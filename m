Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWILH7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWILH7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWILH7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:59:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:47256 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964997AbWILH7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:59:14 -0400
Date: Tue, 12 Sep 2006 09:50:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Brandon Philips <brandon@ifup.org>,
       linux-kernel@vger.kernel.org, Brice Goglin <brice@myri.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Robert Love <rml@novell.com>
Subject: [patch] genirq/MSI: restore __do_IRQ() compat logic temporarily
Message-ID: <20060912075047.GA10641@elte.hu>
References: <20060908174437.GA5926@plankton.ifup.org> <20060908121319.11a5dbb0.akpm@osdl.org> <20060908194300.GA5901@plankton.ifup.org> <20060908125053.c31b76e9.akpm@osdl.org> <20060911021400.GA6163@plankton.ifup.org> <20060911095106.2a7d6d95.akpm@osdl.org> <m1lkop7gi5.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lkop7gi5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Ok.  Looking at it I almost certain the problem is that
> we lost the hunk of code removed in: 266f0566761cf88906d634727b3d9fc2556f5cbd
> i386: Fix stack switching in do_IRQ
> 
> -       if (!irq_desc[irq].handle_irq) {
> -               __do_IRQ(irq, regs);
> -               goto out_exit;
> -       }
> 
> The msi code does not yet set desc->handle_irq.  So when we attempt to 
> call it we get a NULL pointer dereference.

indeed ... We thought the MSI cleanup went all the way with the irqchips 
conversion, that's we suggested to Andrew to drop this chunk in -mm too.

> Except for adding that hunk back in and breaking 4K stacks I don't 
> have an immediate fix.

i've attached a bandaid patch for -mm below. Brandon, does this solve 
the crash you are seeing?

> I do have a pending cleanup that should result in us setting 
> handle_irq in all cases.  I will see if I can advance that shortly.

yeah, that's the right solution.

	Ingo

------------------>
Subject: [patch] genirq/MSI: restore __do_IRQ() compat logic temporarily
From: Ingo Molnar <mingo@elte.hu>

restore the __do_IRQ() compat logic temporarily, until the MSI
genirq conversion has been completed.

disable 4KSTACKS temporarily too.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/i386/Kconfig.debug |    4 ++++
 arch/i386/kernel/irq.c  |    5 +++++
 2 files changed, 9 insertions(+)

Index: linux-2.6.18-rc6-mm1/arch/i386/Kconfig.debug
===================================================================
--- linux-2.6.18-rc6-mm1.orig/arch/i386/Kconfig.debug
+++ linux-2.6.18-rc6-mm1/arch/i386/Kconfig.debug
@@ -56,8 +56,12 @@ config DEBUG_RODATA
 	  portion of the kernel code won't be covered by a 2MB TLB anymore.
 	  If in doubt, say "N".
 
+#
+# FIXME: Disabled temporarily until the MSI genirq conversion is done!
+#
 config 4KSTACKS
 	bool "Use 4Kb + 4Kb for kernel stacks instead of 8Kb" if DEBUG_KERNEL
+	depends on n
 	default y
 	help
 	  If you say Y here the kernel will use a 4Kb stacksize for the
Index: linux-2.6.18-rc6-mm1/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.18-rc6-mm1.orig/arch/i386/kernel/irq.c
+++ linux-2.6.18-rc6-mm1/arch/i386/kernel/irq.c
@@ -83,6 +83,10 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	if (!irq_desc[irq].handle_irq) {
+		__do_IRQ(irq, regs);
+		goto out_exit;
+	}
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
@@ -123,6 +127,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 #endif
 		desc->handle_irq(irq, desc, regs);
 
+out_exit:
 	irq_exit();
 
 	return 1;
