Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266607AbUF3JvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266607AbUF3JvU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266608AbUF3JvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:51:20 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:27818 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S266607AbUF3Ju5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:50:57 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F42FAE@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'andrebalsa@altern.org'" <andrebalsa@altern.org>,
       "'Richard E. Gooch'" <rgooch@atnf.csiro.au>,
       "'Ingo Molnar'" <mingo@elte.hu>, "'rml@tech9.net'" <rml@tech9.net>,
       "'akpm@osdl.org'" <akpm@osdl.org>, "'Con Kolivas'" <kernel@kolivas.org>
Subject: Preemption of the OS system call due to expiration of the time-sl
	ice for: a) SCHED_NORMAL (aka SCHED_OTHER) b) SCHED_RR
Date: Wed, 30 Jun 2004 05:50:33 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con - thanks for your kind answers !

Preemption (due to the expiration of the time-slice) of the process, while
it executes OS system call, -  by another process (of equal or higher
priority) when running under following scheduling policies:

 a) SCHED_NORMAL (aka SCHED_OTHER)
 b) SCHED_RR 

Is it possible in Linux 2.6 ? Linux 2.4 ?

Thanks,
Best Regards,
Alex Povolotsky

-----Original Message-----
From: Con Kolivas [mailto:kernel@kolivas.org]
Sent: Tuesday, June 29, 2004 6:53 PM
To: Povolotsky, Alexander
Cc: 'linux-kernel@vger.kernel.org'; 'andrebalsa@altern.org'; 'Richard E.
Gooch'; 'Ingo Molnar'; 'rml@tech9.net'; 'akpm@osdl.org'
Subject: Re: Linux scheduler (scheduling) questions


Povolotsky, Alexander writes:

> I  have "general"  Linux  OS scheduling  questions, especially with
regards
> as those apply to the (latest) Linux  2.6  scheduler features (would
really
> appreciate if whether/when/while answering those questions listed  below,
> you could pinpoint differences between Linux 2.6 and Linux 2.4 !): 
 
> 0.  I was told that the Linux kernel could be configured with one of the 3
> (? ) different scheduling policies - could someone describe       
>      those to me in details ?
> 2.  Linux 2.6 (I was told it is the same for Linux 2.4.21-15) has
priorities
> 0-99 for RT priorities and 100-139 for normal   (SCHED_NORMAL)   tasks.

> I presume that priorities 0-99 are "recommended" (or enforced ?) for
> Linux kernel "native" tasks ... and "out or reach" for application
> tasks (unless one dares to merge application into the Linux kernel,
> masquerading it as a "system level command" - did anyone tried this ? -
> I presume it is not recommended ...  )  ?

Three different policies are currently supported:
SCHED_NORMAL (also known as SCHED_OTHER) has a soft priority mechanism 
over the 'nice' range of -20 to +19 (static priority of 100-139) which 
decides according to the priority which task goes first, and how much 
timeslice it gets. This system dynamically alters the priority to allow 
interactive tasks to go first, and is designed to prevent starvation of 
lower priority tasks with an expiration policy. 

SCHED_RR is a fixed real time policy over the static range of 0-99 where a 
lower number (higher priority) task will repeatedly go ahead of _any_ tasks 
lower priority than itself. It is called RR because if multiple tasks are at

the same priority it will Round Robin between those tasks. 

SCHED_FIFO is a fixed real time policy the static range of 0-99 where a
lower number (higher priority) task will repeatedly go ahead of _any_ tasks
with lower priority than itself. Unlike RR, if a task does not give up the
cpu it 
will run indefinitely even if other tasks are the same static priority as 
itself.

Unprivileged users are not allowed to set SCHED_RR or SCHED_FIFO because of 
the real risk of these tasks causing starvation.

> 1.   How rescheduling is "induced" in above scheduling policies ?
>      Does at least one of above mentioned scheduling policies uses "clock
>      tick" as a scheduling event ?

Preemption is built into this mechanism where any higher priority task will 
preempt the current running task at any time. SCHED_NORMAL tasks have a 
timeout policy based on scheduler_tick that allows other tasks of the same 
priority to run and considers that task for expiration. SCHED_RR tasks have 
a timeout policy also based on scheduler tick that allows tasks of the same 
priority to run. SCHED_FIFO tasks never time out.

> Under what priority the OS system calls are executed ?

The kernel threads run at different priorities dependent on what they do. 
Run 'top -b -n 1' and you'll see a list of different tasks with the name k* 
that are kernel threads. On SMP systems, the migration thread is SCHED_FIFO 
priority 0 which means it always goes ahead of everything else. The rest of 
the kernel threads vary between SCHED_NORMAL 'nice' -20 to +19 (static 
priority 100-139).

> 3.  Is  priority inversion and its prevention (priority inheritance or
> priority ceilings) applicable to Linux ) for application/user-space tasks
(
> with priorities in the range 100-139) ?

There is no intrinsic mechanism in the kernel to prevent priority inversion.

Generic anti-starvation mechanims minimise the harm that priority inversion 
can do but there can be a lot of wasted cpu cycles for poorly coded 
applications. This is more true of 2.6 than 2.4 because the cpu scheduler 
does far more 'out of order' scheduling where a task can run many many times

dependent on priority before another task will ever run.

Hope this helps,
Cheers,
Con

