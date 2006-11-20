Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933890AbWKTCYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933890AbWKTCYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933888AbWKTCYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51473 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933890AbWKTCYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:24:45 -0500
Date: Mon, 20 Nov 2006 03:24:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/misc/ftdi-elan.c: fixes and cleanups
Message-ID: <20061120022444.GT31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the needlessly global ftdi_release_platform_dev() static
- remove the unused usb_ftdi_elan_read_reg()
- proper prototypes for the following functions:
  - usb_ftdi_elan_read_pcimem()
  - usb_ftdi_elan_write_pcimem()

Note that the misplaced prototypes for the latter ones in 
drivers/usb/host/u132-hcd.c were buggy. Depending on the calling 
convention of the architecture calling one of them could have turned 
your stack into garbage.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/host/u132-hcd.c  |    6 +-----
 drivers/usb/misc/ftdi-elan.c |   10 +---------
 drivers/usb/misc/usb_u132.h  |    4 ++++
 3 files changed, 6 insertions(+), 14 deletions(-)

--- linux-2.6.19-rc5-mm2/drivers/usb/misc/ftdi-elan.c.old	2006-11-20 01:09:28.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/usb/misc/ftdi-elan.c	2006-11-20 01:09:51.000000000 +0100
@@ -303,7 +303,7 @@
 
 
 EXPORT_SYMBOL_GPL(ftdi_elan_gone_away);
-void ftdi_release_platform_dev(struct device *dev)
+static void ftdi_release_platform_dev(struct device *dev)
 {
         dev->parent = NULL;
 }
@@ -1426,14 +1426,6 @@
         }
 }
 
-int usb_ftdi_elan_read_reg(struct platform_device *pdev, u32 *data)
-{
-        struct usb_ftdi *ftdi = platform_device_to_usb_ftdi(pdev);
-        return ftdi_elan_read_reg(ftdi, data);
-}
-
-
-EXPORT_SYMBOL_GPL(usb_ftdi_elan_read_reg);
 static int ftdi_elan_read_config(struct usb_ftdi *ftdi, int config_offset,
         u8 width, u32 *data)
 {
--- linux-2.6.19-rc5-mm2/drivers/usb/misc/usb_u132.h.old	2006-11-20 02:41:07.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/usb/misc/usb_u132.h	2006-11-20 02:49:00.000000000 +0100
@@ -95,3 +95,7 @@
          int halted, int skipped, int actual, int non_null));
 int usb_ftdi_elan_edset_flush(struct platform_device *pdev, u8 ed_number,
         void *endp);
+int usb_ftdi_elan_read_pcimem(struct platform_device *pdev, int mem_offset,
+			      u8 width, u32 *data);
+int usb_ftdi_elan_write_pcimem(struct platform_device *pdev, int mem_offset,
+			       u8 width, u32 data);
--- linux-2.6.19-rc5-mm2/drivers/usb/host/u132-hcd.c.old	2006-11-20 01:09:58.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/usb/host/u132-hcd.c	2006-11-20 02:42:24.000000000 +0100
@@ -205,11 +205,7 @@
         struct u132_port port[MAX_U132_PORTS];
         struct u132_endp *endp[MAX_U132_ENDPS];
 };
-int usb_ftdi_elan_read_reg(struct platform_device *pdev, u32 *data);
-int usb_ftdi_elan_read_pcimem(struct platform_device *pdev, u8 addressofs,
-        u8 width, u32 *data);
-int usb_ftdi_elan_write_pcimem(struct platform_device *pdev, u8 addressofs,
-        u8 width, u32 data);
+
 /*
 * these can not be inlines because we need the structure offset!!
 * Does anyone have a better way?????

