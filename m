Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbUAATKc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 14:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUAATKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 14:10:32 -0500
Received: from mail.actcom.net.il ([192.114.47.15]:29912 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S264565AbUAATJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 14:09:58 -0500
Date: Thu, 1 Jan 2004 21:09:49 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: "Sirotkin, Alexander" <demiurg@ti.com>, linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] skb destructor chaining [was Re: network driver that uses skb destructor]
Message-ID: <20040101190949.GB2358@actcom.co.il>
References: <3FF05C27.5030706@ti.com> <20031229172402.GG13481@actcom.co.il> <1072775631.6557.11.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072775631.6557.11.camel@newt>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 09:13:50AM +0000, Adrian Cox wrote:
> On Mon, 2003-12-29 at 17:24, Muli Ben-Yehuda wrote:
> 
> > I wrote a patch to allow chaining of skb destructors, which was fairly
> > simple and would allow both the driver and the upper layers to set
> > their destructors. If there's any interet, I could probably resurrect
> > it.
> 
> It's interesting to me, for my work with PCI backplane networking, as it
> would eliminate an extra packet copy on receive.

Here's the patch, against 2.6.0. Comments appreciated!

Description: We keep an array of three function pointers for the
destructors, and a counter of registered destructors. When the skb is
destroyted, we call the destructors in reverse order of
registration. 

I went with a fixed number of destructors in order to not have to add
an allocation (and having to deal with the allocation possibly
failing...) to a fast path. If greater flexibility in the number of
descriptors is desired, we can use a pool or a slab cache of
destructors. We can also optimize for  the common case of one
destructor, and as far as I can see, just two is enough for now - one
for the upper layers, one for the driver. 

It's interesting to note how destructor chaining makes the af_unix
code simpler, since it doesn't have to worry about it itself anymore. 

Patch compiles, boots, and scp's large files fine. For testing, I
also added a destructor to e100 and verified that every skb allocated
by it gets its destructor called (not included in the patch).

diff -Naur -X /home/muli/w/dontdiff 2.6.0/include/linux/skbuff.h 2.6.0-skb-dest/include/linux/skbuff.h
--- 2.6.0/include/linux/skbuff.h	Wed Oct  8 19:55:08 2003
+++ 2.6.0-skb-dest/include/linux/skbuff.h	Thu Jan  1 20:22:09 2004
@@ -27,6 +27,7 @@
 #include <linux/highmem.h>
 #include <linux/poll.h>
 #include <linux/net.h>
+#include <asm/hardirq.h> 
 
 #define HAVE_ALLOC_SKB		/* For the drivers to know */
 #define HAVE_ALIGNABLE_SKB	/* Ditto 8)		   */
@@ -147,6 +148,10 @@
 	skb_frag_t	frags[MAX_SKB_FRAGS];
 };
 
+typedef void (*skb_destructor_t) (struct sk_buff* skb); 
+
+#define MAX_NUM_SKB_DESTRUCTORS 3 
+
 /** 
  *	struct sk_buff - socket buffer
  *	@next: Next buffer in list
@@ -177,7 +182,8 @@
  *	@data: Data head pointer
  *	@tail: Tail pointer
  *	@end: End pointer
- *	@destructor: Destruct function
+ *      @numdests: The number of registered destructors
+ *      @destructors: Destructors function array
  *	@nfmark: Can be used for communication between hooks
  *	@nfcache: Cache info
  *	@nfct: Associated connection, if any
@@ -241,7 +247,9 @@
 	unsigned short		protocol,
 				security;
 
-	void			(*destructor)(struct sk_buff *skb);
+	skb_destructor_t        destructors[MAX_NUM_SKB_DESTRUCTORS]; 
+	size_t                  numdests; 
+
 #ifdef CONFIG_NETFILTER
         unsigned long		nfmark;
 	__u32			nfcache;
@@ -995,19 +1003,57 @@
 	return (len < skb->len) ? __pskb_trim(skb, len) : 0;
 }
 
+static inline void skb_init_destructors(struct sk_buff* skb)
+{
+	memset(skb->destructors, 0, sizeof(skb->destructors)); 
+	skb->numdests = 0; 
+}
+
+static inline void skb_call_destructors(struct sk_buff* skb)
+{
+	int in_irq_warn = 1; 
+
+	while (skb->numdests--) { 
+		skb_destructor_t dest; 
+		size_t idx = skb->numdests; 
+
+		if (in_irq() && in_irq_warn) { 
+			printk(KERN_WARNING "Warning: kfree_skb on "
+			       "hard IRQ %p\n", NET_CALLER(skb));
+			in_irq_warn = 0; 
+		}
+
+		dest = skb->destructors[idx]; 
+		BUG_ON(!dest); 
+		dest(skb); 
+
+		skb->destructors[idx] = NULL; 
+	}
+
+	skb->numdests = 0; 
+}
+
+static inline void skb_add_destructor(struct sk_buff* skb, skb_destructor_t dest)
+{
+	size_t idx = skb->numdests++; 
+
+	BUG_ON(idx >= MAX_NUM_SKB_DESTRUCTORS); 
+	BUG_ON(skb->destructors[idx]); /* if it's already set */ 
+
+	skb->destructors[idx] = dest; 
+}
+
 /**
  *	skb_orphan - orphan a buffer
  *	@skb: buffer to orphan
  *
- *	If a buffer currently has an owner then we call the owner's
- *	destructor function and make the @skb unowned. The buffer continues
+ *	If a buffer has any destructors registered, we call them. Then 
+ *      we make the @skb unowned. The buffer continues
  *	to exist but is no longer charged to its former owner.
  */
 static inline void skb_orphan(struct sk_buff *skb)
 {
-	if (skb->destructor)
-		skb->destructor(skb);
-	skb->destructor = NULL;
+	skb_call_destructors(skb); 
 	skb->sk		= NULL;
 }
 
