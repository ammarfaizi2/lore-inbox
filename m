Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbULOBdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbULOBdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbULOBdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:33:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21006 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261729AbULOBTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:19:39 -0500
Date: Wed, 15 Dec 2004 02:19:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: coreteam@netfilter.org
Cc: netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv4/netfilter/: misc possible cleanups
Message-ID: <20041215011931.GD12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make some needlessly global code static
- remove the following unused global functions:
  - ip_conntrack_core.c: ip_conntrack_expect_find_get
  - ip_conntrack_core.c: ip_conntrack_unexpect_related
  - ip_nat_standalone.c: ip_nat_protocol_register
  - ip_nat_standalone.c: ip_nat_protocol_unregister
  - ip_nat_helper.c: ip_nat_find_helper
  - ipfwadm_core.c: ip_acct_ctl
- remove the following variables that never change their values:
  - ip_conntrack_ftp.c: ip_conntrack_ftp
  - ip_conntrack_irc.c: ip_conntrack_irc
- remove the following unneeded EXPORT_SYMBOL's:
  - ip_conntrack_standalone.c: ip_ct_find_helper
  - ip_conntrack_standalone.c: ip_conntrack_unexpect_related
  - ip_conntrack_standalone.c: ip_conntrack_expect_list
  - ip_conntrack_standalone.c: ip_conntrack_put
  - ip_nat_standalone.c: ip_nat_protocol_register
  - ip_nat_standalone.c: ip_nat_protocol_unregister
  - ip_nat_standalone.c: ip_nat_find_helper
- remove the following unneeded EXPORT_SYMBOL_GPL:
  - ip_conntrack_standalone.c: ip_conntrack_expect_find_get

Please comment on which of these changes are correct and which conflict
with pending patches.


diffstat output:
 include/linux/netfilter_ipv4/ip_conntrack.h        |    7 
 include/linux/netfilter_ipv4/ip_conntrack_helper.h |    4 
 include/linux/netfilter_ipv4/ip_nat_core.h         |    4 
 include/linux/netfilter_ipv4/ip_nat_helper.h       |    3 
 include/linux/netfilter_ipv4/ip_nat_protocol.h     |    4 
 include/linux/netfilter_ipv4/ipfwadm_core.h        |    9 -
 net/ipv4/netfilter/ip_conntrack_core.c             |   28 ---
 net/ipv4/netfilter/ip_conntrack_ftp.c              |    3 
 net/ipv4/netfilter/ip_conntrack_irc.c              |    8 
 net/ipv4/netfilter/ip_conntrack_proto_sctp.c       |   20 +-
 net/ipv4/netfilter/ip_conntrack_standalone.c       |    5 
 net/ipv4/netfilter/ip_nat_core.c                   |   94 +++++------
 net/ipv4/netfilter/ip_nat_helper.c                 |   14 -
 net/ipv4/netfilter/ip_nat_standalone.c             |   30 ---
 net/ipv4/netfilter/ipchains_core.c                 |   22 +-
 net/ipv4/netfilter/ipfwadm_core.c                  |  108 +++----------
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |    2 
 net/ipv4/netfilter/ipt_ULOG.c                      |    4 
 net/ipv4/netfilter/ipt_hashlimit.c                 |    2 
 net/ipv4/netfilter/ipt_recent.c                    |    2 
 20 files changed, 111 insertions(+), 262 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_conntrack.h.old	2004-12-14 03:53:07.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_conntrack.h	2004-12-14 03:55:53.000000000 +0100
@@ -244,13 +244,6 @@
 	return (struct ip_conntrack *)skb->nfct;
 }
 
-/* decrement reference count on a conntrack */
-extern inline void ip_conntrack_put(struct ip_conntrack *ct);
-
-/* find unconfirmed expectation based on tuple */
-struct ip_conntrack_expect *
-ip_conntrack_expect_find_get(const struct ip_conntrack_tuple *tuple);
-
 /* decrement reference count on an expectation */
 void ip_conntrack_expect_put(struct ip_conntrack_expect *exp);
 
--- linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_conntrack_helper.h.old	2004-12-14 03:56:52.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_conntrack_helper.h	2004-12-14 03:57:33.000000000 +0100
@@ -33,9 +33,6 @@
 extern int ip_conntrack_helper_register(struct ip_conntrack_helper *);
 extern void ip_conntrack_helper_unregister(struct ip_conntrack_helper *);
 
-extern struct ip_conntrack_helper *ip_ct_find_helper(const struct ip_conntrack_tuple *tuple);
-
-
 /* Allocate space for an expectation: this is mandatory before calling 
    ip_conntrack_expect_related. */
 extern struct ip_conntrack_expect *ip_conntrack_expect_alloc(void);
