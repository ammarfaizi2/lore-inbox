Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbTI1RH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbTI1RH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:07:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16570 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262659AbTI1RHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:07:04 -0400
Date: Sun, 28 Sep 2003 18:07:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MCA_bus move
Message-ID: <20030928170703.GK24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updated for 2.6.0-test6.

 - Move MCA_bus definition to drivers/mca/mca-bus.c
 - Declare MCA_bus in <linux/mca.h>
 - We can always include <linux/mca.h> whether or not CONFIG_MCA is defined.

Index: arch/i386/kernel/i386_ksyms.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/i386_ksyms.c,v
retrieving revision 1.3
diff -u -p -r1.3 i386_ksyms.c
--- arch/i386/kernel/i386_ksyms.c	28 Sep 2003 04:04:44 -0000	1.3
+++ arch/i386/kernel/i386_ksyms.c	28 Sep 2003 16:58:28 -0000
@@ -63,7 +63,6 @@ extern unsigned long get_cmos_time(void)
 
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
-EXPORT_SYMBOL(MCA_bus);
 #ifdef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(node_data);
 EXPORT_SYMBOL(physnode_map);
Index: arch/i386/kernel/setup.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/setup.c,v
retrieving revision 1.5
diff -u -p -r1.5 setup.c
--- arch/i386/kernel/setup.c	28 Sep 2003 04:04:44 -0000	1.5
+++ arch/i386/kernel/setup.c	28 Sep 2003 16:58:28 -0000
@@ -35,6 +35,7 @@
 #include <linux/console.h>
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
+#include <linux/mca.h>
 #include <linux/module.h>
 #include <video/edid.h>
 #include <asm/e820.h>
@@ -79,7 +80,6 @@ EXPORT_SYMBOL(acpi_disabled);
 int acpi_force __initdata = 0;
 
 
-int MCA_bus;
 /* for MCA, but anyone else can use it if they want */
 unsigned int machine_id;
 unsigned int machine_submodel_id;
