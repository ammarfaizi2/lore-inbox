Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVASU15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVASU15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVASU15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:27:57 -0500
Received: from farad.aurel32.net ([82.232.2.251]:64646 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S261877AbVASU1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:27:54 -0500
Date: Wed, 19 Jan 2005 21:27:49 +0100
From: =?iso-8859-15?Q?Aur=E9lien?= Jarno <aurelien@aurel32.net>
To: Greg KH <greg@kroah.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] I2C: Fix DS1621 detection
Message-ID: <20050119202749.GA19261@bode.aurel32.net>
Mail-Followup-To: =?iso-8859-15?Q?Aur=E9lien?= Jarno <aurelien@aurel32.net>,
	Greg KH <greg@kroah.com>, sensors@Stimpy.netroedge.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.6+20040907i (CVS)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Dallas Semiconductors as recently changed the design of their DS1621
chips, including the bits that were checked in the kernel driver to 
detect it.

The patch below fixes the detection by checking an other bit of the
configuration register instead.

Please apply.

Thanks,
Aurelien

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>


diff -urN linux-2.6.11-rc1.orig/drivers/i2c/chips/ds1621.c linux-2.6.11-rc1/drivers/i2c/chips/ds1621.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/ds1621.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/ds1621.c	2005-01-19 18:39:23.000000000 +0100
@@ -42,9 +42,8 @@
 /* Many DS1621 constants specified below */
 /* Config register used for detection         */
 /*  7    6    5    4    3    2    1    0      */
-/* |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT| */
-#define DS1621_REG_CONFIG_MASK		0x0C
-#define DS1621_REG_CONFIG_VAL		0x08
+/* |Done|THF |TLF |NVB | X  | X  |POL |1SHOT| */
+#define DS1621_REG_CONFIG_NVB		0x10
 #define DS1621_REG_CONFIG_POLARITY	0x02
 #define DS1621_REG_CONFIG_1SHOT		0x01
 #define DS1621_REG_CONFIG_DONE		0x80
@@ -55,6 +54,7 @@
 #define DS1621_REG_TEMP_MAX		0xA2 /* word, RW */
 #define DS1621_REG_CONF			0xAC /* byte, RW */
 #define DS1621_COM_START		0xEE /* no data */
+#define DS1621_COM_STOP			0x22 /* no data */
 
 /* The DS1621 configuration register */
 #define DS1621_ALARM_TEMP_HIGH		0x40
@@ -212,9 +212,13 @@
 
 	/* Now, we do the remaining detection. It is lousy. */
 	if (kind < 0) {
+		/* The NVB bit should be low if no EEPROM write has been 
+		   requested during the latest 10ms, which is highly 
+		   improbable in our case. */
 		conf = ds1621_read_value(new_client, DS1621_REG_CONF);
-		if ((conf & DS1621_REG_CONFIG_MASK) != DS1621_REG_CONFIG_VAL)
+		if (conf & DS1621_REG_CONFIG_NVB)
 			goto exit_free;
+		/* The 7 lowest bits of a temperature should always be 0. */
 		temp = ds1621_read_value(new_client, DS1621_REG_TEMP);
 		if (temp & 0x007f)
 			goto exit_free;

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
