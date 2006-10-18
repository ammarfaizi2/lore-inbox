Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423169AbWJRXj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423169AbWJRXj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423160AbWJRXj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:39:27 -0400
Received: from [63.64.152.142] ([63.64.152.142]:54286 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1423151AbWJRXjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:39:06 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 7/7] I/OAT: Only offload copies for TCP when there will be a context switch
Date: Wed, 18 Oct 2006 16:47:01 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org
Message-Id: <20061018234701.26671.31879.stgit@gitlost.site>
In-Reply-To: <20061018234417.26671.56773.stgit@gitlost.site>
References: <20061018234417.26671.56773.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The performance wins come with having the DMA copy engine doing the copies
in parallel with the context switch.  If there is enough data ready on the
socket at recv time just use a regular copy.

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 net/ipv4/tcp.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 66e9a72..ef0a6cd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1108,6 +1108,8 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 	long timeo;
 	struct task_struct *user_recv = NULL;
 	int copied_early = 0;
+	int available = 0;
+	struct sk_buff *skb;
 
 	lock_sock(sk);
 
@@ -1134,7 +1136,11 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 #ifdef CONFIG_NET_DMA
 	tp->ucopy.dma_chan = NULL;
 	preempt_disable();
-	if ((len > sysctl_tcp_dma_copybreak) && !(flags & MSG_PEEK) &&
+	skb = skb_peek_tail(&sk->sk_receive_queue);
+	if (skb)
+		available = TCP_SKB_CB(skb)->seq + skb->len - (*seq);
+	if ((available < target) &&
+	    (len > sysctl_tcp_dma_copybreak) && !(flags & MSG_PEEK) &&
 	    !sysctl_tcp_low_latency && __get_cpu_var(softnet_data).net_dma) {
 		preempt_enable_no_resched();
 		tp->ucopy.pinned_list = dma_pin_iovec_pages(msg->msg_iov, len);
@@ -1143,7 +1149,6 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 #endif
 
 	do {
-		struct sk_buff *skb;
 		u32 offset;
 
 		/* Are we at urgent data? Stop if we have read anything or have SIGURG pending. */
@@ -1431,7 +1436,6 @@ skip_copy:
 
 #ifdef CONFIG_NET_DMA
 	if (tp->ucopy.dma_chan) {
-		struct sk_buff *skb;
 		dma_cookie_t done, used;
 
 		dma_async_memcpy_issue_pending(tp->ucopy.dma_chan);

