Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSJJOUo>; Thu, 10 Oct 2002 10:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSJJOUn>; Thu, 10 Oct 2002 10:20:43 -0400
Received: from h-64-105-35-49.SNVACAID.covad.net ([64.105.35.49]:60801 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261594AbSJJOUk>; Thu, 10 Oct 2002 10:20:40 -0400
Date: Thu, 10 Oct 2002 07:26:18 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andre@linux-ide.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.41/drivers/ide - build IDE as a module
Message-ID: <20021010072618.A918@baldur.yggdrasil.com>
References: <20021010064457.A460@baldur.yggdrasil.com> <1034259516.6463.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1034259516.6463.10.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 10, 2002 at 03:18:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2002 at 03:18:36PM +0100, Alan Cox wrote:
> I'll go over it again, but I have no major problem with applying them
> and working from there to clean up the corners. Firstly however do one
> little thing - dont put extern blah() in the code, add them to the right
> header files.

	Sure.  Here is the updated patch.  I've verified that it
compiles without complaint.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide.diffs"

diff -u -r linux-2.5.41/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.41/drivers/ide/Config.in	2002-10-07 11:23:27.000000000 -0700
+++ linux/drivers/ide/Config.in	2002-10-10 06:25:31.000000000 -0700
@@ -27,13 +27,13 @@
 
    comment 'IDE chipset support/bugfixes'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
-      dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
+      dep_tristate '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86 $CONFIG_BLK_DEV_IDE
       dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
       dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
       if [ "$CONFIG_PCI" = "y" ]; then
 	 bool '  PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI
 	 if [ "$CONFIG_BLK_DEV_IDEPCI" = "y" ]; then
-	    dep_bool '    Generic PCI IDE Chipset Support' CONFIG_BLK_DEV_GENERIC $CONFIG_BLK_DEV_IDEPCI
+	    dep_tristate '    Generic PCI IDE Chipset Support' CONFIG_BLK_DEV_GENERIC $CONFIG_BLK_DEV_IDEPCI $CONFIG_BLK_DEV_IDE
 	    bool '    Sharing PCI IDE interrupts support' CONFIG_IDEPCI_SHARE_IRQ
 	    bool '    Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA_PCI
 	    bool '    Boot off-board chipsets first support' CONFIG_BLK_DEV_OFFBOARD
diff -u -r linux-2.5.41/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.41/drivers/ide/Makefile	2002-10-07 11:24:36.000000000 -0700
+++ linux/drivers/ide/Makefile	2002-10-08 05:34:20.000000000 -0700
@@ -14,19 +14,20 @@
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o
+ide-mod-objs				:= ide.o ide-iops.o ide-taskfile.o ide-probe.o ide-geometry.o ide-lib.o
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-mod.o
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-mod.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
 
-obj-$(CONFIG_BLK_DEV_IDEPCI)		+= setup-pci.o
-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
-obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
-
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
-endif
+obj-ide-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
+obj-ide-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+obj-ide-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
+obj-ide-$(CONFIG_PROC_FS)		+= ide-proc.o
+ide-mod-objs				+= $(obj-ide-y)
+
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ ppc/ arm/
 
diff -u -r linux-2.5.41/drivers/ide/ide-pnp.c linux/drivers/ide/ide-pnp.c
--- linux-2.5.41/drivers/ide/ide-pnp.c	2002-10-07 11:24:41.000000000 -0700
+++ linux/drivers/ide/ide-pnp.c	2002-10-07 18:45:37.000000000 -0700
@@ -19,6 +19,7 @@
 #include <linux/ide.h>
 #include <linux/init.h>
 
+#include <linux/module.h>
 #include <linux/isapnp.h>
 
 #define DEV_IO(dev, index) (dev->resource[index].start)
@@ -88,6 +89,18 @@
 	{	0 }
 };
 
+#ifdef MODULE
+static struct isapnp_card_id ide_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('P', 'N', 'P', 0x0600) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ide_isa_ids);
+#endif
+
 #define NR_PNP_DEVICES 8
 struct pnp_dev_inst {
 	struct pci_dev *dev;
diff -u -r linux-2.5.41/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.41/drivers/ide/ide-probe.c	2002-10-07 11:24:39.000000000 -0700
+++ linux/drivers/ide/ide-probe.c	2002-10-08 05:34:20.000000000 -0700
@@ -1126,10 +1126,10 @@
 	return 0;
 }
 
-#ifdef MODULE
-extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
+int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
+EXPORT_SYMBOL(ide_xlate_1024_hook);
 
-int init_module (void)
+int ide_probe_init (void)
 {
 	unsigned int index;
 	
@@ -1141,10 +1141,9 @@
 	return 0;
 }
 
-void cleanup_module (void)
+void ide_probe_cleanup (void)
 {
 	ide_probe = NULL;
 	ide_xlate_1024_hook = 0;
 }
 MODULE_LICENSE("GPL");
-#endif /* MODULE */
diff -u -r linux-2.5.41/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.41/drivers/ide/ide.c	2002-10-07 11:24:00.000000000 -0700
+++ linux/drivers/ide/ide.c	2002-10-10 07:22:02.000000000 -0700
@@ -197,6 +197,9 @@
 
 EXPORT_SYMBOL(noautodma);
 
