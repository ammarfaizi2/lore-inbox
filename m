Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWJEAgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWJEAgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJEAgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:36:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:11508 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751269AbWJEAgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:36:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PqJ4tOMd/Aq9ebuFxOY9fNLnZx4dMP0mKNpO2InuWTW2DXq7o64eby7tNOOJlwpKstNvShRJWu3ZItYYUrj2IHzmYSYNDWkK1tkXMbzZgUIm2coFN8xFimY6D02qqSqbh2b9IbzdbgP28ltwIBIeF4NmSbJ5JKRhCcOSHj3WEsc=
Message-ID: <7f9863480610041736k2fe84c6bqd1d9740868dedf7d@mail.gmail.com>
Date: Thu, 5 Oct 2006 10:36:49 +1000
From: "Mark Assad" <massad@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] itmtouch: fix inverted flag to indicate touch location correctly
Cc: trivial@kernel.org, hc@mivu.no, torvalds@osdl.org, dtor@mail.ru
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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

Signed-off-by: Mark Assad <massad@gmail.com>

---

--- linux-2.6.18/drivers/usb/input/itmtouch.c   2006-09-20
13:42:06.000000000 +1000
+++ linux/drivers/usb/input/itmtouch.c  2006-10-05 09:49:56.000000000 +1000
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
 #define USB_PRODUCT_ID_TOUCHPANEL      0xf9e9

 #define DRIVER_AUTHOR "Hans-Christian Egtvedt <hc@mivu.no>"
-#define DRIVER_VERSION "v1.2.1"
+#define DRIVER_VERSION "v1.2.2"
 #define DRIVER_DESC "USB ITM Inc Touch Panel Driver"
 #define DRIVER_LICENSE "GPL"

@@ -108,7 +112,7 @@ static void itmtouch_irq(struct urb *urb
        input_regs(dev, regs);

        /* if pressure has been released, then don't report X/Y */
-       if (data[7] & 0x20) {
+       if (!(data[7] & 0x20)) {
                input_report_abs(dev, ABS_X, (data[0] & 0x1F) << 7 |
(data[3] & 0x7F));
                input_report_abs(dev, ABS_Y, (data[1] & 0x1F) << 7 |
(data[4] & 0x7F));
        }
