Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTCEHFN>; Wed, 5 Mar 2003 02:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTCEHFN>; Wed, 5 Mar 2003 02:05:13 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:1246 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262492AbTCEHFM>; Wed, 5 Mar 2003 02:05:12 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WARN_ON noise in 2.5.63's kernel/sched.c:context_switch
References: <buoadgkuatx.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030225063739.GY10411@holomorphy.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Mar 2003 16:13:48 +0900
In-Reply-To: <20030225063739.GY10411@holomorphy.com>
Message-ID: <buok7fetheb.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:
> On Tue, Feb 25, 2003 at 03:35:22PM +0900, Miles Bader wrote:
> > I'm getting a bunch of stack dumps from the WARN_ON newly added to 
> > kernel/sched.c:context_switch:
> > 	if (unlikely(!prev->mm)) {
> > 		prev->active_mm = NULL;
> > 		WARN_ON(rq->prev_mm);
> > 		rq->prev_mm = oldmm;
> > 	}
> 
> This means there's some kind of trouble happening, i.e. the rq->prev_mm
> pointer is not NULL when it should be.
> 
> Tracking down the root cause would better serve you.

Ok, I think I found the reason; sched.c cleans up some stuff in
schedule_tail, and in this code (arch/v850/kernel/entry.S):

C_ENTRY(ret_from_fork):
#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
	mov	r10, r6			// switch_thread returns the prev task.
	jarl	CSYM(schedule_tail), lp	// ...which is schedule_tail's arg
#endif
	mov	r0, r10			// Child's fork call should return 0.
	br	ret_from_trap		// Do normal trap return.

... it only calls that if CONFIG_PREEMPT is turned on.  If I remove the
#ifdef, then I get no warnings.

I take it that the call to schedule_tail should now be unconditional?
[some other archs have the same #ifdef]

Thanks,

-Miles
-- 
97% of everything is grunge
