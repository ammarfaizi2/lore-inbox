Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbWEaPUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWEaPUM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 11:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWEaPUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 11:20:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21909 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965063AbWEaPUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 11:20:10 -0400
Date: Wed, 31 May 2006 17:20:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] lock validator: irqflags-trace entry.S fix
Message-ID: <20060531152030.GA15553@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605310651u61b9756fpfce3515ab046bf42@mail.gmail.com> <20060531140201.GA11617@elte.hu> <20060531141208.GA12296@elte.hu> <6bffcb0e0605310805l5e040e06i8ccc376a88667c34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0605310805l5e040e06i8ccc376a88667c34@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> >here's the fix for the irqs-off iret irqflags-tracing problem. Does this
> >fix the bug(s) on your box?
> 
> Yes. Thanks!

great! Here's the cleaned up fix for Andrew:

----------------------------
Subject: lock validator: irqflags-trace entry.S fix
From: Ingo Molnar <mingo@elte.hu>

this fixes the irqflags-tracing bug reported (and relentlessly
debugged) by Michal Piotrowski: if we took a fault while interrupts
were disabled (for example of a vmalloc area) then irqflags-tracing
mistakenly assumed that the iret would re-enable interrupts.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/i386/kernel/entry.S |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S
+++ linux/arch/i386/kernel/entry.S
@@ -84,6 +84,15 @@ VM_MASK		= 0x00020000
 #define resume_kernel		restore_nocheck
 #endif
 
+.macro TRACE_IRQS_IRET
+#ifdef CONFIG_TRACE_IRQFLAGS
+	testl $IF_MASK,EFLAGS(%esp)     # interrupts off?
+	jz 1f
+	TRACE_IRQS_ON
+1:
+#endif
+.endm
+
 #ifdef CONFIG_VM86
 #define resume_userspace_sig	check_userspace
 #else
@@ -364,7 +373,7 @@ restore_all:
 	CFI_REMEMBER_STATE
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
-	TRACE_IRQS_ON
+	TRACE_IRQS_IRET
 restore_nocheck_notrace:
 	RESTORE_REGS
 	addl $4, %esp
@@ -404,7 +413,7 @@ ldt_ss:
 	 * and a switch16 pointer on top of the current frame. */
 	call setup_x86_bogus_stack
 	CFI_ADJUST_CFA_OFFSET -8	# frame has moved
-	TRACE_IRQS_ON
+	TRACE_IRQS_IRET
 	RESTORE_REGS
 	lss 20+4(%esp), %esp	# switch to 16bit stack
 1:	iret
