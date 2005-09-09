Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVIIAnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVIIAnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 20:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVIIAnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 20:43:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:62603 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751288AbVIIAnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 20:43:09 -0400
Date: Fri, 9 Sep 2005 02:43:07 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] [PATCH] add and handle NMI_VECTOR II
Message-ID: <20050909004307.GA18347@wotan.suse.de>
References: <43207DFC0200007800024543@emea1-mh.id2.novell.com> <20050909002045.GA19913@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909002045.GA19913@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 02:20:45AM +0200, Andi Kleen wrote:
> On Thu, Sep 08, 2005 at 06:07:56PM +0200, Jan Beulich wrote:
> > (Note: Patch also attached because the inline version is certain to get
> > line wrapped.)
> > 
> > Declare NMI_VECTOR and handle it in the IPI sending code.
> 
> The earlier consensus was to just rename KDB_VECTOR to NMI vector.
> 
> I added the following patch.

[...]

The patch was obviously half backed. Here's one that actually
compiles.

-Andi


Rename KDB_VECTOR to NMI_VECTOR

As a generic NMI IPI vector to be used by debuggers.

And clean up the ICR setup for that slightly (code is equivalent, but cleaner 
now)

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-x86_64/hw_irq.h
===================================================================
--- linux.orig/include/asm-x86_64/hw_irq.h
+++ linux/include/asm-x86_64/hw_irq.h
@@ -52,7 +52,7 @@ struct hw_interrupt_type;
 #define ERROR_APIC_VECTOR	0xfe
 #define RESCHEDULE_VECTOR	0xfd
 #define CALL_FUNCTION_VECTOR	0xfc
-#define KDB_VECTOR		0xfb	/* reserved for KDB */
+#define NMI_VECTOR		0xfb	/* IPI NMIs for debugging */
 #define THERMAL_APIC_VECTOR	0xfa
 /* 0xf9 free */
 #define INVALIDATE_TLB_VECTOR_END	0xf8
Index: linux/include/asm-x86_64/ipi.h
===================================================================
--- linux.orig/include/asm-x86_64/ipi.h
+++ linux/include/asm-x86_64/ipi.h
@@ -29,11 +29,14 @@
  * We use 'broadcast', CPU->CPU IPIs and self-IPIs too.
  */
 
-static inline unsigned int __prepare_ICR (unsigned int shortcut, int vector, unsigned int dest)
+static inline unsigned int 
+__prepare_ICR (unsigned int shortcut, int vector, unsigned int dest)
 {
-	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | dest;
-	if (vector == KDB_VECTOR)
-		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI;
+	unsigned int icr =  shortcut | dest;
+	if (vector == NMI_VECTOR)
+		icr |= APIC_DM_NMI;
+	else
+		icr |= APIC_DM_FIXED | vector;
 	return icr;
 }
 
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -931,7 +931,7 @@ void __init trap_init(void)
 	set_system_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
 #endif
        
-	set_intr_gate(KDB_VECTOR, call_debug);
+	set_intr_gate(NMI_VECTOR, call_debug);
        
 	/*
 	 * Should be a barrier for any external CPU state.
Index: linux/arch/x86_64/kernel/i8259.c
===================================================================
--- linux.orig/arch/x86_64/kernel/i8259.c
+++ linux/arch/x86_64/kernel/i8259.c
@@ -551,7 +551,7 @@ void __init init_IRQ(void)
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (i >= NR_IRQS)
 			break;
-		if (vector != IA32_SYSCALL_VECTOR && vector != KDB_VECTOR) { 
+		if (vector != IA32_SYSCALL_VECTOR && vector != NMI_VECTOR) { 
 			set_intr_gate(vector, interrupt[i]);
 	}
 	}
Index: linux/arch/x86_64/kernel/smp.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smp.c
+++ linux/arch/x86_64/kernel/smp.c
@@ -283,11 +283,6 @@ void flush_tlb_all(void)
 	on_each_cpu(do_flush_tlb_all, NULL, 1, 1);
 }
 
-void smp_kdb_stop(void)
-{
-	send_IPI_allbutself(KDB_VECTOR);
-}
-
 /*
  * this function sends a 'reschedule' IPI to another CPU.
  * it goes straight through and wastes no time serializing
