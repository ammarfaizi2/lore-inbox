Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136388AbREDOBo>; Fri, 4 May 2001 10:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136391AbREDOBe>; Fri, 4 May 2001 10:01:34 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:46351 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S136388AbREDOBQ>;
	Fri, 4 May 2001 10:01:16 -0400
Date: Fri, 4 May 2001 16:00:50 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] [UPDATED] mct_u232 usb serial driver
Message-ID: <20010504160050.C13320@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two bugs in the mct_u232 driver when used
with the Sitecom U232-P25 device:

	- baud calculation (already posted two days ago) was wrong,
	  making it impossible to be used with a fixed baud rate device

	- the maximum output packet size as reported by the usb device
	  (32 bytes) is wrong, the device seems to be able to accept
	  reliably only 16 bytes at the time (confirmed by SniffUSB
	  with the original Windows driver).

I only have the Sitecom device available so I've made the two patches
dependent on this particular model. Someone with a real MCT or DLINK
device should verify those against their model, because I suspect
the two bugs to be present for all the models this driver supports
(the same Windows driver is used for all this models...).

Now I can confirm that with those changes, this driver is able to
drive the Sitecom U232-P25 good enough in order to carry PPP traffic
over my Siemens S25 cell phone (fixed baud rate of 19200) or over
a null modem cable at 115200 bps.

Please note that I'm not subscribed to linux-usb-devel, only to
linux-kernel...

Stelian.

diff -uNr linux-2.4.4.orig/drivers/usb/serial/mct_u232.c linux-2.4.4/drivers/usb/serial/mct_u232.c
--- linux-2.4.4.orig/drivers/usb/serial/mct_u232.c	Sat Apr  7 00:51:52 2001
+++ linux-2.4.4/drivers/usb/serial/mct_u232.c	Fri May  4 15:21:50 2001
@@ -24,6 +24,14 @@
  *   Basic tests have been performed with minicom/zmodem transfers and
  *   modem dialing under Linux 2.4.0-test10 (for me it works fine).
  *
+ * 04-May-2001 Stelian Pop
+ *   - Set the maximum bulk output size for Sitecom U232-P25 model to 16 bytes
+ *     instead of the device reported 32 (using 32 bytes causes many data
+ *     loss, Windows driver uses 16 too).
+ *
+ * 02-May-2001 Stelian Pop
+ *   - Fixed the baud calculation for Sitecom U232-P25 model
+ *
  * 06-Jan-2001 Cornel Ciocirlan 
  *   - Added support for Sitecom U232-P25 model (Product Id 0x0230)
  *   - Added support for D-Link DU-H3SP USB BAY (Product Id 0x0200)
@@ -218,11 +226,31 @@
 
 #define WDR_TIMEOUT (HZ * 5 ) /* default urb timeout */
 
+static int mct_u232_calculate_baud_rate(struct usb_serial *serial, int value) {
+	if (serial->dev->descriptor.idProduct == MCT_U232_SITECOM_PID) {
+		switch (value) {
+			case    300: return 0x01;
+			case    600: return 0x02; /* this one not tested */
+			case   1200: return 0x03;
+			case   2400: return 0x04;
+			case   4800: return 0x06;
+			case   9600: return 0x08;
+			case  19200: return 0x09;
+			case  38400: return 0x0a;
+			case  57600: return 0x0b;
+			case 115200: return 0x0c;
+			default:     return -1; /* normally not reached */
+		}
+	}
+	else
+		return MCT_U232_BAUD_RATE(value);
+}
+
 static int mct_u232_set_baud_rate(struct usb_serial *serial, int value)
 {
 	unsigned int divisor;
         int rc;
-	divisor = MCT_U232_BAUD_RATE(value);
+	divisor = mct_u232_calculate_baud_rate(serial, value);
         rc = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
                              MCT_U232_SET_BAUD_RATE_REQUEST,
 			     MCT_U232_SET_REQUEST_TYPE,
@@ -230,7 +258,7 @@
 			     WDR_TIMEOUT);
 	if (rc < 0)
 		err("Set BAUD RATE %d failed (error = %d)", value, rc);
-	dbg("set_baud_rate: 0x%x", divisor);
+	dbg("set_baud_rate: value: %d, divisor: 0x%x", value, divisor);
         return rc;
 } /* mct_u232_set_baud_rate */
 
@@ -366,6 +394,14 @@
 
 	if (!port->active) {
 		port->active = 1;
+
+		/* Compensate for a hardware bug: although the Sitecom U232-P25
+		 * device reports a maximum output packet size of 32 bytes,
+		 * it seems to be able to accept only 16 bytes (and that's what
+		 * SniffUSB says too...)
+		 */
+		if (serial->dev->descriptor.idProduct == MCT_U232_SITECOM_PID)
+			port->bulk_out_size = 16;
 
 		/* Do a defined restart: the normal serial device seems to 
 		 * always turn on DTR and RTS here, so do the same. I'm not


-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|------------- Ingénieur Informatique Libre --------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|----------- Alcôve, l'informatique est libre ------------|
