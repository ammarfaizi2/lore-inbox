Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311415AbSCMWaP>; Wed, 13 Mar 2002 17:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311418AbSCMWaG>; Wed, 13 Mar 2002 17:30:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20363 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311415AbSCMW3y>;
	Wed, 13 Mar 2002 17:29:54 -0500
Date: Wed, 13 Mar 2002 14:27:25 -0800 (PST)
Message-Id: <20020313.142725.17865874.davem@redhat.com>
To: sim@netnation.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre8 Oops: tcp_v4_get_port
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020313165018.GA17171@netnation.com>
In-Reply-To: <20020313165018.GA17171@netnation.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It might be cured by this fix.

--- ../../vanilla/2.4/linux/net/ipv4/tcp_minisocks.c	Mon Oct  1 09:19:57 2001
+++ net/ipv4/tcp_minisocks.c	Mon Mar  4 23:48:09 2002
@@ -5,7 +5,7 @@
  *
  *		Implementation of the Transmission Control Protocol(TCP).
  *
- * Version:	$Id: tcp_minisocks.c,v 1.14 2001/09/21 21:27:34 davem Exp $
+ * Version:	$Id: tcp_minisocks.c,v 1.14.2.1 2002/03/05 04:30:08 davem Exp $
  *
  * Authors:	Ross Biro, <bir7@leland.Stanford.Edu>
  *		Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
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
 
@@ -304,9 +303,23 @@
 	struct tcp_bind_hashbucket *bhead;
 	struct sock **head, *sktw;
 
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
@@ -315,7 +328,7 @@
 		sock_prot_dec_use(sk->prot);
 	}
 
-	/* Step 2: Hash TW into TIMEWAIT half of established hash table. */
+	/* Step 3: Hash TW into TIMEWAIT half of established hash table. */
 	head = &(ehead + tcp_ehash_size)->chain;
 	sktw = (struct sock *)tw;
 	if((sktw->next = *head) != NULL)
@@ -325,20 +338,6 @@
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
