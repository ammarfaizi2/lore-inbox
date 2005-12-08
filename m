Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVLHJw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVLHJw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 04:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVLHJwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 04:52:55 -0500
Received: from styx.suse.cz ([82.119.242.94]:2508 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751017AbVLHJwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 04:52:55 -0500
Date: Thu, 8 Dec 2005 10:34:04 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] x86_64:  Fix collision between pmtimer and pit/hpet timekeeping
Message-ID: <20051208093403.GA7445@midnight>
References: <1133931639.10613.39.camel@cog.beaverton.ibm.com> <20051207175338.GB11190@wotan.suse.de> <1133978430.18188.3.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133978430.18188.3.camel@leatherman>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 10:00:30AM -0800, john stultz wrote:
> On Wed, 2005-12-07 at 18:53 +0100, Andi Kleen wrote:
> > On Tue, Dec 06, 2005 at 09:00:39PM -0800, john stultz wrote:
> > > Hello,
> > > 	I thought I had caught all the problems when the no-legacy HPET support
> > > landed close to the time that the ACPI PM timer support landed, but
> > > apparently not. :(
> > > 
> > > On systems that do not support the HPET legacy functions (basically the
> > > IBM x460, but there could be others), in time_init() we accidentally
> > > fall into a PM timer conditional and set the vxtime_hz value to the PM
> > > timer's frequency. We then use this value with the HPET for timekeeping.
> > > 
> > > This patch (which mimics the behavior in time_init_gtod) corrects the
> > > collision.
> > > 
> > > Andi, any objections or suggestions for a better way?
> > 
> > Ok. I will apply it.
> > 
> > But I never quite got why you fall back to the PIT on these systems
> > anyways - if LEGSUP is not set it just means that the HPET interrupt
> > cannot be routed to irq 0, right? It should be quite easy to change
> > the timer code to accept timer interrupts on other irqs. 
> > 
> > You just need to allocate the other interrupt and possibly coordinate
> > that with the hpet char driver (or rather move the code for that
> > from there to time.c). I think implementing that would be a better
> > solution.
> 
> Indeed that does sound like a decent cleanup. I can't promise anything
> in the near future, but its on my list.
> 
> Would you then want to move all systems to use the non-legacy HPET
> interrupt?
 
Yes, that'd be very cool. The problem with doing it is that HPET is
initialized at a very early stage of boot where it isn't at all clear
which APIC pins will be free to take the HPET interrupt(s).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
