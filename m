Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277782AbRKMSAd>; Tue, 13 Nov 2001 13:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277738AbRKMSAY>; Tue, 13 Nov 2001 13:00:24 -0500
Received: from CPE-61-9-149-179.vic.bigpond.net.au ([61.9.149.179]:13577 "EHLO
	front.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S277722AbRKMSAL>; Tue, 13 Nov 2001 13:00:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        netfilter-devel@lists.samba.org
Subject: Re: Fw: Networking: repeatable oops in 2.4.15-pre2 
In-Reply-To: Your message of "Tue, 13 Nov 2001 18:25:45 +0300."
             <200111131525.SAA29471@ms2.inr.ac.ru> 
Date: Wed, 14 Nov 2001 03:00:27 +1100
Message-Id: <E163fz9-0006c6-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200111131525.SAA29471@ms2.inr.ac.ru> you write:
> But if a hook changes _data_ (f.e. ftp packets), it can break original
> packet sitting in tcp queue and this is fatal. So, when mangling
> data, packet must be always copied. When mangling header, no copy
> is required.

ACK!  Then it will have to set skb->sk, or else ip_queue_xmit2 will
break on orphaned, copied packet.

OK, this covers that case, too (ftp and IRC), and fixes the skb leak
in the last patch.

Thanks!
Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14-official/net/ipv4/netfilter/ip_fw_compat.c working-2.4.14-nfunshare/net/ipv4/netfilter/ip_fw_compat.c
--- linux-2.4.14-official/net/ipv4/netfilter/ip_fw_compat.c	Sat Apr 28 07:15:01 2001
+++ working-2.4.14-nfunshare/net/ipv4/netfilter/ip_fw_compat.c	Wed Nov 14 02:53:03 2001
@@ -84,6 +84,16 @@
 	if ((*pskb)->ip_summed == CHECKSUM_HW)
 		(*pskb)->ip_summed = CHECKSUM_NONE;
 
+	/* Firewall rules can alter TOS: raw socket (tcpdump) may have
+           clone of incoming skb: don't disturb it --RR */
+	if (skb_cloned(*pskb) && !(*pskb)->sk) {
+		struct sk_buff *nskb = skb_copy(*pskb, GFP_ATOMIC);
+		if (!nskb)
+			return NF_DROP;
+		kfree_skb(*pskb);
+		*pskb = nskb;
+	}
+
 	switch (hooknum) {
 	case NF_IP_PRE_ROUTING:
 		if (fwops->fw_acct_in)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14-official/net/ipv4/netfilter/ip_nat_core.c working-2.4.14-nfunshare/net/ipv4/netfilter/ip_nat_core.c
--- linux-2.4.14-official/net/ipv4/netfilter/ip_nat_core.c	Thu May 17 03:31:27 2001
+++ working-2.4.14-nfunshare/net/ipv4/netfilter/ip_nat_core.c	Wed Nov 14 02:21:14 2001
@@ -734,6 +734,18 @@
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
+			kfree_skb(*pskb);
+			*pskb = nskb;
+		}
+
 		if (info->manips[i].direction == dir
 		    && info->manips[i].hooknum == hooknum) {
 			DEBUGP("Mangling %p: %s to %u.%u.%u.%u %u\n",
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14-official/net/ipv4/netfilter/ip_nat_helper.c working-2.4.14-nfunshare/net/ipv4/netfilter/ip_nat_helper.c
--- linux-2.4.14-official/net/ipv4/netfilter/ip_nat_helper.c	Wed Aug 29 00:09:44 2001
+++ working-2.4.14-nfunshare/net/ipv4/netfilter/ip_nat_helper.c	Wed Nov 14 02:46:26 2001
@@ -143,6 +143,23 @@
 		}
 	}
 
+	/* Alexey says: if a hook changes _data_ ... it can break
+	   original packet sitting in tcp queue and this is fatal */
+	if (skb_cloned(*skb)) {
+		struct sk_buff *nskb = skb_copy(*skb, GFP_ATOMIC);
+		if (!nskb) {
+			if (net_ratelimit())
+				printk("Out of memory cloning TCP packet\n");
+			return 0;
+		}
+		/* Rest of kernel will get very unhappy if we pass it
+		   a suddenly-orphaned skbuff */
+		if ((*skb)->sk)
+			skb_set_owner_w(nskb, (*skb)->sk);
+		kfree_skb(*skb);
+		*skb = nskb;
+	}
+
 	/* skb may be copied !! */
 	iph = (*skb)->nh.iph;
 	tcph = (void *)iph + iph->ihl*4;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14-official/net/ipv4/netfilter/ipt_TCPMSS.c working-2.4.14-nfunshare/net/ipv4/netfilter/ipt_TCPMSS.c
--- linux-2.4.14-official/net/ipv4/netfilter/ipt_TCPMSS.c	Mon Oct  1 05:26:08 2001
+++ working-2.4.14-nfunshare/net/ipv4/netfilter/ipt_TCPMSS.c	Wed Nov 14 02:49:46 2001
@@ -44,11 +44,22 @@
 {
 	const struct ipt_tcpmss_info *tcpmssinfo = targinfo;
 	struct tcphdr *tcph;
-	struct iphdr *iph = (*pskb)->nh.iph;
+	struct iphdr *iph;
 	u_int16_t tcplen, newtotlen, oldval, newmss;
 	unsigned int i;
 	u_int8_t *opt;
 
+	/* raw socket (tcpdump) may have clone of incoming skb: don't
+	   disturb it --RR */
+	if (skb_cloned(*pskb) && !(*pskb)->sk) {
+		struct sk_buff *nskb = skb_copy(*pskb, GFP_ATOMIC);
+		if (!nskb)
+			return NF_DROP;
+		kfree_skb(*pskb);
+		*pskb = nskb;
+	}
+
+	iph = (*pskb)->nh.iph;
 	tcplen = (*pskb)->len - iph->ihl*4;
 
 	tcph = (void *)iph + iph->ihl*4;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14-official/net/ipv4/netfilter/ipt_TOS.c working-2.4.14-nfunshare/net/ipv4/netfilter/ipt_TOS.c
--- linux-2.4.14-official/net/ipv4/netfilter/ipt_TOS.c	Mon Oct  1 05:26:08 2001
+++ working-2.4.14-nfunshare/net/ipv4/netfilter/ipt_TOS.c	Wed Nov 14 02:49:37 2001
@@ -21,6 +21,17 @@
 	if ((iph->tos & IPTOS_TOS_MASK) != tosinfo->tos) {
 		u_int16_t diffs[2];
 
+		/* raw socket (tcpdump) may have clone of incoming
+                   skb: don't disturb it --RR */
+		if (skb_cloned(*pskb) && !(*pskb)->sk) {
+			struct sk_buff *nskb = skb_copy(*pskb, GFP_ATOMIC);
+			if (!nskb)
+				return NF_DROP;
+			*pskb = nskb;
+			kfree_skb(*pskb);
+			iph = (*pskb)->nh.iph;
+		}
+
 		diffs[0] = htons(iph->tos) ^ 0xFFFF;
 		iph->tos = (iph->tos & IPTOS_PREC_MASK) | tosinfo->tos;
 		diffs[1] = htons(iph->tos);
