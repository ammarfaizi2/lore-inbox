Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbTDNOgn (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTDNOgn (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:36:43 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:20229 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263324AbTDNOgi (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 10:36:38 -0400
Date: Tue, 15 Apr 2003 00:48:17 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Chris Wright <chris@wirex.com>
cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] remove __sk_filter
In-Reply-To: <20030413225458.A20174@figure1.int.wirex.com>
Message-ID: <Mutt.LNX.4.44.0304150047230.4971-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Apr 2003, Chris Wright wrote:

> Now that CONFIG_FILTER was nuked, the __sk_filter helper can be collapsed
> back into sk_filter.  This eliminates bypassing the security hook by
> using the wrong part of the api.

Good thinking, thanks.


- James
-- 
James Morris
<jmorris@intercode.com.au>


Chris' patch below.

===== include/net/sock.h 1.34 vs edited =====
--- 1.34/include/net/sock.h	Sun Mar 30 01:45:41 2003
+++ edited/include/net/sock.h	Sun Apr 13 22:45:21 2003
@@ -453,7 +453,7 @@
 extern void sock_init_data(struct socket *sock, struct sock *sk);
 
 /**
- *	__sk_filter - run a packet through a socket filter
+ *	sk_filter - run a packet through a socket filter
  *	@sk: sock associated with &sk_buff
  *	@skb: buffer to filter
  *	@needlock: set to 1 if the sock is not locked by caller.
@@ -464,14 +464,16 @@
  * wrapper to sk_run_filter. It returns 0 if the packet should
  * be accepted or -EPERM if the packet should be tossed.
  *
- * This function should not be called directly, use sk_filter instead
- * to ensure that the LSM security check is also performed.
  */
 
-static inline int __sk_filter(struct sock *sk, struct sk_buff *skb, int needlock)
+static inline int sk_filter(struct sock *sk, struct sk_buff *skb, int needlock)
 {
-	int err = 0;
-
+	int err;
+	
+	err = security_sock_rcv_skb(sk, skb);
+	if (err)
+		return err;
+	
 	if (sk->filter) {
 		struct sk_filter *filter;
 		
@@ -516,17 +518,6 @@
 {
 	atomic_inc(&fp->refcnt);
 	atomic_add(sk_filter_len(fp), &sk->omem_alloc);
-}
-
-static inline int sk_filter(struct sock *sk, struct sk_buff *skb, int needlock)
-{
-	int err;
-	
-	err = security_sock_rcv_skb(sk, skb);
-	if (err)
-		return err;
-	
-	return __sk_filter(sk, skb, needlock);
 }
 
 /*

