Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbUKEVTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUKEVTa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 16:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUKEVT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 16:19:29 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:35556 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261219AbUKEVTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 16:19:14 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, james4765@verizon.net
Message-Id: <20041105211912.17210.55119.84600@localhost.localdomain>
Subject: [PATCH] hw_random: Update printk()'s in hw_random.c
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [68.238.31.6] at Fri, 5 Nov 2004 15:19:13 -0600
Date: Fri, 5 Nov 2004 15:19:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update drivers/char/hw_random.c to pr_debug()/pr_info()

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/drivers/char/hw_random.c linux-2.6.9/drivers/char/hw_random.c
--- linux-2.6.9-original/drivers/char/hw_random.c	2004-10-18 17:53:50.000000000 -0400
+++ linux-2.6.9/drivers/char/hw_random.c	2004-11-05 15:26:10.869606837 -0500
@@ -56,31 +56,28 @@
 /*
  * debugging macros
  */
-#undef RNG_DEBUG /* define to enable copious debugging info */
+#undef DEBUG /* define to enable copious debugging info */
+
+/* pr_debug() collapses to a no-op if DEBUG is not defined */
+#define DPRINTK(fmt, args...) pr_debug(PFX "%s: " fmt, __FUNCTION__ , ## args)
 
-#ifdef RNG_DEBUG
-/* note: prints function name for you */
-#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
-#else
-#define DPRINTK(fmt, args...)
-#endif
 
-#define RNG_NDEBUG        /* define to disable lightweight runtime checks */
+#undef RNG_NDEBUG        /* define to enable lightweight runtime checks */
 #ifdef RNG_NDEBUG
-#define assert(expr)
+#define assert(expr)							\
+		if(!(expr)) {						\
+		pr_debug(PFX "Assertion failed! %s,%s,%s,line=%d\n",	\
+		#expr,__FILE__,__FUNCTION__,__LINE__);			\
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
+		loff_t * offp);
 
 static int __init intel_init (struct pci_dev *dev);
 static void intel_cleanup(void);
@@ -322,7 +319,7 @@
 	rnen |= (1 << 7);	/* PMIO enable */
 	pci_write_config_byte(dev, 0x41, rnen);
 
-	printk(KERN_INFO PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
+	pr_info(PFX "AMD768 system management I/O registers at 0x%X.\n",pmbase);
 
 	amd_dev = dev;
 
@@ -413,7 +410,8 @@
 	 * completes.
 	 */
 	via_rng_datum = 0; /* paranoia, not really necessary */
-	bytes_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_1) & VIA_XSTORE_CNT_MASK;
+	bytes_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_1) &
+			VIA_XSTORE_CNT_MASK;
 	if (bytes_out == 0)
 		return 0;
 
@@ -606,7 +604,7 @@
 	if (rc)
 		return rc;
 
-	printk (KERN_INFO RNG_DRIVER_NAME " loaded\n");
+	pr_info (RNG_DRIVER_NAME " loaded\n");
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
