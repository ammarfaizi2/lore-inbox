Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbUAJBAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 20:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbUAJBAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 20:00:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27603 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264594AbUAJA6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:58:43 -0500
Date: Sat, 10 Jan 2004 01:58:39 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [4/4] proof of concept: make arch/i386/kernel/cpu/mtrr/Makefile CPU specific
Message-ID: <20040110005839.GG25089@fs.tum.de>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110004625.GB25089@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- make arch/i386/kernel/cpu/mtrr/Makefile CPU specific

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

