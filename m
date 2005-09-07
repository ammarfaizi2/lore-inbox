Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVIGRpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVIGRpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVIGRpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:45:11 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:9676
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751214AbVIGRpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:45:10 -0400
Subject: [patch] synclinkmp.c fix async internal loopback
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1126115104.4056.17.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Sep 2005 12:45:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] synclinkmp.c fix async internal loopback

From: Paul Fulghum <paulkf@microgate.com>

Fix async internal loopback by not using
enable_loopback function which reprograms
clocking and should only be used for hdlc mode.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.13/drivers/char/synclinkmp.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-mg/drivers/char/synclinkmp.c	2005-09-07 12:28:21.000000000 -0500
@@ -4489,11 +4489,13 @@ void async_mode(SLMP_INFO *info)
 	/* MD2, Mode Register 2
 	 *
 	 * 07..02  Reserved, must be 0
-	 * 01..00  CNCT<1..0> Channel connection, 0=normal
+	 * 01..00  CNCT<1..0> Channel connection, 00=normal 11=local loopback
 	 *
 	 * 0000 0000
 	 */
 	RegValue = 0x00;
+	if (info->params.loopback)
+		RegValue |= (BIT1 + BIT0);
 	write_reg(info, MD2, RegValue);
 
 	/* RXS, Receive clock source
@@ -4574,9 +4576,6 @@ void async_mode(SLMP_INFO *info)
 	write_reg(info, IE2, info->ie2_value);
 
 	set_rate( info, info->params.data_rate * 16 );
-
-	if (info->params.loopback)
-		enable_loopback(info,1);
 }
 
 /* Program the SCA for HDLC communications.


