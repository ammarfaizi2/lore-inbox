Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWEBRPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWEBRPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWEBRPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:15:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46451 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964917AbWEBRPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:15:49 -0400
Date: Tue, 02 May 2006 13:15:48 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: sched_clock() uses are broken
In-reply-to: <20060502165009.GA4223@flint.arm.linux.org.uk>
X-X-Sender: nico@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0605021300140.28543@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
 <p73slns5qda.fsf@bragg.suse.de> <20060502165009.GA4223@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006, Russell King wrote:

> On Tue, May 02, 2006 at 06:43:45PM +0200, Andi Kleen wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> writes:
> > > 
> > > However, this is not the case.  On x86 with TSC, it returns a 54 bit
> > > number.  This means that when t1 < t0, time_passed_ns becomes a very
> > > large number which no longer represents the amount of time.
> > 
> > Good point. For a 1Ghz system this would happen every ~0.57 years.
> > 
> > The problem is there is AFAIK no non destructive[1] way to find out how
> > many bits the TSC has
> > 
> > Destructive would be to overwrite it with -1 and see how many stick.
> > 
> > > All uses in kernel/sched.c seem to be aflicted by this problem.
> > > 
> > > There are several solutions to this - the most obvious being that we
> > > need a function which returns the nanosecond difference between two
> > > sched_clock() return values, and this function needs to know how to
> > > handle the case where sched_clock() has wrapped.
> > 
> > Ok it can be done with a simple test.

Better yet the sched_clock() implementation just needs to return a value 
shifted left so the wrap around always happens on 64 bits and the 
difference between two consecutive samples is always right.

> > > 
> > > IOW:
> > > 
> > > 	t0 = sched_clock();
> > > 	/* do something */
> > > 	t1 = sched_clock();
> > > 
> > > 	time_passed = sched_clock_diff(t1, t0);
> > > 
> > > Comments?
> > 
> > Agreed it's a problem, but probably a small one. At worst you'll get
> > a small scheduling hickup every half year, which should be hardly 
> > that big an issue.

... on x86 that is.

> > Might chose to just ignore it with a big fat comment?
> 
> You're right assuming you have a 64-bit TSC, but ARM has at best a
> 32-bit cycle counter which rolls over about every 179 seconds - with
> gives a range of values from sched_clock from 0 to 178956970625 or
> 0x29AAAAAA81.
> 
> That's rather more of a problem than having it happen every 208 days.

Yet that counter isn't necessarily nanosecond based.  So rescaling the 
returned value to nanosecs requires expensive divisions which could be 
done only once within sched_clock_diff() instead of twice as often in 
each sched_clock() calls.


Nicolas
