Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280686AbRKJTxq>; Sat, 10 Nov 2001 14:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280685AbRKJTx0>; Sat, 10 Nov 2001 14:53:26 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:6016 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280642AbRKJTxY>;
	Sat, 10 Nov 2001 14:53:24 -0500
Message-ID: <3BED85AC.D646C006@pobox.com>
Date: Sat, 10 Nov 2001 11:53:16 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: matthew@hairy.beasts.org, linux-kernel@vger.kernel.org
Subject: Confirm netfilter: repeatable oops in 2.4.15-pre2
In-Reply-To: <3BECC7F4.A9EF9E6B@pobox.com>
		<Pine.LNX.4.33.0111101148250.20176-100000@sphinx.mythic-beasts.com> <20011110.053116.41632367.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------D622283EB664D139BCF6AD0A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D622283EB664D139BCF6AD0A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Confirmation, backing out the following 4 netfilter
diffs makes 2.4.15-pre2 work fine on my firewall.

cu

jjs



"David S. Miller" wrote:

>    From: Matthew Kirkwood <matthew@hairy.beasts.org>
>    Date: Sat, 10 Nov 2001 11:53:11 +0000 (GMT)
>
>    On Fri, 9 Nov 2001, J Sloan wrote:
>
>    > I have been running the 2.4.15-pre kernels and
>    > have found an interesting oops. I can reproduce
>    > it immediately, and reliably, just by issuing an ssh
>    > command (as a normal user).
>
>    I'm seeing the same thing on my gateway, though I haven't
>    yet found my serial cable to get the oops translated.  I
>    am back to 2.4.10 for now.
>
> Just back out the netfilter changes in 2.4.15-pre1, that
> is the cause.
>
> Franks a lot,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--------------D622283EB664D139BCF6AD0A
Content-Type: text/plain; charset=us-ascii;
 name="netfilter-2.4.15-pre2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netfilter-2.4.15-pre2.patch"

diff -u --recursive --new-file v2.4.14/linux/net/ipv4/netfilter/ip_fw_compat.c linux/net/ipv4/netfilter/ip_fw_compat.c
--- v2.4.14/linux/net/ipv4/netfilter/ip_fw_compat.c	Fri Apr 27 14:15:01 2001
+++ linux/net/ipv4/netfilter/ip_fw_compat.c	Wed Nov  7 14:39:36 2001
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
diff -u --recursive --new-file v2.4.14/linux/net/ipv4/netfilter/ip_nat_core.c linux/net/ipv4/netfilter/ip_nat_core.c
--- v2.4.14/linux/net/ipv4/netfilter/ip_nat_core.c	Wed May 16 10:31:27 2001
+++ linux/net/ipv4/netfilter/ip_nat_core.c	Wed Nov  7 14:39:36 2001
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
diff -u --recursive --new-file v2.4.14/linux/net/ipv4/netfilter/ipt_TCPMSS.c linux/net/ipv4/netfilter/ipt_TCPMSS.c
--- v2.4.14/linux/net/ipv4/netfilter/ipt_TCPMSS.c	Tue Oct  9 17:06:53 2001
+++ linux/net/ipv4/netfilter/ipt_TCPMSS.c	Wed Nov  7 14:39:36 2001
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
 
diff -u --recursive --new-file v2.4.14/linux/net/ipv4/netfilter/ipt_TOS.c linux/net/ipv4/netfilter/ipt_TOS.c
--- v2.4.14/linux/net/ipv4/netfilter/ipt_TOS.c	Tue Oct  9 17:06:53 2001
+++ linux/net/ipv4/netfilter/ipt_TOS.c	Wed Nov  7 14:39:36 2001
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

--------------D622283EB664D139BCF6AD0A--

