Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268746AbTBZNim>; Wed, 26 Feb 2003 08:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268747AbTBZNil>; Wed, 26 Feb 2003 08:38:41 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:41668 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268746AbTBZNik>; Wed, 26 Feb 2003 08:38:40 -0500
Date: Wed, 26 Feb 2003 13:49:00 GMT
Message-Id: <200302261349.h1QDn0Bh002816@deviant.impure.org.uk>
To: linux-kernel@vger.kernel.org
From: davej@codemonkey.org.uk
Subject: Enabling L2 cache for overdrive CPUs.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some CPU overdrives (such as those made by powerleap) mean
that we get a CPU with L2 cache disabled by default, and
a BIOS that doesn't know how to turn it on.
The patch below is untested, and I'd like some feedback
from folks (preferably those with these wacky overdrives,
but also from regular intel CPUs too - disable L2 in your
bios and try booting with 'enable-l2' and see what happens).

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/intel.c linux-2.5/arch/i386/kernel/cpu/intel.c
--- bk-linus/arch/i386/kernel/cpu/intel.c	2003-02-25 13:10:08.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/intel.c	2003-02-25 13:07:52.000000000 -0100
@@ -8,6 +8,7 @@
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
+#include <asm/system.h>
 
 #include "cpu.h"
 
@@ -75,6 +76,36 @@ static int __init P4_disable_ht(char *s)
 }
 __setup("noht", P4_disable_ht);
 
+/*
+ * Some 'overdrive' boards, such as those from Powerleap don't have
+ * the L2 cache enabled, and the BIOS doesn't know about it, so we
+ * have this option to 'force' it on.
+ */
+static int __init P2_enable_L2(char *s)
+{
+	unsigned long cr0, lo, hi;
+
+	printk ("CPU: Enabling L2 cache.\n");
+
+	__asm__ ("cli");
+
+	cr0 = read_cr0();
+	cr0 |= 1<<30;
+	write_cr0 (cr0);
+
+	rdmsr (0x11e, lo, hi);
+	lo |= 0x40101;
+	wrmsr (0x11e, lo, hi);
+
+	cr0 &= ~(1<<30);
+	write_cr0 (cr0);
+
+	wbinvd();
+	__asm__("sti");
+	return 0;
+}
+__setup("enable-l2", P2_enable_L2);
+
 #define LVL_1_INST	1
 #define LVL_1_DATA	2
 #define LVL_2		3
