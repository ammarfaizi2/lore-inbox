Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130673AbRC1KTD>; Wed, 28 Mar 2001 05:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131740AbRC1KSx>; Wed, 28 Mar 2001 05:18:53 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48091 "EHLO e1.ny.us.ibm.com") by vger.kernel.org with ESMTP id <S130673AbRC1KSh>; Wed, 28 Mar 2001 05:18:37 -0500
Message-ID: <3AC1BAD3.BBBD97E1@sequent.com>
Date: Wed, 28 Mar 2001 15:50:03 +0530
From: Dipankar Sarma <dipankar@sequent.com>
Organization: IBM Linux Technology Center
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: linux-kernel@vger.kernel.org, mckenney@sequent.com
Subject: Re: [PATCH for 2.5] preemptible kernel
References: <16074.985137800@kao2.melbourne.sgi.com> <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:
> 
> On Wed, 21 Mar 2001, Keith Owens wrote:
> > I misread the code, but the idea is still correct.  Add a preemption
> > depth counter to each cpu, when you schedule and the depth is zero then
> > you know that the cpu is no longer holding any references to quiesced
> > structures.
> 
> A task that has been preempted is on the run queue and can be
> rescheduled on a different CPU, so I can't see how a per-CPU counter
> would work.  It seems to me that you would need a per run queue
> counter, like the example I gave in a previous posting.

Also, a task could be preempted and then rescheduled on the same cpu
making
the depth counter 0 (right ?), but it could still be holding references
to data
structures to be updated using synchronize_kernel(). There seems to be
two
approaches to tackle preemption -

1. Disable pre-emption during the time when references to data
structures 
updated using such Two-phase updates are held.

Pros: easy to implement using a flag (ctx_sw_off() ?)
Cons: not so easy to use since critical sections need to be clearly
identified and interfaces defined. also affects preemptive behavior.

2. In synchronize_kernel(), distinguish between "natural" and preemptive
schedules() and ignore preemptive ones.

Pros: easy to use
Cons: Not so easy to implement. Also a low priority task that keeps
getting
preempted often can affect update side performance significantly.

I intend to experiment with both to understand the impact.

Thanks
Dipankar
-- 
Dipankar Sarma  (dipankar@sequent.com)
IBM Linux Technology Center
IBM Software Lab, Bangalore, India.
Project Page: http://lse.sourceforge.net
