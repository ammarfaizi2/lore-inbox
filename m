Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264782AbSJOW3s>; Tue, 15 Oct 2002 18:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSJOW3r>; Tue, 15 Oct 2002 18:29:47 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:50187 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264875AbSJOW1c>; Tue, 15 Oct 2002 18:27:32 -0400
Date: Tue, 15 Oct 2002 23:33:19 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [4/7] oprofile - NMI hook
Message-ID: <20021015223319.GD41906@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *181aFc-000DFP-00*.HlEYvAKy2k* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch provides a simple api to let oprofile hook into
the NMI interrupt for the perfctr profiler.


diff -Naur -X dontdiff linux-linus/arch/i386/kernel/i386_ksyms.c linux-linus2/arch/i386/kernel/i386_ksyms.c
--- linux-linus/arch/i386/kernel/i386_ksyms.c	Tue Oct 15 22:46:47 2002
+++ linux-linus2/arch/i386/kernel/i386_ksyms.c	Tue Oct 15 22:47:19 2002
@@ -29,6 +29,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/nmi.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
 extern spinlock_t rtc_lock;
@@ -151,6 +152,10 @@
 EXPORT_SYMBOL(flush_tlb_page);
 #endif
 
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PM)
+EXPORT_SYMBOL_GPL(set_nmi_pm_callback);
+EXPORT_SYMBOL_GPL(unset_nmi_pm_callback);
+#endif
 #ifdef CONFIG_X86_IO_APIC
 EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 #endif
@@ -169,6 +174,8 @@
 
 EXPORT_SYMBOL_GPL(register_profile_notifier);
 EXPORT_SYMBOL_GPL(unregister_profile_notifier);
+EXPORT_SYMBOL_GPL(set_nmi_callback);
+EXPORT_SYMBOL_GPL(unset_nmi_callback);
  
 #undef memcpy
 #undef memset
diff -Naur -X dontdiff linux-linus/arch/i386/kernel/nmi.c linux-linus2/arch/i386/kernel/nmi.c
--- linux-linus/arch/i386/kernel/nmi.c	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/kernel/nmi.c	Tue Oct 15 22:47:02 2002
@@ -175,6 +175,18 @@
 	return 0;
 }
 
+struct pm_dev * set_nmi_pm_callback(pm_callback callback)
+{
+	apic_pm_unregister(nmi_pmdev);
+	return apic_pm_register(PM_SYS_DEV, 0, callback);
+}
+
+void unset_nmi_pm_callback(struct pm_dev * dev)
+{
+	apic_pm_unregister(dev);
+	nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
+}
+ 
 static void nmi_pm_init(void)
 {
 	if (!nmi_pmdev)
diff -Naur -X dontdiff linux-linus/arch/i386/kernel/traps.c linux-linus2/arch/i386/kernel/traps.c
--- linux-linus/arch/i386/kernel/traps.c	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/kernel/traps.c	Tue Oct 15 22:47:02 2002
@@ -40,6 +40,7 @@
 #include <asm/debugreg.h>
 #include <asm/desc.h>
 #include <asm/i387.h>
+#include <asm/nmi.h>
 
 #include <asm/smp.h>
 #include <asm/pgalloc.h>
@@ -478,17 +479,16 @@
 		return;
 	}
 #endif
-	printk("Uhhuh. NMI received for unknown reason %02x.\n", reason);
+	printk("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
+		reason, smp_processor_id());
 	printk("Dazed and confused, but trying to continue\n");
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
-asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
+static void default_do_nmi(struct pt_regs * regs)
 {
 	unsigned char reason = inb(0x61);
-
-	++nmi_count(smp_processor_id());
-
+ 
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
 		/*
@@ -515,6 +515,33 @@
 	inb(0x71);		/* dummy */
 	outb(0x0f, 0x70);
 	inb(0x71);		/* dummy */
+}
+
+static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
+{
+	return 0;
+}
+ 
+static nmi_callback_t nmi_callback = dummy_nmi_callback;
+ 
+asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
+{
+	int cpu = smp_processor_id();
+
+	++nmi_count(cpu);
+
+	if (!nmi_callback(regs, cpu))
+		default_do_nmi(regs);
+}
+
+void set_nmi_callback(nmi_callback_t callback)
+{
+	nmi_callback = callback;
+}
+
+void unset_nmi_callback(void)
+{
+	nmi_callback = dummy_nmi_callback;
 }
 
 /*
diff -Naur -X dontdiff linux-linus/include/asm-i386/nmi.h linux-linus2/include/asm-i386/nmi.h
--- linux-linus/include/asm-i386/nmi.h	Thu Jan  1 01:00:00 1970
+++ linux-linus2/include/asm-i386/nmi.h	Tue Oct 15 22:47:02 2002
@@ -0,0 +1,49 @@
+/*
+ *  linux/include/asm-i386/nmi.h
+ */
+#ifndef ASM_NMI_H
+#define ASM_NMI_H
+
+#include <linux/pm.h>
+ 
+struct pt_regs;
+ 
+typedef int (*nmi_callback_t)(struct pt_regs * regs, int cpu);
+ 
+/** 
+ * set_nmi_callback
+ *
+ * Set a handler for an NMI. Only one handler may be
+ * set. Return 1 if the NMI was handled.
+ */
+void set_nmi_callback(nmi_callback_t callback);
+ 
+/** 
+ * unset_nmi_callback
+ *
+ * Remove the handler previously set.
+ */
+void unset_nmi_callback(void);
+ 
+#ifdef CONFIG_PM
+ 
+/** Replace the PM callback routine for NMI. */
+struct pm_dev * set_nmi_pm_callback(pm_callback callback);
+
+/** Unset the PM callback routine back to the default. */
+void unset_nmi_pm_callback(struct pm_dev * dev);
+
+#else
+
+static inline struct pm_dev * set_nmi_pm_callback(pm_callback callback)
+{
+	return 0;
+} 
+ 
+static inline void unset_nmi_pm_callback(struct pm_dev * dev)
+{
+}
+
+#endif /* CONFIG_PM */
+ 
+#endif /* ASM_NMI_H */
