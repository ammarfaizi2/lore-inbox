Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVHHT1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVHHT1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVHHT1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:27:17 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:34260 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932178AbVHHT1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:27:16 -0400
Subject: [patch 1/1] x86_64: Rename KDB_VECTOR to DEBUGGER_VECTOR
Date: Mon, 08 Aug 2005 12:27:10 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, ak@suse.de,
       kaos@sgi.com
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.1.882005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Andi Kleen <ak@suse.de>, Keith Owens <kaos@sgi.com>
The existing hook from KDB in the IPI code is really just a hook for the
NMI vector.  We rename the vector thusly and then it's up to the
debugger to handle things from default_do_nmi().

---

 linux-2.6.13-rc6-trini/arch/x86_64/kernel/i8259.c  |    2 +-
 linux-2.6.13-rc6-trini/arch/x86_64/kernel/smp.c    |    2 +-
 linux-2.6.13-rc6-trini/arch/x86_64/kernel/traps.c  |    2 +-
 linux-2.6.13-rc6-trini/include/asm-x86_64/hw_irq.h |    2 +-
 linux-2.6.13-rc6-trini/include/asm-x86_64/ipi.h    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff -puN arch/x86_64/kernel/i8259.c~x86_64-rename_kdb_vector arch/x86_64/kernel/i8259.c
--- linux-2.6.13-rc6/arch/x86_64/kernel/i8259.c~x86_64-rename_kdb_vector	2005-08-08 12:22:37.000000000 -0700
+++ linux-2.6.13-rc6-trini/arch/x86_64/kernel/i8259.c	2005-08-08 12:22:37.000000000 -0700
@@ -544,7 +544,7 @@ void __init init_IRQ(void)
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (i >= NR_IRQS)
 			break;
-		if (vector != IA32_SYSCALL_VECTOR && vector != KDB_VECTOR) { 
+		if (vector != IA32_SYSCALL_VECTOR && vector != NMI_VECTOR) {
 			set_intr_gate(vector, interrupt[i]);
 	}
 	}
diff -puN arch/x86_64/kernel/smp.c~x86_64-rename_kdb_vector arch/x86_64/kernel/smp.c
--- linux-2.6.13-rc6/arch/x86_64/kernel/smp.c~x86_64-rename_kdb_vector	2005-08-08 12:22:37.000000000 -0700
+++ linux-2.6.13-rc6-trini/arch/x86_64/kernel/smp.c	2005-08-08 12:22:37.000000000 -0700
@@ -252,7 +252,7 @@ void flush_tlb_all(void)
 
 void smp_kdb_stop(void)
 {
-	send_IPI_allbutself(KDB_VECTOR);
+	send_IPI_allbutself(NMI_VECTOR);
 }
 
 /*
diff -puN arch/x86_64/kernel/traps.c~x86_64-rename_kdb_vector arch/x86_64/kernel/traps.c
--- linux-2.6.13-rc6/arch/x86_64/kernel/traps.c~x86_64-rename_kdb_vector	2005-08-08 12:22:37.000000000 -0700
+++ linux-2.6.13-rc6-trini/arch/x86_64/kernel/traps.c	2005-08-08 12:22:37.000000000 -0700
@@ -931,7 +931,7 @@ void __init trap_init(void)
 	set_system_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
 #endif
        
-	set_intr_gate(KDB_VECTOR, call_debug);
+	set_intr_gate(NMI_VECTOR, call_debug);
        
 	/*
 	 * Should be a barrier for any external CPU state.
diff -puN include/asm-x86_64/hw_irq.h~x86_64-rename_kdb_vector include/asm-x86_64/hw_irq.h
--- linux-2.6.13-rc6/include/asm-x86_64/hw_irq.h~x86_64-rename_kdb_vector	2005-08-08 12:22:37.000000000 -0700
+++ linux-2.6.13-rc6-trini/include/asm-x86_64/hw_irq.h	2005-08-08 12:22:37.000000000 -0700
@@ -54,7 +54,7 @@ struct hw_interrupt_type;
 #define RESCHEDULE_VECTOR	0xfc
 #define TASK_MIGRATION_VECTOR	0xfb
 #define CALL_FUNCTION_VECTOR	0xfa
-#define KDB_VECTOR	0xf9
+#define NMI_VECTOR	0xf9
 
 #define THERMAL_APIC_VECTOR	0xf0
 
diff -puN include/asm-x86_64/ipi.h~x86_64-rename_kdb_vector include/asm-x86_64/ipi.h
--- linux-2.6.13-rc6/include/asm-x86_64/ipi.h~x86_64-rename_kdb_vector	2005-08-08 12:22:37.000000000 -0700
+++ linux-2.6.13-rc6-trini/include/asm-x86_64/ipi.h	2005-08-08 12:22:37.000000000 -0700
@@ -32,7 +32,7 @@
 static inline unsigned int __prepare_ICR (unsigned int shortcut, int vector, unsigned int dest)
 {
 	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | dest;
-	if (vector == KDB_VECTOR)
+	if (vector == NMI_VECTOR)
 		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI;
 	return icr;
 }
_
