Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbTIMWaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbTIMWaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:30:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48123 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262233AbTIMWaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:30:02 -0400
Date: Sun, 14 Sep 2003 00:29:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [4/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030913222953.GR27368@fs.tum.de>
References: <20030913222443.GN27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913222443.GN27368@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- made arch/i386/kernel/cpu/mtrr/Makefile CPU specific

diffstat output:

 arch/i386/kernel/cpu/mtrr/Makefile |   14 ++++++++++----
 arch/i386/kernel/cpu/mtrr/main.c   |   14 ++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)


--- linux-2.6.0-test5-cpu/arch/i386/kernel/cpu/mtrr/Makefile.old	2003-09-13 11:25:27.000000000 +0200
+++ linux-2.6.0-test5-cpu/arch/i386/kernel/cpu/mtrr/Makefile	2003-09-13 14:14:20.000000000 +0200
@@ -1,5 +1,11 @@
-obj-y		:= main.o if.o generic.o state.o
-obj-y		+= amd.o
-obj-y		+= cyrix.o
-obj-y		+= centaur.o
+obj-y				:= main.o if.o generic.o state.o
+
+obj-$(CONFIG_CPU_K6)		+= amd.o
+
+obj-$(CONFIG_CPU_586)		+= cyrix.o
+
+obj-$(CONFIG_CPU_WINCHIP)	+= centaur.o
+obj-$(CONFIG_CPU_CYRIXIII)	+= centaur.o
+obj-$(CONFIG_CPU_VIAC3_2)	+= centaur.o
+
 
--- linux-2.6.0-test5-cpu/arch/i386/kernel/cpu/mtrr/main.c.old	2003-09-13 14:04:35.000000000 +0200
+++ linux-2.6.0-test5-cpu/arch/i386/kernel/cpu/mtrr/main.c	2003-09-13 14:09:11.000000000 +0200
@@ -475,12 +475,16 @@
 		printk(KERN_WARNING "mtrr: register: %d too big\n", reg);
 		goto out;
 	}
+
+#if defined(CONFIG_CPU_586)
 	if (is_cpu(CYRIX) && !use_intel()) {
 		if ((reg == 3) && arr3_protected) {
 			printk(KERN_WARNING "mtrr: ARR3 cannot be changed\n");
 			goto out;
 		}
 	}
+#endif
+
 	mtrr_if->get(reg, &lbase, &lsize, &ltype);
 	if (lsize < 1) {
 		printk(KERN_WARNING "mtrr: MTRR %d not used\n", reg);
@@ -536,9 +540,19 @@
 
 static void __init init_ifs(void)
 {
+
+#if defined(CONFIG_CPU_K6)
 	amd_init_mtrr();
+#endif
+
+#if defined(CONFIG_CPU_586)
 	cyrix_init_mtrr();
+#endif
+
+#if defined(CONFIG_CPU_WINCHIP) || defined(CONFIG_CPU_CYRIXIII) || defined(CONFIG_CPU_VIAC3_2)
 	centaur_init_mtrr();
+#endif
+
 }
 
 static void init_other_cpus(void)

