Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVFZQGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVFZQGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 12:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFZQGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 12:06:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12814 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261358AbVFZQFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 12:05:39 -0400
Date: Sun, 26 Jun 2005 18:05:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv4/: possible cleanups
Message-ID: <20050626160536.GH3629@stusta.de>
References: <20050530205651.GY10441@stusta.de> <20050602.131314.21926883.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602.131314.21926883.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 01:13:14PM -0700, David S. Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Subject: [RFC: 2.6 patch] net/ipv4/: possible cleanups
> Date: Mon, 30 May 2005 22:56:51 +0200
> 
> > This patch contains the following possible cleanups:
> > - make needlessly global code static
> > - #if 0 the following unused global function:
> >   - xfrm4_state.c: xfrm4_state_fini
> > - remove the following unneeded EXPORT_SYMBOL's:
> >   - ip_output.c: ip_finish_output
> >   - ip_output.c: sysctl_ip_default_ttl
> >   - fib_frontend.c: ip_dev_find
> >   - inetpeer.c: inet_peer_idlock
> >   - ip_options.c: ip_options_compile
> >   - ip_options.c: ip_options_undo
> >   - tcp_ipv4.c: sysctl_max_syn_backlog
> > 
> > Please review which of these changes are correct and which might 
> > conflict with pending patches.
> 
> Please keep all of the ECN implementation in the
> tcp_ecn.h header file, even if the routine is only
> called in one C file.
> 
> And therefore, please do not remove the tcp_enter_quickack_mode()
> extern declaration from tcp.h

Updated patch below.

> Thanks.

cu
Adrian


<--  snip  -->


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
  - net/core/request_sock.c: sysctl_max_syn_backlog

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/ip.h         |    2 --
 include/net/route.h      |    4 ----
 include/net/xfrm.h       |    1 -
 net/core/request_sock.c  |    1 -
 net/ipv4/fib_frontend.c  |    1 -
 net/ipv4/inetpeer.c      |    2 --
 net/ipv4/ip_options.c    |    3 ---
 net/ipv4/ip_output.c     |    7 +------
 net/ipv4/multipath_drr.c |    2 +-
 net/ipv4/route.c         |    4 +++-
 net/ipv4/xfrm4_state.c   |    2 ++
 11 files changed, 7 insertions(+), 22 deletions(-)

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
--- linux-2.6.12-mm1-full/include/net/route.h.old	2005-06-26 12:54:26.000000000 +0200
+++ linux-2.6.12-mm1-full/include/net/route.h	2005-06-26 12:55:00.000000000 +0200
@@ -105,10 +105,6 @@
         unsigned int out_hlist_search;
 };
 
-extern struct rt_cache_stat *rt_cache_stat;
-#define RT_CACHE_STAT_INC(field)					  \
-		(per_cpu_ptr(rt_cache_stat, raw_smp_processor_id())->field++)
-
 extern struct ip_rt_acct *ip_rt_acct;
 
 struct in_device;
--- linux-2.6.12-mm1-full/net/core/request_sock.c.old	2005-06-26 12:52:03.000000000 +0200
+++ linux-2.6.12-mm1-full/net/core/request_sock.c	2005-06-26 12:52:12.000000000 +0200
@@ -32,7 +32,6 @@
  * Further increasing requires to change hash table size.
  */
 int sysctl_max_syn_backlog = 256;
-EXPORT_SYMBOL(sysctl_max_syn_backlog);
 
 int reqsk_queue_alloc(struct request_sock_queue *queue,
 		      const int nr_table_entries)