@@ -44,6 +41,5 @@
 				       struct ip_conntrack *related_to);
 extern int ip_conntrack_change_expect(struct ip_conntrack_expect *expect,
 				      struct ip_conntrack_tuple *newtuple);
-extern void ip_conntrack_unexpect_related(struct ip_conntrack_expect *exp);
 
 #endif /*_IP_CONNTRACK_HELPER_H*/
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_standalone.c.old	2004-12-14 03:53:25.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_standalone.c	2004-12-14 03:57:37.000000000 +0100
@@ -892,22 +892,17 @@
 EXPORT_SYMBOL(ip_ct_refresh_acct);
 EXPORT_SYMBOL(ip_ct_protos);
 EXPORT_SYMBOL(ip_ct_find_proto);
-EXPORT_SYMBOL(ip_ct_find_helper);
 EXPORT_SYMBOL(ip_conntrack_expect_alloc);
 EXPORT_SYMBOL(ip_conntrack_expect_related);
 EXPORT_SYMBOL(ip_conntrack_change_expect);
-EXPORT_SYMBOL(ip_conntrack_unexpect_related);
-EXPORT_SYMBOL_GPL(ip_conntrack_expect_find_get);
 EXPORT_SYMBOL_GPL(ip_conntrack_expect_put);
 EXPORT_SYMBOL(ip_conntrack_tuple_taken);
 EXPORT_SYMBOL(ip_ct_gather_frags);
 EXPORT_SYMBOL(ip_conntrack_htable_size);
-EXPORT_SYMBOL(ip_conntrack_expect_list);
 EXPORT_SYMBOL(ip_conntrack_lock);
 EXPORT_SYMBOL(ip_conntrack_hash);
 EXPORT_SYMBOL(ip_conntrack_untracked);
 EXPORT_SYMBOL_GPL(ip_conntrack_find_get);
-EXPORT_SYMBOL_GPL(ip_conntrack_put);
 #ifdef CONFIG_IP_NF_NAT_NEEDED
 EXPORT_SYMBOL(ip_conntrack_tcp_update);
 #endif
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_core.c.old	2004-12-14 03:53:36.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_core.c	2004-12-14 03:57:45.000000000 +0100
@@ -77,7 +77,7 @@
 
 DEFINE_PER_CPU(struct ip_conntrack_stat, ip_conntrack_stat);
 
-inline void 
+static inline void 
 ip_conntrack_put(struct ip_conntrack *ct)
 {
 	IP_NF_ASSERT(ct);
@@ -173,23 +173,6 @@
 			 struct ip_conntrack_expect *, tuple);
 }
 
-/* Find a expectation corresponding to a tuple. */
-struct ip_conntrack_expect *
-ip_conntrack_expect_find_get(const struct ip_conntrack_tuple *tuple)
-{
-	struct ip_conntrack_expect *exp;
-
-	READ_LOCK(&ip_conntrack_lock);
-	READ_LOCK(&ip_conntrack_expect_tuple_lock);
-	exp = __ip_ct_expect_find(tuple);
-	if (exp)
-		atomic_inc(&exp->use);
-	READ_UNLOCK(&ip_conntrack_expect_tuple_lock);
-	READ_UNLOCK(&ip_conntrack_lock);
-
-	return exp;
-}
-
 /* remove one specific expectation from all lists and drop refcount,
  * does _NOT_ delete the timer. */
 static void __unexpect_related(struct ip_conntrack_expect *expect)
@@ -497,7 +480,7 @@
 	return ip_ct_tuple_mask_cmp(rtuple, &i->tuple, &i->mask);
 }
 
