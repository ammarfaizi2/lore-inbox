Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268750AbUIGXZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268750AbUIGXZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUIGXZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:25:11 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:15574 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S268750AbUIGXYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:24:45 -0400
From: Duncan Sands <baldrick@free.fr>
To: mpm@selenic.com
Subject: [PATCH] netpoll endian fixes
Date: Wed, 8 Sep 2004 01:24:43 +0200
User-Agent: KMail/1.6.2
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409080124.43530.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The big-endians took their revenge in netpoll.c: on i386,
the ip header length / version nibbles need to be the other
way round; and the htonl leaves only zeros in tot_len...

All the best, 

Duncan.


--- linux-2.5/net/core/netpoll.c.orig	2004-09-08 01:15:22.000000000 +0200
+++ linux-2.5/net/core/netpoll.c	2004-09-08 01:05:33.000000000 +0200
@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <asm/unaligned.h>
+#include <asm/byteorder.h>
 
 /*
  * We maintain a small pool of fully-sized skbs, to make sure the
@@ -242,9 +243,13 @@
 	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
 
 	/* iph->version = 4; iph->ihl = 5; */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	put_unaligned(0x45, (unsigned char *)iph);
+#else
 	put_unaligned(0x54, (unsigned char *)iph);
+#endif
 	iph->tos      = 0;
-	put_unaligned(htonl(ip_len), &(iph->tot_len));
+	put_unaligned(htons(ip_len), &(iph->tot_len));
 	iph->id       = 0;
 	iph->frag_off = 0;
 	iph->ttl      = 64;
