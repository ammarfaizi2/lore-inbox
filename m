Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262995AbTCLDO4>; Tue, 11 Mar 2003 22:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263001AbTCLDO4>; Tue, 11 Mar 2003 22:14:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24219 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262995AbTCLDN6>;
	Tue, 11 Mar 2003 22:13:58 -0500
Message-ID: <3E6EA885.8000402@pobox.com>
Date: Tue, 11 Mar 2003 22:24:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [patch 1/3] shuffle hw_random files
Content-Type: multipart/mixed;
 boundary="------------090609000501030902090400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090609000501030902090400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Preparing for the next patch, to make it more readable, this patch does 
nothing but rename or delete files.

--------------090609000501030902090400
Content-Type: text/plain;
 name="patch0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch0"

# --------------------------------------------
# 03/03/11	jgarzik@redhat.com	1.1101
# [hw_random] shuffle files
# 
# Delete drivers/char/i810_rng.c, superceded.
# Rename Doc/i810_rng.txt to Doc/hw_random.txt.
# Rename drv/char/amd768_rng.c to drv/char/hw_random.c.
# --------------------------------------------
#
diff -Nru a/Documentation/hw_random.txt b/Documentation/hw_random.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/hw_random.txt	Tue Mar 11 21:37:19 2003
@@ -0,0 +1,134 @@
+	Hardware driver for Intel i810 Random Number Generator (RNG)
+	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
+	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
+
+Introduction:
+
+	The i810_rng device driver is software that makes use of a
+	special hardware feature on the Intel i8xx-based chipsets,
+	a Random Number Generator (RNG).
+
+	In order to make effective use of this device driver, you
+	should download the support software as well.  Download the
+	latest version of the "intel-rng-tools" package from the
+	i810_rng driver's official Web site:
+
+		http://sourceforge.net/projects/gkernel/
+
+About the Intel RNG hardware, from the firmware hub datasheet:
+
+	The Firmware Hub integrates a Random Number Generator (RNG)
+	using thermal noise generated from inherently random quantum
+	mechanical properties of silicon. When not generating new random
+	bits the RNG circuitry will enter a low power state. Intel will
+	provide a binary software driver to give third party software
+	access to our RNG for use as a security feature. At this time,
+	the RNG is only to be used with a system in an OS-present state.
+
+Theory of operation:
+
+	Character driver.  Using the standard open()
+	and read() system calls, you can read random data from
+	the i810 RNG device.  This data is NOT CHECKED by any
+	fitness tests, and could potentially be bogus (if the
+	hardware is faulty or has been tampered with).  Data is only
+	output if the hardware "has-data" flag is set, but nevertheless
+	a security-conscious person would run fitness tests on the
+	data before assuming it is truly random.
+
+	/dev/intel_rng is char device major 10, minor 183.
+
+Driver notes:
+
+	* FIXME: support poll(2)
+
+	NOTE: request_mem_region was removed, for two reasons:
+	1) Only one RNG is supported by this driver, 2) The location
+	used by the RNG is a fixed location in MMIO-addressable memory,
+	3) users with properly working BIOS e820 handling will always
+	have the region in which the RNG is located reserved, so
+	request_mem_region calls always fail for proper setups.
+	However, for people who use mem=XX, BIOS e820 information is
+	-not- in /proc/iomem, and request_mem_region(RNG_ADDR) can
+	succeed.
+
+Driver details:
+
+	Based on:
+	Intel 82802AB/82802AC Firmware Hub (FWH) Datasheet
+		May 1999 Order Number: 290658-002 R
+
+	Intel 82802 Firmware Hub: Random Number Generator
+	Programmer's Reference Manual
+		December 1999 Order Number: 298029-001 R
+
+	Intel 82802 Firmware HUB Random Number Generator Driver
+	Copyright (c) 2000 Matt Sottek <msottek@quiknet.com>
+
+	Special thanks to Matt Sottek.  I did the "guts", he
+	did the "brains" and all the testing.
+
+Change history:
+
+	Version 0.9.8:
+	* Support other i8xx chipsets by adding 82801E detection
+	* 82801DB detection is the same as for 82801CA.
+
+	Version 0.9.7:
+	* Support other i8xx chipsets too (by adding 82801BA(M) and
+	  82801CA(M) detection)
+
+	Version 0.9.6:
+	* Internal driver cleanups, prep for 1.0.0 release.
+
+	Version 0.9.5:
+	* Rip out entropy injection via timer.  It never ever worked,
+	  and a better solution (rngd) is now available.
+
+	Version 0.9.4:
+	* Fix: Remove request_mem_region
+	* Fix: Horrible bugs in FIPS calculation and test execution
+
+	Version 0.9.3:
+	* Clean up rng_read a bit.
+	* Update i810_rng driver Web site URL.
+	* Increase default timer interval to 4 samples per second.
+	* Abort if mem region is not available.
+	* BSS zero-initialization cleanup.
+	* Call misc_register() from rng_init_one.
+	* Fix O_NONBLOCK to occur before we schedule.
+
+	Version 0.9.2:
+	* Simplify open blocking logic
+
+	Version 0.9.1:
+	* Support i815 chipsets too (Matt Sottek)
+	* Fix reference counting when statically compiled (prumpf)
+	* Rewrite rng_dev_read (prumpf)
+	* Make module races less likely (prumpf)
+	* Small miscellaneous bug fixes (prumpf)
+	* Use pci table for PCI id list
+
+	Version 0.9.0:
+	* Don't register a pci_driver, because we are really
+	  using PCI bridge vendor/device ids, and someone
+	  may want to register a driver for the bridge. (bug fix)
+	* Don't let the usage count go negative (bug fix)
+	* Clean up spinlocks (bug fix)
+	* Enable PCI device, if necessary (bug fix)
+	* iounmap on module unload (bug fix)
+	* If RNG chrdev is already in use when open(2) is called,
+	  sleep until it is available.
+	* Remove redundant globals rng_allocated, rng_use_count
+	* Convert numeric globals to unsigned
+	* Module unload cleanup
+
+	Version 0.6.2:
+	* Clean up spinlocks.  Since we don't have any interrupts
+	  to worry about, but we do have a timer to worry about,
+	  we use spin_lock_bh everywhere except the timer function
+	  itself.
+	* Fix module load/unload.
+	* Fix timer function and h/w enable/disable logic
+	* New timer interval sysctl
+	* Clean up sysctl names
diff -Nru a/Documentation/i810_rng.txt b/Documentation/i810_rng.txt
--- a/Documentation/i810_rng.txt	Tue Mar 11 21:37:19 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,134 +0,0 @@
-	Hardware driver for Intel i810 Random Number Generator (RNG)
-	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
-	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
-
-Introduction:
-
-	The i810_rng device driver is software that makes use of a
-	special hardware feature on the Intel i8xx-based chipsets,
-	a Random Number Generator (RNG).
-
-	In order to make effective use of this device driver, you
-	should download the support software as well.  Download the
-	latest version of the "intel-rng-tools" package from the
-	i810_rng driver's official Web site:
-
-		http://sourceforge.net/projects/gkernel/
-
-About the Intel RNG hardware, from the firmware hub datasheet:
-
-	The Firmware Hub integrates a Random Number Generator (RNG)
-	using thermal noise generated from inherently random quantum
-	mechanical properties of silicon. When not generating new random
-	bits the RNG circuitry will enter a low power state. Intel will
-	provide a binary software driver to give third party software
-	access to our RNG for use as a security feature. At this time,
-	the RNG is only to be used with a system in an OS-present state.
-
-Theory of operation:
-
-	Character driver.  Using the standard open()
-	and read() system calls, you can read random data from
-	the i810 RNG device.  This data is NOT CHECKED by any
-	fitness tests, and could potentially be bogus (if the
-	hardware is faulty or has been tampered with).  Data is only
-	output if the hardware "has-data" flag is set, but nevertheless
-	a security-conscious person would run fitness tests on the
-	data before assuming it is truly random.
-
-	/dev/intel_rng is char device major 10, minor 183.
-
-Driver notes:
-
-	* FIXME: support poll(2)
-
-	NOTE: request_mem_region was removed, for two reasons:
-	1) Only one RNG is supported by this driver, 2) The location
-	used by the RNG is a fixed location in MMIO-addressable memory,
-	3) users with properly working BIOS e820 handling will always
-	have the region in which the RNG is located reserved, so
-	request_mem_region calls always fail for proper setups.
-	However, for people who use mem=XX, BIOS e820 information is
-	-not- in /proc/iomem, and request_mem_region(RNG_ADDR) can
-	succeed.
-
-Driver details:
-
-	Based on:
-	Intel 82802AB/82802AC Firmware Hub (FWH) Datasheet
-		May 1999 Order Number: 290658-002 R
-
-	Intel 82802 Firmware Hub: Random Number Generator
-	Programmer's Reference Manual
-		December 1999 Order Number: 298029-001 R
-
-	Intel 82802 Firmware HUB Random Number Generator Driver
-	Copyright (c) 2000 Matt Sottek <msottek@quiknet.com>
-
-	Special thanks to Matt Sottek.  I did the "guts", he
-	did the "brains" and all the testing.
-
-Change history:
-
-	Version 0.9.8:
-	* Support other i8xx chipsets by adding 82801E detection
-	* 82801DB detection is the same as for 82801CA.
-
-	Version 0.9.7:
-	* Support other i8xx chipsets too (by adding 82801BA(M) and
-	  82801CA(M) detection)
-
-	Version 0.9.6:
-	* Internal driver cleanups, prep for 1.0.0 release.
-
-	Version 0.9.5:
-	* Rip out entropy injection via timer.  It never ever worked,
-	  and a better solution (rngd) is now available.
-
-	Version 0.9.4:
-	* Fix: Remove request_mem_region
-	* Fix: Horrible bugs in FIPS calculation and test execution
-
-	Version 0.9.3:
-	* Clean up rng_read a bit.
-	* Update i810_rng driver Web site URL.
-	* Increase default timer interval to 4 samples per second.
-	* Abort if mem region is not available.
-	* BSS zero-initialization cleanup.
-	* Call misc_register() from rng_init_one.
-	* Fix O_NONBLOCK to occur before we schedule.
-
-	Version 0.9.2:
-	* Simplify open blocking logic
-
-	Version 0.9.1:
-	* Support i815 chipsets too (Matt Sottek)
-	* Fix reference counting when statically compiled (prumpf)
-	* Rewrite rng_dev_read (prumpf)
-	* Make module races less likely (prumpf)
-	* Small miscellaneous bug fixes (prumpf)
-	* Use pci table for PCI id list
-
-	Version 0.9.0:
-	* Don't register a pci_driver, because we are really
-	  using PCI bridge vendor/device ids, and someone
-	  may want to register a driver for the bridge. (bug fix)
-	* Don't let the usage count go negative (bug fix)
-	* Clean up spinlocks (bug fix)
-	* Enable PCI device, if necessary (bug fix)
-	* iounmap on module unload (bug fix)
-	* If RNG chrdev is already in use when open(2) is called,
-	  sleep until it is available.
-	* Remove redundant globals rng_allocated, rng_use_count
-	* Convert numeric globals to unsigned
-	* Module unload cleanup
-
-	Version 0.6.2:
-	* Clean up spinlocks.  Since we don't have any interrupts
-	  to worry about, but we do have a timer to worry about,
-	  we use spin_lock_bh everywhere except the timer function
-	  itself.
-	* Fix module load/unload.
-	* Fix timer function and h/w enable/disable logic
-	* New timer interval sysctl
-	* Clean up sysctl names
diff -Nru a/drivers/char/amd768_rng.c b/drivers/char/amd768_rng.c
--- a/drivers/char/amd768_rng.c	Tue Mar 11 21:37:19 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,295 +0,0 @@
-/*
- 	Hardware driver for the AMD 768 Random Number Generator (RNG)
-	(c) Copyright 2001 Red Hat Inc <alan@redhat.com>
- 
- 	derived from
- 
-	Hardware driver for Intel i810 Random Number Generator (RNG)
-	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
-	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
-
-	Please read Documentation/i810_rng.txt for details on use.
-
-	----------------------------------------------------------
-	This software may be used and distributed according to the terms
-        of the GNU General Public License, incorporated herein by reference.
-
- */
-
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/random.h>
-#include <linux/miscdevice.h>
-#include <linux/smp_lock.h>
-#include <linux/mm.h>
-#include <linux/delay.h>
-
-#include <asm/io.h>
-#include <asm/uaccess.h>
-
-
-/*
- * core module and version information
- */
-#define RNG_VERSION "0.1.0"
-#define RNG_MODULE_NAME "amd768_rng"
-#define RNG_DRIVER_NAME   RNG_MODULE_NAME " hardware driver " RNG_VERSION
-#define PFX RNG_MODULE_NAME ": "
-
-
-/*
- * debugging macros
- */
-#undef RNG_DEBUG /* define to enable copious debugging info */
-
-#ifdef RNG_DEBUG
-/* note: prints function name for you */
-#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
-#else
-#define DPRINTK(fmt, args...)
-#endif
-
-#undef RNG_NDEBUG        /* define to disable lightweight runtime checks */
-#ifdef RNG_NDEBUG
-#define assert(expr)
-#else
-#define assert(expr) \
-        if(!(expr)) {                                   \
-        printk( "Assertion failed! %s,%s,%s,line=%d\n", \
-        #expr,__FILE__,__FUNCTION__,__LINE__);          \
-        }
-#endif
-
-#define RNG_MISCDEV_MINOR		183 /* official */
-
-/*
- * various RNG status variables.  they are globals
- * as we only support a single RNG device
- */
-
-static u32 pmbase;			/* PMxx I/O base */
-static struct semaphore rng_open_sem;	/* Semaphore for serializing rng_open/release */
-
-
-/*
- * inlined helper functions for accessing RNG registers
- */
-
-static inline int rng_data_present (void)
-{
-      	return inl(pmbase+0xF4) & 1;
-}
-
-
-static inline int rng_data_read (void)
-{
-	return inl(pmbase+0xF0);
-}
-
-static int rng_dev_open (struct inode *inode, struct file *filp)
-{
-	if ((filp->f_mode & FMODE_READ) == 0)
-		return -EINVAL;
-	if (filp->f_mode & FMODE_WRITE)
-		return -EINVAL;
-
-	/* wait for device to become free */
-	if (filp->f_flags & O_NONBLOCK) {
-		if (down_trylock (&rng_open_sem))
-			return -EAGAIN;
-	} else {
-		if (down_interruptible (&rng_open_sem))
-			return -ERESTARTSYS;
-	}
-	return 0;
-}
-
-
-static int rng_dev_release (struct inode *inode, struct file *filp)
-{
-	up(&rng_open_sem);
-	return 0;
-}
-
-
-static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
-			     loff_t * offp)
-{
-	static spinlock_t rng_lock = SPIN_LOCK_UNLOCKED;
-	int have_data;
-	u32 data = 0;
-	ssize_t ret = 0;
-
-	while (size) {
-		spin_lock(&rng_lock);
-
-		have_data = 0;
-		if (rng_data_present()) {
-			data = rng_data_read();
-			have_data = 4;
-		}
-
-		spin_unlock (&rng_lock);
-
-		while (have_data > 0) {
-			if (put_user((u8)data, buf++)) {
-				ret = ret ? : -EFAULT;
-				break;
-			}
-			size--;
-			ret++;
-			have_data--;
-			data>>=8;
-		}
-
-		if (filp->f_flags & O_NONBLOCK)
-			return ret ? : -EAGAIN;
-
-		if(need_resched())
-		{
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(1);
-		}
-		else
-			udelay(200);	/* FIXME: We could poll for 250uS ?? */
-
-		if (signal_pending (current))
-			return ret ? : -ERESTARTSYS;
-	}
-	return ret;
-}
-
-
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
-
-/*
- * rng_init_one - look for and attempt to init a single RNG
- */
-static int __init rng_init_one (struct pci_dev *dev)
-{
-	int rc;
-	u8 rnen;
-
-	DPRINTK ("ENTER\n");
-
-	rc = misc_register (&rng_miscdev);
-	if (rc) {
-		printk (KERN_ERR PFX "cannot register misc device\n");
-		DPRINTK ("EXIT, returning %d\n", rc);
-		goto err_out;
-	}
-
-	pci_read_config_dword(dev, 0x58, &pmbase);
-
-	pmbase&=0x0000FF00;
-
-	if(pmbase == 0)
-	{
-		printk (KERN_ERR PFX "power management base not set\n");
-		DPRINTK ("EXIT, returning %d\n", rc);
-		goto err_out_free_miscdev;
-	}
-
-	pci_read_config_byte(dev, 0x40, &rnen);
-	rnen|=(1<<7);	/* RNG on */
-	pci_write_config_byte(dev, 0x40, rnen);
-
-	pci_read_config_byte(dev, 0x41, &rnen);
-	rnen|=(1<<7);	/* PMIO enable */
-	pci_write_config_byte(dev, 0x41, rnen);
-
-	printk(KERN_INFO PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
-	DPRINTK ("EXIT, returning 0\n");
-	return 0;
-
-err_out_free_miscdev:
-	misc_deregister (&rng_miscdev);
-err_out:
-	return rc;
-}
-
-
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
-
-MODULE_AUTHOR("Alan Cox, Jeff Garzik, Philipp Rumpf, Matt Sottek");
-MODULE_DESCRIPTION("AMD 768 Random Number Generator (RNG) driver");
-MODULE_LICENSE("GPL");
-
-
-/*
- * rng_init - initialize RNG module
- */
-static int __init rng_init (void)
-{
-	int rc;
-	struct pci_dev *pdev;
-
-	DPRINTK ("ENTER\n");
-
-	init_MUTEX (&rng_open_sem);
-
-	pci_for_each_dev(pdev) {
-		if (pci_match_device (rng_pci_tbl, pdev) != NULL)
-			goto match;
-	}
-
-	DPRINTK ("EXIT, returning -ENODEV\n");
-	return -ENODEV;
-
-match:
-	rc = rng_init_one (pdev);
-	if (rc)
-		return rc;
-
-	printk (KERN_INFO RNG_DRIVER_NAME " loaded\n");
-
-	DPRINTK ("EXIT, returning 0\n");
-	return 0;
-}
-
-
-/*
- * rng_init - shutdown RNG module
- */
-static void __exit rng_cleanup (void)
-{
-	DPRINTK ("ENTER\n");
-	misc_deregister (&rng_miscdev);
-	DPRINTK ("EXIT\n");
-}
-
-
-module_init (rng_init);
-module_exit (rng_cleanup);
diff -Nru a/drivers/char/hw_random.c b/drivers/char/hw_random.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/hw_random.c	Tue Mar 11 21:37:19 2003
@@ -0,0 +1,295 @@
+/*
+ 	Hardware driver for the AMD 768 Random Number Generator (RNG)
+	(c) Copyright 2001 Red Hat Inc <alan@redhat.com>
+ 
+ 	derived from
+ 
+	Hardware driver for Intel i810 Random Number Generator (RNG)
+	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
+	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
+
+	Please read Documentation/i810_rng.txt for details on use.
+
+	----------------------------------------------------------
+	This software may be used and distributed according to the terms
+        of the GNU General Public License, incorporated herein by reference.
+
+ */
+
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/random.h>
+#include <linux/miscdevice.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+
+/*
+ * core module and version information
+ */
+#define RNG_VERSION "0.1.0"
+#define RNG_MODULE_NAME "amd768_rng"
+#define RNG_DRIVER_NAME   RNG_MODULE_NAME " hardware driver " RNG_VERSION
+#define PFX RNG_MODULE_NAME ": "
+
+
+/*
+ * debugging macros
+ */
+#undef RNG_DEBUG /* define to enable copious debugging info */
+
+#ifdef RNG_DEBUG
+/* note: prints function name for you */
+#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#undef RNG_NDEBUG        /* define to disable lightweight runtime checks */
+#ifdef RNG_NDEBUG
+#define assert(expr)
+#else
+#define assert(expr) \
+        if(!(expr)) {                                   \
+        printk( "Assertion failed! %s,%s,%s,line=%d\n", \
+        #expr,__FILE__,__FUNCTION__,__LINE__);          \
+        }
+#endif
+
+#define RNG_MISCDEV_MINOR		183 /* official */
+
+/*
+ * various RNG status variables.  they are globals
+ * as we only support a single RNG device
+ */
+
+static u32 pmbase;			/* PMxx I/O base */
+static struct semaphore rng_open_sem;	/* Semaphore for serializing rng_open/release */
+
+
+/*
+ * inlined helper functions for accessing RNG registers
+ */
+
+static inline int rng_data_present (void)
+{
+      	return inl(pmbase+0xF4) & 1;
+}
+
+
+static inline int rng_data_read (void)
+{
+	return inl(pmbase+0xF0);
+}
+
+static int rng_dev_open (struct inode *inode, struct file *filp)
+{
+	if ((filp->f_mode & FMODE_READ) == 0)
+		return -EINVAL;
+	if (filp->f_mode & FMODE_WRITE)
+		return -EINVAL;
+
+	/* wait for device to become free */
+	if (filp->f_flags & O_NONBLOCK) {
+		if (down_trylock (&rng_open_sem))
+			return -EAGAIN;
+	} else {
+		if (down_interruptible (&rng_open_sem))
+			return -ERESTARTSYS;
+	}
+	return 0;
+}
+
+
+static int rng_dev_release (struct inode *inode, struct file *filp)
+{
+	up(&rng_open_sem);
+	return 0;
+}
+
+
+static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
+			     loff_t * offp)
+{
+	static spinlock_t rng_lock = SPIN_LOCK_UNLOCKED;
+	int have_data;
+	u32 data = 0;
+	ssize_t ret = 0;
+
+	while (size) {
+		spin_lock(&rng_lock);
+
+		have_data = 0;
+		if (rng_data_present()) {
+			data = rng_data_read();
+			have_data = 4;
+		}
+
+		spin_unlock (&rng_lock);
+
+		while (have_data > 0) {
+			if (put_user((u8)data, buf++)) {
+				ret = ret ? : -EFAULT;
+				break;
+			}
+			size--;
+			ret++;
+			have_data--;
+			data>>=8;
+		}
+
+		if (filp->f_flags & O_NONBLOCK)
+			return ret ? : -EAGAIN;
+
+		if(need_resched())
+		{
+			current->state = TASK_INTERRUPTIBLE;
+			schedule_timeout(1);
+		}
+		else
+			udelay(200);	/* FIXME: We could poll for 250uS ?? */
+
+		if (signal_pending (current))
+			return ret ? : -ERESTARTSYS;
+	}
+	return ret;
+}
+
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
+
+/*
+ * rng_init_one - look for and attempt to init a single RNG
+ */
+static int __init rng_init_one (struct pci_dev *dev)
+{
+	int rc;
+	u8 rnen;
+
+	DPRINTK ("ENTER\n");
+
+	rc = misc_register (&rng_miscdev);
+	if (rc) {
+		printk (KERN_ERR PFX "cannot register misc device\n");
+		DPRINTK ("EXIT, returning %d\n", rc);
+		goto err_out;
+	}
+
+	pci_read_config_dword(dev, 0x58, &pmbase);
+
+	pmbase&=0x0000FF00;
+
+	if(pmbase == 0)
+	{
+		printk (KERN_ERR PFX "power management base not set\n");
+		DPRINTK ("EXIT, returning %d\n", rc);
+		goto err_out_free_miscdev;
+	}
+
+	pci_read_config_byte(dev, 0x40, &rnen);
+	rnen|=(1<<7);	/* RNG on */
+	pci_write_config_byte(dev, 0x40, rnen);
+
+	pci_read_config_byte(dev, 0x41, &rnen);
+	rnen|=(1<<7);	/* PMIO enable */
+	pci_write_config_byte(dev, 0x41, rnen);
+
+	printk(KERN_INFO PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+
+err_out_free_miscdev:
+	misc_deregister (&rng_miscdev);
+err_out:
+	return rc;
+}
+
+
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
+ */
+static struct pci_device_id rng_pci_tbl[] __initdata = {
+	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
+
+
+MODULE_AUTHOR("Alan Cox, Jeff Garzik, Philipp Rumpf, Matt Sottek");
+MODULE_DESCRIPTION("AMD 768 Random Number Generator (RNG) driver");
+MODULE_LICENSE("GPL");
+
+
+/*
+ * rng_init - initialize RNG module
+ */
+static int __init rng_init (void)
+{
+	int rc;
+	struct pci_dev *pdev;
+
+	DPRINTK ("ENTER\n");
+
+	init_MUTEX (&rng_open_sem);
+
+	pci_for_each_dev(pdev) {
+		if (pci_match_device (rng_pci_tbl, pdev) != NULL)
+			goto match;
+	}
+
+	DPRINTK ("EXIT, returning -ENODEV\n");
+	return -ENODEV;
+
+match:
+	rc = rng_init_one (pdev);
+	if (rc)
+		return rc;
+
+	printk (KERN_INFO RNG_DRIVER_NAME " loaded\n");
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+}
+
+
+/*
+ * rng_init - shutdown RNG module
+ */
+static void __exit rng_cleanup (void)
+{
+	DPRINTK ("ENTER\n");
+	misc_deregister (&rng_miscdev);
+	DPRINTK ("EXIT\n");
+}
+
+
+module_init (rng_init);
+module_exit (rng_cleanup);
diff -Nru a/drivers/char/i810_rng.c b/drivers/char/i810_rng.c
--- a/drivers/char/i810_rng.c	Tue Mar 11 21:37:19 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,404 +0,0 @@
-/*
-
-	Hardware driver for Intel i810 Random Number Generator (RNG)
-	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
-	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
-
-	Driver Web site:  http://sourceforge.net/projects/gkernel/
-
-	Please read Documentation/i810_rng.txt for details on use.
-
-	----------------------------------------------------------
-
-	This software may be used and distributed according to the terms
-        of the GNU General Public License, incorporated herein by reference.
-
- */
-
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/random.h>
-#include <linux/miscdevice.h>
-#include <linux/smp_lock.h>
-#include <linux/mm.h>
-#include <linux/delay.h>
-
-#include <asm/io.h>
-#include <asm/uaccess.h>
-
-
-/*
- * core module and version information
- */
-#define RNG_VERSION "0.9.8"
-#define RNG_MODULE_NAME "i810_rng"
-#define RNG_DRIVER_NAME   RNG_MODULE_NAME " hardware driver " RNG_VERSION
-#define PFX RNG_MODULE_NAME ": "
-
-
-/*
- * debugging macros
- */
-#undef RNG_DEBUG /* define to enable copious debugging info */
-
-#ifdef RNG_DEBUG
-/* note: prints function name for you */
-#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
-#else
-#define DPRINTK(fmt, args...)
-#endif
-
-#undef RNG_NDEBUG        /* define to disable lightweight runtime checks */
-#ifdef RNG_NDEBUG
-#define assert(expr)
-#else
-#define assert(expr) \
-        if(!(expr)) {                                   \
-        printk( "Assertion failed! %s,%s,%s,line=%d\n", \
-        #expr,__FILE__,__FUNCTION__,__LINE__);          \
-        }
-#endif
-
-
-/*
- * RNG registers (offsets from rng_mem)
- */
-#define RNG_HW_STATUS			0
-#define		RNG_PRESENT		0x40
-#define		RNG_ENABLED		0x01
-#define RNG_STATUS			1
-#define		RNG_DATA_PRESENT	0x01
-#define RNG_DATA			2
-
-/*
- * Magic address at which Intel PCI bridges locate the RNG
- */
-#define RNG_ADDR			0xFFBC015F
-#define RNG_ADDR_LEN			3
-
-#define RNG_MISCDEV_MINOR		183 /* official */
-
-/*
- * various RNG status variables.  they are globals
- * as we only support a single RNG device
- */
-static void *rng_mem;			/* token to our ioremap'd RNG register area */
-static struct semaphore rng_open_sem;	/* Semaphore for serializing rng_open/release */
-
-
-/*
- * inlined helper functions for accessing RNG registers
- */
-static inline u8 rng_hwstatus (void)
-{
-	assert (rng_mem != NULL);
-	return readb (rng_mem + RNG_HW_STATUS);
-}
-
-static inline u8 rng_hwstatus_set (u8 hw_status)
-{
-	assert (rng_mem != NULL);
-	writeb (hw_status, rng_mem + RNG_HW_STATUS);
-	return rng_hwstatus ();
-}
-
-
-static inline int rng_data_present (void)
-{
-	assert (rng_mem != NULL);
-
-	return (readb (rng_mem + RNG_STATUS) & RNG_DATA_PRESENT) ? 1 : 0;
-}
-
-
-static inline int rng_data_read (void)
-{
-	assert (rng_mem != NULL);
-
-	return readb (rng_mem + RNG_DATA);
-}
-
-/*
- * rng_enable - enable the RNG hardware
- */
-
-static int rng_enable (void)
-{
-	int rc = 0;
-	u8 hw_status, new_status;
-
-	DPRINTK ("ENTER\n");
-
-	hw_status = rng_hwstatus ();
-
-	if ((hw_status & RNG_ENABLED) == 0) {
-		new_status = rng_hwstatus_set (hw_status | RNG_ENABLED);
-
-		if (new_status & RNG_ENABLED)
-			printk (KERN_INFO PFX "RNG h/w enabled\n");
-		else {
-			printk (KERN_ERR PFX "Unable to enable the RNG\n");
-			rc = -EIO;
-		}
-	}
-
-	DPRINTK ("EXIT, returning %d\n", rc);
-	return rc;
-}
-
-/*
- * rng_disable - disable the RNG hardware
- */
-
-static void rng_disable(void)
-{
-	u8 hw_status, new_status;
-
-	DPRINTK ("ENTER\n");
-
-	hw_status = rng_hwstatus ();
-
-	if (hw_status & RNG_ENABLED) {
-		new_status = rng_hwstatus_set (hw_status & ~RNG_ENABLED);
-	
-		if ((new_status & RNG_ENABLED) == 0)
-			printk (KERN_INFO PFX "RNG h/w disabled\n");
-		else {
-			printk (KERN_ERR PFX "Unable to disable the RNG\n");
-		}
-	}
-
-	DPRINTK ("EXIT\n");
-}
-
-static int rng_dev_open (struct inode *inode, struct file *filp)
-{
-	int rc;
-
-	if ((filp->f_mode & FMODE_READ) == 0)
-		return -EINVAL;
-	if (filp->f_mode & FMODE_WRITE)
-		return -EINVAL;
-
-	/* wait for device to become free */
-	if (filp->f_flags & O_NONBLOCK) {
-		if (down_trylock (&rng_open_sem))
-			return -EAGAIN;
-	} else {
-		if (down_interruptible (&rng_open_sem))
-			return -ERESTARTSYS;
-	}
-
-	rc = rng_enable ();
-	if (rc) {
-		up (&rng_open_sem);
-		return rc;
-	}
-
-	return 0;
-}
-
-
-static int rng_dev_release (struct inode *inode, struct file *filp)
-{
-	rng_disable ();
-	up (&rng_open_sem);
-	return 0;
-}
-
-
-static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
-			     loff_t * offp)
-{
-	static spinlock_t rng_lock = SPIN_LOCK_UNLOCKED;
-	int have_data;
-	u8 data = 0;
-	ssize_t ret = 0;
-
-	while (size) {
-		spin_lock (&rng_lock);
-
-		have_data = 0;
-		if (rng_data_present ()) {
-			data = rng_data_read ();
-			have_data = 1;
-		}
-
-		spin_unlock (&rng_lock);
-
-		if (have_data) {
-			if (put_user (data, buf++)) {
-				ret = ret ? : -EFAULT;
-				break;
-			}
-			size--;
-			ret++;
-		}
-
-		if (filp->f_flags & O_NONBLOCK)
-			return ret ? : -EAGAIN;
-
-		if (need_resched())
-		{
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(1);
-		}
-		else
-			udelay(200);
-
-		if (signal_pending (current))
-			return ret ? : -ERESTARTSYS;
-	}
-
-	return ret;
-}
-
-
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
-
-/*
- * rng_init_one - look for and attempt to init a single RNG
- */
-static int __init rng_init_one (struct pci_dev *dev)
-{
-	int rc;
-	u8 hw_status;
-
-	DPRINTK ("ENTER\n");
-
-	rc = misc_register (&rng_miscdev);
-	if (rc) {
-		printk (KERN_ERR PFX "cannot register misc device\n");
-		DPRINTK ("EXIT, returning %d\n", rc);
-		goto err_out;
-	}
-
-	rng_mem = ioremap (RNG_ADDR, RNG_ADDR_LEN);
-	if (rng_mem == NULL) {
-		printk (KERN_ERR PFX "cannot ioremap RNG Memory\n");
-		DPRINTK ("EXIT, returning -EBUSY\n");
-		rc = -EBUSY;
-		goto err_out_free_miscdev;
-	}
-
-	/* Check for Intel 82802 */
-	hw_status = rng_hwstatus ();
-	if ((hw_status & RNG_PRESENT) == 0) {
-		printk (KERN_ERR PFX "RNG not detected\n");
-		DPRINTK ("EXIT, returning -ENODEV\n");
-		rc = -ENODEV;
-		goto err_out_free_map;
-	}
-
-	/* turn RNG h/w off, if it's on */
-	if (hw_status & RNG_ENABLED)
-		hw_status = rng_hwstatus_set (hw_status & ~RNG_ENABLED);
-	if (hw_status & RNG_ENABLED) {
-		printk (KERN_ERR PFX "cannot disable RNG, aborting\n");
-		goto err_out_free_map;
-	}
-
-	DPRINTK ("EXIT, returning 0\n");
-	return 0;
-
-err_out_free_map:
-	iounmap (rng_mem);
-err_out_free_miscdev:
-	misc_deregister (&rng_miscdev);
-err_out:
-	return rc;
-}
-
-
-/*
- * Data for PCI driver interface
- *
- * This data only exists for exporting the supported
- * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
- * register a pci_driver, because someone else might one day
- * want to register another driver on the same PCI id.
- */
-static struct pci_device_id rng_pci_tbl[] __initdata = {
-	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0, },
-};
-MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
-
-
-MODULE_AUTHOR("Jeff Garzik, Philipp Rumpf, Matt Sottek");
-MODULE_DESCRIPTION("Intel i8xx chipset Random Number Generator (RNG) driver");
-MODULE_LICENSE("GPL");
-
-
-/*
- * rng_init - initialize RNG module
- */
-static int __init rng_init (void)
-{
-	int rc;
-	struct pci_dev *pdev;
-
-	DPRINTK ("ENTER\n");
-
-	init_MUTEX (&rng_open_sem);
-
-	pci_for_each_dev(pdev) {
-		if (pci_match_device (rng_pci_tbl, pdev) != NULL)
-			goto match;
-	}
-
-	DPRINTK ("EXIT, returning -ENODEV\n");
-	return -ENODEV;
-
-match:
-	rc = rng_init_one (pdev);
-	if (rc)
-		return rc;
-
-	printk (KERN_INFO RNG_DRIVER_NAME " loaded\n");
-
-	DPRINTK ("EXIT, returning 0\n");
-	return 0;
-}
-
-
-/*
- * rng_init - shutdown RNG module
- */
-static void __exit rng_cleanup (void)
-{
-	DPRINTK ("ENTER\n");
-
-	misc_deregister (&rng_miscdev);
-
-	iounmap (rng_mem);
-
-	DPRINTK ("EXIT\n");
-}
-
-
-module_init (rng_init);
-module_exit (rng_cleanup);

--------------090609000501030902090400--