-struct ip_conntrack_helper *ip_ct_find_helper(const struct ip_conntrack_tuple *tuple)
+static struct ip_conntrack_helper *ip_ct_find_helper(const struct ip_conntrack_tuple *tuple)
 {
 	return LIST_FIND(&helpers, helper_cmp,
 			 struct ip_conntrack_helper *,
@@ -812,13 +795,6 @@
 	return ip_ct_tuple_mask_cmp(&i->tuple, tuple, &intersect_mask);
 }
 
-inline void ip_conntrack_unexpect_related(struct ip_conntrack_expect *expect)
-{
-	WRITE_LOCK(&ip_conntrack_lock);
-	unexpect_related(expect);
-	WRITE_UNLOCK(&ip_conntrack_lock);
-}
-	
 static void expectation_timed_out(unsigned long ul_expect)
 {
 	struct ip_conntrack_expect *expect = (void *) ul_expect;
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_ftp.c.old	2004-12-14 03:58:12.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_ftp.c	2004-12-14 03:58:47.000000000 +0100
@@ -29,7 +29,6 @@
 static char ftp_buffer[65536];
 
 static DECLARE_LOCK(ip_ftp_lock);
-struct module *ip_conntrack_ftp = THIS_MODULE;
 
 #define MAX_PORTS 8
 static int ports[MAX_PORTS];
@@ -438,7 +437,7 @@
 		ftp[i].max_expected = 1;
 		ftp[i].timeout = 0;
 		ftp[i].flags = IP_CT_HELPER_F_REUSE_EXPECT;
-		ftp[i].me = ip_conntrack_ftp;
+		ftp[i].me = THIS_MODULE;
 		ftp[i].help = help;
 
 		tmpname = &ftp_names[i][0];
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_irc.c.old	2004-12-14 03:59:08.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_irc.c	2004-12-14 04:00:11.000000000 +0100
@@ -56,8 +56,6 @@
 static char *dccprotos[] = { "SEND ", "CHAT ", "MOVE ", "TSEND ", "SCHAT " };
 #define MINMATCHLEN	5
 
-struct module *ip_conntrack_irc = THIS_MODULE;
-
 #if 0
 #define DEBUGP(format, args...) printk(KERN_DEBUG "%s:%s:" format, \
                                        __FILE__, __FUNCTION__ , ## args)
@@ -65,8 +63,8 @@
 #define DEBUGP(format, args...)
 #endif
 
-int parse_dcc(char *data, char *data_end, u_int32_t * ip, u_int16_t * port,
-	      char **ad_beg_p, char **ad_end_p)
+static int parse_dcc(char *data, char *data_end, u_int32_t * ip,
+		     u_int16_t * port, char **ad_beg_p, char **ad_end_p)
 /* tries to get the ip_addr and port out of a dcc command
    return value: -1 on failure, 0 on success 
 	data		pointer to first byte of DCC command data
@@ -269,7 +267,7 @@
 		hlpr->max_expected = max_dcc_channels;
 		hlpr->timeout = dcc_timeout;
 		hlpr->flags = IP_CT_HELPER_F_REUSE_EXPECT;
-		hlpr->me = ip_conntrack_irc;
+		hlpr->me = THIS_MODULE;
 		hlpr->help = help;
 
 		tmpname = &irc_names[i][0];
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_sctp.c.old	2004-12-14 04:00:28.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_conntrack_proto_sctp.c	2004-12-14 04:01:47.000000000 +0100
@@ -58,13 +58,13 @@
 #define HOURS * 60 MINS
 #define DAYS  * 24 HOURS
 
-unsigned long ip_ct_sctp_timeout_closed            =  10 SECS;
-unsigned long ip_ct_sctp_timeout_cookie_wait       =   3 SECS;
-unsigned long ip_ct_sctp_timeout_cookie_echoed     =   3 SECS;
-unsigned long ip_ct_sctp_timeout_established       =   5 DAYS;
-unsigned long ip_ct_sctp_timeout_shutdown_sent     = 300 SECS / 1000;
-unsigned long ip_ct_sctp_timeout_shutdown_recd     = 300 SECS / 1000;
-unsigned long ip_ct_sctp_timeout_shutdown_ack_sent =   3 SECS;
+static unsigned long ip_ct_sctp_timeout_closed            =  10 SECS;
+static unsigned long ip_ct_sctp_timeout_cookie_wait       =   3 SECS;
+static unsigned long ip_ct_sctp_timeout_cookie_echoed     =   3 SECS;
+static unsigned long ip_ct_sctp_timeout_established       =   5 DAYS;
+static unsigned long ip_ct_sctp_timeout_shutdown_sent     = 300 SECS / 1000;
+static unsigned long ip_ct_sctp_timeout_shutdown_recd     = 300 SECS / 1000;
+static unsigned long ip_ct_sctp_timeout_shutdown_ack_sent =   3 SECS;
 
 static unsigned long * sctp_timeouts[]
 = { NULL,                                  /* SCTP_CONNTRACK_NONE  */
@@ -501,7 +501,7 @@
 	return 0;
 }
 
-struct ip_conntrack_protocol ip_conntrack_protocol_sctp = { 
+static struct ip_conntrack_protocol ip_conntrack_protocol_sctp = { 
 	.proto 		 = IPPROTO_SCTP, 
 	.name 		 = "sctp",
 	.pkt_to_tuple 	 = sctp_pkt_to_tuple, 
@@ -609,7 +609,7 @@
 static struct ctl_table_header *ip_ct_sysctl_header;
 #endif
 
-int __init init(void)
+static int __init init(void)
 {
 	int ret;
 
@@ -639,7 +639,7 @@
 	return ret;
 }
 
-void __exit fini(void)
+static void __exit fini(void)
 {
 	ip_conntrack_protocol_unregister(&ip_conntrack_protocol_sctp);
 #ifdef CONFIG_SYSCTL
--- linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_nat_core.h.old	2004-12-14 04:04:27.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_nat_core.h	2004-12-14 04:04:36.000000000 +0100
@@ -19,9 +19,5 @@
 				  unsigned int hooknum,
 				  int dir);
 
-extern void replace_in_hashes(struct ip_conntrack *conntrack,
-			      struct ip_nat_info *info);
-extern void place_in_hashes(struct ip_conntrack *conntrack,
-			    struct ip_nat_info *info);
 
 #endif /* _IP_NAT_CORE_H */
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_nat_core.c.old	2004-12-14 04:04:43.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_nat_core.c	2004-12-14 04:05:37.000000000 +0100
@@ -479,6 +479,53 @@
 #endif
 };
 
+static void replace_in_hashes(struct ip_conntrack *conntrack,
+			      struct ip_nat_info *info)
+{
+	/* Source has changed, so replace in hashes. */
+	unsigned int srchash
+		= hash_by_src(&conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
+			      .tuple.src,
+			      conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
+			      .tuple.dst.protonum);
+	/* We place packet as seen OUTGOUNG in byips_proto hash
+           (ie. reverse dst and src of reply packet. */
+	unsigned int ipsprotohash
+		= hash_by_ipsproto(conntrack->tuplehash[IP_CT_DIR_REPLY]
+				   .tuple.dst.ip,
+				   conntrack->tuplehash[IP_CT_DIR_REPLY]
+				   .tuple.src.ip,
+				   conntrack->tuplehash[IP_CT_DIR_REPLY]
+				   .tuple.dst.protonum);
+
+	MUST_BE_WRITE_LOCKED(&ip_nat_lock);
+	list_move(&info->bysource, &bysource[srchash]);
+	list_move(&info->byipsproto, &byipsproto[ipsprotohash]);
+}
+
+static void place_in_hashes(struct ip_conntrack *conntrack,
+			    struct ip_nat_info *info)
+{
+	unsigned int srchash
+		= hash_by_src(&conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
+			      .tuple.src,
+			      conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
+			      .tuple.dst.protonum);
+	/* We place packet as seen OUTGOUNG in byips_proto hash
+           (ie. reverse dst and src of reply packet. */
+	unsigned int ipsprotohash
+		= hash_by_ipsproto(conntrack->tuplehash[IP_CT_DIR_REPLY]
+				   .tuple.dst.ip,
+				   conntrack->tuplehash[IP_CT_DIR_REPLY]
+				   .tuple.src.ip,
+				   conntrack->tuplehash[IP_CT_DIR_REPLY]
+				   .tuple.dst.protonum);
+
+	MUST_BE_WRITE_LOCKED(&ip_nat_lock);
+	list_add(&info->bysource, &bysource[srchash]);
+	list_add(&info->byipsproto, &byipsproto[ipsprotohash]);
+}
+
 unsigned int
 ip_nat_setup_info(struct ip_conntrack *conntrack,
 		  const struct ip_nat_multi_range *mr,
@@ -620,53 +667,6 @@
 	return NF_ACCEPT;
 }
 
-void replace_in_hashes(struct ip_conntrack *conntrack,
-		       struct ip_nat_info *info)
-{
-	/* Source has changed, so replace in hashes. */
-	unsigned int srchash
-		= hash_by_src(&conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
-			      .tuple.src,
-			      conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
-			      .tuple.dst.protonum);
-	/* We place packet as seen OUTGOUNG in byips_proto hash
-           (ie. reverse dst and src of reply packet. */
-	unsigned int ipsprotohash
-		= hash_by_ipsproto(conntrack->tuplehash[IP_CT_DIR_REPLY]
-				   .tuple.dst.ip,
-				   conntrack->tuplehash[IP_CT_DIR_REPLY]
-				   .tuple.src.ip,
-				   conntrack->tuplehash[IP_CT_DIR_REPLY]
-				   .tuple.dst.protonum);
-
-	MUST_BE_WRITE_LOCKED(&ip_nat_lock);
-	list_move(&info->bysource, &bysource[srchash]);
-	list_move(&info->byipsproto, &byipsproto[ipsprotohash]);
-}
-
-void place_in_hashes(struct ip_conntrack *conntrack,
-		     struct ip_nat_info *info)
-{
-	unsigned int srchash
-		= hash_by_src(&conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
-			      .tuple.src,
-			      conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
-			      .tuple.dst.protonum);
-	/* We place packet as seen OUTGOUNG in byips_proto hash
-           (ie. reverse dst and src of reply packet. */
-	unsigned int ipsprotohash
-		= hash_by_ipsproto(conntrack->tuplehash[IP_CT_DIR_REPLY]
-				   .tuple.dst.ip,
-				   conntrack->tuplehash[IP_CT_DIR_REPLY]
-				   .tuple.src.ip,
-				   conntrack->tuplehash[IP_CT_DIR_REPLY]
-				   .tuple.dst.protonum);
-
-	MUST_BE_WRITE_LOCKED(&ip_nat_lock);
-	list_add(&info->bysource, &bysource[srchash]);
-	list_add(&info->byipsproto, &byipsproto[ipsprotohash]);
-}
-
 /* Returns true if succeeded. */
 static int
 manip_pkt(u_int16_t proto,
--- linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_nat_helper.h.old	2004-12-14 04:05:58.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_nat_helper.h	2004-12-14 04:06:08.000000000 +0100
@@ -42,9 +42,6 @@
 extern void ip_nat_helper_unregister(struct ip_nat_helper *me);
 
 extern struct ip_nat_helper *
-ip_nat_find_helper(const struct ip_conntrack_tuple *tuple);
-
-extern struct ip_nat_helper *
 __ip_nat_find_helper(const struct ip_conntrack_tuple *tuple);
 
 /* These return true or false. */
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_nat_standalone.c.old	2004-12-14 04:06:19.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_nat_standalone.c	2004-12-14 04:08:05.000000000 +0100
@@ -279,33 +279,6 @@
 };
 #endif
 
-/* Protocol registration. */
-int ip_nat_protocol_register(struct ip_nat_protocol *proto)
-{
-	int ret = 0;
-
-	WRITE_LOCK(&ip_nat_lock);
-	if (ip_nat_protos[proto->protonum] != &ip_nat_unknown_protocol) {
-		ret = -EBUSY;
-		goto out;
-	}
-	ip_nat_protos[proto->protonum] = proto;
- out:
-	WRITE_UNLOCK(&ip_nat_lock);
-	return ret;
-}
-
-/* Noone stores the protocol anywhere; simply delete it. */
-void ip_nat_protocol_unregister(struct ip_nat_protocol *proto)
-{
-	WRITE_LOCK(&ip_nat_lock);
-	ip_nat_protos[proto->protonum] = &ip_nat_unknown_protocol;
-	WRITE_UNLOCK(&ip_nat_lock);
-
-	/* Someone could be still looking at the proto in a bh. */
-	synchronize_net();
-}
-
 static int init_or_cleanup(int init)
 {
 	int ret = 0;
@@ -381,14 +354,11 @@
 module_exit(fini);
 
 EXPORT_SYMBOL(ip_nat_setup_info);
-EXPORT_SYMBOL(ip_nat_protocol_register);
-EXPORT_SYMBOL(ip_nat_protocol_unregister);
 EXPORT_SYMBOL(ip_nat_helper_register);
 EXPORT_SYMBOL(ip_nat_helper_unregister);
 EXPORT_SYMBOL(ip_nat_cheat_check);
 EXPORT_SYMBOL(ip_nat_mangle_tcp_packet);
 EXPORT_SYMBOL(ip_nat_mangle_udp_packet);
 EXPORT_SYMBOL(ip_nat_used_tuple);
-EXPORT_SYMBOL(ip_nat_find_helper);
 EXPORT_SYMBOL(__ip_nat_find_helper);
 MODULE_LICENSE("GPL");
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_nat_helper.c.old	2004-12-14 04:06:33.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ip_nat_helper.c	2004-12-14 04:07:06.000000000 +0100
@@ -48,7 +48,7 @@
 #endif
 
 static LIST_HEAD(helpers);
-DECLARE_LOCK(ip_nat_seqofs_lock);
+static DECLARE_LOCK(ip_nat_seqofs_lock);
 
 /* Setup TCP sequence correction given this change at this sequence */
 static inline void 
@@ -431,18 +431,6 @@
 	return LIST_FIND(&helpers, helper_cmp, struct ip_nat_helper *, tuple);
 }
 
-struct ip_nat_helper *
-ip_nat_find_helper(const struct ip_conntrack_tuple *tuple)
-{
-	struct ip_nat_helper *h;
-
-	READ_LOCK(&ip_nat_lock);
-	h = __ip_nat_find_helper(tuple);
-	READ_UNLOCK(&ip_nat_lock);
-
-	return h;
-}
-
 static int
 kill_helper(const struct ip_conntrack *i, void *helper)
 {
--- linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_nat_protocol.h.old	2004-12-14 04:07:23.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ip_nat_protocol.h	2004-12-14 04:07:42.000000000 +0100
@@ -48,10 +48,6 @@
 #define MAX_IP_NAT_PROTO 256
 extern struct ip_nat_protocol *ip_nat_protos[MAX_IP_NAT_PROTO];
 
-/* Protocol registration. */
-extern int ip_nat_protocol_register(struct ip_nat_protocol *proto);
-extern void ip_nat_protocol_unregister(struct ip_nat_protocol *proto);
-
 static inline struct ip_nat_protocol *ip_nat_find_proto(u_int8_t protocol)
 {
 	return ip_nat_protos[protocol];
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipchains_core.c.old	2004-12-14 04:08:35.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipchains_core.c	2004-12-14 04:10:24.000000000 +0100
@@ -266,7 +266,7 @@
 #endif
 
 /* Lock around ip_fw_chains linked list structure */
-rwlock_t ip_fw_lock = RW_LOCK_UNLOCKED;
+static rwlock_t ip_fw_lock = RW_LOCK_UNLOCKED;
 
 /* Head of linked list of fw rules */
 static struct ip_chain *ip_fw_chains;
@@ -1758,17 +1758,17 @@
 /*
  *	Interface to the generic firewall chains.
  */
-int ipfw_input_check(struct firewall_ops *this, int pf,
-		     struct net_device *dev, void *arg,
-		     struct sk_buff **pskb)
+static int ipfw_input_check(struct firewall_ops *this, int pf,
+			    struct net_device *dev, void *arg,
+			    struct sk_buff **pskb)
 {
 	return ip_fw_check(dev->name,
 			   arg, IP_FW_INPUT_CHAIN, pskb, SLOT_NUMBER(), 0);
 }
 
-int ipfw_output_check(struct firewall_ops *this, int pf,
-		      struct net_device *dev, void *arg,
-		      struct sk_buff **pskb)
+static int ipfw_output_check(struct firewall_ops *this, int pf,
+			     struct net_device *dev, void *arg,
+			     struct sk_buff **pskb)
 {
 	/* Locally generated bogus packets by root. <SIGH>. */
 	if ((*pskb)->len < sizeof(struct iphdr) ||
@@ -1778,15 +1778,15 @@
 			   arg, IP_FW_OUTPUT_CHAIN, pskb, SLOT_NUMBER(), 0);
 }
 
-int ipfw_forward_check(struct firewall_ops *this, int pf,
-		       struct net_device *dev, void *arg,
-		       struct sk_buff **pskb)
+static int ipfw_forward_check(struct firewall_ops *this, int pf,
+			      struct net_device *dev, void *arg,
+			      struct sk_buff **pskb)
 {
 	return ip_fw_check(dev->name,
 			   arg, IP_FW_FORWARD_CHAIN, pskb, SLOT_NUMBER(), 0);
 }
 
-struct firewall_ops ipfw_ops = {
+static struct firewall_ops ipfw_ops = {
 	.fw_forward	=	ipfw_forward_check,
 	.fw_input	=	ipfw_input_check,
 	.fw_output	=	ipfw_output_check,
--- linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ipfwadm_core.h.old	2004-12-14 04:11:30.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netfilter_ipv4/ipfwadm_core.h	2004-12-14 04:17:32.000000000 +0100
@@ -229,17 +229,10 @@
 
 #include <linux/config.h>
 #ifdef CONFIG_IP_FIREWALL
-extern struct ip_fw *ip_fw_in_chain;
-extern struct ip_fw *ip_fw_out_chain;
-extern struct ip_fw *ip_fw_fwd_chain;
-extern int ip_fw_in_policy;
-extern int ip_fw_out_policy;
-extern int ip_fw_fwd_policy;
 extern int ip_fw_ctl(int, void *, int);
 #endif
 #ifdef CONFIG_IP_ACCT
 extern struct ip_fw *ip_acct_chain;
-extern int ip_acct_ctl(int, void *, int);
 #endif
 #ifdef CONFIG_IP_MASQUERADE
 extern int ip_masq_ctl(int, void *, int);
@@ -250,7 +243,5 @@
 
 extern int ip_fw_masq_timeouts(void *user, int len);
 
-extern int ip_fw_chk(struct sk_buff **, struct net_device *, __u16 *,
-		     struct ip_fw *, int, int);
 #endif /* KERNEL */
 #endif /* _IP_FW_H */
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipfwadm_core.c.old	2004-12-14 04:10:42.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipfwadm_core.c	2004-12-15 00:13:46.000000000 +0100
@@ -165,11 +165,11 @@
 
 #if defined(CONFIG_IP_ACCT) || defined(CONFIG_IP_FIREWALL)
 
-struct ip_fw *ip_fw_fwd_chain;
-struct ip_fw *ip_fw_in_chain;
-struct ip_fw *ip_fw_out_chain;
-struct ip_fw *ip_acct_chain;
-struct ip_fw *ip_masq_chain;
+static struct ip_fw *ip_fw_fwd_chain;
+static struct ip_fw *ip_fw_in_chain;
+static struct ip_fw *ip_fw_out_chain;
+static struct ip_fw *ip_acct_chain;
+static struct ip_fw *ip_masq_chain;
 
 static struct ip_fw **chains[] =
 	{&ip_fw_fwd_chain, &ip_fw_in_chain, &ip_fw_out_chain, &ip_acct_chain,
@@ -178,9 +178,9 @@
 #endif /* CONFIG_IP_ACCT || CONFIG_IP_FIREWALL */
 
 #ifdef CONFIG_IP_FIREWALL
-int ip_fw_fwd_policy=IP_FW_F_ACCEPT;
-int ip_fw_in_policy=IP_FW_F_ACCEPT;
-int ip_fw_out_policy=IP_FW_F_ACCEPT;
+static int ip_fw_fwd_policy=IP_FW_F_ACCEPT;
+static int ip_fw_in_policy=IP_FW_F_ACCEPT;
+static int ip_fw_out_policy=IP_FW_F_ACCEPT;
 
 static int *policies[] =
 	{&ip_fw_fwd_policy, &ip_fw_in_policy, &ip_fw_out_policy};
@@ -188,7 +188,7 @@
 #endif
 
 #ifdef CONFIG_IP_FIREWALL_NETLINK
-struct sock *ipfwsk;
+static struct sock *ipfwsk;
 #endif
 
 /*
@@ -323,9 +323,9 @@
  */
 
 
-int ip_fw_chk(struct sk_buff **pskb,
-	      struct net_device *rif, __u16 *redirport,
-	      struct ip_fw *chain, int policy, int mode)
+static int ip_fw_chk(struct sk_buff **pskb,
+		     struct net_device *rif, __u16 *redirport,
+		     struct ip_fw *chain, int policy, int mode)
 {
 	struct ip_fw *f;
 	__u32			src, dst;
@@ -939,7 +939,7 @@
 
 #endif  /* CONFIG_IP_ACCT || CONFIG_IP_FIREWALL */
 
-struct ip_fw *check_ipfw_struct(struct ip_fw *frwl, int len)
+static struct ip_fw *check_ipfw_struct(struct ip_fw *frwl, int len)
 {
 
 	if ( len != sizeof(struct ip_fw) )
@@ -1008,55 +1008,6 @@
 }
 
 
-
-
-#ifdef CONFIG_IP_ACCT
-
-int ip_acct_ctl(int stage, void *m, int len)
-{
-	if ( stage == IP_ACCT_FLUSH )
-	{
-		free_fw_chain(&ip_acct_chain);
-		return(0);
-	}
-	if ( stage == IP_ACCT_ZERO )
-	{
-		zero_fw_chain(ip_acct_chain);
-		return(0);
-	}
-	if ( stage == IP_ACCT_INSERT || stage == IP_ACCT_APPEND ||
-	  				stage == IP_ACCT_DELETE )
-	{
-		struct ip_fw *frwl;
-
-		if (!(frwl=check_ipfw_struct(m,len)))
-			return (EINVAL);
-
-		switch (stage)
-		{
-			case IP_ACCT_INSERT:
-				return( insert_in_chain(&ip_acct_chain,frwl,len));
-			case IP_ACCT_APPEND:
-				return( append_to_chain(&ip_acct_chain,frwl,len));
-		    	case IP_ACCT_DELETE:
-				return( del_from_chain(&ip_acct_chain,frwl));
-			default:
-				/*
- 				 *	Should be panic but... (Why ??? - AC)
-				 */
-#ifdef DEBUG_IP_FIREWALL
-				printk("ip_acct_ctl:  unknown request %d\n",stage);
-#endif
-				return(EINVAL);
-		}
-	}
-#ifdef DEBUG_IP_FIREWALL
-	printk("ip_acct_ctl:  unknown request %d\n",stage);
-#endif
-	return(EINVAL);
-}
-#endif
-
 #ifdef CONFIG_IP_FIREWALL
 int ip_fw_ctl(int stage, void *m, int len)
 {
@@ -1321,45 +1272,47 @@
  *	Interface to the generic firewall chains.
  */
 
-int ipfw_input_check(struct firewall_ops *this, int pf,
-		     struct net_device *dev, void *arg,
-		     struct sk_buff **pskb)
+static int ipfw_input_check(struct firewall_ops *this, int pf,
+			    struct net_device *dev, void *arg,
+			    struct sk_buff **pskb)
 {
 	return ip_fw_chk(pskb, dev, arg, ip_fw_in_chain, ip_fw_in_policy,
 			 IP_FW_MODE_FW);
 }
 
-int ipfw_output_check(struct firewall_ops *this, int pf,
-		      struct net_device *dev, void *arg,
-		      struct sk_buff **pskb)
+static int ipfw_output_check(struct firewall_ops *this, int pf,
+			     struct net_device *dev, void *arg,
+			     struct sk_buff **pskb)
 {
 	return ip_fw_chk(pskb, dev, arg, ip_fw_out_chain, ip_fw_out_policy,
 			 IP_FW_MODE_FW);
 }
 
-int ipfw_forward_check(struct firewall_ops *this, int pf,
-		       struct net_device *dev, void *arg,
-		       struct sk_buff **pskb)
+static int ipfw_forward_check(struct firewall_ops *this, int pf,
+			      struct net_device *dev, void *arg,
+			      struct sk_buff **pskb)
 {
 	return ip_fw_chk(pskb, dev, arg, ip_fw_fwd_chain, ip_fw_fwd_policy,
 			 IP_FW_MODE_FW);
 }
 
 #ifdef CONFIG_IP_ACCT
-int ipfw_acct_in(struct firewall_ops *this, int pf, struct net_device *dev,
-		 void *arg, struct sk_buff **pskb)
+static int ipfw_acct_in(struct firewall_ops *this, int pf,
+			struct net_device *dev,
+			void *arg, struct sk_buff **pskb)
 {
 	return ip_fw_chk(pskb,dev,NULL,ip_acct_chain,0,IP_FW_MODE_ACCT_IN);
 }
 
-int ipfw_acct_out(struct firewall_ops *this, int pf, struct net_device *dev,
-		  void *arg, struct sk_buff **pskb)
+static int ipfw_acct_out(struct firewall_ops *this, int pf,
+			 struct net_device *dev,
+			 void *arg, struct sk_buff **pskb)
 {
 	return ip_fw_chk(pskb,dev,NULL,ip_acct_chain,0,IP_FW_MODE_ACCT_OUT);
 }
 #endif
 
-struct firewall_ops ipfw_ops = {
+static struct firewall_ops ipfw_ops = {
 	.fw_forward	=	ipfw_forward_check,
 	.fw_input	=	ipfw_input_check,
 	.fw_output	=	ipfw_output_check,
@@ -1373,7 +1326,8 @@
 
 #if defined(CONFIG_IP_ACCT) || defined(CONFIG_IP_FIREWALL)
 
-int ipfw_device_event(struct notifier_block *this, unsigned long event, void *ptr)
+static int ipfw_device_event(struct notifier_block *this, unsigned long event,
+			     void *ptr)
 {
 	struct net_device *dev=ptr;
 	char *devname = dev->name;
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipt_CLUSTERIP.c.old	2004-12-14 04:17:48.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipt_CLUSTERIP.c	2004-12-14 04:17:57.000000000 +0100
@@ -66,7 +66,7 @@
 
 /* clusterip_lock protects the clusterip_configs list _AND_ the configurable
  * data within all structurses (num_local_nodes, local_nodes[]) */
-DECLARE_RWLOCK(clusterip_lock);
+static DECLARE_RWLOCK(clusterip_lock);
 
 #ifdef CONFIG_PROC_FS
 static struct file_operations clusterip_proc_fops;
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipt_ULOG.c.old	2004-12-14 04:18:10.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipt_ULOG.c	2004-12-14 04:18:30.000000000 +0100
@@ -100,7 +100,7 @@
 static ulog_buff_t ulog_buffers[ULOG_MAXNLGROUPS];	/* array of buffers */
 
 static struct sock *nflognl;	/* our socket */
-DECLARE_LOCK(ulog_lock);	/* spinlock */
+static DECLARE_LOCK(ulog_lock);	/* spinlock */
 
 /* send one ulog_buff_t to userspace */
 static void ulog_send(unsigned int nlgroupnum)
@@ -140,7 +140,7 @@
 	UNLOCK_BH(&ulog_lock);
 }
 
-struct sk_buff *ulog_alloc_skb(unsigned int size)
+static struct sk_buff *ulog_alloc_skb(unsigned int size)
 {
 	struct sk_buff *skb;
 
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipt_hashlimit.c.old	2004-12-14 04:18:42.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipt_hashlimit.c	2004-12-14 04:18:53.000000000 +0100
@@ -97,7 +97,7 @@
 	struct list_head hash[0];	/* hashtable itself */
 };
 
-DECLARE_RWLOCK(hashlimit_lock);		/* protects htables list */
+static DECLARE_RWLOCK(hashlimit_lock);	/* protects htables list */
 static LIST_HEAD(hashlimit_htables);
 static kmem_cache_t *hashlimit_cachep;
 
--- linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipt_recent.c.old	2004-12-14 04:19:11.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ipv4/netfilter/ipt_recent.c	2004-12-14 04:19:18.000000000 +0100
@@ -107,7 +107,7 @@
       int *hotdrop);
 
 /* Function to hash a given address into the hash table of table_size size */
-int hash_func(unsigned int addr, int table_size)
+static int hash_func(unsigned int addr, int table_size)
 {
 	int result = 0;
 	unsigned int value = addr;




