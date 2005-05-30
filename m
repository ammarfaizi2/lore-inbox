Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVE3VRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVE3VRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVE3VOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:14:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28430 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261755AbVE3U4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:56:54 -0400
Date: Mon, 30 May 2005 22:56:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] net/ipv4/: possible cleanups
Message-ID: <20050530205651.GY10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global function:
  - xfrm4_state.c: xfrm4_state_fini
- remove the following unneeded EXPORT_SYMBOL's:
  - ip_output.c: ip_finish_output
  - ip_output.c: sysctl_ip_default_ttl
  - fib_frontend.c: ip_dev_find
  - inetpeer.c: inet_peer_idlock
  - ip_options.c: ip_options_compile
  - ip_options.c: ip_options_undo
  - tcp_ipv4.c: sysctl_max_syn_backlog

Please review which of these changes are correct and which might 
conflict with pending patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 7 May 2005

 include/net/ip.h         |    2 --
 include/net/route.h      |    4 ----
 include/net/tcp.h        |    2 --
 include/net/tcp_ecn.h    |   13 -------------
 include/net/xfrm.h       |    1 -
 net/ipv4/fib_frontend.c  |    1 -
 net/ipv4/inetpeer.c      |    2 --
 net/ipv4/ip_options.c    |    3 ---
 net/ipv4/ip_output.c     |    7 +------
 net/ipv4/multipath_drr.c |    2 +-
 net/ipv4/route.c         |    4 +++-
 net/ipv4/tcp_input.c     |   15 ++++++++++++++-
 net/ipv4/tcp_ipv4.c      |    1 -
 net/ipv4/xfrm4_state.c   |    2 ++
 14 files changed, 21 insertions(+), 38 deletions(-)

--- linux-2.6.12-rc3-mm2-full/include/net/ip.h.old	2005-05-05 02:35:00.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/include/net/ip.h	2005-05-05 02:35:07.000000000 +0200
@@ -140,8 +140,6 @@
 void ip_send_reply(struct sock *sk, struct sk_buff *skb, struct ip_reply_arg *arg,
 		   unsigned int len); 
 
-extern int ip_finish_output(struct sk_buff *skb);
-
 struct ipv4_config
 {
 	int	log_martians;
--- linux-2.6.12-rc3-mm2-full/net/ipv4/multipath_drr.c.old	2005-05-05 02:37:58.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/ipv4/multipath_drr.c	2005-05-05 02:38:06.000000000 +0200
@@ -107,7 +107,7 @@
 	return NOTIFY_DONE;
 }
 
-struct notifier_block drr_dev_notifier = {
+static struct notifier_block drr_dev_notifier = {
 	.notifier_call	= drr_dev_event,
 };
 
--- linux-2.6.12-rc3-mm3-full/net/ipv4/ip_output.c.old	2005-05-05 21:43:22.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv4/ip_output.c	2005-05-05 21:44:36.000000000 +0200
@@ -216,7 +216,7 @@
 	return -EINVAL;
 }
 
-int ip_finish_output(struct sk_buff *skb)
+static int ip_finish_output(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dst->dev;
 
@@ -1351,12 +1351,7 @@
 #endif
 }
 
-EXPORT_SYMBOL(ip_finish_output);
 EXPORT_SYMBOL(ip_fragment);
 EXPORT_SYMBOL(ip_generic_getfrag);
 EXPORT_SYMBOL(ip_queue_xmit);
 EXPORT_SYMBOL(ip_send_check);
-
-#ifdef CONFIG_SYSCTL
-EXPORT_SYMBOL(sysctl_ip_default_ttl);
-#endif
--- linux-2.6.12-rc3-mm3-full/include/net/route.h.old	2005-05-05 21:21:09.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/include/net/route.h	2005-05-05 21:22:19.000000000 +0200
@@ -105,10 +105,6 @@
         unsigned int out_hlist_search;
 };
 
-extern struct rt_cache_stat *rt_cache_stat;
-#define RT_CACHE_STAT_INC(field)					  \
-		(per_cpu_ptr(rt_cache_stat, _smp_processor_id())->field++)
-
 extern struct ip_rt_acct *ip_rt_acct;
 
 struct in_device;
--- linux-2.6.12-rc3-mm3-full/net/ipv4/route.c.old	2005-05-05 21:21:21.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv4/route.c	2005-05-05 21:22:14.000000000 +0200
@@ -209,7 +209,9 @@
 static int			rt_hash_log;
 static unsigned int		rt_hash_rnd;
 
-struct rt_cache_stat *rt_cache_stat;
+static struct rt_cache_stat *rt_cache_stat;
+#define RT_CACHE_STAT_INC(field)					  \
+		(per_cpu_ptr(rt_cache_stat, _smp_processor_id())->field++)
 
 static int rt_intern_hash(unsigned hash, struct rtable *rth,
 				struct rtable **res);
--- linux-2.6.12-rc3-mm3-full/include/net/tcp.h.old	2005-05-05 21:23:42.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/include/net/tcp.h	2005-05-05 21:23:52.000000000 +0200
@@ -825,8 +825,6 @@
 	}
 }
 
-extern void tcp_enter_quickack_mode(struct tcp_sock *tp);
-
 static __inline__ void tcp_delack_init(struct tcp_sock *tp)
 {
 	memset(&tp->ack, 0, sizeof(tp->ack));
--- linux-2.6.12-rc3-mm3-full/include/net/tcp_ecn.h.old	2005-05-05 21:25:48.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/include/net/tcp_ecn.h	2005-05-05 21:25:57.000000000 +0200
@@ -78,19 +78,6 @@
 	tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
 }
 
