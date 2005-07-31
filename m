Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVGaTtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVGaTtX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVGaTtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:49:22 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:10259 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261973AbVGaTtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:49:07 -0400
Date: Sun, 31 Jul 2005 21:49:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (6/11) hwmon vs i2c, second round
Message-Id: <20050731214903.20146711.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing left in i2c-sensor.h are module parameter definition
macros. It's only an extension of what i2c.h offers, and this extension
is not sensors-specific. As a matter of fact, a few non-sensors drivers
use them. So we better merge them in i2c.h, and get rid of i2c-sensor.h
altogether.

Signed-off-by: Jean Delvare <khali@linux-fr>

 Documentation/i2c/porting-clients |    8 -
 Documentation/i2c/writing-clients |   68 ++----------
 drivers/hwmon/adm1021.c           |    3 
 drivers/hwmon/adm1025.c           |    3 
 drivers/hwmon/adm1026.c           |    3 
 drivers/hwmon/adm1031.c           |    3 
 drivers/hwmon/adm9240.c           |    3 
 drivers/hwmon/asb100.c            |    3 
 drivers/hwmon/atxp1.c             |    3 
 drivers/hwmon/ds1621.c            |    3 
 drivers/hwmon/fscher.c            |    3 
 drivers/hwmon/fscpos.c            |    3 
 drivers/hwmon/gl518sm.c           |    3 
 drivers/hwmon/gl520sm.c           |    3 
 drivers/hwmon/it87.c              |    3 
 drivers/hwmon/lm63.c              |    3 
 drivers/hwmon/lm75.c              |    3 
 drivers/hwmon/lm77.c              |    3 
 drivers/hwmon/lm78.c              |    3 
 drivers/hwmon/lm80.c              |    3 
 drivers/hwmon/lm83.c              |    3 
 drivers/hwmon/lm85.c              |    3 
 drivers/hwmon/lm87.c              |    3 
 drivers/hwmon/lm90.c              |    3 
 drivers/hwmon/lm92.c              |    3 
 drivers/hwmon/max1619.c           |    3 
 drivers/hwmon/sis5595.c           |    1 
 drivers/hwmon/smsc47m1.c          |    1 
 drivers/hwmon/via686a.c           |    1 
 drivers/hwmon/w83627hf.c          |    1 
 drivers/hwmon/w83781d.c           |    3 
 drivers/hwmon/w83792d.c           |    3 
 drivers/hwmon/w83l785ts.c         |    3 
 drivers/i2c/chips/ds1337.c        |    3 
 drivers/i2c/chips/eeprom.c        |    3 
 drivers/i2c/chips/max6875.c       |    3 
 drivers/i2c/chips/pca9539.c       |    3 
 drivers/i2c/chips/pcf8574.c       |    3 
 drivers/i2c/chips/pcf8591.c       |    3 
 include/linux/i2c-sensor.h        |  203 --------------------------------------
 include/linux/i2c.h               |  148 +++++++++++++++++++++++++--
 41 files changed, 188 insertions(+), 342 deletions(-)

--- linux-2.6.13-rc4.orig/Documentation/i2c/porting-clients	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/Documentation/i2c/porting-clients	2005-07-31 20:55:54.000000000 +0200
@@ -1,4 +1,4 @@
-Revision 4, 2004-03-30
+Revision 5, 2005-07-29
 Jean Delvare <khali@linux-fr.org>
 Greg KH <greg@kroah.com>
 
@@ -17,13 +17,12 @@
 
 Technical changes:
 
-* [Includes] Get rid of "version.h". Replace <linux/i2c-proc.h> with
-  <linux/i2c-sensor.h>. Includes typically look like that:
+* [Includes] Get rid of "version.h" and <linux/i2c-proc.h>.
+  Includes typically look like that:
   #include <linux/module.h>
   #include <linux/init.h>
   #include <linux/slab.h>
   #include <linux/i2c.h>
-  #include <linux/i2c-sensor.h>
   #include <linux/i2c-vid.h>	/* if you need VRM support */
   #include <asm/io.h>		/* if you have I/O operations */
   Please respect this inclusion order. Some extra headers may be
