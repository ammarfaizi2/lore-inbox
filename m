Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRA2H4d>; Mon, 29 Jan 2001 02:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbRA2H4W>; Mon, 29 Jan 2001 02:56:22 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:42734 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S129847AbRA2H4F>;
	Mon, 29 Jan 2001 02:56:05 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, netfilter@us5.samba.org
Subject: [PATCH] ipt_TOS fix.
Date: Mon, 29 Jan 2001 18:55:56 +1100
Message-Id: <E14N9AL-0003qv-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply v2.4.0.

ipt_TOS checksum calculations were completely broken, causing bad csum
packets.  Whoever implemented it didn't understand the code it was
copied from.

This fixes the problem (tested in userspace against all TOS changes).

Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN -I \$.*\$ -X /tmp/kerndiff.ZtZl97 --minimal linux-2.4.0-official/net/ipv4/netfilter/ipt_TOS.c working-2.4.0/net/ipv4/netfilter/ipt_TOS.c
--- linux-2.4.0-official/net/ipv4/netfilter/ipt_TOS.c	Fri Apr 28 08:43:15 2000
+++ working-2.4.0/net/ipv4/netfilter/ipt_TOS.c	Mon Jan 29 18:40:37 2001
@@ -19,11 +19,11 @@
 	const struct ipt_tos_target_info *tosinfo = targinfo;
 
 	if ((iph->tos & IPTOS_TOS_MASK) != tosinfo->tos) {
-		u_int8_t diffs[2];
+		u_int16_t diffs[2];
 
-		diffs[0] = iph->tos;
+		diffs[0] = htons(iph->tos) ^ 0xFFFF;
 		iph->tos = (iph->tos & IPTOS_PREC_MASK) | tosinfo->tos;
-		diffs[1] = iph->tos;
+		diffs[1] = htons(iph->tos);
 		iph->check = csum_fold(csum_partial((char *)diffs,
 		                                    sizeof(diffs),
 		                                    iph->check^0xFFFF));
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
