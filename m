Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSL2U4r>; Sun, 29 Dec 2002 15:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSL2U4r>; Sun, 29 Dec 2002 15:56:47 -0500
Received: from verein.lst.de ([212.34.181.86]:20491 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261640AbSL2U4R>;
	Sun, 29 Dec 2002 15:56:17 -0500
Date: Sun, 29 Dec 2002 22:04:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make i2c use initcalls everywhere
Message-ID: <20021229220436.A11420@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The use of explicit initializers all over the i2c core anoyed for
long, but the lm_sensors merge with two new files just for initializers
was too much.  Conver all of i2c to sane initialization (mostly
initcall, but some driver also got other cleanups in that area)

--- 1.28/drivers/Makefile	Wed Dec 18 16:28:25 2002
+++ edited/drivers/Makefile	Sun Dec 29 17:39:52 2002
@@ -38,8 +38,6 @@
 obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
-obj-$(CONFIG_I2C_MAINBOARD)	+= i2c/busses/
-obj-$(CONFIG_SENSORS)		+= i2c/chips/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
--- 1.33/drivers/char/mem.c	Thu Dec 26 02:35:14 2002
+++ edited/drivers/char/mem.c	Sun Dec 29 18:28:56 2002
@@ -27,15 +27,6 @@
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 
-#ifdef CONFIG_I2C_MAINBOARD
-extern void i2c_mainboard_init_all(void);
-#endif
-#ifdef CONFIG_SENSORS
-extern void sensors_init_all(void);
-#endif
-#ifdef CONFIG_I2C
-extern int i2c_init_all(void);
-#endif
 #ifdef CONFIG_FB
 extern void fbmem_init(void);
 #endif
@@ -708,12 +699,6 @@
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 	memory_devfs_register();
 	rand_initialize();
-#ifdef CONFIG_I2C
-	i2c_init_all();
-#endif
-#ifdef CONFIG_I2C_MAINBOARD
-	i2c_mainboard_init_all();
-#endif
 #if defined (CONFIG_FB)
 	fbmem_init();
 #endif
@@ -728,10 +713,6 @@
 #if defined(CONFIG_S390_TAPE) && defined(CONFIG_S390_TAPE_CHAR)
 	tapechar_init();
 #endif
-#ifdef CONFIG_SENSORS
-	sensors_init_all();
-#endif
-
 	return 0;
 }
 
--- 1.2/drivers/i2c/Kconfig	Sun Dec  1 19:42:06 2002
+++ edited/drivers/i2c/Kconfig	Sun Dec 29 19:31:23 2002
@@ -166,8 +166,6 @@
 	tristate "IBM on-chip I2C Adapter"
 	depends on I2C_IBM_OCP_ALGO
 
-# This is needed for automatic patch generation: sensors code starts here
-# This is needed for automatic patch generation: sensors code ends here
 config I2C_CHARDEV
 	tristate "I2C device interface"
 	depends on I2C
--- 1.6/drivers/i2c/Makefile	Sat Dec 14 07:38:56 2002
+++ edited/drivers/i2c/Makefile	Sun Dec 29 19:31:06 2002
@@ -18,6 +18,4 @@
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
-
-# This is needed for automatic patch generation: sensors code starts here
-# This is needed for automatic patch generation: sensors code ends here
+obj-y				+= busses/ chips/
--- 1.9/drivers/i2c/i2c-algo-bit.c	Sun Jul  7 20:41:49 2002
+++ edited/drivers/i2c/i2c-algo-bit.c	Sun Dec 29 18:28:36 2002
@@ -605,18 +605,9 @@
 	return 0;
 }
 
