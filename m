Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVEONaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVEONaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 09:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEON34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 09:29:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25617 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261524AbVEON3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 09:29:11 -0400
Date: Sun, 15 May 2005 15:29:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Julian Anastasov <ja@ssi.bg>
Cc: Wensong Zhang <wensong@LinuxVirtualServer.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove net/ipv4/ipvs/ip_vs_proto_icmp.c?
Message-ID: <20050515132906.GW16549@stusta.de>
References: <20050513041622.GE3603@stusta.de> <Pine.LNX.4.58.0505141013520.1568@u.domain.uli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505141013520.1568@u.domain.uli>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 10:17:53AM +0300, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Fri, 13 May 2005, Adrian Bunk wrote:
> 
> > Will it be made working in the forseeable future or is it a candidate
> > for removal?
> 
> 	IMO, it can be removed as it was never finished. We can always
> add it later.

Thanks for the confirmation.

A patch to remove it is below.

> Regards
> Julian Anastasov <ja@ssi.bg>

cu
Adrian


<--  snip  -->


ip_vs_proto_icmp.c was never finished.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ipv4/ipvs/Makefile           |    2 
 net/ipv4/ipvs/ip_vs_proto.c      |    3 
 net/ipv4/ipvs/ip_vs_proto_icmp.c |  182 -------------------------------
 3 files changed, 1 insertion(+), 186 deletions(-)

--- linux-2.6.12-rc4-mm1-full/net/ipv4/ipvs/Makefile.old	2005-05-15 13:14:02.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/net/ipv4/ipvs/Makefile	2005-05-15 13:14:17.000000000 +0200
@@ -11,7 +11,7 @@
 
 ip_vs-objs :=	ip_vs_conn.o ip_vs_core.o ip_vs_ctl.o ip_vs_sched.o	   \
 		ip_vs_xmit.o ip_vs_app.o ip_vs_sync.o	   		   \
-		ip_vs_est.o ip_vs_proto.o ip_vs_proto_icmp.o		   \
+		ip_vs_est.o ip_vs_proto.o 				   \
 		$(ip_vs_proto-objs-y)
 
 
--- linux-2.6.12-rc4-mm1-full/net/ipv4/ipvs/ip_vs_proto.c.old	2005-05-15 13:18:55.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/net/ipv4/ipvs/ip_vs_proto.c	2005-05-15 13:15:03.000000000 +0200
@@ -216,9 +216,6 @@
 #ifdef CONFIG_IP_VS_PROTO_UDP
 	REGISTER_PROTOCOL(&ip_vs_protocol_udp);
 #endif
-#ifdef CONFIG_IP_VS_PROTO_ICMP
-	REGISTER_PROTOCOL(&ip_vs_protocol_icmp);
-#endif
 #ifdef CONFIG_IP_VS_PROTO_AH
 	REGISTER_PROTOCOL(&ip_vs_protocol_ah);
 #endif
