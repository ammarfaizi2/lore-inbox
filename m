Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270033AbUJUHGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270033AbUJUHGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270327AbUJUHFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:05:55 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:13448 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269192AbUJUG7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:59:50 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Sonypi: switch to module_param
Date: Thu, 21 Oct 2004 01:57:19 -0500
User-Agent: KMail/1.6.2
Cc: stelian@popies.net
References: <200410210154.58301.dtor_core@ameritech.net> <200410210156.27067.dtor_core@ameritech.net>
In-Reply-To: <200410210156.27067.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210157.22833.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1977, 2004-10-21 01:44:25-05:00, dtor_core@ameritech.net
  Sonypi: convert to use new style of mocule parameters (module_param).
          See Documentation/kernel-parameters.txt for new syntax.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Documentation/kernel-parameters.txt |   19 +++++
 drivers/char/sonypi.c               |  122 ++++++++++++++++++------------------
 drivers/char/sonypi.h               |   31 ---------
 3 files changed, 81 insertions(+), 91 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-10-21 01:54:11 -05:00
+++ b/Documentation/kernel-parameters.txt	2004-10-21 01:54:11 -05:00
@@ -1219,8 +1219,23 @@
 	sonycd535=	[HW,CD]
 			Format: <io>[,<irq>]
 
-	sonypi=		[HW] Sony Programmable I/O Control Device driver
-			Format: <minor>,<verbose>,<fnkeyinit>,<camera>,<compat>,<nojogdial>
+	sonypi.*	[HW] Sony Programmable I/O Control Device driver
+		camera	Activate control of MotionEye camera, default is 0 (off)
+			Format: <camera> - boolean, default is off
+		compat	Trun on compatibility mode
+			Format: <compat> - boolean, default is off
+		fnkeyinit
+			Force initialization of FN-keys, default is 0 (off)
+			Format: <fnkeyinit> - boolean, default is off
+		mask=	Event mask
+			Format: <minor> - integer, default is 0xffffffff (all)
+		minor=	Minor number of the misc device
+			Format: <minor> - integer, default is -1 (auto)
+		useinput
+			Report events from jogdial through input core,
+			Format: <useinput> - boolean, default is on
+		verbose	Verbose event reporting
+			Format: <verbose> - boolean, default is off
 
 	specialix=	[HW,SERIAL] Specialix multi-serial port adapter
 			See Documentation/specialix.txt.
diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-21 01:54:11 -05:00
+++ b/drivers/char/sonypi.c	2004-10-21 01:54:11 -05:00
@@ -50,18 +50,46 @@
 #include <asm/io.h>
 #include <asm/system.h>
 
-static int verbose; /* = 0 */
-
 #include "sonypi.h"
 #include <linux/sonypi.h>
 
-static struct sonypi_device sonypi_device;
+MODULE_AUTHOR("Stelian Pop <stelian@popies.net>");
+MODULE_DESCRIPTION("Sony Programmable I/O Control Device driver");
+MODULE_LICENSE("GPL");
+
 static int minor = -1;
+module_param(minor, uint, 0);
+MODULE_PARM_DESC(minor, "minor number of the misc device, default is -1 (automatic)");
+
+static int verbose; /* = 0 */
+module_param(verbose, bool, 600);
+MODULE_PARM_DESC(verbose, "be verbose, default is 0 (no)");
+
 static int fnkeyinit; /* = 0 */
+module_param(fnkeyinit, bool, 0);
+MODULE_PARM_DESC(fnkeyinit, "set this if your Fn keys do not generate any event");
+
 static int camera; /* = 0 */
+module_param(camera, bool, 0);
+MODULE_PARM_DESC(camera, "set this if you have a MotionEye camera (PictureBook series)");
+
 static int compat; /* = 0 */
-static int useinput = 1;
+module_param(compat, bool, 0);
+MODULE_PARM_DESC(compat, "set this if you want to enable backward compatibility mode");
+
 static unsigned long mask = 0xffffffff;
+module_param(mask, ulong, 600);
+MODULE_PARM_DESC(mask, "set this to the mask of event you want to enable (see doc)");
+
+#ifdef SONYPI_USE_INPUT
+static int useinput = 1;
+module_param(useinput, bool, 0);
+MODULE_PARM_DESC(useinput, "if you have a jogdial, set this if you would like it to use the modern Linux Input Driver system");
+#else
+static int useinput; /* = 0 */
+#endif
+
+static struct sonypi_device sonypi_device;
 
 /* Inits the queue */
 static inline void sonypi_initq(void)
@@ -125,6 +153,38 @@
         return result;
 }
 
