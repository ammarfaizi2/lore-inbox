Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758295AbWLCSQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295AbWLCSQv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758765AbWLCSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 13:16:51 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:6346 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1758295AbWLCSQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 13:16:50 -0500
Date: Sun, 3 Dec 2006 21:16:43 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] i386/kernel/smp.c: don't use set_irq_regs()
Message-ID: <20061203181642.GA226@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to setup _irq_regs in smp_xxx_interrupt (except apic timer).
These handlers run with irqs disabled and do not call functions which need
"struct pt_regs".

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 19-rc6/arch/i386/kernel/smp.c~regs	2006-11-17 19:42:22.000000000 +0300
+++ 19-rc6/arch/i386/kernel/smp.c	2006-12-03 20:51:41.000000000 +0300
@@ -321,7 +321,6 @@ static inline void leave_mm (unsigned lo
 
 fastcall void smp_invalidate_interrupt(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned long cpu;
 
 	cpu = get_cpu();
@@ -352,7 +351,6 @@ fastcall void smp_invalidate_interrupt(s
 	smp_mb__after_clear_bit();
 out:
 	put_cpu_no_resched();
-	set_irq_regs(old_regs);
 }
 
 static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
@@ -607,14 +605,11 @@ void smp_send_stop(void)
  */
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	ack_APIC_irq();
-	set_irq_regs(old_regs);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	void (*func) (void *info) = call_data->func;
 	void *info = call_data->info;
 	int wait = call_data->wait;
@@ -637,7 +632,6 @@ fastcall void smp_call_function_interrup
 		mb();
 		atomic_inc(&call_data->finished);
 	}
-	set_irq_regs(old_regs);
 }
 
 /*

