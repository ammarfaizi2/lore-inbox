Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280089AbRJaGYt>; Wed, 31 Oct 2001 01:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280087AbRJaGYj>; Wed, 31 Oct 2001 01:24:39 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:32780 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S280089AbRJaGY1>; Wed, 31 Oct 2001 01:24:27 -0500
Date: Wed, 31 Oct 2001 17:28:35 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: fokkensr@linux06.vertis.nl, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: iptables and tcpdump
Message-Id: <20011031172835.4f0c0ed2.rusty@rustcorp.com.au>
In-Reply-To: <20011029.213157.39157336.davem@redhat.com>
In-Reply-To: <01102817104101.01788@home01>
	<20011030152812.2e9ba8ee.rusty@rustcorp.com.au>
	<20011029.213157.39157336.davem@redhat.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001 21:31:57 -0800 (PST)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Tue, 30 Oct 2001 15:28:12 +1100
>    
>    should the NAT layer be doing skb_unshare() before altering the packet?
> 
> I think it should.

Agreed.  The 2.2 masq code didn't do this, and hence the "don't tcpdump on masq host"
recommendation.

Please try this patch (compiles at least),
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-official/net/ipv4/netfilter/ip_fw_compat.c working-2.4.13-nfunshare/net/ipv4/netfilter/ip_fw_compat.c
--- linux-2.4.13-official/net/ipv4/netfilter/ip_fw_compat.c	Sat Apr 28 07:15:01 2001
+++ working-2.4.13-nfunshare/net/ipv4/netfilter/ip_fw_compat.c	Wed Oct 31 17:05:53 2001
@@ -78,11 +78,19 @@
 {
 	int ret = FW_BLOCK;
 	u_int16_t redirpt;
+	struct sk_buff *nskb;
 
 	/* Assume worse case: any hook could change packet */
 	(*pskb)->nfcache |= NFC_UNKNOWN | NFC_ALTERED;
 	if ((*pskb)->ip_summed == CHECKSUM_HW)
 		(*pskb)->ip_summed = CHECKSUM_NONE;
+
+	/* Firewall rules can alter TOS: raw socket may have clone of
+           skb: don't disturb it --RR */
+	nskb = skb_unshare(*pskb, GFP_ATOMIC);
+	if (!nskb)
+		return NF_DROP;
+	*pskb = nskb;
 
 	switch (hooknum) {
 	case NF_IP_PRE_ROUTING:
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-official/net/ipv4/netfilter/ip_nat_core.c working-2.4.13-nfunshare/net/ipv4/netfilter/ip_nat_core.c
--- linux-2.4.13-official/net/ipv4/netfilter/ip_nat_core.c	Thu May 17 03:31:27 2001
+++ working-2.4.13-nfunshare/net/ipv4/netfilter/ip_nat_core.c	Wed Oct 31 16:52:06 2001
@@ -734,6 +734,15 @@
 	   synchronize_bh()) can vanish. */
 	READ_LOCK(&ip_nat_lock);
 	for (i = 0; i < info->num_manips; i++) {
+		struct sk_buff *nskb;
+		/* raw socket may have clone of skb: don't disturb it --RR */
+		nskb = skb_unshare(*pskb, GFP_ATOMIC);
+		if (!nskb) {
+			READ_UNLOCK(&ip_nat_lock);
+			return NF_DROP;
+		}
+		*pskb = nskb;
+
 		if (info->manips[i].direction == dir
 		    && info->manips[i].hooknum == hooknum) {
 			DEBUGP("Mangling %p: %s to %u.%u.%u.%u %u\n",
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-official/net/ipv4/netfilter/ipt_TCPMSS.c working-2.4.13-nfunshare/net/ipv4/netfilter/ipt_TCPMSS.c
--- linux-2.4.13-official/net/ipv4/netfilter/ipt_TCPMSS.c	Mon Oct  1 05:26:08 2001
+++ working-2.4.13-nfunshare/net/ipv4/netfilter/ipt_TCPMSS.c	Wed Oct 31 17:00:42 2001
@@ -48,6 +48,13 @@
 	u_int16_t tcplen, newtotlen, oldval, newmss;
 	unsigned int i;
 	u_int8_t *opt;
+	struct sk_buff *nskb;
+
+	/* raw socket may have clone of skb: don't disturb it --RR */
+	nskb = skb_unshare(*pskb, GFP_ATOMIC);
+	if (!nskb)
+		return NF_DROP;
+	*pskb = nskb;
 
 	tcplen = (*pskb)->len - iph->ihl*4;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.13-official/net/ipv4/netfilter/ipt_TOS.c working-2.4.13-nfunshare/net/ipv4/netfilter/ipt_TOS.c
--- linux-2.4.13-official/net/ipv4/netfilter/ipt_TOS.c	Mon Oct  1 05:26:08 2001
+++ working-2.4.13-nfunshare/net/ipv4/netfilter/ipt_TOS.c	Wed Oct 31 17:03:11 2001
@@ -19,7 +19,14 @@
 	const struct ipt_tos_target_info *tosinfo = targinfo;
 
 	if ((iph->tos & IPTOS_TOS_MASK) != tosinfo->tos) {
+		struct sk_buff *nskb;
 		u_int16_t diffs[2];
+
+		/* raw socket may have clone of skb: don't disturb it --RR */
+		nskb = skb_unshare(*pskb, GFP_ATOMIC);
+		if (!nskb)
+			return NF_DROP;
+		*pskb = nskb;
 
 		diffs[0] = htons(iph->tos) ^ 0xFFFF;
 		iph->tos = (iph->tos & IPTOS_PREC_MASK) | tosinfo->tos;
