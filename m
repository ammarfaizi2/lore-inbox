Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271455AbTGRJc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271567AbTGRJbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:31:43 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:23279 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271455AbTGRJax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 7/7][v850]  Update v850 config/makefile
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094539.D650637C2@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:39 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This updates the v850 Kconfig and kernel/Makefile to reflect preceding
changes.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/Kconfig linux-2.6.0-test1-moo-v850-20030718/arch/v850/Kconfig
--- linux-2.6.0-test1-moo/arch/v850/Kconfig	2003-07-03 13:06:45.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/Kconfig	2003-07-18 10:48:55.000000000 +0900
@@ -48,20 +48,24 @@
    choice
 	  prompt "Platform"
 	  default GDB
+      config V850E_SIM
+      	     bool "GDB"
       config RTE_CB_MA1
       	     bool "RTE-V850E/MA1-CB"
       config RTE_CB_NB85E
       	     bool "RTE-V850E/NB85E-CB"
-      config V850E_SIM
-      	     bool "GDB"
+      config RTE_CB_ME2
+      	     bool "RTE-V850E/ME2-CB"
+      config V850E_AS85EP1
+      	     bool "AS85EP1"
       config V850E2_SIM85E2C
       	     bool "sim85e2c"
+      config V850E2_SIM85E2S
+      	     bool "sim85e2s"
       config V850E2_FPGA85E2C
       	     bool "NA85E2C-FPGA"
       config V850E2_ANNA
       	     bool "Anna"
-      config V850E_AS85EP1
-      	     bool "AS85EP1"
    endchoice
 
 
@@ -78,41 +82,32 @@
    	  bool
 	  depends RTE_CB_MA1
 	  default y
-   # Similarly for the RTE-V850E/MA1-CB - V850E/TEG
+   # Similarly for the RTE-V850E/NB85E-CB - V850E/TEG
    config V850E_TEG
    	  bool
 	  depends RTE_CB_NB85E
 	  default y
-
-   # NB85E processor core
-   config V850E_NB85E
+   # ... and the RTE-V850E/ME2-CB - V850E/ME2
+   config V850E_ME2
    	  bool
-	  depends V850E_MA1 || V850E_TEG
+	  depends RTE_CB_ME2
 	  default y
 
-   config V850E_MA1_HIGHRES_TIMER
-   	  bool "High resolution timer support"
-  	  depends V850E_MA1
-
 
-   #### V850E2 processor-specific config
+   #### sim85e2-specific config
 
-   # V850E2 processors
-   config V850E2
+   config V850E2_SIM85E2
    	  bool
-	  depends V850E2_SIM85E2C || V850E2_FPGA85E2C || V850E2_ANNA
+	  depends V850E2_SIM85E2C || V850E2_SIM85E2S
 	  default y
 
-   # Processors based on the NA85E2A core
-   config V850E2_NA85E2A
-   	  bool
-	  depends V850E2_ANNA
-	  default y
 
-   # Processors based on the NA85E2C core
-   config V850E2_NA85E2C
+   #### V850E2 processor-specific config
+
+   # V850E2 processors
+   config V850E2
    	  bool
-	  depends V850E2_SIM85E2C || V850E2_FPGA85E2C
+	  depends V850E2_SIM85E2 || V850E2_FPGA85E2C || V850E2_ANNA
 	  default y
 
 
@@ -121,7 +116,7 @@
    # Boards in the RTE-x-CB series
    config RTE_CB
    	  bool
-	  depends RTE_CB_MA1 || RTE_CB_NB85E
+	  depends RTE_CB_MA1 || RTE_CB_NB85E || RTE_CB_ME2
 	  default y
 
    config RTE_CB_MULTI
@@ -129,7 +124,7 @@
 	  # RTE_CB_NB85E can either have multi ROM support or not, but
 	  # other platforms (currently only RTE_CB_MA1) require it.
 	  prompt "Multi monitor ROM support" if RTE_CB_NB85E
-	  depends RTE_CB
+	  depends RTE_CB_MA1 || RTE_CB_NB85E
 	  default y
 
    config RTE_CB_MULTI_DBTRAP
@@ -156,14 +151,42 @@
    # The only PCI bus we support is on the RTE-MOTHER-A board
    config PCI
    	  bool
-	  default y if RTE_MB_A_PCI
+	  default RTE_MB_A_PCI
+
+
+   #### Some feature-specific configs
+
+   # Everything except for the GDB simulator uses the same interrupt controller
+   config V850E_INTC
+   	  bool
+	  default !V850E_SIM
+
+   # Everything except for the various simulators uses the "Timer D" unit
+   config V850E_TIMER_D
+   	  bool
+	  default !V850E_SIM && !V850E2_SIM85E2
+
+   # Cache control used on some v850e1 processors
+   config V850E_CACHE
+          bool
+	  default V850E_TEG || V850E_ME2
+
+   # Cache control used on v850e2 processors; I think this should
+   # actually apply to more, but currently only the SIM85E2S uses it
+   config V850E2_CACHE
+   	  bool
+	  default V850E2_SIM85E2S
+
+   config NO_CACHE
+   	  bool
+	  default !V850E_CACHE && !V850E2_CACHE
 
 
    #### Misc config
 
    config ROM_KERNEL
    	  bool "Kernel in ROM"
