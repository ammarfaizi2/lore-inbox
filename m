Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbULOA4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbULOA4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbULOAz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:55:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1549 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261795AbULOAvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:51:46 -0500
Date: Wed, 15 Dec 2004 01:51:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv4/: misc possible cleanups
Message-ID: <20041215005139.GJ23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make some needlessly global code static
- remove the following unused global functions:
  - fib_rules.c: fib_rules_map_destination
  - xfrm4_policy.: xfrm4_fini
- remove the following unneeded EXPORT_SYMBOL:
  - tcp_timer.c: tcp_timer_bug_msg

Please review which of these changes are correct and which might 
conflict with pending patches.


diffstat output:
 include/net/ip.h         |    2 --
 include/net/ip_fib.h     |    2 --
 include/net/ipconfig.h   |   11 -----------
 include/net/tcp.h        |   16 ----------------
 include/net/xfrm.h       |    1 -
 net/ipv4/af_inet.c       |    8 ++++----
 net/ipv4/arp.c           |    8 ++++----
 net/ipv4/devinet.c       |    4 ++--
 net/ipv4/fib_frontend.c  |    6 +++---
 net/ipv4/fib_rules.c     |    8 +-------
 net/ipv4/icmp.c          |    4 ++--
 net/ipv4/igmp.c          |   16 ++++++++--------
 net/ipv4/ip_gre.c        |    6 +++---
 net/ipv4/ip_sockglue.c   |    2 +-
 net/ipv4/ipconfig.c      |   12 ++++++------
 net/ipv4/raw.c           |    4 ++--
 net/ipv4/route.c         |   32 ++++++++++++++++----------------
 net/ipv4/tcp_input.c     |   16 ++++++++++++++--
 net/ipv4/tcp_minisocks.c |    4 +++-
 net/ipv4/tcp_timer.c     |    3 ---
 net/ipv4/udp.c           |   13 ++++++++-----
 net/ipv4/xfrm4_policy.c  |    7 -------
 22 files changed, 77 insertions(+), 108 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/net/ip.h.old	2004-12-14 05:20:46.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/ip.h	2004-12-14 05:20:53.000000000 +0100
@@ -295,8 +295,6 @@
 extern void	ip_local_error(struct sock *sk, int err, u32 daddr, u16 dport,
 			       u32 info);
 
-extern int ipv4_proc_init(void);
-
 /* sysctl helpers - any sysctl which holds a value that ends up being
  * fed into the routing cache should use these handlers.
  */
--- linux-2.6.10-rc3-mm1-full/net/ipv4/af_inet.c.old	2004-12-14 05:20:00.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/af_inet.c	2004-12-14 05:20:33.000000000 +0100
@@ -659,7 +659,7 @@
 }
 
 
-ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset, size_t size, int flags)
+static ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset, size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 
@@ -1011,7 +1011,7 @@
 	return 0;
 }
 
-int ipv4_proc_init(void);
+static int ipv4_proc_init(void);
 extern void ipfrag_init(void);
 
 static int __init inet_init(void)
@@ -1136,7 +1136,7 @@
 extern int  udp4_proc_init(void);
 extern void udp4_proc_exit(void);
 
-int __init ipv4_proc_init(void)
+static int __init ipv4_proc_init(void)
 {
 	int rc = 0;
 
@@ -1166,7 +1166,7 @@
 }
 
 #else /* CONFIG_PROC_FS */
-int __init ipv4_proc_init(void)
+static int __init ipv4_proc_init(void)
 {
 	return 0;
 }
--- linux-2.6.10-rc3-mm1-full/net/ipv4/arp.c.old	2004-12-14 05:21:08.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/arp.c	2004-12-14 05:21:53.000000000 +0100
@@ -704,7 +704,7 @@
  *	Process an arp request.
  */
 
