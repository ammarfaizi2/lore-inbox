Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265125AbUKATet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUKATet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S277179AbUKATeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:34:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53958 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S291940AbUKATaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:39 -0500
Date: Mon, 1 Nov 2004 19:30:21 GMT
Message-Id: <200411011930.iA1JULKN023227@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 10/14] FRV: Make calibrate_delay() optional
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes calibrate_delay() optional. In this architecture, it's
a waste of time since we can predict exactly what it's going to come up with
just by looking at the CPU's hardware clock registers. Thus far, we haven't
seem a board with any clock not dependent on the CPU's clock.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-calibrate-2610rc1bk10.diff
 init/main.c     |   70 ---------------------------------------------
 lib/Makefile    |    3 +
 lib/calibrate.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 71 deletions(-)

diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/init/main.c linux-2.6.10-rc1-bk10-frv/init/main.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/init/main.c	2004-11-01 11:45:34.000000000 +0000
+++ linux-2.6.10-rc1-bk10-frv/init/main.c	2004-11-01 11:47:05.147633905 +0000
@@ -182,15 +178,6 @@
 	return 0;
 }
 
-static unsigned long preset_lpj;
-static int __init lpj_setup(char *str)
-{
-	preset_lpj = simple_strtoul(str,NULL,0);
-	return 1;
-}
-
-__setup("lpj=", lpj_setup);
-
 /*
  * This should be approx 2 Bo*oMips to start (note initial shift), and will
  * still work even if initially too large, it will just take slightly longer
@@ -199,67 +190,6 @@
 
 EXPORT_SYMBOL(loops_per_jiffy);
 
-/*
- * This is the number of bits of precision for the loops_per_jiffy.  Each
- * bit takes on average 1.5/HZ seconds.  This (like the original) is a little
- * better than 1%
- */
-#define LPS_PREC 8
-
-void __devinit calibrate_delay(void)
-{
-	unsigned long ticks, loopbit;
-	int lps_precision = LPS_PREC;
-
-	if (preset_lpj) {
-		loops_per_jiffy = preset_lpj;
-		printk("Calibrating delay loop (skipped)... "
-			"%lu.%02lu BogoMIPS preset\n",
-			loops_per_jiffy/(500000/HZ),
-			(loops_per_jiffy/(5000/HZ)) % 100);
-	} else {
-		loops_per_jiffy = (1<<12);
-
-		printk(KERN_DEBUG "Calibrating delay loop... ");
-		while ((loops_per_jiffy <<= 1) != 0) {
-			/* wait for "start of" clock tick */
-			ticks = jiffies;
-			while (ticks == jiffies)
-				/* nothing */;
-			/* Go .. */
-			ticks = jiffies;
-			__delay(loops_per_jiffy);
-			ticks = jiffies - ticks;
-			if (ticks)
-				break;
-		}
-
-		/*
-		 * Do a binary approximation to get loops_per_jiffy set to
-		 * equal one clock (up to lps_precision bits)
-		 */
-		loops_per_jiffy >>= 1;
-		loopbit = loops_per_jiffy;
-		while (lps_precision-- && (loopbit >>= 1)) {
-			loops_per_jiffy |= loopbit;
-			ticks = jiffies;
-			while (ticks == jiffies)
-				/* nothing */;
-			ticks = jiffies;
-			__delay(loops_per_jiffy);
-			if (jiffies != ticks)	/* longer than 1 tick */
-				loops_per_jiffy &= ~loopbit;
-		}
-
-		/* Round the value and print it */
-		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
-			loops_per_jiffy/(500000/HZ),
-			(loops_per_jiffy/(5000/HZ)) % 100,
-			loops_per_jiffy);
-	}
-
-}
-
 static int __init debug_kernel(char *str)
 {
 	if (*str)
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/lib/calibrate.c linux-2.6.10-rc1-bk10-frv/lib/calibrate.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/lib/calibrate.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/lib/calibrate.c	2004-11-01 11:47:05.186630659 +0000
@@ -0,0 +1,86 @@
+/* calibrate.c: default delay calibration
+ *
+ * Excised from init/main.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ *  GK 2/5/95  -  Changed to support mounting root fs via NFS
+ *  Added initrd & change_root: Werner Almesberger & Hans Lermen, Feb '96
+ *  Moan early if gcc is old, avoiding bogus kernels - Paul Gortmaker, May '96
+ *  Simplified starting of init:  Michael A. Griffith <grif@acm.org> 
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+static unsigned long preset_lpj;
+static int __init lpj_setup(char *str)
+{
+	preset_lpj = simple_strtoul(str,NULL,0);
+	return 1;
+}
+
+__setup("lpj=", lpj_setup);
+
+/*
+ * This is the number of bits of precision for the loops_per_jiffy.  Each
+ * bit takes on average 1.5/HZ seconds.  This (like the original) is a little
+ * better than 1%
+ */
+#define LPS_PREC 8
+
+void __devinit calibrate_delay(void)
+{
+	unsigned long ticks, loopbit;
+	int lps_precision = LPS_PREC;
+
+	if (preset_lpj) {
+		loops_per_jiffy = preset_lpj;
+		printk("Calibrating delay loop (skipped)... "
+			"%lu.%02lu BogoMIPS preset\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100);
+	} else {
+		loops_per_jiffy = (1<<12);
+
+		printk(KERN_DEBUG "Calibrating delay loop... ");
+		while ((loops_per_jiffy <<= 1) != 0) {
+			/* wait for "start of" clock tick */
+			ticks = jiffies;
+			while (ticks == jiffies)
+				/* nothing */;
+			/* Go .. */
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			ticks = jiffies - ticks;
+			if (ticks)
+				break;
+		}
+
+		/*
+		 * Do a binary approximation to get loops_per_jiffy set to
+		 * equal one clock (up to lps_precision bits)
+		 */
+		loops_per_jiffy >>= 1;
+		loopbit = loops_per_jiffy;
+		while (lps_precision-- && (loopbit >>= 1)) {
+			loops_per_jiffy |= loopbit;
+			ticks = jiffies;
+			while (ticks == jiffies)
+				/* nothing */;
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			if (jiffies != ticks)	/* longer than 1 tick */
+				loops_per_jiffy &= ~loopbit;
+		}
+
+		/* Round the value and print it */
+		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100,
+			loops_per_jiffy);
+	}
+
+}
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/lib/Makefile linux-2.6.10-rc1-bk10-frv/lib/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-bk10/lib/Makefile	2004-11-01 11:45:34.000000000 +0000
+++ linux-2.6.10-rc1-bk10-frv/lib/Makefile	2004-11-01 12:00:25.742993383 +0000
@@ -5,7 +5,8 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o kobject_uevent.o find_next_bit.o
+	 bitmap.o extable.o kobject_uevent.o find_next_bit.o \
+	 calibrate.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
