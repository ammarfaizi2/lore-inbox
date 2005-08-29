Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVH2LOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVH2LOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 07:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVH2LOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 07:14:32 -0400
Received: from [85.8.12.41] ([85.8.12.41]:2712 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751062AbVH2LOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 07:14:31 -0400
Message-ID: <4312EDE6.7090603@drzeus.cx>
Date: Mon, 29 Aug 2005 13:13:42 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-16811-1125314069-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ios for mmc chip select
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-16811-1125314069-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Adds a new ios for setting the chip select pin on MMC cards. Needed on
SD controllers which use this pin for other things and therefore cannot
have it pulled high at all times.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

--=_hermes.drzeus.cx-16811-1125314069-0001-2
Content-Type: text/x-patch; name="mmc-cs.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-cs.patch"

Index: linux/drivers/mmc/mmc.c
===================================================================
--- linux/drivers/mmc/mmc.c	(revision 151)
+++ linux/drivers/mmc/mmc.c	(working copy)
@@ -457,6 +457,11 @@
 {
 	struct mmc_command cmd;
 
+	host->ios.chip_select = MMC_CS_HIGH;
+	host->ops->set_ios(host, &host->ios);
+
+	mmc_delay(1);
+
 	cmd.opcode = MMC_GO_IDLE_STATE;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_NONE;
@@ -464,6 +469,11 @@
 	mmc_wait_for_cmd(host, &cmd, 0);
 
 	mmc_delay(1);
+
+	host->ios.chip_select = MMC_CS_DONTCARE;
+	host->ops->set_ios(host, &host->ios);
+
+	mmc_delay(1);
 }
 
 /*
@@ -475,6 +485,7 @@
 
 	host->ios.vdd = bit;
 	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+	host->ios.chip_select = MMC_CS_DONTCARE;
 	host->ios.power_mode = MMC_POWER_UP;
 	host->ops->set_ios(host, &host->ios);
 
@@ -492,6 +503,7 @@
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+	host->ios.chip_select = MMC_CS_DONTCARE;
 	host->ios.power_mode = MMC_POWER_OFF;
 	host->ops->set_ios(host, &host->ios);
 }
Index: linux/include/linux/mmc/host.h
===================================================================
--- linux/include/linux/mmc/host.h	(revision 151)
+++ linux/include/linux/mmc/host.h	(working copy)
@@ -46,6 +46,12 @@
 #define MMC_BUSMODE_OPENDRAIN	1
 #define MMC_BUSMODE_PUSHPULL	2
 
+	unsigned char	chip_select;		/* SPI chip select */
+
+#define MMC_CS_DONTCARE		0
+#define MMC_CS_HIGH		1
+#define MMC_CS_LOW		2
+
 	unsigned char	power_mode;		/* power supply mode */
 
 #define MMC_POWER_OFF		0

--=_hermes.drzeus.cx-16811-1125314069-0001-2--
