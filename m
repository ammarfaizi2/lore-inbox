Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbUJ1KIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbUJ1KIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbUJ1KIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:08:14 -0400
Received: from sd291.sivit.org ([194.146.225.122]:35478 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262871AbUJ1KFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:05:11 -0400
Date: Thu, 28 Oct 2004 12:06:34 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/8] sonypi: module related fixes
Message-ID: <20041028100634.GB3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041028100525.GA3893@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028100525.GA3893@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2191, 2004-10-27 16:28:44+02:00, stelian@popies.net
  sonypi: module related fixes
  	* use module_param() instead of MODULE_PARM() and __setup()
  	* use MODULE_VERSION()

  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 Documentation/kernel-parameters.txt |    4 
 Documentation/sonypi.txt            |   11 --
 drivers/char/sonypi.c               |  147 ++++++++++++++++++------------------
 drivers/char/sonypi.h               |   32 -------
 4 files changed, 84 insertions(+), 110 deletions(-)

===================================================================

diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-10-28 11:01:10 +02:00
+++ b/Documentation/kernel-parameters.txt	2004-10-28 11:01:10 +02:00
@@ -1217,8 +1217,8 @@
 	sonycd535=	[HW,CD]
 			Format: <io>[,<irq>]
 
-	sonypi=		[HW] Sony Programmable I/O Control Device driver
-			Format: <minor>,<verbose>,<fnkeyinit>,<camera>,<compat>,<nojogdial>
+	sonypi.*=	[HW] Sony Programmable I/O Control Device driver
+			See Documentation/sonypi.txt
 
 	specialix=	[HW,SERIAL] Specialix multi-serial port adapter
 			See Documentation/specialix.txt.
diff -Nru a/Documentation/sonypi.txt b/Documentation/sonypi.txt
--- a/Documentation/sonypi.txt	2004-10-28 11:01:09 +02:00
+++ b/Documentation/sonypi.txt	2004-10-28 11:01:09 +02:00
@@ -42,13 +42,10 @@
 Driver options:
 ---------------
 
-Several options can be passed to the sonypi driver, either by adding them
-to /etc/modprobe.conf file, when the driver is compiled as a module or by
-adding the following to the kernel command line (in your bootloader):
-
-	sonypi=minor[,verbose[,fnkeyinit[,camera[,compat[,mask[,useinput]]]]]]
-
-where:
+Several options can be passed to the sonypi driver using the standard
+module argument syntax (<param>=<value> when passing the option to the
+module or sonypi.<param>=<value> on the kernel boot line when sonypi is
+statically linked into the kernel). Those options are:
 
 	minor: 		minor number of the misc device /dev/sonypi, 
 			default is -1 (automatic allocation, see /proc/misc
diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-28 11:01:10 +02:00
+++ b/drivers/char/sonypi.c	2004-10-28 11:01:10 +02:00
@@ -50,18 +50,80 @@
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
+MODULE_VERSION(SONYPI_DRIVER_VERSION);
+
 static int minor = -1;
-static int fnkeyinit; /* = 0 */
-static int camera; /* = 0 */
-static int compat; /* = 0 */
-static int useinput = 1;
+module_param(minor, int, 0);
+MODULE_PARM_DESC(minor,
+		 "minor number of the misc device, default is -1 (automatic)");
+
+static int verbose;		/* = 0 */
+module_param(verbose, int, 0644);
+MODULE_PARM_DESC(verbose, "be verbose, default is 0 (no)");
+
+static int fnkeyinit;		/* = 0 */
+module_param(fnkeyinit, int, 0444);
+MODULE_PARM_DESC(fnkeyinit,
+		 "set this if your Fn keys do not generate any event");
+
+static int camera;		/* = 0 */
+module_param(camera, int, 0444);
+MODULE_PARM_DESC(camera,
+		 "set this if you have a MotionEye camera (PictureBook series)");
+
+static int compat;		/* = 0 */
+module_param(compat, int, 0444);
+MODULE_PARM_DESC(compat,
+		 "set this if you want to enable backward compatibility mode");
+
 static unsigned long mask = 0xffffffff;
+module_param(mask, ulong, 0644);
+MODULE_PARM_DESC(mask,
+		 "set this to the mask of event you want to enable (see doc)");
+
+static int useinput = 1;
+module_param(useinput, int, 0444);
+MODULE_PARM_DESC(useinput,
+		 "set this if you would like sonypi to feed events to the input subsystem");
+
+static struct sonypi_device sonypi_device;
+
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
 
 /* Inits the queue */
 static inline void sonypi_initq(void) {
@@ -437,6 +499,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(sonypi_camera_command);
+
 static int sonypi_misc_fasync(int fd, struct file *filp, int on) {
 	int retval;
 
@@ -780,9 +844,8 @@
 	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
 		outb(0xf0, 0xb2);
 
-	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%d.%d.\n",
-	       SONYPI_DRIVER_MAJORVERSION,
-	       SONYPI_DRIVER_MINORVERSION);
+	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%s.\n",
+	       SONYPI_DRIVER_VERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
 	       "verbose = %d, fnkeyinit = %s, camera = %s, "
 	       "compat = %s, mask = 0x%08lx, useinput = %s, acpi = %s\n",
@@ -887,7 +950,7 @@
 	{ }
 };
 
-static int __init sonypi_init_module(void)
+static int __init sonypi_init(void)
 {
 	struct pci_dev *pcidev = NULL;
 	if (dmi_check_system(sonypi_dmi_table)) {
@@ -900,65 +963,9 @@
 		return -ENODEV;
 }
 
-static void __exit sonypi_cleanup_module(void) {
+static void __exit sonypi_exit(void) {
 	sonypi_remove();
 }
 
-#ifndef MODULE
-static int __init sonypi_setup(char *str)  {
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
-/* Module entry points */
-module_init(sonypi_init_module);
-module_exit(sonypi_cleanup_module);
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
-
-EXPORT_SYMBOL(sonypi_camera_command);
+module_init(sonypi_init);
+module_exit(sonypi_exit);
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-28 11:01:10 +02:00
+++ b/drivers/char/sonypi.h	2004-10-28 11:01:10 +02:00
@@ -36,8 +36,7 @@
 
 #ifdef __KERNEL__
 
-#define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	23
+#define SONYPI_DRIVER_VERSION	 "1.23"
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
@@ -400,35 +399,6 @@
 #else
 #define SONYPI_ACPI_ACTIVE 0
 #endif /* CONFIG_ACPI */
-
-static inline int sonypi_ec_write(u8 addr, u8 value) {
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
-static inline int sonypi_ec_read(u8 addr, u8 *value) {
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
 
 #endif /* __KERNEL__ */
 
