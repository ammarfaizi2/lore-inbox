Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSGVN0Y>; Mon, 22 Jul 2002 09:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317078AbSGVN0Y>; Mon, 22 Jul 2002 09:26:24 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29593 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316666AbSGVN0J>;
	Mon, 22 Jul 2002 09:26:09 -0400
Date: Mon, 22 Jul 2002 15:27:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
Subject: [patch] big IRQ lock removal, 2.5.27-D6
Message-ID: <Pine.LNX.4.44.0207221513210.7711-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the following delta patch is against the current BK tree + the
cli-sti-cleanup-2.5.27-A2 patch. (will redo this patch if there's any
conceptual or practial problem with the cli-sti-cleanup patch, right now
this tree is the most straightforward working point for me.)

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-D6

Changes:

 - tulip synchronize_irq fix from wli.

 - qlogicisp driver fixes from wli.

 - have one central point of cli()/sti() compability defines, in 
   include/linux/interrupt.h. Remove all the per-arch defines from
   include/asm-*/system.h.

 - updated Documentation/cli-sti-removal.txt.

(patch also attached) 

It compiles, boots & works on x86 SMP and UP.

	Ingo

--- linux/drivers/net/tulip/de2104x.c.orig	Sun Jun  9 07:28:18 2002
+++ linux/drivers/net/tulip/de2104x.c	Mon Jul 22 14:53:51 2002
@@ -1455,7 +1455,7 @@
 	/* Update the error counts. */
 	__de_get_stats(de);
 
-	synchronize_irq();
+	synchronize_irq(dev->irq);
 	de_clean_rings(de);
 
 	de_init_hw(de);
--- linux/drivers/scsi/qlogicisp.c.orig	Mon Jul 22 14:52:36 2002
+++ linux/drivers/scsi/qlogicisp.c	Mon Jul 22 14:53:51 2002
@@ -84,14 +84,11 @@
 {								\
 	unsigned long flags;					\
 								\
-	save_flags(flags);					\
-	cli();							\
 	trace.buf[trace.next].name  = (w);			\
 	trace.buf[trace.next].time  = jiffies;			\
 	trace.buf[trace.next].index = (i);			\
 	trace.buf[trace.next].addr  = (long) (a);		\
 	trace.next = (trace.next + 1) & (TRACE_BUF_LEN - 1);	\
-	restore_flags(flags);					\
 }
 
 #else
@@ -1704,9 +1701,6 @@
 
 	ENTER("isp1020_load_parameters");
 
-	save_flags(flags);
-	cli();
-
 	hwrev = isp_inw(host, ISP_CFG0) & ISP_CFG0_HWMSK;
 	isp_cfg1 = ISP_CFG1_F64 | ISP_CFG1_BENAB;
 	if (hwrev == ISP_CFG0_1040A) {
@@ -1724,7 +1718,6 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
 		printk("qlogicisp : set initiator id failure\n");
 		return 1;
 	}
@@ -1736,7 +1729,6 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
 		printk("qlogicisp : set retry count failure\n");
 		return 1;
 	}
@@ -1747,7 +1739,6 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
 		printk("qlogicisp : async data setup time failure\n");
 		return 1;
 	}
@@ -1759,7 +1750,6 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
 		printk("qlogicisp : set active negation state failure\n");
 		return 1;
 	}
@@ -1771,7 +1761,6 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
 		printk("qlogicisp : set pci control parameter failure\n");
 		return 1;
 	}
@@ -1782,7 +1771,6 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
 		printk("qlogicisp : set tag age limit failure\n");
 		return 1;
 	}
@@ -1793,7 +1781,6 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
 		printk("qlogicisp : set selection timeout failure\n");
 		return 1;
 	}
@@ -1812,7 +1799,6 @@
 		isp1020_mbox_command(host, param);
 
 		if (param[0] != MBOX_COMMAND_COMPLETE) {
-			restore_flags(flags);
 			printk("qlogicisp : set target parameter failure\n");
 			return 1;
 		}
@@ -1827,7 +1813,6 @@
 			isp1020_mbox_command(host, param);
 
 			if (param[0] != MBOX_COMMAND_COMPLETE) {
-				restore_flags(flags);
 				printk("qlogicisp : set device queue "
 				       "parameter failure\n");
 				return 1;
@@ -1854,7 +1839,6 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
 		printk("qlogicisp : set response queue failure\n");
 		return 1;
 	}
@@ -1879,12 +1863,9 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
 		printk("qlogicisp : set request queue failure\n");
 		return 1;
 	}
-
-	restore_flags(flags);
 
 	LEAVE("isp1020_load_parameters");
 
--- linux/include/linux/interrupt.h.orig	Mon Jul 22 15:06:39 2002
+++ linux/include/linux/interrupt.h	Mon Jul 22 15:05:48 2002
@@ -44,6 +44,16 @@
 #include <asm/hardirq.h>
 #include <asm/softirq.h>
 
