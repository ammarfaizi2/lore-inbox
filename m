Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUIBXVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUIBXVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269204AbUIBXVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:21:12 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:26332 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269283AbUIBXTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:19:49 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0409021536450.28532@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com>
	 <1094164096.14662.345.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021536450.28532@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1094166858.14662.367.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 16:14:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 15:42, Christoph Lameter wrote:
> On Thu, 2 Sep 2004, john stultz wrote:
> 
> > What about my idea from yesterday of inverting the fastcall
> > relationship? Instead of creating a structure that exports values and
> > pointers the fastcall can use to create a time of day, why not use the
> > fast call to read the raw time and return it back to the time of day
> > code (which may be running in user context)? This avoids the duplication
> > of having to re-implement the timeofday/clock_gettime functions in
> > fastcall asm code.
> 
> "Read raw time"? How can you read the raw time in a fast call if the
> fast call needs to do additional function calls (as defined in the
> proposed time structure) in the kernel context in order to retrieve time?
> 
> A fast call cannot do any function calls in the kernel context or
> otherwise.
> 
> The overhead of the function calls will reduce the performance of time
> access significantly.

Forgive me if I mis-understand the fastcall method, but this is the
concept. Instead of having a fastcall function that implmements the
gettimofday/clock_gettime + ntp scaling + etc all in asm we do the
following:

When creating a ia64 timesource (say the cyclone just for a specific
example) we do something like the following.

/* trivial delta (nothing new here) */
static cycle_t cyclone_fastcall_delta(cycle_t now, cycle_t then)
{
	return (now - then);
}
/* trivial cyc2ns (nothing new here) */
static nsec_t cyclone_fastcall_cyc2ns(cycle_t cyc, cycle_t* remainder)
{
	u64 rem;
	cyc *= freq_multiplier;
	if (remainder)
		*remainder = 0;
	return (nsec_t)cyc;
}

/* fastcall read, this is where it gets interesting */
static cycle_t cyclone_fasatcall_read(void)
{
	u64 ret;

	ret = fastcall_readcyclonecounter();

	return (cycle_t)ret;
}

struct timesource_t timesource_cyclone_fastcall = {
	.name = "cyclone_fastcall",
	.priority = 100,
	.read = cyclone_fastcall_read,
	.delta = cyclone_fastcall_delta,
	.cyc2ns = cyclone_fastcall_cyc2ns,
};

Then you implement a fastcall for fastcall_readcyclonecounter(), which
in crazy ia64 asm would do something like:

ENTRY(fastcall_readcyclonecounter)
blip	// magic privledge escalation
blop	// load cyclone counter into memory
bloop	// copy cyclone counter back into return register
;;
END(fastcall_readcyclonecounter)


This avoids 150+ lines of asm needed to re-implement the gettimeofday
math.

However, I could be mistaken. Is something like this possible?

thanks
-john




