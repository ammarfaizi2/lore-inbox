Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbVBCRup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVBCRup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbVBCRuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:50:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:5032 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262616AbVBCRlR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:17 -0500
Cc: aurelien@aurel32.net
Subject: [PATCH] I2C: Fix DS1621 detection
In-Reply-To: <20050203173745.GA24076@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:38:58 -0800
Message-Id: <11074523381178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2041, 2005/02/03 00:28:34-08:00, aurelien@aurel32.net

[PATCH] I2C: Fix DS1621 detection

Dallas Semiconductors as recently changed the design of their DS1621
chips, including the bits that were checked in the kernel driver to
detect it.

The patch below fixes the detection by checking an other bit of the
configuration register instead.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/ds1621.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c	2005-02-03 09:35:23 -08:00
+++ b/drivers/i2c/chips/ds1621.c	2005-02-03 09:35:23 -08:00
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