+int cmd640_vlb;			/* = 0, flag for cmd640.c */
+EXPORT_SYMBOL(cmd640_vlb);
+
 /*
  * ide_modules keeps track of the available IDE chipset/probe/driver modules.
  */
@@ -3006,7 +3009,6 @@
 #ifdef CONFIG_BLK_DEV_CMD640
 			case -14: /* "cmd640_vlb" */
 			{
-				extern int cmd640_vlb; /* flag for cmd640.c */
 				cmd640_vlb = 1;
 				goto done;
 			}
@@ -3123,12 +3125,6 @@
 		init_e100_ide();
 	}
 #endif /* CONFIG_ETRAX_IDE */
-#ifdef CONFIG_BLK_DEV_CMD640
-	{
-		extern void ide_probe_for_cmd640x(void);
-		ide_probe_for_cmd640x();
-	}
-#endif /* CONFIG_BLK_DEV_CMD640 */
 #ifdef CONFIG_BLK_DEV_PDC4030
 	{
 		extern int ide_probe_for_pdc4030(void);
@@ -3514,6 +3510,27 @@
 struct bus_type ide_bus_type = {
 	.name		= "ide",
 };
+EXPORT_SYMBOL(ide_bus_type);
+
+#ifdef MODULE
+static char *options = NULL;
+MODULE_PARM(options,"s");
+MODULE_LICENSE("GPL");
+
+static void __init parse_options (char *line)
+{
+	char *next = line;
+
+	if (line == NULL || !*line)
+		return;
+	while ((line = next) != NULL) {
+ 		if ((next = strchr(line,' ')) != NULL)
+			*next++ = 0;
+		if (!ide_setup(line))
+			printk ("Unknown option '%s'\n", line);
+	}
+}
+#endif /* MODULE */
 
 /*
  * This is gets invoked once during initialization, to set *everything* up
@@ -3521,6 +3538,9 @@
 int __init ide_init (void)
 {
 	static char banner_printed;
+#ifdef MODULE
+	parse_options(options);
+#endif
 	if (!banner_printed) {
 		printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
 		ide_devfs_handle = devfs_mk_dir(NULL, "ide", NULL);
@@ -3537,40 +3557,16 @@
 	initializing = 0;
 
 	register_reboot_notifier(&ide_notifier);
-	return 0;
+	return ide_probe_init();
 }
 
 module_init(ide_init);
 
-#ifdef MODULE
-char *options = NULL;
-MODULE_PARM(options,"s");
-MODULE_LICENSE("GPL");
-
-static void __init parse_options (char *line)
-{
-	char *next = line;
-
-	if (line == NULL || !*line)
-		return;
-	while ((line = next) != NULL) {
- 		if ((next = strchr(line,' ')) != NULL)
-			*next++ = 0;
-		if (!ide_setup(line))
-			printk ("Unknown option '%s'\n", line);
-	}
-}
-
-int init_module (void)
-{
-	parse_options(options);
-	return ide_init();
-}
-
-void cleanup_module (void)
+static void __exit ide_cleanup (void)
 {
 	int index;
 
+	ide_probe_cleanup();
 	unregister_reboot_notifier(&ide_notifier);
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		ide_unregister(index);
@@ -3585,11 +3581,8 @@
 #endif
 	devfs_unregister (ide_devfs_handle);
 
-	bus_unregister(&ide_bus_type);
+	put_bus(&ide_bus_type);
 }
-
-#else /* !MODULE */
+module_exit(ide_cleanup);
 
 __setup("", ide_setup);
-
-#endif /* MODULE */
diff -u -r linux-2.5.41/drivers/ide/pci/cmd640.c linux/drivers/ide/pci/cmd640.c
--- linux-2.5.41/drivers/ide/pci/cmd640.c	2002-10-07 11:25:15.000000000 -0700
+++ linux/drivers/ide/pci/cmd640.c	2002-10-10 06:25:31.000000000 -0700
@@ -102,6 +102,7 @@
 #define CMD640_PREFETCH_MASKS 1
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -120,7 +121,7 @@
 /*
  * This flag is set in ide.c by the parameter:  ide0=cmd640_vlb
  */
-int cmd640_vlb = 0;
+extern int cmd640_vlb;
 
 /*
  * CMD640 specific registers definition.
@@ -723,7 +724,7 @@
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
  */
-int __init ide_probe_for_cmd640x (void)
+static int ide_probe_for_cmd640x (void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled = 0;
@@ -883,4 +884,4 @@
 #endif
 	return 1;
 }
-
+module_init(ide_probe_for_cmd640x);
--- linux-2.5.41/include/linux/ide.h	2002-10-07 11:24:05.000000000 -0700
+++ linux/include/linux/ide.h	2002-10-10 07:22:02.000000000 -0700
@@ -1704,6 +1704,9 @@
 extern char *ide_xfer_verbose(u8 xfer_rate);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 
+/* ide.c */
+extern int ide_probe_init(void);
+extern void ide_probe_cleanup(void);
 extern spinlock_t ide_lock;
 
 #define local_irq_set(flags)	do { local_save_flags((flags)); local_irq_enable(); } while (0)

--oyUTqETQ0mS9luUI--
