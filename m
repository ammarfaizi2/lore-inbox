Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVCONH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVCONH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVCONH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:07:58 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:2436 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261214AbVCONHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:07:50 -0500
Date: Tue, 15 Mar 2005 08:07:35 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050315120053.GA4686@elte.hu>
Message-ID: <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
References: <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
 <20050311153817.GA32020@elte.hu> <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
 <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe>
 <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
 <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Mar 2005, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > I've realized that my previous patch had too many problems with the
> > way the journaling system works.  So I went back to my first approach
> > but added the journal_head lock as one global lock to keep the buffer
> > head size smaller. I only added the state lock to the buffer head.
> > I've tested this for some time now, and it works well (for the test at
> > least). I'll recompile it with PREEMPT_DESKTOP to see if that works
> > too.
>
> good progress - but the global lock may be a scalability worry on
> upstream though. Would it be possible to just mirror much of the current
> lock logic, but with spinlocks instead of bitlocks? And there should be
> no #ifdefs on PREEMPT_RT.
>

The first patch I had just converted the bit spinlocks to spinlocks but I
thought that adding two spinlocks was too much for every buffer head, even
if it wasn't in the ext3 file system. The journal head spinlock is just
used to add and remove the journal heads from the buffer heads, so I'm not
sure how much contention is on them. I only have a dual smp system, so I
can't test the system on large number of CPUs. What do you think, should
we sacrafice memory for speed?

What should we use instead of #ifdef PREEMPT_RT? Or should we just keep it
the same for both.  Since this fix is only to fix spinlocks that schedule,
I figured that it would be better not to waste the memory of those not
using PREEMPT_RT.  Should I use the opposite PREEMPT_DESKTOP?

Thanks,

-- Steve