-int __init i2c_algo_bit_init (void)
-{
-	printk(KERN_INFO "i2c-algo-bit.o: i2c bit algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
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
@@ -629,13 +620,3 @@
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
--- 1.5/drivers/i2c/i2c-algo-pcf.c	Thu May 23 17:21:11 2002
+++ edited/drivers/i2c/i2c-algo-pcf.c	Sun Dec 29 18:19:38 2002
@@ -520,17 +520,9 @@
 	return 0;
 }
 
-int __init i2c_algo_pcf_init (void)
-{
-	printk(KERN_INFO "i2c-algo-pcf.o: i2c pcf8584 algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
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
@@ -541,14 +533,3 @@
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
--- 1.12/drivers/i2c/i2c-core.c	Sun Dec  1 19:42:06 2002
+++ edited/drivers/i2c/i2c-core.c	Sun Dec 29 19:43:44 2002
@@ -56,8 +56,8 @@
 /* ----- global variables -------------------------------------------------- */
 
 /**** lock for writing to global variables: the adapter & driver list */
-struct semaphore adap_lock;
-struct semaphore driver_lock;
+DECLARE_MUTEX(adap_lock);
+DECLARE_MUTEX(driver_lock);
 
 /**** adapter list */
 static struct i2c_adapter *adapters[I2C_ADAP_MAX];
@@ -76,11 +76,6 @@
  */
 
 #ifdef CONFIG_PROC_FS
-
-int __init i2cproc_init(void);
-void __exit i2cproc_exit(void);
-static int i2cproc_cleanup(void);
-
 static ssize_t i2cproc_bus_read(struct file * file, char * buf,size_t count, 
                                 loff_t *ppos);
 static int read_bus_i2c(char *buf, char **start, off_t offset, int len,
@@ -91,14 +86,6 @@
 static struct file_operations i2cproc_operations = {
 	.read		= i2cproc_bus_read,
 };
-
-static int i2cproc_initialized = 0;
-
-#else /* undef CONFIG_PROC_FS */
-
-#define i2cproc_init() 0
-#define i2cproc_cleanup() 0
-
 #endif /* CONFIG_PROC_FS */
 
 
@@ -136,8 +123,7 @@
 	init_MUTEX(&adap->lock);
 
 #ifdef CONFIG_PROC_FS
-
-	if (i2cproc_initialized) {
+	{
 		char name[8];
 		struct proc_dir_entry *proc_entry;
 
@@ -155,7 +141,6 @@
 		proc_entry->owner = THIS_MODULE;
 		adap->inode = proc_entry->low_ino;
 	}
-
 #endif /* def CONFIG_PROC_FS */
 
 	/* inform drivers of new adapters */
@@ -234,10 +219,10 @@
 			}
 	}
 #ifdef CONFIG_PROC_FS
-	if (i2cproc_initialized) {
+	{
 		char name[8];
 		sprintf(name,"i2c-%d", i);
-		remove_proc_entry(name,proc_bus);
+		remove_proc_entry(name, proc_bus);
 	}
 #endif /* def CONFIG_PROC_FS */
 
@@ -681,41 +666,30 @@
 	return -ENOENT;
 }
 
-int i2cproc_init(void)
+static int i2cproc_init(void)
 {
 
 	struct proc_dir_entry *proc_bus_i2c;
 
-	i2cproc_initialized = 0;
-
-	if (! proc_bus) {
-		printk(KERN_ERR "i2c-core.o: /proc/bus/ does not exist");
-		i2cproc_cleanup();
-		return -ENOENT;
- 	} 
 	proc_bus_i2c = create_proc_entry("i2c",0,proc_bus);
 	if (!proc_bus_i2c) {
 		printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/i2c");
-		i2cproc_cleanup();
 		return -ENOENT;
  	}
+
 	proc_bus_i2c->read_proc = &read_bus_i2c;
 	proc_bus_i2c->owner = THIS_MODULE;
-	i2cproc_initialized += 2;
 	return 0;
 }
 
-int i2cproc_cleanup(void)
+static void __exit i2cproc_cleanup(void)
 {
 
-	if (i2cproc_initialized >= 1) {
-		remove_proc_entry("i2c",proc_bus);
-		i2cproc_initialized -= 2;
-	}
-	return 0;
+	remove_proc_entry("i2c",proc_bus);
 }
 
-
+module_init(i2cproc_init);
+module_exit(i2cproc_cleanup);
 #endif /* def CONFIG_PROC_FS */
 
 /* ----------------------------------------------------
@@ -1440,120 +1414,6 @@
 	return (func & adap_func) == func;
 }
 
-
-static int __init i2c_init(void)
-{
-	printk(KERN_INFO "i2c-core.o: i2c core module version %s (%s)\n", I2C_VERSION, I2C_DATE);
-	memset(adapters,0,sizeof(adapters));
-	memset(drivers,0,sizeof(drivers));
-	adap_count=0;
-	driver_count=0;
-
-	init_MUTEX(&adap_lock);
-	init_MUTEX(&driver_lock);
-	
-	i2cproc_init();
-	
-	return 0;
-}
-
-void __exit i2c_exit(void)
-{
-	i2cproc_cleanup();
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
-#ifdef CONFIG_I2C_PROC
-	extern int sensors_init(void);
-#endif
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
-
-	/* --------------------- 8xx -------- */
-#ifdef CONFIG_I2C_ALGO8XX
-	i2c_algo_8xx_init();
-#endif
-#ifdef CONFIG_I2C_RPXLITE
-	i2c_rpx_init();
-#endif
-
-	/* -------------- proc interface ---- */
-#ifdef CONFIG_I2C_PROC
-	sensors_init();
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
@@ -1594,9 +1454,7 @@
 
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
-MODULE_PARM(i2c_debug, "i");
-MODULE_PARM_DESC(i2c_debug,"debug level");
 MODULE_LICENSE("GPL");
 
-module_init(i2c_init);
-module_exit(i2c_exit);
+MODULE_PARM(i2c_debug, "i");
+MODULE_PARM_DESC(i2c_debug,"debug level");
--- 1.18/drivers/i2c/i2c-dev.c	Sat Dec 14 06:56:33 2002
+++ edited/drivers/i2c/i2c-dev.c	Sun Dec 29 18:20:26 2002
@@ -48,10 +48,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
-int __init i2c_dev_init(void);
-void __exit i2c_dev_exit(void);
-static int dev_cleanup(void);
-
 /* struct file_operations changed too often in the 2.1 series for nice code */
 
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count, 
@@ -437,19 +433,6 @@
 	return -1;
 }
 
-static int dev_cleanup(void)
-{
-	int res;
-
-	if ((res = i2c_del_driver(&i2cdev_driver))) {
-		printk(KERN_ERR "i2c-dev.o: Driver deregistration failed, "
-		       "module not removed.\n");
-	}
-
-	devfs_remove("i2c");
-	unregister_chrdev(I2C_MAJOR,"i2c");
-}
-
 int __init i2c_dev_init(void)
 {
 	int res;
@@ -471,12 +454,12 @@
 	return 0;
 }
 
-void __exit i2c_dev_exit(void)
+static void __exit i2c_dev_exit(void)
 {
-	dev_cleanup();
+	i2c_del_driver(&i2cdev_driver);
+	devfs_remove("i2c");
+	unregister_chrdev(I2C_MAJOR,"i2c");
 }
-
-EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C /dev entries driver");
--- 1.10/drivers/i2c/i2c-elektor.c	Mon Nov 18 07:42:08 2002
+++ edited/drivers/i2c/i2c-elektor.c	Sun Dec 29 19:48:40 2002
@@ -159,19 +159,6 @@
 	return 0;
 }
 
-
-static void pcf_isa_exit(void)
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
@@ -223,7 +210,7 @@
 	.client_unregister = pcf_isa_unreg,
 };
 
