Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262605AbTCMXx0>; Thu, 13 Mar 2003 18:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbTCMXx0>; Thu, 13 Mar 2003 18:53:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16059 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262605AbTCMXwz>;
	Thu, 13 Mar 2003 18:52:55 -0500
Message-ID: <3E711C6D.3060100@pobox.com>
Date: Thu, 13 Mar 2003 19:03:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2/5] rng driver update
References: <3E711C0A.40705@pobox.com>
In-Reply-To: <3E711C0A.40705@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------090303020003070901030603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090303020003070901030603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------090303020003070901030603
Content-Type: text/plain;
 name="patch.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.2"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1105  -> 1.1106 
#	drivers/char/Kconfig	1.8     -> 1.9    
#	drivers/char/hw_random.c	1.4     -> 1.5    
#	drivers/char/Makefile	1.55    -> 1.56   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/13	jgarzik@redhat.com	1.1106
# [hw_random] update amd768_rng driver to be modular; add Intel support
# 
# Take Alan's amd768_rng driver, recently renamed to hw_random.c,
# and convert it's very-simple structure to support multiple
# types of hardware RNG.  Integrate Intel i8xx (ICH) RNG support.
# --------------------------------------------
#
diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Thu Mar 13 18:52:44 2003
+++ b/drivers/char/Kconfig	Thu Mar 13 18:52:44 2003
@@ -709,39 +709,20 @@
 
 	  If you're not sure, say N.
 
-config INTEL_RNG
-	tristate "Intel i8x0 Random Number Generator support"
+config HW_RANDOM
+	tristate "Intel/AMD H/W Random Number Generator support"
 	depends on (X86 || IA64) && PCI
 	---help---
 	  This driver provides kernel-side support for the Random Number
-	  Generator hardware found on Intel i8xx-based motherboards.
+	  Generator hardware found on Intel i8xx-based motherboards,
+	  and AMD 76x-based motherboards.
 
-	  Both a character driver, used to read() entropy data, and a timer
-	  function which automatically adds entropy directly into the
-	  kernel pool, are exported by this driver.
+	  Provides a character driver, used to read() entropy data.
 
 	  To compile this driver as a module ( = code which can be inserted in
 	  and removed from the running kernel whenever you want), say M here
 	  and read <file:Documentation/modules.txt>. The module will be called
-	  i810_rng.
-
-	  If unsure, say N.
-
-config AMD_RNG
-	tristate "AMD 768 Random Number Generator support"
-	depends on X86 && PCI
-	---help---
-	  This driver provides kernel-side support for the Random Number
-	  Generator hardware found on AMD 76x based motherboards.
-
-	  Both a character driver, used to read() entropy data, and a timer
-	  function which automatically adds entropy directly into the
-	  kernel pool, are exported by this driver.
-
-	  To compile this driver as a module ( = code which can be inserted in
-	  and removed from the running kernel whenever you want), say M here
-	  and read <file:Documentation/modules.txt>. The module will be called
-	  amd768_rng.
+	  hw_random.
 
 	  If unsure, say N.
 
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Thu Mar 13 18:52:44 2003
+++ b/drivers/char/Makefile	Thu Mar 13 18:52:44 2003
@@ -59,8 +59,7 @@
 obj-$(CONFIG_TOSHIBA) += toshiba.o
 obj-$(CONFIG_I8K) += i8k.o
 obj-$(CONFIG_DS1620) += ds1620.o
-obj-$(CONFIG_INTEL_RNG) += i810_rng.o
-obj-$(CONFIG_AMD_RNG) += amd768_rng.o
+obj-$(CONFIG_HW_RANDOM) += hw_random.o
 obj-$(CONFIG_QIC02_TAPE) += tpqic02.o
 obj-$(CONFIG_FTAPE) += ftape/
 obj-$(CONFIG_H8) += h8.o
diff -Nru a/drivers/char/hw_random.c b/drivers/char/hw_random.c
--- a/drivers/char/hw_random.c	Thu Mar 13 18:52:44 2003
+++ b/drivers/char/hw_random.c	Thu Mar 13 18:52:44 2003
@@ -1,14 +1,19 @@
 /*
- 	Hardware driver for the AMD 768 Random Number Generator (RNG)
-	(c) Copyright 2001 Red Hat Inc <alan@redhat.com>
+ 	Hardware driver for the Intel/AMD Random Number Generators (RNG)
+	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
  
  	derived from
  
+        Hardware driver for the AMD 768 Random Number Generator (RNG)
+        (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
+
+ 	derived from
+ 
 	Hardware driver for Intel i810 Random Number Generator (RNG)
 	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
 	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
 
-	Please read Documentation/i810_rng.txt for details on use.
+	Please read Documentation/hw_random.txt for details on use.
 
 	----------------------------------------------------------
 	This software may be used and distributed according to the terms
@@ -37,8 +42,8 @@
 /*
  * core module and version information
  */