+/*
+ * Temporary defines for UP kernels, until all code gets fixed.
+ */
+#if !CONFIG_SMP
+# define cli()			irq_off()
+# define sti()			irq_on()
+# define save_flags(x)		irq_save(x)
+# define restore_flags(x)	irq_restore(x)
+# define save_and_cli(x)	irq_save_off(x)
+#endif
 
 
 /* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
--- linux/include/asm-ppc64/system.h.orig	Mon Jul 22 15:08:15 2002
+++ linux/include/asm-ppc64/system.h	Mon Jul 22 15:09:27 2002
@@ -114,16 +114,6 @@
 struct pt_regs;
 extern void dump_regs(struct pt_regs *);
 
-#if !CONFIG_SMP
-
-#define cli()			irq_off()
-#define sti()			irq_on()
-#define save_flags(flags)	irq_save(flags)
-#define restore_flags(flags)	irq_restore(flags)
-#define save_and_cli(flags)	irq_save_off(flags)
-
-#endif
-
 static __inline__ int __is_processor(unsigned long pv)
 {
       unsigned long pvr;
--- linux/include/asm-ia64/system.h.orig	Mon Jul 22 15:08:14 2002
+++ linux/include/asm-ia64/system.h	Mon Jul 22 15:09:06 2002
@@ -172,14 +172,6 @@
 #define irq_save(flags)		__asm__ __volatile__ ("mov %0=psr" : "=r" (flags) :: "memory")
 #define irq_restore(flags)	irq_restore(flags)
 
-#if !CONFIG_SMP
-# define cli()			irq_off()
-# define sti()			irq_on()
-# define save_flags(flags)	irq_save(flags)
-# define restore_flags(flags)	irq_restore(flags)
-# define save_and_cli(flags)	irq_save_off(flags)
-#endif /* !CONFIG_SMP */
-
 /*
  * Force an unresolved reference if someone tries to use
  * ia64_fetch_and_add() with a bad value.
--- linux/include/asm-x86_64/system.h.orig	Mon Jul 22 15:08:15 2002
+++ linux/include/asm-x86_64/system.h	Mon Jul 22 15:09:56 2002
@@ -249,15 +249,6 @@
 
 #define irq_save_off(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# irq_save_off \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
 
-#if !CONFIG_SMP
-
-#define cli() irq_off()
-#define sti() irq_on()
-#define save_flags(x) irq_save(x)
-#define restore_flags(x) irq_restore(x)
-
-#endif
-
 /* Default simics "magic" breakpoint */
 #define icebp() asm volatile("xchg %%bx,%%bx" ::: "ebx")
 
--- linux/include/asm-ppc/system.h.orig	Mon Jul 22 15:08:15 2002
+++ linux/include/asm-ppc/system.h	Mon Jul 22 15:09:24 2002
@@ -101,16 +101,6 @@
 struct pt_regs;
 extern void dump_regs(struct pt_regs *);
 
