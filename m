Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVBYQmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVBYQmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 11:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVBYQmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 11:42:21 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:24078 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S261863AbVBYQkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 11:40:10 -0500
Date: Fri, 25 Feb 2005 16:40:01 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@redhat.com, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       netdev@oss.sgi.com
cc: linux-kernel@vger.kernel.org
Subject: linux-2.6.8.1 to linux-2.6.10: Kernel Patching Issues.
Message-ID: <Pine.LNX.4.10.10502251550520.26208-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am not sure exactly where to send this email. A have chosen the
ip4/ip6 networking as the issues are in this area of the kernel.
 
The kernel patch files patch-2.6.9 and patch-2.6.10 do not apear to be
correct. I had some errors during patching so I generated a diff against a
freshly downloaded linux-2.6.10 kernel. See the steps below:

1) bzcat linux-2.6.8.1.tar.bz2 | tar -xf -
2) cd linux-2.6.8.1
3) bzcat ../patch-2.6.8.1.bz2 | patch -R -p1
	This gives a 2.6.8 kernel.

4) bzcat ../patch-2.6.9.bz2 | patch -p1
	This should give a 2.6.9 kernel. The patch has two errors:
		./net/ipv4/netfilter/ipt_ecn.c.rej
		./net/ipv4/netfilter/ipt_tcpmss.c.rej

5) bzcat ../patch-2.6.10.bz2 | patch -p1 -f
	This should give a 2.6.10 kernel. The patch has three erros:
		./include/linux/netfilter_ipv4/ipt_connmark.h.rej
		./net/ipv4/netfilter/ipt_connmark.c.rej
		./net/ipv6/netfilter/ip6t_MARK.c.rej
6) cd ..; mv linux-2.6.8.1 linux-2.6.10p
7) bzcat linux-2.6.10.tar.bz2 | tar -xf -
8) diff -rupN linux-2.6.10p linux-2.6.10 | tee patch-2.6.10.err

