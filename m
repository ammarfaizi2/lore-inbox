Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbTBNQ7A>; Fri, 14 Feb 2003 11:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTBNQ67>; Fri, 14 Feb 2003 11:58:59 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:23252 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261371AbTBNQ6o>; Fri, 14 Feb 2003 11:58:44 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15949.8847.118333.842282@laputa.namesys.com>
Date: Fri, 14 Feb 2003 20:08:31 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       John Levon <levon@movementarian.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: [PATCH]: consolidate and cleanup profiling code.
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
X-Drdoom-Fodder: passwd security drdoom root crypt CERT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

this patch moves functions from identical per-architecture
arch/*/kernel/profile.c into generic kernel/profile.c. Also, identical
{x86,parisc,ppc64,sparc64}_profile_hook()'s are all replaced by the
single kernel/profile.c:profile_hook(), which is #defined to noop in
include/linux/profile.h if CONFIG_PROFILING is not set.

John Levon okked it.

Please apply.
Nikita.
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1053  -> 1.1054 
#	arch/x86_64/kernel/x8664_ksyms.c	1.11    -> 1.12   
#	arch/i386/kernel/Makefile	1.33    -> 1.34   
#	arch/sparc64/kernel/Makefile	1.19    -> 1.20   
#	arch/ppc64/kernel/ppc_ksyms.c	1.21    -> 1.22   
#	arch/sparc64/kernel/profile.c	1.1     ->         (deleted)      
#	arch/parisc/kernel/Makefile	1.9     -> 1.10   
#	include/asm-parisc/irq.h	1.3     -> 1.4    
#	arch/parisc/kernel/time.c	1.5     -> 1.6    
#	arch/parisc/kernel/profile.c	1.1     ->         (deleted)      
#	include/linux/profile.h	1.3     -> 1.4    
#	arch/sparc64/kernel/time.c	1.20    -> 1.21   
#	arch/ppc64/kernel/profile.c	1.1     ->         (deleted)      
#	arch/x86_64/kernel/profile.c	1.2     ->         (deleted)      
#	include/asm-sparc64/irq.h	1.11    -> 1.12   
#	arch/x86_64/kernel/Makefile	1.16    -> 1.17   
#	arch/sparc64/kernel/sparc64_ksyms.c	1.36    -> 1.37   
#	arch/i386/kernel/profile.c	1.1     ->         (deleted)      
#	arch/ppc64/kernel/time.c	1.16    -> 1.17   
#	    kernel/profile.c	1.3     -> 1.4    
#	include/asm-x86_64/hw_irq.h	1.4     -> 1.5    
#	arch/ppc64/kernel/Makefile	1.19    -> 1.20   
#	include/asm-ppc64/hw_irq.h	1.7     -> 1.8    
#	include/asm-i386/hw_irq.h	1.19    -> 1.20   
#	arch/i386/kernel/i386_ksyms.c	1.43    -> 1.44   
#	arch/parisc/kernel/parisc_ksyms.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/14	god@laputa.namesys.com	1.1054
# cleanup and consolidation of the profiling code
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Fri Feb 14 20:04:35 2003
+++ b/arch/i386/kernel/Makefile	Fri Feb 14 20:04:35 2003
@@ -25,7 +25,6 @@
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
-obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Fri Feb 14 20:04:35 2003
+++ b/arch/i386/kernel/i386_ksyms.c	Fri Feb 14 20:04:35 2003
@@ -182,8 +182,6 @@
 
 EXPORT_SYMBOL(rtc_lock);
 
-EXPORT_SYMBOL_GPL(register_profile_notifier);
-EXPORT_SYMBOL_GPL(unregister_profile_notifier);
 EXPORT_SYMBOL_GPL(set_nmi_callback);
 EXPORT_SYMBOL_GPL(unset_nmi_callback);
  
diff -Nru a/arch/i386/kernel/profile.c b/arch/i386/kernel/profile.c
--- a/arch/i386/kernel/profile.c	Fri Feb 14 20:04:35 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,45 +0,0 @@
-/*
- *	linux/arch/i386/kernel/profile.c
- *
- *	(C) 2002 John Levon <levon@movementarian.org>
- *
- */
-
-#include <linux/profile.h>
-#include <linux/spinlock.h>
-#include <linux/notifier.h>
-#include <linux/irq.h>
-#include <asm/hw_irq.h> 
- 
-static struct notifier_block * profile_listeners;
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
- 
-int register_profile_notifier(struct notifier_block * nb)
-{
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_register(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
-}
-
-
-int unregister_profile_notifier(struct notifier_block * nb)
-{
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
-}
-
-
-void x86_profile_hook(struct pt_regs * regs)
-{
-	/* we would not even need this lock if
-	 * we had a global cli() on register/unregister
-	 */ 
-	read_lock(&profile_lock);
-	notifier_call_chain(&profile_listeners, 0, regs);
-	read_unlock(&profile_lock);
-}
diff -Nru a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
--- a/arch/parisc/kernel/Makefile	Fri Feb 14 20:04:35 2003
+++ b/arch/parisc/kernel/Makefile	Fri Feb 14 20:04:35 2003
@@ -16,7 +16,6 @@
 		   processor.o pdc_chassis.o
 
 obj-$(CONFIG_SMP)	+= smp.o
-obj-$(CONFIG_PROFILING)	+= profile.o
 obj-$(CONFIG_PA11)	+= pci-dma.o
 obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_MODULES)	+= module.o
