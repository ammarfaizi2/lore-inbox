Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293071AbSCEAy5>; Mon, 4 Mar 2002 19:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293095AbSCEAyt>; Mon, 4 Mar 2002 19:54:49 -0500
Received: from web12302.mail.yahoo.com ([216.136.173.100]:12864 "HELO
	web12302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293071AbSCEAyk>; Mon, 4 Mar 2002 19:54:40 -0500
Message-ID: <20020305005439.87673.qmail@web12302.mail.yahoo.com>
Date: Mon, 4 Mar 2002 16:54:39 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: Re: memory corruption in tcp bind hash buckets on SMP?
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20020304.152646.123971801.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1st patch: reverses the insertion order in __tcp_tw_hashdance(). This is what
we tested

2nd patch: removes conditional around tw->tb in tcp_timewait_kill(). I have
only made sure it compiles. "tw-tb == NULL;" is not strictly required.. but
esures oops if we end up in similar race again.

patch 1:
--------

--- linux-2.4.7-10/net/ipv4/tcp_minisocks.c	Thu Sep  6 13:11:49 2001
+++ linux-2.4.7-10-mod/net/ipv4/tcp_minisocks.c	Fri Mar  1 15:41:26 2002
@@ -304,9 +304,25 @@
 	struct tcp_bind_hashbucket *bhead;
 	struct sock **head, *sktw;
 
+
+	/* Step 1: Put TW into bind hash. Original socket stays there too.
+	   Note, that any socket with sk->num!=0 MUST be bound in binding
+	   cache, even if it is closed.
+	 */
+	bhead = &tcp_bhash[tcp_bhashfn(sk->num)];
+	spin_lock(&bhead->lock);
+	tw->tb = (struct tcp_bind_bucket *)sk->prev;
+	BUG_TRAP(sk->prev!=NULL);
+	if ((tw->bind_next = tw->tb->owners) != NULL)
+		tw->tb->owners->bind_pprev = &tw->bind_next;
+	tw->tb->owners = (struct sock*)tw;
+	tw->bind_pprev = &tw->tb->owners;
+	spin_unlock(&bhead->lock);
+
 	write_lock(&ehead->lock);
 
-	/* Step 1: Remove SK from established hash. */
+	/* Step 2: Remove SK from established hash. */
 	if (sk->pprev) {
 		if(sk->next)
 			sk->next->pprev = sk->pprev;
@@ -315,7 +331,7 @@
 		sock_prot_dec_use(sk->prot);
 	}
 
-	/* Step 2: Hash TW into TIMEWAIT half of established hash table. */
+	/* Step 3: Hash TW into TIMEWAIT half of established hash table. */
 	head = &(ehead + tcp_ehash_size)->chain;
 	sktw = (struct sock *)tw;
 	if((sktw->next = *head) != NULL)
@@ -325,20 +341,6 @@
 	atomic_inc(&tw->refcnt);
 
 	write_unlock(&ehead->lock);
-
-	/* Step 3: Put TW into bind hash. Original socket stays there too.
-	   Note, that any socket with sk->num!=0 MUST be bound in binding
-	   cache, even if it is closed.
-	 */
-	bhead = &tcp_bhash[tcp_bhashfn(sk->num)];
-	spin_lock(&bhead->lock);
-	tw->tb = (struct tcp_bind_bucket *)sk->prev;
-	BUG_TRAP(sk->prev!=NULL);
-	if ((tw->bind_next = tw->tb->owners) != NULL)
-		tw->tb->owners->bind_pprev = &tw->bind_next;
-	tw->tb->owners = (struct sock*)tw;
-	tw->bind_pprev = &tw->tb->owners;
-	spin_unlock(&bhead->lock);
 }
 
 /* 


patch 2:
--------

--- linux-2.4.7-10/net/ipv4/tcp_minisocks.c	Thu Sep  6 13:11:49 2001
+++ linux-2.4.7-10-mod/net/ipv4/tcp_minisocks.c	Mon Mar  4 16:41:35 2002
@@ -75,17 +75,16 @@
 	/* Disassociate with bind bucket. */
 	bhead = &tcp_bhash[tcp_bhashfn(tw->num)];
 	spin_lock(&bhead->lock);
-	if ((tb = tw->tb) != NULL) {
-		if(tw->bind_next)
-			tw->bind_next->bind_pprev = tw->bind_pprev;
-		*(tw->bind_pprev) = tw->bind_next;
-		tw->tb = NULL;
-		if (tb->owners == NULL) {
-			if (tb->next)
-				tb->next->pprev = tb->pprev;
-			*(tb->pprev) = tb->next;
-			kmem_cache_free(tcp_bucket_cachep, tb);
-		}
+	tb = tw->tb;
+	if(tw->bind_next)
+		tw->bind_next->bind_pprev = tw->bind_pprev;
+	*(tw->bind_pprev) = tw->bind_next;
+	tw->tb = NULL;
+	if (tb->owners == NULL) {
+		if (tb->next)
+			tb->next->pprev = tb->pprev;
+		*(tb->pprev) = tb->next;
+		kmem_cache_free(tcp_bucket_cachep, tb);
 	}
 	spin_unlock(&bhead->lock);


--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Raghu Angadi <raghuangadi@yahoo.com>
>    Date: Mon, 4 Mar 2002 12:48:32 -0800 (PST)
> 
>    We have been load testing the kernel with this patch (reverse the
> insertion
>    order in __tcp_tw_hashdance(). It seems to work fine till now.
> 
> Where was "this patch" posted?  I never saw anyone post
> any code, all anyone did was merely describe the change :)


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - sign up for Fantasy Baseball
http://sports.yahoo.com
