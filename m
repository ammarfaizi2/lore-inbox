Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTLXWLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 17:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbTLXWLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 17:11:44 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:27144 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263945AbTLXWLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 17:11:20 -0500
Date: Wed, 24 Dec 2003 23:12:16 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, second wave (1/5)
Message-Id: <20031224231216.1c2d3828.khali@linux-fr.org>
In-Reply-To: <20031224225707.749707e5.khali@linux-fr.org>
References: <20031224225707.749707e5.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes init and exit functions for all i2c subsystem drivers,
switching from the 2.2 legacy method to the better 2.4 method. In the
process, useless functions were removed, and static, __init and __exit
keywords were enforced. One interesting thing here is that drivers no
longer depend on i2c-core for initialization after this change, which
makes adding and removing drivers easier.

diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-adap-ite.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-adap-ite.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-adap-ite.c	Sat Aug  3 02:39:44 2002
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-adap-ite.c	Mon Dec 22 22:04:00 2003
@@ -286,7 +286,7 @@
 }
 
 
-static void iic_ite_exit(void)
+static void __exit iic_ite_exit(void)
 {
 	i2c_iic_del_bus(&iic_ite_ops);
         iic_ite_release();
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-algo-bit.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-bit.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-algo-bit.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-bit.c	Mon Dec 22 22:04:00 2003
@@ -607,18 +607,9 @@
 	return 0;
 }
 
-int __init i2c_algo_bit_init (void)
-{
-	printk(KERN_INFO "i2c-algo-bit.o: i2c bit algorithm module\n");
-	return 0;
-}
-
-
-
 EXPORT_SYMBOL(i2c_bit_add_bus);
 EXPORT_SYMBOL(i2c_bit_del_bus);
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus bit-banging algorithm");
 MODULE_LICENSE("GPL");
@@ -631,13 +622,3 @@
 MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
             "debug level - 0 off; 1 normal; 2,3 more verbose; 9 bit-protocol");
-
-int init_module(void) 
-{
-	return i2c_algo_bit_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-algo-ite.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-ite.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-algo-ite.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-ite.c	Mon Dec 22 22:04:00 2003
@@ -822,20 +822,6 @@
 	return 0;
 }
 
-
-int __init i2c_algo_iic_init (void)
-{
-	printk(KERN_INFO "ITE iic (i2c) algorithm module\n");
-	return 0;
-}
-
-
-void i2c_algo_iic_exit(void)
-{
-	return;
-}
-
-
 EXPORT_SYMBOL(i2c_iic_add_bus);
 EXPORT_SYMBOL(i2c_iic_del_bus);
 
@@ -854,20 +840,3 @@
 MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
         "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
-
-
-/* This function resolves to init_module (the function invoked when a module
- * is loaded via insmod) when this file is compiled with MODULES defined.
- * Otherwise (i.e. if you want this driver statically linked to the kernel),
- * a pointer to this function is stored in a table and called
- * during the intialization of the kernel (in do_basic_setup in /init/main.c) 
- *
- * All this functionality is complements of the macros defined in linux/init.h
- */
-module_init(i2c_algo_iic_init);
-
-
-/* If MODULES is defined when this file is compiled, then this function will
- * resolved to cleanup_module.
- */
-module_exit(i2c_algo_iic_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-algo-pcf.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-pcf.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-algo-pcf.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-pcf.c	Mon Dec 22 22:04:00 2003
@@ -522,17 +522,9 @@
 	return 0;
 }
 
-int __init i2c_algo_pcf_init (void)
-{
-	printk("i2c-algo-pcf.o: i2c pcf8584 algorithm module\n");
-	return 0;
-}
-
-
 EXPORT_SYMBOL(i2c_pcf_add_bus);
 EXPORT_SYMBOL(i2c_pcf_del_bus);
 
-#ifdef MODULE
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
 MODULE_LICENSE("GPL");
