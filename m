Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130078AbRARPir>; Thu, 18 Jan 2001 10:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130460AbRARPih>; Thu, 18 Jan 2001 10:38:37 -0500
Received: from ousrvr.oulu.fi ([130.231.240.1]:55737 "EHLO oulu.fi")
	by vger.kernel.org with ESMTP id <S130078AbRARPi0>;
	Thu, 18 Jan 2001 10:38:26 -0500
Date: Thu, 18 Jan 2001 17:38:20 +0200
From: Tuukka Toivonen <tutoivon@mail.student.oulu.fi>
To: linux-kernel@vger.kernel.org
Subject: patch: enabling RDPMC: bit 8 in CR4 (PCE)
Message-ID: <Pine.SGI.4.21.0101181735430.3651579-100000@paju.oulu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables performance counters if RDTSC is not disabled (ie. it
assumes user wants to enable RDPMC if he wants to enable RDTSC too).

It is against 2.4.0.

To save me from typing, I'll quote Intel IA-32 manuals:

"PCE    Performance-Monitoring Counter Enable (bit 8 of CR4). Enables
execution of the RDPMC instruction for programs or procedures running at
any protection level when set; RDPMC instruction can be executed only at
protection level 0 when clear."

"The RDPMC instruction was introduced into the IA-32 architecture with the
Pentium Pro processor and the Pentium processor with MMX technology."

I suppose that if the CPU has MMX, then it's ok to write 1 in PCE
bit. This should be valid for Intel CPUs, but it's certainly possible that
there are non-Intel CPUs that have MMX but not RDPMC. However, I'd guess
that writing 1 to PCE bit doesn't do any harm.

Security considerations: same as with RDTSC, I guess?

Tested on AMD Athlon 800 MHz.

Please keep me on the CC list, because majordomo doesn't allow me to
subscribe to the mailing list.

Request: has anyone links to using MSRs on Linux? It seems that three
persons have done work on MSR support: Stephen Meyer, Peter Anvin and
Richard Gooch. From Richard's pages I found some user-space libraries, but
they don't seem to work with current kernels?

--- linux-2.4.0/include/asm-i386/processor.h	Tue Jan 16 15:00:57 2001
+++ linux-2.4.0-tt/include/asm-i386/processor.h	Thu Jan 18 16:39:39 2001
@@ -88,6 +88,7 @@
 #define cpu_has_fxsr	(test_bit(X86_FEATURE_FXSR, boot_cpu_data.x86_capability))
 #define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
 #define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
+#define cpu_has_mmx	(test_bit(X86_FEATURE_MMX,  boot_cpu_data.x86_capability))
 
 extern char ignore_irq13;
 
--- linux-2.4.0/arch/i386/kernel/setup.c	Sun Dec 31 20:26:18 2000
+++ linux-2.4.0-tt/arch/i386/kernel/setup.c	Thu Jan 18 16:57:51 2001
@@ -2215,6 +2215,14 @@
 
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
+	if (cpu_has_mmx	/* Suppose that if CPU has MMX, it also has PCE */
+#ifndef CONFIG_X86_TSC
+		&& !tsc_disable	/* Don't enable RDPMC if TSC is disabled */
+#endif	
+	) {
+		printk("Enabling performance monitoring counters...\n");
+		set_in_cr4(X86_CR4_PCE);
+	}
 #ifndef CONFIG_X86_TSC
 	if (tsc_disable && cpu_has_tsc) {
 		printk("Disabling TSC...\n");


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
