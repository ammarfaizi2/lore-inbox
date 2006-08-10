Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWHJUOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWHJUOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWHJTgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:7915 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932324AbWHJTfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:31 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [17/145] i386/x86-64: x86 nmi fix
Message-Id: <20060810193529.EE9D413B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:29 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Shaohua Li <shaohua.li@intel.com>

Making NMI suspend/resume work with SMP. We use CPU hotplug to offline
APs in SMP suspend/resume. Only BSP executes sysdev's .suspend/.resume
method. APs should follow CPU hotplug code path.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/nmi.c       |   14 +++++++++-----
 arch/i386/kernel/smpboot.c   |    3 ++-
 arch/x86_64/kernel/nmi.c     |   14 +++++++++-----
 arch/x86_64/kernel/smpboot.c |    2 ++
 include/asm-i386/nmi.h       |    1 +
 include/asm-x86_64/nmi.h     |    1 +
 6 files changed, 24 insertions(+), 11 deletions(-)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -63,7 +63,6 @@ struct nmi_watchdog_ctlblk {
 static DEFINE_PER_CPU(struct nmi_watchdog_ctlblk, nmi_watchdog_ctlblk);
 
 /* local prototypes */
-static void stop_apic_nmi_watchdog(void *unused);
 static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu);
 
 extern void show_registers(struct pt_regs *regs);
@@ -341,15 +340,20 @@ static int nmi_pm_active; /* nmi_active 
 
 static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
+	/* only CPU0 goes here, other CPUs should be offline */
 	nmi_pm_active = atomic_read(&nmi_active);
-	disable_lapic_nmi_watchdog();
+	stop_apic_nmi_watchdog(NULL);
+	BUG_ON(atomic_read(&nmi_active) != 0);
 	return 0;
 }
 
 static int lapic_nmi_resume(struct sys_device *dev)
 {
-	if (nmi_pm_active > 0)
-		enable_lapic_nmi_watchdog();
+	/* only CPU0 goes here, other CPUs should be offline */
+	if (nmi_pm_active > 0) {
+		setup_apic_nmi_watchdog(NULL);
+		touch_nmi_watchdog();
+	}
 	return 0;
 }
 
@@ -667,7 +671,7 @@ void setup_apic_nmi_watchdog (void *unus
 	atomic_inc(&nmi_active);
 }
 
-static void stop_apic_nmi_watchdog(void *unused)
+void stop_apic_nmi_watchdog(void *unused)
 {
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
Index: linux/arch/i386/kernel/smpboot.c
===================================================================
--- linux.orig/arch/i386/kernel/smpboot.c
+++ linux/arch/i386/kernel/smpboot.c
@@ -1372,7 +1372,8 @@ int __cpu_disable(void)
 	 */
 	if (cpu == 0)
 		return -EBUSY;
-
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		stop_apic_nmi_watchdog(NULL);
 	clear_local_APIC();
 	/* Allow any queued timer interrupts to get serviced */
 	local_irq_enable();
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -63,7 +63,6 @@ struct nmi_watchdog_ctlblk {
 static DEFINE_PER_CPU(struct nmi_watchdog_ctlblk, nmi_watchdog_ctlblk);
 
 /* local prototypes */
-static void stop_apic_nmi_watchdog(void *unused);
 static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu);
 
 /* converts an msr to an appropriate reservation bit */
@@ -337,15 +336,20 @@ static int nmi_pm_active; /* nmi_active 
 
 static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
+	/* only CPU0 goes here, other CPUs should be offline */
 	nmi_pm_active = atomic_read(&nmi_active);
-	disable_lapic_nmi_watchdog();
+	stop_apic_nmi_watchdog(NULL);
+	BUG_ON(atomic_read(&nmi_active) != 0);
 	return 0;
 }
 
 static int lapic_nmi_resume(struct sys_device *dev)
 {
-	if (nmi_pm_active > 0)
-		enable_lapic_nmi_watchdog();
+	/* only CPU0 goes here, other CPUs should be offline */
+	if (nmi_pm_active > 0) {
+		setup_apic_nmi_watchdog(NULL);
+		touch_nmi_watchdog();
+	}
 	return 0;
 }
 
@@ -586,7 +590,7 @@ void setup_apic_nmi_watchdog(void *unuse
 	atomic_inc(&nmi_active);
 }
 
-static void stop_apic_nmi_watchdog(void *unused)
+void stop_apic_nmi_watchdog(void *unused)
 {
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c
+++ linux/arch/x86_64/kernel/smpboot.c
@@ -1233,6 +1233,8 @@ int __cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		stop_apic_nmi_watchdog(NULL);
 	clear_local_APIC();
 
 	/*
Index: linux/include/asm-i386/nmi.h
===================================================================
--- linux.orig/include/asm-i386/nmi.h
+++ linux/include/asm-i386/nmi.h
@@ -23,6 +23,7 @@ extern int reserve_evntsel_nmi(unsigned 
 extern void release_evntsel_nmi(unsigned int);
 
 extern void setup_apic_nmi_watchdog (void *);
+extern void stop_apic_nmi_watchdog (void *);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
Index: linux/include/asm-x86_64/nmi.h
===================================================================
--- linux.orig/include/asm-x86_64/nmi.h
+++ linux/include/asm-x86_64/nmi.h
@@ -54,6 +54,7 @@ extern int reserve_evntsel_nmi(unsigned 
 extern void release_evntsel_nmi(unsigned int);
 
 extern void setup_apic_nmi_watchdog (void *);
+extern void stop_apic_nmi_watchdog (void *);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