-int __init i2c_pcfisa_init(void) 
+static int __init i2c_pcfisa_init(void) 
 {
 #ifdef __alpha__
 	/* check to see we have memory mapped PCF8584 connected to the 
@@ -281,23 +268,39 @@
 	}
 
 	init_waitqueue_head(&pcf_wait);
-	if (pcf_isa_init() == 0) {
-		if (i2c_pcf_add_bus(&pcf_isa_ops) < 0) {
-			pcf_isa_exit();
-			return -ENODEV;
-		}
-	} else {
+	if (pcf_isa_init())
 		return -ENODEV;
-	}
+	if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
+		goto fail;
 	
 	printk(KERN_ERR "i2c-elektor.o: found device at %#x.\n", base);
 
 	return 0;
+
+ fail:
+	if (irq > 0) {
+		disable_irq(irq);
+		free_irq(irq, 0);
+	}
+
+	if (!mmapped)
+		release_region(base , 2);
+	return -ENODEV;
 }
 
-EXPORT_NO_SYMBOLS;
+static void i2c_pcfisa_exit(void)
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
 
-#ifdef MODULE
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
 MODULE_LICENSE("GPL");
@@ -309,15 +312,5 @@
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
--- 1.6/drivers/i2c/i2c-elv.c	Tue May 14 18:01:25 2002
+++ edited/drivers/i2c/i2c-elv.c	Sun Dec 29 19:44:23 2002
@@ -113,11 +113,6 @@
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
@@ -166,7 +161,7 @@
 	bit_elv_unreg,	
 };
 
-int __init i2c_bitelv_init(void)
+static int __init i2c_bitelv_init(void)
 {
 	printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
@@ -192,24 +187,17 @@
 	return 0;
 }
 
+static void __exit i2c_bitelv_exit(void)
+{
+	i2c_bit_del_bus(&bit_elv_ops);
+	release_region(base , (base == 0x3bc) ? 3 : 8);
+}
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter");
 MODULE_LICENSE("GPL");
 
-
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
--- 1.2/drivers/i2c/i2c-frodo.c	Mon Nov 18 09:02:17 2002
+++ edited/drivers/i2c/i2c-frodo.c	Sun Dec 29 18:25:35 2002
@@ -96,8 +96,6 @@
 	return (i2c_bit_add_bus (&frodo_ops));
 }
 
-EXPORT_NO_SYMBOLS;
-
 static void __exit i2c_frodo_exit (void)
 {
 	i2c_bit_del_bus (&frodo_ops);
@@ -105,12 +103,7 @@
 
 MODULE_AUTHOR ("Abraham van der Merwe <abraham@2d3d.co.za>");
 MODULE_DESCRIPTION ("I2C-Bus adapter routines for Frodo");
-
-#ifdef MODULE_LICENSE
 MODULE_LICENSE ("GPL");
-#endif	/* #ifdef MODULE_LICENSE */
-
-EXPORT_NO_SYMBOLS;
 
 module_init (i2c_frodo_init);
 module_exit (i2c_frodo_exit);
--- 1.5/drivers/i2c/i2c-philips-par.c	Tue Sep 17 15:53:02 2002
+++ edited/drivers/i2c/i2c-philips-par.c	Sun Dec 29 18:26:03 2002
@@ -297,14 +297,5 @@
 
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
--- 1.8/drivers/i2c/i2c-proc.c	Sun Dec  1 19:42:06 2002
+++ edited/drivers/i2c/i2c-proc.c	Sun Dec 29 19:50:11 2002
@@ -40,10 +40,6 @@
 #define THIS_MODULE NULL
 #endif
 
-int __init sensors_init(void);
-void __exit i2c_proc_exit(void);
-static int proc_cleanup(void);
-
 static int i2c_create_name(char **name, const char *prefix,
 			       struct i2c_adapter *adapter, int addr);
 static int i2c_parse_reals(int *nrels, void *buffer, int bufsize,
@@ -92,7 +88,6 @@
 
 
 static struct ctl_table_header *i2c_proc_header;
-static int i2c_initialized;
 
 /* This returns a nice name for a new directory; for example lm78-isa-0310
    (for a LM78 chip on the ISA bus at port 0x310), or lm75-i2c-3-4e (for
@@ -848,10 +843,9 @@
 	return 0;
 }
 
-int __init sensors_init(void)
+static int __init i2c_proc_init(void)
 {
 	printk(KERN_INFO "i2c-proc.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
-	i2c_initialized = 0;
 	if (!
 	    (i2c_proc_header =
 	     register_sysctl_table(i2c_proc, 0))) {
@@ -859,22 +853,12 @@
 		return -EPERM;
 	}
 	i2c_proc_header->ctl_table->child->de->owner = THIS_MODULE;
-	i2c_initialized++;
 	return 0;
 }
 
-void __exit i2c_proc_exit(void)
-{
-	proc_cleanup();
-}
-
-static int proc_cleanup(void)
+static void __exit i2c_proc_exit(void)
 {
-	if (i2c_initialized >= 1) {
-		unregister_sysctl_table(i2c_proc_header);
-		i2c_initialized--;
-	}
-	return 0;
+	unregister_sysctl_table(i2c_proc_header);
 }
 
 EXPORT_SYMBOL(i2c_deregister_entry);
@@ -887,5 +871,5 @@
 MODULE_DESCRIPTION("i2c-proc driver");
 MODULE_LICENSE("GPL");
 
-module_init(sensors_init);
+module_init(i2c_proc_init);
 module_exit(i2c_proc_exit);
--- 1.2/drivers/i2c/i2c-rpx.c	Mon Nov 18 02:09:32 2002
+++ edited/drivers/i2c/i2c-rpx.c	Sun Dec 29 18:27:25 2002
@@ -126,11 +126,8 @@
 	i2c_8xx_del_bus(&rpx_ops);
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Dan Malek <dmalek@jlc.net>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for MPC8xx boards");
 
 module_init(i2c_rpx_init);
 module_exit(i2c_rpx_exit);
-#endif
-
--- 1.5/drivers/i2c/i2c-velleman.c	Tue May 14 18:04:11 2002
+++ edited/drivers/i2c/i2c-velleman.c	Sun Dec 29 19:46:32 2002
@@ -102,12 +102,6 @@
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
@@ -157,7 +151,7 @@
 	bit_velle_unreg,
 };
 
-int __init  i2c_bitvelle_init(void)
+static int __init i2c_bitvelle_init(void)
 {
 	printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
@@ -183,22 +177,17 @@
 	return 0;
 }
 
-#ifdef MODULE
+static void __exit i2c_bitvelle_exit(void)
+{	
+	i2c_bit_del_bus(&bit_velle_ops);
+	release_region(base, (base == 0x3bc) ? 3 : 8);
+}
+
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
--- 1.1/drivers/i2c/busses/Kconfig	Sun Dec  1 19:42:06 2002
+++ edited/drivers/i2c/busses/Kconfig	Sun Dec 29 19:29:23 2002
@@ -5,22 +5,8 @@
 
 menu "I2C Hardware Sensors Mainboard support"
 
-config I2C_MAINBOARD
-	bool "Hardware sensors mainboard support"
-	depends on EXPERIMENTAL && I2C && I2C_PROC
-	help
-	  Many modern mainboards have some kind of I2C interface integrated. This
-	  is often in the form of a SMBus, or System Management Bus, which is
-	  basically the same as I2C but which uses only a subset of the I2C
-	  protocol.
-
-	  You will also want the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
-
 config I2C_AMD756
 	tristate "  AMD 756/766"
-	depends on I2C_MAINBOARD
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  756/766/768 mainboard I2C interfaces.
@@ -37,7 +23,6 @@
 
 config I2C_AMD8111
 	tristate "  AMD 8111"
-	depends on I2C_MAINBOARD
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  8111 mainboard I2C interfaces.
--- 1.1/drivers/i2c/busses/Makefile	Wed Dec 18 16:41:22 2002
+++ edited/drivers/i2c/busses/Makefile	Sun Dec 29 18:10:44 2002
@@ -2,6 +2,5 @@
 # Makefile for the kernel hardware sensors bus drivers.
 #
 
-obj-$(CONFIG_I2C_MAINBOARD)	+= i2c-mainboard.o
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
--- 1.1/drivers/i2c/busses/i2c-mainboard.c	Sun Dec  1 19:42:06 2002
+++ edited/drivers/i2c/busses/i2c-mainboard.c	Sun Dec 29 18:10:37 2002
@@ -1,34 +0,0 @@
-/*
-    i2c-mainboard.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
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
-/* Not configurable as a module */
-
-#include <linux/init.h>
-
-extern int i2c_amd756_init(void);
-
-int __init i2c_mainboard_init_all(void)
-{
-#ifdef CONFIG_I2C_AMD756
-	i2c_amd756_init();
-#endif
-
-	return 0;
-}
--- 1.1/drivers/i2c/chips/Kconfig	Sun Dec  1 19:42:06 2002
+++ edited/drivers/i2c/chips/Kconfig	Sun Dec 29 19:30:33 2002
@@ -5,22 +5,8 @@
 
 menu "I2C Hardware Sensors Chip support"
 
-config SENSORS
-	bool "Hardware sensors chip support"
-	depends on EXPERIMENTAL && I2C && I2C_PROC
-	help
-	  Many modern mainboards have some kind of I2C interface integrated.
-	  This is often in the form of a SMBus, or System Management Bus, which
-	  is basically the same as I2C but which uses only a subset of the I2C
-	  protocol.
-
-	  You will also want the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
-
 config SENSORS_ADM1021
 	tristate "  Analog Devices ADM1021 and compatibles"
-	depends on SENSORS
 	help
 	  If you say yes here you get support for Analog Devices ADM1021 
 	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
@@ -37,7 +23,6 @@
 
 config SENSORS_LM75
 	tristate "  National Semiconductors LM75 and compatibles"
-	depends on SENSORS
 	help
 	  If you say yes here you get support for National Semiconductor LM75
 	  sensor chips and clones: Dallas Semi DS75 and DS1775, TelCon
@@ -51,4 +36,3 @@
 	  http://www.lm-sensors.nu
 
 endmenu
-
--- 1.1/drivers/i2c/chips/Makefile	Wed Dec 18 16:41:29 2002
+++ edited/drivers/i2c/chips/Makefile	Sun Dec 29 18:17:10 2002
@@ -2,6 +2,5 @@
 # Makefile for the kernel hardware sensors chip drivers.
 #
 
-obj-$(CONFIG_SENSORS)		+= sensors.o
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
--- 1.1/drivers/i2c/chips/adm1021.c	Sun Dec  1 19:51:47 2002
+++ edited/drivers/i2c/chips/adm1021.c	Sun Dec 29 20:13:58 2002
@@ -26,7 +26,6 @@
 #include <linux/sensors.h>
 #include <linux/init.h>
 
-MODULE_LICENSE("GPL");
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { SENSORS_I2C_END };
@@ -108,10 +107,6 @@
 	   remote_temp_offset, remote_temp_offset_prec;
 };
 
-int __init sensors_adm1021_init(void);
-void __exit sensors_adm1021_exit(void);
-static int adm1021_cleanup(void);
-
 static int adm1021_attach_adapter(struct i2c_adapter *adapter);
 static int adm1021_detect(struct i2c_adapter *adapter, int address,
 			  unsigned short flags, int kind);
@@ -178,9 +173,6 @@
 	{0}
 };
 
