Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWJIFon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWJIFon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 01:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWJIFom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 01:44:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27020 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932228AbWJIFom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 01:44:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: [PATCH 1/1] x86_64 irq:  Scream but don't die if we receive an unexpected irq
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610060855220.3952@g5.osdl.org>
	<m1hcyh1hqz.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610061102010.3952@g5.osdl.org>
Date: Sun, 08 Oct 2006 23:41:59 -0600
In-Reply-To: <Pine.LNX.4.64.0610061102010.3952@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 6 Oct 2006 11:08:08 -0700 (PDT)")
Message-ID: <m1psd2rqoo.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Due to code bugs or misbehaving hardware it is possible that we
can receive an interrupt that we have not mapped into a linux irq.
Calling BUG when that happens is very rude, and if the problem
is mild enough prevents anything else from getting done.

So instead of calling BUG just scream loudly about the problem
and continue running.  We don't have enough knowledge to know
which interrupt triggered this behavior so we don't acknowledge it.
This will likely prevent a recurrence of the problem by jamming
up the works with an unacknowledged interrupt.

If the interrupt was something important it is quite possible
that nothing productive will happen past this point.  But
it is now at least possible to keep working if the kernel
can survive without the interrupt we dropped on the floor.

Solutions like irqpoll should generally make dropped irqs non-fatal.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/irq.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
index b8a407f..dff68eb 100644
--- a/arch/x86_64/kernel/irq.c
+++ b/arch/x86_64/kernel/irq.c
@@ -114,16 +114,16 @@ asmlinkage unsigned int do_IRQ(struct pt
 	irq_enter();
 	irq = __get_cpu_var(vector_irq)[vector];
 
-	if (unlikely(irq >= NR_IRQS)) {
-		printk(KERN_EMERG "%s: cannot handle IRQ %d\n",
-					__FUNCTION__, irq);
-		BUG();
-	}
-
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	stack_overflow_check(regs);
 #endif
-	generic_handle_irq(irq);
+
+	if (likely(irq < NR_IRQS))
+		generic_handle_irq(irq);
+	else
+		printk(KERN_EMERG "%s: %d.%d No irq handler for vector\n",
+			__func__, smp_processor_id(), vector);
+
 	irq_exit();
 
 	set_irq_regs(old_regs);
-- 
1.4.2.rc3.g7e18e-dirty

