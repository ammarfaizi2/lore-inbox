Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTIFBDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTIFBDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:03:23 -0400
Received: from fmr09.intel.com ([192.52.57.35]:42462 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262721AbTIFBDV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:03:21 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] idle using PNI monitor/mwait (take 2)
Date: Fri, 5 Sep 2003 18:03:14 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304A72D@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] idle using PNI monitor/mwait (take 2)
Thread-Index: AcNz8rZwWO12ExNARWSvJdsVJT0o3wAEnc9A
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 06 Sep 2003 01:03:15.0036 (UTC) FILETIME=[A6A1C9C0:01C37412]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the explanation.

> It isn't defensive.  The local_irq_disable() is needed to avoid a race
> condition.  It was added to fix high latency spikes.
> 
> Without it, after checking need_resched, that flag can be set by an
> interrupt before we do "hlt".
> 
> The result is a halted CPU even though need_resched is set, and the
> idle loop isn't broken until the next interrupt, often a timer tick.

I'm aware of the window, but did not realize that it could cause high
latency spikes. Is that still the case with 2.6 where we have higher HZ
(1000)? Anyway, I think it's a cheap way of removing such spikes.

> So you can remove it from your loop.
Okay we'll remove local_irq_enable() at entry. So in that case we can
remove the local_irq_enable() below as well?

static void poll_idle (void)
{
	int oldval;

=>	local_irq_enable();

	/*
	 * Deal with another CPU just having chosen a thread to
	 * run here:
	 */
	oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
...

Thanks,
Jun

> -----Original Message-----
> From: Jamie Lokier [mailto:jamie@shareable.org]
> Sent: Friday, September 05, 2003 2:14 PM
> To: Nakajima, Jun
> Cc: Andrew Morton; linux-kernel@vger.kernel.org; Saxena, Sunil;
Mallick,
> Asit K; Pallipadi, Venkatesh
> Subject: Re: [PATCH] idle using PNI monitor/mwait (take 2)
> 
> Nakajima, Jun wrote:
> > We are doing this as defensive programming (because of bogus device
> > drivers, for example), like the other idle routines (default_idle,
and
> > poll_idle) always do.
> >
> > BTW, I'm not sure that local_irq_disable() is really required below
(as
> > you know, "sti" is hiding in safe_halt()).
> >
> > void default_idle(void)
> > {
> > 	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
> > =>		local_irq_disable();
> > 		if (!need_resched())
> > 			safe_halt();
> > 		else
> > 			local_irq_enable();
> > 	}
> > }
> 
> 
> It isn't defensive.  The local_irq_disable() is needed to avoid a race
> condition.  It was added to fix high latency spikes.
> 
> (A comment to that effect in default_idle would be nice).
> 
> Without it, after checking need_resched, that flag can be set by an
> interrupt before we do "hlt".
> 
> The result is a halted CPU even though need_resched is set, and the
> idle loop isn't broken until the next interrupt, often a timer tick.
> 
> The "sti" in safe_halt() is immediately before the "hlt", which means
> it doesn't enable interrupts until after the "hlt" instruction.  This
> means that any interrupt will wake the CPU.
> 
> local_irq_disable() isn't required in the monitor/mwait loop, because
> you check need_resched between the monitor and mwait.  (If Intel had
> implemented monitor+mwait as a single instruction, then you'd need
it).
> 
> So you can remove it from your loop.
> 
> Enjoy :)
> -- Jamie