@@ -31,6 +30,7 @@
 
 * [Addresses] SENSORS_I2C_END becomes I2C_CLIENT_END, ISA addresses
   are no more handled by the i2c core.
+  SENSORS_INSMOD_<n> becomes I2C_CLIENT_INSMOD_<n>.
 
 * [Client data] Get rid of sysctl_id. Try using standard names for
   register values (for example, temp_os becomes temp_max). You're
--- linux-2.6.13-rc4.orig/Documentation/i2c/writing-clients	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/Documentation/i2c/writing-clients	2005-07-31 20:55:54.000000000 +0200
@@ -155,8 +155,8 @@
 
 
 
-Probing classes (i2c)
----------------------
+Probing classes
+---------------
 
 All parameters are given as lists of unsigned 16-bit integers. Lists are
 terminated by I2C_CLIENT_END.
@@ -171,12 +171,18 @@
    ignore: insmod parameter.
      A list of pairs. The first value is a bus number (-1 for any I2C bus), 
      the second is the I2C address. These addresses are never probed. 
-     This parameter overrules 'normal' and 'probe', but not the 'force' lists.
+     This parameter overrules the 'normal_i2c' list only.
    force: insmod parameter. 
      A list of pairs. The first value is a bus number (-1 for any I2C bus),
      the second is the I2C address. A device is blindly assumed to be on
      the given address, no probing is done. 
 
+Additionally, kind-specific force lists may optionally be defined if
+the driver supports several chip kinds. They are grouped in a
+NULL-terminated list of pointers named forces, those first element if the
+generic force list mentioned above. Each additional list correspond to an
+insmod parameter of the form force_<kind>.
+
 Fortunately, as a module writer, you just have to define the `normal_i2c' 
 parameter. The complete declaration could look like this:
 
@@ -186,61 +192,17 @@
 
   /* Magic definition of all other variables and things */
   I2C_CLIENT_INSMOD;
+  /* Or, if your driver supports, say, 2 kind of devices: */
+  I2C_CLIENT_INSMOD_2(foo, bar);
+
+If you use the multi-kind form, an enum will be defined for you:
+  enum chips { any_chip, foo, bar, ... }
+You can then (and certainly should) use it in the driver code.
 
 Note that you *have* to call the defined variable `normal_i2c',
 without any prefix!
 
 
