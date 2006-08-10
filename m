Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWHJUOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWHJUOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWHJTgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:07 -0400
Received: from ns.suse.de ([195.135.220.2]:13200 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932340AbWHJTfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:33 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [19/145] x86_64: Fix up panic messages for different NMI panics
Message-Id: <20060810193532.1748713B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:32 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

When a unknown NMI happened the panic would claim a NMI watchdog timeout.
Also it would check the variable set by nmi_watchdog=panic and panic then.

Fix up the panic message to be generic
Unconditionally panic on unknown NMI when panic on unknown nmi is enabled.

Noticed by Jan Beulich

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/nmi.c   |    5 +++--
 arch/x86_64/kernel/traps.c |    7 +++----
 include/asm-x86_64/nmi.h   |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -695,7 +695,8 @@ int __kprobes nmi_watchdog_tick(struct p
 		 */
 		local_inc(&__get_cpu_var(alert_counter));
 		if (local_read(&__get_cpu_var(alert_counter)) == 5*nmi_hz)
-			die_nmi("NMI Watchdog detected LOCKUP on CPU %d\n", regs);
+			die_nmi("NMI Watchdog detected LOCKUP on CPU %d\n", regs,
+				panic_on_timeout);
 	} else {
 		__get_cpu_var(last_irq_sum) = sum;
 		local_set(&__get_cpu_var(alert_counter), 0);
@@ -765,7 +766,7 @@ static int unknown_nmi_panic_callback(st
 	char buf[64];
 
 	sprintf(buf, "NMI received for unknown reason %02x\n", reason);
-	die_nmi(buf,regs);
+	die_nmi(buf, regs, 1);	/* Always panic here */
 	return 0;
 }
 
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -566,7 +566,7 @@ void die(const char * str, struct pt_reg
 	do_exit(SIGSEGV); 
 }
 
-void __kprobes die_nmi(char *str, struct pt_regs *regs)
+void __kprobes die_nmi(char *str, struct pt_regs *regs, int do_panic)
 {
 	unsigned long flags = oops_begin();
 
@@ -578,9 +578,8 @@ void __kprobes die_nmi(char *str, struct
 	show_registers(regs);
 	if (kexec_should_crash(current))
 		crash_kexec(regs);
-	if (panic_on_timeout || panic_on_oops)
-		panic("nmi watchdog");
-	printk("console shuts up ...\n");
+	if (do_panic || panic_on_oops)
+		panic("Non maskable interrupt");
 	oops_end(flags);
 	nmi_exit();
 	local_irq_enable();
Index: linux/include/asm-x86_64/nmi.h
===================================================================
--- linux.orig/include/asm-x86_64/nmi.h
+++ linux/include/asm-x86_64/nmi.h
@@ -37,7 +37,7 @@ static inline void unset_nmi_pm_callback
 #endif /* CONFIG_PM */
  
 extern void default_do_nmi(struct pt_regs *);
-extern void die_nmi(char *str, struct pt_regs *regs);
+extern void die_nmi(char *str, struct pt_regs *regs, int do_panic);
 
 #define get_nmi_reason() inb(0x61)
 
