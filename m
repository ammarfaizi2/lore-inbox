Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWHJUQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWHJUQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWHJUQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:16:06 -0400
Received: from ns.suse.de ([195.135.220.2]:4496 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932195AbWHJTfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:22 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [9/145] x86_64: Cleanup NMI interrupt path
Message-Id: <20060810193521.6A8C513B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:21 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: dzickus <dzickus@redhat.com>

This patch cleans up the NMI interrupt path.  Instead of being gated by if
the 'nmi callback' is set, the interrupt handler now calls everyone who is
registered on the die_chain and additionally checks the nmi watchdog,
reseting it if enabled.  This allows more subsystems to hook into the NMI if
they need to (without being block by set_nmi_callback). 


Signed-off-by:  Don Zickus <dzickus@redhat.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/nmi.c     |   16 +++++++++++++---
 arch/i386/kernel/traps.c   |   24 +++++++++++-------------
 arch/x86_64/kernel/nmi.c   |   26 +++++++++++++++++++-------
 arch/x86_64/kernel/traps.c |    8 ++++----
 include/asm-i386/nmi.h     |    2 +-
 include/asm-x86_64/nmi.h   |   10 +++++++++-
 6 files changed, 57 insertions(+), 29 deletions(-)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -781,7 +781,7 @@ EXPORT_SYMBOL(touch_nmi_watchdog);
 
 extern void die_nmi(struct pt_regs *, const char *msg);
 
-void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason)
+int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason)
 {
 
 	/*
@@ -794,10 +794,12 @@ void nmi_watchdog_tick (struct pt_regs *
 	int cpu = smp_processor_id();
 	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 	u64 dummy;
+	int rc=0;
 
 	/* check for other users first */
 	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT)
 			== NOTIFY_STOP) {
+		rc = 1;
 		touched = 1;
 	}
 
@@ -850,10 +852,18 @@ void nmi_watchdog_tick (struct pt_regs *
 			}
 			/* start the cycle over again */
 			write_watchdog_counter(wd->perfctr_msr, NULL);
-		}
+			rc = 1;
+		} else if (nmi_watchdog == NMI_IO_APIC) {
+			/* don't know how to accurately check for this.
+			 * just assume it was a watchdog timer interrupt
+			 * This matches the old behaviour.
+			 */
+			rc = 1;
+		} else
+			printk(KERN_WARNING "Unknown enabled NMI hardware?!\n");
 	}
 done:
-	return;
+	return rc;
 }
 
 #ifdef CONFIG_SYSCTL
Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -703,6 +703,13 @@ void die_nmi (struct pt_regs *regs, cons
 	do_exit(SIGSEGV);
 }
 
+static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
+{
+	return 0;
+}
+
+static nmi_callback_t nmi_callback = dummy_nmi_callback;
+
 static void default_do_nmi(struct pt_regs * regs)
 {
 	unsigned char reason = 0;
@@ -720,12 +727,11 @@ static void default_do_nmi(struct pt_reg
 		 * Ok, so this is none of the documented NMI sources,
 		 * so it must be the NMI watchdog.
 		 */
-		if (nmi_watchdog) {
-			nmi_watchdog_tick(regs, reason);
+		if (nmi_watchdog_tick(regs, reason))
 			return;
-		}
 #endif
-		unknown_nmi_error(reason, regs);
+		if (!rcu_dereference(nmi_callback)(regs, smp_processor_id()))
+			unknown_nmi_error(reason, regs);
 		return;
 	}
 	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_STOP)
@@ -741,13 +747,6 @@ static void default_do_nmi(struct pt_reg
 	reassert_nmi();
 }
 
-static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
-{
-	return 0;
-}
- 
-static nmi_callback_t nmi_callback = dummy_nmi_callback;
- 
 fastcall void do_nmi(struct pt_regs * regs, long error_code)
 {
 	int cpu;
@@ -758,8 +757,7 @@ fastcall void do_nmi(struct pt_regs * re
 
 	++nmi_count(cpu);
 
-	if (!rcu_dereference(nmi_callback)(regs, cpu))
-		default_do_nmi(regs);
+	default_do_nmi(regs);
 
 	nmi_exit();
 }
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -682,16 +682,18 @@ void touch_nmi_watchdog (void)
  	touch_softlockup_watchdog();
 }
 