-/* Used by init/cleanup */
-static int __initdata adm1021_initialized = 0;
-
 /* I choose here for semi-static allocation. Complete dynamic
    allocation could also be used; the code needed for this would probably
    take more memory than the datastructure takes now. */
@@ -585,46 +577,21 @@
 	}
 }
 
-int __init sensors_adm1021_init(void)
+static int __init sensors_adm1021_init(void)
 {
-	int res;
 
-	printk("adm1021.o version %s (%s)\n", LM_VERSION, LM_DATE);
-	adm1021_initialized = 0;
-	if ((res = i2c_add_driver(&adm1021_driver))) {
-		printk
-		    ("adm1021.o: Driver registration failed, module not inserted.\n");
-		adm1021_cleanup();
-		return res;
-	}
-	adm1021_initialized++;
-	return 0;
+	return i2c_add_driver(&adm1021_driver);
 }
 
-void __exit sensors_adm1021_exit(void)
+static void __exit sensors_adm1021_exit(void)
 {
-	adm1021_cleanup();
-}
-
-static int adm1021_cleanup(void)
-{
-	int res;
-
-	if (adm1021_initialized >= 1) {
-		if ((res = i2c_del_driver(&adm1021_driver))) {
-			printk
-			    ("adm1021.o: Driver deregistration failed, module not removed.\n");
-			return res;
-		}
-		adm1021_initialized--;
-	}
-
-	return 0;
+	i2c_del_driver(&adm1021_driver);
 }
 
 MODULE_AUTHOR
     ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("adm1021 driver");
