Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUHUV2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUHUV2u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267895AbUHUV2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:28:50 -0400
Received: from 80-219-192-49.dclient.hispeed.ch ([80.219.192.49]:11780 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S267882AbUHUV2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:28:42 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] fix EnE Cardbus bridges for HDSP
Date: Sat, 21 Aug 2004 23:22:31 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408212322.31099.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi marcelo

this has been in 2.6 since may 04. the 2.4 version of it.
against 2.4-bknow

rgds
-daniel

-------------

this patch clears an almost undocumented EnE specific test register that
makes sound on RME Hammerfall DSP Carbus work...

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

--- 1.7/drivers/pcmcia/ti113x.h	Fri Aug  8 16:07:45 2003
+++ edited/drivers/pcmcia/ti113x.h	Sat Aug 21 22:46:00 2004
@@ -134,6 +134,10 @@
 /* ExCA IO offset registers */
 #define TI113X_IO_OFFSET(map)		(0x36+((map)<<1))
 
+/* EnE test register */
+#define ENE_TEST_C9			0xc9	/* 8bit */
+#define ENE_TEST_C9_TLTENABLE		0x02
+
 #ifdef CONFIG_CARDBUS
 
 /*
@@ -155,6 +159,17 @@
 	new = reg & ~I365_INTR_ENA;
 	if (new != reg)
 		exca_writeb(socket, I365_INTCTL, new);
+
+	/*
+	 * for EnE bridges only: clear testbit TLTEnable. this makes the
+	 * RME Hammerfall DSP sound card working.
+	 */
+	if (socket->dev->vendor == PCI_VENDOR_ID_ENE) {
+		u8 test_c9 = config_readb(socket, ENE_TEST_C9);
+		test_c9 &= ~ENE_TEST_C9_TLTENABLE;
+		config_writeb(socket, ENE_TEST_C9, test_c9);
+	}
+
 	return 0;
 }
 


