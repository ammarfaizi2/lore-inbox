Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbTCMX5H>; Thu, 13 Mar 2003 18:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbTCMXzc>; Thu, 13 Mar 2003 18:55:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20155 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263118AbTCMXy0>;
	Thu, 13 Mar 2003 18:54:26 -0500
Message-ID: <3E711CC7.1080809@pobox.com>
Date: Thu, 13 Mar 2003 19:05:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 5/5] rng driver update
References: <3E711C0A.40705@pobox.com>
In-Reply-To: <3E711C0A.40705@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------010302080807030402050909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010302080807030402050909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010302080807030402050909
Content-Type: text/plain;
 name="patch.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.5"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1108  -> 1.1109 
#	drivers/char/Kconfig	1.10    -> 1.11   
#	drivers/char/hw_random.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/13	jgarzik@redhat.com	1.1109
# [hw_random] fixes and cleanups
# 
# * s/Via/VIA/
# * allow multiple simultaneous open(2)s of the chrdev.  This allows
# us to eliminate some code, without modifying the core code (rng_dev_read)
# at all.
# * s/__exit// in ->cleanup ops, to eliminate link error
# --------------------------------------------
#
diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Thu Mar 13 18:53:15 2003
+++ b/drivers/char/Kconfig	Thu Mar 13 18:53:15 2003
@@ -710,12 +710,12 @@
 	  If you're not sure, say N.
 
 config HW_RANDOM
-	tristate "Intel/AMD/Via H/W Random Number Generator support"
+	tristate "Intel/AMD/VIA HW Random Number Generator support"
 	depends on (X86 || IA64) && PCI
 	---help---
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on Intel i8xx-based motherboards,
-	  and AMD 76x-based motherboards.
+	  AMD 76x-based motherboards, and Via Nehemiah CPUs.
 
 	  Provides a character driver, used to read() entropy data.
 
diff -Nru a/drivers/char/hw_random.c b/drivers/char/hw_random.c
--- a/drivers/char/hw_random.c	Thu Mar 13 18:53:15 2003
+++ b/drivers/char/hw_random.c	Thu Mar 13 18:53:15 2003
@@ -1,5 +1,5 @@
 /*
- 	Hardware driver for the Intel/AMD/Via Random Number Generators (RNG)
+ 	Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
 	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
  
  	derived from
@@ -79,22 +79,21 @@
 #define RNG_MISCDEV_MINOR		183 /* official */
 
 static int rng_dev_open (struct inode *inode, struct file *filp);
-static int rng_dev_release (struct inode *inode, struct file *filp);
 static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
 			     loff_t * offp);
 
 static int __init intel_init (struct pci_dev *dev);
-static void __exit intel_cleanup(void);
+static void intel_cleanup(void);
 static unsigned int intel_data_present (void);
 static u32 intel_data_read (void);
 
 static int __init amd_init (struct pci_dev *dev);
-static void __exit amd_cleanup(void);
+static void amd_cleanup(void);
 static unsigned int amd_data_present (void);
 static u32 amd_data_read (void);
 
 static int __init via_init(struct pci_dev *dev);
-static void __exit via_cleanup(void);
+static void via_cleanup(void);
 static unsigned int via_data_present (void);
 static u32 via_data_read (void);
 
@@ -107,12 +106,9 @@
 };
 static struct rng_operations *rng_ops;
 
-static struct semaphore rng_open_sem;	/* Semaphore for serializing rng_open/release */
-
 static struct file_operations rng_chrdev_ops = {
 	.owner		= THIS_MODULE,
 	.open		= rng_dev_open,
-	.release	= rng_dev_release,
 	.read		= rng_dev_read,
 };
 
@@ -262,7 +258,7 @@
 	return rc;
 }
 
-static void __exit intel_cleanup(void)
+static void intel_cleanup(void)
 {
 	u8 hw_status;
 
@@ -333,7 +329,7 @@
 	return rc;
 }
 
-static void __exit amd_cleanup(void)
+static void amd_cleanup(void)
 {
 	u8 rnen;
 
@@ -346,7 +342,7 @@
 
 /***********************************************************************
  *
- * Via RNG operations
+ * VIA RNG operations
  *
  */
 
@@ -448,14 +444,14 @@
 	   unneeded */
 	rdmsr(MSR_VIA_RNG, lo, hi);
 	if ((lo & VIA_RNG_ENABLE) == 0) {
-		printk(KERN_ERR PFX "cannot enable Via C3 RNG, aborting\n");
+		printk(KERN_ERR PFX "cannot enable VIA C3 RNG, aborting\n");
 		return -ENODEV;
 	}
 
 	return 0;
 }
 
-static void __exit via_cleanup(void)
+static void via_cleanup(void)
 {
 	u32 lo, hi;
 
@@ -473,26 +469,12 @@
 
 static int rng_dev_open (struct inode *inode, struct file *filp)
 {
+	/* enforce read-only access to this chrdev */
 	if ((filp->f_mode & FMODE_READ) == 0)
 		return -EINVAL;
 	if (filp->f_mode & FMODE_WRITE)
 		return -EINVAL;
 
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
 	return 0;
 }
 
@@ -595,8 +577,6 @@
 
 	DPRINTK ("ENTER\n");
 
-	init_MUTEX (&rng_open_sem);
-
 	/* Probe for Intel, AMD RNGs */
 	pci_for_each_dev(pdev) {
 		ent = pci_match_device (rng_pci_tbl, pdev);
@@ -607,7 +587,7 @@
 	}
 
 #ifdef __i386__
-	/* Probe for Via RNG */
+	/* Probe for VIA RNG */
 	if (cpu_has_xstore) {
 		rng_ops = &rng_vendor_ops[rng_hw_via];
 		pdev = NULL;

--------------010302080807030402050909--

