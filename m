Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135344AbREBOc2>; Wed, 2 May 2001 10:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135331AbREBOcT>; Wed, 2 May 2001 10:32:19 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:48909 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S135344AbREBOcC>;
	Wed, 2 May 2001 10:32:02 -0400
Date: Wed, 2 May 2001 16:31:34 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] correct baud rate in mct_u232 usb serial driver
Message-ID: <20010502163134.A17517@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the baud rate in the mct_u232 driver when
used with the Sitecom device. 

I only have the Sitecom device available so I've corrected the
baud rate calculation only for this model. Someone with a 
real MCT or DLINK device should verify the original baud rate
calculation, because I suspect it to be wrong for all models
this driver supports (the same Windows driver is used for all
this models, so I suppose there is a unique baud rate calculation...).

Anyway, this enables me to use my Siemens S25 cell modem (working
only at a fixed baud rate of 19200) with this adapter, so it may
be useful for some other people.

Please note that I'm not subscribed to linux-usb-devel, only to
linux-kernel...

Stelian.

diff -uNr linux-2.4.4.orig/drivers/usb/serial/mct_u232.c linux-2.4.4/drivers/usb/serial/mct_u232.c
--- linux-2.4.4.orig/drivers/usb/serial/mct_u232.c	Wed May  2 15:07:45 2001
+++ linux-2.4.4/drivers/usb/serial/mct_u232.c	Wed May  2 14:49:15 2001
@@ -24,6 +24,9 @@
  *   Basic tests have been performed with minicom/zmodem transfers and
  *   modem dialing under Linux 2.4.0-test10 (for me it works fine).
  *
+ * 02-May-2001 Stelian Pop
+ *   - Fixed the baud calculation for Sitecom U232-P25 model
+ *
  * 06-Jan-2001 Cornel Ciocirlan 
  *   - Added support for Sitecom U232-P25 model (Product Id 0x0230)
  *   - Added support for D-Link DU-H3SP USB BAY (Product Id 0x0200)
@@ -218,11 +221,31 @@
 
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
@@ -230,7 +253,7 @@
 			     WDR_TIMEOUT);
 	if (rc < 0)
 		err("Set BAUD RATE %d failed (error = %d)", value, rc);
-	dbg("set_baud_rate: 0x%x", divisor);
+	dbg("set_baud_rate: value: %d, divisor: 0x%x", value, divisor);
         return rc;
 } /* mct_u232_set_baud_rate */
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|------------- Ingénieur Informatique Libre --------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|----------- Alcôve, l'informatique est libre ------------|