-	  depends V850E2_ANNA || (RTE_CB && !RTE_CB_MULTI)
+	  depends V850E2_ANNA || V850E_AS85EP1 || RTE_CB_ME2
 
    # Some platforms pre-zero memory, in which case the kernel doesn't need to
    config ZERO_BSS
@@ -177,9 +200,12 @@
    	  int
 	  default 8 if V850E2_SIM85E2C || V850E2_FPGA85E2C
 
+   config V850E_HIGHRES_TIMER
+   	  bool "High resolution timer support"
+	  depends V850E_TIMER_D
    config TIME_BOOTUP
    	  bool "Time bootup"
-	  depends V850E_MA1_HIGHRES_TIMER
+	  depends V850E_HIGHRES_TIMER
 
    config RESET_GUARD
    	  bool "Reset Guard"
@@ -241,6 +267,7 @@
 	default y
 
 config KCORE_ELF
+	bool
 	default y
 
 source "fs/Kconfig.binfmt"
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/Makefile linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/Makefile
--- linux-2.6.0-test1-moo/arch/v850/kernel/Makefile	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/Makefile	2003-07-17 20:25:27.000000000 +0900
@@ -15,24 +15,26 @@
 	 signal.o irq.o mach.o ptrace.o bug.o
 obj-$(CONFIG_MODULES)		+= module.o v850_ksyms.o
 # chip-specific code
-obj-$(CONFIG_V850E_NB85E)	+= nb85e_intc.o
-obj-$(CONFIG_V850E_MA1)		+= ma.o nb85e_utils.o nb85e_timer_d.o
-obj-$(CONFIG_V850E_TEG)		+= teg.o nb85e_utils.o nb85e_cache.o \
-				   nb85e_timer_d.o
-obj-$(CONFIG_V850E2_ANNA)	+= anna.o nb85e_intc.o nb85e_utils.o \
-				   nb85e_timer_d.o
-obj-$(CONFIG_V850E_AS85EP1)	+= as85ep1.o nb85e_intc.o nb85e_utils.o \
-				   nb85e_timer_d.o
+obj-$(CONFIG_V850E_MA1)		+= ma.o
+obj-$(CONFIG_V850E_ME2)		+= me2.o
+obj-$(CONFIG_V850E_TEG)		+= teg.o
+obj-$(CONFIG_V850E_AS85EP1)	+= as85ep1.o
+obj-$(CONFIG_V850E2_ANNA)	+= anna.o
 # platform-specific code
 obj-$(CONFIG_V850E_SIM)		+= sim.o simcons.o
-obj-$(CONFIG_V850E2_SIM85E2C)	+= sim85e2c.o nb85e_intc.o memcons.o
-obj-$(CONFIG_V850E2_FPGA85E2C)	+= fpga85e2c.o nb85e_intc.o memcons.o
+obj-$(CONFIG_V850E2_SIM85E2)	+= sim85e2.o memcons.o
+obj-$(CONFIG_V850E2_FPGA85E2C)	+= fpga85e2c.o memcons.o
 obj-$(CONFIG_RTE_CB)		+= rte_cb.o rte_cb_leds.o
 obj-$(CONFIG_RTE_CB_MA1)	+= rte_ma1_cb.o
+obj-$(CONFIG_RTE_CB_ME2)	+= rte_me2_cb.o
 obj-$(CONFIG_RTE_CB_NB85E)	+= rte_nb85e_cb.o
 obj-$(CONFIG_RTE_CB_MULTI)	+= rte_cb_multi.o
 obj-$(CONFIG_RTE_MB_A_PCI)	+= rte_mb_a_pci.o
 obj-$(CONFIG_RTE_GBUS_INT)	+= gbus_int.o
 # feature-specific code
-obj-$(CONFIG_V850E_MA1_HIGHRES_TIMER)	+= highres_timer.o
+obj-$(CONFIG_V850E_INTC)	+= v850e_intc.o
+obj-$(CONFIG_V850E_TIMER_D)	+= v850e_timer_d.o v850e_utils.o
+obj-$(CONFIG_V850E_CACHE)	+= v850e_cache.o
+obj-$(CONFIG_V850E2_CACHE)	+= v850e2_cache.o
+obj-$(CONFIG_V850E_HIGHRES_TIMER) += highres_timer.o
 obj-$(CONFIG_PROC_FS)		+= procfs.o
