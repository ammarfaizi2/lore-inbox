Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVHKPeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVHKPeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVHKPeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:34:23 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:27370 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751098AbVHKPeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:34:22 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: 2.6.13-rc4-mm1: Divide by zero in find_idlest_group
Date: Fri, 12 Aug 2005 01:27:39 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <1123773675.9252.11.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1123773675.9252.11.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508120127.39436.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005 01:21 am, Dave Kleikamp wrote:
> I encounted this trap on a 2-way i386 box running 2.6.13-rc4-mm1:
>
> [70347.743727] divide error: 0000 [#2]
> [70347.752979] PREEMPT SMP DEBUG_PAGEALLOC
> [70347.773060] last sysfs file: /devices/pnp0/00:11/id
>
> Program received signal SIGTRAP, Trace/breakpoint trap.
> 0xc0119556 in find_idlest_group (sd=0xc1084dc0, p=0xc3b96030, this_cpu=0)
>     at sched.c:1033
> 1033                    target_load = target_load * rq->prio_bias /
> rq->nr_running;
>
> (gdb) where
> #0  0xc0119556 in find_idlest_group (sd=0xc1084dc0, p=0xc3b96030,
> this_cpu=0) at sched.c:1033
> #1  0xc0119744 in sched_balance_self (cpu=0, flag=4) at sched.c:1151
> #2  0xc011a63f in sched_exec () at sched.c:1840
> #3  0xc016cacb in do_execve (filename=0xc3e35000 "/bin/sh",
> argv=0xbfff512c, envp=0xbfff6010, regs=0xa00) at exec.c:1162
> #4  0xc0101b5a in sys_execve (regs=
>       {ebx = -1208173323, ecx = -1073786580, edx = -1073782768, esi =
> -1073782768, edi = -1208107392, ebp = -1073786620, eax = 11, xds = 123, xes
> = -1072693125, orig_eax = 11, eip = -1208664822, xcs = 115, eflags = 658,
> esp = -1073786628, xss = 123}) at process.c:787 #5  0xc0102fdd in
> syscall_call () at current.h:9
> #6  0xb7fcbcf5 in ?? ()
>
> print *(struct runqueue *)0xc108c400
> $1 = {lock = {raw_lock = {slock = 1}, break_lock = 0}, nr_running = 0,
>   prio_bias = 0, cpu_load = {0, 0, 0}, nr_switches = 8877527,
>   nr_uninterruptible = 132930, expired_timestamp = 0,
>   timestamp_last_tick = 70347783539837, curr = 0xc1103550, idle =
> 0xc1103550, prev_mm = 0x0, active = 0xc108c8c0, expired = 0xc108c448,
> arrays = {{ nr_active = 0, bitmap = {0, 0, 0, 0, 4096}, queue = {{next =
> 0xc108c460, prev = 0xc108c460}, {next = 0xc108c468, prev = 0xc108c468}, {
> next = 0xc108c470, prev = 0xc108c470}, {next = 0xc108c478, prev =
> 0xc108c478}, {next = 0xc108c480, prev = 0xc108c480}, { next = 0xc108c488,
> prev = 0xc108c488}, {next = 0xc108c490,
>
> in __source_load, it looks like rq_nr_running must have changed between
> the if statement and the divide:
>
>         if (rq->nr_running > 1 || (idle == NOT_IDLE && rq->nr_running))
>                 /*
>                  * If we are busy rebalancing the load is biased by
>                  * priority to create 'nice' support across cpus. When
>                  * idle rebalancing we should only bias the source_load if
>                  * there is more than one task running on that queue to
>                  * prevent idle rebalance from trying to pull tasks from a
>                  * queue with only one running task.
>                  */
>                 source_load = source_load * rq->prio_bias / rq->nr_running;
>
> Should there be any locking around this?  Or should the value of
> rq->nr_running be saved to a local variable as in this untested patch?

Very sneaky..

On initial inspection your patch makes complete sense. I see no point in 
adding locking to this function as the accuracy is not critical. Want to give 
your patch a run and then push it to akpm? Thanks!

Cheers,
Con
