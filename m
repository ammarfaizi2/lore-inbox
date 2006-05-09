Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWEIU5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWEIU5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWEIU52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:57:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15069 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750793AbWEIU5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:57:14 -0400
From: dzickus <dzickus@redhat.com>
Message-Id: <20060509205958.146459000@drseuss.boston.redhat.com>
References: <20060509205035.446349000@drseuss.boston.redhat.com>
User-Agent: quilt/0.45-1
Date: Tue, 09 May 2006 16:50:42 -0400
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, oprofile-list@lists.sourceforge.net, dzickus@redhat.com
Subject: [patch 7/8] Remove un/set_nmi_callback and reserve/release_lapic_nmi functions
Content-Disposition: inline; filename=nmi-x86-remove-callback.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Removes the un/set_nmi_callback and reserve/release_lapic_nmi functions as
they are no longer needed.  The various subsystems are modified to register
with the die_notifier instead. 

Signed-off-by:  Don Zickus <dzickus@redhat.com>

Index: linux-don/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/x86_64/kernel/nmi.c
+++ linux-don/arch/x86_64/kernel/nmi.c
@@ -42,20 +42,6 @@ static DEFINE_PER_CPU(unsigned, evntsel_
  */
 #define NMI_MAX_COUNTER_BITS 66
 
-/*
- * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
- * - it may be reserved by some other driver, or not
- * - when not reserved by some other driver, it may be used for
- *   the NMI watchdog, or not
- *
- * This is maintained separately from nmi_active because the NMI
- * watchdog may also be driven from the I/O APIC timer.
- */
-static DEFINE_SPINLOCK(lapic_nmi_owner_lock);
-static unsigned int lapic_nmi_owner;
-#define LAPIC_NMI_WATCHDOG	(1<<0)
-#define LAPIC_NMI_RESERVED	(1<<1)
-
 /* nmi_active:
  * >0: the lapic NMI watchdog is active, but can be disabled
  * <0: the lapic NMI watchdog has not been set up, and cannot
@@ -322,33 +308,6 @@ static void enable_lapic_nmi_watchdog(vo
 	touch_nmi_watchdog();
 }
 
-int reserve_lapic_nmi(void)
-{
-	unsigned int old_owner;
-
-	spin_lock(&lapic_nmi_owner_lock);
-	old_owner = lapic_nmi_owner;
-	lapic_nmi_owner |= LAPIC_NMI_RESERVED;
-	spin_unlock(&lapic_nmi_owner_lock);
-	if (old_owner & LAPIC_NMI_RESERVED)
-		return -EBUSY;
-	if (old_owner & LAPIC_NMI_WATCHDOG)
-		disable_lapic_nmi_watchdog();
-	return 0;
-}
-
-void release_lapic_nmi(void)
-{
-	unsigned int new_owner;
-
-	spin_lock(&lapic_nmi_owner_lock);
-	new_owner = lapic_nmi_owner & ~LAPIC_NMI_RESERVED;
-	lapic_nmi_owner = new_owner;
-	spin_unlock(&lapic_nmi_owner_lock);
-	if (new_owner & LAPIC_NMI_WATCHDOG)
-		enable_lapic_nmi_watchdog();
-}
-
 void disable_timer_nmi_watchdog(void)
 {
 	BUG_ON(nmi_watchdog != NMI_IO_APIC);
@@ -763,13 +722,6 @@ done:
 	return rc;
 }
 
-static __kprobes int dummy_nmi_callback(struct pt_regs * regs, int cpu)
-{
-	return 0;
-}
- 
-static nmi_callback_t nmi_callback = dummy_nmi_callback;
- 
 asmlinkage __kprobes void do_nmi(struct pt_regs * regs, long error_code)
 {
 	nmi_enter();
@@ -780,18 +732,11 @@ asmlinkage __kprobes void do_nmi(struct 
 
 int do_nmi_callback(struct pt_regs * regs, int cpu)
 {
-	return rcu_dereference(nmi_callback)(regs, cpu);
-}
-
-void set_nmi_callback(nmi_callback_t callback)
-{
-	vmalloc_sync_all();
-	rcu_assign_pointer(nmi_callback, callback);
-}
-
-void unset_nmi_callback(void)
-{
-	nmi_callback = dummy_nmi_callback;
+#ifdef CONFIG_SYSCTL
+	if (unknown_nmi_panic)
+		return unknown_nmi_panic_callback(regs, cpu);
+#endif
+	return 0;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -801,37 +746,8 @@ static int unknown_nmi_panic_callback(st
 	unsigned char reason = get_nmi_reason();
 	char buf[64];
 
-	if (!(reason & 0xc0)) {
-		sprintf(buf, "NMI received for unknown reason %02x\n", reason);
-		die_nmi(buf,regs);
-	}
-	return 0;
-}
-
-/*
- * proc handler for /proc/sys/kernel/unknown_nmi_panic
- */
-int proc_unknown_nmi_panic(struct ctl_table *table, int write, struct file *file,
-			void __user *buffer, size_t *length, loff_t *ppos)
-{
-	int old_state;
-
-	old_state = unknown_nmi_panic;
-	proc_dointvec(table, write, file, buffer, length, ppos);
-	if (!!old_state == !!unknown_nmi_panic)
-		return 0;
-
-	if (unknown_nmi_panic) {
-		if (reserve_lapic_nmi() < 0) {
-			unknown_nmi_panic = 0;
-			return -EBUSY;
-		} else {
-			set_nmi_callback(unknown_nmi_panic_callback);
-		}
-	} else {
-		release_lapic_nmi();
-		unset_nmi_callback();
-	}
+	sprintf(buf, "NMI received for unknown reason %02x\n", reason);
+	die_nmi(buf,regs);
 	return 0;
 }
 
@@ -845,8 +761,6 @@ EXPORT_SYMBOL(reserve_perfctr_nmi);
 EXPORT_SYMBOL(release_perfctr_nmi);
 EXPORT_SYMBOL(reserve_evntsel_nmi);
 EXPORT_SYMBOL(release_evntsel_nmi);
-EXPORT_SYMBOL(reserve_lapic_nmi);
-EXPORT_SYMBOL(release_lapic_nmi);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
 EXPORT_SYMBOL(touch_nmi_watchdog);
Index: linux-don/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-don.orig/arch/x86_64/kernel/x8664_ksyms.c
+++ linux-don/arch/x86_64/kernel/x8664_ksyms.c
@@ -104,9 +104,6 @@ EXPORT_SYMBOL(screen_info);
 
 EXPORT_SYMBOL(rtc_lock);
 
-EXPORT_SYMBOL_GPL(set_nmi_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_callback);
-
 /* Export string functions. We normally rely on gcc builtin for most of these,
    but gcc sometimes decides not to inline them. */    
 #undef memcpy
Index: linux-don/include/asm-x86_64/nmi.h
===================================================================
--- linux-don.orig/include/asm-x86_64/nmi.h
+++ linux-don/include/asm-x86_64/nmi.h
@@ -7,25 +7,6 @@
 #include <linux/pm.h>
 #include <asm/io.h>
  
-struct pt_regs;
-
-typedef int (*nmi_callback_t)(struct pt_regs * regs, int cpu);
-
-/**
- * set_nmi_callback
- *
- * Set a handler for an NMI. Only one handler may be
- * set. Return 1 if the NMI was handled.
- */
-void set_nmi_callback(nmi_callback_t callback);
-
-/**
- * unset_nmi_callback
- *
- * Remove the handler previously set.
- */
-void unset_nmi_callback(void);
-
 /**
  * do_nmi_callback
  *
@@ -72,8 +53,6 @@ extern int reserve_evntsel_nmi(unsigned 
 extern void release_evntsel_nmi(unsigned int);
 
 extern void setup_apic_nmi_watchdog (void *);
-extern int reserve_lapic_nmi(void);
-extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
Index: linux-don/arch/i386/oprofile/nmi_int.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/nmi_int.c
+++ linux-don/arch/i386/oprofile/nmi_int.c
@@ -16,14 +16,15 @@
 #include <asm/nmi.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
+#include <asm/kdebug.h>
  
 #include "op_counter.h"
 #include "op_x86_model.h"
- 
+
 static struct op_x86_model_spec const * model;
 static struct op_msrs cpu_msrs[NR_CPUS];
 static unsigned long saved_lvtpc[NR_CPUS];
- 
+
 static int nmi_start(void);
 static void nmi_stop(void);
 
@@ -81,13 +82,24 @@ static void exit_driverfs(void)
 #define exit_driverfs() do { } while (0)
 #endif /* CONFIG_PM */
 
-
-static int nmi_callback(struct pt_regs * regs, int cpu)
+int profile_exceptions_notify(struct notifier_block *self,
+				unsigned long val, void *data)
 {
-	return model->check_ctrs(regs, &cpu_msrs[cpu]);
+	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+	int cpu = smp_processor_id();
+
+	switch(val) {
+	case DIE_NMI:
+		if (model->check_ctrs(args->regs, &cpu_msrs[cpu]))
+			ret = NOTIFY_STOP;
+		break;
+	default:
+		break;
+	}
+	return ret;
 }
- 
- 
+
 static void nmi_cpu_save_registers(struct op_msrs * msrs)
 {
 	unsigned int const nr_ctrs = model->num_counters;
@@ -173,27 +185,29 @@ static void nmi_cpu_setup(void * dummy)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 }
 
+static struct notifier_block profile_exceptions_nb = {
+	.notifier_call = profile_exceptions_notify,
+	.next = NULL,
+	.priority = 0
+};
 
 static int nmi_setup(void)
 {
+	int err=0;
+
 	if (!allocate_msrs())
 		return -ENOMEM;
 
-	/* We walk a thin line between law and rape here.
-	 * We need to be careful to install our NMI handler
-	 * without actually triggering any NMIs as this will
-	 * break the core code horrifically.
-	 */
-	if (reserve_lapic_nmi() < 0) {
+	if ((err = register_die_notifier(&profile_exceptions_nb))){
 		free_msrs();
-		return -EBUSY;
+		return err;
 	}
+
 	/* We need to serialize save and setup for HT because the subset
 	 * of msrs are distinct for save and setup operations
 	 */
 	on_each_cpu(nmi_save_registers, NULL, 0, 1);
 	on_each_cpu(nmi_cpu_setup, NULL, 0, 1);
-	set_nmi_callback(nmi_callback);
 	nmi_enabled = 1;
 	return 0;
 }
@@ -249,8 +263,7 @@ static void nmi_shutdown(void)
 {
 	nmi_enabled = 0;
 	on_each_cpu(nmi_cpu_shutdown, NULL, 0, 1);
-	unset_nmi_callback();
-	release_lapic_nmi();
+	unregister_die_notifier(&profile_exceptions_nb);
 	free_msrs();
 }
 
Index: linux-don/arch/i386/oprofile/nmi_timer_int.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/nmi_timer_int.c
+++ linux-don/arch/i386/oprofile/nmi_timer_int.c
@@ -17,32 +17,49 @@
 #include <asm/nmi.h>
 #include <asm/apic.h>
 #include <asm/ptrace.h>
+#include <asm/kdebug.h>
  
-static int nmi_timer_callback(struct pt_regs * regs, int cpu)
+int profile_timer_exceptions_notify(struct notifier_block *self,
+				unsigned long val, void *data)
 {
-	oprofile_add_sample(regs, 0);
-	return 1;
+	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+
+	switch(val) {
+	case DIE_NMI:
+		oprofile_add_sample(args->regs, 0);
+		ret = NOTIFY_STOP;
+		break;
+	default:
+		break;
+	}
+	return ret;
 }
 
+static struct notifier_block profile_timer_exceptions_nb = {
+	.notifier_call = profile_timer_exceptions_notify,
+	.next = NULL,
+	.priority = 0
+};
+
 static int timer_start(void)
 {
-	disable_timer_nmi_watchdog();
-	set_nmi_callback(nmi_timer_callback);
+	if (register_die_notifier(&profile_timer_exceptions_nb))
+		return 1;
 	return 0;
 }
 
 
 static void timer_stop(void)
 {
-	enable_timer_nmi_watchdog();
-	unset_nmi_callback();
+	unregister_die_notifier(&profile_timer_exceptions_nb);
 	synchronize_sched();  /* Allow already-started NMIs to complete. */
 }
 
 
 int __init op_nmi_timer_init(struct oprofile_operations * ops)
 {
-	if (atomic_read(&nmi_active) <= 0)
+	if ((nmi_watchdog != NMI_IO_APIC) || (atomic_read(&nmi_active) <= 0))
 		return -ENODEV;
 
 	ops->start = timer_start;
Index: linux-don/arch/i386/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/i386/kernel/nmi.c
+++ linux-don/arch/i386/kernel/nmi.c
@@ -42,20 +42,6 @@ static DEFINE_PER_CPU(unsigned long, evn
  */
 #define NMI_MAX_COUNTER_BITS 66
 
-/*
- * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
- * - it may be reserved by some other driver, or not
- * - when not reserved by some other driver, it may be used for
- *   the NMI watchdog, or not
- *
- * This is maintained separately from nmi_active because the NMI
- * watchdog may also be driven from the I/O APIC timer.
- */
-static DEFINE_SPINLOCK(lapic_nmi_owner_lock);
-static unsigned int lapic_nmi_owner;
-#define LAPIC_NMI_WATCHDOG	(1<<0)
-#define LAPIC_NMI_RESERVED	(1<<1)
-
 /* nmi_active:
  * >0: the lapic NMI watchdog is active, but can be disabled
  * <0: the lapic NMI watchdog has not been set up, and cannot
@@ -325,33 +311,6 @@ static void enable_lapic_nmi_watchdog(vo
 	touch_nmi_watchdog();
 }
 
-int reserve_lapic_nmi(void)
-{
-	unsigned int old_owner;
-
-	spin_lock(&lapic_nmi_owner_lock);
-	old_owner = lapic_nmi_owner;
-	lapic_nmi_owner |= LAPIC_NMI_RESERVED;
-	spin_unlock(&lapic_nmi_owner_lock);
-	if (old_owner & LAPIC_NMI_RESERVED)
-		return -EBUSY;
-	if (old_owner & LAPIC_NMI_WATCHDOG)
-		disable_lapic_nmi_watchdog();
-	return 0;
-}
-
-void release_lapic_nmi(void)
-{
-	unsigned int new_owner;
-
-	spin_lock(&lapic_nmi_owner_lock);
-	new_owner = lapic_nmi_owner & ~LAPIC_NMI_RESERVED;
-	lapic_nmi_owner = new_owner;
-	spin_unlock(&lapic_nmi_owner_lock);
-	if (new_owner & LAPIC_NMI_WATCHDOG)
-		enable_lapic_nmi_watchdog();
-}
-
 void disable_timer_nmi_watchdog(void)
 {
 	BUG_ON(nmi_watchdog != NMI_IO_APIC);
@@ -865,6 +824,15 @@ done:
 	return rc;
 }
 
+int do_nmi_callback(struct pt_regs * regs, int cpu)
+{
+#ifdef CONFIG_SYSCTL
+	if (unknown_nmi_panic)
+		return unknown_nmi_panic_callback(regs, cpu);
+#endif
+	return 0;
+}
+
 #ifdef CONFIG_SYSCTL
 
 static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu)
@@ -872,37 +840,8 @@ static int unknown_nmi_panic_callback(st
 	unsigned char reason = get_nmi_reason();
 	char buf[64];
 
-	if (!(reason & 0xc0)) {
-		sprintf(buf, "NMI received for unknown reason %02x\n", reason);
-		die_nmi(regs, buf);
-	}
-	return 0;
-}
-
-/*
- * proc handler for /proc/sys/kernel/unknown_nmi_panic
- */
-int proc_unknown_nmi_panic(ctl_table *table, int write, struct file *file,
-			void __user *buffer, size_t *length, loff_t *ppos)
-{
-	int old_state;
-
-	old_state = unknown_nmi_panic;
-	proc_dointvec(table, write, file, buffer, length, ppos);
-	if (!!old_state == !!unknown_nmi_panic)
-		return 0;
-
-	if (unknown_nmi_panic) {
-		if (reserve_lapic_nmi() < 0) {
-			unknown_nmi_panic = 0;
-			return -EBUSY;
-		} else {
-			set_nmi_callback(unknown_nmi_panic_callback);
-		}
-	} else {
-		release_lapic_nmi();
-		unset_nmi_callback();
-	}
+	sprintf(buf, "NMI received for unknown reason %02x\n", reason);
+	die_nmi(regs, buf);
 	return 0;
 }
 
@@ -916,7 +855,5 @@ EXPORT_SYMBOL(reserve_perfctr_nmi);
 EXPORT_SYMBOL(release_perfctr_nmi);
 EXPORT_SYMBOL(reserve_evntsel_nmi);
 EXPORT_SYMBOL(release_evntsel_nmi);
-EXPORT_SYMBOL(reserve_lapic_nmi);
-EXPORT_SYMBOL(release_lapic_nmi);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
Index: linux-don/arch/i386/kernel/traps.c
===================================================================
--- linux-don.orig/arch/i386/kernel/traps.c
+++ linux-don/arch/i386/kernel/traps.c
@@ -673,13 +673,6 @@ void die_nmi (struct pt_regs *regs, cons
 	do_exit(SIGSEGV);
 }
 
-static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
-{
-	return 0;
-}
-
-static nmi_callback_t nmi_callback = dummy_nmi_callback;
-
 static void default_do_nmi(struct pt_regs * regs)
 {
 	unsigned char reason = 0;
@@ -699,9 +692,10 @@ static void default_do_nmi(struct pt_reg
 		 */
 		if (nmi_watchdog_tick(regs, reason))
 			return;
+		if (!do_nmi_callback(regs, smp_processor_id()))
 #endif
-		if (!rcu_dereference(nmi_callback)(regs, smp_processor_id()))
 			unknown_nmi_error(reason, regs);
+
 		return;
 	}
 	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_STOP)
@@ -732,19 +726,6 @@ fastcall void do_nmi(struct pt_regs * re
 	nmi_exit();
 }
 
-void set_nmi_callback(nmi_callback_t callback)
-{
-	vmalloc_sync_all();
-	rcu_assign_pointer(nmi_callback, callback);
-}
-EXPORT_SYMBOL_GPL(set_nmi_callback);
-
-void unset_nmi_callback(void)
-{
-	nmi_callback = dummy_nmi_callback;
-}
-EXPORT_SYMBOL_GPL(unset_nmi_callback);
-
 #ifdef CONFIG_KPROBES
 fastcall void __kprobes do_int3(struct pt_regs *regs, long error_code)
 {
Index: linux-don/include/asm-i386/nmi.h
===================================================================
--- linux-don.orig/include/asm-i386/nmi.h
+++ linux-don/include/asm-i386/nmi.h
@@ -6,24 +6,13 @@
 
 #include <linux/pm.h>
 
-struct pt_regs;
-
-typedef int (*nmi_callback_t)(struct pt_regs * regs, int cpu);
-
-/**
- * set_nmi_callback
- *
- * Set a handler for an NMI. Only one handler may be
- * set. Return 1 if the NMI was handled.
- */
-void set_nmi_callback(nmi_callback_t callback);
-
 /**
- * unset_nmi_callback
+ * do_nmi_callback
  *
- * Remove the handler previously set.
+ * Check to see if a callback exists and execute it.  Return 1
+ * if the handler exists and was handled successfully.
  */
-void unset_nmi_callback(void);
+int do_nmi_callback(struct pt_regs *regs, int cpu);
 
 extern int avail_to_resrv_perfctr_nmi_bit(unsigned int);
 extern int avail_to_resrv_perfctr_nmi(unsigned int);
@@ -33,8 +22,6 @@ extern int reserve_evntsel_nmi(unsigned 
 extern void release_evntsel_nmi(unsigned int);
 
 extern void setup_apic_nmi_watchdog (void *);
-extern int reserve_lapic_nmi(void);
-extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
Index: linux-don/kernel/sysctl.c
===================================================================
--- linux-don.orig/kernel/sysctl.c
+++ linux-don/kernel/sysctl.c
@@ -75,8 +75,6 @@ extern int percpu_pagelist_fraction;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
-extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
-				  void __user *, size_t *, loff_t *);
 #endif
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -630,7 +628,7 @@ static ctl_table kern_table[] = {
 		.data           = &unknown_nmi_panic,
 		.maxlen         = sizeof (int),
 		.mode           = 0644,
-		.proc_handler   = &proc_unknown_nmi_panic,
+		.proc_handler   = &proc_dointvec,
 	},
 #endif
 #if defined(CONFIG_X86)

--
