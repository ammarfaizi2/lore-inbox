Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbUKIFy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbUKIFy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUKIFwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:52:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:3487 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261392AbUKIFZC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:25:02 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778562059@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:16 -0800
Message-Id: <10999778563931@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.15, 2004/11/08 16:34:36-08:00, greg@kroah.com

I2C: remove ignore_range from I2C sensor drivers, as it's not used.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/pc87360.c     |    2 --
 drivers/i2c/chips/smsc47m1.c    |    2 --
 drivers/i2c/i2c-sensor-detect.c |   10 ----------
 include/linux/i2c-sensor.h      |   11 -----------
 4 files changed, 25 deletions(-)


diff -Nru a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c	2004-11-08 18:55:11 -08:00
+++ b/drivers/i2c/chips/pc87360.c	2004-11-08 18:55:11 -08:00
@@ -57,8 +57,6 @@
 	.normal_i2c_range	= normal_i2c_range,
 	.normal_isa		= normal_isa,
 	.normal_isa_range	= normal_isa_range,
-	.ignore			= normal_i2c,		/* cheat */
-	.ignore_range		= normal_i2c_range,	/* cheat */
 	.forces			= forces,
 };
 
diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2004-11-08 18:55:11 -08:00
+++ b/drivers/i2c/chips/smsc47m1.c	2004-11-08 18:55:11 -08:00
@@ -46,8 +46,6 @@
 	.normal_i2c_range	= normal_i2c_range,
 	.normal_isa		= normal_isa,
 	.normal_isa_range	= normal_isa_range,
-	.ignore			= normal_i2c,		/* cheat */
-	.ignore_range		= normal_i2c_range,	/* cheat */
 	.forces			= forces,
 };
 
diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:55:11 -08:00
+++ b/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:55:11 -08:00
@@ -81,16 +81,6 @@
 				found = 1;
 			}
 		}
-		for (i = 0; !found && (address_data->ignore_range[i] != I2C_CLIENT_END); i += 3) {
-			if ( ((adapter_id == address_data->ignore_range[i]) ||
-			      ((address_data-> ignore_range[i] == ANY_I2C_BUS) & 
-			       !is_isa)) &&
-			     (addr >= address_data->ignore_range[i + 1]) &&
-			     (addr <= address_data->ignore_range[i + 2])) {
-				dev_dbg(&adapter->dev,  "found ignore_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
-				found = 1;
-			}
-		}
 		if (found)
 			continue;
 
diff -Nru a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h	2004-11-08 18:55:11 -08:00
+++ b/include/linux/i2c-sensor.h	2004-11-08 18:55:11 -08:00
@@ -63,12 +63,6 @@
      the ISA bus, -1 for any I2C bus), the second is the I2C address. These
      addresses are never probed. This parameter overrules 'normal' and 
      'probe', but not the 'force' lists.
-   ignore_range: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END 
-      values.
-     A list of triples. The first value is a bus number (ANY_I2C_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
-     These form an inclusive range of I2C addresses that are never probed.
-     This parameter overrules 'normal' and 'probe', but not the 'force' lists.
    force_data: insmod parameters. A list, ending with an element of which
      the force field is NULL.
 */
@@ -79,7 +73,6 @@
 	unsigned int *normal_isa_range;
 	unsigned short *probe;
 	unsigned short *ignore;
-	unsigned short *ignore_range;
 	struct i2c_force_data *forces;
 };
 
@@ -95,9 +88,6 @@
                       "List of adapter,address pairs to scan additionally"); \
   I2C_CLIENT_MODULE_PARM(ignore, \
                       "List of adapter,address pairs not to scan"); \
-  I2C_CLIENT_MODULE_PARM(ignore_range, \
-                      "List of adapter,start-addr,end-addr triples not to " \
-                      "scan"); \
 	static struct i2c_address_data addr_data = {			\
 			.normal_i2c =		normal_i2c,		\
 			.normal_i2c_range =	normal_i2c_range,	\
@@ -105,7 +95,6 @@
 			.normal_isa_range =	normal_isa_range,	\
 			.probe =		probe,			\
 			.ignore =		ignore,			\
-			.ignore_range =		ignore_range,		\
 			.forces =		forces,			\
 		}
 

