Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVEDJFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVEDJFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 05:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVEDJFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 05:05:19 -0400
Received: from alt.aurema.com ([203.217.18.57]:42927 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261512AbVEDJFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 05:05:04 -0400
Date: Wed, 4 May 2005 19:04:17 +1000
From: kingsley@aurema.com
To: Tom Zanussi <zanussi@us.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Relayfs Question: Use of relay_reset().  Potential race?
Message-ID: <20050504090417.GB21255@aurema.com>
Mail-Followup-To: Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
References: <20050323090254.GA10630@aurema.com> <20050418012951.GC4846@aurema.com> <16995.55497.569295.838562@tut.ibm.com> <20050419004023.GD4846@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419004023.GD4846@aurema.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 10:40:23AM +1000, Kingsley Cheung wrote:
> On Mon, Apr 18, 2005 at 10:56:57AM -0500, Tom Zanussi wrote:
> > Kingsley Cheung writes:
> >  > On Wed, Mar 23, 2005 at 08:02:54PM +1100, kingsley@aurema.com wrote:
> >  > > Hi 
> >  > > 
> >  > > I'm using relayfs to relay data from a kernel module to user space on
> >  > > a SuSE 2.6.5 kernel.  I'm not absolutely sure what version of relayfs
> >  > > has been back ported to it.
> >  > 
> >  > Hi Tom,
> >  > 
> >  > Could you please have a look at the following use of relay_reset() in
> >  > a kernel module as follows (compiled against pre-redux relayfs):
> (snip)
> >  > Is that legitimate?  The reason I ask is because I've been seeing
> > 
> > Yes, you should be able to reset the channel here, since at that point
> > it's been closed.
> > 
> >  > garbled oopses with keventd and I've narrowed it to two things:
> >  > 
> >  > 1) Inadequate locking on my part in the kernel module, which I have
> >  > addressed separately.
> >  > 
> >  > 2) A race with relay_reset() and keventd, which is probably of
> >  > interest to you if you're still maintaining the pre-redux patches.
> >  > 
> >  > The race is due to the use of INIT_WORK in _reset_relay():
> >  > 
> >  > INIT_WORK(&rchan->wake_readers, NULL, NULL);
> >  > INIT_WORK(&rchan->wake_writers, NULL, NULL);
> >  > 
> >  > However, at the time relay_reset() is called, it is possible that
> >  > these work structures are still being used by keventd when under heavy
> >  > loads.  The workaround I've used to fix this is to call
> >  > flush_scheduled_work() before calling reset_relay() in the kernel
> >  > module.  Perhaps that needs to be called in relay_reset() or
> >  > _relay_reset()?
> 
> Tom,
> 
> Thanks for the prompt response. 
> 
> > Yes, flush_scheduled_work() should probably be called from
> > __relay_reset() - thanks for catching this and suggesting the fix.

Tom,

Sorry about this, but the fix only works if schedule_work() is used
instead of schedule_delayed_work() for the pre-redux relayfs patch.  I
only realised this recently since I have been using the "flush" fix on
a pre-redux relayfs port to 2.4 which doesn't doesn't have an
equivalent of schedule_delayed_work() and have only tried it on 2.6
today.

Using flush_scheduled_work() with schedule_delayed_work() doesn't work
since schedule_delay_work() uses a timer to queue work at the
appropriate time.  Although all uses of schedule_delay_work() in
relayfs adds work to the queue a tick later, this time delay is enough
for flush_schedule_work() to flushes what is presently on the queue
before the timer actually expires.  eventd would then attempt to use a
work_struct that has then been initialised by relay_reset().

With schedule_work() is instead of schedule_delayed_work() I haven't
seen the race happen.

Thanks,
-- 
		Kingsley
