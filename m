Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVHPWQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVHPWQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVHPWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:16:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:16273 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751125AbVHPWQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:16:41 -0400
Date: Tue, 16 Aug 2005 15:16:32 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pingc@wacom.com
Subject: [patch 6/7] USB: fix usb wacom tablet driver bug
Message-ID: <20050816221631.GG28619@kroah.com>
References: <20050816220001.699316000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-fix-wacom-bug.patch"
In-Reply-To: <20050816221527.GA28619@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ping Cheng <pingc@wacom.com>

This patch fixes bug 4905 and a Cintiq 21UX bug.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/input/wacom.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

--- gregkh-2.6.orig/drivers/usb/input/wacom.c	2005-08-16 14:51:29.000000000 -0700
+++ gregkh-2.6/drivers/usb/input/wacom.c	2005-08-16 14:58:01.000000000 -0700
@@ -342,9 +342,6 @@ static void wacom_graphire_irq(struct ur
 		goto exit;
 	}
 
-	x = le16_to_cpu(*(__le16 *) &data[2]);
-	y = le16_to_cpu(*(__le16 *) &data[4]);
-
 	input_regs(dev, regs);
 
 	if (data[1] & 0x10) { /* in prox */
@@ -373,15 +370,17 @@ static void wacom_graphire_irq(struct ur
 		}
 	}
 
-	if (data[1] & 0x80) {
+	if (data[1] & 0x90) {
+		x = le16_to_cpu(*(__le16 *) &data[2]);
+		y = le16_to_cpu(*(__le16 *) &data[4]);
 		input_report_abs(dev, ABS_X, x);
 		input_report_abs(dev, ABS_Y, y);
-	}
-	if (wacom->tool[0] != BTN_TOOL_MOUSE) {
-		input_report_abs(dev, ABS_PRESSURE, le16_to_cpu(*(__le16 *) &data[6]));
-		input_report_key(dev, BTN_TOUCH, data[1] & 0x01);
-		input_report_key(dev, BTN_STYLUS, data[1] & 0x02);
-		input_report_key(dev, BTN_STYLUS2, data[1] & 0x04);
+		if (wacom->tool[0] != BTN_TOOL_MOUSE) {
+			input_report_abs(dev, ABS_PRESSURE, le16_to_cpu(*(__le16 *) &data[6]));
+			input_report_key(dev, BTN_TOUCH, data[1] & 0x01);
+			input_report_key(dev, BTN_STYLUS, data[1] & 0x02);
+			input_report_key(dev, BTN_STYLUS2, data[1] & 0x04);
+		}
 	}
 
 	input_report_key(dev, wacom->tool[0], data[1] & 0x10);
@@ -568,7 +567,7 @@ static void wacom_intuos_irq(struct urb 
 
 	/* Cintiq doesn't send data when RDY bit isn't set */
 	if ((wacom->features->type == CINTIQ) && !(data[1] & 0x40))
-		return;
+		goto exit;
 
 	if (wacom->features->type >= INTUOS3) {
 		input_report_abs(dev, ABS_X, (data[2] << 9) | (data[3] << 1) | ((data[9] >> 1) & 1));

--