-int arp_process(struct sk_buff *skb)
+static int arp_process(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
 	struct in_device *in_dev = in_dev_get(dev);
@@ -961,7 +961,7 @@
  *	Set (create) an ARP cache entry.
  */
 
-int arp_req_set(struct arpreq *r, struct net_device * dev)
+static int arp_req_set(struct arpreq *r, struct net_device * dev)
 {
 	u32 ip = ((struct sockaddr_in *) &r->arp_pa)->sin_addr.s_addr;
 	struct neighbour *neigh;
@@ -1075,7 +1075,7 @@
 	return err;
 }
 
-int arp_req_delete(struct arpreq *r, struct net_device * dev)
+static int arp_req_delete(struct arpreq *r, struct net_device * dev)
 {
 	int err;
 	u32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
@@ -1207,7 +1207,7 @@
 	return NOTIFY_DONE;
 }
 
-struct notifier_block arp_netdev_notifier = {
+static struct notifier_block arp_netdev_notifier = {
 	.notifier_call = arp_netdev_event,
 };
 
--- linux-2.6.10-rc3-mm1-full/net/ipv4/devinet.c.old	2004-12-14 05:22:07.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/devinet.c	2004-12-14 05:22:26.000000000 +0100
@@ -380,7 +380,7 @@
 	return NULL;
 }
 
-int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg)
+static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg)
 {
 	struct rtattr **rta = arg;
 	struct in_device *in_dev;
@@ -412,7 +412,7 @@
 	return -EADDRNOTAVAIL;
 }
 