--- linux-2.6.12-rc4-mm1-full/net/ipv4/ipvs/ip_vs_proto_icmp.c	2005-03-02 08:37:31.000000000 +0100
+++ /dev/null	2005-04-28 03:52:17.000000000 +0200
@@ -1,182 +0,0 @@
-/*
- * ip_vs_proto_icmp.c:	ICMP load balancing support for IP Virtual Server
- *
- * Authors:	Julian Anastasov <ja@ssi.bg>, March 2002
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		version 2 as published by the Free Software Foundation;
- *
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/icmp.h>
-#include <linux/netfilter.h>
-#include <linux/netfilter_ipv4.h>
-
-#include <net/ip_vs.h>
-
-
-static int icmp_timeouts[1] =		{ 1*60*HZ };
-
-static char * icmp_state_name_table[1] = { "ICMP" };
-
-static struct ip_vs_conn *
-icmp_conn_in_get(const struct sk_buff *skb,
-		 struct ip_vs_protocol *pp,
-		 const struct iphdr *iph,
-		 unsigned int proto_off,
-		 int inverse)
-{
-#if 0
-	struct ip_vs_conn *cp;
-
-	if (likely(!inverse)) {
-		cp = ip_vs_conn_in_get(iph->protocol,
-			iph->saddr, 0,
-			iph->daddr, 0);
-	} else {
-		cp = ip_vs_conn_in_get(iph->protocol,
-			iph->daddr, 0,
-			iph->saddr, 0);
-	}
-
-	return cp;
-
-#else
-	return NULL;
-#endif
-}
-
-static struct ip_vs_conn *
-icmp_conn_out_get(const struct sk_buff *skb,
-		  struct ip_vs_protocol *pp,
-		  const struct iphdr *iph,
-		  unsigned int proto_off,
-		  int inverse)
-{
-#if 0
-	struct ip_vs_conn *cp;
-
-	if (likely(!inverse)) {
-		cp = ip_vs_conn_out_get(iph->protocol,
-			iph->saddr, 0,
-			iph->daddr, 0);
-	} else {
-		cp = ip_vs_conn_out_get(IPPROTO_UDP,
-			iph->daddr, 0,
-			iph->saddr, 0);
-	}
-
-	return cp;
-#else
-	return NULL;
-#endif
-}
-
-static int
-icmp_conn_schedule(struct sk_buff *skb, struct ip_vs_protocol *pp,
-		   int *verdict, struct ip_vs_conn **cpp)
-{
-	*verdict = NF_ACCEPT;
-	return 0;
-}
-
-static int
-icmp_csum_check(struct sk_buff *skb, struct ip_vs_protocol *pp)
-{
-	if (!(skb->nh.iph->frag_off & __constant_htons(IP_OFFSET))) {
-		if (skb->ip_summed != CHECKSUM_UNNECESSARY) {
-			if (ip_vs_checksum_complete(skb, skb->nh.iph->ihl * 4)) {
-				IP_VS_DBG_RL_PKT(0, pp, skb, 0, "Failed checksum for");
-				return 0;
-			}
-		}
-	}
-	return 1;
-}
-
-static void
-icmp_debug_packet(struct ip_vs_protocol *pp,
-		  const struct sk_buff *skb,
-		  int offset,
-		  const char *msg)
-{
-	char buf[256];
-	struct iphdr _iph, *ih;
-
-	ih = skb_header_pointer(skb, offset, sizeof(_iph), &_iph);
-	if (ih == NULL)
-		sprintf(buf, "%s TRUNCATED", pp->name);
-	else if (ih->frag_off & __constant_htons(IP_OFFSET))
-		sprintf(buf, "%s %u.%u.%u.%u->%u.%u.%u.%u frag",
-			pp->name, NIPQUAD(ih->saddr),
-			NIPQUAD(ih->daddr));
-	else {
-		struct icmphdr _icmph, *ic;
-
-		ic = skb_header_pointer(skb, offset + ih->ihl*4,
-					sizeof(_icmph), &_icmph);
-		if (ic == NULL)
-			sprintf(buf, "%s TRUNCATED to %u bytes\n",
-				pp->name, skb->len - offset);
-		else
-			sprintf(buf, "%s %u.%u.%u.%u->%u.%u.%u.%u T:%d C:%d",
-				pp->name, NIPQUAD(ih->saddr),
-				NIPQUAD(ih->daddr),
-				ic->type, ic->code);
-	}
-	printk(KERN_DEBUG "IPVS: %s: %s\n", msg, buf);
-}
-
-static int
-icmp_state_transition(struct ip_vs_conn *cp, int direction,
-		      const struct sk_buff *skb,
-		      struct ip_vs_protocol *pp)
-{
-	cp->timeout = pp->timeout_table[IP_VS_ICMP_S_NORMAL];
-	return 1;
-}
-
-static int
-icmp_set_state_timeout(struct ip_vs_protocol *pp, char *sname, int to)
-{
-	int num;
-	char **names;
-
-	num = IP_VS_ICMP_S_LAST;
-	names = icmp_state_name_table;
-	return ip_vs_set_state_timeout(pp->timeout_table, num, names, sname, to);
-}
-
-
-static void icmp_init(struct ip_vs_protocol *pp)
-{
-	pp->timeout_table = icmp_timeouts;
-}
-
-static void icmp_exit(struct ip_vs_protocol *pp)
-{
-}
-
-struct ip_vs_protocol ip_vs_protocol_icmp = {
-	.name =			"ICMP",
-	.protocol =		IPPROTO_ICMP,
-	.dont_defrag =		0,
-	.init =			icmp_init,
-	.exit =			icmp_exit,
-	.conn_schedule =	icmp_conn_schedule,
-	.conn_in_get =		icmp_conn_in_get,
-	.conn_out_get =		icmp_conn_out_get,
-	.snat_handler =		NULL,
-	.dnat_handler =		NULL,
-	.csum_check =		icmp_csum_check,
-	.state_transition =	icmp_state_transition,
-	.register_app =		NULL,
-	.unregister_app =	NULL,
-	.app_conn_bind =	NULL,
-	.debug_packet =		icmp_debug_packet,
-	.timeout_change =	NULL,
-	.set_state_timeout =	icmp_set_state_timeout,
-};

