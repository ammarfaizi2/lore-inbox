Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271183AbTHHC4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 22:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271174AbTHHC4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 22:56:31 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:24986
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271187AbTHHCzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 22:55:03 -0400
Date: Thu, 7 Aug 2003 22:55:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.4 2/2] add hw_random RNG driver
Message-ID: <20030808025502.GA31909@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#
#	drivers/char/Config.in	1.48    -> 1.49   
#	Documentation/Configure.help	1.176   -> 1.177  
#	drivers/char/Makefile	1.34    -> 1.35   
#	               (new)	        -> 1.1     drivers/char/hw_random.c
#	               (new)	        -> 1.2     Documentation/hw_random.txt
#
# --------------------------------------------
# 03/08/07	jgarzik@redhat.com	1.1067
# [hw_random] add combined Intel+AMD+VIA h/w RNG driver
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Thu Aug  7 22:51:42 2003
+++ b/Documentation/Configure.help	Thu Aug  7 22:51:43 2003
@@ -18797,6 +18797,21 @@
 
   If unsure, say N.
 
+Intel/AMD/VIA HW Random Number Generator support
+CONFIG_HW_RANDOM
+  This driver provides kernel-side support for the
+  Random Number Generator hardware found on Intel i8xx-based motherboards,
+  AMD 76x-based motherboards, and Via Nehemiah CPUs.
+
+  Provides a character driver, used to read() entropy data.
+
+  To compile this driver as a module ( = code which can be inserted in
+  and removed from the running kernel whenever you want), say M here
+  and read <file:Documentation/modules.txt>. The module will be called
+  hw_random.
+
+  If unsure, say N.
+
 Power Management support
 CONFIG_PM
   "Power Management" means that parts of your computer are shut
diff -Nru a/Documentation/hw_random.txt b/Documentation/hw_random.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/hw_random.txt	Thu Aug  7 22:51:43 2003
@@ -0,0 +1,138 @@
+	Hardware driver for Intel/AMD/VIA Random Number Generators (RNG)
+	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
+	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
+
+Introduction:
+
+	The hw_random device driver is software that makes use of a
+	special hardware feature on your CPU or motherboard,
+	a Random Number Generator (RNG).
+
+	In order to make effective use of this device driver, you
+	should download the support software as well.  Download the
+	latest version of the "rng-tools" package from the
+	hw_random driver's official Web site:
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
+	the hardware RNG device.  This data is NOT CHECKED by any
+	fitness tests, and could potentially be bogus (if the
+	hardware is faulty or has been tampered with).  Data is only
+	output if the hardware "has-data" flag is set, but nevertheless
+	a security-conscious person would run fitness tests on the
+	data before assuming it is truly random.
+
+	/dev/hwrandom is char device major 10, minor 183.
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
+	Version 1.0.0:
+	* Merge Intel, AMD, VIA RNG drivers into one.
+	  Further changelog in BitKeeper.
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
diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Thu Aug  7 22:51:42 2003
+++ b/drivers/char/Config.in	Thu Aug  7 22:51:42 2003
@@ -267,6 +267,10 @@
 if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
    dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CONFIG_PCI
 fi
+if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" -o \
+     "$CONFIG_X86_64" = "y" ]; then
+   dep_tristate 'Intel/AMD/VIA HW Random Number Generator support' CONFIG_HW_RANDOM $CONFIG_PCI
+fi
 dep_tristate 'AMD 76x native power management (Experimental)' CONFIG_AMD_PM768 $CONFIG_PCI
 tristate '/dev/nvram support' CONFIG_NVRAM
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Thu Aug  7 22:51:43 2003
+++ b/drivers/char/Makefile	Thu Aug  7 22:51:43 2003
@@ -247,6 +247,7 @@
 obj-$(CONFIG_DS1620) += ds1620.o
 obj-$(CONFIG_INTEL_RNG) += i810_rng.o
 obj-$(CONFIG_AMD_RNG) += amd768_rng.o
+obj-$(CONFIG_HW_RANDOM) += hw_random.o
 obj-$(CONFIG_AMD_PM768) += amd76x_pm.o
 obj-$(CONFIG_BRIQ_PANEL) += briq_panel.o
 
