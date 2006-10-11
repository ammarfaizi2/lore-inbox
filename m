Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWJKNkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWJKNkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWJKNkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:40:14 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.16]:8010 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161050AbWJKNkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:40:11 -0400
Subject: [PATCH] lockdep: annotate i386 apm
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: sfr@canb.auug.org.au, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 15:40:22 +0200
Message-Id: <1160574022.2006.82.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lockdep doesn't like to enable interrupts when they are enabled already.

BUG: warning at kernel/lockdep.c:1814/trace_hardirqs_on() (Not tainted)
 [<c04051ed>] show_trace_log_lvl+0x58/0x16a
 [<c04057fa>] show_trace+0xd/0x10
 [<c0405913>] dump_stack+0x19/0x1b
 [<c043abfb>] trace_hardirqs_on+0xa2/0x11e
 [<c041463c>] apm_bios_call_simple+0xcd/0xfd
 [<c0415242>] apm+0x92/0x5b1
 [<c0402005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c04057fa>] show_trace+0xd/0x10
 [<c0405913>] dump_stack+0x19/0x1b
 [<c043abfb>] trace_hardirqs_on+0xa2/0x11e
 [<c041463c>] apm_bios_call_simple+0xcd/0xfd
 [<c0415242>] apm+0x92/0x5b1
 [<c0402005>] kernel_thread_helper+0x5/0xb

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/i386/kernel/apm.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

Index: linux-2.6.18.noarch/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.18.noarch.orig/arch/i386/kernel/apm.c
+++ linux-2.6.18.noarch/arch/i386/kernel/apm.c
@@ -539,11 +539,22 @@ static inline void apm_restore_cpus(cpum
  * Also, we KNOW that for the non error case of apm_bios_call, there
  * is no useful data returned in the low order 8 bits of eax.
  */
-#define APM_DO_CLI	\
-	if (apm_info.allow_ints) \
-		local_irq_enable(); \
-	else \
-		local_irq_disable();
+#define APM_DO_CLI \
+	do { \
+		if (apm_info.allow_ints) { \
+			if (irqs_disabled_flags(flags)) \
+				local_irq_enable(); \
+		} else \
+			local_irq_disable(); \
+	} while (0)
+
+#define APM_DO_STI \
+	do { \
+		if (irqs_disabled_flags(flags)) \
+			local_irq_disable(); \
+		else if (irqs_disabled()) \
+			local_irq_enable(); \
+	} while (0)
 
 #ifdef APM_ZERO_SEGS
 #	define APM_DECL_SEGS \
@@ -600,7 +611,7 @@ static u8 apm_bios_call(u32 func, u32 eb
 	APM_DO_SAVE_SEGS;
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
 	APM_DO_RESTORE_SEGS;
-	local_irq_restore(flags);
+	APM_DO_STI;
 	gdt[0x40 / 8] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
@@ -644,7 +655,7 @@ static u8 apm_bios_call_simple(u32 func,
 	APM_DO_SAVE_SEGS;
 	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
 	APM_DO_RESTORE_SEGS;
-	local_irq_restore(flags);
+	APM_DO_STI;
 	gdt[0x40 / 8] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);


