Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUG2TVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUG2TVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUG2TTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:19:32 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:3555 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S264826AbUG2TSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:18:16 -0400
Date: Thu, 29 Jul 2004 15:17:52 -0400
To: Bill Huey <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, Scott Wood <scott@timesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040729191752.GB27701@yoda.timesys>
References: <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu> <20040722185308.GC4774@yoda.timesys> <20040722194513.GA32377@nietzsche.lynx.com> <20040728064547.GA16176@elte.hu> <20040728205211.GC6685@yoda.timesys> <20040729182110.GA16419@elte.hu> <20040729183626.GA11652@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729183626.GA11652@nietzsche.lynx.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 11:36:26AM -0700, Bill Huey wrote:
> On Thu, Jul 29, 2004 at 08:21:10PM +0200, Ingo Molnar wrote:
> > * Scott Wood <scott@timesys.com> wrote:
> > ok, i see - this makes 100% sense. I'm wondering how intrusive such an
> > all-preemptive patchset is? There are some problems with per-CPU data
> > structures on SMP. Right now holding a spinlock means one can use
> > smp_processor_id() and rely on it staying constant in the critical
> > section. With a mutex in the same place all such assumptions would
> > break. Is there some automatic way to deal with these issues (or to at
> > least detect them reliably?).
> 
> Make smp_processor_id check if preempt_count() is non-zero to make sure 
> that you're running within a non-preemptable critical section (scheduler
> deferred). Do the same with local_irq_* critical section by checking to
> see if interrupts are disabled. They are also non-preemptable (hardware
> defered).

There are legitimate reasons to use smp_processor_id() outside of a
non-preemptible region, though.  These include debugging
printks/logging, and situations where the awareness of CPU is for
optimization rather than correctness (for example, using per-cpu data
with per-cpu locks, which are only contended if preemption occurs, or
per-cpu counters incremented with atomic operations (or where counter
accuracy is not critical)).

The detection mechanism we used in 2.4 was simply to grep for
smp_processor_id and check/fix everything manually (which is somewhat
tedious, but there aren't *too* many instances in core code, and many
uses are similar to one another).

-Scott