-Probing classes (sensors)
--------------------------
-
-If you write a `sensors' driver, you use a slightly different interface.
-Also, we use a enum of chip types. Don't forget to include `sensors.h'.
-
-The following lists are used internally. They are all lists of integers.
-
-   normal_i2c: filled in by the module writer. Terminated by I2C_CLIENT_END.
-     A list of I2C addresses which should normally be examined.
-   probe: insmod parameter. Initialize this list with I2C_CLIENT_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
-     I2C bus), the second is the address. These addresses are also probed,
-     as if they were in the 'normal' list.
-   ignore: insmod parameter. Initialize this list with I2C_CLIENT_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
-     I2C bus), the second is the I2C address. These addresses are never
-     probed. This parameter overrules 'normal' and 'probe', but not the
-     'force' lists.
-
-Also used is a list of pointers to sensors_force_data structures:
-   force_data: insmod parameters. A list, ending with an element of which
-     the force field is NULL.
-     Each element contains the type of chip and a list of pairs.
-     The first value is a bus number (ANY_I2C_BUS for any I2C bus), the
-     second is the address.
-     These are automatically translated to insmod variables of the form
-     force_foo.
-
-So we have a generic insmod variabled `force', and chip-specific variables
-`force_CHIPNAME'.
-
-Fortunately, as a module writer, you just have to define the `normal_i2c' 
-parameter, and define what chip names are used. The complete declaration
-could look like this:
-  /* Scan i2c addresses 0x37, and 0x48 to 0x4f */
-  static unsigned short normal_i2c[] = { 0x37, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
-                                         0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
-
-  /* Define chips foo and bar, as well as all module parameters and things */
-  SENSORS_INSMOD_2(foo,bar);
-
-If you have one chip, you use macro SENSORS_INSMOD_1(chip), if you have 2
-you use macro SENSORS_INSMOD_2(chip1,chip2), etc. If you do not want to
-bother with chip types, you can use SENSORS_INSMOD_0.
-
-A enum is automatically defined as follows:
-  enum chips { any_chip, chip1, chip2, ... }
-
-
 Attaching to an adapter
 -----------------------
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1021.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1021.c	2005-07-31 20:55:54.000000000 +0200
@@ -24,7 +24,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 
@@ -36,7 +35,7 @@
 					I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
+I2C_CLIENT_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
 
 /* adm1021 constants specified below */
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1025.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1025.c	2005-07-31 20:55:54.000000000 +0200
@@ -50,7 +50,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -67,7 +66,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_2(adm1025, ne1619);
+I2C_CLIENT_INSMOD_2(adm1025, ne1619);
 
 /*
  * The ADM1025 registers
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1026.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1026.c	2005-07-31 20:55:54.000000000 +0200
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
@@ -38,7 +37,7 @@
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(adm1026);
+I2C_CLIENT_INSMOD_1(adm1026);
 
 static int gpio_input[17]  = { -1, -1, -1, -1, -1, -1, -1, -1, -1,
 				-1, -1, -1, -1, -1, -1, -1, -1 }; 
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1031.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1031.c	2005-07-31 20:55:54.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 
@@ -63,7 +62,7 @@
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_2(adm1030, adm1031);
+I2C_CLIENT_INSMOD_2(adm1030, adm1031);
 
 typedef u8 auto_chan_table_t[8][2];
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm9240.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm9240.c	2005-07-31 20:55:54.000000000 +0200
@@ -45,7 +45,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -55,7 +54,7 @@
 					I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_3(adm9240, ds1780, lm81);
+I2C_CLIENT_INSMOD_3(adm9240, ds1780, lm81);
 
 /* ADM9240 registers */
 #define ADM9240_REG_MAN_ID		0x3e
--- linux-2.6.13-rc4.orig/drivers/hwmon/asb100.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/asb100.c	2005-07-31 20:55:54.000000000 +0200
@@ -39,7 +39,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -57,7 +56,7 @@
 static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(asb100);
+I2C_CLIENT_INSMOD_1(asb100);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 	"{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/atxp1.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/atxp1.c	2005-07-31 20:55:54.000000000 +0200
@@ -23,7 +23,6 @@
 #include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -43,7 +42,7 @@
 
 static unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
 
-SENSORS_INSMOD_1(atxp1);
+I2C_CLIENT_INSMOD_1(atxp1);
 
 static int atxp1_attach_adapter(struct i2c_adapter * adapter);
 static int atxp1_detach_client(struct i2c_client * client);
--- linux-2.6.13-rc4.orig/drivers/hwmon/ds1621.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/ds1621.c	2005-07-31 20:55:54.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include "lm75.h"
@@ -36,7 +35,7 @@
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(ds1621);
+I2C_CLIENT_INSMOD_1(ds1621);
 static int polarity = -1;
 module_param(polarity, int, 0);
 MODULE_PARM_DESC(polarity, "Output's polarity: 0 = active high, 1 = active low");
--- linux-2.6.13-rc4.orig/drivers/hwmon/fscher.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/fscher.c	2005-07-31 20:55:54.000000000 +0200
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 
@@ -45,7 +44,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_1(fscher);
+I2C_CLIENT_INSMOD_1(fscher);
 
 /*
  * The FSCHER registers
--- linux-2.6.13-rc4.orig/drivers/hwmon/fscpos.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/fscpos.c	2005-07-31 20:55:54.000000000 +0200
@@ -34,7 +34,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/init.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -47,7 +46,7 @@
 /*
  * Insmod parameters
  */
-SENSORS_INSMOD_1(fscpos);
+I2C_CLIENT_INSMOD_1(fscpos);
 
 /*
  * The FSCPOS registers
--- linux-2.6.13-rc4.orig/drivers/hwmon/gl518sm.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/gl518sm.c	2005-07-31 20:55:54.000000000 +0200
@@ -41,7 +41,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 
@@ -49,7 +48,7 @@
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_2(gl518sm_r00, gl518sm_r80);
+I2C_CLIENT_INSMOD_2(gl518sm_r00, gl518sm_r80);
 
 /* Many GL518 constants specified below */
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/gl520sm.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/gl520sm.c	2005-07-31 20:55:54.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -40,7 +39,7 @@
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(gl520sm);
+I2C_CLIENT_INSMOD_1(gl520sm);
 
 /* Many GL520 constants specified below 
 One of the inputs can be configured as either temp or voltage.
--- linux-2.6.13-rc4.orig/drivers/hwmon/it87.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/it87.c	2005-07-31 20:55:54.000000000 +0200
@@ -37,7 +37,6 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
@@ -51,7 +50,7 @@
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
-SENSORS_INSMOD_2(it87, it8712);
+I2C_CLIENT_INSMOD_2(it87, it8712);
 
 #define	REG	0x2e	/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm63.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm63.c	2005-07-31 20:55:54.000000000 +0200
@@ -42,7 +42,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -58,7 +57,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_1(lm63);
+I2C_CLIENT_INSMOD_1(lm63);
 
 /*
  * The LM63 registers
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm75.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm75.c	2005-07-31 20:55:54.000000000 +0200
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include "lm75.h"
@@ -34,7 +33,7 @@
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(lm75);
+I2C_CLIENT_INSMOD_1(lm75);
 
 /* Many LM75 constants specified below */
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm77.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm77.c	2005-07-31 20:55:54.000000000 +0200
@@ -30,7 +30,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 
@@ -38,7 +37,7 @@
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(lm77);
+I2C_CLIENT_INSMOD_1(lm77);
 
 /* The LM77 registers */
 #define LM77_REG_TEMP		0x00
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm78.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm78.c	2005-07-31 20:55:54.000000000 +0200
@@ -24,7 +24,6 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <asm/io.h>
@@ -37,7 +36,7 @@
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
-SENSORS_INSMOD_2(lm78, lm79);
+I2C_CLIENT_INSMOD_2(lm78, lm79);
 
 /* Many LM78 constants specified below */
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm80.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm80.c	2005-07-31 20:55:54.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 
@@ -35,7 +34,7 @@
 					0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(lm80);
+I2C_CLIENT_INSMOD_1(lm80);
 
 /* Many LM80 constants specified below */
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm83.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm83.c	2005-07-31 20:55:54.000000000 +0200
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -52,7 +51,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_1(lm83);
+I2C_CLIENT_INSMOD_1(lm83);
 
 /*
  * The LM83 registers
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm85.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm85.c	2005-07-31 20:55:54.000000000 +0200
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -37,7 +36,7 @@
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);
+I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);
 
 /* The LM85 registers */
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm87.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm87.c	2005-07-31 20:55:54.000000000 +0200
@@ -57,7 +57,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -73,7 +72,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_1(lm87);
+I2C_CLIENT_INSMOD_1(lm87);
 
 /*
  * The LM87 registers
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm90.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm90.c	2005-07-31 20:55:54.000000000 +0200
@@ -75,7 +75,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -96,7 +95,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_6(lm90, adm1032, lm99, lm86, max6657, adt7461);
+I2C_CLIENT_INSMOD_6(lm90, adm1032, lm99, lm86, max6657, adt7461);
 
 /*
  * The LM90 registers
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm92.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm92.c	2005-07-31 20:55:54.000000000 +0200
@@ -44,7 +44,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 
@@ -54,7 +53,7 @@
 				       I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(lm92);
+I2C_CLIENT_INSMOD_1(lm92);
 
 /* The LM92 registers */
 #define LM92_REG_CONFIG			0x01 /* 8-bit, RW */
--- linux-2.6.13-rc4.orig/drivers/hwmon/max1619.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/max1619.c	2005-07-31 20:55:54.000000000 +0200
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 
@@ -44,7 +43,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_1(max1619);
+I2C_CLIENT_INSMOD_1(max1619);
 
 /*
  * The MAX1619 registers
--- linux-2.6.13-rc4.orig/drivers/hwmon/sis5595.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/sis5595.c	2005-07-31 20:55:54.000000000 +0200
@@ -56,7 +56,6 @@
 #include <linux/pci.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
--- linux-2.6.13-rc4.orig/drivers/hwmon/smsc47m1.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/smsc47m1.c	2005-07-31 20:55:54.000000000 +0200
@@ -31,7 +31,6 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
--- linux-2.6.13-rc4.orig/drivers/hwmon/via686a.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/via686a.c	2005-07-31 20:55:54.000000000 +0200
@@ -36,7 +36,6 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83627hf.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83627hf.c	2005-07-31 20:55:54.000000000 +0200
@@ -43,7 +43,6 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83781d.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83781d.c	2005-07-31 20:55:54.000000000 +0200
@@ -39,7 +39,6 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -53,7 +52,7 @@
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
-SENSORS_INSMOD_5(w83781d, w83782d, w83783s, w83627hf, as99127f);
+I2C_CLIENT_INSMOD_5(w83781d, w83782d, w83783s, w83627hf, as99127f);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83792d.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83792d.c	2005-07-31 20:55:54.000000000 +0200
@@ -40,7 +40,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -50,7 +49,7 @@
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(w83792d);
+I2C_CLIENT_INSMOD_1(w83792d);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 			"{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83l785ts.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83l785ts.c	2005-07-31 20:55:54.000000000 +0200
@@ -36,7 +36,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 
@@ -54,7 +53,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_1(w83l785ts);
+I2C_CLIENT_INSMOD_1(w83l785ts);
 
 /*
  * The W83L785TS-S registers
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/ds1337.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/ds1337.c	2005-07-31 20:55:54.000000000 +0200
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <linux/string.h>
 #include <linux/rtc.h>		/* get the user-level API */
 #include <linux/bcd.h>
@@ -40,7 +39,7 @@
  */
 static unsigned short normal_i2c[] = { 0x68, I2C_CLIENT_END };
 
-SENSORS_INSMOD_1(ds1337);
+I2C_CLIENT_INSMOD_1(ds1337);
 
 static int ds1337_attach_adapter(struct i2c_adapter *adapter);
 static int ds1337_detect(struct i2c_adapter *adapter, int address, int kind);
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/eeprom.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/eeprom.c	2005-07-31 20:55:54.000000000 +0200
@@ -33,14 +33,13 @@
 #include <linux/sched.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
 					0x55, 0x56, 0x57, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(eeprom);
+I2C_CLIENT_INSMOD_1(eeprom);
 
 
 /* Size of EEPROM in bytes */
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/max6875.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/max6875.c	2005-07-31 20:55:54.000000000 +0200
@@ -31,14 +31,13 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 #include <asm/semaphore.h>
 
 /* Do not scan - the MAX6875 access method will write to some EEPROM chips */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(max6875);
+I2C_CLIENT_INSMOD_1(max6875);
 
 /* The MAX6875 can only read/write 16 bytes at a time */
 #define SLICE_SIZE			16
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/pca9539.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/pca9539.c	2005-07-31 20:55:54.000000000 +0200
@@ -13,13 +13,12 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/hwmon-sysfs.h>
-#include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {0x74, 0x75, 0x76, 0x77, I2C_CLIENT_END};
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(pca9539);
+I2C_CLIENT_INSMOD_1(pca9539);
 
 enum pca9539_cmd
 {
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/pcf8574.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/pcf8574.c	2005-07-31 20:55:54.000000000 +0200
@@ -39,7 +39,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
@@ -47,7 +46,7 @@
 					I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_2(pcf8574, pcf8574a);
+I2C_CLIENT_INSMOD_2(pcf8574, pcf8574a);
 
 /* Initial values */
 #define PCF8574_INIT 255	/* All outputs on (input mode) */
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/pcf8591.c	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/pcf8591.c	2005-07-31 20:55:54.000000000 +0200
@@ -24,14 +24,13 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-sensor.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(pcf8591);
+I2C_CLIENT_INSMOD_1(pcf8591);
 
 static int input_mode;
 module_param(input_mode, int, 0);
--- linux-2.6.13-rc4.orig/include/linux/i2c-sensor.h	2005-07-31 16:50:47.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,203 +0,0 @@
-/*
-    i2c-sensor.h - Part of the i2c package
-    was originally sensors.h - Part of lm_sensors, Linux kernel modules
-                               for hardware monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-#ifndef _LINUX_I2C_SENSOR_H
-#define _LINUX_I2C_SENSOR_H
-
-#include <linux/i2c.h>
-
-#define SENSORS_MODULE_PARM_FORCE(name) \
-  I2C_CLIENT_MODULE_PARM(force_ ## name, \
-                      "List of adapter,address pairs which are unquestionably" \
-                      " assumed to contain a `" # name "' chip")
-
-
-/* This defines several insmod variables, and the addr_data structure */
-#define SENSORS_INSMOD \
-  I2C_CLIENT_MODULE_PARM(probe, \
-                      "List of adapter,address pairs to scan additionally"); \
-  I2C_CLIENT_MODULE_PARM(ignore, \
-                      "List of adapter,address pairs not to scan"); \
-	static struct i2c_client_address_data addr_data = {		\
-			.normal_i2c =		normal_i2c,		\
-			.probe =		probe,			\
-			.ignore =		ignore,			\
-			.forces =		forces,			\
-		}
-
-/* The following functions create an enum with the chip names as elements. 
-   The first element of the enum is any_chip. These are the only macros
-   a module will want to use. */
-
-#define SENSORS_INSMOD_0 \
-  enum chips { any_chip }; \
-  I2C_CLIENT_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  static unsigned short *forces[] = { force, \
-				      NULL }; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_1(chip1) \
-  enum chips { any_chip, chip1 }; \
-  I2C_CLIENT_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  static unsigned short *forces[] = { force, \
-				      force_##chip1, \
-				      NULL }; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_2(chip1,chip2) \
-  enum chips { any_chip, chip1, chip2 }; \
-  I2C_CLIENT_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  static unsigned short *forces[] = { force, \
-				      force_##chip1, \
-				      force_##chip2, \
-				      NULL }; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_3(chip1,chip2,chip3) \
-  enum chips { any_chip, chip1, chip2, chip3 }; \
-  I2C_CLIENT_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  static unsigned short *forces[] = { force, \
-				      force_##chip1, \
-				      force_##chip2, \
-				      force_##chip3, \
-				      NULL }; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_4(chip1,chip2,chip3,chip4) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4 }; \
-  I2C_CLIENT_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  static unsigned short *forces[] = { force, \
-				      force_##chip1, \
-				      force_##chip2, \
-				      force_##chip3, \
-				      force_##chip4, \
-				      NULL}; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_5(chip1,chip2,chip3,chip4,chip5) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 }; \
-  I2C_CLIENT_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  SENSORS_MODULE_PARM_FORCE(chip5); \
-  static unsigned short *forces[] = { force, \
-				      force_##chip1, \
-				      force_##chip2, \
-				      force_##chip3, \
-				      force_##chip4, \
-				      force_##chip5, \
-				      NULL }; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_6(chip1,chip2,chip3,chip4,chip5,chip6) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 }; \
-  I2C_CLIENT_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  SENSORS_MODULE_PARM_FORCE(chip5); \
-  SENSORS_MODULE_PARM_FORCE(chip6); \
-  static unsigned short *forces[] = { force, \
-				      force_##chip1, \
-				      force_##chip2, \
-				      force_##chip3, \
-				      force_##chip4, \
-				      force_##chip5, \
-				      force_##chip6, \
-				      NULL }; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_7(chip1,chip2,chip3,chip4,chip5,chip6,chip7) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7 }; \
-  I2C_CLIENT_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  SENSORS_MODULE_PARM_FORCE(chip5); \
-  SENSORS_MODULE_PARM_FORCE(chip6); \
-  SENSORS_MODULE_PARM_FORCE(chip7); \
-  static unsigned short *forces[] = { force, \
-				      force_##chip1, \
-				      force_##chip2, \
-				      force_##chip3, \
-				      force_##chip4, \
-				      force_##chip5, \
-				      force_##chip6, \
-				      force_##chip7, \
-				      NULL }; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_8(chip1,chip2,chip3,chip4,chip5,chip6,chip7,chip8) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8 }; \
-  I2C_CLIENT_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  SENSORS_MODULE_PARM_FORCE(chip5); \
-  SENSORS_MODULE_PARM_FORCE(chip6); \
-  SENSORS_MODULE_PARM_FORCE(chip7); \
-  SENSORS_MODULE_PARM_FORCE(chip8); \
-  static unsigned short *forces[] = { force, \
-				      force_##chip1, \
-				      force_##chip2, \
-				      force_##chip3, \
-				      force_##chip4, \
-				      force_##chip5, \
-				      force_##chip6, \
-				      force_##chip7, \
-				      force_##chip8, \
-				      NULL }; \
-  SENSORS_INSMOD
-
-#endif				/* def _LINUX_I2C_SENSOR_H */
--- linux-2.6.13-rc4.orig/include/linux/i2c.h	2005-07-31 16:50:47.000000000 +0200
+++ linux-2.6.13-rc4/include/linux/i2c.h	2005-07-31 20:55:54.000000000 +0200
@@ -565,24 +565,148 @@
   module_param_array(var, short, &var##_num, 0); \
   MODULE_PARM_DESC(var,desc)
 
-/* This is the one you want to use in your own modules */
+#define I2C_CLIENT_MODULE_PARM_FORCE(name)				\
+I2C_CLIENT_MODULE_PARM(force_##name,					\
+		       "List of adapter,address pairs which are "	\
+		       "unquestionably assumed to contain a `"		\
+		       # name "' chip")
+
+
+#define I2C_CLIENT_INSMOD_COMMON					\
+I2C_CLIENT_MODULE_PARM(probe, "List of adapter,address pairs to scan "	\
+		       "additionally");					\
+I2C_CLIENT_MODULE_PARM(ignore, "List of adapter,address pairs not to "	\
+		       "scan");						\
+static struct i2c_client_address_data addr_data = {			\
+	.normal_i2c	= normal_i2c,					\
+	.probe		= probe,					\
+	.ignore		= ignore,					\
+	.forces		= forces,					\
+}
+
+/* These are the ones you want to use in your own drivers. Pick the one
+   which matches the number of devices the driver differenciates between. */
 #define I2C_CLIENT_INSMOD \
-  I2C_CLIENT_MODULE_PARM(probe, \
-                      "List of adapter,address pairs to scan additionally"); \
-  I2C_CLIENT_MODULE_PARM(ignore, \
-                      "List of adapter,address pairs not to scan"); \
   I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
-	static unsigned short *addr_forces[] = {			\
+	static unsigned short *forces[] = {				\
 			force,						\
 			NULL						\
 		};							\
-	static struct i2c_client_address_data addr_data = {		\
-			.normal_i2c = 		normal_i2c,		\
-			.probe =		probe,			\
-			.ignore =		ignore,			\
-			.forces =		addr_forces,		\
-		}
+I2C_CLIENT_INSMOD_COMMON
+
+#define I2C_CLIENT_INSMOD_1(chip1)					\
+enum chips { any_chip, chip1 };						\
+I2C_CLIENT_MODULE_PARM(force, "List of adapter,address pairs to "	\
+		       "boldly assume to be present");			\
+I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
+static unsigned short *forces[] = { force, force_##chip1, NULL };	\
+I2C_CLIENT_INSMOD_COMMON
+
+#define I2C_CLIENT_INSMOD_2(chip1, chip2)				\
+enum chips { any_chip, chip1, chip2 };					\
+I2C_CLIENT_MODULE_PARM(force, "List of adapter,address pairs to "	\
+		       "boldly assume to be present");			\
+I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
+static unsigned short *forces[] = { force, force_##chip1,		\
+				    force_##chip2, NULL };		\
+I2C_CLIENT_INSMOD_COMMON
+
+#define I2C_CLIENT_INSMOD_3(chip1, chip2, chip3)			\
+enum chips { any_chip, chip1, chip2, chip3 };				\
+I2C_CLIENT_MODULE_PARM(force, "List of adapter,address pairs to "	\
+		       "boldly assume to be present");			\
+I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
+static unsigned short *forces[] = { force, force_##chip1,		\
+				    force_##chip2, force_##chip3,	\
+				    NULL };				\
+I2C_CLIENT_INSMOD_COMMON
+
+#define I2C_CLIENT_INSMOD_4(chip1, chip2, chip3, chip4)			\
+enum chips { any_chip, chip1, chip2, chip3, chip4 };			\
+I2C_CLIENT_MODULE_PARM(force, "List of adapter,address pairs to "	\
+		       "boldly assume to be present");			\
+I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
+static unsigned short *forces[] = { force, force_##chip1,		\
+				    force_##chip2, force_##chip3,	\
+				    force_##chip4, NULL};		\
+I2C_CLIENT_INSMOD_COMMON
+
+#define I2C_CLIENT_INSMOD_5(chip1, chip2, chip3, chip4, chip5)		\
+enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 };		\
+I2C_CLIENT_MODULE_PARM(force, "List of adapter,address pairs to "	\
+		       "boldly assume to be present");			\
+I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip5);					\
+static unsigned short *forces[] = { force, force_##chip1,		\
+				    force_##chip2, force_##chip3,	\
+				    force_##chip4, force_##chip5,	\
+				    NULL };				\
+I2C_CLIENT_INSMOD_COMMON
+
+#define I2C_CLIENT_INSMOD_6(chip1, chip2, chip3, chip4, chip5, chip6)	\
+enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 };	\
+I2C_CLIENT_MODULE_PARM(force, "List of adapter,address pairs to "	\
+		       "boldly assume to be present");			\
+I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip5);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip6);					\
+static unsigned short *forces[] = { force, force_##chip1,		\
+				    force_##chip2, force_##chip3,	\
+				    force_##chip4, force_##chip5,	\
+				    force_##chip6, NULL };		\
+I2C_CLIENT_INSMOD_COMMON
+
+#define I2C_CLIENT_INSMOD_7(chip1, chip2, chip3, chip4, chip5, chip6, chip7) \
+enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,	\
+	     chip7 };							\
+I2C_CLIENT_MODULE_PARM(force, "List of adapter,address pairs to "	\
+		       "boldly assume to be present");			\
+I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip5);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip6);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip7);					\
+static unsigned short *forces[] = { force, force_##chip1,		\
+				    force_##chip2, force_##chip3,	\
+				    force_##chip4, force_##chip5,	\
+				    force_##chip6, force_##chip7,	\
+				    NULL };				\
+I2C_CLIENT_INSMOD_COMMON
+
+#define I2C_CLIENT_INSMOD_8(chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8) \
+enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,	\
+	     chip7, chip8 };						\
+I2C_CLIENT_MODULE_PARM(force, "List of adapter,address pairs to "	\
+		       "boldly assume to be present");			\
+I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip5);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip6);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip7);					\
+I2C_CLIENT_MODULE_PARM_FORCE(chip8);					\
+static unsigned short *forces[] = { force, force_##chip1,		\
+				    force_##chip2, force_##chip3,	\
+				    force_##chip4, force_##chip5,	\
+				    force_##chip6, force_##chip7,	\
+				    force_##chip8, NULL };		\
+I2C_CLIENT_INSMOD_COMMON
 
 #endif /* _LINUX_I2C_H */


-- 
Jean Delvare