diff -Nru a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
--- a/arch/parisc/kernel/parisc_ksyms.c	Fri Feb 14 20:04:35 2003
+++ b/arch/parisc/kernel/parisc_ksyms.c	Fri Feb 14 20:04:35 2003
@@ -207,10 +207,5 @@
 EXPORT_SYMBOL_NOVERS($$dyncall);
 #endif
 
-#ifdef CONFIG_PROFILING
-EXPORT_SYMBOL_GPL(register_profile_notifier);
-EXPORT_SYMBOL_GPL(unregister_profile_notifier);
-#endif
-
 #include <asm/pgtable.h>
 EXPORT_SYMBOL_NOVERS(vmalloc_start);
diff -Nru a/arch/parisc/kernel/profile.c b/arch/parisc/kernel/profile.c
--- a/arch/parisc/kernel/profile.c	Fri Feb 14 20:04:35 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,43 +0,0 @@
-/* arch/parisc/kernel/profile.c
- *
- * Almost entirely copied from ppc64 which is:
- * (C) 2002 John Levon <levon@movementarian.org>
- */
-
-#include <linux/profile.h>
-#include <linux/spinlock.h>
-#include <linux/notifier.h>
-#include <asm/irq.h>
-
-static struct notifier_block *profile_listeners;
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
-
-int register_profile_notifier(struct notifier_block *nb)
-{
-	int err;
-
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_register(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-
-	return err;
-}
-
-int unregister_profile_notifier(struct notifier_block *nb)
-{
-	int err;
-
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-
-	return err;
-}
-
-void parisc_profile_hook(struct pt_regs *regs)
-{
-	read_lock(&profile_lock);
-	notifier_call_chain(&profile_listeners, 0, regs);
-	read_unlock(&profile_lock);
-}
-
diff -Nru a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
--- a/arch/parisc/kernel/time.c	Fri Feb 14 20:04:35 2003
+++ b/arch/parisc/kernel/time.c	Fri Feb 14 20:04:35 2003
@@ -51,11 +51,7 @@
 	extern unsigned long prof_cpu_mask;
 	extern char _stext;
 
-#ifdef CONFIG_PROFILING
-	extern void parisc_profile_hook(struct pt_regs *);
-
-	parisc_profile_hook(regs);
-#endif
+	profile_hook(regs);
 
 	if (user_mode(regs))
 		return;
diff -Nru a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile	Fri Feb 14 20:04:35 2003
+++ b/arch/ppc64/kernel/Makefile	Fri Feb 14 20:04:35 2003
@@ -27,6 +27,5 @@
 
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
 obj-$(CONFIG_SMP)		+= smp.o
-obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_PPC_RTAS)		+= rtas-proc.o
diff -Nru a/arch/ppc64/kernel/ppc_ksyms.c b/arch/ppc64/kernel/ppc_ksyms.c
--- a/arch/ppc64/kernel/ppc_ksyms.c	Fri Feb 14 20:04:35 2003
+++ b/arch/ppc64/kernel/ppc_ksyms.c	Fri Feb 14 20:04:35 2003
@@ -232,8 +232,3 @@
 #endif
 
 EXPORT_SYMBOL(tb_ticks_per_usec);
