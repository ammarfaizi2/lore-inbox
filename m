Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUKPD2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUKPD2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 22:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUKPD2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 22:28:18 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:2433 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261763AbUKPD2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 22:28:10 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, james4765@verizon.net
Message-Id: <20041116032809.17232.34960.53013@localhost.localdomain>
Subject: [PATCH] hw_random: Clean up printk()'s in drivers/char/hw_random.c
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.220.243] at Mon, 15 Nov 2004 21:28:09 -0600
Date: Mon, 15 Nov 2004 21:28:10 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up printk()'s in hw_random driver.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/char/hw_random.c linux-2.6.10-rc2/drivers/char/hw_random.c
--- linux-2.6.10-rc2-original/drivers/char/hw_random.c	2004-11-15 21:38:16.292353701 -0500
+++ linux-2.6.10-rc2/drivers/char/hw_random.c	2004-11-15 22:18:21.879591411 -0500
@@ -21,6 +21,7 @@
 
  */
 
+#undef DEBUG /* define to enable copious debugging information */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -56,24 +57,20 @@
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
+/* note: prints function name for you 
+ * collapses to a no-op if DEBUG is #undef */
+#define DPRINTK(fmt, args...) pr_debug( "%s: " fmt, __FUNCTION__ , ## args)
 
-#define RNG_NDEBUG        /* define to disable lightweight runtime checks */
+#undef RNG_NDEBUG        /* define to enable lightweight runtime checks */
 #ifdef RNG_NDEBUG
-#define assert(expr)
+#define assert(expr)						\
+	if(!(expr)) {						\
+	pr_debug( PFX "Assertion failed! %s,%s,%s,line=%d\n",	\
+	#expr,__FILE__,__FUNCTION__,__LINE__);			\
+	}
 #else
-#define assert(expr) \
-        if(!(expr)) {                                   \
-        printk( "Assertion failed! %s,%s,%s,line=%d\n", \
-        #expr,__FILE__,__FUNCTION__,__LINE__);          \
-        }
+#define assert(expr)
 #endif
 
 #define RNG_MISCDEV_MINOR		183 /* official */
@@ -322,7 +319,7 @@
 	rnen |= (1 << 7);	/* PMIO enable */
 	pci_write_config_byte(dev, 0x41, rnen);
 
-	printk(KERN_INFO PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
+	pr_info(PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
 
 	amd_dev = dev;
 
@@ -606,7 +603,7 @@
 	if (rc)
 		return rc;
 
-	printk (KERN_INFO RNG_DRIVER_NAME " loaded\n");
+	pr_info(RNG_DRIVER_NAME " loaded\n");
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