@@ -543,14 +535,3 @@
 MODULE_PARM_DESC(pcf_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
         "debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
-
-
-int init_module(void) 
-{
-	return i2c_algo_pcf_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-algo-sibyte.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-sibyte.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-algo-sibyte.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-sibyte.c	Mon Dec 22 22:04:00 2003
@@ -203,29 +203,11 @@
 	return 0;
 }
 
-int __init i2c_algo_sibyte_init (void)
-{
-	printk("i2c-algo-sibyte.o: i2c SiByte algorithm module\n");
-	return 0;
-}
-
-
 EXPORT_SYMBOL(i2c_sibyte_add_bus);
 EXPORT_SYMBOL(i2c_sibyte_del_bus);
 
-#ifdef MODULE
 MODULE_AUTHOR("Kip Walker, Broadcom Corp.");
 MODULE_DESCRIPTION("SiByte I2C-Bus algorithm");
 MODULE_PARM(bit_scan, "i");
 MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_LICENSE("GPL");
-
-int init_module(void) 
-{
-	return i2c_algo_sibyte_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-core.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-core.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-core.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-core.c	Mon Dec 22 22:04:00 2003
@@ -1273,121 +1273,27 @@
 	init_MUTEX(&adap_lock);
 	init_MUTEX(&driver_lock);
 	
-	i2cproc_init();
-	
+#ifdef CONFIG_PROC_FS
+	return i2cproc_init();
+#else
 	return 0;
-}
-
-#ifndef MODULE
-#ifdef CONFIG_I2C_CHARDEV
-	extern int i2c_dev_init(void);
-#endif
-#ifdef CONFIG_I2C_ALGOBIT
-	extern int i2c_algo_bit_init(void);
-#endif
-#ifdef CONFIG_I2C_PHILIPSPAR
-	extern int i2c_bitlp_init(void);
-#endif
-#ifdef CONFIG_I2C_ELV
-	extern int i2c_bitelv_init(void);
-#endif
-#ifdef CONFIG_I2C_VELLEMAN
-	extern int i2c_bitvelle_init(void);
-#endif
-#ifdef CONFIG_I2C_BITVIA
-	extern int i2c_bitvia_init(void);
-#endif
-
-#ifdef CONFIG_I2C_ALGOPCF
-	extern int i2c_algo_pcf_init(void);	
-#endif
-#ifdef CONFIG_I2C_ELEKTOR
-	extern int i2c_pcfisa_init(void);
-#endif
-
-#ifdef CONFIG_I2C_ALGO8XX
-	extern int i2c_algo_8xx_init(void);
-#endif
-#ifdef CONFIG_I2C_RPXLITE
-	extern int i2c_rpx_init(void);
-#endif
-
-#ifdef CONFIG_I2C_ALGO_SIBYTE
-	extern int i2c_algo_sibyte_init(void);
-	extern int i2c_sibyte_init(void);
-#endif
-#ifdef CONFIG_I2C_MAX1617
-	extern int i2c_max1617_init(void);
 #endif
+}
 
-#ifdef CONFIG_I2C_PROC
-	extern int sensors_init(void);
+static void __exit i2c_exit(void) 
+{
+#ifdef CONFIG_PROC_FS
+	i2cproc_cleanup();
 #endif
+}
 
-/* This is needed for automatic patch generation: sensors code starts here */
-/* This is needed for automatic patch generation: sensors code ends here   */
-
+/* leave this in for now simply to make patching easier so we don't have
+   to remove the call in drivers/char/mem.c */
 int __init i2c_init_all(void)
 {
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
-
-	/* --------------------- 8xx -------- */
-#ifdef CONFIG_I2C_ALGO8XX
-	i2c_algo_8xx_init();
-#endif
-#ifdef CONFIG_I2C_RPXLITE
-	i2c_rpx_init();
-#endif
-
-	/* --------------------- SiByte -------- */
-#ifdef CONFIG_I2C_ALGO_SIBYTE
-	i2c_algo_sibyte_init();
-	i2c_sibyte_init();
-#endif
-#ifdef CONFIG_I2C_MAX1617
-	i2c_max1617_init();
-#endif
-
-	/* -------------- proc interface ---- */
-#ifdef CONFIG_I2C_PROC
-	sensors_init();
-#endif
-/* This is needed for automatic patch generation: sensors code starts here */
-/* This is needed for automatic patch generation: sensors code ends here */
-
 	return 0;
 }
 