+static int sonypi_ec_write(u8 addr, u8 value)
+{
+#ifdef CONFIG_ACPI_EC
+	if (SONYPI_ACPI_ACTIVE)
+		return ec_write(addr, value);
+#endif
+	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
+	outb_p(0x81, SONYPI_CST_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	outb_p(addr, SONYPI_DATA_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	outb_p(value, SONYPI_DATA_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	return 0;
+}
+
+static int sonypi_ec_read(u8 addr, u8 *value)
+{
+#ifdef CONFIG_ACPI_EC
+	if (SONYPI_ACPI_ACTIVE)
+		return ec_read(addr, value);
+#endif
+	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
+	outb_p(0x80, SONYPI_CST_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	outb_p(addr, SONYPI_DATA_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	*value = inb_p(SONYPI_DATA_IOPORT);
+	return 0;
+}
+
+
 static int ec_read16(u8 addr, u16 *value)
 {
 	u8 val_lb, val_hb;
@@ -932,62 +992,8 @@
 	sonypi_remove();
 }
 
-#ifndef MODULE
-static int __init sonypi_setup(char *str)
-{
-	int ints[8];
-
-	str = get_options(str, ARRAY_SIZE(ints), ints);
-	if (ints[0] <= 0)
-		goto out;
-	minor = ints[1];
-	if (ints[0] == 1)
-		goto out;
-	verbose = ints[2];
-	if (ints[0] == 2)
-		goto out;
-	fnkeyinit = ints[3];
-	if (ints[0] == 3)
-		goto out;
-	camera = ints[4];
-	if (ints[0] == 4)
-		goto out;
-	compat = ints[5];
-	if (ints[0] == 5)
-		goto out;
-	mask = ints[6];
-	if (ints[0] == 6)
-		goto out;
-	useinput = ints[7];
-out:
-	return 1;
-}
-
-__setup("sonypi=", sonypi_setup);
-#endif /* !MODULE */
-
 /* Module entry points */
 module_init(sonypi_init_module);
 module_exit(sonypi_cleanup_module);
-
-MODULE_AUTHOR("Stelian Pop <stelian@popies.net>");
-MODULE_DESCRIPTION("Sony Programmable I/O Control Device driver");
-MODULE_LICENSE("GPL");
-
-
-MODULE_PARM(minor,"i");
-MODULE_PARM_DESC(minor, "minor number of the misc device, default is -1 (automatic)");
-MODULE_PARM(verbose,"i");
-MODULE_PARM_DESC(verbose, "be verbose, default is 0 (no)");
-MODULE_PARM(fnkeyinit,"i");
-MODULE_PARM_DESC(fnkeyinit, "set this if your Fn keys do not generate any event");
-MODULE_PARM(camera,"i");
-MODULE_PARM_DESC(camera, "set this if you have a MotionEye camera (PictureBook series)");
-MODULE_PARM(compat,"i");
-MODULE_PARM_DESC(compat, "set this if you want to enable backward compatibility mode");
-MODULE_PARM(mask, "i");
-MODULE_PARM_DESC(mask, "set this to the mask of event you want to enable (see doc)");
-MODULE_PARM(useinput, "i");
-MODULE_PARM_DESC(useinput, "if you have a jogdial, set this if you would like it to use the modern Linux Input Driver system");
 
 EXPORT_SYMBOL(sonypi_camera_command);
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-21 01:54:10 -05:00
+++ b/drivers/char/sonypi.h	2004-10-21 01:54:10 -05:00
@@ -401,37 +401,6 @@
 #define SONYPI_ACPI_ACTIVE 0
 #endif /* CONFIG_ACPI */
 
-static inline int sonypi_ec_write(u8 addr, u8 value)
-{
-#ifdef CONFIG_ACPI_EC
-	if (SONYPI_ACPI_ACTIVE)
-		return ec_write(addr, value);
-#endif
-	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
-	outb_p(0x81, SONYPI_CST_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
-	outb_p(addr, SONYPI_DATA_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
-	outb_p(value, SONYPI_DATA_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
-	return 0;
-}
-
-static inline int sonypi_ec_read(u8 addr, u8 *value)
-{
-#ifdef CONFIG_ACPI_EC
-	if (SONYPI_ACPI_ACTIVE)
-		return ec_read(addr, value);
-#endif
-	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
-	outb_p(0x80, SONYPI_CST_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
-	outb_p(addr, SONYPI_DATA_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
-	*value = inb_p(SONYPI_DATA_IOPORT);
-	return 0;
-}
-
 #endif /* __KERNEL__ */
 
 #endif /* _SONYPI_PRIV_H_ */
