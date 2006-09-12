Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWILRDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWILRDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWILRDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:03:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39043 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030284AbWILRDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:03:24 -0400
Date: Tue, 12 Sep 2006 18:54:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjanv@infradead.org
Subject: Re: lockdep warning in check_flags()
Message-ID: <20060912165448.GA5751@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org> <20060909083523.GG1121@slug> <20060911054335.GC11269@elte.hu> <20060912141335.GM3775@slug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912141335.GM3775@slug>
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


* Frederik Deweerdt <deweerdt@free.fr> wrote:

> On Mon, Sep 11, 2006 at 07:43:35AM +0200, Ingo Molnar wrote:
> > 
> > * Frederik Deweerdt <deweerdt@free.fr> wrote:
> > 
> > > Lockdep issues the following warning:
> > > 
> > > [   16.835268] Freeing unused kernel memory: 260k freed
> > > [   16.842715] Write protecting the kernel read-only data: 432k
> > > [   17.796518] BUG: warning at kernel/lockdep.c:2359/check_flags()
> > 
> > this warning means that the "soft" and "hard" hardirqs-disabled state 
> > got out of sync: the irqtrace tracking code thinks that hardirqs are 
> > disabled, while in reality they are enabled. The thing to watch for are 
> > new "stii" instructions in entry.S (and other assembly code), without a 
> > matching TRACE_HARDIRQS_ON call. [Another, rarer possiblity is NMI code 
> > saving/restoring interrupts - do you have NMIs enabled? (are there any 
> > NMI counts in /proc/interrupts?)]
> NMIs were disabled. But I've just booted -mm2 and the warning went away.
> Could this be related to the recent pda changes?

yeah, it could be related to the fix below. Can you confirm that by 
applying this to your -mm1 tree the message goes away?

	Ingo

--------------->
Subject: [patch] i386-PDA, lockdep: fix %gs restore
From: Ingo Molnar <mingo@elte.hu>

in the syscall exit path the %gs selector has to be restored _after_ the
last kernel function has been called. If lockdep is enabled then this
kernel function is TRACE_IRQS_ON.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/i386/kernel/entry.S |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S
+++ linux/arch/i386/kernel/entry.S
@@ -326,11 +326,12 @@ sysenter_past_esp:
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
 /* if something modifies registers it must also disable sysexit */
-1:	mov  PT_GS(%esp), %gs
+1:
+	TRACE_IRQS_ON
+	mov  PT_GS(%esp), %gs
 	movl PT_EIP(%esp), %edx
 	movl PT_OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
-	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS_SYSEXIT
 	CFI_ENDPROC
 .pushsection .fixup,"ax";	\