-#endif
-
-
-
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
@@ -1424,7 +1330,6 @@
 EXPORT_SYMBOL(i2c_get_functionality);
 EXPORT_SYMBOL(i2c_check_functionality);
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
@@ -1432,13 +1337,5 @@
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
+module_init(i2c_init);
+module_exit(i2c_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-dev.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-dev.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-dev.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-dev.c	Mon Dec 22 22:04:00 2003
@@ -53,11 +53,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
-#ifdef MODULE
-extern int init_module(void);
-extern int cleanup_module(void);
-#endif /* def MODULE */
-
 /* struct file_operations changed too often in the 2.1 series for nice code */
 
 #if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
@@ -79,12 +74,6 @@
 static int i2cdev_command(struct i2c_client *client, unsigned int cmd,
                            void *arg);
 
-#ifdef MODULE
-static
-#else
-extern
-#endif
-       int __init i2c_dev_init(void);
 static int i2cdev_cleanup(void);
 
 static struct file_operations i2cdev_fops = {
@@ -514,7 +503,7 @@
 	return -1;
 }
 
-int __init i2c_dev_init(void)
+static int __init i2c_dev_init(void)
 {
 	int res;
 
@@ -544,7 +533,7 @@
 	return 0;
 }
 
-int i2cdev_cleanup(void)
+static int __exit i2cdev_cleanup(void)
 {
 	int res;
 
@@ -573,23 +562,16 @@
 	return 0;
 }
 
-EXPORT_NO_SYMBOLS;
+static void __exit i2c_dev_exit(void)
+{
+	i2cdev_cleanup();
+}
 
-#ifdef MODULE
+EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C /dev entries driver");
 MODULE_LICENSE("GPL");
 
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
-
+module_init(i2c_dev_init);
+module_exit(i2c_dev_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-elektor.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-elektor.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-elektor.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-elektor.c	Mon Dec 22 22:04:00 2003
@@ -160,19 +160,6 @@
 	return 0;
 }
 
-
-static void __exit pcf_isa_exit(void)
-{
-	if (irq > 0) {
-		disable_irq(irq);
-		free_irq(irq, 0);
-	}
-	if (!mmapped) {
-		release_region(base , 2);
-	}
-}
-
-
 static int pcf_isa_reg(struct i2c_client *client)
 {
 	return 0;
@@ -224,7 +211,7 @@
 	pcf_isa_unreg,
 };
 
-int __init i2c_pcfisa_init(void) 
+static int __init i2c_pcfisa_init(void) 
 {
 #ifdef __alpha__
 	/* check to see we have memory mapped PCF8584 connected to the 
@@ -296,10 +283,21 @@
 	return 0;
 }
 
+static void __exit i2c_pcfisa_exit(void)
+{
+	i2c_pcf_del_bus(&pcf_isa_ops);
+
+	if (irq > 0) {
+		disable_irq(irq);
+		free_irq(irq, 0);
+	}
+
+	if (!mmapped)
+		release_region(base , 2);
+}
 
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
 MODULE_LICENSE("GPL");
@@ -311,15 +309,5 @@
 MODULE_PARM(mmapped, "i");
 MODULE_PARM(i2c_debug, "i");
 
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
+module_init(i2c_pcfisa_init);
+module_exit(i2c_pcfisa_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-elv.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-elv.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-elv.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-elv.c	Mon Dec 22 22:04:00 2003
@@ -115,11 +115,6 @@
 	return 0;
 }
 
-static void __exit bit_elv_exit(void)
-{
-	release_region( base , (base == 0x3bc)? 3 : 8 );
-}
-
 static int bit_elv_reg(struct i2c_client *client)
 {
 	return 0;
@@ -168,7 +163,7 @@
 	bit_elv_unreg,	
 };
 
-int __init i2c_bitelv_init(void)
+static int __init i2c_bitelv_init(void)
 {
 	printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
@@ -194,25 +189,19 @@
 	return 0;
 }
 
+static void __exit i2c_bitelv_exit(void)
+{
+	i2c_bit_del_bus(&bit_elv_ops);
+	release_region(base, (base == 0x3bc) ? 3 : 8);
+}
 
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter");
 MODULE_LICENSE("GPL");
 
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
+module_init(i2c_bitelv_init);
+module_exit(i2c_bitelv_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-max1617.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-max1617.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-max1617.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-max1617.c	Mon Dec 22 22:04:00 2003
@@ -200,26 +200,21 @@
 #endif
 }
 
-void i2c_max1617_init(void)
+static int __init i2c_max1617_init(void)
 {
-        i2c_add_driver(&i2c_driver_max1617);
+        return i2c_add_driver(&i2c_driver_max1617);
+}
+
+static void __exit i2c_max1617_exit(void)
+{
+        i2c_del_driver(&i2c_driver_max1617);
 }
 
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Kip Walker, Broadcom Corp.");
 MODULE_DESCRIPTION("Max 1617 temperature sensor for SiByte SOC boards");
 MODULE_LICENSE("GPL");
 
-int init_module(void)
-{
-	i2c_max1617_init();
-	return 0;
-}
-
-void cleanup_module(void)
-{
-        i2c_del_driver(&i2c_driver_max1617);
-}
-#endif
+module_init(i2c_max1617_init);
+module_exit(i2c_max1617_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-philips-par.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-philips-par.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-philips-par.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-philips-par.c	Mon Dec 22 22:04:00 2003
@@ -29,14 +29,10 @@
 #include <linux/init.h>
 #include <linux/stddef.h>
 #include <linux/parport.h>
-
+#include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
-#ifndef __exit
-#define __exit __init
-#endif
-
 static int type;
 
 struct i2c_par
@@ -259,7 +255,7 @@
 };
 #endif
 
-int __init i2c_bitlp_init(void)
+static int __init i2c_bitlp_init(void)
 {
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,4)
 	struct parport *port;
@@ -276,7 +272,7 @@
 	return 0;
 }
 
-void __exit i2c_bitlp_exit(void)
+static void __exit i2c_bitlp_exit(void)
 {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 	parport_unregister_driver(&i2c_driver);
@@ -295,14 +291,5 @@
 
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
+module_init(i2c_bitlp_init);
+module_exit(i2c_bitlp_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-proc.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-proc.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-proc.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-proc.c	Mon Dec 22 22:04:00 2003
@@ -56,8 +56,6 @@
 				void *newval, size_t newlen,
 				void **context);
 
-int __init sensors_init(void);
-
 #define SENSORS_ENTRY_MAX 20
 static struct ctl_table_header *i2c_entries[SENSORS_ENTRY_MAX];
 
@@ -856,7 +854,7 @@
 	return 0;
 }
 
-int __init sensors_init(void)
+static int __init i2c_proc_init(void)
 {
 	printk(KERN_INFO "i2c-proc.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	i2c_initialized = 0;
@@ -873,34 +871,23 @@
 	return 0;
 }
 
+static void __exit i2c_proc_exit(void)
+{
+	if (i2c_initialized >= 1) {
+		unregister_sysctl_table(i2c_proc_header);
+		i2c_initialized--;
+	}
+}
+
 EXPORT_SYMBOL(i2c_deregister_entry);
 EXPORT_SYMBOL(i2c_detect);
 EXPORT_SYMBOL(i2c_proc_real);
 EXPORT_SYMBOL(i2c_register_entry);
 EXPORT_SYMBOL(i2c_sysctl_real);
 
-#ifdef MODULE
-
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("i2c-proc driver");
 MODULE_LICENSE("GPL");
 
-int i2c_cleanup(void)
-{
-	if (i2c_initialized >= 1) {
-		unregister_sysctl_table(i2c_proc_header);
-		i2c_initialized--;
-	}
-	return 0;
-}
-
-int init_module(void)
-{
-	return sensors_init();
-}
-
-int cleanup_module(void)
-{
-	return i2c_cleanup();
-}
-#endif				/* MODULE */
+module_init(i2c_proc_init);
+module_exit(i2c_proc_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-sibyte.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-sibyte.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-sibyte.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-sibyte.c	Mon Dec 22 22:04:00 2003
@@ -82,7 +82,7 @@
         }
 };
 
-int __init i2c_sibyte_init(void)
+static int __init i2c_sibyte_init(void)
 {
 	printk("i2c-swarm.o: i2c SMBus adapter module for SiByte board\n");
         if (i2c_sibyte_add_bus(&sibyte_board_adapter[0], K_SMB_FREQ_100KHZ) < 0)
@@ -92,23 +92,17 @@
 	return 0;
 }
 
+static void __exit i2c_sibyte_exit(void)
+{
+	i2c_sibyte_del_bus(&sibyte_board_adapter[0]);
+	i2c_sibyte_del_bus(&sibyte_board_adapter[1]);
+}
 
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Kip Walker, Broadcom Corp.");
 MODULE_DESCRIPTION("SMBus adapter routines for SiByte boards");
 MODULE_LICENSE("GPL");
 
-int init_module(void)
-{
-	return i2c_sibyte_init();
-}
-
-void cleanup_module(void)
-{
-	i2c_sibyte_del_bus(&sibyte_board_adapter[0]);
-	i2c_sibyte_del_bus(&sibyte_board_adapter[1]);
-}
-
-#endif
+module_init(i2c_sibyte_init);
+module_exit(i2c_sibyte_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/i2c-velleman.c linux-2.4.24-pre2-k1/drivers/i2c/i2c-velleman.c
--- linux-2.4.24-pre2/drivers/i2c/i2c-velleman.c	Mon Dec 22 21:50:10 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/i2c-velleman.c	Mon Dec 22 22:04:00 2003
@@ -103,12 +103,6 @@
 	return 0;
 }
 
-static void __exit bit_velle_exit(void)
-{	
-	release_region( base , (base == 0x3bc)? 3 : 8 );
-}
-
-
 static int bit_velle_reg(struct i2c_client *client)
 {
 	return 0;
@@ -158,7 +152,7 @@
 	bit_velle_unreg,
 };
 
-int __init  i2c_bitvelle_init(void)
+static int __init i2c_bitvelle_init(void)
 {
 	printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
@@ -184,24 +178,19 @@
 	return 0;
 }
 
+static void __exit i2c_bitvelle_exit(void)
+{	
+	i2c_bit_del_bus(&bit_velle_ops);
+	release_region(base, (base == 0x3bc) ? 3 : 8);
+}
+
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for Velleman K8000 adapter");
 MODULE_LICENSE("GPL");
 
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
+module_init(i2c_bitvelle_init);
+module_exit(i2c_bitvelle_exit);
diff -ruN linux-2.4.24-pre2/drivers/i2c/scx200_i2c.c linux-2.4.24-pre2-k1/drivers/i2c/scx200_i2c.c
--- linux-2.4.24-pre2/drivers/i2c/scx200_i2c.c	Fri Jun 13 16:51:33 2003
+++ linux-2.4.24-pre2-k1/drivers/i2c/scx200_i2c.c	Mon Dec 22 22:04:00 2003
@@ -110,7 +110,7 @@
 	.client_unregister = scx200_i2c_unreg,
 };
 
-int scx200_i2c_init(void)
+static int __init scx200_i2c_init(void)
 {
 	printk(KERN_DEBUG NAME ": NatSemi SCx200 I2C Driver\n");
 
@@ -140,7 +140,7 @@
 	return 0;
 }
 
-void scx200_i2c_cleanup(void)
+static void __exit scx200_i2c_cleanup(void)
 {
 	i2c_bit_del_bus(&scx200_i2c_ops);
 }

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
