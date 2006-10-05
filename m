Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWJECZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWJECZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 22:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWJECZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 22:25:22 -0400
Received: from staff.cs.usyd.edu.au ([129.78.8.1]:1460 "helo
	staff.cs.usyd.edu.au") by vger.kernel.org with SMTP
	id S1750815AbWJECZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 22:25:21 -0400
Date: Thu, 5 Oct 2006 12:25:05 +1000 (EST)
From: Mark Assad <massad@it.usyd.edu.au>
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, trivial@kernel.org, hc@mivu.no, dtor@mail.ru
Subject: [PATCH] itmtouch: fix inverted flag to indicate touch location
 correctly, correct white space
Message-ID: <Pine.SOL.4.21.0610051222320.7133-100000@staff.cs.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report-SoIT: * -100 USER_IN_WHITELIST From: address is in the user's white-list
	* -2.8 ALL_TRUSTED Did not pass through any untrusted hosts
X-Spam-Flag-SoIT: No (Score=-102.8, required: 5.0)
X-Spam-Level-SoIT: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Assad <massad@gmail.com>

There is a bug in the current version of the itmtouch USB touchscreen
driver. The if statment that checks if pressure is being applied to
the touch screen is now missing a ! (not), so events are no longer
being reported correctly.

The origonal source code for this line was as follows:
#define UCP(x) ((unsigned char*)(x))
#define UCOM(x,y,z) ((UCP((x)->transfer_buffer)[y]) & (z))
if (!UCOM(urb, 7, 0x20)) {

And was cleaned to:
 unsigned char *data = urb->transfer_buffer;
....
 if (data[7] & 0x20) {

(note the lack of ! )

This has been tested on an LG L1510BF and an LG1510SF touch screen.

Patched applied from: linux-2.6.18

(resent because I mangled the whitespace from gmail. Sorry!)

Signed-off-by: Mark Assad <massad@gmail.com>

---

--- linux-2.6.18/drivers/usb/input/itmtouch.c	2006-09-20 13:42:06.000000000 +1000
+++ linux/drivers/usb/input/itmtouch.c	2006-10-05 09:49:56.000000000 +1000
@@ -36,7 +36,11 @@
  *
  * 1.2.1  09/03/2005 (HCE) hc@mivu.no
  *   Code cleanup and adjusting syntax to start matching kernel standards
- *
+ * 
+ * 1.2.2  10/05/2006 (MJA) massad@gmail.com
+ *   Flag for detecting if the screen was being touch was incorrectly 
+ *   inverted, so no touch events were being detected. 	
+ *   
  *****************************************************************************/
 
 #include <linux/kernel.h>
@@ -53,7 +57,7 @@
 #define USB_PRODUCT_ID_TOUCHPANEL	0xf9e9
 
 #define DRIVER_AUTHOR "Hans-Christian Egtvedt <hc@mivu.no>"
-#define DRIVER_VERSION "v1.2.1"
+#define DRIVER_VERSION "v1.2.2"
 #define DRIVER_DESC "USB ITM Inc Touch Panel Driver"
 #define DRIVER_LICENSE "GPL"
 
@@ -108,7 +112,7 @@ static void itmtouch_irq(struct urb *urb
 	input_regs(dev, regs);
 
 	/* if pressure has been released, then don't report X/Y */
-	if (data[7] & 0x20) {
+	if (!(data[7] & 0x20)) {
 		input_report_abs(dev, ABS_X, (data[0] & 0x1F) << 7 | (data[3] & 0x7F));
 		input_report_abs(dev, ABS_Y, (data[1] & 0x1F) << 7 | (data[4] & 0x7F));
 	}



