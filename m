Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132549AbRC1U5F>; Wed, 28 Mar 2001 15:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132437AbRC1U4k>; Wed, 28 Mar 2001 15:56:40 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:5970 "EHLO c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP id <S132552AbRC1U4P>; Wed, 28 Mar 2001 15:56:15 -0500
Message-ID: <3AC24EB6.1F0DD551@mvista.com>
Date: Wed, 28 Mar 2001 12:51:02 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dipankar Sarma <dipankar@sequent.com>
CC: nigel@nrg.org, linux-kernel@vger.kernel.org, mckenney@sequent.com
Subject: Re: [PATCH for 2.5] preemptible kernel
References: <16074.985137800@kao2.melbourne.sgi.com> <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org> <3AC1BAD3.BBBD97E1@sequent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> Nigel Gamble wrote:
> >
> > On Wed, 21 Mar 2001, Keith Owens wrote:
> > > I misread the code, but the idea is still correct.  Add a preemption
> > > depth counter to each cpu, when you schedule and the depth is zero then
> > > you know that the cpu is no longer holding any references to quiesced
> > > structures.
> >
> > A task that has been preempted is on the run queue and can be
> > rescheduled on a different CPU, so I can't see how a per-CPU counter
> > would work.  It seems to me that you would need a per run queue
> > counter, like the example I gave in a previous posting.
> 
> Also, a task could be preempted and then rescheduled on the same cpu
> making
> the depth counter 0 (right ?), but it could still be holding references
> to data
> structures to be updated using synchronize_kernel(). There seems to be
> two
> approaches to tackle preemption -
> 
> 1. Disable pre-emption during the time when references to data
> structures
> updated using such Two-phase updates are held.

Doesn't this fly in the face of the whole Two-phase system?  It seems to
me that the point was to not require any locks.  Preemption disable IS a
lock.  Not as strong as some, but a lock none the less.
> 
> Pros: easy to implement using a flag (ctx_sw_off() ?)
> Cons: not so easy to use since critical sections need to be clearly
> identified and interfaces defined. also affects preemptive behavior.
> 
> 2. In synchronize_kernel(), distinguish between "natural" and preemptive
> schedules() and ignore preemptive ones.
> 
> Pros: easy to use
> Cons: Not so easy to implement. Also a low priority task that keeps
> getting
> preempted often can affect update side performance significantly.

Actually is is fairly easy to distinguish the two (see TASK_PREEMPTED in
state).  Don't you also have to have some sort of task flag that
indicates that the task is one that needs to sync?  Something that gets
set when it enters the area of interest and cleared when it hits the
sync point?  

George