-void __kprobes nmi_watchdog_tick(struct pt_regs * regs, unsigned reason)
+int __kprobes nmi_watchdog_tick(struct pt_regs * regs, unsigned reason)
 {
 	int sum;
 	int touched = 0;
 	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 	u64 dummy;
+	int rc=0;
 
 	/* check for other users first */
 	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT)
 			== NOTIFY_STOP) {
+		rc = 1;
 		touched = 1;
 	}
 
@@ -746,10 +748,18 @@ void __kprobes nmi_watchdog_tick(struct 
 	 		}
 			/* start the cycle over again */
 			wrmsrl(wd->perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
-		}
+			rc = 1;
+		} else 	if (nmi_watchdog == NMI_IO_APIC) {
+			/* don't know how to accurately check for this.
+			 * just assume it was a watchdog timer interrupt
+			 * This matches the old behaviour.
+			 */
+			rc = 1;
+		} else
+			printk(KERN_WARNING "Unknown enabled NMI hardware?!\n");
 	}
 done:
-	return;
+	return rc;
 }
 
 static __kprobes int dummy_nmi_callback(struct pt_regs * regs, int cpu)
@@ -761,15 +771,17 @@ static nmi_callback_t nmi_callback = dum
  
 asmlinkage __kprobes void do_nmi(struct pt_regs * regs, long error_code)
 {
-	int cpu = safe_smp_processor_id();
-
 	nmi_enter();
 	add_pda(__nmi_count,1);
-	if (!rcu_dereference(nmi_callback)(regs, cpu))
-		default_do_nmi(regs);
+	default_do_nmi(regs);
 	nmi_exit();
 }
 
+int do_nmi_callback(struct pt_regs * regs, int cpu)
+{
+	return rcu_dereference(nmi_callback)(regs, cpu);
+}
+
 void set_nmi_callback(nmi_callback_t callback)
 {
 	vmalloc_sync_all();
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -777,12 +777,12 @@ asmlinkage __kprobes void default_do_nmi
 		 * Ok, so this is none of the documented NMI sources,
 		 * so it must be the NMI watchdog.
 		 */
-		if (nmi_watchdog > 0) {
-			nmi_watchdog_tick(regs,reason);
+		if (nmi_watchdog_tick(regs,reason))
 			return;
-		}
+		if (!do_nmi_callback(regs,cpu))
 #endif
-		unknown_nmi_error(reason, regs);
+			unknown_nmi_error(reason, regs);
+
 		return;
 	}
 	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_STOP)
Index: linux/include/asm-i386/nmi.h
===================================================================
--- linux.orig/include/asm-i386/nmi.h
+++ linux/include/asm-i386/nmi.h
@@ -37,7 +37,7 @@ extern int reserve_lapic_nmi(void);
 extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
+extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 
 extern atomic_t nmi_active;
 extern unsigned int nmi_watchdog;
Index: linux/include/asm-x86_64/nmi.h
===================================================================
--- linux.orig/include/asm-x86_64/nmi.h
+++ linux/include/asm-x86_64/nmi.h
@@ -26,6 +26,14 @@ void set_nmi_callback(nmi_callback_t cal
  */
 void unset_nmi_callback(void);
 
+/**
+ * do_nmi_callback
+ *
+ * Check to see if a callback exists and execute it.  Return 1
+ * if the handler exists and was handled successfully.
+ */
+int do_nmi_callback(struct pt_regs *regs, int cpu);
+
 #ifdef CONFIG_PM
  
 /** Replace the PM callback routine for NMI. */
@@ -68,7 +76,7 @@ extern int reserve_lapic_nmi(void);
 extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
+extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 
 extern void nmi_watchdog_default(void);
 extern int setup_nmi_watchdog(char *);
