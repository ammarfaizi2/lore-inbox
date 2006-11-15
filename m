Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbWKOJel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbWKOJel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 04:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932822AbWKOJel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 04:34:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34224 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932669AbWKOJek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 04:34:40 -0500
Date: Wed, 15 Nov 2006 10:33:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: sleeping functions called in invalid context during resume
Message-ID: <20061115093354.GA30813@elte.hu>
References: <20061114223002.10c231bd@localhost.localdomain> <20061115012025.13c72fc1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115012025.13c72fc1.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0004]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  [<ffffffff80215059>] vfs_write+0xce/0x174
> >  [<ffffffff802159a5>] sys_write+0x45/0x6e
> >  [<ffffffff802593de>] system_call+0x7e/0x83
> > DWARF2 unwinder stuck at system_call+0x7e/0x83
> > 
> > Leftover inexact backtrace:
> 
> Could mean that someone somewhere forgot to release a spinlock.
> 
> Ingo had a patch which would find the culprit (preempt-tracing.patch).
> 
> Does it still live?

if it's really a spinlock/rwlock release that was missed, then i've got 
good news: we already have that debugging infrastructure, it's called 
lockdep :-)

The patch below makes use of that capability of lockdep for all 
stackdumps that are printed to the console. Stephen, please apply this 
patch, enable CONFIG_PROVE_LOCKING and try to trigger another message. 

	Ingo

---------------->
Subject: lockdep: show held locks when showing a stackdump
From: Ingo Molnar <mingo@elte.hu>

show held locks when printing a backtrace.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/i386/kernel/traps.c   |    1 +
 arch/x86_64/kernel/traps.c |    1 +
 2 files changed, 2 insertions(+)

Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -318,6 +318,7 @@ static void show_stack_log_lvl(struct ta
 	}
 	printk("\n%sCall Trace:\n", log_lvl);
 	show_trace_log_lvl(task, regs, esp, log_lvl);
+	debug_show_held_locks(task);
 }
 
 void show_stack(struct task_struct *task, unsigned long *esp)
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -405,6 +405,7 @@ show_trace(struct task_struct *tsk, stru
 	printk("\nCall Trace:\n");
 	dump_trace(tsk, regs, stack, &print_trace_ops, NULL);
 	printk("\n");
+	debug_show_held_locks(tsk);
 }
 
 static void