diff -Naur -X /home/muli/w/dontdiff 2.6.0/include/net/sock.h 2.6.0-skb-dest/include/net/sock.h
--- 2.6.0/include/net/sock.h	Tue Nov 25 05:44:51 2003
+++ 2.6.0-skb-dest/include/net/sock.h	Tue Dec 30 16:05:08 2003
@@ -903,14 +903,14 @@
 {
 	sock_hold(sk);
 	skb->sk = sk;
-	skb->destructor = sock_wfree;
+	skb_add_destructor(skb, sock_wfree); 
 	atomic_add(skb->truesize, &sk->sk_wmem_alloc);
 }
 
 static inline void skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 	skb->sk = sk;
-	skb->destructor = sock_rfree;
+	skb_add_destructor(skb, sock_rfree); 
 	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 }
 
diff -Naur -X /home/muli/w/dontdiff 2.6.0/include/net/tcp.h 2.6.0-skb-dest/include/net/tcp.h
--- 2.6.0/include/net/tcp.h	Tue Oct 28 13:11:07 2003
+++ 2.6.0-skb-dest/include/net/tcp.h	Tue Dec 30 16:14:39 2003
@@ -1889,7 +1889,7 @@
 static inline void tcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 	skb->sk = sk;
-	skb->destructor = tcp_rfree;
+	skb_add_destructor(skb, tcp_rfree); 
 	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 	sk->sk_forward_alloc -= skb->truesize;
 }
diff -Naur -X /home/muli/w/dontdiff 2.6.0/net/core/skbuff.c 2.6.0-skb-dest/net/core/skbuff.c
--- 2.6.0/net/core/skbuff.c	Thu Nov  6 22:23:45 2003
+++ 2.6.0-skb-dest/net/core/skbuff.c	Tue Dec 30 16:18:42 2003
@@ -229,12 +229,9 @@
 #ifdef CONFIG_XFRM
 	secpath_put(skb->sp);
 #endif
-	if(skb->destructor) {
-		if (in_irq())
-			printk(KERN_WARNING "Warning: kfree_skb on "
-					    "hard IRQ %p\n", NET_CALLER(skb));
-		skb->destructor(skb);
-	}
+	
+	skb_call_destructors(skb); 
+
 #ifdef CONFIG_NETFILTER
 	nf_conntrack_put(skb->nfct);
 #ifdef CONFIG_BRIDGE_NETFILTER
@@ -293,7 +290,7 @@
 	C(priority);
 	C(protocol);
 	C(security);
-	n->destructor = NULL;
+	skb_init_destructors(n); 
 #ifdef CONFIG_NETFILTER
 	C(nfmark);
 	C(nfcache);
@@ -350,7 +347,7 @@
 	new->local_df	= old->local_df;
 	new->pkt_type	= old->pkt_type;
 	new->stamp	= old->stamp;
-	new->destructor = NULL;
+	skb_init_destructors(new); 
 	new->security	= old->security;
 #ifdef CONFIG_NETFILTER
 	new->nfmark	= old->nfmark;
diff -Naur -X /home/muli/w/dontdiff 2.6.0/net/unix/af_unix.c 2.6.0-skb-dest/net/unix/af_unix.c
--- 2.6.0/net/unix/af_unix.c	Wed Oct  1 09:42:11 2003
+++ 2.6.0-skb-dest/net/unix/af_unix.c	Thu Jan  1 20:10:01 2004
@@ -1142,7 +1142,6 @@
 	int i;
 
 	scm->fp = UNIXCB(skb).fp;
-	skb->destructor = sock_wfree;
 	UNIXCB(skb).fp = NULL;
 
 	for (i=scm->fp->count-1; i>=0; i--)
@@ -1158,7 +1157,6 @@
 	/* Alas, it calls VFS */
 	/* So fscking what? fput() had been SMP-safe since the last Summer */
 	scm_destroy(&scm);
-	sock_wfree(skb);
 }
 
 static void unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
@@ -1167,7 +1165,7 @@
 	for (i=scm->fp->count-1; i>=0; i--)
 		unix_inflight(scm->fp->fp[i]);
 	UNIXCB(skb).fp = scm->fp;
-	skb->destructor = unix_destruct_fds;
+	skb_add_destructor(skb, unix_destruct_fds); 
 	scm->fp = NULL;
 }
 

-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic

