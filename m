Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269718AbRHTWgf>; Mon, 20 Aug 2001 18:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269735AbRHTWg1>; Mon, 20 Aug 2001 18:36:27 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:51847 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269728AbRHTWgU>; Mon, 20 Aug 2001 18:36:20 -0400
Date: Mon, 20 Aug 2001 15:36:35 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.9/drivers/i2o to new module_{init,exit} interface
Message-ID: <20010820153635.A28930@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>Sounds ok to me - Im not against tidying it up. Note btw the -ac i2o code
>is a little different to vanilla and is the 'current' one. I think your
>patches will apply fine however as the changes are small

	Great.  Here is a new patch.  I have removed the CONFIG_NET
diff that did not belong, and I added a diff to linux/Makefile
to initialize drivers/i2o just before drivers/block, preserving
the current initialization order.

	Thanks again for processing this patch.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i2o.diffs"

--- linux-2.4.9/drivers/block/genhd.c	Thu Jul 19 17:48:15 2001
+++ linux/drivers/block/genhd.c	Mon Aug 20 07:21:36 2001
@@ -28,16 +28,12 @@
 extern void console_map_init(void);
 extern int soc_probe(void);
 extern int atmdev_init(void);
-extern int i2o_init(void);
 extern int cpqarray_init(void);
 
 int __init device_init(void)
 {
 	blk_dev_init();
 	sti();
-#ifdef CONFIG_I2O
-	i2o_init();
-#endif
 #ifdef CONFIG_BLK_DEV_DAC960
 	DAC960_Initialize();
 #endif
diff -u -r linux-2.4.9/drivers/i2o/i2o_block.c linux/drivers/i2o/i2o_block.c
--- linux-2.4.9/drivers/i2o/i2o_block.c	Thu Aug 16 09:50:06 2001
+++ linux/drivers/i2o/i2o_block.c	Sun Aug 19 06:21:15 2001
@@ -44,6 +44,7 @@
 
 #include <linux/module.h>
 
+#include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/stat.h>
@@ -1875,10 +1876,6 @@
  *  (Just smiley confuses emacs :-)
  */
 
-#ifdef MODULE
-#define i2o_block_init init_module
-#endif
-
 int i2o_block_init(void)
 {
 	int i;
@@ -1895,9 +1892,7 @@
 		       MAJOR_NR);
 		return -EIO;
 	}
-#ifdef MODULE
 	printk(KERN_INFO "i2o_block: registered device at major %d\n", MAJOR_NR);
-#endif
 
 	/*
 	 *	Now fill in the boiler plate
@@ -1985,13 +1980,11 @@
 	return 0;
 }
 
-#ifdef MODULE
-
 EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR("Red Hat Software");
 MODULE_DESCRIPTION("I2O Block Device OSM");
 
-void cleanup_module(void)
+static __exit void i2o_block_exit(void)
 {
 	struct gendisk *gdp;
 	int i;
@@ -2066,4 +2059,6 @@
 			}
 	}
 }
-#endif
+
+module_init(i2o_block_init);
+module_exit(i2o_block_exit);
diff -u -r linux-2.4.9/drivers/i2o/i2o_config.c linux/drivers/i2o/i2o_config.c
--- linux-2.4.9/drivers/i2o/i2o_config.c	Thu Aug 16 09:50:15 2001
+++ linux/drivers/i2o/i2o_config.c	Sun Aug 19 06:21:15 2001
@@ -908,11 +908,7 @@
 	&config_fops
 };	
 
-#ifdef MODULE
-int init_module(void)
-#else
 int __init i2o_config_init(void)
-#endif
 {
 	printk(KERN_INFO "I2O configuration manager v 0.04.\n");
 	printk(KERN_INFO "  (C) Copyright 1999 Red Hat Software\n");
@@ -945,10 +941,9 @@
 	i2o_cfg_context = cfg_handler.context;
 	return 0;
 }
+module_init(i2o_config_init);
 
-#ifdef MODULE
-
-void cleanup_module(void)
+static __exit void i2o_config_exit(void)
 {
 	misc_deregister(&i2o_miscdev);
 	
@@ -957,9 +952,9 @@
 	if(i2o_cfg_context != -1)
 		i2o_remove_handler(&cfg_handler);
 }
- 
+
+module_exit(i2o_config_exit);
+
 EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR("Red Hat Software");
 MODULE_DESCRIPTION("I2O Configuration");
-
-#endif
diff -u -r linux-2.4.9/drivers/i2o/i2o_core.c linux/drivers/i2o/i2o_core.c
--- linux-2.4.9/drivers/i2o/i2o_core.c	Thu Aug 16 09:50:24 2001
+++ linux/drivers/i2o/i2o_core.c	Sun Aug 19 06:21:15 2001
@@ -120,7 +120,6 @@
  */
 static spinlock_t i2o_dev_lock = SPIN_LOCK_UNLOCKED;
 
