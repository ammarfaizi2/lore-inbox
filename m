Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVIGHiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVIGHiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 03:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIGHiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 03:38:14 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:27863 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751177AbVIGHiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 03:38:13 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 7 Sep 2005 10:37:43 +0300
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050907073743.GB5804@atomide.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905072704.GB5734@atomide.com> <20050905170202.GJ25856@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905170202.GJ25856@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Aravamudan <nacc@us.ibm.com> [050905 20:02]:
> On 05.09.2005 [10:27:05 +0300], Tony Lindgren wrote:
> > * Srivatsa Vaddagiri <vatsa@in.ibm.com> [050905 10:03]:
> > > On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > > > 
> > > > Also, I am a bit confused by the use of "dynamic-tick" to describe these
> > > > changes. To me, these are all NO_IDLE_HZ implementations, as they are
> > > > only invoked from cpu_idle() (or their equivalent) routines. I know this
> > > > is true of s390 and the x86 code, and I believe it is true of the ARM
> > > > code? If it were dynamic-tick, I would think we would be adjusting the
> > > > timer interrupt frequency continuously (e.g., at the end of
> > > > __run_timers() and at every call to {add,mod,del}_timer()). I was
> > > > working on a patch which did some renaming to no_idle_hz_timer, etc.,
> > > > but it's mostly code churn :)
> > > 
> > > Yes, the name 'dynamic-tick' is misleading!
> > 
> > Huh? For most people dynamic-tick is much more descriptive name than
> > NO_IDLE_HZ or VST!
> 
> I understand this. My point is that the structures are *not*
> dynamic-tick specific. They are interrupt source specific, generally
> (also known as hardware timers) -- dynamic tick or NO_IDLE_HZ are the
> users of the interrupt source reprogramming functions, but not the
> reprogrammers themselves, in my mind. Also, it still would be confusing
> to use dynamic-tick, when the .config option is NO_IDLE_HZ! :)

I see what you mean, it's a confusing naming issue currently :) Would
the following solution work for you:

- Dynamic tick is the structure you register with, and then you use it
  for any kind of non-continuous timer tinkering 

- This structure has at least two possible users, NO_IDLE_HZ and
  sub-jiffie timers

So we could have following config options:

CONFIG_DYNTICK
CONFIG_NO_IDLE_HZ	depends on dyntick
CONFIG_SUBJIFFIE_TIMER	depends on dyntick
 
> > If you wanted, you could reprogram the next timer to happen from
> > {add,mod,del}_timer() just by calling the timer_dyn_reprogram() there.
> 
> I messed with this with my soft-timer rework (which has since has fallen
> by the wayside). It is a bit of overhead, especially del_timer(), but
> it's possible. This is what I would consider "dynamic-tick." And I would
> setup a *different* .config option to enable it. Perhaps depending on
> CONFIG_NO_IDLE_HZ.

Yes, I agree it should be a different .config option. Maybe the example
above would work for that?
 
> > And you would want to do that if you wanted sub-jiffie timer
> > interrupts.
> 
> Yes, true, it does enable that. Well, to be honest, it completely
> redefines (in some sense) the jiffy, as it is potentially continuously
> changing, not just at idle times.

Yeah. But should still work as we already accept interrupts at any point
inbetween jiffies to update time, and update the system time from a
second continuously running timer :)
 
> > So I'd rather not limit the name to the currently implemented
> > functionality only :)
> 
> I'm not trying to limit the name, but make sure we are tying the
> strcutures and functions to the right abstraction (interrupt source, in
> my opinion).

But other devices are interrupt sources too... And really the only use
for this stuct is non-continuous timer stuff, right?

Tony
