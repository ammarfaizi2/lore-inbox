Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbUL0URx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUL0URx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbUL0URw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:17:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55503 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261973AbUL0UPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:15:20 -0500
Message-ID: <41D06D52.6090902@pobox.com>
Date: Mon, 27 Dec 2004 15:15:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x misc updates
Content-Type: multipart/mixed;
 boundary="------------030903000408090402070408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030903000408090402070408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------030903000408090402070408
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/misc-2.6

This will update the following files:

 drivers/block/floppy.c   |    1 -
 drivers/char/hw_random.c |   35 ++++++++++++++++-------------------
 sound/oss/i810_audio.c   |   12 ++++++------
 sound/oss/soundcard.c    |    4 ++--
 sound/oss/uart401.c      |    8 ++++----
 5 files changed, 28 insertions(+), 32 deletions(-)

through these ChangeSets:

Adrian Bunk:
  o drivers/char/hw_random.c: make a variable static

James Nelson:
  o hw_random: Minor cleanup to hw_random.c

Jeff Garzik:
  o drivers/block/floppy:  kill #include linux/version.h
  o [sound/oss] use module_param() in soundcard.c and uart401.c
  o [sound/oss i810_audio] use module_param()


--------------030903000408090402070408
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.txt"

diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	2004-12-27 15:14:25 -05:00
+++ b/drivers/block/floppy.c	2004-12-27 15:14:25 -05:00
@@ -155,7 +155,6 @@
 #include <linux/kernel.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
-#include <linux/version.h>
 #define FDPATCHES
 #include <linux/fdreg.h>
 
diff -Nru a/drivers/char/hw_random.c b/drivers/char/hw_random.c
--- a/drivers/char/hw_random.c	2004-12-27 15:14:25 -05:00
+++ b/drivers/char/hw_random.c	2004-12-27 15:14:25 -05:00
@@ -56,31 +56,27 @@
 /*
  * debugging macros
  */
-#undef RNG_DEBUG /* define to enable copious debugging info */
 
-#ifdef RNG_DEBUG
-/* note: prints function name for you */
-#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
-#else
-#define DPRINTK(fmt, args...)
-#endif
+/* pr_debug() collapses to a no-op if DEBUG is not defined */
+#define DPRINTK(fmt, args...) pr_debug(PFX "%s: " fmt, __FUNCTION__ , ## args)
+
 
-#define RNG_NDEBUG        /* define to disable lightweight runtime checks */
+#undef RNG_NDEBUG        /* define to enable lightweight runtime checks */
 #ifdef RNG_NDEBUG
-#define assert(expr)
+#define assert(expr)							\
+		if(!(expr)) {						\
+		printk(KERN_DEBUG PFX "Assertion failed! %s,%s,%s,"	\
+		"line=%d\n", #expr, __FILE__, __FUNCTION__, __LINE__);	\
+		}
 #else
-#define assert(expr) \
-        if(!(expr)) {                                   \
-        printk( "Assertion failed! %s,%s,%s,line=%d\n", \
-        #expr,__FILE__,__FUNCTION__,__LINE__);          \
-        }
+#define assert(expr)
 #endif
 
 #define RNG_MISCDEV_MINOR		183 /* official */
 
 static int rng_dev_open (struct inode *inode, struct file *filp);
 static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
-			     loff_t * offp);
+				loff_t * offp);
 
 static int __init intel_init (struct pci_dev *dev);
 static void intel_cleanup(void);
@@ -322,7 +318,8 @@
 	rnen |= (1 << 7);	/* PMIO enable */
 	pci_write_config_byte(dev, 0x41, rnen);
 
-	printk(KERN_INFO PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
+	pr_info( PFX "AMD768 system management I/O registers at 0x%X.\n",
+			pmbase);
 
 	amd_dev = dev;
 
@@ -369,7 +366,7 @@
 	VIA_RNG_CHUNK_1_MASK	= 0xFF,
 };
 
-u32 via_rng_datum;
+static u32 via_rng_datum;
 
 /*
  * Investigate using the 'rep' prefix to obtain 32 bits of random data
@@ -483,7 +480,7 @@
 
 
 static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
-			     loff_t * offp)
+				loff_t * offp)
 {
 	static spinlock_t rng_lock = SPIN_LOCK_UNLOCKED;
 	unsigned int have_data;
@@ -606,7 +603,7 @@
 	if (rc)
 		return rc;
 
-	printk (KERN_INFO RNG_DRIVER_NAME " loaded\n");
+	pr_info( RNG_DRIVER_NAME " loaded\n");
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	2004-12-27 15:14:25 -05:00
+++ b/sound/oss/i810_audio.c	2004-12-27 15:14:25 -05:00
@@ -3460,15 +3460,15 @@
 }	
 #endif /* CONFIG_PM */
 
-MODULE_AUTHOR("");
+MODULE_AUTHOR("The Linux kernel team");
 MODULE_DESCRIPTION("Intel 810 audio support");
 MODULE_LICENSE("GPL");
-MODULE_PARM(ftsodell, "i");
-MODULE_PARM(clocking, "i");
-MODULE_PARM(strict_clocking, "i");
-MODULE_PARM(spdif_locked, "i");
+module_param(ftsodell, int, 0444);
+module_param(clocking, uint, 0444);
+module_param(strict_clocking, int, 0444);
+module_param(spdif_locked, int, 0444);
 
-#define I810_MODULE_NAME "intel810_audio"
+#define I810_MODULE_NAME "i810_audio"
 
 static struct pci_driver i810_pci_driver = {
 	.name		= I810_MODULE_NAME,
diff -Nru a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c	2004-12-27 15:14:25 -05:00
+++ b/sound/oss/soundcard.c	2004-12-27 15:14:25 -05:00
@@ -535,8 +535,8 @@
 static int dmabuf;
 static int dmabug;
 
-MODULE_PARM(dmabuf, "i");
-MODULE_PARM(dmabug, "i");
+module_param(dmabuf, int, 0444);
+module_param(dmabug, int, 0444);
 
 static int __init oss_init(void)
 {
diff -Nru a/sound/oss/uart401.c b/sound/oss/uart401.c
--- a/sound/oss/uart401.c	2004-12-27 15:14:25 -05:00
+++ b/sound/oss/uart401.c	2004-12-27 15:14:25 -05:00
@@ -430,11 +430,11 @@
 
 static struct address_info cfg_mpu;
 
-static int __initdata io = -1;
-static int __initdata irq = -1;
+static int io = -1;
+static int irq = -1;
 
-MODULE_PARM(io, "i");
-MODULE_PARM(irq, "i");
+module_param(io, int, 0444);
+module_param(irq, int, 0444);
 
 
 static int __init init_uart401(void)

--------------030903000408090402070408--