-int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg)
+static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg)
 {
 	struct rtattr **rta = arg;
 	struct net_device *dev;
--- linux-2.6.10-rc3-mm1-full/include/net/ip_fib.h.old	2004-12-14 05:22:51.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/ip_fib.h	2004-12-14 05:23:53.000000000 +0100
@@ -200,7 +200,6 @@
 
 /* Exported by fib_frontend.c */
 extern void		ip_fib_init(void);
-extern void		fib_flush(void);
 extern int inet_rtm_delroute(struct sk_buff *skb, struct nlmsghdr* nlh, void *arg);
 extern int inet_rtm_newroute(struct sk_buff *skb, struct nlmsghdr* nlh, void *arg);
 extern int inet_rtm_getroute(struct sk_buff *skb, struct nlmsghdr* nlh, void *arg);
@@ -226,7 +225,6 @@
 extern int inet_rtm_delrule(struct sk_buff *skb, struct nlmsghdr* nlh, void *arg);
 extern int inet_rtm_newrule(struct sk_buff *skb, struct nlmsghdr* nlh, void *arg);
 extern int inet_dump_rules(struct sk_buff *skb, struct netlink_callback *cb);
-extern u32 fib_rules_map_destination(u32 daddr, struct fib_result *res);
 #ifdef CONFIG_NET_CLS_ROUTE
 extern u32 fib_rules_tclass(struct fib_result *res);
 #endif
--- linux-2.6.10-rc3-mm1-full/net/ipv4/fib_frontend.c.old	2004-12-14 05:23:09.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/fib_frontend.c	2004-12-14 05:23:33.000000000 +0100
@@ -75,7 +75,7 @@
 #endif /* CONFIG_IP_MULTIPLE_TABLES */
 
 
-void fib_flush(void)
+static void fib_flush(void)
 {
 	int flushed = 0;
 #ifdef CONFIG_IP_MULTIPLE_TABLES
@@ -585,11 +585,11 @@
 	return NOTIFY_DONE;
 }
 
-struct notifier_block fib_inetaddr_notifier = {
+static struct notifier_block fib_inetaddr_notifier = {
 	.notifier_call =fib_inetaddr_event,
 };
 
-struct notifier_block fib_netdev_notifier = {
+static struct notifier_block fib_netdev_notifier = {
 	.notifier_call =fib_netdev_event,
 };
 
--- linux-2.6.10-rc3-mm1-full/net/ipv4/fib_rules.c.old	2004-12-14 05:24:04.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/fib_rules.c	2004-12-14 05:24:22.000000000 +0100
@@ -245,12 +245,6 @@
 	return 0;
 }
 
-u32 fib_rules_map_destination(u32 daddr, struct fib_result *res)
-{
-	u32 mask = inet_make_mask(res->prefixlen);
-	return (daddr&~mask)|res->fi->fib_nh->nh_gw;
-}
-
 #ifdef CONFIG_NET_CLS_ROUTE
 u32 fib_rules_tclass(struct fib_result *res)
 {
@@ -368,7 +362,7 @@
 }
 
 
-struct notifier_block fib_rules_notifier = {
+static struct notifier_block fib_rules_notifier = {
 	.notifier_call =fib_rules_event,
 };
 
--- linux-2.6.10-rc3-mm1-full/net/ipv4/icmp.c.old	2004-12-14 05:24:38.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/icmp.c	2004-12-14 05:25:02.000000000 +0100
@@ -327,8 +327,8 @@
  *	Checksum each fragment, and on the first include the headers and final
  *	checksum.
  */
-int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
-		   struct sk_buff *skb)
+static int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
+			  struct sk_buff *skb)
 {
 	struct icmp_bxm *icmp_param = (struct icmp_bxm *)from;
 	unsigned int csum;
--- linux-2.6.10-rc3-mm1-full/net/ipv4/igmp.c.old	2004-12-14 05:25:26.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/igmp.c	2004-12-14 05:26:44.000000000 +0100
@@ -143,8 +143,8 @@
 static void sf_markstate(struct ip_mc_list *pmc);
 #endif
 static void ip_mc_clear_src(struct ip_mc_list *pmc);
-int ip_mc_add_src(struct in_device *in_dev, __u32 *pmca, int sfmode,
-	int sfcount, __u32 *psfsrc, int delta);
+static int ip_mc_add_src(struct in_device *in_dev, __u32 *pmca, int sfmode,
+			 int sfcount, __u32 *psfsrc, int delta);
 
 static void ip_ma_put(struct ip_mc_list *im)
 {
@@ -1384,8 +1384,8 @@
 #define igmp_ifc_event(x)	do { } while (0)
 #endif
 
-int ip_mc_del_src(struct in_device *in_dev, __u32 *pmca, int sfmode,
-	int sfcount, __u32 *psfsrc, int delta)
+static int ip_mc_del_src(struct in_device *in_dev, __u32 *pmca, int sfmode,
+			 int sfcount, __u32 *psfsrc, int delta)
 {
 	struct ip_mc_list *pmc;
 	int	changerec = 0;
@@ -1520,8 +1520,8 @@
 /*
  * Add multicast source filter list to the interface list
  */
-int ip_mc_add_src(struct in_device *in_dev, __u32 *pmca, int sfmode,
-	int sfcount, __u32 *psfsrc, int delta)
+static int ip_mc_add_src(struct in_device *in_dev, __u32 *pmca, int sfmode,
+			 int sfcount, __u32 *psfsrc, int delta)
 {
 	struct ip_mc_list *pmc;
 	int	isexclude;
@@ -1667,8 +1667,8 @@
 	return err;
 }
 
-int ip_mc_leave_src(struct sock *sk, struct ip_mc_socklist *iml,
-	struct in_device *in_dev)
+static int ip_mc_leave_src(struct sock *sk, struct ip_mc_socklist *iml,
+			   struct in_device *in_dev)
 {
 	int err;
 
--- linux-2.6.10-rc3-mm1-full/net/ipv4/ip_gre.c.old	2004-12-14 05:29:23.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/ip_gre.c	2004-12-14 05:29:54.000000000 +0100
@@ -304,7 +304,7 @@
 }
 
 
-void ipgre_err(struct sk_buff *skb, u32 info)
+static void ipgre_err(struct sk_buff *skb, u32 info)
 {
 #ifndef I_WISH_WORLD_WERE_PERFECT
 
@@ -552,7 +552,7 @@
 	return INET_ECN_encapsulate(tos, inner);
 }
 
-int ipgre_rcv(struct sk_buff *skb)
+static int ipgre_rcv(struct sk_buff *skb)
 {
 	struct iphdr *iph;
 	u8     *h;
@@ -1279,7 +1279,7 @@
 	goto out;
 }
 
-void ipgre_fini(void)
+static void ipgre_fini(void)
 {
 	if (inet_del_protocol(&ipgre_protocol, IPPROTO_GRE) < 0)
 		printk(KERN_INFO "ipgre close: can't remove protocol\n");
--- linux-2.6.10-rc3-mm1-full/net/ipv4/ip_sockglue.c.old	2004-12-14 05:30:10.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/ip_sockglue.c	2004-12-14 05:30:17.000000000 +0100
@@ -92,7 +92,7 @@
 }
 
 
-void ip_cmsg_recv_retopts(struct msghdr *msg, struct sk_buff *skb)
+static void ip_cmsg_recv_retopts(struct msghdr *msg, struct sk_buff *skb)
 {
 	unsigned char optbuf[sizeof(struct ip_options) + 40];
 	struct ip_options * opt = (struct ip_options*)optbuf;
--- linux-2.6.10-rc3-mm1-full/include/net/ipconfig.h.old	2004-12-14 05:30:42.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/ipconfig.h	2004-12-14 05:35:02.000000000 +0100
@@ -8,14 +8,10 @@
 
 /* The following are initdata: */
 
-extern int ic_enable;		/* Enable or disable the whole shebang */
-
 extern int ic_proto_enabled;	/* Protocols enabled (see IC_xxx) */
-extern int ic_host_name_set;	/* Host name set by ipconfig? */
 extern int ic_set_manually;	/* IPconfig parameters set manually */
 
 extern u32 ic_myaddr;		/* My IP address */
-extern u32 ic_netmask;		/* Netmask for local subnet */
 extern u32 ic_gateway;		/* Gateway IP address */
 
 extern u32 ic_servaddr;		/* Boot server IP address */
@@ -24,13 +20,6 @@
 extern u8 root_server_path[];	/* Path to mount as root */
 
 
-
-/* The following are persistent (not initdata): */
-
-extern int ic_proto_used;	/* Protocol used, if any */
-extern u32 ic_nameserver;	/* DNS server IP address */
-extern u8 ic_domain[];		/* DNS (not NIS) domain name */
-
 /* bits in ic_proto_{enabled,used} */
 #define IC_PROTO	0xFF	/* Protocols mask: */
 #define IC_BOOTP	0x01	/*   BOOTP (or DHCP, see below) */
--- linux-2.6.10-rc3-mm1-full/net/ipv4/ipconfig.c.old	2004-12-14 05:30:57.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/ipconfig.c	2004-12-14 05:35:10.000000000 +0100
@@ -109,7 +109,7 @@
  */
 int ic_set_manually __initdata = 0;		/* IPconfig parameters set manually */
 
-int ic_enable __initdata = 0;			/* IP config enabled? */
+static int ic_enable __initdata = 0;		/* IP config enabled? */
 
 /* Protocol choice */
 int ic_proto_enabled __initdata = 0
@@ -124,10 +124,10 @@
 #endif
 			;
 
-int ic_host_name_set __initdata = 0;		/* Host name set by us? */
+static int ic_host_name_set __initdata = 0;	/* Host name set by us? */
 
 u32 ic_myaddr = INADDR_NONE;		/* My IP address */
-u32 ic_netmask = INADDR_NONE;	/* Netmask for local subnet */
+static u32 ic_netmask = INADDR_NONE;	/* Netmask for local subnet */
 u32 ic_gateway = INADDR_NONE;	/* Gateway IP address */
 
 u32 ic_servaddr = INADDR_NONE;	/* Boot server IP address */
@@ -137,9 +137,9 @@
 
 /* Persistent data: */
 
-int ic_proto_used;			/* Protocol used, if any */
-u32 ic_nameservers[CONF_NAMESERVERS_MAX]; /* DNS Server IP addresses */
-u8 ic_domain[64];		/* DNS (not NIS) domain name */
+static int ic_proto_used;			/* Protocol used, if any */
+static u32 ic_nameservers[CONF_NAMESERVERS_MAX]; /* DNS Server IP addresses */
+static u8 ic_domain[64];		/* DNS (not NIS) domain name */
 
 /*
  * Private state.
--- linux-2.6.10-rc3-mm1-full/net/ipv4/raw.c.old	2004-12-14 05:36:04.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/raw.c	2004-12-14 05:36:22.000000000 +0100
@@ -562,8 +562,8 @@
  *	we return it, otherwise we block.
  */
 
-int raw_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		size_t len, int noblock, int flags, int *addr_len)
+static int raw_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
+		       size_t len, int noblock, int flags, int *addr_len)
 {
 	struct inet_opt *inet = inet_sk(sk);
 	size_t copied = 0;
--- linux-2.6.10-rc3-mm1-full/net/ipv4/route.c.old	2004-12-14 05:36:47.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/route.c	2004-12-14 05:59:55.000000000 +0100
@@ -108,22 +108,22 @@
 
 #define RT_GC_TIMEOUT (300*HZ)
 
-int ip_rt_min_delay		= 2 * HZ;
-int ip_rt_max_delay		= 10 * HZ;
-int ip_rt_max_size;
-int ip_rt_gc_timeout		= RT_GC_TIMEOUT;
-int ip_rt_gc_interval		= 60 * HZ;
-int ip_rt_gc_min_interval	= HZ / 2;
-int ip_rt_redirect_number	= 9;
-int ip_rt_redirect_load		= HZ / 50;
-int ip_rt_redirect_silence	= ((HZ / 50) << (9 + 1));
-int ip_rt_error_cost		= HZ;
-int ip_rt_error_burst		= 5 * HZ;
-int ip_rt_gc_elasticity		= 8;
-int ip_rt_mtu_expires		= 10 * 60 * HZ;
-int ip_rt_min_pmtu		= 512 + 20 + 20;
-int ip_rt_min_advmss		= 256;
-int ip_rt_secret_interval	= 10 * 60 * HZ;
+static int ip_rt_min_delay		= 2 * HZ;
+static int ip_rt_max_delay		= 10 * HZ;
+static int ip_rt_max_size;
+static int ip_rt_gc_timeout		= RT_GC_TIMEOUT;
+static int ip_rt_gc_interval		= 60 * HZ;
+static int ip_rt_gc_min_interval	= HZ / 2;
+static int ip_rt_redirect_number	= 9;
+static int ip_rt_redirect_load		= HZ / 50;
+static int ip_rt_redirect_silence	= ((HZ / 50) << (9 + 1));
+static int ip_rt_error_cost		= HZ;
+static int ip_rt_error_burst		= 5 * HZ;
+static int ip_rt_gc_elasticity		= 8;
+static int ip_rt_mtu_expires		= 10 * 60 * HZ;
+static int ip_rt_min_pmtu		= 512 + 20 + 20;
+static int ip_rt_min_advmss		= 256;
+static int ip_rt_secret_interval	= 10 * 60 * HZ;
 static unsigned long rt_deadline;
 
 #define RTprint(a...)	printk(KERN_DEBUG a)
--- linux-2.6.10-rc3-mm1-full/include/net/tcp.h.old	2004-12-14 05:43:25.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/tcp.h	2004-12-14 05:45:41.000000000 +0100
@@ -315,7 +315,6 @@
 extern atomic_t tcp_orphan_count;
 extern int tcp_tw_count;
 extern void tcp_time_wait(struct sock *sk, int state, int timeo);
-extern void tcp_tw_schedule(struct tcp_tw_bucket *tw, int timeo);
 extern void tcp_tw_deschedule(struct tcp_tw_bucket *tw);
 
 
@@ -2020,21 +2019,6 @@
                 tp->westwood.rtt = rtt_seq;
 }
 
-void __tcp_westwood_fast_bw(struct sock *, struct sk_buff *);
-void __tcp_westwood_slow_bw(struct sock *, struct sk_buff *);
-
-static inline void tcp_westwood_fast_bw(struct sock *sk, struct sk_buff *skb)
-{
-        if (tcp_is_westwood(tcp_sk(sk)))
-                __tcp_westwood_fast_bw(sk, skb);
-}
-
-static inline void tcp_westwood_slow_bw(struct sock *sk, struct sk_buff *skb)
-{
-        if (tcp_is_westwood(tcp_sk(sk)))
-                __tcp_westwood_slow_bw(sk, skb);
-}
-
 static inline __u32 __tcp_westwood_bw_rttmin(const struct tcp_opt *tp)
 {
         return max((tp->westwood.bw_est) * (tp->westwood.rtt_min) /
--- linux-2.6.10-rc3-mm1-full/net/ipv4/tcp_input.c.old	2004-12-14 05:43:43.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/tcp_input.c	2004-12-14 05:44:53.000000000 +0100
@@ -2786,7 +2786,7 @@
  * straight forward and doesn't need any particular care.
  */
 
-void __tcp_westwood_fast_bw(struct sock *sk, struct sk_buff *skb)
+static void __tcp_westwood_fast_bw(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_opt *tp = tcp_sk(sk);
 
@@ -2797,6 +2797,12 @@
 	tp->westwood.rtt_min = westwood_update_rttmin(sk);
 }
 
+static inline void tcp_westwood_fast_bw(struct sock *sk, struct sk_buff *skb)
+{
+        if (tcp_is_westwood(tcp_sk(sk)))
+                __tcp_westwood_fast_bw(sk, skb);
+}
+
 
 /*
  * @westwood_dupack_update
@@ -2867,7 +2873,7 @@
  * dupack. But we need to be careful in such case.
  */
 
-void __tcp_westwood_slow_bw(struct sock *sk, struct sk_buff *skb)
+static void __tcp_westwood_slow_bw(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_opt *tp = tcp_sk(sk);
 
@@ -2877,6 +2883,12 @@
 	tp->westwood.rtt_min = westwood_update_rttmin(sk);
 }
 
+static inline void tcp_westwood_slow_bw(struct sock *sk, struct sk_buff *skb)
+{
+        if (tcp_is_westwood(tcp_sk(sk)))
+                __tcp_westwood_slow_bw(sk, skb);
+}
+
 /* This routine deals with incoming acks, but not outgoing ones. */
 static int tcp_ack(struct sock *sk, struct sk_buff *skb, int flag)
 {
--- linux-2.6.10-rc3-mm1-full/net/ipv4/tcp_minisocks.c.old	2004-12-14 05:45:57.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/tcp_minisocks.c	2004-12-14 05:46:17.000000000 +0100
@@ -41,6 +41,8 @@
 int sysctl_tcp_syncookies = SYNC_INIT; 
 int sysctl_tcp_abort_on_overflow;
 
+static void tcp_tw_schedule(struct tcp_tw_bucket *tw, int timeo);
+
 static __inline__ int tcp_in_window(u32 seq, u32 end_seq, u32 s_win, u32 e_win)
 {
 	if (seq == s_win)
@@ -551,7 +553,7 @@
 		TIMER_INITIALIZER(tcp_twcal_tick, 0, 0);
 static struct hlist_head tcp_twcal_row[TCP_TW_RECYCLE_SLOTS];
 
-void tcp_tw_schedule(struct tcp_tw_bucket *tw, int timeo)
+static void tcp_tw_schedule(struct tcp_tw_bucket *tw, int timeo)
 {
 	struct hlist_head *list;
 	int slot;
--- linux-2.6.10-rc3-mm1-full/net/ipv4/tcp_timer.c.old	2004-12-14 05:48:10.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/tcp_timer.c	2004-12-14 13:57:40.000000000 +0100
@@ -653,6 +653,3 @@
 EXPORT_SYMBOL(tcp_delete_keepalive_timer);
 EXPORT_SYMBOL(tcp_init_xmit_timers);
 EXPORT_SYMBOL(tcp_reset_keepalive_timer);
-#ifdef TCP_DEBUG
-EXPORT_SYMBOL(tcp_timer_bug_msg);
-#endif
--- linux-2.6.10-rc3-mm1-full/net/ipv4/udp.c.old	2004-12-14 05:50:04.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/udp.c	2004-12-14 05:51:36.000000000 +0100
@@ -219,7 +219,8 @@
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
  * harder than this. -DaveM
  */
-struct sock *udp_v4_lookup_longway(u32 saddr, u16 sport, u32 daddr, u16 dport, int dif)
+static struct sock *udp_v4_lookup_longway(u32 saddr, u16 sport,
+					  u32 daddr, u16 dport, int dif)
 {
 	struct sock *sk, *result = NULL;
 	struct hlist_node *node;
@@ -263,7 +264,8 @@
 	return result;
 }
 
-__inline__ struct sock *udp_v4_lookup(u32 saddr, u16 sport, u32 daddr, u16 dport, int dif)
+static __inline__ struct sock *udp_v4_lookup(u32 saddr, u16 sport,
+					     u32 daddr, u16 dport, int dif)
 {
 	struct sock *sk;
 
@@ -667,7 +669,8 @@
 	goto out;
 }
 
-int udp_sendpage(struct sock *sk, struct page *page, int offset, size_t size, int flags)
+static int udp_sendpage(struct sock *sk, struct page *page, int offset,
+			size_t size, int flags)
 {
 	struct udp_opt *up = udp_sk(sk);
 	int ret;
@@ -770,8 +773,8 @@
  * 	return it, otherwise we block.
  */
 
-int udp_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		size_t len, int noblock, int flags, int *addr_len)
+static int udp_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
+		       size_t len, int noblock, int flags, int *addr_len)
 {
 	struct inet_opt *inet = inet_sk(sk);
   	struct sockaddr_in *sin = (struct sockaddr_in *)msg->msg_name;
--- linux-2.6.10-rc3-mm1-full/include/net/xfrm.h.old	2004-12-14 05:51:56.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/xfrm.h	2004-12-14 05:52:03.000000000 +0100
@@ -782,7 +782,6 @@
 
 extern void xfrm_init(void);
 extern void xfrm4_init(void);
-extern void xfrm4_fini(void);
 extern void xfrm6_init(void);
 extern void xfrm6_fini(void);
 extern void xfrm_state_init(void);
--- linux-2.6.10-rc3-mm1-full/net/ipv4/xfrm4_policy.c.old	2004-12-14 05:52:13.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/xfrm4_policy.c	2004-12-14 05:52:22.000000000 +0100
@@ -279,10 +279,3 @@
 	xfrm4_policy_init();
 }
 
-void __exit xfrm4_fini(void)
-{
-	//xfrm4_input_fini();
-	xfrm4_policy_fini();
-	xfrm4_state_fini();
-}
-

