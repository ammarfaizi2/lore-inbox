Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264847AbTIIWbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTIIWbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:31:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4325 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264847AbTIIW3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:29:39 -0400
Date: Tue, 9 Sep 2003 23:29:37 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Marc Zyngier <maz@wild-wind.fr.eu.org>,
       Ralf Baechle <ralf@gnu.org>, Richard Henderson <rth@twiddle.net>
Subject: [PATCH] Move EISA_bus
Message-ID: <20030909222937.GH18654@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I change the setting of CONFIG_EISA, everything rebuilds.  This is
because EISA_bus is declared in <asm/processor.h> which is implicitly
included by just about everything.  This is a silly place to declare it,
so this patch moves it to include/linux/eisa.h.

While I'm at it, I also move the variable definition to
drivers/eisa/eisa-bus.c.  The rest of this patch is fixing up the fallout
from having to include <linux/eisa.h> if you use EISA_bus.

 arch/alpha/Kconfig                |    3 +++
 arch/i386/kernel/i386_ksyms.c     |    3 ---
 arch/i386/kernel/traps.c          |    5 +----
 arch/mips/jazz/setup.c            |    1 +
 arch/mips/kernel/mips_ksyms.c     |    4 ----
 arch/mips/kernel/setup.c          |    9 ---------
 arch/mips/sgi-ip22/ip22-eisa.c    |    1 +
 arch/mips/sni/setup.c             |    1 +
 arch/parisc/kernel/irq.c          |    3 ++-
 arch/parisc/kernel/parisc_ksyms.c |    3 ---
 arch/parisc/kernel/pci.c          |    1 +
 arch/parisc/kernel/setup.c        |    4 ----
 drivers/eisa/eisa-bus.c           |    5 +++++
 drivers/net/ac3200.c              |    1 +
 drivers/net/dgrs.c                |    1 +
 drivers/net/es3210.c              |    1 +
 drivers/net/hp100.c               |    1 +
 drivers/net/lne390.c              |    1 +
 drivers/net/ne3210.c              |    1 +
 drivers/net/smc-ultra32.c         |    1 +
 drivers/net/tlan.c                |    1 +
 include/asm-alpha/processor.h     |    1 -
 include/asm-arm/processor.h       |    1 -
 include/asm-arm26/processor.h     |    1 -
 include/asm-h8300/processor.h     |    1 -
 include/asm-i386/processor.h      |    5 -----
 include/asm-ia64/processor.h      |    1 -
 include/asm-m68k/processor.h      |    1 -
 include/asm-m68knommu/processor.h |    1 -
 include/asm-mips/processor.h      |    6 ------
 include/asm-parisc/processor.h    |    6 ------
 include/asm-ppc/processor.h       |    1 -
 include/asm-ppc64/processor.h     |    2 --
 include/asm-sh/processor.h        |    2 --
 include/asm-sparc/processor.h     |    1 -
 include/asm-sparc64/processor.h   |    1 -
 include/asm-v850/processor.h      |    2 --
 include/asm-x86_64/processor.h    |    1 -
 include/linux/eisa.h              |   13 +++++++++++++
 39 files changed, 36 insertions(+), 62 deletions(-)

Index: arch/alpha/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/alpha/Kconfig,v
retrieving revision 1.4
diff -u -p -r1.4 Kconfig
--- arch/alpha/Kconfig	8 Sep 2003 21:41:22 -0000	1.4
+++ arch/alpha/Kconfig	9 Sep 2003 21:16:03 -0000
@@ -484,6 +484,9 @@ config EISA
 
 	  Otherwise, say N.
 
+config EISA_ALWAYS
+	def_bool EISA
+
 config SMP
 	bool "Symmetric multi-processing support"
 	depends on ALPHA_SABLE || ALPHA_LYNX || ALPHA_RAWHIDE || ALPHA_DP264 || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_GENERIC || ALPHA_SHARK || ALPHA_MARVEL