+MODULE_LICENSE("GPL");
 
 MODULE_PARM(read_only, "i");
 MODULE_PARM_DESC(read_only, "Don't set any values, read only mode");
--- 1.1/drivers/i2c/chips/lm75.c	Sun Dec  1 19:49:04 2002
+++ edited/drivers/i2c/chips/lm75.c	Sun Dec 29 20:14:30 2002
@@ -25,7 +25,6 @@
 #include <linux/sensors.h>
 #include <linux/init.h>
 
-MODULE_LICENSE("GPL");
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { SENSORS_I2C_END };
@@ -66,10 +65,6 @@
 	u16 temp, temp_os, temp_hyst;	/* Register values */
 };
 
-int __init sensors_lm75_init(void);
-void __exit sensors_lm75_exit(void);
-static int lm75_cleanup(void);
-
 static int lm75_attach_adapter(struct i2c_adapter *adapter);
 static int lm75_detect(struct i2c_adapter *adapter, int address,
 		       unsigned short flags, int kind);
@@ -110,9 +105,6 @@
 	{0}
 };
 
-/* Used by init/cleanup */
-static int __initdata lm75_initialized = 0;
-
 static int lm75_id = 0;
 
 int lm75_attach_adapter(struct i2c_adapter *adapter)
@@ -188,10 +180,7 @@
 		type_name = "lm75";
 		client_name = "LM75 chip";
 	} else {
-#ifdef DEBUG
-		printk("lm75.o: Internal error: unknown kind (%d)?!?",
-		       kind);
-#endif
+		pr_debug("lm75.o: Internal error: unknown kind (%d)?!?", kind);
 		goto error1;
 	}
 