-#define RNG_VERSION "0.1.0"
-#define RNG_MODULE_NAME "amd768_rng"
+#define RNG_VERSION "0.9.0"
+#define RNG_MODULE_NAME "hw_random"
 #define RNG_DRIVER_NAME   RNG_MODULE_NAME " hardware driver " RNG_VERSION
 #define PFX RNG_MODULE_NAME ": "
 
@@ -55,7 +60,7 @@
 #define DPRINTK(fmt, args...)
 #endif
 
-#undef RNG_NDEBUG        /* define to disable lightweight runtime checks */
+#define RNG_NDEBUG        /* define to disable lightweight runtime checks */
 #ifdef RNG_NDEBUG
 #define assert(expr)
 #else
@@ -68,30 +73,269 @@
 
 #define RNG_MISCDEV_MINOR		183 /* official */
 
+static int rng_dev_open (struct inode *inode, struct file *filp);
+static int rng_dev_release (struct inode *inode, struct file *filp);
+static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
+			     loff_t * offp);
+
+static int __init intel_init (struct pci_dev *dev);
+static void __exit intel_cleanup(void);
+static unsigned int intel_data_present (void);
+static u32 intel_data_read (void);
+
+static int __init amd_init (struct pci_dev *dev);
+static void __exit amd_cleanup(void);
+static unsigned int amd_data_present (void);
+static u32 amd_data_read (void);
+
+struct rng_operations {
+	int (*init) (struct pci_dev *dev);
+	void (*cleanup) (void);
+	unsigned int (*data_present) (void);
+	u32 (*data_read) (void);
+	unsigned int n_bytes; /* number of bytes per ->data_read */
+};
+static struct rng_operations *rng_ops;
+
+static struct semaphore rng_open_sem;	/* Semaphore for serializing rng_open/release */
+
+static struct file_operations rng_chrdev_ops = {
+	.owner		= THIS_MODULE,
+	.open		= rng_dev_open,
+	.release	= rng_dev_release,
+	.read		= rng_dev_read,
+};
+
+
+static struct miscdevice rng_miscdev = {
+	RNG_MISCDEV_MINOR,
+	RNG_MODULE_NAME,
+	&rng_chrdev_ops,
+};
+
+enum {
+	rng_hw_none,
+	rng_hw_intel,
+	rng_hw_amd,
+};
+
+static struct rng_operations rng_vendor_ops[] __initdata = {
+	/* rng_hw_none */
+	{ },
+
+	/* rng_hw_intel */
+	{ intel_init, intel_cleanup, intel_data_present,
+	  intel_data_read, 1 },
+
+	/* rng_hw_amd */
+	{ amd_init, amd_cleanup, amd_data_present, amd_data_read, 4 },
+};
+
 /*
- * various RNG status variables.  they are globals
- * as we only support a single RNG device
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
  */
+static struct pci_device_id rng_pci_tbl[] __initdata = {
+	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
 
-static u32 pmbase;			/* PMxx I/O base */
-static struct semaphore rng_open_sem;	/* Semaphore for serializing rng_open/release */
+	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+
+	{ 0, },	/* terminate list */
+};
+MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
 
 
+/***********************************************************************
+ *
+ * Intel RNG operations
+ *
+ */
+
 /*
- * inlined helper functions for accessing RNG registers
+ * RNG registers (offsets from rng_mem)
  */
