Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262177AbREQCiu>; Wed, 16 May 2001 22:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbREQCim>; Wed, 16 May 2001 22:38:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57059 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262177AbREQCic>;
	Wed, 16 May 2001 22:38:32 -0400
Date: Wed, 16 May 2001 22:38:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] more initcall cleanups
Message-ID: <Pine.GSO.4.21.0105162217530.27492-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, I've done a bit more cleaning the device initialization
up (beginning of chr_dev_init()) and results were, well, interesting.

	a) I2C stuff got converted to module_init() nicely. That took
a lot of cruft away.

	b) init order is preserved. However, that worked only because
none of the i2c initialization functions touch stuff from random.c

	c) I had to put i2c before char to preserve the ordering.
Not a big deal, but I'm somewhat at loss here - how to do it without
really ugly drivers/Makefile. Suggestions?

	d) if we set CONFIG_I2C to 'y' we don't include drivers/i2c
into subdir-m. However, having i2c-core in kernel and the rest done as
modules is OK with i2c itself. And I seriously suspect that it's
a common situation. Am I right assuming that correct way to deal with
that is to put i2c into mod-subdirs?

	e) looks like rand_initialize() is in the same class as handling
VFS/VM/etc. caches - global infrastructure. It definitely should be
called before all other drivers. Notice that old device_init() was asking
for trouble - it called parport_init() before chr_dev_init() (which calls
rand_initialize()), so if somebody would try to feed some entropy into
pool during the parport_init() we would get an interesting (and hard
to understand) problem. Maybe we should move the call into basic_setup()?

	Comments?

	Very preliminary patch follows. Please, _don't_ apply it in that
form - drivers/Makefile is just too ugly.
								Al

diff -urN S5-pre3-init-0/drivers/Makefile S5-pre3-init/drivers/Makefile
--- S5-pre3-init-0/drivers/Makefile	Wed May 16 16:26:35 2001
+++ S5-pre3-init/drivers/Makefile	Wed May 16 20:47:52 2001
@@ -9,8 +9,13 @@
 mod-subdirs :=	dio mtd sbus video macintosh usb input telephony sgi i2o ide \
 		scsi md ieee1394 pnp isdn atm fc4 net/hamradio i2c acpi
 
-subdir-y :=	parport char block net sound misc media cdrom
-subdir-m :=	$(subdir-y)
+subdir-y :=	parport
+subdir-m :=	parport
+
+subdir-$(CONFIG_I2C)		+= i2c
+
+subdir-y +=	char block net sound misc media cdrom
+subdir-m +=	char block net sound misc media cdrom
 
 
 subdir-$(CONFIG_DIO)		+= dio
@@ -40,7 +45,6 @@
 
 # CONFIG_HAMRADIO can be set without CONFIG_NETDEVICE being set  -- ch
 subdir-$(CONFIG_HAMRADIO)	+= net/hamradio
-subdir-$(CONFIG_I2C)		+= i2c
 subdir-$(CONFIG_ACPI)		+= acpi
 
 include $(TOPDIR)/Rules.make
diff -urN S5-pre3-init-0/drivers/char/Makefile S5-pre3-init/drivers/char/Makefile
--- S5-pre3-init-0/drivers/char/Makefile	Wed May 16 16:26:36 2001
+++ S5-pre3-init/drivers/char/Makefile	Wed May 16 20:39:26 2001
@@ -16,7 +16,7 @@
 
 O_TARGET := char.o
 
-obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o raw.o pty.o misc.o random.o
+obj-y	 += random.o mem.o tty_io.o n_tty.o tty_ioctl.o raw.o pty.o misc.o
 
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
diff -urN S5-pre3-init-0/drivers/char/mem.c S5-pre3-init/drivers/char/mem.c
--- S5-pre3-init-0/drivers/char/mem.c	Wed May 16 16:26:36 2001
+++ S5-pre3-init/drivers/char/mem.c	Wed May 16 20:48:51 2001
@@ -26,9 +26,6 @@
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 
-#ifdef CONFIG_I2C
-extern int i2c_init_all(void);
-#endif
 #ifdef CONFIG_VIDEO_DEV
 extern int videodev_init(void);
 #endif