patch-2.6.10.err:
------------------------------------------------------------------------
diff -rupN linux-2.6.10p/include/linux/netfilter_ipv4/ipt_connmark.h.rej linux-2.6.10/include/linux/netfilter_ipv4/ipt_connmark.h.rej
--- linux-2.6.10p/include/linux/netfilter_ipv4/ipt_connmark.h.rej	2005-02-25 16:00:01.703125000 +0000
+++ linux-2.6.10/include/linux/netfilter_ipv4/ipt_connmark.h.rej	1970-01-01 00:00:00.000000000 +0000
@@ -1,21 +0,0 @@
-***************
-*** 0 ****
---- 1,18 ----
-+ #ifndef _IPT_CONNMARK_H
-+ #define _IPT_CONNMARK_H
-+ 
-+ /* Copyright (C) 2002,2004 MARA Systems AB <http://www.marasystems.com>
-+  * by Henrik Nordstrom <hno@marasystems.com>
-+  *
-+  * This program is free software; you can redistribute it and/or modify
-+  * it under the terms of the GNU General Public License as published by
-+  * the Free Software Foundation; either version 2 of the License, or
-+  * (at your option) any later version.
-+  */
-+ 
-+ struct ipt_connmark_info {
-+ 	unsigned long mark, mask;
-+ 	u_int8_t invert;
-+ };
-+ 
-+ #endif /*_IPT_CONNMARK_H*/
diff -rupN linux-2.6.10p/net/ipv4/netfilter/ipt_TCPMSS.c linux-2.6.10/net/ipv4/netfilter/ipt_TCPMSS.c
--- linux-2.6.10p/net/ipv4/netfilter/ipt_TCPMSS.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/net/ipv4/netfilter/ipt_TCPMSS.c	2004-12-24 21:34:48.000000000 +0000
@@ -0,0 +1,262 @@
+/*
+ * This is a module which is used for setting the MSS option in TCP packets.
+ *
+ * Copyright (C) 2000 Marc Boucher <marc@mbsi.ca>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/skbuff.h>
+
+#include <linux/ip.h>
+#include <net/tcp.h>
+
+#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter_ipv4/ipt_TCPMSS.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marc Boucher <marc@mbsi.ca>");
+MODULE_DESCRIPTION("iptables TCP MSS modification module");
+
+#if 0
+#define DEBUGP printk
+#else
+#define DEBUGP(format, args...)
+#endif
+
+static u_int16_t
+cheat_check(u_int32_t oldvalinv, u_int32_t newval, u_int16_t oldcheck)
+{
+	u_int32_t diffs[] = { oldvalinv, newval };
+	return csum_fold(csum_partial((char *)diffs, sizeof(diffs),
+                                      oldcheck^0xFFFF));
+}
+
+static inline unsigned int
+optlen(const u_int8_t *opt, unsigned int offset)
+{
+	/* Beware zero-length options: make finite progress */
+	if (opt[offset] <= TCPOPT_NOP || opt[offset+1] == 0) return 1;
+	else return opt[offset+1];
+}
+
+static unsigned int
+ipt_tcpmss_target(struct sk_buff **pskb,
+		  const struct net_device *in,
+		  const struct net_device *out,
+		  unsigned int hooknum,
+		  const void *targinfo,
+		  void *userinfo)
+{
+	const struct ipt_tcpmss_info *tcpmssinfo = targinfo;
+	struct tcphdr *tcph;
+	struct iphdr *iph;
+	u_int16_t tcplen, newtotlen, oldval, newmss;
+	unsigned int i;
+	u_int8_t *opt;
+
+	if (!skb_ip_make_writable(pskb, (*pskb)->len))
+		return NF_DROP;
+
+	iph = (*pskb)->nh.iph;
+	tcplen = (*pskb)->len - iph->ihl*4;
+
+	tcph = (void *)iph + iph->ihl*4;
+
+	/* Since it passed flags test in tcp match, we know it is is
+	   not a fragment, and has data >= tcp header length.  SYN
+	   packets should not contain data: if they did, then we risk
+	   running over MTU, sending Frag Needed and breaking things
+	   badly. --RR */
+	if (tcplen != tcph->doff*4) {
+		if (net_ratelimit())
+			printk(KERN_ERR
+			       "ipt_tcpmss_target: bad length (%d bytes)\n",
+			       (*pskb)->len);
+		return NF_DROP;
+	}
+
+	if(tcpmssinfo->mss == IPT_TCPMSS_CLAMP_PMTU) {
+		if(!(*pskb)->dst) {
+			if (net_ratelimit())
+				printk(KERN_ERR
+			       		"ipt_tcpmss_target: no dst?! can't determine path-MTU\n");
+			return NF_DROP; /* or IPT_CONTINUE ?? */
+		}
+
+		if(dst_pmtu((*pskb)->dst) <= (sizeof(struct iphdr) + sizeof(struct tcphdr))) {
+			if (net_ratelimit())
+				printk(KERN_ERR
+		       			"ipt_tcpmss_target: unknown or invalid path-MTU (%d)\n", dst_pmtu((*pskb)->dst));
+			return NF_DROP; /* or IPT_CONTINUE ?? */
+		}
+
+		newmss = dst_pmtu((*pskb)->dst) - sizeof(struct iphdr) - sizeof(struct tcphdr);
+	} else
+		newmss = tcpmssinfo->mss;
+
+ 	opt = (u_int8_t *)tcph;
+	for (i = sizeof(struct tcphdr); i < tcph->doff*4; i += optlen(opt, i)){
+		if ((opt[i] == TCPOPT_MSS) &&
+		    ((tcph->doff*4 - i) >= TCPOLEN_MSS) &&
+		    (opt[i+1] == TCPOLEN_MSS)) {
+			u_int16_t oldmss;
+
+			oldmss = (opt[i+2] << 8) | opt[i+3];
+
+			if((tcpmssinfo->mss == IPT_TCPMSS_CLAMP_PMTU) &&
+				(oldmss <= newmss))
+					return IPT_CONTINUE;
+
+			opt[i+2] = (newmss & 0xff00) >> 8;
+			opt[i+3] = (newmss & 0x00ff);
+
+			tcph->check = cheat_check(htons(oldmss)^0xFFFF,
+						  htons(newmss),
+						  tcph->check);
+
+			DEBUGP(KERN_INFO "ipt_tcpmss_target: %u.%u.%u.%u:%hu"
+			       "->%u.%u.%u.%u:%hu changed TCP MSS option"
+			       " (from %u to %u)\n", 
+			       NIPQUAD((*pskb)->nh.iph->saddr),
+			       ntohs(tcph->source),
+			       NIPQUAD((*pskb)->nh.iph->daddr),
+			       ntohs(tcph->dest),
+			       oldmss, newmss);
+			goto retmodified;
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
+		if (!newskb) {
+			if (net_ratelimit())
+				printk(KERN_ERR "ipt_tcpmss_target:"
+				       " unable to allocate larger skb\n");
+			return NF_DROP;
+		}
+
+		kfree_skb(*pskb);
+		*pskb = newskb;
+		iph = (*pskb)->nh.iph;
+		tcph = (void *)iph + iph->ihl*4;
+	}
+
+	skb_put((*pskb), TCPOLEN_MSS);
+
+ 	opt = (u_int8_t *)tcph + sizeof(struct tcphdr);
+	memmove(opt + TCPOLEN_MSS, opt, tcplen - sizeof(struct tcphdr));
+
+	tcph->check = cheat_check(htons(tcplen) ^ 0xFFFF,
+				  htons(tcplen + TCPOLEN_MSS), tcph->check);
+	tcplen += TCPOLEN_MSS;
+
+	opt[0] = TCPOPT_MSS;
+	opt[1] = TCPOLEN_MSS;
+	opt[2] = (newmss & 0xff00) >> 8;
+	opt[3] = (newmss & 0x00ff);
+
+	tcph->check = cheat_check(~0, *((u_int32_t *)opt), tcph->check);
+
+	oldval = ((u_int16_t *)tcph)[6];
+	tcph->doff += TCPOLEN_MSS/4;
+	tcph->check = cheat_check(oldval ^ 0xFFFF,
+				  ((u_int16_t *)tcph)[6], tcph->check);
+
+	newtotlen = htons(ntohs(iph->tot_len) + TCPOLEN_MSS);
+	iph->check = cheat_check(iph->tot_len ^ 0xFFFF,
+				 newtotlen, iph->check);
+	iph->tot_len = newtotlen;
+
+	DEBUGP(KERN_INFO "ipt_tcpmss_target: %u.%u.%u.%u:%hu"
+	       "->%u.%u.%u.%u:%hu added TCP MSS option (%u)\n",
+	       NIPQUAD((*pskb)->nh.iph->saddr),
+	       ntohs(tcph->source),
+	       NIPQUAD((*pskb)->nh.iph->daddr),
+	       ntohs(tcph->dest),
+	       newmss);
+
+ retmodified:
+	/* We never hw checksum SYN packets.  */
+	BUG_ON((*pskb)->ip_summed == CHECKSUM_HW);
+
+	(*pskb)->nfcache |= NFC_UNKNOWN | NFC_ALTERED;
+	return IPT_CONTINUE;
+}
+
+#define TH_SYN 0x02
+
+static inline int find_syn_match(const struct ipt_entry_match *m)
+{
+	const struct ipt_tcp *tcpinfo = (const struct ipt_tcp *)m->data;
+
+	if (strcmp(m->u.kernel.match->name, "tcp") == 0
+	    && (tcpinfo->flg_cmp & TH_SYN)
+	    && !(tcpinfo->invflags & IPT_TCP_INV_FLAGS))
+		return 1;
+
+	return 0;
+}
+
+/* Must specify -p tcp --syn/--tcp-flags SYN */
+static int
+ipt_tcpmss_checkentry(const char *tablename,
+		      const struct ipt_entry *e,
+		      void *targinfo,
+		      unsigned int targinfosize,
+		      unsigned int hook_mask)
+{
+	const struct ipt_tcpmss_info *tcpmssinfo = targinfo;
+
+	if (targinfosize != IPT_ALIGN(sizeof(struct ipt_tcpmss_info))) {
+		DEBUGP("ipt_tcpmss_checkentry: targinfosize %u != %u\n",
+		       targinfosize, IPT_ALIGN(sizeof(struct ipt_tcpmss_info)));
+		return 0;
+	}
+
+
+	if((tcpmssinfo->mss == IPT_TCPMSS_CLAMP_PMTU) && 
+			((hook_mask & ~((1 << NF_IP_FORWARD)
+			   	| (1 << NF_IP_LOCAL_OUT)
+			   	| (1 << NF_IP_POST_ROUTING))) != 0)) {
+		printk("TCPMSS: path-MTU clamping only supported in FORWARD, OUTPUT and POSTROUTING hooks\n");
+		return 0;
+	}
+
+	if (e->ip.proto == IPPROTO_TCP
+	    && !(e->ip.invflags & IPT_INV_PROTO)
+	    && IPT_MATCH_ITERATE(e, find_syn_match))
+		return 1;
+
+	printk("TCPMSS: Only works on TCP SYN packets\n");
+	return 0;
+}
+
+static struct ipt_target ipt_tcpmss_reg = {
+	.name		= "TCPMSS",
+	.target		= ipt_tcpmss_target,
+	.checkentry	= ipt_tcpmss_checkentry,
+	.me		= THIS_MODULE,
+};
+
+static int __init init(void)
+{
+	return ipt_register_target(&ipt_tcpmss_reg);
+}
+
+static void __exit fini(void)
+{
+	ipt_unregister_target(&ipt_tcpmss_reg);
+}
+
+module_init(init);
+module_exit(fini);
diff -rupN linux-2.6.10p/net/ipv4/netfilter/ipt_connmark.c.rej linux-2.6.10/net/ipv4/netfilter/ipt_connmark.c.rej
--- linux-2.6.10p/net/ipv4/netfilter/ipt_connmark.c.rej	2005-02-25 16:06:01.390625000 +0000
+++ linux-2.6.10/net/ipv4/netfilter/ipt_connmark.c.rej	1970-01-01 00:00:00.000000000 +0000
@@ -1,84 +0,0 @@
-***************
-*** 0 ****
---- 1,81 ----
-+ /* This kernel module matches connection mark values set by the
-+  * CONNMARK target
-+  *
-+  * Copyright (C) 2002,2004 MARA Systems AB <http://www.marasystems.com>
-+  * by Henrik Nordstrom <hno@marasystems.com>
-+  *
-+  * This program is free software; you can redistribute it and/or modify
-+  * it under the terms of the GNU General Public License as published by
-+  * the Free Software Foundation; either version 2 of the License, or
-+  * (at your option) any later version.
-+  *
-+  * This program is distributed in the hope that it will be useful,
-+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-+  * GNU General Public License for more details.
-+  *
-+  * You should have received a copy of the GNU General Public License
-+  * along with this program; if not, write to the Free Software
-+  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-+  */
-+ 
-+ #include <linux/module.h>
-+ #include <linux/skbuff.h>
-+ 
-+ MODULE_AUTHOR("Henrik Nordstrom <hno@marasytems.com>");
-+ MODULE_DESCRIPTION("IP tables connmark match module");
-+ MODULE_LICENSE("GPL");
-+ 
-+ #include <linux/netfilter_ipv4/ip_tables.h>
-+ #include <linux/netfilter_ipv4/ipt_connmark.h>
-+ #include <linux/netfilter_ipv4/ip_conntrack.h>
-+ 
-+ static int
-+ match(const struct sk_buff *skb,
-+       const struct net_device *in,
-+       const struct net_device *out,
-+       const void *matchinfo,
-+       int offset,
-+       int *hotdrop)
-+ {
-+ 	const struct ipt_connmark_info *info = matchinfo;
-+ 	enum ip_conntrack_info ctinfo;
-+ 	struct ip_conntrack *ct = ip_conntrack_get((struct sk_buff *)skb, &ctinfo);
-+ 	if (!ct)
-+ 		return 0;
-+ 
-+ 	return ((ct->mark & info->mask) == info->mark) ^ info->invert;
-+ }
-+ 
-+ static int
-+ checkentry(const char *tablename,
-+ 	   const struct ipt_ip *ip,
-+ 	   void *matchinfo,
-+ 	   unsigned int matchsize,
-+ 	   unsigned int hook_mask)
-+ {
-+ 	if (matchsize != IPT_ALIGN(sizeof(struct ipt_connmark_info)))
-+ 		return 0;
-+ 
-+ 	return 1;
-+ }
-+ 
-+ static struct ipt_match connmark_match = {
-+ 	.name = "connmark",
-+ 	.match = &match,
-+ 	.checkentry = &checkentry,
-+ 	.me = THIS_MODULE
-+ };
-+ 
-+ static int __init init(void)
-+ {
-+ 	return ipt_register_match(&connmark_match);
-+ }
-+ 
-+ static void __exit fini(void)
-+ {
-+ 	ipt_unregister_match(&connmark_match);
-+ }
-+ 
-+ module_init(init);
-+ module_exit(fini);
diff -rupN linux-2.6.10p/net/ipv4/netfilter/ipt_ecn.c.orig linux-2.6.10/net/ipv4/netfilter/ipt_ecn.c.orig
--- linux-2.6.10p/net/ipv4/netfilter/ipt_ecn.c.orig	2005-02-25 15:53:04.375000000 +0000
+++ linux-2.6.10/net/ipv4/netfilter/ipt_ecn.c.orig	1970-01-01 00:00:00.000000000 +0000
@@ -1,178 +0,0 @@
-/* iptables module for the IPv4 and TCP ECN bits, Version 1.5
- *
- * (C) 2002 by Harald Welte <laforge@netfilter.org>
- * 
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as 
- * published by the Free Software Foundation.
- *
- * ipt_ECN.c,v 1.5 2002/08/18 19:36:51 laforge Exp
-*/
-
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <linux/ip.h>
-#include <linux/tcp.h>
-#include <net/checksum.h>
-
-#include <linux/netfilter_ipv4/ip_tables.h>
-#include <linux/netfilter_ipv4/ipt_ECN.h>
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
-MODULE_DESCRIPTION("iptables ECN modification module");
-
-/* set ECT codepoint from IP header.
- * 	return 0 if there was an error. */
-static inline int
-set_ect_ip(struct sk_buff **pskb, const struct ipt_ECN_info *einfo)
-{
-	if (((*pskb)->nh.iph->tos & IPT_ECN_IP_MASK)
-	    != (einfo->ip_ect & IPT_ECN_IP_MASK)) {
-		u_int16_t diffs[2];
-
-		if (!skb_ip_make_writable(pskb, sizeof(struct iphdr)))
-			return 0;
-
-		diffs[0] = htons((*pskb)->nh.iph->tos) ^ 0xFFFF;
-		(*pskb)->nh.iph->tos &= ~IPT_ECN_IP_MASK;
-		(*pskb)->nh.iph->tos |= (einfo->ip_ect & IPT_ECN_IP_MASK);
-		diffs[1] = htons((*pskb)->nh.iph->tos);
-		(*pskb)->nh.iph->check
-			= csum_fold(csum_partial((char *)diffs,
-						 sizeof(diffs),
-						 (*pskb)->nh.iph->check
-						 ^0xFFFF));
-		(*pskb)->nfcache |= NFC_ALTERED;
-	} 
-	return 1;
-}
-
-/* Return 0 if there was an error. */
-static inline int
-set_ect_tcp(struct sk_buff **pskb, const struct ipt_ECN_info *einfo, int inward)
-{
-	struct tcphdr _tcph, *th;
-	u_int16_t diffs[2];
-
-	/* Not enought header? */
-	th = skb_header_pointer(*pskb, (*pskb)->nh.iph->ihl*4,
-				sizeof(_tcph), &_tcph);
-	if (th == NULL)
-		return 0;
-
-	diffs[0] = ((u_int16_t *)th)[6];
-	if (einfo->operation & IPT_ECN_OP_SET_ECE)
-		th->ece = einfo->proto.tcp.ece;
-
-	if (einfo->operation & IPT_ECN_OP_SET_CWR)
-		th->cwr = einfo->proto.tcp.cwr;
-	diffs[1] = ((u_int16_t *)&th)[6];
-
-	/* Only mangle if it's changed. */
-	if (diffs[0] != diffs[1]) {
-		diffs[0] = diffs[0] ^ 0xFFFF;
-		if (!skb_ip_make_writable(pskb,
-					  (*pskb)->nh.iph->ihl*4+sizeof(_tcph)))
-			return 0;
-
-		if (th != &_tcph)
-			memcpy(&_tcph, th, sizeof(_tcph));
-
-		if ((*pskb)->ip_summed != CHECKSUM_HW)
-			_tcph.check = csum_fold(csum_partial((char *)diffs,
-							     sizeof(diffs),
-							     _tcph.check^0xFFFF));
-		memcpy((*pskb)->data + (*pskb)->nh.iph->ihl*4,
-		       &_tcph, sizeof(_tcph));
-		if ((*pskb)->ip_summed == CHECKSUM_HW)
-			if (skb_checksum_help(pskb, inward))
-				return 0;
-		(*pskb)->nfcache |= NFC_ALTERED;
-	}
-	return 1;
-}
-
-static unsigned int
-target(struct sk_buff **pskb,
-       const struct net_device *in,
-       const struct net_device *out,
-       unsigned int hooknum,
-       const void *targinfo,
-       void *userinfo)
-{
-	const struct ipt_ECN_info *einfo = targinfo;
-
-	if (einfo->operation & IPT_ECN_OP_SET_IP)
-		if (!set_ect_ip(pskb, einfo))
-			return NF_DROP;
-
-	if (einfo->operation & (IPT_ECN_OP_SET_ECE | IPT_ECN_OP_SET_CWR)
-	    && (*pskb)->nh.iph->protocol == IPPROTO_TCP)
-		if (!set_ect_tcp(pskb, einfo, (out == NULL)))
-			return NF_DROP;
-
-	return IPT_CONTINUE;
-}
-
-static int
-checkentry(const char *tablename,
-	   const struct ipt_entry *e,
-           void *targinfo,
-           unsigned int targinfosize,
-           unsigned int hook_mask)
-{
-	const struct ipt_ECN_info *einfo = (struct ipt_ECN_info *)targinfo;
-
-	if (targinfosize != IPT_ALIGN(sizeof(struct ipt_ECN_info))) {
-		printk(KERN_WARNING "ECN: targinfosize %u != %Zu\n",
-		       targinfosize,
-		       IPT_ALIGN(sizeof(struct ipt_ECN_info)));
-		return 0;
-	}
-
-	if (strcmp(tablename, "mangle") != 0) {
-		printk(KERN_WARNING "ECN: can only be called from \"mangle\" table, not \"%s\"\n", tablename);
-		return 0;
-	}
-
-	if (einfo->operation & IPT_ECN_OP_MASK) {
-		printk(KERN_WARNING "ECN: unsupported ECN operation %x\n",
-			einfo->operation);
-		return 0;
-	}
-	if (einfo->ip_ect & ~IPT_ECN_IP_MASK) {
-		printk(KERN_WARNING "ECN: new ECT codepoint %x out of mask\n",
-			einfo->ip_ect);
-		return 0;
-	}
-
-	if ((einfo->operation & (IPT_ECN_OP_SET_ECE|IPT_ECN_OP_SET_CWR))
-	    && e->ip.proto != IPPROTO_TCP) {
-		printk(KERN_WARNING "ECN: cannot use TCP operations on a "
-		       "non-tcp rule\n");
-		return 0;
-	}
-
-	return 1;
-}
-
-static struct ipt_target ipt_ecn_reg = {
-	.name		= "ECN",
-	.target		= target,
-	.checkentry	= checkentry,
-	.me		= THIS_MODULE,
-};
-
-static int __init init(void)
-{
-	return ipt_register_target(&ipt_ecn_reg);
-}
-
-static void __exit fini(void)
-{
-	ipt_unregister_target(&ipt_ecn_reg);
-}
-
-module_init(init);
-module_exit(fini);
diff -rupN linux-2.6.10p/net/ipv4/netfilter/ipt_ecn.c.rej linux-2.6.10/net/ipv4/netfilter/ipt_ecn.c.rej
--- linux-2.6.10p/net/ipv4/netfilter/ipt_ecn.c.rej	2005-02-25 15:53:04.812500000 +0000
+++ linux-2.6.10/net/ipv4/netfilter/ipt_ecn.c.rej	1970-01-01 00:00:00.000000000 +0000
@@ -1,68 +0,0 @@
-***************
-*** 30,60 ****
-  			    const struct ipt_ecn_info *einfo,
-  			    int *hotdrop)
-  {
-- 	struct tcphdr tcph;
-  
-  	/* In practice, TCP match does this, so can't fail.  But let's
--            be good citizens. */
-- 	if (skb_copy_bits(skb, skb->nh.iph->ihl*4, &tcph, sizeof(tcph)) < 0) {
-  		*hotdrop = 0;
-  		return 0;
-  	}
-  
-  	if (einfo->operation & IPT_ECN_OP_MATCH_ECE) {
-  		if (einfo->invert & IPT_ECN_OP_MATCH_ECE) {
-- 			if (tcph.ece == 1)
-  				return 0;
-  		} else {
-- 			if (tcph.ece == 0)
-  				return 0;
-  		}
-  	}
-  
-  	if (einfo->operation & IPT_ECN_OP_MATCH_CWR) {
-  		if (einfo->invert & IPT_ECN_OP_MATCH_CWR) {
-- 			if (tcph.cwr == 1)
-  				return 0;
-  		} else {
-- 			if (tcph.cwr == 0)
-  				return 0;
-  		}
-  	}
---- 30,63 ----
-  			    const struct ipt_ecn_info *einfo,
-  			    int *hotdrop)
-  {
-+ 	struct tcphdr _tcph, *th;
-  
-  	/* In practice, TCP match does this, so can't fail.  But let's
-+ 	 * be good citizens.
-+ 	 */
-+ 	th = skb_header_pointer(skb, skb->nh.iph->ihl * 4,
-+ 				sizeof(_tcph), &_tcph);
-+ 	if (th == NULL) {
-  		*hotdrop = 0;
-  		return 0;
-  	}
-  
-  	if (einfo->operation & IPT_ECN_OP_MATCH_ECE) {
-  		if (einfo->invert & IPT_ECN_OP_MATCH_ECE) {
-+ 			if (th->ece == 1)
-  				return 0;
-  		} else {
-+ 			if (th->ece == 0)
-  				return 0;
-  		}
-  	}
-  
-  	if (einfo->operation & IPT_ECN_OP_MATCH_CWR) {
-  		if (einfo->invert & IPT_ECN_OP_MATCH_CWR) {
-+ 			if (th->cwr == 1)
-  				return 0;
-  		} else {
-+ 			if (th->cwr == 0)
-  				return 0;
-  		}
-  	}
diff -rupN linux-2.6.10p/net/ipv4/netfilter/ipt_tcpmss.c linux-2.6.10/net/ipv4/netfilter/ipt_tcpmss.c
--- linux-2.6.10p/net/ipv4/netfilter/ipt_tcpmss.c	2005-02-25 16:06:02.000000000 +0000
+++ linux-2.6.10/net/ipv4/netfilter/ipt_tcpmss.c	1970-01-01 00:00:00.000000000 +0000
@@ -1,262 +0,0 @@
-/*
- * This is a module which is used for setting the MSS option in TCP packets.
- *
- * Copyright (C) 2000 Marc Boucher <marc@mbsi.ca>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/skbuff.h>
-
-#include <linux/ip.h>
-#include <net/tcp.h>
-
-#include <linux/netfilter_ipv4/ip_tables.h>
-#include <linux/netfilter_ipv4/ipt_TCPMSS.h>
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Marc Boucher <marc@mbsi.ca>");
-MODULE_DESCRIPTION("iptables TCP MSS modification module");
-
-#if 0
-#define DEBUGP printk
-#else
-#define DEBUGP(format, args...)
-#endif
-
-static u_int16_t
-cheat_check(u_int32_t oldvalinv, u_int32_t newval, u_int16_t oldcheck)
-{
-	u_int32_t diffs[] = { oldvalinv, newval };
-	return csum_fold(csum_partial((char *)diffs, sizeof(diffs),
-                                      oldcheck^0xFFFF));
-}
-
-static inline unsigned int
-optlen(const u_int8_t *opt, unsigned int offset)
-{
-	/* Beware zero-length options: make finite progress */
-	if (opt[offset] <= TCPOPT_NOP || opt[offset+1] == 0) return 1;
-	else return opt[offset+1];
-}
-
-static unsigned int
-ipt_tcpmss_target(struct sk_buff **pskb,
-		  const struct net_device *in,
-		  const struct net_device *out,
-		  unsigned int hooknum,
-		  const void *targinfo,
-		  void *userinfo)
-{
-	const struct ipt_tcpmss_info *tcpmssinfo = targinfo;
-	struct tcphdr *tcph;
-	struct iphdr *iph;
-	u_int16_t tcplen, newtotlen, oldval, newmss;
-	unsigned int i;
-	u_int8_t *opt;
-
-	if (!skb_ip_make_writable(pskb, (*pskb)->len))
-		return NF_DROP;
-
-	iph = (*pskb)->nh.iph;
-	tcplen = (*pskb)->len - iph->ihl*4;
-
-	tcph = (void *)iph + iph->ihl*4;
-
-	/* Since it passed flags test in tcp match, we know it is is
-	   not a fragment, and has data >= tcp header length.  SYN
-	   packets should not contain data: if they did, then we risk
-	   running over MTU, sending Frag Needed and breaking things
-	   badly. --RR */
-	if (tcplen != tcph->doff*4) {
-		if (net_ratelimit())
-			printk(KERN_ERR
-			       "ipt_tcpmss_target: bad length (%d bytes)\n",
-			       (*pskb)->len);
-		return NF_DROP;
-	}
-
-	if(tcpmssinfo->mss == IPT_TCPMSS_CLAMP_PMTU) {
-		if(!(*pskb)->dst) {
-			if (net_ratelimit())
-				printk(KERN_ERR
-			       		"ipt_tcpmss_target: no dst?! can't determine path-MTU\n");
-			return NF_DROP; /* or IPT_CONTINUE ?? */
-		}
-
-		if(dst_pmtu((*pskb)->dst) <= (sizeof(struct iphdr) + sizeof(struct tcphdr))) {
-			if (net_ratelimit())
-				printk(KERN_ERR
-		       			"ipt_tcpmss_target: unknown or invalid path-MTU (%d)\n", dst_pmtu((*pskb)->dst));
-			return NF_DROP; /* or IPT_CONTINUE ?? */
-		}
-
-		newmss = dst_pmtu((*pskb)->dst) - sizeof(struct iphdr) - sizeof(struct tcphdr);
-	} else
-		newmss = tcpmssinfo->mss;
-
- 	opt = (u_int8_t *)tcph;
-	for (i = sizeof(struct tcphdr); i < tcph->doff*4; i += optlen(opt, i)){
-		if ((opt[i] == TCPOPT_MSS) &&
-		    ((tcph->doff*4 - i) >= TCPOLEN_MSS) &&
-		    (opt[i+1] == TCPOLEN_MSS)) {
-			u_int16_t oldmss;
-
-			oldmss = (opt[i+2] << 8) | opt[i+3];
-
-			if((tcpmssinfo->mss == IPT_TCPMSS_CLAMP_PMTU) &&
-				(oldmss <= newmss))
-					return IPT_CONTINUE;
-
-			opt[i+2] = (newmss & 0xff00) >> 8;
-			opt[i+3] = (newmss & 0x00ff);
-
-			tcph->check = cheat_check(htons(oldmss)^0xFFFF,
-						  htons(newmss),
-						  tcph->check);
-
-			DEBUGP(KERN_INFO "ipt_tcpmss_target: %u.%u.%u.%u:%hu"
-			       "->%u.%u.%u.%u:%hu changed TCP MSS option"
-			       " (from %u to %u)\n", 
-			       NIPQUAD((*pskb)->nh.iph->saddr),
-			       ntohs(tcph->source),
-			       NIPQUAD((*pskb)->nh.iph->daddr),
-			       ntohs(tcph->dest),
-			       oldmss, newmss);
-			goto retmodified;
-		}
-	}
-
-	/*
-	 * MSS Option not found ?! add it..
-	 */
-	if (skb_tailroom((*pskb)) < TCPOLEN_MSS) {
-		struct sk_buff *newskb;
-
-		newskb = skb_copy_expand(*pskb, skb_headroom(*pskb),
-					 TCPOLEN_MSS, GFP_ATOMIC);
-		if (!newskb) {
-			if (net_ratelimit())
-				printk(KERN_ERR "ipt_tcpmss_target:"
-				       " unable to allocate larger skb\n");
-			return NF_DROP;
-		}
-
-		kfree_skb(*pskb);
-		*pskb = newskb;
-		iph = (*pskb)->nh.iph;
-		tcph = (void *)iph + iph->ihl*4;
-	}
-
-	skb_put((*pskb), TCPOLEN_MSS);
-
- 	opt = (u_int8_t *)tcph + sizeof(struct tcphdr);
-	memmove(opt + TCPOLEN_MSS, opt, tcplen - sizeof(struct tcphdr));
-
-	tcph->check = cheat_check(htons(tcplen) ^ 0xFFFF,
-				  htons(tcplen + TCPOLEN_MSS), tcph->check);
-	tcplen += TCPOLEN_MSS;
-
-	opt[0] = TCPOPT_MSS;
-	opt[1] = TCPOLEN_MSS;
-	opt[2] = (newmss & 0xff00) >> 8;
-	opt[3] = (newmss & 0x00ff);
-
-	tcph->check = cheat_check(~0, *((u_int32_t *)opt), tcph->check);
-
-	oldval = ((u_int16_t *)tcph)[6];
-	tcph->doff += TCPOLEN_MSS/4;
-	tcph->check = cheat_check(oldval ^ 0xFFFF,
-				  ((u_int16_t *)tcph)[6], tcph->check);
-
-	newtotlen = htons(ntohs(iph->tot_len) + TCPOLEN_MSS);
-	iph->check = cheat_check(iph->tot_len ^ 0xFFFF,
-				 newtotlen, iph->check);
-	iph->tot_len = newtotlen;
-
-	DEBUGP(KERN_INFO "ipt_tcpmss_target: %u.%u.%u.%u:%hu"
-	       "->%u.%u.%u.%u:%hu added TCP MSS option (%u)\n",
-	       NIPQUAD((*pskb)->nh.iph->saddr),
-	       ntohs(tcph->source),
-	       NIPQUAD((*pskb)->nh.iph->daddr),
-	       ntohs(tcph->dest),
-	       newmss);
-
- retmodified:
-	/* We never hw checksum SYN packets.  */
-	BUG_ON((*pskb)->ip_summed == CHECKSUM_HW);
-
-	(*pskb)->nfcache |= NFC_UNKNOWN | NFC_ALTERED;
-	return IPT_CONTINUE;
-}
-
-#define TH_SYN 0x02
-
-static inline int find_syn_match(const struct ipt_entry_match *m)
-{
-	const struct ipt_tcp *tcpinfo = (const struct ipt_tcp *)m->data;
-
-	if (strcmp(m->u.kernel.match->name, "tcp") == 0
-	    && (tcpinfo->flg_cmp & TH_SYN)
-	    && !(tcpinfo->invflags & IPT_TCP_INV_FLAGS))
-		return 1;
-
-	return 0;
-}
-
-/* Must specify -p tcp --syn/--tcp-flags SYN */
-static int
-ipt_tcpmss_checkentry(const char *tablename,
-		      const struct ipt_entry *e,
-		      void *targinfo,
-		      unsigned int targinfosize,
-		      unsigned int hook_mask)
-{
-	const struct ipt_tcpmss_info *tcpmssinfo = targinfo;
-
-	if (targinfosize != IPT_ALIGN(sizeof(struct ipt_tcpmss_info))) {
-		DEBUGP("ipt_tcpmss_checkentry: targinfosize %u != %u\n",
-		       targinfosize, IPT_ALIGN(sizeof(struct ipt_tcpmss_info)));
-		return 0;
-	}
-
-
-	if((tcpmssinfo->mss == IPT_TCPMSS_CLAMP_PMTU) && 
-			((hook_mask & ~((1 << NF_IP_FORWARD)
-			   	| (1 << NF_IP_LOCAL_OUT)
-			   	| (1 << NF_IP_POST_ROUTING))) != 0)) {
-		printk("TCPMSS: path-MTU clamping only supported in FORWARD, OUTPUT and POSTROUTING hooks\n");
-		return 0;
-	}
-
-	if (e->ip.proto == IPPROTO_TCP
-	    && !(e->ip.invflags & IPT_INV_PROTO)
-	    && IPT_MATCH_ITERATE(e, find_syn_match))
-		return 1;
-
-	printk("TCPMSS: Only works on TCP SYN packets\n");
-	return 0;
-}
-
-static struct ipt_target ipt_tcpmss_reg = {
-	.name		= "TCPMSS",
-	.target		= ipt_tcpmss_target,
-	.checkentry	= ipt_tcpmss_checkentry,
-	.me		= THIS_MODULE,
-};
-
-static int __init init(void)
-{
-	return ipt_register_target(&ipt_tcpmss_reg);
-}
-
-static void __exit fini(void)
-{
-	ipt_unregister_target(&ipt_tcpmss_reg);
-}
-
-module_init(init);
-module_exit(fini);
diff -rupN linux-2.6.10p/net/ipv4/netfilter/ipt_tcpmss.c.orig linux-2.6.10/net/ipv4/netfilter/ipt_tcpmss.c.orig
--- linux-2.6.10p/net/ipv4/netfilter/ipt_tcpmss.c.orig	2005-02-25 15:53:05.156250000 +0000
+++ linux-2.6.10/net/ipv4/netfilter/ipt_tcpmss.c.orig	1970-01-01 00:00:00.000000000 +0000
@@ -1,262 +0,0 @@
-/*
- * This is a module which is used for setting the MSS option in TCP packets.
- *
- * Copyright (C) 2000 Marc Boucher <marc@mbsi.ca>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/skbuff.h>
-
-#include <linux/ip.h>
-#include <net/tcp.h>
-
-#include <linux/netfilter_ipv4/ip_tables.h>
-#include <linux/netfilter_ipv4/ipt_TCPMSS.h>
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Marc Boucher <marc@mbsi.ca>");
-MODULE_DESCRIPTION("iptables TCP MSS modification module");
-
-#if 0
-#define DEBUGP printk
-#else
-#define DEBUGP(format, args...)
-#endif
-
-static u_int16_t
-cheat_check(u_int32_t oldvalinv, u_int32_t newval, u_int16_t oldcheck)
-{
-	u_int32_t diffs[] = { oldvalinv, newval };
-	return csum_fold(csum_partial((char *)diffs, sizeof(diffs),
-                                      oldcheck^0xFFFF));
-}
-
-static inline unsigned int
-optlen(const u_int8_t *opt, unsigned int offset)
-{
-	/* Beware zero-length options: make finite progress */
-	if (opt[offset] <= TCPOPT_NOP || opt[offset+1] == 0) return 1;
-	else return opt[offset+1];
-}
-
-static unsigned int
-ipt_tcpmss_target(struct sk_buff **pskb,
-		  const struct net_device *in,
-		  const struct net_device *out,
-		  unsigned int hooknum,
-		  const void *targinfo,
-		  void *userinfo)
-{
-	const struct ipt_tcpmss_info *tcpmssinfo = targinfo;
-	struct tcphdr *tcph;
-	struct iphdr *iph;
-	u_int16_t tcplen, newtotlen, oldval, newmss;
-	unsigned int i;
-	u_int8_t *opt;
-
-	if (!skb_ip_make_writable(pskb, (*pskb)->len))
-		return NF_DROP;
-
-	iph = (*pskb)->nh.iph;
-	tcplen = (*pskb)->len - iph->ihl*4;
-
-	tcph = (void *)iph + iph->ihl*4;
-
-	/* Since it passed flags test in tcp match, we know it is is
-	   not a fragment, and has data >= tcp header length.  SYN
-	   packets should not contain data: if they did, then we risk
-	   running over MTU, sending Frag Needed and breaking things
-	   badly. --RR */
-	if (tcplen != tcph->doff*4) {
-		if (net_ratelimit())
-			printk(KERN_ERR
-			       "ipt_tcpmss_target: bad length (%d bytes)\n",
-			       (*pskb)->len);
-		return NF_DROP;
-	}
-
-	if(tcpmssinfo->mss == IPT_TCPMSS_CLAMP_PMTU) {
-		if(!(*pskb)->dst) {
-			if (net_ratelimit())
-				printk(KERN_ERR
-			       		"ipt_tcpmss_target: no dst?! can't determine path-MTU\n");
-			return NF_DROP; /* or IPT_CONTINUE ?? */
-		}
-
-		if(dst_pmtu((*pskb)->dst) <= (sizeof(struct iphdr) + sizeof(struct tcphdr))) {
-			if (net_ratelimit())
-				printk(KERN_ERR
-		       			"ipt_tcpmss_target: unknown or invalid path-MTU (%d)\n", dst_pmtu((*pskb)->dst));
-			return NF_DROP; /* or IPT_CONTINUE ?? */
-		}
-
-		newmss = dst_pmtu((*pskb)->dst) - sizeof(struct iphdr) - sizeof(struct tcphdr);
-	} else
-		newmss = tcpmssinfo->mss;
-
- 	opt = (u_int8_t *)tcph;
-	for (i = sizeof(struct tcphdr); i < tcph->doff*4; i += optlen(opt, i)){
-		if ((opt[i] == TCPOPT_MSS) &&
-		    ((tcph->doff*4 - i) >= TCPOLEN_MSS) &&
-		    (opt[i+1] == TCPOLEN_MSS)) {
-			u_int16_t oldmss;
-
-			oldmss = (opt[i+2] << 8) | opt[i+3];
-
-			if((tcpmssinfo->mss == IPT_TCPMSS_CLAMP_PMTU) &&
-				(oldmss <= newmss))
-					return IPT_CONTINUE;
-
-			opt[i+2] = (newmss & 0xff00) >> 8;
-			opt[i+3] = (newmss & 0x00ff);
-
-			tcph->check = cheat_check(htons(oldmss)^0xFFFF,
-						  htons(newmss),
-						  tcph->check);
-
-			DEBUGP(KERN_INFO "ipt_tcpmss_target: %u.%u.%u.%u:%hu"
-			       "->%u.%u.%u.%u:%hu changed TCP MSS option"
-			       " (from %u to %u)\n", 
-			       NIPQUAD((*pskb)->nh.iph->saddr),
-			       ntohs(tcph->source),
-			       NIPQUAD((*pskb)->nh.iph->daddr),
-			       ntohs(tcph->dest),
-			       oldmss, newmss);
-			goto retmodified;
-		}
-	}
-
-	/*
-	 * MSS Option not found ?! add it..
-	 */
-	if (skb_tailroom((*pskb)) < TCPOLEN_MSS) {
-		struct sk_buff *newskb;
-
-		newskb = skb_copy_expand(*pskb, skb_headroom(*pskb),
-					 TCPOLEN_MSS, GFP_ATOMIC);
-		if (!newskb) {
-			if (net_ratelimit())
-				printk(KERN_ERR "ipt_tcpmss_target:"
-				       " unable to allocate larger skb\n");
-			return NF_DROP;
-		}
-
-		kfree_skb(*pskb);
-		*pskb = newskb;
-		iph = (*pskb)->nh.iph;
-		tcph = (void *)iph + iph->ihl*4;
-	}
-
-	skb_put((*pskb), TCPOLEN_MSS);
-
- 	opt = (u_int8_t *)tcph + sizeof(struct tcphdr);
-	memmove(opt + TCPOLEN_MSS, opt, tcplen - sizeof(struct tcphdr));
-
-	tcph->check = cheat_check(htons(tcplen) ^ 0xFFFF,
-				  htons(tcplen + TCPOLEN_MSS), tcph->check);
-	tcplen += TCPOLEN_MSS;
-
-	opt[0] = TCPOPT_MSS;
-	opt[1] = TCPOLEN_MSS;
-	opt[2] = (newmss & 0xff00) >> 8;
-	opt[3] = (newmss & 0x00ff);
-
-	tcph->check = cheat_check(~0, *((u_int32_t *)opt), tcph->check);
-
-	oldval = ((u_int16_t *)tcph)[6];
-	tcph->doff += TCPOLEN_MSS/4;
-	tcph->check = cheat_check(oldval ^ 0xFFFF,
-				  ((u_int16_t *)tcph)[6], tcph->check);
-
-	newtotlen = htons(ntohs(iph->tot_len) + TCPOLEN_MSS);
-	iph->check = cheat_check(iph->tot_len ^ 0xFFFF,
-				 newtotlen, iph->check);
-	iph->tot_len = newtotlen;
-
-	DEBUGP(KERN_INFO "ipt_tcpmss_target: %u.%u.%u.%u:%hu"
-	       "->%u.%u.%u.%u:%hu added TCP MSS option (%u)\n",
-	       NIPQUAD((*pskb)->nh.iph->saddr),
-	       ntohs(tcph->source),
-	       NIPQUAD((*pskb)->nh.iph->daddr),
-	       ntohs(tcph->dest),
-	       newmss);
-
- retmodified:
-	/* We never hw checksum SYN packets.  */
-	BUG_ON((*pskb)->ip_summed == CHECKSUM_HW);
-
-	(*pskb)->nfcache |= NFC_UNKNOWN | NFC_ALTERED;
-	return IPT_CONTINUE;
-}
-
-#define TH_SYN 0x02
-
-static inline int find_syn_match(const struct ipt_entry_match *m)
-{
-	const struct ipt_tcp *tcpinfo = (const struct ipt_tcp *)m->data;
-
-	if (strcmp(m->u.kernel.match->name, "tcp") == 0
-	    && (tcpinfo->flg_cmp & TH_SYN)
-	    && !(tcpinfo->invflags & IPT_TCP_INV_FLAGS))
-		return 1;
-
-	return 0;
-}
-
-/* Must specify -p tcp --syn/--tcp-flags SYN */
-static int
-ipt_tcpmss_checkentry(const char *tablename,
-		      const struct ipt_entry *e,
-		      void *targinfo,
-		      unsigned int targinfosize,
-		      unsigned int hook_mask)
-{
-	const struct ipt_tcpmss_info *tcpmssinfo = targinfo;
-
-	if (targinfosize != IPT_ALIGN(sizeof(struct ipt_tcpmss_info))) {
-		DEBUGP("ipt_tcpmss_checkentry: targinfosize %u != %u\n",
-		       targinfosize, IPT_ALIGN(sizeof(struct ipt_tcpmss_info)));
-		return 0;
-	}
-
-
-	if((tcpmssinfo->mss == IPT_TCPMSS_CLAMP_PMTU) && 
-			((hook_mask & ~((1 << NF_IP_FORWARD)
-			   	| (1 << NF_IP_LOCAL_OUT)
-			   	| (1 << NF_IP_POST_ROUTING))) != 0)) {
-		printk("TCPMSS: path-MTU clamping only supported in FORWARD, OUTPUT and POSTROUTING hooks\n");
-		return 0;
-	}
-
-	if (e->ip.proto == IPPROTO_TCP
-	    && !(e->ip.invflags & IPT_INV_PROTO)
-	    && IPT_MATCH_ITERATE(e, find_syn_match))
-		return 1;
-
-	printk("TCPMSS: Only works on TCP SYN packets\n");
-	return 0;
-}
-
-static struct ipt_target ipt_tcpmss_reg = {
-	.name		= "TCPMSS",
-	.target		= ipt_tcpmss_target,
-	.checkentry	= ipt_tcpmss_checkentry,
-	.me		= THIS_MODULE,
-};
-
-static int __init init(void)
-{
-	return ipt_register_target(&ipt_tcpmss_reg);
-}
-
-static void __exit fini(void)
-{
-	ipt_unregister_target(&ipt_tcpmss_reg);
-}
-
-module_init(init);
-module_exit(fini);
diff -rupN linux-2.6.10p/net/ipv4/netfilter/ipt_tcpmss.c.rej linux-2.6.10/net/ipv4/netfilter/ipt_tcpmss.c.rej
--- linux-2.6.10p/net/ipv4/netfilter/ipt_tcpmss.c.rej	2005-02-25 16:06:02.078125000 +0000
+++ linux-2.6.10/net/ipv4/netfilter/ipt_tcpmss.c.rej	1970-01-01 00:00:00.000000000 +0000
@@ -1,27 +0,0 @@
-***************
-*** 87,104 ****
-  			       info->invert, hotdrop);
-  }
-  
-- static inline int find_syn_match(const struct ipt_entry_match *m)
-- {
-- 	const struct ipt_tcp *tcpinfo = (const struct ipt_tcp *)m->data;
-- 
-- 	if (strcmp(m->u.kernel.match->name, "tcp") == 0
-- 	    && (tcpinfo->flg_cmp & TH_SYN)
-- 	    && !(tcpinfo->invflags & IPT_TCP_INV_FLAGS))
-- 		return 1;
-- 
-- 	return 0;
-- }
-- 
-  static int
-  checkentry(const char *tablename,
-             const struct ipt_ip *ip,
---- 87,92 ----
-  			       info->invert, hotdrop);
-  }
-  
-  static int
-  checkentry(const char *tablename,
-             const struct ipt_ip *ip,
diff -rupN linux-2.6.10p/net/ipv6/netfilter/ip6t_MARK.c.orig linux-2.6.10/net/ipv6/netfilter/ip6t_MARK.c.orig
--- linux-2.6.10p/net/ipv6/netfilter/ip6t_MARK.c.orig	2004-08-14 11:56:25.000000000 +0100
+++ linux-2.6.10/net/ipv6/netfilter/ip6t_MARK.c.orig	1970-01-01 00:00:00.000000000 +0000
@@ -1,67 +0,0 @@
-/* Kernel module to match NFMARK values. */
-
-/* (C) 1999-2001 Marc Boucher <marc@mbsi.ca>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-
-#include <linux/module.h>
-#include <linux/skbuff.h>
-
-#include <linux/netfilter_ipv6/ip6t_mark.h>
-#include <linux/netfilter_ipv6/ip6_tables.h>
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
-MODULE_DESCRIPTION("ip6tables mark match");
-
-static int
-match(const struct sk_buff *skb,
-      const struct net_device *in,
-      const struct net_device *out,
-      const void *matchinfo,
-      int offset,
-      const void *hdr,
-      u_int16_t datalen,
-      int *hotdrop)
-{
-	const struct ip6t_mark_info *info = matchinfo;
-
-	return ((skb->nfmark & info->mask) == info->mark) ^ info->invert;
-}
-
-static int
-checkentry(const char *tablename,
-           const struct ip6t_ip6 *ip,
-           void *matchinfo,
-           unsigned int matchsize,
-           unsigned int hook_mask)
-{
-	if (matchsize != IP6T_ALIGN(sizeof(struct ip6t_mark_info)))
-		return 0;
-
-	return 1;
-}
-
-static struct ip6t_match mark_match = {
-	.name		= "mark",
-	.match		= &match,
-	.checkentry	= &checkentry,
-	.me		= THIS_MODULE,
-};
-
-static int __init init(void)
-{
-	return ip6t_register_match(&mark_match);
-}
-
-static void __exit fini(void)
-{
-	ip6t_unregister_match(&mark_match);
-}
-
-module_init(init);
-module_exit(fini);
diff -rupN linux-2.6.10p/net/ipv6/netfilter/ip6t_MARK.c.rej linux-2.6.10/net/ipv6/netfilter/ip6t_MARK.c.rej
--- linux-2.6.10p/net/ipv6/netfilter/ip6t_MARK.c.rej	2005-02-25 16:06:04.781250000 +0000
+++ linux-2.6.10/net/ipv6/netfilter/ip6t_MARK.c.rej	1970-01-01 00:00:00.000000000 +0000
@@ -1,21 +0,0 @@
-***************
-*** 20,28 ****
-  
-  static unsigned int
-  target(struct sk_buff **pskb,
--        unsigned int hooknum,
-         const struct net_device *in,
-         const struct net_device *out,
-         const void *targinfo,
-         void *userinfo)
-  {
---- 20,28 ----
-  
-  static unsigned int
-  target(struct sk_buff **pskb,
-         const struct net_device *in,
-         const struct net_device *out,
-+        unsigned int hooknum,
-         const void *targinfo,
-         void *userinfo)
-  {
------------------------------------------------------------------------
Regards
	Mark Fortescue.