-#if !CONFIG_SMP
-
-#define cli()			irq_off()
-#define sti()			irq_on()
-#define save_flags(flags)	irq_save(flags)
-#define restore_flags(flags)	irq_restore(flags)
-#define save_and_cli(flags)	irq_save_off(flags)
-
-#endif
-
 static __inline__ unsigned long
 xchg_u32(volatile void *p, unsigned long val)
 {
--- linux/include/asm-s390x/system.h.orig	Mon Jul 22 15:08:15 2002
+++ linux/include/asm-s390x/system.h	Mon Jul 22 15:09:41 2002
@@ -225,11 +225,6 @@
 
 #if !CONFIG_SMP
 
-#define cli() irq_off()
-#define sti() irq_on()
-#define save_flags(x) irq_save(x)
-#define restore_flags(x) irq_restore(x)
-
 #define ctl_set_bit(cr, bit) __ctl_set_bit(cr, bit)
 #define ctl_clear_bit(cr, bit) __ctl_clear_bit(cr, bit)
 
--- linux/include/asm-arm/system.h.orig	Mon Jul 22 15:08:14 2002
+++ linux/include/asm-arm/system.h	Mon Jul 22 15:07:14 2002
@@ -88,13 +88,6 @@
 #define smp_rmb()		barrier()
 #define smp_wmb()		barrier()
 
-#define cli()			irq_off()
-#define sti()			irq_on()
-#define clf()			__clf()
-#define stf()			__stf()
-#define save_flags(x)		irq_save(x)
-#define restore_flags(x)	irq_restore(x)
-
 #endif /* CONFIG_SMP */
 
 #endif /* __KERNEL__ */
--- linux/include/asm-m68k/system.h.orig	Mon Jul 22 15:08:14 2002
+++ linux/include/asm-m68k/system.h	Mon Jul 22 15:09:10 2002
@@ -62,14 +62,6 @@
 #define irq_restore(x) asm volatile ("movew %0,%%sr": :"d" (x) : "memory")
 #define irq_save_off(x)	({ irq_save(x); irq_off(); })
 
-#if !CONFIG_SMP
-#define cli()			irq_off()
-#define sti()			irq_on()
-#define save_flags(x)		irq_save(x)
-#define restore_flags(x)	irq_restore(x)
-#define save_and_cli(flags)	do { save_flags(flags); cli(); } while(0)
-#endif
-
 /*
  * Force strict CPU ordering.
  * Not really required on m68k...
--- linux/include/asm-mips/system.h.orig	Mon Jul 22 15:08:14 2002
+++ linux/include/asm-mips/system.h	Mon Jul 22 15:09:13 2002
@@ -115,16 +115,6 @@
 		: "$1", "memory");					\
 } while(0)
 
-#if !CONFIG_SMP
-
-#  define sti() irq_on()
-#  define cli() irq_off()
-#  define save_flags(x) irq_save(x)
-#  define save_and_cli(x) irq_save_off(x)
-#  define restore_flags(x) irq_restore(x)
-
-#endif
-
 /*
  * These are probably defined overly paranoid ...
  */
--- linux/include/asm-parisc/system.h.orig	Mon Jul 22 15:08:14 2002
+++ linux/include/asm-parisc/system.h	Mon Jul 22 15:09:21 2002
@@ -72,13 +72,6 @@
 #define irq_restore(x) \
 	__asm__ __volatile__("mtsm %0" : : "r" (x) : "memory" )
 
-#if !CONFIG_SMP
-#define cli() irq_off()
-#define sti() irq_on()
-#define save_flags(x) irq_save(x)
-#define restore_flags(x) irq_restore(x)
-#endif
-
 
 #define mfctl(reg)	({		\
 	unsigned long cr;		\
--- linux/include/asm-s390/system.h.orig	Mon Jul 22 15:08:15 2002
+++ linux/include/asm-s390/system.h	Mon Jul 22 15:09:31 2002
@@ -212,18 +212,6 @@
 
 #define irq_save_off(x)	((x) = irq_off())
 
-#if !CONFIG_SMP
-
-#define cli()			irq_off()
-#define sti()			irq_on()
-#define save_flags(x)		irq_save(x)
-#define restore_flags(x)	irq_restore(x)
-
-#define ctl_set_bit(cr, bit) __ctl_set_bit(cr, bit)
-#define ctl_clear_bit(cr, bit) __ctl_clear_bit(cr, bit)
-
-#endif
-
 #ifdef __KERNEL__
 extern struct task_struct *resume(void *, void *);
 
--- linux/include/asm-sparc64/system.h.orig	Mon Jul 22 15:08:15 2002
+++ linux/include/asm-sparc64/system.h	Mon Jul 22 15:09:52 2002
@@ -66,14 +66,6 @@
 #define irq_save_off(flags)	((flags) = read_pil_and_cli())
 #define irq_restore(flags)	setipl((flags))
 
-#if !CONFIG_SMP
-#define cli() irq_off()
-#define sti() irq_on()
-#define save_flags(x) irq_save(x)
-#define restore_flags(x) irq_restore(x)
-#define save_and_cli(x) irq_save_off(x)
-#endif
-
 #define nop() 		__asm__ __volatile__ ("nop")
 
 #define membar(type)	__asm__ __volatile__ ("membar " type : : : "memory");
--- linux/include/asm-alpha/system.h.orig	Mon Jul 22 15:08:14 2002
+++ linux/include/asm-alpha/system.h	Mon Jul 22 15:07:06 2002
@@ -309,16 +309,6 @@
 #define irq_save_off(flags)	do { (flags) = swpipl(IPL_MAX); barrier(); } while(0)
 #define irq_restore(flags)	do { barrier(); setipl(flags); barrier(); } while(0)
 
-#if !CONFIG_SMP
-
-#define cli()			irq_off()
-#define sti()			irq_on()
-#define save_flags(flags)	irq_save(flags)
-#define save_and_cli(flags)	irq_save_off(flags)
-#define restore_flags(flags)	irq_restore(flags)
-
-#endif /* CONFIG_SMP */
-
 /*
  * TB routines..
  */
--- linux/include/asm-i386/system.h.orig	Mon Jul 22 15:08:14 2002
+++ linux/include/asm-i386/system.h	Mon Jul 22 15:09:03 2002
@@ -321,17 +321,6 @@
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 
 /*
- * Compatibility macros - they will be removed after some time.
- */
-#if !CONFIG_SMP
-# define sti() irq_on()
-# define cli() irq_off()
-# define save_flags(flags) irq_save(flags)
-# define restore_flags(flags) irq_restore(flags)
-# define save_flags_cli(flags) irq_save_off(flags)
-#endif
-
-/*
  * disable hlt during certain critical i/o operations
  */
 #define HAVE_DISABLE_HLT
--- linux/include/asm-sparc/system.h.orig	Mon Jul 22 15:08:15 2002
+++ linux/include/asm-sparc/system.h	Mon Jul 22 15:09:49 2002
@@ -245,16 +245,6 @@
 #define irq_save_off(flags)	((flags) = read_psr_and_cli())
 #define irq_restore(flags)	setipl((flags))
 
-#if !CONFIG_SMP
-
-#define cli() irq_off()
-#define sti() irq_on()
-#define save_flags(x) irq_save(x)
-#define restore_flags(x) irq_restore(x)
-#define save_and_cli(x) irq_save_off(x)
-
-#endif
-
 /* XXX Change this if we ever use a PSO mode kernel. */
 #define mb()	__asm__ __volatile__ ("" : : : "memory")
 #define rmb()	mb()
--- linux/include/asm-cris/system.h.orig	Mon Jul 22 15:08:14 2002
+++ linux/include/asm-cris/system.h	Mon Jul 22 15:08:52 2002
@@ -72,14 +72,6 @@
 
 #endif
 
-#if !CONFIG_SMP
-#define cli() irq_off()
-#define sti() irq_on()
-#define save_flags(x) irq_save(x)
-#define restore_flags(x) irq_restore(x)
-#define save_and_cli(x) do { irq_save(x); cli(); } while(0)
-#endif
-
 static inline unsigned long __xchg(unsigned long x, void * ptr, int size)
 {
   /* since Etrax doesn't have any atomic xchg instructions, we need to disable
--- linux/include/asm-mips64/system.h.orig	Mon Jul 22 15:08:14 2002
+++ linux/include/asm-mips64/system.h	Mon Jul 22 15:09:17 2002
@@ -106,16 +106,6 @@
 		: "$1", "memory");					\
 } while(0)
 
-#if !CONFIG_SMP
-
-#define cli() irq_off()
-#define sti() irq_on()
-#define save_flags(x) irq_save(x)
-#define restore_flags(x) irq_restore(x)
-#define save_and_cli(x) irq_save_off(x)
-
-#endif
-
 /*
  * These are probably defined overly paranoid ...
  */
--- linux/include/asm-sh/system.h.orig	Mon Jul 22 15:08:15 2002
+++ linux/include/asm-sh/system.h	Mon Jul 22 15:09:45 2002
@@ -215,16 +215,6 @@
 		: "=&r" (__dummy));			\
 } while (0)
 
