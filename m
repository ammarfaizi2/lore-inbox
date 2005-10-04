Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVJDPLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVJDPLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJDPLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:11:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60635 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964796AbVJDPK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:10:59 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <fastboot@osdl.org>
Subject: [PATCH] i386 kexec-on-panic: Don't shutdown the apics.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 09:09:36 -0600
Message-ID: <m1br258gjz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is dangerous to shutdown the apics in machine_crash_shutdown.

With my previous patch to initialize apics in init_IRQ we should be
able to boot a kernel without this.  As long as we reinitialize the APICs
we don't care what state they were in during bootup.

This should make machine_crash_shutdown noticeably more reliable.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/i386/kernel/crash.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

cc07e81f8993ad1a4b8b1a51a2e12bae957a4604
diff --git a/arch/i386/kernel/crash.c b/arch/i386/kernel/crash.c
--- a/arch/i386/kernel/crash.c
+++ b/arch/i386/kernel/crash.c
@@ -21,7 +21,6 @@
 #include <asm/hardirq.h>
 #include <asm/nmi.h>
 #include <asm/hw_irq.h>
-#include <asm/apic.h>
 #include <mach_ipi.h>
 
 
@@ -148,7 +147,6 @@ static int crash_nmi_callback(struct pt_
 		regs = &fixed_regs;
 	}
 	crash_save_this_cpu(regs, cpu);
-	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
 	halt();
@@ -188,7 +186,6 @@ static void nmi_shootdown_cpus(void)
 	}
 
 	/* Leave the nmi callback set */
-	disable_local_APIC();
 }
 #else
 static void nmi_shootdown_cpus(void)
@@ -213,9 +210,5 @@ void machine_crash_shutdown(struct pt_re
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
 	crashing_cpu = smp_processor_id();
 	nmi_shootdown_cpus();
-	lapic_shutdown();
-#if defined(CONFIG_X86_IO_APIC)
-	disable_IO_APIC();
-#endif
 	crash_save_self(regs);
 }
