Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVAHIvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVAHIvX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVAHIt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:49:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:55429 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261884AbVAHFs1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:27 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <1105162774832@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:34 -0800
Message-Id: <110516277494@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.49, 2005/01/06 15:04:58-08:00, david-b@pacbell.net

[PATCH] I2C: minor isp1301_omap tweaks

Minor cleanups to the isp130_omap driver:  enable the right
amount of VBUS current draw in non-OTG configurations; get rid
of a warning from GCC 2.95.3 ("int" function returns no value);
use kcalloc() not kmalloc+memset.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/isp1301_omap.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
--- a/drivers/i2c/chips/isp1301_omap.c	2005-01-07 14:54:18 -08:00
+++ b/drivers/i2c/chips/isp1301_omap.c	2005-01-07 14:54:18 -08:00
@@ -934,13 +934,14 @@
 
 static void b_peripheral(struct isp1301 *isp)
 {
-	enable_vbus_draw(isp, 8);
 	OTG_CTRL_REG = OTG_CTRL_REG & OTG_XCEIV_OUTPUTS;
 	usb_gadget_vbus_connect(isp->otg.gadget);
 
 #ifdef	CONFIG_USB_OTG
+	enable_vbus_draw(isp, 8);
 	otg_update_isp(isp);
 #else
+	enable_vbus_draw(isp, 100);
 	/* UDC driver just set OTG_BSESSVLD */
 	isp1301_set_bits(isp, ISP1301_OTG_CONTROL_1, OTG1_DP_PULLUP);
 	isp1301_clear_bits(isp, ISP1301_OTG_CONTROL_1, OTG1_DP_PULLDOWN);
@@ -950,7 +951,7 @@
 #endif
 }
 
-static int isp_update_otg(struct isp1301 *isp, u8 stat)
+static void isp_update_otg(struct isp1301 *isp, u8 stat)
 {
 	u8			isp_stat, isp_bstat;
 	enum usb_otg_state	state = isp->otg.state;
@@ -1489,11 +1490,9 @@
 	if (the_transceiver)
 		return 0;
 
-	isp = kmalloc(sizeof *isp, GFP_KERNEL);
+	isp = kcalloc(1, sizeof *isp, GFP_KERNEL);
 	if (!isp)
 		return 0;
-
-	memset(isp, 0, sizeof *isp);
 
 	INIT_WORK(&isp->work, isp1301_work, isp);
 	init_timer(&isp->timer);