@@ -615,10 +612,6 @@
 	if (devfs_register_chrdev(MEM_MAJOR,"mem",&memory_fops))
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 	memory_devfs_register();
-	rand_initialize();
-#ifdef CONFIG_I2C
-	i2c_init_all();
-#endif
 #if defined (CONFIG_FB)
 	fbmem_init();
 #endif
diff -urN S5-pre3-init-0/drivers/char/random.c S5-pre3-init/drivers/char/random.c
--- S5-pre3-init-0/drivers/char/random.c	Wed May 16 16:26:36 2001
+++ S5-pre3-init/drivers/char/random.c	Wed May 16 20:40:12 2001
@@ -1380,7 +1380,7 @@
 	}
 }
 
-void __init rand_initialize(void)
+static int __init rand_initialize(void)
 {
 	int i;
 
@@ -1404,7 +1404,10 @@
 	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
 	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
 	extract_timer_state.dont_count_entropy = 1;
+	return 0;
 }
+
+__initcall(rand_initialize);
 
 void rand_initialize_irq(int irq)
 {
diff -urN S5-pre3-init-0/drivers/i2c/i2c-algo-bit.c S5-pre3-init/drivers/i2c/i2c-algo-bit.c
--- S5-pre3-init-0/drivers/i2c/i2c-algo-bit.c	Sun Apr  1 23:56:45 2001
+++ S5-pre3-init/drivers/i2c/i2c-algo-bit.c	Wed May 16 20:54:07 2001
@@ -607,7 +607,7 @@
 	return 0;
 }
 
