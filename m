Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWHPAp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWHPAp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWHPAp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:45:56 -0400
Received: from [63.64.152.142] ([63.64.152.142]:33289 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1750756AbWHPApz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:45:55 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 3/7] [I/OAT] Don't offload copies for loopback traffic
Date: Tue, 15 Aug 2006 17:53:41 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060816005341.8634.10380.stgit@gitlost.site>
In-Reply-To: <20060816005337.8634.70033.stgit@gitlost.site>
References: <20060816005337.8634.70033.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Local traffic (loopback) is generally in cache anyway, and the overhead
cost of offloading the copy is worse than just doing it with the CPU.

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 net/ipv4/tcp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 36f6b64..7971e73 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1107,6 +1107,7 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 	int copied_early = 0;
 	int available = 0;
 	struct sk_buff *skb;
+	struct dst_entry *dst;
 
 	lock_sock(sk);
 
@@ -1136,7 +1137,8 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 	skb = skb_peek_tail(&sk->sk_receive_queue);
 	if (skb)
 		available = TCP_SKB_CB(skb)->seq + skb->len - (*seq);
-	if ((available < target) &&
+	dst = __sk_dst_get(sk);
+	if ((available < target) && (!dst || (dst->dev != &loopback_dev)) &&
 	    (len > sysctl_tcp_dma_copybreak) && !(flags & MSG_PEEK) &&
 	    !sysctl_tcp_low_latency && __get_cpu_var(softnet_data).net_dma) {
 		preempt_enable_no_resched();

