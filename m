Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbRGPPtA>; Mon, 16 Jul 2001 11:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbRGPPsu>; Mon, 16 Jul 2001 11:48:50 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:1994 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267430AbRGPPsc>;
	Mon, 16 Jul 2001 11:48:32 -0400
Date: Mon, 16 Jul 2001 08:46:11 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Andi Kleen <ak@suse.de>
Cc: Mike Kravetz <mkravetz@sequent.com>,
        David Lang <david.lang@digitalinsight.com>,
        Larry McVoy <lm@bitmover.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency
Message-ID: <20010716084611.A1186@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20010713100521.D1137@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.33.0107131249200.4540-100000@dlang.diginsite.com> <20010713154305.G1137@w-mikek2.des.beaverton.ibm.com> <20010715221542.B14480@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010715221542.B14480@gruyere.muc.suse.de>; from ak@suse.de on Sun, Jul 15, 2001 at 10:15:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 10:15:42PM +0200, Andi Kleen wrote:
> On Fri, Jul 13, 2001 at 03:43:05PM -0700, Mike Kravetz wrote:
> > - Define a new field in the task structure 'saved_cpus_allowed'.
> >   With a little collapsing of existing fields, there is room to put
> >   this on the same cache line as 'cpus_allowed'.
> > - In reschedule_idle() if we determine that the best CPU for a task
> >   is the CPU it is associated with (p->processor), then temporarily
> >   bind the task to that CPU.  The task is temporarily bound to the
> >   CPU by overwriting the 'cpus_allowed' field such that the task can
> >   only be scheduled on the target CPU.  Of course, the original
> >   value of 'cpus_allowed' is saved in 'saved_cpus_allowed'.
> > - In schedule(), the loop which examines all tasks on the runqueue
> >   will restore the value of 'cpus_allowed'.
> 
> This sounds racy, at least with your simple description. Even other CPUs
> could walk their run queue while the IPI is being processed and reset the
> cpus_allowed flag too early. I guess it would need a check in the 
> schedule loop that restores cpus_allowed that the current CPU is the only
> on set in that task's cpus_allowed.

You are correct.  It is trivial to allow only the 'target' CPU to reset
the cpus_allowed field.  This was my first thought.  However, as you
state below we would get into trouble if there was an extremely long
delay in that CPU running schedule.

The timestamp sounds reasonable, but I was trying to keep it as simple
as possible.

>                                     This unfortunately would hang the
> process if the CPU for some reason cannot process schedules timely, so
> it may be needed to add a timestamp also to the task_struct that allows 
> the restoration of cpus_allowed even from non target CPUs after some
> time.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
