Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWEaOLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWEaOLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWEaOLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:11:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:48289 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965035AbWEaOLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:11:48 -0400
Date: Wed, 31 May 2006 16:12:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531141208.GA12296@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605310651u61b9756fpfce3515ab046bf42@mail.gmail.com> <20060531140201.GA11617@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531140201.GA11617@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> i think what happened is that the pagefault happened with irqs 
> disabled, and the entry.S return-to-exception-site irq-flags tracing 
> code mistakenly turned on the irq flag - causing the mismatch and 
> lockdep's confusion.

here's the fix for the irqs-off iret irqflags-tracing problem. Does this 
fix the bug(s) on your box?

	Ingo

Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S
+++ linux/arch/i386/kernel/entry.S
@@ -364,6 +364,8 @@ restore_all:
 	CFI_REMEMBER_STATE
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
+	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
+	jz restore_nocheck_notrace
 	TRACE_IRQS_ON
 restore_nocheck_notrace:
 	RESTORE_REGS
@@ -404,7 +406,10 @@ ldt_ss:
 	 * and a switch16 pointer on top of the current frame. */
 	call setup_x86_bogus_stack
 	CFI_ADJUST_CFA_OFFSET -8	# frame has moved
+	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
+	jz restore_nocheck_notrace2
 	TRACE_IRQS_ON
+restore_nocheck_notrace2:
 	RESTORE_REGS
 	lss 20+4(%esp), %esp	# switch to 16bit stack
 1:	iret
