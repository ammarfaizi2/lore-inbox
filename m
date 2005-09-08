Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVIHQja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVIHQja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVIHQja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:39:30 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:416 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964876AbVIHQj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:39:29 -0400
Date: Thu, 8 Sep 2005 09:39:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Keith Owens <kaos@sgi.com>
Subject: [PATCH 2.6.13] x86_64: Rename KDB_VECTOR to NMI_VECTOR
Message-ID: <20050908163928.GS3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The existing hook from KDB in the IPI code is really just a hook for the
NMI vector.  We rename the vector thusly and then it's up to the
debugger to handle things from do_default_nmi().

---

 linux-2.6.13-trini/arch/x86_64/kernel/i8259.c  |    3 +--
 linux-2.6.13-trini/arch/x86_64/kernel/smp.c    |    2 +-
 linux-2.6.13-trini/arch/x86_64/kernel/traps.c  |    2 +-
 linux-2.6.13-trini/include/asm-x86_64/hw_irq.h |    2 +-
 linux-2.6.13-trini/include/asm-x86_64/ipi.h    |    2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff -puN arch/x86_64/kernel/i8259.c~x86_64-rename_kdb_vector arch/x86_64/kernel/i8259.c
--- linux-2.6.13/arch/x86_64/kernel/i8259.c~x86_64-rename_kdb_vector	2005-09-01 12:00:42.000000000 -0700
+++ linux-2.6.13-trini/arch/x86_64/kernel/i8259.c	2005-09-01 12:00:42.000000000 -0700
@@ -544,10 +544,9 @@ void __init init_IRQ(void)
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (i >= NR_IRQS)
 			break;
-		if (vector != IA32_SYSCALL_VECTOR && vector != KDB_VECTOR) { 
+		if (vector != IA32_SYSCALL_VECTOR && vector != NMI_VECTOR)
 			set_intr_gate(vector, interrupt[i]);
 	}
-	}
 
 #ifdef CONFIG_SMP
 	/*
diff -puN arch/x86_64/kernel/smp.c~x86_64-rename_kdb_vector arch/x86_64/kernel/smp.c
--- linux-2.6.13/arch/x86_64/kernel/smp.c~x86_64-rename_kdb_vector	2005-09-01 12:00:42.000000000 -0700
+++ linux-2.6.13-trini/arch/x86_64/kernel/smp.c	2005-09-01 12:00:42.000000000 -0700
@@ -252,7 +252,7 @@ void flush_tlb_all(void)
 
 void smp_kdb_stop(void)
 {
-	send_IPI_allbutself(KDB_VECTOR);
+	send_IPI_allbutself(NMI_VECTOR);
 }
 
 /*
diff -puN arch/x86_64/kernel/traps.c~x86_64-rename_kdb_vector arch/x86_64/kernel/traps.c
--- linux-2.6.13/arch/x86_64/kernel/traps.c~x86_64-rename_kdb_vector	2005-09-01 12:00:42.000000000 -0700
+++ linux-2.6.13-trini/arch/x86_64/kernel/traps.c	2005-09-01 12:00:56.000000000 -0700
@@ -931,7 +931,7 @@ void __init trap_init(void)
 	set_system_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
 #endif
        
-	set_intr_gate(KDB_VECTOR, call_debug);
+	set_intr_gate(NMI_VECTOR, call_debug);
        
 	/*
 	 * Should be a barrier for any external CPU state.
diff -puN include/asm-x86_64/hw_irq.h~x86_64-rename_kdb_vector include/asm-x86_64/hw_irq.h
--- linux-2.6.13/include/asm-x86_64/hw_irq.h~x86_64-rename_kdb_vector	2005-09-01 12:00:42.000000000 -0700
+++ linux-2.6.13-trini/include/asm-x86_64/hw_irq.h	2005-09-01 12:00:42.000000000 -0700
@@ -54,7 +54,7 @@ struct hw_interrupt_type;
 #define RESCHEDULE_VECTOR	0xfc
 #define TASK_MIGRATION_VECTOR	0xfb
 #define CALL_FUNCTION_VECTOR	0xfa
-#define KDB_VECTOR	0xf9
+#define NMI_VECTOR	0xf9
 
 #define THERMAL_APIC_VECTOR	0xf0
 
diff -puN include/asm-x86_64/ipi.h~x86_64-rename_kdb_vector include/asm-x86_64/ipi.h
--- linux-2.6.13/include/asm-x86_64/ipi.h~x86_64-rename_kdb_vector	2005-09-01 12:00:42.000000000 -0700
+++ linux-2.6.13-trini/include/asm-x86_64/ipi.h	2005-09-01 12:00:42.000000000 -0700
@@ -32,7 +32,7 @@
 static inline unsigned int __prepare_ICR (unsigned int shortcut, int vector, unsigned int dest)
 {
 	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | dest;
-	if (vector == KDB_VECTOR)
+	if (vector == NMI_VECTOR)
 		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI;
 	return icr;
 }

-- 
Tom Rini
http://gate.crashing.org/~trini/