@@ -314,10 +303,7 @@
 
 	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
 	    (jiffies < data->last_updated) || !data->valid) {
-
-#ifdef DEBUG
-		printk("Starting lm75 update\n");
-#endif
+		pr_debug("Starting lm75 update\n");
 
 		data->temp = lm75_read_value(client, LM75_REG_TEMP);
 		data->temp_os = lm75_read_value(client, LM75_REG_TEMP_OS);
@@ -359,45 +345,17 @@
 
 int __init sensors_lm75_init(void)
 {
-	int res;
-
-	printk("lm75.o version %s (%s)\n", LM_VERSION, LM_DATE);
-	lm75_initialized = 0;
-	if ((res = i2c_add_driver(&lm75_driver))) {
-		printk
-		    ("lm75.o: Driver registration failed, module not inserted.\n");
-		lm75_cleanup();
-		return res;
-	}
-	lm75_initialized++;
-	return 0;
-}
-
-void __exit sensors_lm75_exit(void)
-{
-	lm75_cleanup();
+	return i2c_add_driver(&lm75_driver);
 }
 
-static int lm75_cleanup(void)
+static void __exit sensors_lm75_exit(void)
 {
-	int res;
-
-	if (lm75_initialized >= 1) {
-		if ((res = i2c_del_driver(&lm75_driver))) {
-			printk
-			    ("lm75.o: Driver deregistration failed, module not removed.\n");
-			return res;
-		}
-		lm75_initialized--;
-	}
-
-	return 0;
+	i2c_del_driver(&lm75_driver);
 }
 
-EXPORT_NO_SYMBOLS;
-
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("LM75 driver");
+MODULE_LICENSE("GPL");
 
 module_init(sensors_lm75_init);
 module_exit(sensors_lm75_exit);
--- 1.1/drivers/i2c/chips/sensors.c	Sun Dec  1 19:42:06 2002
+++ edited/drivers/i2c/chips/sensors.c	Sun Dec 29 18:17:05 2002
@@ -1,37 +0,0 @@
-/*
-    sensors.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
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
-/* Not configurable as a module */
-
-#include <linux/init.h>
-
-extern int sensors_adm1021_init(void);
-extern int sensors_lm75_init(void);
-
-int __init sensors_init_all(void)
-{
-#ifdef CONFIG_SENSORS_ADM1021
-	sensors_adm1021_init();
-#endif
-#ifdef CONFIG_SENSORS_LM75
-	sensors_lm75_init();
-#endif
-	return 0;
-}
