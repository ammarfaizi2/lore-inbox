Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWFIJAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWFIJAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 05:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFIJAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 05:00:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54226 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932188AbWFIJAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 05:00:08 -0400
Date: Fri, 9 Jun 2006 10:59:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch, -rc6-mm1] irqflags tracing: fix x86_64 entry/exit
Message-ID: <20060609085920.GA4869@elte.hu>
References: <20060608213809.101161b0@localhost> <20060608215935.37c52bff@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608215935.37c52bff@localhost>
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


* Paolo Ornati <ornati@fastwebnet.it> wrote:

> Wow, now I can reproduce it easly :)
> 
> Just run under "gdb" a program that segfaults:
> 
> void main(void)
> {
>         *(int*)(0) = 1;
> }
> 
> and it will trigger.

thanks - please try the fix below - it has solved the problem on my 
testbox.

	Ingo

-------------
Subject: irqflags tracing: fix x86_64 entry/exit
From: Ingo Molnar <mingo@elte.hu>

the x86_64 portion of the irqflags code did not properly trace the
"paranoid userspace" type of syscall/ptrace exit variant.

A testcase Paolo Ornati has discovered triggers a lock validator
assert due to this bug.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/entry.S |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -50,9 +50,10 @@
 #define retint_kernel retint_restore_args
 #endif	
 
-.macro TRACE_IRQS_IRETQ
+
+.macro TRACE_IRQS_IRETQ offset=ARGOFFSET
 #ifdef CONFIG_TRACE_IRQFLAGS
-	bt   $9,EFLAGS-ARGOFFSET(%rsp)	/* interrupts off? */
+	bt   $9,EFLAGS-\offset(%rsp)	/* interrupts off? */
 	jnc  1f
 	TRACE_IRQS_ON
 1:
@@ -809,9 +810,9 @@ error_exit:		
 	andl  %edi,%edx
 	jnz  retint_careful
 	/*
-	 * The iret will restore flags:
+	 * The iret might restore flags:
 	 */
-	TRACE_IRQS_ON
+	TRACE_IRQS_IRETQ
 	swapgs 
 	RESTORE_ARGS 0,8,0						
 	jmp iret_label
@@ -999,6 +1000,7 @@ paranoid_exit:
 	testl $3,CS(%rsp)
 	jnz   paranoid_userspace
 paranoid_swapgs:	
+	TRACE_IRQS_IRETQ 0
 	swapgs
 paranoid_restore:	
 	RESTORE_ALL 8
