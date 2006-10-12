Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWJLINX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWJLINX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWJLINX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:13:23 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:14844 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932494AbWJLINW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:13:22 -0400
Subject: [PATCH] lockdep: annotate i386 apm
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061012002906.dd29c376.akpm@osdl.org>
References: <1160574022.2006.82.camel@taijtu>
	 <20061011141813.79fb278f.akpm@osdl.org> <1160633180.2006.94.camel@taijtu>
	 <20061011233925.c9ba117a.akpm@osdl.org> <1160635850.2006.98.camel@taijtu>
	 <20061012002906.dd29c376.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 10:13:34 +0200
Message-Id: <1160640814.2006.102.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so how about this:

---
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
 arch/i386/kernel/apm.c |   37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

Index: linux-2.6.18.noarch/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.18.noarch.orig/arch/i386/kernel/apm.c
+++ linux-2.6.18.noarch/arch/i386/kernel/apm.c
@@ -539,11 +539,30 @@ static inline void apm_restore_cpus(cpum
  * Also, we KNOW that for the non error case of apm_bios_call, there
  * is no useful data returned in the low order 8 bits of eax.
  */
-#define APM_DO_CLI	\
-	if (apm_info.allow_ints) \
-		local_irq_enable(); \
-	else \
+
+static inline unsigned long __apm_irq_save(void)
+{
+	unsigned long flags;
+	local_save_flags(flags);
+	if (apm_info.allow_ints) {
+		if (irqs_disabled_flags(flags))
+			local_irq_enable();
+	} else
+		local_irq_disable();
+
+	return flags;
+}
+
+#define apm_irq_save(flags) \
+	do { flags = __apm_irq_save(); } while (0)
+
+static inline void apm_irq_restore(unsigned long flags)
+{
+	if (irqs_disabled_flags(flags))
 		local_irq_disable();
+	else if (irqs_disabled())
+		local_irq_enable();
+}
 
 #ifdef APM_ZERO_SEGS
 #	define APM_DECL_SEGS \
@@ -595,12 +614,11 @@ static u8 apm_bios_call(u32 func, u32 eb
 	save_desc_40 = gdt[0x40 / 8];
 	gdt[0x40 / 8] = bad_bios_desc;
 
-	local_save_flags(flags);
-	APM_DO_CLI;
+	apm_irq_save(flags);
 	APM_DO_SAVE_SEGS;
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
 	APM_DO_RESTORE_SEGS;
-	local_irq_restore(flags);
+	apm_irq_restore(flags);
 	gdt[0x40 / 8] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
@@ -639,12 +657,11 @@ static u8 apm_bios_call_simple(u32 func,
 	save_desc_40 = gdt[0x40 / 8];
 	gdt[0x40 / 8] = bad_bios_desc;
 
-	local_save_flags(flags);
-	APM_DO_CLI;
+	apm_irq_save(flags);
 	APM_DO_SAVE_SEGS;
 	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
 	APM_DO_RESTORE_SEGS;
-	local_irq_restore(flags);
+	apm_irq_restore(flags);
 	gdt[0x40 / 8] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);


