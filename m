Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVCFB6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVCFB6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVCFB5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:57:37 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:52900 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261286AbVCFB5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:57:20 -0500
Message-ID: <422A637D.9050308@drzeus.cx>
Date: Sun, 06 Mar 2005 02:57:17 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-27868-1110074324-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC][6/6] Secure Digital (SD) support : wide bus
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <422A5E1C.2050107@drzeus.cx>
In-Reply-To: <422A5E1C.2050107@drzeus.cx>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-27868-1110074324-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Wide bus support.

This adds 4-bit bus support to the MMC layer. It is designed to 
(hopefully) be compatible with a future 4-bit MMC implementation. This 
is done by seperating the three different instances of bus width defines:

* Protocol definition: SD_BUS_WIDTH_x
* SCR contents: SD_SCR_BUS_WIDTH_x
* Host mode: MMC_BUS_WIDTH_x

They have the same values atm but drivers should not rely on this. 
MMC_BUS_WIDTH_x is not meant to be SD specific.

The MMC layer changes bus width when a card is selected. This is because 
the SD spec says that a card is only required to keep a certain bus 
width as long as it's selected.

Layers further up do not need to know which mode the host/card is in. 
They will only see a change in speed.


--=_hades.drzeus.cx-27868-1110074324-0001-2
Content-Type: text/x-patch; name="mmc-sd-4bit.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-sd-4bit.patch"

Index: linux-sd/include/linux/mmc/host.h
===================================================================
--- linux-sd/include/linux/mmc/host.h	(revision 138)
+++ linux-sd/include/linux/mmc/host.h	(working copy)
@@ -51,6 +51,11 @@
 #define MMC_POWER_OFF		0
 #define MMC_POWER_UP		1
 #define MMC_POWER_ON		2
+
+	unsigned char	bus_width;		/* data bus width */
+
+#define MMC_BUS_WIDTH_1		0
+#define MMC_BUS_WIDTH_4		2
 };
 
 struct mmc_host_ops {
@@ -69,7 +74,11 @@
 	unsigned int		f_max;
 	u32			ocr_avail;
 	char			host_name[8];
+	
+	unsigned long		caps;		/* Host capabilities */
 
+#define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
+
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
 	unsigned short		max_hw_segs;	/* see blk_queue_max_hw_segments */
Index: linux-sd/include/linux/mmc/protocol.h
===================================================================
--- linux-sd/include/linux/mmc/protocol.h	(revision 136)
+++ linux-sd/include/linux/mmc/protocol.h	(working copy)
@@ -209,5 +209,12 @@
 #define CSD_SPEC_VER_2      2           /* Implements system specification 2.0 - 2.2 */
 #define CSD_SPEC_VER_3      3           /* Implements system specification 3.1 */
 
+
+/*
+ * SD bus widths
+ */
+#define SD_BUS_WIDTH_1      0
+#define SD_BUS_WIDTH_4      2
+
 #endif  /* MMC_MMC_PROTOCOL_H */
 
Index: linux-sd/drivers/mmc/mmc.c
===================================================================
--- linux-sd/drivers/mmc/mmc.c	(revision 139)
+++ linux-sd/drivers/mmc/mmc.c	(working copy)
@@ -335,6 +335,40 @@
 	if (err != MMC_ERR_NONE)
 		return err;
 
+	/*
+	 * Default bus width is 1 bit.
+	 */
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
+	
+	/*
+	 * We can only change the bus width of the selected
+	 * card so therefore we have to put the handling
+	 * here.
+	 */
+	if (host->caps & MMC_CAP_4_BIT_DATA) {
+		/*
+		 * The card is in 1 bit mode by default so
+		 * we only need to change if it supports the
+		 * wider version.
+		 */
+		if (mmc_card_sd(card) &&
+			(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
+			struct mmc_command cmd;
+			cmd.opcode = SD_APP_SET_BUS_WIDTH;
+			cmd.arg = SD_BUS_WIDTH_4;
+			cmd.flags = MMC_RSP_R1;
+			
+			err = mmc_wait_for_app_cmd(host, card->rca, &cmd,
+				CMD_RETRIES);
+			if (err != MMC_ERR_NONE)
+				return err;
+			
+			host->ios.bus_width = MMC_BUS_WIDTH_4;
+		}
+	}
+
+	host->ops->set_ios(host, &host->ios);
+
 	return MMC_ERR_NONE;
 }
 
@@ -644,6 +678,7 @@
 	host->ios.vdd = bit;
 	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 	host->ios.power_mode = MMC_POWER_UP;
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
 	host->ops->set_ios(host, &host->ios);
 
 	mmc_delay(1);
@@ -661,6 +696,7 @@
 	host->ios.vdd = 0;
 	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 	host->ios.power_mode = MMC_POWER_OFF;
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
 	host->ops->set_ios(host, &host->ios);
 }
 

--=_hades.drzeus.cx-27868-1110074324-0001-2--