-int __init i2c_algo_bit_init (void)
+static int __init i2c_algo_bit_init (void)
 {
 	printk("i2c-algo-bit.o: i2c bit algorithm module\n");
 	return 0;
@@ -618,7 +618,6 @@
 EXPORT_SYMBOL(i2c_bit_add_bus);
 EXPORT_SYMBOL(i2c_bit_del_bus);
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus bit-banging algorithm");
 
@@ -631,12 +630,4 @@
 MODULE_PARM_DESC(i2c_debug,
             "debug level - 0 off; 1 normal; 2,3 more verbose; 9 bit-protocol");
 
-int init_module(void) 
-{
-	return i2c_algo_bit_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif
+module_init(i2c_algo_bit_init)
diff -urN S5-pre3-init-0/drivers/i2c/i2c-algo-pcf.c S5-pre3-init/drivers/i2c/i2c-algo-pcf.c
--- S5-pre3-init-0/drivers/i2c/i2c-algo-pcf.c	Fri Feb 16 22:53:49 2001
+++ S5-pre3-init/drivers/i2c/i2c-algo-pcf.c	Wed May 16 21:02:17 2001
@@ -593,7 +593,6 @@
 EXPORT_SYMBOL(i2c_pcf_add_bus);
 EXPORT_SYMBOL(i2c_pcf_del_bus);
 
-#ifdef MODULE
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
 
@@ -607,12 +606,4 @@
         "debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
 
 
-int init_module(void) 
-{
-	return i2c_algo_pcf_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif
+module_init(i2c_algo_pcf_init)
diff -urN S5-pre3-init-0/drivers/i2c/i2c-core.c S5-pre3-init/drivers/i2c/i2c-core.c
--- S5-pre3-init-0/drivers/i2c/i2c-core.c	Fri Feb 16 22:53:49 2001
+++ S5-pre3-init/drivers/i2c/i2c-core.c	Wed May 16 21:08:53 2001
@@ -1276,58 +1276,6 @@
 	return 0;
 }
 
-#ifndef MODULE
-	extern int i2c_dev_init(void);
-	extern int i2c_algo_bit_init(void);
-	extern int i2c_bitlp_init(void);
-	extern int i2c_bitelv_init(void);
-	extern int i2c_bitvelle_init(void);
-	extern int i2c_bitvia_init(void);
-	extern int i2c_algo_pcf_init(void);	
-	extern int i2c_pcfisa_init(void);
-
-/* This is needed for automatic patch generation: sensors code starts here */
-/* This is needed for automatic patch generation: sensors code ends here   */
-
-int __init i2c_init_all(void)
-{
-	/* --------------------- global ----- */
-	i2c_init();
-
-#ifdef CONFIG_I2C_CHARDEV
-	i2c_dev_init();
-#endif
-	/* --------------------- bit -------- */
-#ifdef CONFIG_I2C_ALGOBIT
-	i2c_algo_bit_init();
-#endif
-#ifdef CONFIG_I2C_PHILIPSPAR
-	i2c_bitlp_init();
-#endif
-#ifdef CONFIG_I2C_ELV
-	i2c_bitelv_init();
-#endif
-#ifdef CONFIG_I2C_VELLEMAN
-	i2c_bitvelle_init();
-#endif
-
-	/* --------------------- pcf -------- */
-#ifdef CONFIG_I2C_ALGOPCF
-	i2c_algo_pcf_init();	
-#endif
-#ifdef CONFIG_I2C_ELEKTOR
-	i2c_pcfisa_init();
-#endif
-/* This is needed for automatic patch generation: sensors code starts here */
-/* This is needed for automatic patch generation: sensors code ends here */
-
-	return 0;
-}
-
-#endif
-
-
-
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
@@ -1364,19 +1312,10 @@
 EXPORT_SYMBOL(i2c_get_functionality);
 EXPORT_SYMBOL(i2c_check_functionality);
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_PARM(i2c_debug, "i");
 MODULE_PARM_DESC(i2c_debug,"debug level");
 
-int init_module(void) 
-{
-	return i2c_init();
-}
-
-void cleanup_module(void) 
-{
-	i2cproc_cleanup();
-}
-#endif
+module_init(i2c_init)
+module_exit(i2cproc_cleanup)
diff -urN S5-pre3-init-0/drivers/i2c/i2c-dev.c S5-pre3-init/drivers/i2c/i2c-dev.c
--- S5-pre3-init-0/drivers/i2c/i2c-dev.c	Fri Feb 16 22:53:49 2001
+++ S5-pre3-init/drivers/i2c/i2c-dev.c	Wed May 16 20:52:30 2001
@@ -53,11 +53,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
-#ifdef MODULE
-extern int init_module(void);
-extern int cleanup_module(void);
-#endif /* def MODULE */
-
 /* struct file_operations changed too often in the 2.1 series for nice code */
 
 static loff_t i2cdev_lseek (struct file *file, loff_t offset, int origin);
@@ -78,12 +73,7 @@
 static int i2cdev_command(struct i2c_client *client, unsigned int cmd,
                            void *arg);
 
-#ifdef MODULE
-static
-#else
-extern
-#endif
-       int __init i2c_dev_init(void);
+static int __init i2c_dev_init(void);
 static int i2cdev_cleanup(void);
 
 static struct file_operations i2cdev_fops = {
@@ -476,7 +466,7 @@
 	return -1;
 }
 
-int __init i2c_dev_init(void)
+static int __init i2c_dev_init(void)
 {
 	int res;
 
@@ -506,7 +496,7 @@
 	return 0;
 }
 
-int i2cdev_cleanup(void)
+static int i2cdev_cleanup(void)
 {
 	int res;
 
@@ -537,20 +527,9 @@
 
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
+module_init(i2c_dev_init)
+module_exit(i2cdev_cleanup)
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C /dev entries driver");
-
-int init_module(void)
-{
-	return i2c_dev_init();
-}
-
-int cleanup_module(void)
-{
-	return i2cdev_cleanup();
-}
-
-#endif /* def MODULE */
 
diff -urN S5-pre3-init-0/drivers/i2c/i2c-elektor.c S5-pre3-init/drivers/i2c/i2c-elektor.c
--- S5-pre3-init-0/drivers/i2c/i2c-elektor.c	Fri Feb 16 22:53:49 2001
+++ S5-pre3-init/drivers/i2c/i2c-elektor.c	Wed May 16 21:03:58 2001
@@ -172,6 +172,7 @@
 
 static void pcf_isa_exit(void)
 {
+	i2c_pcf_del_bus(&pcf_isa_ops);
 	if (gpi.pi_irq > 0) {
 		disable_irq(gpi.pi_irq);
 		free_irq(gpi.pi_irq, 0);
@@ -274,7 +275,6 @@
 
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
 
@@ -284,15 +284,5 @@
 MODULE_PARM(own, "i");
 MODULE_PARM(i2c_debug,"i");
 
-int init_module(void) 
-{
-	return i2c_pcfisa_init();
-}
-
-void cleanup_module(void) 
-{
-	i2c_pcf_del_bus(&pcf_isa_ops);
-	pcf_isa_exit();
-}
-
-#endif
+module_init(i2c_pcfisa_init)
+module_exit(pcf_isa_exit)
diff -urN S5-pre3-init-0/drivers/i2c/i2c-elv.c S5-pre3-init/drivers/i2c/i2c-elv.c
--- S5-pre3-init-0/drivers/i2c/i2c-elv.c	Fri Feb 16 22:53:49 2001
+++ S5-pre3-init/drivers/i2c/i2c-elv.c	Wed May 16 20:59:34 2001
@@ -117,6 +117,7 @@
 
 static void bit_elv_exit(void)
 {
+	i2c_bit_del_bus(&bit_elv_ops);
 	release_region( base , (base == 0x3bc)? 3 : 8 );
 }
 
@@ -197,22 +198,11 @@
 
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter")
 ;
 
 MODULE_PARM(base, "i");
 
-int init_module(void)
-{
-	return i2c_bitelv_init();
-}
-
-void cleanup_module(void)
-{
-	i2c_bit_del_bus(&bit_elv_ops);
-	bit_elv_exit();
-}
-
-#endif
+module_init(i2c_bitelv_init)
+module_exit(bit_elv_exit)
diff -urN S5-pre3-init-0/drivers/i2c/i2c-philips-par.c S5-pre3-init/drivers/i2c/i2c-philips-par.c
--- S5-pre3-init-0/drivers/i2c/i2c-philips-par.c	Fri Feb 16 16:22:55 2001
+++ S5-pre3-init/drivers/i2c/i2c-philips-par.c	Wed May 16 20:56:58 2001
@@ -33,10 +33,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
-#ifndef __exit
-#define __exit __init
-#endif
-
 static int type;
 
 struct i2c_par
@@ -294,14 +290,5 @@
 
 MODULE_PARM(type, "i");
 
-#ifdef MODULE
-int init_module(void)
-{
-	return i2c_bitlp_init();
-}
-
-void cleanup_module(void)
-{
-	i2c_bitlp_exit();
-}
-#endif
+module_init(i2c_bitlp_init)
+module_exit(i2c_bitlp_exit)
diff -urN S5-pre3-init-0/drivers/i2c/i2c-velleman.c S5-pre3-init/drivers/i2c/i2c-velleman.c
--- S5-pre3-init-0/drivers/i2c/i2c-velleman.c	Fri Feb 16 06:27:19 2001
+++ S5-pre3-init/drivers/i2c/i2c-velleman.c	Wed May 16 21:01:20 2001
@@ -105,6 +105,7 @@
 
 static void bit_velle_exit(void)
 {	
+	i2c_bit_del_bus(&bit_velle_ops);
 	release_region( base , (base == 0x3bc)? 3 : 8 );
 }
 
@@ -192,15 +193,5 @@
 
 MODULE_PARM(base, "i");
 
-int init_module(void) 
-{
-	return i2c_bitvelle_init();
-}
-
-void cleanup_module(void) 
-{
-	i2c_bit_del_bus(&bit_velle_ops);
-	bit_velle_exit();
-}
-
-#endif
+module_init(i2c_bitvelle_init)
+module_exit(bit_velle_exit)

