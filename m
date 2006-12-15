Return-Path: <linux-kernel-owner+w=401wt.eu-S1751131AbWLOGw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWLOGw7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 01:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWLOGwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 01:52:35 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47543 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbWLOGwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 01:52:32 -0500
Date: Thu, 14 Dec 2006 22:52:19 -0800
Message-Id: <200612150652.kBF6qJ78025526@zach-dev.vmware.com>
Subject: [PATCH 4/6] SMP boot hook for paravirt
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 15 Dec 2006 06:52:20.0372 (UTC) FILETIME=[91136D40:01C72015]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add VMI SMP boot hook.  We emulate a regular boot sequence and use the
same APIC IPI initiation, we just poke magic values to load into the CPU
state when the startup IPI is received, rather than having to jump through a
real mode trampoline.

This is all that was needed to get SMP to work.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Subject: SMP boot hook for paravirt

diff -r acfb7a15715f arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Thu Dec 14 16:22:03 2006 -0800
+++ b/arch/i386/kernel/paravirt.c	Thu Dec 14 16:51:48 2006 -0800
@@ -572,5 +572,7 @@ struct paravirt_ops paravirt_ops = {
 
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
+
+	.startup_ipi_hook = (void *)native_nop,
 };
 EXPORT_SYMBOL(paravirt_ops);
diff -r acfb7a15715f arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Thu Dec 14 16:22:03 2006 -0800
+++ b/arch/i386/kernel/smpboot.c	Thu Dec 14 16:51:52 2006 -0800
@@ -831,6 +831,13 @@ wakeup_secondary_cpu(int phys_apicid, un
 		num_starts = 0;
 
 	/*
+	 * Paravirt / VMI wants a startup IPI hook here to set up the
+	 * target processor state.
+	 */
+	startup_ipi_hook(phys_apicid, (unsigned long) start_secondary,
+		         (unsigned long) stack_start.esp);
+
+	/*
 	 * Run STARTUP IPI loop.
 	 */
 	Dprintk("#startup loops: %d.\n", num_starts);
diff -r acfb7a15715f include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Thu Dec 14 16:22:03 2006 -0800
+++ b/include/asm-i386/paravirt.h	Thu Dec 14 16:51:48 2006 -0800
@@ -151,6 +151,8 @@ struct paravirt_ops
 	/* These two are jmp to, not actually called. */
 	void (fastcall *irq_enable_sysexit)(void);
 	void (fastcall *iret)(void);
+
+	void (fastcall *startup_ipi_hook)(int phys_apicid, unsigned long start_eip, unsigned long start_esp);
 };
 
 /* Mark a paravirt probe function. */
@@ -323,6 +325,13 @@ static inline unsigned long apic_read(un
 }
 #endif
 
+#ifdef CONFIG_SMP
+static inline void startup_ipi_hook(int phys_apicid, unsigned long start_eip,
+				    unsigned long start_esp)
+{
+	return paravirt_ops.startup_ipi_hook(phys_apicid, start_eip, start_esp);
+}
+#endif
 
 #define __flush_tlb() paravirt_ops.flush_tlb_user()
 #define __flush_tlb_global() paravirt_ops.flush_tlb_kernel()
diff -r acfb7a15715f include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Thu Dec 14 16:22:03 2006 -0800
+++ b/include/asm-i386/smp.h	Thu Dec 14 16:52:21 2006 -0800
@@ -52,6 +52,11 @@ extern void cpu_uninit(void);
 extern void cpu_uninit(void);
 #endif
 
+#ifndef CONFIG_PARAVIRT
+#define startup_ipi_hook(phys_apicid, start_eip, start_esp) 		\
+do { } while (0)
+#endif
+
 /*
  * This function is needed by all SMP systems. It must _always_ be valid
  * from the initial startup. We map APIC_BASE very early in page_setup(),
