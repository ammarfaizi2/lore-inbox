Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWAYSHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWAYSHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWAYSHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:07:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:46777 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750949AbWAYSHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:07:43 -0500
Date: Wed, 25 Jan 2006 19:08:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@ftp.linux.org.uk>
Subject: Re: [patch, validator] fix proc_subdir_lock related deadlock
Message-ID: <20060125180811.GA12762@elte.hu>
References: <20060125170331.GA29339@elte.hu> <1138209283.6695.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138209283.6695.55.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > proc_subdir_lock can also be used from softirq (tasklet) context, which 
> > may lead to deadlocks.
> > 
> > This bug was found via the lock validator:
> > 
> 
> Thanks Ingo,
> 
> I stressed in sending the patch that there was a big assumption that 
> the calls would not be done in (soft)irq context.  I just didn't want 
> to add overhead if it wasn't needed.  But I guess that this is needed 
> until we can remove all the instances that use it in softirq context. 
> But that's for a later patch.

the validator just found another problem with this lock, pointing out 
that files_lock nests inside of proc_subdir_lock, and that files_lock is 
a softirq-unsafe lock, creating another (unlikely but possible) deadlock 
scenario:

 =====================================
 [ BUG: lock inversion bug detected! ]
 -------------------------------------
 grep/2290 just changed the state of lock {proc_subdir_lock} at:
  [<c0196e53>] remove_proc_entry+0x33/0x1f0
 but this lock took lock {files_lock} in the past,
 acquired at: [<c0196ece>] remove_proc_entry+0xae/0x1f0
 and interrupts could create an inverse lock dependency between them,
 which could lead to deadlocks!
 other info that might help in debugging this:
 ------------------------------
 | showing all locks held by: |  (grep/2290 [c321c790, 125]):
 ------------------------------

  [<c010432d>] show_trace+0xd/0x10
  [<c0104347>] dump_stack+0x17/0x20
  [<c0137b11>] check_no_lock_2_mask+0x131/0x180
  [<c0137ffb>] mark_lock+0xfb/0x2a0
  [<c01387b3>] debug_lock_chain+0x613/0x10d0
  [<c01392ad>] debug_lock_chain_spin+0x3d/0x60
  [<c02656ed>] _raw_spin_lock+0x2d/0x90
  [<c04d88d2>] _spin_lock_bh+0x12/0x20
  [<c0196e53>] remove_proc_entry+0x33/0x1f0
  [<c01427c9>] unregister_handler_proc+0x19/0x20
  [<c0141f8b>] free_irq+0x7b/0xe0
  [<c02f2302>] floppy_release_irq_and_dma+0x1b2/0x210
  [<c02f07f7>] set_dor+0xc7/0x1b0
  [<c02f3871>] motor_off_callback+0x21/0x30
  [<c01273a5>] run_timer_softirq+0xf5/0x1f0
  [<c0122cf7>] __do_softirq+0x97/0x130
  [<c0105519>] do_softirq+0x69/0x100
  =======================
  [<c01229a9>] irq_exit+0x39/0x50
  [<c010f4cc>] smp_apic_timer_interrupt+0x4c/0x50
  [<c010393b>] apic_timer_interrupt+0x27/0x2c

to solve this we must either change files_lock to be softirq-safe too 
(bleh!), or we must forbid remove_proc_entry() use from softirq 
contexts. Neither is a happy solution - remove_proc_entry() is used 
within free_irq(), and who knows how many drivers do free_irq() in 
softirq/tasklet context ...

Andrew, this needs to be resolved before v2.6.16, correct? Steve's patch 
solves a real bug in the upstream kernel.

	Ingo