-
-#ifdef CONFIG_PROFILING
-EXPORT_SYMBOL_GPL(register_profile_notifier);
-EXPORT_SYMBOL_GPL(unregister_profile_notifier);
-#endif
diff -Nru a/arch/ppc64/kernel/profile.c b/arch/ppc64/kernel/profile.c
--- a/arch/ppc64/kernel/profile.c	Fri Feb 14 20:04:35 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,42 +0,0 @@
-/*
- *	linux/arch/i386/kernel/profile.c
- *
- *	(C) 2002 John Levon <levon@movementarian.org>
- *
- */
-
-#include <linux/profile.h>
-#include <linux/spinlock.h>
-#include <linux/notifier.h>
-#include <linux/irq.h>
-#include <asm/hw_irq.h> 
- 
-static struct notifier_block * profile_listeners;
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
- 
-int register_profile_notifier(struct notifier_block * nb)
-{
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_register(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
-}
-
-
-int unregister_profile_notifier(struct notifier_block * nb)
-{
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
-}
-
-
-void ppc64_profile_hook(struct pt_regs * regs)
-{
-	read_lock(&profile_lock);
-	notifier_call_chain(&profile_listeners, 0, regs);
-	read_unlock(&profile_lock);
-}
diff -Nru a/arch/ppc64/kernel/time.c b/arch/ppc64/kernel/time.c
--- a/arch/ppc64/kernel/time.c	Fri Feb 14 20:04:35 2003
+++ b/arch/ppc64/kernel/time.c	Fri Feb 14 20:04:35 2003
@@ -110,11 +110,8 @@
 	unsigned long nip;
 	extern unsigned long prof_cpu_mask;
 	extern char _stext;
-#ifdef CONFIG_PROFILING
-	extern void ppc64_profile_hook(struct pt_regs *);
 
-	ppc64_profile_hook(regs);
-#endif
+	profile_hook(regs);
 
 	if (user_mode(regs))
 		return;
diff -Nru a/arch/sparc64/kernel/Makefile b/arch/sparc64/kernel/Makefile
--- a/arch/sparc64/kernel/Makefile	Fri Feb 14 20:04:35 2003
+++ b/arch/sparc64/kernel/Makefile	Fri Feb 14 20:04:35 2003
@@ -15,7 +15,6 @@
 obj-$(CONFIG_PCI)	 += ebus.o isa.o pci_common.o pci_iommu.o \
 			    pci_psycho.o pci_sabre.o pci_schizo.o
 obj-$(CONFIG_SMP)	 += smp.o trampoline.o
-obj-$(CONFIG_PROFILING)  += profile.o
 obj-$(CONFIG_SPARC32_COMPAT) += sys32.o sys_sparc32.o signal32.o ioctl32.o
 obj-$(CONFIG_BINFMT_ELF32) += binfmt_elf32.o
 obj-$(CONFIG_BINFMT_AOUT32) += binfmt_aout32.o
diff -Nru a/arch/sparc64/kernel/profile.c b/arch/sparc64/kernel/profile.c
--- a/arch/sparc64/kernel/profile.c	Fri Feb 14 20:04:35 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,42 +0,0 @@
-/* arch/sparc64/kernel/profile.c
- *
- * Almost entirely copied from ppc64 which is:
- * (C) 2002 John Levon <levon@movementarian.org>
- */
-
-#include <linux/profile.h>
-#include <linux/spinlock.h>
-#include <linux/notifier.h>
-#include <asm/irq.h>
-
-static struct notifier_block *profile_listeners;
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
-
-int register_profile_notifier(struct notifier_block *nb)
-{
-	int err;
-
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_register(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-
-	return err;
-}
-
-int unregister_profile_notifier(struct notifier_block *nb)
-{
-	int err;
-
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-
-	return err;
-}
-
-void sparc64_profile_hook(struct pt_regs *regs)
-{
-	read_lock(&profile_lock);
-	notifier_call_chain(&profile_listeners, 0, regs);
-	read_unlock(&profile_lock);
-}
diff -Nru a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
--- a/arch/sparc64/kernel/sparc64_ksyms.c	Fri Feb 14 20:04:35 2003
+++ b/arch/sparc64/kernel/sparc64_ksyms.c	Fri Feb 14 20:04:35 2003
@@ -374,8 +374,3 @@
 
 /* for ns8703 */
 EXPORT_SYMBOL(ns87303_lock);
-
-#ifdef CONFIG_PROFILING
-EXPORT_SYMBOL_GPL(register_profile_notifier);
-EXPORT_SYMBOL_GPL(unregister_profile_notifier);
-#endif
diff -Nru a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
--- a/arch/sparc64/kernel/time.c	Fri Feb 14 20:04:35 2003
+++ b/arch/sparc64/kernel/time.c	Fri Feb 14 20:04:35 2003
@@ -88,11 +88,8 @@
 {
 	unsigned long pc = regs->tpc;
 	unsigned long o7 = regs->u_regs[UREG_RETPC];
-#ifdef CONFIG_PROFILING
-	extern void sparc64_profile_hook(struct pt_regs *);
 
-	sparc64_profile_hook(regs);
-#endif
+	profile_hook(regs);
 
 	if (user_mode(regs))
 		return;
diff -Nru a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
--- a/arch/x86_64/kernel/Makefile	Fri Feb 14 20:04:35 2003
+++ b/arch/x86_64/kernel/Makefile	Fri Feb 14 20:04:35 2003
@@ -22,8 +22,6 @@
 obj-$(CONFIG_GART_IOMMU) += pci-gart.o aperture.o
 obj-$(CONFIG_DUMMY_IOMMU) += pci-nommu.o
 obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_PROFILING)         += profile.o
-
 
 $(obj)/bootflag.c: 
 	@ln -sf ../../i386/kernel/bootflag.c $(obj)/bootflag.c
diff -Nru a/arch/x86_64/kernel/profile.c b/arch/x86_64/kernel/profile.c
--- a/arch/x86_64/kernel/profile.c	Fri Feb 14 20:04:35 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,45 +0,0 @@
-/*
- *	linux/arch/x86_64/kernel/profile.c
- *
- *	(C) 2002 John Levon <levon@movementarian.org>
- *
- */
-
-#include <linux/profile.h>
-#include <linux/spinlock.h>
-#include <linux/notifier.h>
-#include <linux/irq.h>
-#include <asm/hw_irq.h> 
- 
-static struct notifier_block * profile_listeners;
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
- 
-int register_profile_notifier(struct notifier_block * nb)
-{
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_register(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
-}
-
-
-int unregister_profile_notifier(struct notifier_block * nb)
-{
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
-}
-
-
-void x86_profile_hook(struct pt_regs * regs)
-{
-	/* we would not even need this lock if
-	 * we had a global cli() on register/unregister
-	 */ 
-	read_lock(&profile_lock);
-	notifier_call_chain(&profile_listeners, 0, regs);
-	read_unlock(&profile_lock);
-}
diff -Nru a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
--- a/arch/x86_64/kernel/x8664_ksyms.c	Fri Feb 14 20:04:35 2003
+++ b/arch/x86_64/kernel/x8664_ksyms.c	Fri Feb 14 20:04:35 2003
@@ -132,8 +132,6 @@
 
 EXPORT_SYMBOL(rtc_lock);
 
-EXPORT_SYMBOL_GPL(register_profile_notifier);
-EXPORT_SYMBOL_GPL(unregister_profile_notifier);
 EXPORT_SYMBOL_GPL(set_nmi_callback);
 EXPORT_SYMBOL_GPL(unset_nmi_callback);
 
diff -Nru a/include/asm-i386/hw_irq.h b/include/asm-i386/hw_irq.h
--- a/include/asm-i386/hw_irq.h	Fri Feb 14 20:04:35 2003
+++ b/include/asm-i386/hw_irq.h	Fri Feb 14 20:04:35 2003
@@ -76,11 +76,8 @@
 {
 	unsigned long eip;
 	extern unsigned long prof_cpu_mask;
-#ifdef CONFIG_PROFILING
-	extern void x86_profile_hook(struct pt_regs *);
  
-	x86_profile_hook(regs);
-#endif
+	profile_hook(regs);
  
 	if (user_mode(regs))
 		return;
@@ -108,27 +105,6 @@
 		eip = prof_len-1;
 	atomic_inc((atomic_t *)&prof_buffer[eip]);
 }
- 
-struct notifier_block;
- 
-#ifdef CONFIG_PROFILING
- 
-int register_profile_notifier(struct notifier_block * nb);
-int unregister_profile_notifier(struct notifier_block * nb);
-
-#else
-
-static inline int register_profile_notifier(struct notifier_block * nb)
-{
-	return -ENOSYS;
-}
-
-static inline int unregister_profile_notifier(struct notifier_block * nb)
-{
-	return -ENOSYS;
-}
-
-#endif /* CONFIG_PROFILING */
  
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
diff -Nru a/include/asm-parisc/irq.h b/include/asm-parisc/irq.h
--- a/include/asm-parisc/irq.h	Fri Feb 14 20:04:35 2003
+++ b/include/asm-parisc/irq.h	Fri Feb 14 20:04:35 2003
@@ -95,21 +95,4 @@
 /* soft power switch support (power.c) */
 extern struct tasklet_struct power_tasklet;
 
-struct notifier_block;
-
-#ifdef CONFIG_PROFILING
-int register_profile_notifier(struct notifier_block *nb);
-int unregister_profile_notifier(struct notifier_block *nb);
-#else
-static inline int register_profile_notifier(struct notifier_block *nb)
-{
-    return -ENOSYS;
-}
-
-static inline int unregister_profile_notifier(struct notifier_block *nb)
-{
-    return -ENOSYS;
-}
-#endif
-
 #endif	/* _ASM_PARISC_IRQ_H */
diff -Nru a/include/asm-ppc64/hw_irq.h b/include/asm-ppc64/hw_irq.h
--- a/include/asm-ppc64/hw_irq.h	Fri Feb 14 20:04:35 2003
+++ b/include/asm-ppc64/hw_irq.h	Fri Feb 14 20:04:35 2003
@@ -81,26 +81,5 @@
 struct hw_interrupt_type;
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
  
-struct notifier_block;
- 
-#ifdef CONFIG_PROFILING
- 
-int register_profile_notifier(struct notifier_block * nb);
-int unregister_profile_notifier(struct notifier_block * nb);
-
-#else
-
-static inline int register_profile_notifier(struct notifier_block * nb)
-{
-	return -ENOSYS;
-}
-
-static inline int unregister_profile_notifier(struct notifier_block * nb)
-{
-	return -ENOSYS;
-}
-
-#endif /* CONFIG_PROFILING */
- 
 #endif /* _PPC64_HW_IRQ_H */
 #endif /* __KERNEL__ */
diff -Nru a/include/asm-sparc64/irq.h b/include/asm-sparc64/irq.h
--- a/include/asm-sparc64/irq.h	Fri Feb 14 20:04:35 2003
+++ b/include/asm-sparc64/irq.h	Fri Feb 14 20:04:35 2003
@@ -157,25 +157,4 @@
 	return retval;
 }
 
-struct notifier_block;
- 
-#ifdef CONFIG_PROFILING
- 
-int register_profile_notifier(struct notifier_block *nb);
-int unregister_profile_notifier(struct notifier_block *nb);
-
-#else
-
-static inline int register_profile_notifier(struct notifier_block *nb)
-{
-	return -ENOSYS;
-}
-
-static inline int unregister_profile_notifier(struct notifier_block *nb)
-{
-	return -ENOSYS;
-}
-
-#endif /* CONFIG_PROFILING */
-
 #endif
diff -Nru a/include/asm-x86_64/hw_irq.h b/include/asm-x86_64/hw_irq.h
--- a/include/asm-x86_64/hw_irq.h	Fri Feb 14 20:04:35 2003
+++ b/include/asm-x86_64/hw_irq.h	Fri Feb 14 20:04:35 2003
@@ -135,11 +135,9 @@
 	unsigned long rip;
 	extern unsigned long prof_cpu_mask;
 	extern char _stext;
-#ifdef CONFIG_PROFILING
-	extern void x86_profile_hook(struct pt_regs *);
  
-	x86_profile_hook(regs);
-#endif
+	profile_hook(regs);
+
 	if (user_mode(regs))
 		return;
 	if (!prof_buffer)
@@ -166,26 +164,6 @@
 	atomic_inc((atomic_t *)&prof_buffer[rip]);
 }
 
-struct notifier_block;
- 
-#ifdef CONFIG_PROFILING
-
-int register_profile_notifier(struct notifier_block * nb);
-int unregister_profile_notifier(struct notifier_block * nb);
-
-#else
-
-static inline int register_profile_notifier(struct notifier_block * nb)
-{
-	return -ENOSYS;
-}
-
-static inline int unregister_profile_notifier(struct notifier_block * nb)
-{
-	return -ENOSYS;
-}
-
-#endif /* CONFIG_PROFILING */
 #ifdef CONFIG_SMP /*more of this file should probably be ifdefed SMP */
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
 	if (IO_APIC_IRQ(i))
diff -Nru a/include/linux/profile.h b/include/linux/profile.h
--- a/include/linux/profile.h	Fri Feb 14 20:04:35 2003
+++ b/include/linux/profile.h	Fri Feb 14 20:04:35 2003
@@ -45,6 +45,12 @@
 
 int profile_event_unregister(enum profile_type, struct notifier_block * n);
  
+int register_profile_notifier(struct notifier_block * nb);
+int unregister_profile_notifier(struct notifier_block * nb);
+ 
+/* profiling hook activated on each timer interrupt */
+void profile_hook(struct pt_regs * regs);
+
 #else
 
 static inline int profile_event_register(enum profile_type t, struct notifier_block * n)
@@ -60,7 +66,19 @@
 #define profile_exit_task(a) do { } while (0)
 #define profile_exec_unmap(a) do { } while (0)
 #define profile_exit_mmap(a) do { } while (0)
- 
+
+static inline int register_profile_notifier(struct notifier_block * nb)
+{
+	return -ENOSYS;
+}
+
+static inline int unregister_profile_notifier(struct notifier_block * nb)
+{
+	return -ENOSYS;
+}
+
+#define profile_hook(regs) do { } while (0)
+
 #endif /* CONFIG_PROFILING */
  
 #endif /* __KERNEL__ */
diff -Nru a/kernel/profile.c b/kernel/profile.c
--- a/kernel/profile.c	Fri Feb 14 20:04:35 2003
+++ b/kernel/profile.c	Fri Feb 14 20:04:35 2003
@@ -119,6 +119,39 @@
 	return err;
 }
 
+static struct notifier_block * profile_listeners;
+static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
+ 
+int register_profile_notifier(struct notifier_block * nb)
+{
+	int err;
+	write_lock_irq(&profile_lock);
+	err = notifier_chain_register(&profile_listeners, nb);
+	write_unlock_irq(&profile_lock);
+	return err;
+}
+
+
+int unregister_profile_notifier(struct notifier_block * nb)
+{
+	int err;
+	write_lock_irq(&profile_lock);
+	err = notifier_chain_unregister(&profile_listeners, nb);
+	write_unlock_irq(&profile_lock);
+	return err;
+}
+
+
+void profile_hook(struct pt_regs * regs)
+{
+	read_lock(&profile_lock);
+	notifier_call_chain(&profile_listeners, 0, regs);
+	read_unlock(&profile_lock);
+}
+
+EXPORT_SYMBOL_GPL(register_profile_notifier);
+EXPORT_SYMBOL_GPL(unregister_profile_notifier);
+
 #endif /* CONFIG_PROFILING */
 
 EXPORT_SYMBOL_GPL(profile_event_register);
