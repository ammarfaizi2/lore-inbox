Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031152AbWKQFGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031152AbWKQFGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031162AbWKQFGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:06:54 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38106 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1031152AbWKQFGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:06:53 -0500
Date: Fri, 17 Nov 2006 05:57:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch] x86_64: stack unwinder crash fix
Message-ID: <20061117045748.GA20387@elte.hu>
References: <20060928192048.GA17436@elte.hu> <45351782.76E4.0078.0@novell.com> <20061116171614.GA4575@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116171614.GA4575@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> Jan,
> 
> in 2.6.19-rc6 i'm getting frequent unwinder failures, like:
[...]

> it's quite an annoyance, i rarely see the unwinder getting a stackdump 
> right, without 'falling back' to the inexact backtrace ...

to make matters worse, i also got an unwinder /crash/ while it tried to 
dump the stack ...

that particular bug is fixed by the patch below - aligning the stack 
pointer solved both the case of corrupted RSP values and corrupted/buggy 
dwarf2 debug info.

Linus, please apply, this is a 2.6.19 must-fix i think.

	Ingo

---------------->
Subject: [patch] x86_64: stack unwinder crash fix
From: Ingo Molnar <mingo@elte.hu>

the new dwarf2 unwinder crashes while trying to dump the stack:

 Leftover inexact backtrace:

 Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff8026cf26>] dump_trace+0x35b/0x3d2
 PGD 203027 PUD 205027 PMD 0
 Oops: 0000 [2] PREEMPT SMP
 CPU 0
 Modules linked in:
 Pid: 30, comm: khelper Not tainted 2.6.19-rc6-rt1 #11
 RIP: 0010:[<ffffffff8026cf26>]  [<ffffffff8026cf26>] dump_trace+0x35b/0x3d2
 RSP: 0000:ffff81003fb9d848  EFLAGS: 00010006
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffffff805b3520 RDI: 0000000000000000
 RBP: ffffffff827ffff9 R08: ffffffff80aad000 R09: 0000000000000005
 R10: ffffffff80aae000 R11: ffffffff8037961b R12: ffff81003fb9d858
 R13: 0000000000000000 R14: ffffffff80598460 R15: ffffffff80ab1fc0
 FS:  0000000000000000(0000) GS:ffffffff806c4200(0000) knlGS:0000000000000000
 CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
 CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0

this crash happened because it did not sanitize the dwarf2 data it
got, and got an unaligned stack pointer - which happily walked past
the process stack (and eventually reached the end of kernel memory
and pagefaulted there) due to this naive iteration condition:

        HANDLE_STACK (((long) stack & (THREAD_SIZE-1)) != 0);

note that i386 is alot more conservative when it comes to trusting
stack pointers:

 static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
 {
         return  p > (void *)tinfo &&
                 p < (void *)tinfo + THREAD_SIZE - 3;
 }

but the x86_64 code did not take this bit of i386 code.

the fix is to align the stack pointer.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/traps.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -290,6 +290,12 @@ void dump_trace(struct task_struct *tsk,
 		if (tsk && tsk != current)
 			stack = (unsigned long *)tsk->thread.rsp;
 	}
+	/*
+	 * Align the stack pointer on word boundary, later loops
+	 * rely on that (and corruption / debug info bugs can cause
+	 * unaligned values here):
+	 */
+	stack = (unsigned long *)((unsigned long)stack & ~(sizeof(long)-1));
 
 	/*
 	 * Print function call entries within a stack. 'cond' is the