-static inline void TCP_ECN_check_ce(struct tcp_sock *tp, struct sk_buff *skb)
-{
-	if (tp->ecn_flags&TCP_ECN_OK) {
-		if (INET_ECN_is_ce(TCP_SKB_CB(skb)->flags))
-			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
-		/* Funny extension: if ECT is not set on a segment,
-		 * it is surely retransmit. It is not in ECN RFC,
-		 * but Linux follows this rule. */
-		else if (INET_ECN_is_not_ect((TCP_SKB_CB(skb)->flags)))
-			tcp_enter_quickack_mode(tp);
-	}
-}
-
 static inline void TCP_ECN_rcv_synack(struct tcp_sock *tp, struct tcphdr *th)
 {
 	if ((tp->ecn_flags&TCP_ECN_OK) && (!th->ece || th->cwr))
--- linux-2.6.12-rc3-mm3-full/net/ipv4/tcp_input.c.old	2005-05-05 21:24:11.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv4/tcp_input.c	2005-05-05 21:25:04.000000000 +0200
@@ -183,13 +183,26 @@
 		tp->ack.quick = min(quickacks, TCP_MAX_QUICKACKS);
 }
 
-void tcp_enter_quickack_mode(struct tcp_sock *tp)
+static void tcp_enter_quickack_mode(struct tcp_sock *tp)
 {
 	tcp_incr_quickack(tp);
 	tp->ack.pingpong = 0;
 	tp->ack.ato = TCP_ATO_MIN;
 }
 
+static inline void TCP_ECN_check_ce(struct tcp_sock *tp, struct sk_buff *skb)
+{
+	if (tp->ecn_flags&TCP_ECN_OK) {
+		if (INET_ECN_is_ce(TCP_SKB_CB(skb)->flags))
+			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
+		/* Funny extension: if ECT is not set on a segment,
+		 * it is surely retransmit. It is not in ECN RFC,
+		 * but Linux follows this rule. */
+		else if (INET_ECN_is_not_ect((TCP_SKB_CB(skb)->flags)))
+			tcp_enter_quickack_mode(tp);
+	}
+}
+
 /* Send ACKs quickly, if "quick" count is not exhausted
  * and the session is not interactive.
  */
--- linux-2.6.12-rc3-mm3-full/include/net/xfrm.h.old	2005-05-05 21:26:56.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/include/net/xfrm.h	2005-05-05 21:27:01.000000000 +0200
@@ -799,7 +799,6 @@
 extern void xfrm6_fini(void);
 extern void xfrm_state_init(void);
 extern void xfrm4_state_init(void);
-extern void xfrm4_state_fini(void);
 extern void xfrm6_state_init(void);
 extern void xfrm6_state_fini(void);
 
--- linux-2.6.12-rc3-mm3-full/net/ipv4/xfrm4_state.c.old	2005-05-05 21:27:09.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv4/xfrm4_state.c	2005-05-05 21:27:24.000000000 +0200
@@ -119,8 +119,10 @@
 	xfrm_state_register_afinfo(&xfrm4_state_afinfo);
 }
 
+#if 0
 void __exit xfrm4_state_fini(void)
 {
 	xfrm_state_unregister_afinfo(&xfrm4_state_afinfo);
 }
+#endif  /*  0  */
 
--- linux-2.6.12-rc3-mm3-full/net/ipv4/fib_frontend.c.old	2005-05-05 21:38:28.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv4/fib_frontend.c	2005-05-05 21:38:40.000000000 +0200
@@ -607,5 +607,4 @@
 }
 
 EXPORT_SYMBOL(inet_addr_type);
-EXPORT_SYMBOL(ip_dev_find);
 EXPORT_SYMBOL(ip_rt_ioctl);
--- linux-2.6.12-rc3-mm3-full/net/ipv4/inetpeer.c.old	2005-05-05 21:41:06.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv4/inetpeer.c	2005-05-05 21:41:14.000000000 +0200
@@ -456,5 +456,3 @@
 			peer_total / inet_peer_threshold * HZ;
 	add_timer(&peer_periodic_timer);
 }
-
-EXPORT_SYMBOL(inet_peer_idlock);
--- linux-2.6.12-rc3-mm3-full/net/ipv4/ip_options.c.old	2005-05-05 21:42:02.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv4/ip_options.c	2005-05-05 21:42:33.000000000 +0200
@@ -620,6 +620,3 @@
 	}
 	return 0;
 }
-
-EXPORT_SYMBOL(ip_options_compile);
-EXPORT_SYMBOL(ip_options_undo);
--- linux-2.6.12-rc3-mm3-full/net/ipv4/tcp_ipv4.c.old	2005-05-05 21:58:55.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv4/tcp_ipv4.c	2005-05-05 21:59:33.000000000 +0200
@@ -2660,7 +2660,6 @@
 EXPORT_SYMBOL(tcp_proc_unregister);
 #endif
 EXPORT_SYMBOL(sysctl_local_port_range);
-EXPORT_SYMBOL(sysctl_max_syn_backlog);
 EXPORT_SYMBOL(sysctl_tcp_low_latency);
 EXPORT_SYMBOL(sysctl_tcp_tw_reuse);
 