diff -Nru a/drivers/char/hw_random.c b/drivers/char/hw_random.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/hw_random.c	Thu Aug  7 22:51:43 2003
@@ -0,0 +1,631 @@
+/*
+ 	Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
+	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
+ 
+ 	derived from
+ 
+        Hardware driver for the AMD 768 Random Number Generator (RNG)
+        (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
+
+ 	derived from
+ 
+	Hardware driver for Intel i810 Random Number Generator (RNG)
+	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
+	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
+
+	Please read Documentation/hw_random.txt for details on use.
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
+#ifdef __i386__
+#include <asm/msr.h>
+#include <asm/cpufeature.h>
+#endif
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+
+/*
+ * core module and version information
+ */
+#define RNG_VERSION "1.0.0"
+#define RNG_MODULE_NAME "hw_random"
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
+#define RNG_NDEBUG        /* define to disable lightweight runtime checks */
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
+static int rng_dev_open (struct inode *inode, struct file *filp);
+static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
+			     loff_t * offp);
+
+static int __init intel_init (struct pci_dev *dev);
+static void intel_cleanup(void);
+static unsigned int intel_data_present (void);
+static u32 intel_data_read (void);
+
+static int __init amd_init (struct pci_dev *dev);
+static void amd_cleanup(void);
+static unsigned int amd_data_present (void);
+static u32 amd_data_read (void);
+
+static int __init via_init(struct pci_dev *dev);
+static void via_cleanup(void);
+static unsigned int via_data_present (void);
+static u32 via_data_read (void);
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
+static struct file_operations rng_chrdev_ops = {
+	.owner		= THIS_MODULE,
+	.open		= rng_dev_open,
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
+	rng_hw_via,
+};
+
+static struct rng_operations rng_vendor_ops[] = {
+	/* rng_hw_none */
+	{ },
+
+	/* rng_hw_intel */
+	{ intel_init, intel_cleanup, intel_data_present,
+	  intel_data_read, 1 },
+
+	/* rng_hw_amd */
+	{ amd_init, amd_cleanup, amd_data_present, amd_data_read, 4 },
+
+	/* rng_hw_via */
+	{ via_init, via_cleanup, via_data_present, via_data_read, 1 },
+};
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
+	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
+	{ 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
+
+	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+
+	{ 0, },	/* terminate list */
+};
+MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
+
+
+/***********************************************************************
+ *
+ * Intel RNG operations
+ *
+ */
+
+/*
+ * RNG registers (offsets from rng_mem)
+ */
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
+static void intel_cleanup(void)
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
+
+static unsigned int amd_data_present (void)
+{
+      	return inl(pmbase + 0xF4) & 1;
+}
+
+
+static u32 amd_data_read (void)
+{
+	return inl(pmbase + 0xF0);
+}
+
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
+static void amd_cleanup(void)
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
+ * VIA RNG operations
+ *
+ */
+
+enum {
+	VIA_STRFILT_CNT_SHIFT	= 16,
+	VIA_STRFILT_FAIL	= (1 << 15),
+	VIA_STRFILT_ENABLE	= (1 << 14),
+	VIA_RAWBITS_ENABLE	= (1 << 13),
+	VIA_RNG_ENABLE		= (1 << 6),
+	VIA_XSTORE_CNT_MASK	= 0x0F,
+
+	VIA_RNG_CHUNK_8		= 0x00,	/* 64 rand bits, 64 stored bits */
+	VIA_RNG_CHUNK_4		= 0x01,	/* 32 rand bits, 32 stored bits */
+	VIA_RNG_CHUNK_4_MASK	= 0xFFFFFFFF,
+	VIA_RNG_CHUNK_2		= 0x02,	/* 16 rand bits, 32 stored bits */
+	VIA_RNG_CHUNK_2_MASK	= 0xFFFF,
+	VIA_RNG_CHUNK_1		= 0x03,	/* 8 rand bits, 32 stored bits */
+	VIA_RNG_CHUNK_1_MASK	= 0xFF,
+};
+
+u32 via_rng_datum;
+
+/*
+ * Investigate using the 'rep' prefix to obtain 32 bits of random data
+ * in one insn.  The upside is potentially better performance.  The
+ * downside is that the instruction becomes no longer atomic.  Due to
+ * this, just like familiar issues with /dev/random itself, the worst
+ * case of a 'rep xstore' could potentially pause a cpu for an
+ * unreasonably long time.  In practice, this condition would likely
+ * only occur when the hardware is failing.  (or so we hope :))
+ *
+ * Another possible performance boost may come from simply buffering
+ * until we have 4 bytes, thus returning a u32 at a time,
+ * instead of the current u8-at-a-time.
+ */
+
+static inline u32 xstore(u32 *addr, u32 edx_in)
+{
+	u32 eax_out;
+
+	asm(".byte 0x0F,0xA7,0xC0 /* xstore %%edi (addr=%0) */"
+		:"=m"(*addr), "=a"(eax_out)
+		:"D"(addr), "d"(edx_in));
+
+	return eax_out;
+}
+
+static unsigned int via_data_present(void)
+{
+	u32 bytes_out;
+
+	/* We choose the recommended 1-byte-per-instruction RNG rate,
+	 * for greater randomness at the expense of speed.  Larger
+	 * values 2, 4, or 8 bytes-per-instruction yield greater
+	 * speed at lesser randomness.
+	 *
+	 * If you change this to another VIA_CHUNK_n, you must also
+	 * change the ->n_bytes values in rng_vendor_ops[] tables.
+	 * VIA_CHUNK_8 requires further code changes.
+	 *
+	 * A copy of MSR_VIA_RNG is placed in eax_out when xstore
+	 * completes.
+	 */
+	via_rng_datum = 0; /* paranoia, not really necessary */
+	bytes_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_1) & VIA_XSTORE_CNT_MASK;
+	if (bytes_out == 0)
+		return 0;
+
+	return 1;
+}
+
+static u32 via_data_read(void)
+{
+	return via_rng_datum;
+}
+
+static int __init via_init(struct pci_dev *dev)
+{
+	u32 lo, hi, old_lo;
+
+	/* Control the RNG via MSR.  Tread lightly and pay very close
+	 * close attention to values written, as the reserved fields
+	 * are documented to be "undefined and unpredictable"; but it
+	 * does not say to write them as zero, so I make a guess that
+	 * we restore the values we find in the register.
+	 */
+	rdmsr(MSR_VIA_RNG, lo, hi);
+
+	old_lo = lo;
+	lo &= ~(0x7f << VIA_STRFILT_CNT_SHIFT);
+	lo &= ~VIA_XSTORE_CNT_MASK;
+	lo &= ~(VIA_STRFILT_ENABLE | VIA_STRFILT_FAIL | VIA_RAWBITS_ENABLE);
+	lo |= VIA_RNG_ENABLE;
+
+	if (lo != old_lo)
+		wrmsr(MSR_VIA_RNG, lo, hi);
+
+	/* perhaps-unnecessary sanity check; remove after testing if
+	   unneeded */
+	rdmsr(MSR_VIA_RNG, lo, hi);
+	if ((lo & VIA_RNG_ENABLE) == 0) {
+		printk(KERN_ERR PFX "cannot enable VIA C3 RNG, aborting\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void via_cleanup(void)
+{
+	u32 lo, hi;
+
+	rdmsr(MSR_VIA_RNG, lo, hi);
+	lo &= ~VIA_RNG_ENABLE;
+	wrmsr(MSR_VIA_RNG, lo, hi);
+}
+
+
+/***********************************************************************
+ *
+ * /dev/hwrandom character device handling (major 10, minor 183)
+ *
+ */
+
+static int rng_dev_open (struct inode *inode, struct file *filp)
+{
+	/* enforce read-only access to this chrdev */
+	if ((filp->f_mode & FMODE_READ) == 0)
+		return -EINVAL;
+	if (filp->f_mode & FMODE_WRITE)
+		return -EINVAL;
+
+	return 0;
+}
+
+
+static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
+			     loff_t * offp)
+{
+	static spinlock_t rng_lock = SPIN_LOCK_UNLOCKED;
+	unsigned int have_data;
+	u32 data = 0;
+	ssize_t ret = 0;
+
+	while (size) {
+		spin_lock(&rng_lock);
+
+		have_data = 0;
+		if (rng_ops->data_present()) {
+			data = rng_ops->data_read();
+			have_data = rng_ops->n_bytes;
+		}
+
+		spin_unlock (&rng_lock);
+
+		while (have_data && size) {
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
+
+/*
+ * rng_init_one - look for and attempt to init a single RNG
+ */
+static int __init rng_init_one (struct pci_dev *dev)
+{
+	int rc;
+
+	DPRINTK ("ENTER\n");
+
+	assert(rng_ops != NULL);
+
+	rc = rng_ops->init(dev);
+	if (rc)
+		goto err_out;
+
+	rc = misc_register (&rng_miscdev);
+	if (rc) {
+		printk (KERN_ERR PFX "misc device register failed\n");
+		goto err_out_cleanup_hw;
+	}
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+
+err_out_cleanup_hw:
+	rng_ops->cleanup();
+err_out:
+	DPRINTK ("EXIT, returning %d\n", rc);
+	return rc;
+}
+
+
+
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver");
+MODULE_LICENSE("GPL");
+
+
+/*
+ * rng_init - initialize RNG module
+ */
+static int __init rng_init (void)
+{
+	int rc;
+	struct pci_dev *pdev = NULL;
+	const struct pci_device_id *ent;
+
+	DPRINTK ("ENTER\n");
+
+	/* Probe for Intel, AMD RNGs */
+	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+		ent = pci_match_device (rng_pci_tbl, pdev);
+		if (ent) {
+			rng_ops = &rng_vendor_ops[ent->driver_data];
+			goto match;
+		}
+	}
+
+#ifdef __i386__
+	/* Probe for VIA RNG */
+	if (cpu_has_xstore) {
+		rng_ops = &rng_vendor_ops[rng_hw_via];
+		pdev = NULL;
+		goto match;
+	}
+#endif
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
+
+	misc_deregister (&rng_miscdev);
+
+	if (rng_ops->cleanup)
+		rng_ops->cleanup();
+
+	DPRINTK ("EXIT\n");
+}
+
+
+module_init (rng_init);
+module_exit (rng_cleanup);