Index: arch/i386/kernel/i386_ksyms.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/i386_ksyms.c,v
retrieving revision 1.1
diff -u -p -r1.1 i386_ksyms.c
--- arch/i386/kernel/i386_ksyms.c	29 Jul 2003 17:00:24 -0000	1.1
+++ arch/i386/kernel/i386_ksyms.c	9 Sep 2003 21:07:55 -0000
@@ -62,9 +62,6 @@ extern unsigned long get_cmos_time(void)
 
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
-#ifdef CONFIG_EISA
-EXPORT_SYMBOL(EISA_bus);
-#endif
 EXPORT_SYMBOL(MCA_bus);
 #ifdef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(node_data);
Index: arch/i386/kernel/traps.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/traps.c,v
retrieving revision 1.3
diff -u -p -r1.3 traps.c
--- arch/i386/kernel/traps.c	8 Sep 2003 21:41:30 -0000	1.3
+++ arch/i386/kernel/traps.c	9 Sep 2003 21:10:34 -0000
@@ -28,6 +28,7 @@
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
+#include <linux/eisa.h>
 #endif
 
 #ifdef CONFIG_MCA
@@ -831,10 +832,6 @@ static void __init set_task_gate(unsigne
 	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
 }
 
-
-#ifdef CONFIG_EISA
-int EISA_bus;
-#endif
 
 void __init trap_init(void)
 {
Index: arch/mips/jazz/setup.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/mips/jazz/setup.c,v
retrieving revision 1.2
diff -u -p -r1.2 setup.c
--- arch/mips/jazz/setup.c	12 Aug 2003 19:10:51 -0000	1.2
+++ arch/mips/jazz/setup.c	9 Sep 2003 21:56:15 -0000
@@ -9,6 +9,7 @@
  * Copyright (C) 2001 MIPS Technologies, Inc.
  */
 #include <linux/config.h>
+#include <linux/eisa.h>
 #include <linux/hdreg.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
Index: arch/mips/kernel/mips_ksyms.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/mips/kernel/mips_ksyms.c,v
retrieving revision 1.2
diff -u -p -r1.2 mips_ksyms.c
--- arch/mips/kernel/mips_ksyms.c	12 Aug 2003 19:10:52 -0000	1.2
+++ arch/mips/kernel/mips_ksyms.c	9 Sep 2003 21:18:36 -0000
@@ -43,10 +43,6 @@ extern long __strnlen_user_asm(const cha
 
 EXPORT_SYMBOL(mips_machtype);
 
-#ifdef CONFIG_EISA
-EXPORT_SYMBOL(EISA_bus);
-#endif
-
 /*
  * String functions
  */
Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/mips/kernel/setup.c,v
retrieving revision 1.2
diff -u -p -r1.2 setup.c
--- arch/mips/kernel/setup.c	12 Aug 2003 19:10:52 -0000	1.2
+++ arch/mips/kernel/setup.c	9 Sep 2003 21:18:49 -0000
@@ -44,15 +44,6 @@ struct cpuinfo_mips cpu_data[NR_CPUS];
 struct screen_info screen_info;
 #endif
 
-/*
- * Set if box has EISA slots.
- */
-#ifdef CONFIG_EISA
-int EISA_bus;
-
-EXPORT_SYMBOL(EISA_bus);
-#endif
-
 #if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_FD_MODULE)
 extern struct fd_ops no_fd_ops;
 struct fd_ops *fd_ops;
Index: arch/mips/sgi-ip22/ip22-eisa.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/mips/sgi-ip22/ip22-eisa.c,v
retrieving revision 1.1
diff -u -p -r1.1 ip22-eisa.c
--- arch/mips/sgi-ip22/ip22-eisa.c	29 Jul 2003 17:00:39 -0000	1.1
+++ arch/mips/sgi-ip22/ip22-eisa.c	9 Sep 2003 21:56:30 -0000
@@ -20,6 +20,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/eisa.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/irq.h>
Index: arch/mips/sni/setup.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/mips/sni/setup.c,v
retrieving revision 1.2
diff -u -p -r1.2 setup.c
--- arch/mips/sni/setup.c	12 Aug 2003 19:10:54 -0000	1.2
+++ arch/mips/sni/setup.c	9 Sep 2003 21:56:39 -0000
@@ -8,6 +8,7 @@
  * Copyright (C) 1996, 1997, 1998, 2000, 2003 by Ralf Baechle
  */
 #include <linux/config.h>
+#include <linux/eisa.h>
 #include <linux/hdreg.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
Index: arch/parisc/kernel/irq.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/kernel/irq.c,v
retrieving revision 1.8
diff -u -p -r1.8 irq.c
--- arch/parisc/kernel/irq.c	8 Sep 2003 22:00:21 -0000	1.8
+++ arch/parisc/kernel/irq.c	9 Sep 2003 21:25:33 -0000
@@ -22,7 +22,7 @@
  */
 #include <linux/bitops.h>
 #include <linux/config.h>
-#include <asm/pdc.h>
+#include <linux/eisa.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/signal.h>
@@ -39,6 +39,7 @@
 #include <linux/spinlock.h>
 
 #include <asm/cache.h>
+#include <asm/pdc.h>
 
 #undef DEBUG_IRQ
 #undef PARISC_IRQ_CR16_COUNTS
Index: arch/parisc/kernel/parisc_ksyms.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/kernel/parisc_ksyms.c,v
retrieving revision 1.8
diff -u -p -r1.8 parisc_ksyms.c
--- arch/parisc/kernel/parisc_ksyms.c	8 Sep 2003 22:00:21 -0000	1.8
+++ arch/parisc/kernel/parisc_ksyms.c	9 Sep 2003 21:19:16 -0000
@@ -42,9 +42,6 @@ EXPORT_SYMBOL(probe_irq_mask);
 #include <asm/processor.h>
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(boot_cpu_data);
-#ifdef CONFIG_EISA
-EXPORT_SYMBOL(EISA_bus);
-#endif
 
 #include <linux/pm.h>
 EXPORT_SYMBOL(pm_power_off);
Index: arch/parisc/kernel/pci.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/kernel/pci.c,v
retrieving revision 1.10
diff -u -p -r1.10 pci.c
--- arch/parisc/kernel/pci.c	8 Sep 2003 22:00:21 -0000	1.10
+++ arch/parisc/kernel/pci.c	9 Sep 2003 21:24:20 -0000
@@ -10,6 +10,7 @@
  * Copyright (C) 1999-2001 Grant Grundler
  */
 #include <linux/config.h>
+#include <linux/eisa.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
Index: arch/parisc/kernel/setup.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/kernel/setup.c,v
retrieving revision 1.1
diff -u -p -r1.1 setup.c
--- arch/parisc/kernel/setup.c	29 Jul 2003 17:00:41 -0000	1.1
+++ arch/parisc/kernel/setup.c	9 Sep 2003 21:19:30 -0000
@@ -52,10 +52,6 @@ char	command_line[COMMAND_LINE_SIZE];
 struct proc_dir_entry * proc_runway_root = NULL;
 struct proc_dir_entry * proc_gsc_root = NULL;
 
-#ifdef CONFIG_EISA
-int EISA_bus;	/* This has to go somewhere in architecture specific code. */
-#endif
-
 void __init setup_cmdline(char **cmdline_p)
 {
 	extern unsigned int boot_args[];
Index: drivers/eisa/eisa-bus.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/eisa/eisa-bus.c,v
retrieving revision 1.2
diff -u -p -r1.2 eisa-bus.c
--- drivers/eisa/eisa-bus.c	23 Aug 2003 02:46:42 -0000	1.2
+++ drivers/eisa/eisa-bus.c	9 Sep 2003 21:38:12 -0000
@@ -427,6 +427,11 @@ module_param(disable_dev, intarray, 0444
 
 postcore_initcall (eisa_init);
 
+#ifndef CONFIG_EISA_ALWAYS
+int EISA_bus;
+EXPORT_SYMBOL(EISA_bus);
+#endif
+
 EXPORT_SYMBOL (eisa_bus_type);
 EXPORT_SYMBOL (eisa_driver_register);
 EXPORT_SYMBOL (eisa_driver_unregister);
Index: drivers/net/ac3200.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/ac3200.c,v
retrieving revision 1.1
diff -u -p -r1.1 ac3200.c
--- drivers/net/ac3200.c	29 Jul 2003 17:01:17 -0000	1.1
+++ drivers/net/ac3200.c	9 Sep 2003 21:56:51 -0000
@@ -25,6 +25,7 @@ static const char version[] =
 	"ac3200.c:v1.01 7/1/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
 
 #include <linux/module.h>
+#include <linux/eisa.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
Index: drivers/net/dgrs.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/dgrs.c,v
retrieving revision 1.3
diff -u -p -r1.3 dgrs.c
--- drivers/net/dgrs.c	8 Sep 2003 21:42:12 -0000	1.3
+++ drivers/net/dgrs.c	9 Sep 2003 21:57:21 -0000
@@ -84,6 +84,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/eisa.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/delay.h>
Index: drivers/net/es3210.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/es3210.c,v
retrieving revision 1.1
diff -u -p -r1.1 es3210.c
--- drivers/net/es3210.c	29 Jul 2003 17:01:18 -0000	1.1
+++ drivers/net/es3210.c	9 Sep 2003 21:57:33 -0000
@@ -49,6 +49,7 @@ static const char version[] =
 	"es3210.c: Driver revision v0.03, 14/09/96\n";
 
 #include <linux/module.h>
+#include <linux/eisa.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
Index: drivers/net/hp100.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/hp100.c,v
retrieving revision 1.2
diff -u -p -r1.2 hp100.c
--- drivers/net/hp100.c	23 Aug 2003 02:46:51 -0000	1.2
+++ drivers/net/hp100.c	9 Sep 2003 21:57:53 -0000
@@ -104,6 +104,7 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/eisa.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/netdevice.h>
Index: drivers/net/lne390.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/lne390.c,v
retrieving revision 1.1
diff -u -p -r1.1 lne390.c
--- drivers/net/lne390.c	29 Jul 2003 17:01:18 -0000	1.1
+++ drivers/net/lne390.c	9 Sep 2003 21:58:01 -0000
@@ -35,6 +35,7 @@ static const char *version =
 	"lne390.c: Driver revision v0.99.1, 01/09/2000\n";
 
 #include <linux/module.h>
+#include <linux/eisa.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
Index: drivers/net/ne3210.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/ne3210.c,v
retrieving revision 1.1
diff -u -p -r1.1 ne3210.c
--- drivers/net/ne3210.c	29 Jul 2003 17:01:18 -0000	1.1
+++ drivers/net/ne3210.c	9 Sep 2003 21:58:10 -0000
@@ -29,6 +29,7 @@ static const char *version =
 	"ne3210.c: Driver revision v0.03, 30/09/98\n";
 
 #include <linux/module.h>
+#include <linux/eisa.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
Index: drivers/net/smc-ultra32.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/smc-ultra32.c,v
retrieving revision 1.1
diff -u -p -r1.1 smc-ultra32.c
--- drivers/net/smc-ultra32.c	29 Jul 2003 17:01:18 -0000	1.1
+++ drivers/net/smc-ultra32.c	9 Sep 2003 21:58:17 -0000
@@ -47,6 +47,7 @@ static const char *version = "smc-ultra3
 
 
 #include <linux/module.h>
+#include <linux/eisa.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
Index: drivers/net/tlan.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/tlan.c,v
retrieving revision 1.4
diff -u -p -r1.4 tlan.c
--- drivers/net/tlan.c	8 Sep 2003 21:42:13 -0000	1.4
+++ drivers/net/tlan.c	9 Sep 2003 21:58:29 -0000
@@ -169,6 +169,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/eisa.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
Index: include/asm-alpha/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-alpha/processor.h,v
retrieving revision 1.1
diff -u -p -r1.1 processor.h
--- include/asm-alpha/processor.h	29 Jul 2003 17:01:48 -0000	1.1
+++ include/asm-alpha/processor.h	9 Sep 2003 21:04:44 -0000
@@ -29,7 +29,6 @@
 /*
  * Bus types
  */
-#define EISA_bus 1
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
Index: include/asm-arm/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-arm/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-arm/processor.h	8 Sep 2003 21:42:41 -0000	1.2
+++ include/asm-arm/processor.h	9 Sep 2003 21:04:48 -0000
@@ -19,7 +19,6 @@
 
 #ifdef __KERNEL__
 
-#define EISA_bus 0
 #define MCA_bus 0
 #define MCA_bus__is_a_macro
 
Index: include/asm-arm26/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-arm26/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-arm26/processor.h	8 Sep 2003 21:42:43 -0000	1.2
+++ include/asm-arm26/processor.h	9 Sep 2003 21:04:51 -0000
@@ -20,7 +20,6 @@
 
 #ifdef __KERNEL__
 
-#define EISA_bus 0
 #define MCA_bus 0
 #define MCA_bus__is_a_macro
 
Index: include/asm-h8300/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-h8300/processor.h,v
retrieving revision 1.3
diff -u -p -r1.3 processor.h
--- include/asm-h8300/processor.h	23 Aug 2003 02:47:15 -0000	1.3
+++ include/asm-h8300/processor.h	9 Sep 2003 21:04:54 -0000
@@ -48,7 +48,6 @@ extern inline void wrusp(unsigned long u
 /*
  * Bus types
  */
-#define EISA_bus 0
 #define MCA_bus 0
 
 struct thread_struct {
Index: include/asm-i386/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-i386/processor.h,v
retrieving revision 1.3
diff -u -p -r1.3 processor.h
--- include/asm-i386/processor.h	8 Sep 2003 21:42:45 -0000	1.3
+++ include/asm-i386/processor.h	9 Sep 2003 21:03:22 -0000
@@ -260,11 +260,6 @@ static inline void clear_in_cr4 (unsigne
  * Bus types (default is ISA, but people can check others with these..)
  * pc98 indicates PC98 systems (CBUS)
  */
-#ifdef CONFIG_EISA
-extern int EISA_bus;
-#else
-#define EISA_bus (0)
-#endif
 extern int MCA_bus;
 #ifdef CONFIG_X86_PC9800
 #define pc98 1
Index: include/asm-ia64/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ia64/processor.h,v
retrieving revision 1.3
diff -u -p -r1.3 processor.h
--- include/asm-ia64/processor.h	23 Aug 2003 02:47:19 -0000	1.3
+++ include/asm-ia64/processor.h	9 Sep 2003 21:04:57 -0000
@@ -56,7 +56,6 @@
 /*
  * Bus types
  */
-#define EISA_bus 0
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
Index: include/asm-m68k/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-m68k/processor.h,v
retrieving revision 1.1
diff -u -p -r1.1 processor.h
--- include/asm-m68k/processor.h	29 Jul 2003 17:01:58 -0000	1.1
+++ include/asm-m68k/processor.h	9 Sep 2003 21:05:00 -0000
@@ -56,7 +56,6 @@ extern inline void wrusp(unsigned long u
 /*
  * Bus types
  */
-#define EISA_bus 0
 #define MCA_bus 0
 
 struct task_work {
Index: include/asm-m68knommu/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-m68knommu/processor.h,v
retrieving revision 1.1
diff -u -p -r1.1 processor.h
--- include/asm-m68knommu/processor.h	29 Jul 2003 17:01:59 -0000	1.1
+++ include/asm-m68knommu/processor.h	9 Sep 2003 21:05:02 -0000
@@ -58,7 +58,6 @@ extern inline void wrusp(unsigned long u
 /*
  * Bus types
  */
-#define EISA_bus 0
 #define MCA_bus 0
 
 /* 
Index: include/asm-mips/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-mips/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-mips/processor.h	12 Aug 2003 19:11:22 -0000	1.2
+++ include/asm-mips/processor.h	9 Sep 2003 21:05:13 -0000
@@ -135,12 +135,6 @@ extern unsigned int vced_count, vcei_cou
 /*
  * Bus types (default is ISA, but people can check others with these..)
  */
-#ifdef CONFIG_EISA
-extern int EISA_bus;
-#else
-#define EISA_bus (0)
-#endif
-
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
Index: include/asm-parisc/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-parisc/processor.h,v
retrieving revision 1.1
diff -u -p -r1.1 processor.h
--- include/asm-parisc/processor.h	29 Jul 2003 17:02:04 -0000	1.1
+++ include/asm-parisc/processor.h	9 Sep 2003 21:05:18 -0000
@@ -101,12 +101,6 @@ extern struct cpuinfo_parisc cpu_data[NR
 
 #define CPU_HVERSION ((boot_cpu_data.hversion >> 4) & 0x0FFF)
 
-#ifdef CONFIG_EISA
-extern int EISA_bus;
-#else
-#define EISA_bus 0
-#endif
-
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
Index: include/asm-ppc/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ppc/processor.h,v
retrieving revision 1.3
diff -u -p -r1.3 processor.h
--- include/asm-ppc/processor.h	8 Sep 2003 21:42:47 -0000	1.3
+++ include/asm-ppc/processor.h	9 Sep 2003 21:05:21 -0000
@@ -803,7 +803,6 @@ extern long kernel_thread(int (*fn)(void
 /*
  * Bus types
  */
-#define EISA_bus 0
 #define MCA_bus 0
 #define MCA_bus__is_a_macro
 
Index: include/asm-ppc64/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ppc64/processor.h,v
retrieving revision 1.1
diff -u -p -r1.1 processor.h
--- include/asm-ppc64/processor.h	29 Jul 2003 17:02:04 -0000	1.1
+++ include/asm-ppc64/processor.h	9 Sep 2003 21:05:25 -0000
@@ -612,8 +612,6 @@ extern long kernel_thread(int (*fn)(void
 /*
  * Bus types
  */
-#define EISA_bus 0
-#define EISA_bus__is_a_macro /* for versions in ksyms.c */
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
Index: include/asm-sh/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-sh/processor.h,v
retrieving revision 1.1
diff -u -p -r1.1 processor.h
--- include/asm-sh/processor.h	29 Jul 2003 17:02:05 -0000	1.1
+++ include/asm-sh/processor.h	9 Sep 2003 21:05:28 -0000
@@ -169,8 +169,6 @@ extern int kernel_thread(int (*fn)(void 
 /*
  * Bus types
  */
-#define EISA_bus 0
-#define EISA_bus__is_a_macro /* for versions in ksyms.c */
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
Index: include/asm-sparc/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-sparc/processor.h,v
retrieving revision 1.1
diff -u -p -r1.1 processor.h
--- include/asm-sparc/processor.h	29 Jul 2003 17:02:09 -0000	1.1
+++ include/asm-sparc/processor.h	9 Sep 2003 21:05:32 -0000
@@ -27,7 +27,6 @@
 /*
  * Bus types
  */
-#define EISA_bus 0
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
Index: include/asm-sparc64/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-sparc64/processor.h,v
retrieving revision 1.3
diff -u -p -r1.3 processor.h
--- include/asm-sparc64/processor.h	23 Aug 2003 02:47:21 -0000	1.3
+++ include/asm-sparc64/processor.h	9 Sep 2003 21:05:45 -0000
@@ -22,7 +22,6 @@
 #include <asm/page.h>
 
 /* Bus types */
-#define EISA_bus 0
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
Index: include/asm-v850/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-v850/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-v850/processor.h	29 Jul 2003 17:25:54 -0000	1.2
+++ include/asm-v850/processor.h	9 Sep 2003 21:05:49 -0000
@@ -52,8 +52,6 @@
 /*
  * Bus types
  */
-#define EISA_bus 0
-#define EISA_bus__is_a_macro /* for versions in ksyms.c */
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
Index: include/asm-x86_64/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-x86_64/processor.h,v
retrieving revision 1.4
diff -u -p -r1.4 processor.h
--- include/asm-x86_64/processor.h	8 Sep 2003 21:42:48 -0000	1.4
+++ include/asm-x86_64/processor.h	9 Sep 2003 21:05:54 -0000
@@ -160,7 +160,6 @@ static inline void clear_in_cr4 (unsigne
 /*
  * Bus types
  */
-#define EISA_bus 0
 #define MCA_bus 0
 #define MCA_bus__is_a_macro
 
Index: include/linux/eisa.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/eisa.h,v
retrieving revision 1.2
diff -u -p -r1.2 eisa.h
--- include/linux/eisa.h	23 Aug 2003 02:47:23 -0000	1.2
+++ include/linux/eisa.h	9 Sep 2003 21:23:44 -0000
@@ -1,6 +1,19 @@
 #ifndef _LINUX_EISA_H
 #define _LINUX_EISA_H
 
+#include <linux/ioport.h>
+#include <linux/device.h>
+
+#ifdef CONFIG_EISA
+# ifdef CONFIG_EISA_ALWAYS
+#  define EISA_bus 1
+# else
+   extern int EISA_bus;
+# endif
+#else
+# define EISA_bus 0
+#endif
+
 #define EISA_SIG_LEN   8
 #define EISA_MAX_SLOTS 8
 

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
