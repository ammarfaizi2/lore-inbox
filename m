Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTEZEPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTEZEOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:14:30 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:53009 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264254AbTEZEOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:14:19 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10539232501791@movementarian.org>
Subject: [PATCH 3/5] OProfile update
In-Reply-To: <10539232492885@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Mon, 26 May 2003 05:27:30 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19K9a6-000Npi-HA*5jk2SYvsMPA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A patch mostly by Will Cohen, adding a parameter to OProfile to
over-ride use of the perfctr hardware. Useful for testing and
a host of other things.

diff -Naur -X dontdiff linux-cvs/Documentation/kernel-parameters.txt linux-me/Documentation/kernel-parameters.txt
--- linux-cvs/Documentation/kernel-parameters.txt	2003-03-30 21:12:29.000000000 +0100
+++ linux-me/Documentation/kernel-parameters.txt	2003-05-26 04:53:57.000000000 +0100
@@ -652,6 +652,9 @@
 	opl3sa2=	[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>,<mss_io>,<mpu_io>,<ymode>,<loopback>[,<isapnp>,<multiple]
  
+	oprofile.timer=	[HW]
+			Use timer interrupt instead of performance counters
+
 	optcd=		[HW,CD]
 			Format: <io>
 
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprof.c linux-me/drivers/oprofile/oprof.c
--- linux-cvs/drivers/oprofile/oprof.c	2003-05-10 17:30:28.000000000 +0100
+++ linux-me/drivers/oprofile/oprof.c	2003-05-26 04:52:51.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/oprofile.h>
+#include <linux/moduleparam.h>
 #include <asm/semaphore.h>
 
 #include "oprof.h"
@@ -24,6 +25,12 @@
 static unsigned long is_setup;
 static DECLARE_MUTEX(start_sem);
 
+/* timer
+   0 - use performance monitoring hardware if available
+   1 - use the timer int mechanism regardless
+ */
+static int timer = 0;
+
 int oprofile_setup(void)
 {
 	int err;
@@ -124,13 +131,16 @@
 
 static int __init oprofile_init(void)
 {
-	int err;
+	int err = -ENODEV;
+
+	if (!timer) {
+		/* Architecture must fill in the interrupt ops and the
+		 * logical CPU type, or we can fall back to the timer
+		 * interrupt profiler.
+		 */
+		err = oprofile_arch_init(&oprofile_ops);
+	}
 
-	/* Architecture must fill in the interrupt ops and the
-	 * logical CPU type, or we can fall back to the timer
-	 * interrupt profiler.
-	 */
-	err = oprofile_arch_init(&oprofile_ops);
 	if (err == -ENODEV) {
 		timer_init(&oprofile_ops);
 		err = 0;
@@ -163,6 +173,9 @@
  
 module_init(oprofile_init);
 module_exit(oprofile_exit);
+
+module_param_named(timer, timer, int, 0644);
+MODULE_PARM_DESC(timer, "force use of timer interrupt");
  
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("John Levon <levon@movementarian.org>");

