Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbUKFGOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUKFGOI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 01:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbUKFGOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 01:14:08 -0500
Received: from ozlabs.org ([203.10.76.45]:44736 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261322AbUKFGOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 01:14:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16780.27572.271645.404083@cargo.ozlabs.ibm.com>
Date: Sat, 6 Nov 2004 17:14:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] Check character flags in ppp_async ldisc
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although it was checking the per-character error flags supplied by the
driver for ordinary characters, the ppp_async line discipline code
wasn't checking the flags for special characters, such as the flag and
escape characters (~ and }).  This patch adds that check.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/net/ppp_async.c pmac-2.5/drivers/net/ppp_async.c
--- linux-2.5/drivers/net/ppp_async.c	2004-10-22 07:00:21.000000000 +1000
+++ pmac-2.5/drivers/net/ppp_async.c	2004-11-06 17:12:05.517208784 +1100
@@ -911,7 +911,9 @@
 			break;
 
 		c = buf[n];
-		if (c == PPP_FLAG) {
+		if (flags != NULL && flags[n] != 0) {
+			ap->state |= SC_TOSS;
+		} else if (c == PPP_FLAG) {
 			process_input_packet(ap);
 		} else if (c == PPP_ESCAPE) {
 			ap->state |= SC_ESCAPE;
