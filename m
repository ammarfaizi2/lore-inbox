Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281603AbRKMLSx>; Tue, 13 Nov 2001 06:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281598AbRKMLSo>; Tue, 13 Nov 2001 06:18:44 -0500
Received: from [202.135.142.195] ([202.135.142.195]:22035 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S281511AbRKMLS1>; Tue, 13 Nov 2001 06:18:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com (David S. Miller), rusty@rustcorp.com.au,
        linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: Re: Fw: Networking: repeatable oops in 2.4.15-pre2 
In-Reply-To: Your message of "Sat, 10 Nov 2001 21:57:39 +0300."
             <200111101857.VAA17220@ms2.inr.ac.ru> 
Date: Tue, 13 Nov 2001 20:18:38 +1100
Message-Id: <E163ZiI-0001CR-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200111101857.VAA17220@ms2.inr.ac.ru> you write:
> A. Paul, look into your own code doing the same thing which you wrote before.
>    Seems, you have lost the skill of copying skbs owned by sockets.

Argh... that explains the crashes, of course.  You have a good memory!

> Actually, skbs owned by sockets should not be copied at all, if
> mangle does not involve change of data.

The NAT code is special: it will always mangle packet the same way, so
it doesn't *REALLY* matter if we mangle the original packet for local
output (if we change IP headers in different ways for retransmission
of the same packet, we would have much bigger problems).

> B. It is very strange that a copy happened in local output path.
>    The problem which was supposed to be cured by this was at input.

My solution was too generic: *any* cloned skb was copied.  Repairing
is simple.

Does this work for everyone?  Particularly while running tcpdump?
Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.14-official/net/ipv4/netfilter/ip_fw_compat.c working-2.4.13-uml-proc/net/ipv4/netfilter/ip_fw_compat.c
--- linux-2.4.14-official/net/ipv4/netfilter/ip_fw_compat.c	Sun Apr 29 06:17:11 2001
+++ working-2.4.13-uml-proc/net/ipv4/netfilter/ip_fw_compat.c	Tue Nov 13 20:58:33 2001
@@ -78,11 +78,21 @@
 {
 	int ret = FW_BLOCK;
 	u_int16_t redirpt;
+	struct sk_buff *nskb;
 
 	/* Assume worse case: any hook could change packet */
 	(*pskb)->nfcache |= NFC_UNKNOWN | NFC_ALTERED;
 	if ((*pskb)->ip_summed == CHECKSUM_HW)
 		(*pskb)->ip_summed = CHECKSUM_NONE;
+
+	/* Firewall rules can alter TOS: raw socket (tcpdump) may have
+           clone of incoming skb: don't disturb it --RR */
+	if (skb_cloned(*pskb) && !(*pskb)->sk) {
+		struct sk_buff *nskb = skb_copy(*pskb, GFP_ATOMIC);
+		if (!nskb)
+			return NF_DROP;
+		*pskb = nskb;
+	}
 
 	switch (hooknum) {
 	case NF_IP_PRE_ROUTING:
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.14-official/net/ipv4/netfilter/ip_nat_core.c working-2.4.13-uml-proc/net/ipv4/netfilter/ip_nat_core.c
--- linux-2.4.14-official/net/ipv4/netfilter/ip_nat_core.c	Mon May 28 12:43:00 2001
+++ working-2.4.13-uml-proc/net/ipv4/netfilter/ip_nat_core.c	Tue Nov 13 20:57:56 2001
@@ -734,6 +734,17 @@
 	   synchronize_bh()) can vanish. */
 	READ_LOCK(&ip_nat_lock);
 	for (i = 0; i < info->num_manips; i++) {
+		/* raw socket (tcpdump) may have clone of incoming
+                   skb: don't disturb it --RR */
+		if (skb_cloned(*pskb) && !(*pskb)->sk) {
+			struct sk_buff *nskb = skb_copy(*pskb, GFP_ATOMIC);
+			if (!nskb) {
+				READ_UNLOCK(&ip_nat_lock);
+				return NF_DROP;
+			}
+			*pskb = nskb;
+		}
+
 		if (info->manips[i].direction == dir
 		    && info->manips[i].hooknum == hooknum) {
 			DEBUGP("Mangling %p: %s to %u.%u.%u.%u %u\n",
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.14-official/net/ipv4/netfilter/ipt_TCPMSS.c working-2.4.13-uml-proc/net/ipv4/netfilter/ipt_TCPMSS.c
--- linux-2.4.14-official/net/ipv4/netfilter/ipt_TCPMSS.c	Thu Oct 25 11:29:50 2001
+++ working-2.4.13-uml-proc/net/ipv4/netfilter/ipt_TCPMSS.c	Tue Nov 13 20:59:42 2001
@@ -44,11 +44,22 @@
 {
 	const struct ipt_tcpmss_info *tcpmssinfo = targinfo;
 	struct tcphdr *tcph;
-	struct iphdr *iph = (*pskb)->nh.iph;
+	struct iphdr *iph;
 	u_int16_t tcplen, newtotlen, oldval, newmss;
 	unsigned int i;
 	u_int8_t *opt;
+	struct sk_buff *nskb;
 
+	/* raw socket (tcpdump) may have clone of incoming skb: don't
+	   disturb it --RR */
+	if (skb_cloned(*pskb) && !(*pskb)->sk) {
+		struct sk_buff *nskb = skb_copy(*pskb, GFP_ATOMIC);
+		if (!nskb)
+			return NF_DROP;
+		*pskb = nskb;
+	}
+
+	iph = (*pskb)->nh.iph;
 	tcplen = (*pskb)->len - iph->ihl*4;
 
 	tcph = (void *)iph + iph->ihl*4;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.14-official/net/ipv4/netfilter/ipt_TOS.c working-2.4.13-uml-proc/net/ipv4/netfilter/ipt_TOS.c
--- linux-2.4.14-official/net/ipv4/netfilter/ipt_TOS.c	Thu Oct 25 11:29:50 2001
+++ working-2.4.13-uml-proc/net/ipv4/netfilter/ipt_TOS.c	Tue Nov 13 21:02:20 2001
@@ -19,7 +19,18 @@
 	const struct ipt_tos_target_info *tosinfo = targinfo;
 
 	if ((iph->tos & IPTOS_TOS_MASK) != tosinfo->tos) {
+		struct sk_buff *nskb;
 		u_int16_t diffs[2];
+
+		/* raw socket (tcpdump) may have clone of incoming
+                   skb: don't disturb it --RR */
+		if (skb_cloned(*pskb) && !(*pskb)->sk) {
+			struct sk_buff *nskb = skb_copy(*pskb, GFP_ATOMIC);
+			if (!nskb)
+				return NF_DROP;
+			*pskb = nskb;
+			iph = (*pskb)->nh.iph;
+		}
 
 		diffs[0] = htons(iph->tos) ^ 0xFFFF;
 		iph->tos = (iph->tos & IPTOS_PREC_MASK) | tosinfo->tos;
