Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVBLDzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVBLDzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVBLDzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:55:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:37545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262390AbVBLDzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:55:22 -0500
Date: Fri, 11 Feb 2005 19:55:20 -0800
From: Chris Wright <chrisw@osdl.org>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused netlink NL_EMULATE_DEV code
Message-ID: <20050211195520.T24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NL_EMULATE_DEV handler functions can't ever be set, so let's rip them
out too.  I realize the other half (netlink_attach()) just came out in
2.6.11-rc1, but what's left behind can't be used at all.

Signed-off-by: Chris Wright <chrisw@osdl.org>

 af_netlink.c |   24 +-----------------------
 1 files changed, 1 insertion(+), 23 deletions(-)

===== net/netlink/af_netlink.c 1.69 vs edited =====
--- 1.69/net/netlink/af_netlink.c	2005-01-21 12:25:32 -08:00
+++ edited/net/netlink/af_netlink.c	2005-02-11 19:47:08 -08:00
@@ -55,10 +55,6 @@
 
 #define Nprintk(a...)
 
-#if defined(CONFIG_NETLINK_DEV) || defined(CONFIG_NETLINK_DEV_MODULE)
-#define NL_EMULATE_DEV
-#endif
-
 struct netlink_opt
 {
 	u32			pid;
@@ -66,7 +62,6 @@ struct netlink_opt
 	u32			dst_pid;
 	unsigned int		dst_groups;
 	unsigned long		state;
-	int			(*handler)(int unit, struct sk_buff *skb);
 	wait_queue_head_t	wait;
 	struct netlink_callback	*cb;
 	spinlock_t		cb_lock;
@@ -596,10 +591,6 @@ int netlink_attachskb(struct sock *sk, s
 
 	nlk = nlk_sk(sk);
 
-#ifdef NL_EMULATE_DEV
-	if (nlk->handler)
-		return 0;
-#endif
 	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
 	    test_bit(0, &nlk->state)) {
 		DECLARE_WAITQUEUE(wait, current);
@@ -639,14 +630,6 @@ int netlink_sendskb(struct sock *sk, str
 	int len = skb->len;
 
 	nlk = nlk_sk(sk);
-#ifdef NL_EMULATE_DEV
-	if (nlk->handler) {
-		skb_orphan(skb);
-		len = nlk->handler(protocol, skb);
-		sock_put(sk);
-		return len;
-	}
-#endif
 
 	skb_queue_tail(&sk->sk_receive_queue, skb);
 	sk->sk_data_ready(sk, len);
@@ -711,12 +694,7 @@ retry:
 static __inline__ int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlink_opt *nlk = nlk_sk(sk);
-#ifdef NL_EMULATE_DEV
-	if (nlk->handler) {
-		nlk->handler(sk->sk_protocol, skb);
-		return 0;
-	} else
-#endif
+
 	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
 	    !test_bit(0, &nlk->state)) {
 		skb_set_owner_r(skb, sk);
