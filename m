Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRCUBYf>; Tue, 20 Mar 2001 20:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRCUBYZ>; Tue, 20 Mar 2001 20:24:25 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:31800 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129486AbRCUBYH>; Tue, 20 Mar 2001 20:24:07 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: nigel@nrg.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Tue, 20 Mar 2001 16:48:01 -0800."
             <Pine.LNX.4.05.10103201625430.26853-100000@cosmic.nrg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Mar 2001 12:23:20 +1100
Message-ID: <16074.985137800@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001 16:48:01 -0800 (PST), 
Nigel Gamble <nigel@nrg.org> wrote:
>On Tue, 20 Mar 2001, Keith Owens wrote:
>> The preemption patch only allows preemption from interrupt and only for
>> a single level of preemption.  That coexists quite happily with
>> synchronize_kernel() which runs in user context.  Just count user
>> context schedules (preempt_count == 0), not preemptive schedules.
>
>If you're looking at preempt_schedule(), note the call to ctx_sw_off()
>only increments current->preempt_count for the preempted task - the
>higher priority preempting task that is about to be scheduled will have
>a preempt_count of 0.

I misread the code, but the idea is still correct.  Add a preemption
depth counter to each cpu, when you schedule and the depth is zero then
you know that the cpu is no longer holding any references to quiesced
structures.

>So, to make sure I understand this, the code to free a node would look
>like:
>
>	prev->next = node->next; /* assumed to be atomic */
>	synchronize_kernel();
>	free(node);
>
>So that any other CPU concurrently traversing the list would see a
>consistent state, either including or not including "node" before the
>call to synchronize_kernel(); but after synchronize_kernel() all other
>CPUs are guaranteed to see a list that no longer includes "node", so it
>is now safe to free it.
>
>It looks like there are also implicit assumptions to this approach, like
>no other CPU is trying to use the same approach simultaneously to free
>"prev".

Not quite.  The idea is that readers can traverse lists without locks,
code that changes the list needs to take a semaphore first.

Read
	node = node->next;

Update
	down(&list_sem);
	prev->next = node->next;
	synchronize_kernel();
	free(node);
	up(&list_sem);

Because the readers have no locks, other cpus can have references to
the node being freed.  The updating code needs to wait until all other
cpus have gone through at least one schedule to ensure that all
dangling references have been flushed.  Adding preemption complicates
this slightly, we have to distinguish between the bottom level schedule
and higher level schedules for preemptive code.  Only when all
preemptive code on a cpu has ended is it safe to say that there are no
dangling references left on that cpu.

This method is a win for high read, low update lists.  Instead of
penalizing the read code every time on the off chance that somebody
will update the data, speed up the common code and penalize the update
code.  The classic example is module code, it is rarely unloaded but
right now everything that *might* be entering a module has to grab the
module spin lock and update the module use count.  So main line code is
being slowed down all the time.

