Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVLOWux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVLOWux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVLOWuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:50:52 -0500
Received: from fmr22.intel.com ([143.183.121.14]:45284 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751184AbVLOWuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:50:50 -0500
Date: Thu, 15 Dec 2005 14:50:40 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: hawkes@sgi.com
Cc: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Keith Owens <kaos@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH] ia64: disable preemption in udelay()
Message-ID: <20051215225040.GA9086@agluck-lia64.sc.intel.com>
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 03:25:26PM -0800, hawkes@sgi.com wrote:
> Sending this to a wider audience:
> 
> The udelay() inline for ia64 uses the ITC.  If CONFIG_PREEMPT is enabled
> and the platform has unsynchronized ITCs and the calling task migrates
> to another CPU while doing the udelay loop, then the effective delay may
> be too short or very, very long.
> 
> The most simple fix is to disable preemption around the udelay looping.
> The downside is that this inhibits realtime preemption for cases of long
> udelays.  One datapoint:  an SGI realtime engineer reports that if
> CONFIG_PREEMPT is turned off, that no significant holdoffs are
> are attributed to udelay().
> 
> I am reluctant to propose a much more complicated patch (that disables
> preemption only for "short" delays, and uses the global RTC as the time
> base for longer, preemptible delays) unless this patch introduces
> significant and unacceptable preemption delays.

Stuck between a rock and the proverbial hard place.

I think that the more complex patch is needed though.  If some crazy
driver has a pre-emptible udelay(10000), then you really don't want
to spin for that long without allowing preemption.

What is the threshold between a "long" and a "short" delay?  Presumably
related to whatever your maximum hold-off value is.  Also depends on
how long it takes to read the global RTC.

If you don't want to get the global RTC involved, then perhaps
you can break long delays up inside udelay()?  Something like
this:

#define	SMALLUSECS 250 /* randomly picked, needs some thought! */

static __inline__ void
udelay (unsigned long usecs)
{
	unsigned long start;
	unsigned long cycles;
	unsigned long smallusecs;

	while (usecs > 0) {
		smallusecs = (usecs > SMALLUSECS) ? SMALLUSECS : usecs;
		preempt_disable();
		cycles = smallusecs*local_cpu_data->cyc_per_usec;
		start = ia64_get_itc();

		while (ia64_get_itc() - start < cycles)
			cpu_relax();

		preempt_enable();
		usecs -= smallusecs;
	}
}

This does make the function a bit big for an "inline" though.  Does
it really need to be inline?  Do we care how fast our delay loops
are?

-Tony
