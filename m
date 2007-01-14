Return-Path: <linux-kernel-owner+w=401wt.eu-S1751637AbXANT3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbXANT3l (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 14:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbXANT3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 14:29:40 -0500
Received: from nef2.ens.fr ([129.199.96.40]:2589 "EHLO nef2.ens.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbXANT3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 14:29:39 -0500
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 14:29:38 EST
Date: Sun, 14 Jan 2007 20:20:11 +0100
From: David Madore <david.madore@ens.fr>
To: netfilter-devel@lists.netfilter.org, kaber@trash.net
Cc: linux-kernel@vger.kernel.org
Subject: [patch] netfilter: implement TCPMSS target for IPv6
Message-ID: <20070114192011.GA6270@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.9 (nef2.ens.fr [129.199.96.32]); Sun, 14 Jan 2007 20:20:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement TCPMSS target for IPv6 by shamelessly copying from
Marc Boucher's IPv4 implementation.

Signed-off-by: David A. Madore <david.madore@ens.fr>

---

 Note: The patch for ip6tables to make use of this module can be
 obtained from <URL:
 ftp://quatramaran.ens.fr/pub/madore/misc/ip6t-TCPMSS/
 > (also contains a version of this same patch for 2.6.19.2).

 include/linux/netfilter_ipv6/ip6t_TCPMSS.h |   10 ++
 net/ipv6/netfilter/Kconfig                 |   26 ++++
 net/ipv6/netfilter/Makefile                |    1 +
 net/ipv6/netfilter/ip6t_TCPMSS.c           |  225 ++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+), 0 deletions(-)

diff --git a/include/linux/netfilter_ipv6/ip6t_TCPMSS.h b/include/linux/netfilter_ipv6/ip6t_TCPMSS.h
new file mode 100644
index 0000000..412d1cb
--- /dev/null
+++ b/include/linux/netfilter_ipv6/ip6t_TCPMSS.h
@@ -0,0 +1,10 @@
+#ifndef _IP6T_TCPMSS_H
+#define _IP6T_TCPMSS_H
+
+struct ip6t_tcpmss_info {
+	u_int16_t mss;
+};
+
+#define IP6T_TCPMSS_CLAMP_PMTU 0xffff
+
+#endif /*_IP6T_TCPMSS_H*/
diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index adcd613..3890a59 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -154,6 +154,32 @@ config IP6_NF_TARGET_REJECT
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
+config IP6_NF_TARGET_TCPMSS
+	tristate "TCPMSS target support"
+	depends on IP6_NF_IPTABLES
+	---help---
+	  This option adds a `TCPMSS' target, which allows you to alter the
+	  MSS value of TCP SYN packets, to control the maximum size for that
+	  connection (usually limiting it to your outgoing interface's MTU
+	  minus 60).
+
+	  This is used to overcome criminally braindead ISPs or servers which
+	  block ICMPv6 Packet Too Big packets.  The symptoms of this
+	  problem are that everything works fine from your Linux
+	  firewall/router, but machines behind it can never exchange large
+	  packets:
+	  	1) Web browsers connect, then hang with no data received.
+	  	2) Small mail works fine, but large emails hang.
+	  	3) ssh works fine, but scp hangs after initial handshaking.
+
+	  Workaround: activate this option and add a rule to your firewall
+	  configuration like:
+
+	  ip6tables -A FORWARD -p tcp --tcp-flags SYN,RST SYN \
+	  		 -j TCPMSS --clamp-mss-to-pmtu
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
 config IP6_NF_MANGLE
 	tristate "Packet mangling"
 	depends on IP6_NF_IPTABLES
diff --git a/net/ipv6/netfilter/Makefile b/net/ipv6/netfilter/Makefile
index ac1dfeb..616a006 100644
--- a/net/ipv6/netfilter/Makefile
+++ b/net/ipv6/netfilter/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_IP6_NF_TARGET_LOG) += ip6t_LOG.o
 obj-$(CONFIG_IP6_NF_RAW) += ip6table_raw.o
 obj-$(CONFIG_IP6_NF_MATCH_HL) += ip6t_hl.o
 obj-$(CONFIG_IP6_NF_TARGET_REJECT) += ip6t_REJECT.o
+obj-$(CONFIG_IP6_NF_TARGET_TCPMSS) += ip6t_TCPMSS.o
 
 # objects for l3 independent conntrack
 nf_conntrack_ipv6-objs  :=  nf_conntrack_l3proto_ipv6.o nf_conntrack_proto_icmpv6.o nf_conntrack_reasm.o
diff --git a/net/ipv6/netfilter/ip6t_TCPMSS.c b/net/ipv6/netfilter/ip6t_TCPMSS.c
new file mode 100644
index 0000000..ab492c3
--- /dev/null
+++ b/net/ipv6/netfilter/ip6t_TCPMSS.c
@@ -0,0 +1,225 @@
+/*
+ * This is a module which is used for setting the MSS option in TCP packets.
+ *
+ * Copyright (C) 2007 David Madore <david.madore@ens.fr>
+ *
+ * Shamelessly based on net/ipv4/netfilter/ipt_TCPMSS.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/skbuff.h>
+
+#include <net/ipv6.h>
+#include <net/tcp.h>
+
+#include <linux/netfilter_ipv6/ip6_tables.h>
+#include <linux/netfilter_ipv6/ip6t_TCPMSS.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("David Madore <david.madore@ens.fr>");
+MODULE_DESCRIPTION("ip6tables TCP MSS modification module");
+
+static inline unsigned int
+optlen(const u_int8_t *opt, unsigned int offset)
+{
+	/* Beware zero-length options: make finite progress */
+	if (opt[offset] <= TCPOPT_NOP || opt[offset+1] == 0)
+		return 1;
+	else
+		return opt[offset+1];
+}
+
+static unsigned int
+ip6t_tcpmss_target(struct sk_buff **pskb,
+		   const struct net_device *in,
+		   const struct net_device *out,
+		   unsigned int hooknum,
+		   const struct xt_target *target,
+		   const void *targinfo)
+{
+	const struct ip6t_tcpmss_info *tcpmssinfo = targinfo;
+	struct tcphdr *tcph;
+	struct ipv6hdr *ipv6h;
+	u_int8_t nexthdr;
+	int tcphoff;
+	u_int16_t tcplen, newmss;
+	__be16 newiplen, oldval;
+	unsigned int i;
+	u_int8_t *opt;
+
+	if (!skb_make_writable(pskb, (*pskb)->len))
+		return NF_DROP;
+
+	ipv6h = (*pskb)->nh.ipv6h;
+	nexthdr = ipv6h->nexthdr;
+	tcphoff = ipv6_skip_exthdr(*pskb, sizeof(struct ipv6hdr), &nexthdr);
+	if ((tcphoff < 0) || (tcphoff > (*pskb)->len)) {
+		if (net_ratelimit())
+			printk(KERN_ERR
+			       "ip6t_tcpmss_target: can't find TCP header\n");
+		return NF_DROP;
+	}
+	tcplen = (*pskb)->len - tcphoff;
+	if ((nexthdr != IPPROTO_TCP) || (tcplen < sizeof(struct tcphdr))) {
+		/* Can't happen (see other comment below)? */
+		if (net_ratelimit())
+			printk(KERN_ERR
+			       "ip6t_tcpmss_target: bad TCP header\n");
+		return NF_DROP;
+	}
+	tcph = (void *)ipv6h + tcphoff;
+
+	/* Since it passed flags test in tcp match, we know it is is
+	   not a fragment, and has data >= tcp header length.  SYN
+	   packets should not contain data: if they did, then we risk
+	   running over MTU, sending Frag Needed and breaking things
+	   badly. --RR */
+	if (tcplen != tcph->doff*4) {
+		if (net_ratelimit())
+			printk(KERN_ERR
+			       "ip6t_tcpmss_target: bad length (%d bytes)\n",
+			       (*pskb)->len);
+		return NF_DROP;
+	}
+
+	if (tcpmssinfo->mss == IP6T_TCPMSS_CLAMP_PMTU) {
+		if (dst_mtu((*pskb)->dst) <= sizeof(struct ipv6hdr) +
+					     sizeof(struct tcphdr)) {
+			if (net_ratelimit())
+				printk(KERN_ERR "ip6t_tcpmss_target: "
+				       "unknown or invalid path-MTU (%d)\n",
+				       dst_mtu((*pskb)->dst));
+			return NF_DROP; /* or IP6T_CONTINUE ?? */
+		}
+
+		newmss = dst_mtu((*pskb)->dst) - sizeof(struct ipv6hdr) -
+						 sizeof(struct tcphdr);
+	} else
+		newmss = tcpmssinfo->mss;
+
+ 	opt = (u_int8_t *)tcph;
+	for (i = sizeof(struct tcphdr); i < tcph->doff*4; i += optlen(opt, i)) {
+		if (opt[i] == TCPOPT_MSS && tcph->doff*4 - i >= TCPOLEN_MSS &&
+		    opt[i+1] == TCPOLEN_MSS) {
+			u_int16_t oldmss;
+
+			oldmss = (opt[i+2] << 8) | opt[i+3];
+
+			if (tcpmssinfo->mss == IP6T_TCPMSS_CLAMP_PMTU &&
+			    oldmss <= newmss)
+				return IP6T_CONTINUE;
+
+			opt[i+2] = (newmss & 0xff00) >> 8;
+			opt[i+3] = (newmss & 0x00ff);
+
+			nf_proto_csum_replace2(&tcph->check, *pskb,
+					       htons(oldmss), htons(newmss), 0);
+			return IP6T_CONTINUE;
+		}
+	}
+
+	/*
+	 * MSS Option not found ?! add it..
+	 */
+	if (skb_tailroom((*pskb)) < TCPOLEN_MSS) {
+		struct sk_buff *newskb;
+
+		newskb = skb_copy_expand(*pskb, skb_headroom(*pskb),
+					 TCPOLEN_MSS, GFP_ATOMIC);
+		if (!newskb)
+			return NF_DROP;
+		kfree_skb(*pskb);
+		*pskb = newskb;
+		ipv6h = (*pskb)->nh.ipv6h;
+		tcph = (void *)ipv6h + tcphoff;
+	}
+
+	skb_put((*pskb), TCPOLEN_MSS);
+
+ 	opt = (u_int8_t *)tcph + sizeof(struct tcphdr);
+	memmove(opt + TCPOLEN_MSS, opt, tcplen - sizeof(struct tcphdr));
+
+ 	nf_proto_csum_replace2(&tcph->check, *pskb,
+ 				htons(tcplen), htons(tcplen + TCPOLEN_MSS), 1);
+	opt[0] = TCPOPT_MSS;
+	opt[1] = TCPOLEN_MSS;
+	opt[2] = (newmss & 0xff00) >> 8;
+	opt[3] = (newmss & 0x00ff);
+
+ 	nf_proto_csum_replace4(&tcph->check, *pskb, 0, *((__be32 *)opt), 0);
+
+	oldval = ((__be16 *)tcph)[6];
+	tcph->doff += TCPOLEN_MSS/4;
+ 	nf_proto_csum_replace2(&tcph->check, *pskb,
+ 				oldval, ((__be16 *)tcph)[6], 0);
+
+	newiplen = htons(ntohs(ipv6h->payload_len) + TCPOLEN_MSS);
+	ipv6h->payload_len = newiplen;
+	return IP6T_CONTINUE;
+}
+
+#define TH_SYN 0x02
+
+static inline int find_syn_match(const struct ip6t_entry_match *m)
+{
+	const struct ip6t_tcp *tcpinfo = (const struct ip6t_tcp *)m->data;
+
+	if (strcmp(m->u.kernel.match->name, "tcp") == 0 &&
+	    tcpinfo->flg_cmp & TH_SYN &&
+	    !(tcpinfo->invflags & IP6T_TCP_INV_FLAGS))
+		return 1;
+
+	return 0;
+}
+
+/* Must specify -p tcp --syn/--tcp-flags SYN */
+static int
+ip6t_tcpmss_checkentry(const char *tablename,
+		       const void *e_void,
+		       const struct xt_target *target,
+		       void *targinfo,
+		       unsigned int hook_mask)
+{
+	const struct ip6t_tcpmss_info *tcpmssinfo = targinfo;
+	const struct ip6t_entry *e = e_void;
+
+	if (tcpmssinfo->mss == IP6T_TCPMSS_CLAMP_PMTU &&
+	    (hook_mask & ~((1 << NF_IP6_FORWARD) |
+			   (1 << NF_IP6_LOCAL_OUT) |
+			   (1 << NF_IP6_POST_ROUTING))) != 0) {
+		printk("TCPMSS: path-MTU clamping only supported in "
+		       "FORWARD, OUTPUT and POSTROUTING hooks\n");
+		return 0;
+	}
+
+	if (IP6T_MATCH_ITERATE(e, find_syn_match))
+		return 1;
+	printk("TCPMSS: Only works on TCP SYN packets\n");
+	return 0;
+}
+
+static struct ip6t_target ip6t_tcpmss_reg = {
+	.name		= "TCPMSS",
+	.target		= ip6t_tcpmss_target,
+	.targetsize	= sizeof(struct ip6t_tcpmss_info),
+	.proto		= IPPROTO_TCP,
+	.checkentry	= ip6t_tcpmss_checkentry,
+	.me		= THIS_MODULE,
+};
+
+static int __init ip6t_tcpmss_init(void)
+{
+	return ip6t_register_target(&ip6t_tcpmss_reg);
+}
+
+static void __exit ip6t_tcpmss_fini(void)
+{
+	ip6t_unregister_target(&ip6t_tcpmss_reg);
+}
+
+module_init(ip6t_tcpmss_init);
+module_exit(ip6t_tcpmss_fini);