-#ifdef MODULE
 /* 
  * Function table to send to bus specific layers
  * See <include/linux/i2o.h> for explanation of this
@@ -140,8 +139,6 @@
 extern void i2o_pci_core_detach(void);
 #endif /* CONFIG_I2O_PCI_MODULE */
 
-#endif /* MODULE */
-
 /*
  * Structures and definitions for synchronous message posting.
  * See i2o_post_wait() for description.
@@ -3423,13 +3420,11 @@
 
 EXPORT_SYMBOL(i2o_get_class_name);
 
-#ifdef MODULE
-
 MODULE_AUTHOR("Red Hat Software");
 MODULE_DESCRIPTION("I2O Core");
 
 
-int init_module(void)
+static int __init i2o_init(void)
 {
 	printk(KERN_INFO "I2O Core - (C) Copyright 1999 Red Hat Software\n");
 	if (i2o_install_handler(&i2o_core_handler) < 0)
@@ -3471,7 +3466,7 @@
 	return 0;
 }
 
-void cleanup_module(void)
+static void __exit i2o_exit(void)
 {
 	int stat;
 
@@ -3502,63 +3497,5 @@
 	unregister_reboot_notifier(&i2o_reboot_notifier);
 }
 
-#else
-
-extern int i2o_block_init(void);
-extern int i2o_config_init(void);
-extern int i2o_lan_init(void);
-extern int i2o_pci_init(void);
-extern int i2o_proc_init(void);
-extern int i2o_scsi_init(void);
-
-int __init i2o_init(void)
-{
-	printk(KERN_INFO "Loading I2O Core - (c) Copyright 1999 Red Hat Software\n");
-	
-	if (i2o_install_handler(&i2o_core_handler) < 0)
-	{
-		printk(KERN_ERR 
-			"i2o_core: Unable to install core handler.\nI2O stack not loaded!");
-		return 0;
-	}
-
-	core_context = i2o_core_handler.context;
-
-	/*
-	 * Initialize event handling thread
-	 * We may not find any controllers, but still want this as 
-	 * down the road we may have hot pluggable controllers that
-	 * need to be dealt with.
-	 */	
-	init_MUTEX_LOCKED(&evt_sem);
-	if((evt_pid = kernel_thread(i2o_core_evt, &evt_reply, CLONE_SIGHAND)) < 0)
-	{
-		printk(KERN_ERR "I2O: Could not create event handler kernel thread\n");
-		i2o_remove_handler(&i2o_core_handler);
-		return 0;
-	}
-
-
-#ifdef CONFIG_I2O_PCI
-	i2o_pci_init();
-#endif
-
-	if(i2o_num_controllers)
-		i2o_sys_init();
-
-	register_reboot_notifier(&i2o_reboot_notifier);
-
-	i2o_config_init();
-#ifdef CONFIG_I2O_BLOCK
-	i2o_block_init();
-#endif
-#ifdef CONFIG_I2O_LAN
-	i2o_lan_init();
-#endif
-#ifdef CONFIG_I2O_PROC
-	i2o_proc_init();
-#endif
-	return 0;
-}
-
-#endif
+module_init(i2o_init);
+module_exit(i2o_exit);
diff -u -r linux-2.4.9/drivers/i2o/i2o_lan.c linux/drivers/i2o/i2o_lan.c
--- linux-2.4.9/drivers/i2o/i2o_lan.c	Sun Aug 12 11:16:18 2001
+++ linux/drivers/i2o/i2o_lan.c	Sun Aug 19 06:21:16 2001
@@ -1430,11 +1430,7 @@
 	return dev;
 }
 
-#ifdef MODULE
-#define i2o_lan_init	init_module
-#endif
-
-int __init i2o_lan_init(void)
+static int __init i2o_lan_init(void)
 {
 	struct net_device *dev;
 	int i;
@@ -1515,9 +1511,7 @@
 	return 0;
 }
 
-#ifdef MODULE
-
-void cleanup_module(void)
+static void __exit i2o_lan_exit(void)
 {
 	int i;
 
@@ -1561,6 +1555,9 @@
 }
 
 EXPORT_NO_SYMBOLS;
+module_init(i2o_lan_init);
+module_exit(i2o_lan_exit);
+
 
 MODULE_AUTHOR("University of Helsinki, Department of Computer Science");
 MODULE_DESCRIPTION("I2O Lan OSM");
@@ -1574,4 +1571,3 @@
 MODULE_PARM(tx_batch_mode, "0-2" "i");
 MODULE_PARM_DESC(tx_batch_mode, "0=Send immediatelly, 1=Send in batches, 2=Switch automatically");
 
-#endif
diff -u -r linux-2.4.9/drivers/i2o/i2o_pci.c linux/drivers/i2o/i2o_pci.c
--- linux-2.4.9/drivers/i2o/i2o_pci.c	Sun Aug 12 11:16:18 2001
+++ linux/drivers/i2o/i2o_pci.c	Sun Aug 19 06:21:16 2001
@@ -31,17 +31,15 @@
 #include <asm/mtrr.h>
 #endif // CONFIG_MTRR
 
-#ifdef MODULE
 /*
  * Core function table
  * See <include/linux/i2o.h> for an explanation
  */
-static struct i2o_core_func_table *core;
+static struct i2o_core_func_table *core; /* = NULL */
 
 /* Core attach function */
 extern int i2o_pci_core_attach(struct i2o_core_func_table *);
 extern void i2o_pci_core_detach(void);
-#endif /* MODULE */
 
 /*
  *	Free bus specific resources
@@ -100,11 +98,7 @@
 static void i2o_pci_interrupt(int irq, void *dev_id, struct pt_regs *r)
 {
 	struct i2o_controller *c = dev_id;
-#ifdef MODULE
 	core->run_queue(c);
-#else
-	i2o_run_queue(c);
-#endif /* MODULE */
 }	
 
 /*
@@ -226,11 +220,7 @@
 
 	I2O_IRQ_WRITE32(c,0xFFFFFFFF);
 
-#ifdef MODULE
 	i = core->install(c);
-#else
-	i = i2o_install_controller(c);
-#endif /* MODULE */
 	
 	if(i<0)
 	{
@@ -250,11 +240,7 @@
 			printk(KERN_ERR "%s: unable to allocate interrupt %d.\n",
 				c->name, dev->irq);
 			c->bus.pci.irq = -1;
-#ifdef MODULE
 			core->delete(c);
-#else
-			i2o_delete_controller(c);
-#endif /* MODULE */	
 			iounmap(mem);
 			return -EBUSY;
 		}
@@ -310,28 +296,17 @@
 	if(c->type == I2O_TYPE_PCI)
 	{
 		I2O_IRQ_WRITE32(c,0);
-#ifdef MODULE
 		if(core->activate(c))
-#else
-		if(i2o_activate_controller(c))
-#endif /* MODULE */
 		{
 			printk("%s: Failed to initialize.\n", c->name);
-#ifdef MODULE
 			core->unlock(c);
 			core->delete(c);
-#else
-			i2o_unlock_controller(c);
-			i2o_delete_controller(c);
-#endif
 			continue;
 		}
 	}
 }
 #endif // I2O_HOTPLUG_SUPPORT
 
-#ifdef MODULE
-
 int i2o_pci_core_attach(struct i2o_core_func_table *table)
 {
 	MOD_INC_USE_COUNT;
@@ -348,30 +323,17 @@
 	MOD_DEC_USE_COUNT;
 }
 
-int init_module(void)
-{
-	printk(KERN_INFO "Linux I2O PCI support (c) 1999 Red Hat Software.\n");
-	
-	core = NULL;
-
- 	return 0;
- 
-}
-
-void cleanup_module(void)
-{
-}
-
 EXPORT_SYMBOL(i2o_pci_core_attach);
 EXPORT_SYMBOL(i2o_pci_core_detach);
 
 MODULE_AUTHOR("Red Hat Software");
 MODULE_DESCRIPTION("I2O PCI Interface");
 
-#else
-void __init i2o_pci_init(void)
+static int __init i2o_pci_init(void)
 {
 	printk(KERN_INFO "Linux I2O PCI support (c) 1999 Red Hat Software.\n");
-	i2o_pci_scan();
+	return i2o_pci_scan();
 }
-#endif
+
+module_init(i2o_pci_init);
+
diff -u -r linux-2.4.9/drivers/i2o/i2o_proc.c linux/drivers/i2o/i2o_proc.c
--- linux-2.4.9/drivers/i2o/i2o_proc.c	Sun Aug 12 11:16:18 2001
+++ linux/drivers/i2o/i2o_proc.c	Sun Aug 19 06:21:16 2001
@@ -3372,8 +3372,6 @@
 	i2o_remove_handler(&i2o_proc_handler);
 }
 
-#ifdef MODULE
 module_init(i2o_proc_init);
-#endif
 module_exit(i2o_proc_exit);
 
--- linux-2.4.9/Makefile	Thu Aug 16 11:12:49 2001
+++ linux/Makefile	Mon Aug 20 08:17:01 2001
@@ -130,11 +130,15 @@
 
 DRIVERS-$(CONFIG_ACPI) += drivers/acpi/acpi.o
 DRIVERS-$(CONFIG_PARPORT) += drivers/parport/driver.o
-DRIVERS-y += drivers/char/char.o \
-	drivers/block/block.o \
+DRIVERS-y += drivers/char/char.o
+
+DRIVERS-$(CONFIG_I2O) += drivers/i2o/i2o.o
+
+DRIVERS-y += drivers/block/block.o \
 	drivers/misc/misc.o \
 	drivers/net/net.o \
 	drivers/media/media.o
+
 DRIVERS-$(CONFIG_AGP) += drivers/char/agp/agp.o
 DRIVERS-$(CONFIG_DRM) += drivers/char/drm/drm.o
 DRIVERS-$(CONFIG_NUBUS) += drivers/nubus/nubus.a
@@ -175,7 +183,6 @@
 DRIVERS-$(CONFIG_TC) += drivers/tc/tc.a
 DRIVERS-$(CONFIG_USB) += drivers/usb/usbdrv.o
 DRIVERS-$(CONFIG_INPUT) += drivers/input/inputdrv.o
-DRIVERS-$(CONFIG_I2O) += drivers/i2o/i2o.o
 DRIVERS-$(CONFIG_IRDA) += drivers/net/irda/irda.o
 DRIVERS-$(CONFIG_I2C) += drivers/i2c/i2c.o
 DRIVERS-$(CONFIG_PHONE) += drivers/telephony/telephony.o

--SUOF0GtieIMvvwua--