+#define INTEL_RNG_HW_STATUS			0
+#define         INTEL_RNG_PRESENT		0x40
+#define         INTEL_RNG_ENABLED		0x01
+#define INTEL_RNG_STATUS			1
+#define         INTEL_RNG_DATA_PRESENT		0x01
+#define INTEL_RNG_DATA				2
+
+/*
+ * Magic address at which Intel PCI bridges locate the RNG
+ */
+#define INTEL_RNG_ADDR				0xFFBC015F
+#define INTEL_RNG_ADDR_LEN			3
+
+/* token to our ioremap'd RNG register area */
+static void *rng_mem;
+
+static inline u8 intel_hwstatus (void)
+{
+	assert (rng_mem != NULL);
+	return readb (rng_mem + INTEL_RNG_HW_STATUS);
+}
+
+static inline u8 intel_hwstatus_set (u8 hw_status)
+{
+	assert (rng_mem != NULL);
+	writeb (hw_status, rng_mem + INTEL_RNG_HW_STATUS);
+	return intel_hwstatus ();
+}
+
+static unsigned int intel_data_present(void)
+{
+	assert (rng_mem != NULL);
+
+	return (readb (rng_mem + INTEL_RNG_STATUS) & INTEL_RNG_DATA_PRESENT) ?
+		1 : 0;
+}
+
+static u32 intel_data_read(void)
+{
+	assert (rng_mem != NULL);
+
+	return readb (rng_mem + INTEL_RNG_DATA);
+}
+
+static int __init intel_init (struct pci_dev *dev)
+{
+	int rc;
+	u8 hw_status;
+
+	DPRINTK ("ENTER\n");
+
+	rng_mem = ioremap (INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
+	if (rng_mem == NULL) {
+		printk (KERN_ERR PFX "cannot ioremap RNG Memory\n");
+		rc = -EBUSY;
+		goto err_out;
+	}
+
+	/* Check for Intel 82802 */
+	hw_status = intel_hwstatus ();
+	if ((hw_status & INTEL_RNG_PRESENT) == 0) {
+		printk (KERN_ERR PFX "RNG not detected\n");
+		rc = -ENODEV;
+		goto err_out_free_map;
+	}
+
+	/* turn RNG h/w on, if it's off */
+	if ((hw_status & INTEL_RNG_ENABLED) == 0)
+		hw_status = intel_hwstatus_set (hw_status | INTEL_RNG_ENABLED);
+	if ((hw_status & INTEL_RNG_ENABLED) == 0) {
+		printk (KERN_ERR PFX "cannot enable RNG, aborting\n");
+		rc = -EIO;
+		goto err_out_free_map;
+	}
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+
+err_out_free_map:
+	iounmap (rng_mem);
+	rng_mem = NULL;
+err_out:
+	DPRINTK ("EXIT, returning %d\n", rc);
+	return rc;
+}
+
+static void __exit intel_cleanup(void)
+{
+	u8 hw_status;
+
+	hw_status = intel_hwstatus ();
+	if (hw_status & INTEL_RNG_ENABLED)
+		intel_hwstatus_set (hw_status & ~INTEL_RNG_ENABLED);
+	else
+		printk(KERN_WARNING PFX "unusual: RNG already disabled\n");
+	iounmap(rng_mem);
+	rng_mem = NULL;
+}
+
+/***********************************************************************
+ *
+ * AMD RNG operations
+ *
+ */
+
+static u32 pmbase;			/* PMxx I/O base */
+static struct pci_dev *amd_dev;
 
-static inline int rng_data_present (void)
+static unsigned int amd_data_present (void)
 {
-      	return inl(pmbase+0xF4) & 1;
+      	return inl(pmbase + 0xF4) & 1;
 }
 
 
-static inline int rng_data_read (void)
+static u32 amd_data_read (void)
 {
-	return inl(pmbase+0xF0);
+	return inl(pmbase + 0xF0);
 }
 
+static int __init amd_init (struct pci_dev *dev)
+{
+	int rc;
+	u8 rnen;
+
+	DPRINTK ("ENTER\n");
+
+	pci_read_config_dword(dev, 0x58, &pmbase);
+
+	pmbase &= 0x0000FF00;
+
+	if (pmbase == 0)
+	{
+		printk (KERN_ERR PFX "power management base not set\n");
+		rc = -EIO;
+		goto err_out;
+	}
+
+	pci_read_config_byte(dev, 0x40, &rnen);
+	rnen |= (1 << 7);	/* RNG on */
+	pci_write_config_byte(dev, 0x40, rnen);
+
+	pci_read_config_byte(dev, 0x41, &rnen);
+	rnen |= (1 << 7);	/* PMIO enable */
+	pci_write_config_byte(dev, 0x41, rnen);
+
+	printk(KERN_INFO PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
+
+	amd_dev = dev;
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+
+err_out:
+	DPRINTK ("EXIT, returning %d\n", rc);
+	return rc;
+}
+
+static void __exit amd_cleanup(void)
+{
+	u8 rnen;
+
+	pci_read_config_byte(amd_dev, 0x40, &rnen);
+	rnen &= ~(1 << 7);	/* RNG off */
+	pci_write_config_byte(amd_dev, 0x40, rnen);
+
+	/* FIXME: twiddle pmio, also? */
+}
+
+/***********************************************************************
+ *
+ * /dev/hwrandom character device handling (major 10, minor 183)
+ *
+ */
+
 static int rng_dev_open (struct inode *inode, struct file *filp)
 {
 	if ((filp->f_mode & FMODE_READ) == 0)
@@ -122,7 +366,7 @@
 			     loff_t * offp)
 {
 	static spinlock_t rng_lock = SPIN_LOCK_UNLOCKED;
-	int have_data;
+	unsigned int have_data;
 	u32 data = 0;
 	ssize_t ret = 0;
 
@@ -130,9 +374,9 @@
 		spin_lock(&rng_lock);
 
 		have_data = 0;
-		if (rng_data_present()) {
-			data = rng_data_read();
-			have_data = 4;
+		if (rng_ops->data_present()) {
+			data = rng_ops->data_read();
+			have_data = rng_ops->n_bytes;
 		}
 
 		spin_unlock (&rng_lock);
@@ -166,20 +410,6 @@
 }
 
 
-static struct file_operations rng_chrdev_ops = {
-	.owner		= THIS_MODULE,
-	.open		= rng_dev_open,
-	.release	= rng_dev_release,
-	.read		= rng_dev_read,
-};
-
-
-static struct miscdevice rng_miscdev = {
-	RNG_MISCDEV_MINOR,
-	RNG_MODULE_NAME,
-	&rng_chrdev_ops,
-};
-
 
 /*
  * rng_init_one - look for and attempt to init a single RNG
@@ -187,64 +417,35 @@
 static int __init rng_init_one (struct pci_dev *dev)
 {
 	int rc;
-	u8 rnen;
 
 	DPRINTK ("ENTER\n");
 
-	rc = misc_register (&rng_miscdev);
-	if (rc) {
-		printk (KERN_ERR PFX "cannot register misc device\n");
-		DPRINTK ("EXIT, returning %d\n", rc);
-		goto err_out;
-	}
-
-	pci_read_config_dword(dev, 0x58, &pmbase);
+	assert(rng_ops != NULL);
 
-	pmbase&=0x0000FF00;
+	rc = rng_ops->init(dev);
+	if (rc)
+		goto err_out;
 
-	if(pmbase == 0)
-	{
-		printk (KERN_ERR PFX "power management base not set\n");
-		DPRINTK ("EXIT, returning %d\n", rc);
-		goto err_out_free_miscdev;
+	rc = misc_register (&rng_miscdev);
+	if (rc) {
+		printk (KERN_ERR PFX "misc device register failed\n");
+		goto err_out_cleanup_hw;
 	}
 
-	pci_read_config_byte(dev, 0x40, &rnen);
-	rnen|=(1<<7);	/* RNG on */
-	pci_write_config_byte(dev, 0x40, rnen);
-
-	pci_read_config_byte(dev, 0x41, &rnen);
-	rnen|=(1<<7);	/* PMIO enable */
-	pci_write_config_byte(dev, 0x41, rnen);
-
-	printk(KERN_INFO PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 
-err_out_free_miscdev:
-	misc_deregister (&rng_miscdev);
+err_out_cleanup_hw:
+	rng_ops->cleanup();
 err_out:
+	DPRINTK ("EXIT, returning %d\n", rc);
 	return rc;
 }
 
 
-/*
- * Data for PCI driver interface
- *
- * This data only exists for exporting the supported
- * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
- * register a pci_driver, because someone else might one day
- * want to register another driver on the same PCI id.
- */
-static struct pci_device_id rng_pci_tbl[] __initdata = {
-	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0, },
-};
-MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
-
 
-MODULE_AUTHOR("Alan Cox, Jeff Garzik, Philipp Rumpf, Matt Sottek");
-MODULE_DESCRIPTION("AMD 768 Random Number Generator (RNG) driver");
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver");
 MODULE_LICENSE("GPL");
 
 
@@ -255,14 +456,19 @@
 {
 	int rc;
 	struct pci_dev *pdev;
+	const struct pci_device_id *ent;
 
 	DPRINTK ("ENTER\n");
 
 	init_MUTEX (&rng_open_sem);
 
+	/* Probe for Intel, AMD RNGs */
 	pci_for_each_dev(pdev) {
-		if (pci_match_device (rng_pci_tbl, pdev) != NULL)
+		ent = pci_match_device (rng_pci_tbl, pdev);
+		if (ent) {
+			rng_ops = &rng_vendor_ops[ent->driver_data];
 			goto match;
+		}
 	}
 
 	DPRINTK ("EXIT, returning -ENODEV\n");
@@ -286,7 +492,12 @@
 static void __exit rng_cleanup (void)
 {
 	DPRINTK ("ENTER\n");
+
 	misc_deregister (&rng_miscdev);
+
+	if (rng_ops->cleanup)
+		rng_ops->cleanup();
+
 	DPRINTK ("EXIT\n");
 }
 

--------------090303020003070901030603--