@@ -966,7 +966,9 @@ void __init setup_arch(char **cmdline_p)
 	saved_videomode = VIDEO_MODE;
 	printk("Video mode to be used for restore is %lx\n", saved_videomode);
 	if( SYS_DESC_TABLE.length != 0 ) {
+#ifdef CONFIG_MCA
 		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
+#endif
 		machine_id = SYS_DESC_TABLE.table[0];
 		machine_submodel_id = SYS_DESC_TABLE.table[1];
 		BIOS_revision = SYS_DESC_TABLE.table[2];
Index: arch/i386/kernel/time.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/time.c,v
retrieving revision 1.2
diff -u -p -r1.2 time.c
--- arch/i386/kernel/time.c	8 Sep 2003 21:41:30 -0000	1.2
+++ arch/i386/kernel/time.c	28 Sep 2003 16:58:30 -0000
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/mca.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
 #include <linux/bcd.h>
Index: arch/i386/kernel/traps.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/traps.c,v
retrieving revision 1.5
diff -u -p -r1.5 traps.c
--- arch/i386/kernel/traps.c	28 Sep 2003 04:04:44 -0000	1.5
+++ arch/i386/kernel/traps.c	28 Sep 2003 16:58:30 -0000
@@ -25,15 +25,9 @@
 #include <linux/highmem.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
-
-#ifdef CONFIG_EISA
 #include <linux/ioport.h>
 #include <linux/eisa.h>
-#endif
-
-#ifdef CONFIG_MCA
 #include <linux/mca.h>
-#endif
 
 #include <asm/processor.h>
 #include <asm/system.h>
Index: arch/i386/mach-pc9800/setup.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/mach-pc9800/setup.c,v
retrieving revision 1.1
diff -u -p -r1.1 setup.c
--- arch/i386/mach-pc9800/setup.c	29 Jul 2003 17:00:25 -0000	1.1
+++ arch/i386/mach-pc9800/setup.c	28 Sep 2003 16:58:30 -0000
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/apm_bios.h>
+#include <linux/mca.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 
Index: drivers/isdn/eicon/eicon_isa.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/isdn/eicon/eicon_isa.c,v
retrieving revision 1.2
diff -u -p -r1.2 eicon_isa.c
--- drivers/isdn/eicon/eicon_isa.c	12 Aug 2003 19:11:04 -0000	1.2
+++ drivers/isdn/eicon/eicon_isa.c	28 Sep 2003 16:58:33 -0000
@@ -13,6 +13,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/mca.h>
 #include "eicon.h"
 #include "eicon_isa.h"
 
Index: drivers/isdn/eicon/eicon_mod.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/isdn/eicon/eicon_mod.c,v
retrieving revision 1.1
diff -u -p -r1.1 eicon_mod.c
--- drivers/isdn/eicon/eicon_mod.c	29 Jul 2003 17:01:10 -0000	1.1
+++ drivers/isdn/eicon/eicon_mod.c	28 Sep 2003 16:58:33 -0000
@@ -27,9 +27,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#ifdef CONFIG_MCA
 #include <linux/mca.h>
-#endif /* CONFIG_MCA */
 
 #include "eicon.h"
 
Index: drivers/mca/mca-bus.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/mca/mca-bus.c,v
retrieving revision 1.2
diff -u -p -r1.2 mca-bus.c
--- drivers/mca/mca-bus.c	23 Aug 2003 02:46:48 -0000	1.2
+++ drivers/mca/mca-bus.c	28 Sep 2003 16:58:33 -0000
@@ -36,6 +36,9 @@
  * expansion.  None that I know have more than 2 */
 struct mca_bus *mca_root_busses[MAX_MCA_BUSSES];
 
+int MCA_bus;
+EXPORT_SYMBOL(MCA_bus);
+
 #define MCA_DEVINFO(i,s) { .pos = i, .name = s }
 
 struct mca_device_info {
Index: drivers/net/depca.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/depca.c,v
retrieving revision 1.2
diff -u -p -r1.2 depca.c
--- drivers/net/depca.c	28 Sep 2003 04:05:34 -0000	1.2
+++ drivers/net/depca.c	28 Sep 2003 16:58:34 -0000
@@ -237,6 +237,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -253,21 +254,15 @@
 #include <linux/types.h>
 #include <linux/unistd.h>
 #include <linux/ctype.h>
-#include <linux/moduleparam.h>
+#include <linux/mca-legacy.h>
+#include <linux/mca.h>
 #include <linux/device.h>
+#include <linux/eisa.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-
-#ifdef CONFIG_MCA
-#include <linux/mca.h>
-#endif
-
-#ifdef CONFIG_EISA
-#include <linux/eisa.h>
-#endif
 
 #include "depca.h"
 
Index: drivers/serial/8250.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/serial/8250.c,v
retrieving revision 1.11
diff -u -p -r1.11 8250.c
--- drivers/serial/8250.c	28 Sep 2003 04:05:52 -0000	1.11
+++ drivers/serial/8250.c	28 Sep 2003 16:58:34 -0000
@@ -29,6 +29,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/mca.h>
 #include <linux/sysrq.h>
 #include <linux/serial_reg.h>
 #include <linux/serial.h>
Index: include/asm-alpha/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-alpha/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-alpha/processor.h	21 Sep 2003 19:23:25 -0000	1.2
+++ include/asm-alpha/processor.h	28 Sep 2003 16:58:35 -0000
@@ -26,12 +26,6 @@
 #define TASK_UNMAPPED_BASE \
   ((current->personality & ADDR_LIMIT_32BIT) ? 0x40000000 : TASK_SIZE / 2)
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro /* for versions in ksyms.c */
-
 typedef struct {
 	unsigned long seg;
 } mm_segment_t;
Index: include/asm-arm/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-arm/processor.h,v
retrieving revision 1.3
diff -u -p -r1.3 processor.h
--- include/asm-arm/processor.h	21 Sep 2003 19:23:25 -0000	1.3
+++ include/asm-arm/processor.h	28 Sep 2003 16:58:35 -0000
@@ -19,9 +19,6 @@
 
 #ifdef __KERNEL__
 
-#define MCA_bus 0
-#define MCA_bus__is_a_macro
-
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/procinfo.h>
Index: include/asm-arm26/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-arm26/processor.h,v
retrieving revision 1.3
diff -u -p -r1.3 processor.h
--- include/asm-arm26/processor.h	21 Sep 2003 19:23:25 -0000	1.3
+++ include/asm-arm26/processor.h	28 Sep 2003 16:58:35 -0000
@@ -20,9 +20,6 @@
 
 #ifdef __KERNEL__
 
-#define MCA_bus 0
-#define MCA_bus__is_a_macro
-
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <linux/string.h>
Index: include/asm-h8300/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-h8300/processor.h,v
retrieving revision 1.4
diff -u -p -r1.4 processor.h
--- include/asm-h8300/processor.h	21 Sep 2003 19:23:26 -0000	1.4
+++ include/asm-h8300/processor.h	28 Sep 2003 16:58:35 -0000
@@ -45,11 +45,6 @@ extern inline void wrusp(unsigned long u
  */
 #define TASK_UNMAPPED_BASE	0
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-
 struct thread_struct {
 	unsigned long ksp;		/* kernel stack pointer */
 	unsigned long usp;		/* user stack pointer */
Index: include/asm-i386/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-i386/processor.h,v
retrieving revision 1.5
diff -u -p -r1.5 processor.h
--- include/asm-i386/processor.h	28 Sep 2003 04:06:12 -0000	1.5
+++ include/asm-i386/processor.h	28 Sep 2003 16:58:36 -0000
@@ -260,7 +260,6 @@ static inline void clear_in_cr4 (unsigne
  * Bus types (default is ISA, but people can check others with these..)
  * pc98 indicates PC98 systems (CBUS)
  */
-extern int MCA_bus;
 #ifdef CONFIG_X86_PC9800
 #define pc98 1
 #else
Index: include/asm-ia64/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ia64/processor.h,v
retrieving revision 1.4
diff -u -p -r1.4 processor.h
--- include/asm-ia64/processor.h	21 Sep 2003 19:23:27 -0000	1.4
+++ include/asm-ia64/processor.h	28 Sep 2003 16:58:36 -0000
@@ -53,12 +53,6 @@
  */
 #define TASK_UNMAPPED_BASE	(current->thread.map_base)
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro /* for versions in ksyms.c */
-
 #define IA64_THREAD_FPH_VALID	(__IA64_UL(1) << 0)	/* floating-point high state valid? */
 #define IA64_THREAD_DBG_VALID	(__IA64_UL(1) << 1)	/* debug registers valid? */
 #define IA64_THREAD_PM_VALID	(__IA64_UL(1) << 2)	/* performance registers valid? */
Index: include/asm-m68k/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-m68k/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-m68k/processor.h	21 Sep 2003 19:23:27 -0000	1.2
+++ include/asm-m68k/processor.h	28 Sep 2003 16:58:36 -0000
@@ -53,11 +53,6 @@ extern inline void wrusp(unsigned long u
 #endif
 #define TASK_UNMAPPED_ALIGN(addr, off)	PAGE_ALIGN(addr)
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-
 struct task_work {
 	unsigned char sigpending;
 	unsigned char notify_resume;	/* request for notification on
Index: include/asm-m68knommu/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-m68knommu/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-m68knommu/processor.h	21 Sep 2003 19:23:28 -0000	1.2
+++ include/asm-m68knommu/processor.h	28 Sep 2003 16:58:36 -0000
@@ -55,11 +55,6 @@ extern inline void wrusp(unsigned long u
  */
 #define TASK_UNMAPPED_BASE	0
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-
 /* 
  * if you change this structure, you must change the code and offsets
  * in m68k/machasm.S
Index: include/asm-mips/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-mips/processor.h,v
retrieving revision 1.3
diff -u -p -r1.3 processor.h
--- include/asm-mips/processor.h	21 Sep 2003 19:23:28 -0000	1.3
+++ include/asm-mips/processor.h	28 Sep 2003 16:58:36 -0000
@@ -132,12 +132,6 @@ extern void (*cpu_wait)(void);
 
 extern unsigned int vced_count, vcei_count;
 
-/*
- * Bus types (default is ISA, but people can check others with these..)
- */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro /* for versions in ksyms.c */
-
 #ifdef CONFIG_MIPS32
 /*
  * User space process size: 2GB. This is hardcoded into a few places,
Index: include/asm-parisc/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-parisc/processor.h,v
retrieving revision 1.5
diff -u -p -r1.5 processor.h
--- include/asm-parisc/processor.h	25 Sep 2003 01:07:21 -0000	1.5
+++ include/asm-parisc/processor.h	28 Sep 2003 16:58:36 -0000
@@ -109,9 +109,6 @@ extern struct cpuinfo_parisc cpu_data[NR
 
 #define CPU_HVERSION ((boot_cpu_data.hversion >> 4) & 0x0FFF)
 
-#define MCA_bus 0
-#define MCA_bus__is_a_macro /* for versions in ksyms.c */
-
 typedef struct {
 	int seg;  
 } mm_segment_t;
Index: include/asm-ppc/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ppc/processor.h,v
retrieving revision 1.5
diff -u -p -r1.5 processor.h
--- include/asm-ppc/processor.h	28 Sep 2003 04:06:18 -0000	1.5
+++ include/asm-ppc/processor.h	28 Sep 2003 16:58:37 -0000
@@ -70,12 +70,6 @@ extern void prepare_to_copy(struct task_
  */
 extern long kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro
-
 /* Lazy FPU handling on uni-processor */
 extern struct task_struct *last_task_used_math;
 extern struct task_struct *last_task_used_altivec;
Index: include/asm-ppc64/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ppc64/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-ppc64/processor.h	21 Sep 2003 19:23:30 -0000	1.2
+++ include/asm-ppc64/processor.h	28 Sep 2003 16:58:37 -0000
@@ -609,12 +609,6 @@ void release_thread(struct task_struct *
  */
 extern long kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro /* for versions in ksyms.c */
-
 /* Lazy FPU handling on uni-processor */
 extern struct task_struct *last_task_used_math;
 
Index: include/asm-sh/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-sh/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-sh/processor.h	21 Sep 2003 19:23:30 -0000	1.2
+++ include/asm-sh/processor.h	28 Sep 2003 16:58:37 -0000
@@ -166,12 +166,6 @@ extern void release_thread(struct task_s
  */
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro /* for versions in ksyms.c */
-
 /* Copy and release all segment info associated with a VM */
 #define copy_segments(p, mm)	do { } while(0)
 #define release_segments(mm)	do { } while(0)
Index: include/asm-sparc/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-sparc/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-sparc/processor.h	21 Sep 2003 19:23:31 -0000	1.2
+++ include/asm-sparc/processor.h	28 Sep 2003 16:58:37 -0000
@@ -25,12 +25,6 @@
 #include <asm/atomic.h>
 
 /*
- * Bus types
- */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro /* for versions in ksyms.c */
-
-/*
  * The sparc has no problems with write protection
  */
 #define wp_works_ok 1
Index: include/asm-sparc64/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-sparc64/processor.h,v
retrieving revision 1.4
diff -u -p -r1.4 processor.h
--- include/asm-sparc64/processor.h	21 Sep 2003 19:23:31 -0000	1.4
+++ include/asm-sparc64/processor.h	28 Sep 2003 16:58:37 -0000
@@ -21,10 +21,6 @@
 #include <asm/segment.h>
 #include <asm/page.h>
 
-/* Bus types */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro /* for versions in ksyms.c */
-
 /* The sparc has no problems with write protection */
 #define wp_works_ok 1
 #define wp_works_ok__is_a_macro /* for versions in ksyms.c */
Index: include/asm-v850/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-v850/processor.h,v
retrieving revision 1.3
diff -u -p -r1.3 processor.h
--- include/asm-v850/processor.h	21 Sep 2003 19:23:31 -0000	1.3
+++ include/asm-v850/processor.h	28 Sep 2003 16:58:37 -0000
@@ -49,12 +49,6 @@
 #define current_text_addr()	({ __label__ _l; _l: &&_l;})
 
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro /* for versions in ksyms.c */
-
 /* If you change this, you must change the associated assembly-languages
    constants defined below, THREAD_*.  */
 struct thread_struct {
Index: include/asm-x86_64/processor.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-x86_64/processor.h,v
retrieving revision 1.5
diff -u -p -r1.5 processor.h
--- include/asm-x86_64/processor.h	21 Sep 2003 19:23:32 -0000	1.5
+++ include/asm-x86_64/processor.h	28 Sep 2003 16:58:37 -0000
@@ -157,12 +157,6 @@ static inline void clear_in_cr4 (unsigne
 		:"ax");
 }
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-#define MCA_bus__is_a_macro
-
 
 /*
  * User space process size: 512GB - 1GB (default).
Index: include/linux/mca.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/mca.h,v
retrieving revision 1.3
diff -u -p -r1.3 mca.h
--- include/linux/mca.h	9 Sep 2003 20:50:51 -0000	1.3
+++ include/linux/mca.h	28 Sep 2003 16:58:37 -0000
@@ -11,17 +11,17 @@
  * are sorted out */
 #include <linux/device.h>
 
-/* get the platform specific defines */
 #ifdef CONFIG_MCA
+/* get the platform specific defines */
 #include <asm/mca.h>
-#endif
 
 /* The detection of MCA bus is done in the real mode (using BIOS).
  * The information is exported to the protected code, where this
  * variable is set to one in case MCA bus was detected.
  */
-#ifndef MCA_bus__is_a_macro
 extern int  MCA_bus;
+#else
+#define MCA_bus 0
 #endif
 
 /* This sets up an information callback for /proc/mca/slot?.  The

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