-#if !CONFIG_SMP
-
-#define cli() irq_off()
-#define sti() irq_on()
-#define save_flags(x) irq_save(x)
-#define save_and_cli(x) x = irq_save_off()
-#define restore_flags(x) irq_restore(x)
-
-#endif
-
 static __inline__ unsigned long xchg_u32(volatile int * m, unsigned long val)
 {
 	unsigned long flags, retval;
--- linux/Documentation/cli-sti-removal.txt.orig	Mon Jul 22 15:12:47 2002
+++ linux/Documentation/cli-sti-removal.txt	Mon Jul 22 15:14:08 2002
@@ -2,10 +2,10 @@
 #### cli()/sti() removal guide, started by Ingo Molnar <mingo@redhat.com>
 
 
-as of 2.5.28, four popular macros have been removed on SMP, and
+as of 2.5.28, five popular macros have been removed on SMP, and
 are being phased out on UP:
 
- cli(), sti(), save_flags(flags), restore_flags(flags)
+ cli(), sti(), save_flags(flags), save_flags_cli(flags), restore_flags(flags)
 
 until now it was possible to protect driver code against interrupt
 handlers via a cli(), but from now on other, more lightweight methods
@@ -89,16 +89,18 @@
  
 
 to make the transition easier, we've still kept the cli(), sti(),
-save_flags() and restore_flags() macros defined on UP systems - but
-their usage will be phased out until the 2.6 kernel is released.
+save_flags(), save_flags_cli() and restore_flags() macros defined
+on UP systems - but their usage will be phased out until 2.6 is
+released.
 
 drivers that want to disable local interrupts (interrupts on the
-current CPU), can use the following four macros:
+current CPU), can use the following five macros:
 
-  irq_off(), irq_on(), irq_save(flags), irq_restore(flags)
+  irq_off(), irq_on(), irq_save(flags), irq_save_off(flags), irq_restore(flags)
 
 but beware, their meaning and semantics are much simpler, far from
-that of cli(), sti(), save_flags(flags) and restore_flags(flags).
+that of the old cli(), sti(), save_flags(flags) and restore_flags(flags)
+SMP meaning.
 
 
 another related change is that synchronize_irq() now takes a parameter:



