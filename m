Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVASHy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVASHy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVASHyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:54:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51647 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261626AbVASHdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:20 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 24/29] x86-crash_shutdown-apic-shutdown
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-crash-shutdown-apic-shutdown-11061198971134@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-crash-shutdown-snapshot-registers-11061198972173@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
	<x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
	<x86-64-crashkernel-11061198971876@ebiederm.dsl.xmission.com>
	<kexec-ppc-support-11061198973302@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-nmi-shootdown-11061198973234@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-snapshot-registers-11061198972173@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch should not make it to the stable kernel without a being
reviewed a lot more.  It is unclear how much a hardned kernel can
take when it comes to misconfigured apics.  So since a normal kernel
has problems this patch does a clean shutdown.

It is my expectation this patch will be dropped from future
generations of the kexec work.  But for the moment it is a 
crutch to keep from breaking everything.


Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 crash.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-snapshot-registers/arch/i386/kernel/crash.c linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-apic-shutdown/arch/i386/kernel/crash.c
--- linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-snapshot-registers/arch/i386/kernel/crash.c	Tue Jan 18 23:15:34 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-apic-shutdown/arch/i386/kernel/crash.c	Tue Jan 18 23:15:50 2005
@@ -23,6 +23,7 @@
 #include <asm/hardirq.h>
 #include <asm/nmi.h>
 #include <asm/hw_irq.h>
+#include <asm/apic.h>
 #include <mach_ipi.h>
 
 #define MAX_NOTE_BYTES 1024
@@ -115,6 +116,7 @@
 {
 	local_irq_disable();
 	crash_save_this_cpu(regs, cpu);
+	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
 	__asm__("hlt");
@@ -153,6 +155,7 @@
 	}
 	
 	/* Leave the nmi callback set */
+	disable_local_APIC();
 }
 #else
 static void nmi_shootdown_cpus(void)
@@ -174,5 +177,9 @@
 	/* The kernel is broken so disable interrupts */
 	local_irq_disable();
 	nmi_shootdown_cpus();
+	lapic_shutdown();
+#if defined(CONFIG_X86_IO_APIC)
+	disable_IO_APIC();
+#endif
 	crash_save_self();
 }
