Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUHGMkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUHGMkW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 08:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUHGMkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 08:40:21 -0400
Received: from ozlabs.org ([203.10.76.45]:37799 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261987AbUHGMkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 08:40:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16660.52705.377762.409226@cargo.ozlabs.ibm.com>
Date: Sat, 7 Aug 2004 22:41:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: kkeil@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] Restore PPP filtering
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Keil's patch entitled "[ISDN]: Fix kernel PPP/IPPP
active/passiv filter code" that went in back in April was an attempt
to solve a real problem - namely that the libpcap maintainers have
removed useful functionality that pppd was using - but his fix broke
existing pppd binaries and IMO didn't end up actually solving the
problem.

This patch reverts the change to ppp_generic.c so that existing pppd
binaries work again.  I am going to have to work out a proper fix,
which may involve further changes to ppp_generic.c, but I will make
sure existing pppd binaries still work.

Please apply.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/net/ppp_generic.c pmac-2.5/drivers/net/ppp_generic.c
--- linux-2.5/drivers/net/ppp_generic.c	2004-07-28 01:06:02.000000000 +1000
+++ pmac-2.5/drivers/net/ppp_generic.c	2004-08-07 21:07:09.018980776 +1000
@@ -1026,11 +1026,7 @@
 		/* check if we should pass this packet */
 		/* the filter instructions are constructed assuming
 		   a four-byte PPP header on each packet */
-		{
-			u_int16_t *p = (u_int16_t *) skb_push(skb, 2);
-
-			*p = htons(4); /* indicate outbound in DLT_LINUX_SLL */;
-		}
+		*skb_push(skb, 2) = 1;
 		if (ppp->pass_filter
 		    && sk_run_filter(skb, ppp->pass_filter,
 				     ppp->pass_len) == 0) {
@@ -1573,11 +1569,7 @@
 		/* check if the packet passes the pass and active filters */
 		/* the filter instructions are constructed assuming
 		   a four-byte PPP header on each packet */
-		{
-			u_int16_t *p = (u_int16_t *) skb_push(skb, 2);
-
-			*p = 0; /* indicate inbound in DLT_LINUX_SLL */
-		}
+		*skb_push(skb, 2) = 0;
 		if (ppp->pass_filter
 		    && sk_run_filter(skb, ppp->pass_filter,
 				     ppp->pass_len) == 0) {
