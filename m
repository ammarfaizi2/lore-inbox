Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269170AbUIBWjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269170AbUIBWjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269167AbUIBWgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:36:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55268 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269152AbUIBWck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:32:40 -0400
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
In-Reply-To: <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1094164096.14662.345.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 15:28:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 15:19, Christoph Lameter wrote:
> On Thu, 2 Sep 2004, john stultz wrote:
> 
> > +struct timesource_t {
> > +	char* name;
> > +	int priority;
> > +	cycle_t (*read)(void);
> > +	cycle_t (*delta)(cycle_t now, cycle_t then);
> > +	nsec_t (*cyc2ns)(cycle_t cycles, cycle_t* remainder);
> > +};
> 
> This is defining functions to be called for a timesource. Which means that
> the functionality for clock_gettime cannot be implemented as a fastcall
> anymore on IA64. The delta and the cyc2ns function are always the same.
> The compensation for jitter etc is always the same and can also be
> implemented generically.
> 
> Could we change this to avoid the function calls.
> 
> For example.
> 
> struct timesource_t {
> 	char *name;
> 	int priority;
> 	int type;
> 	void *address;
> 	long long int frequency;
> }
> 
> The functions are always
> 
> delta = (now-then)
> cycle2ns = cycles * (NSEC_PER_SEC / frequency) + remainder
> 
> types of time sources
> 
> #define TIMESOURCE_CPU 0
> #define TIMESOURCE_MMIO32 1
> #define TIMESOURCE_MMIO64 2
> #define TIMESOURCE_FUNCTION 3 	/* To catch odd cases */


What about my idea from yesterday of inverting the fastcall
relationship? Instead of creating a structure that exports values and
pointers the fastcall can use to create a time of day, why not use the
fast call to read the raw time and return it back to the time of day
code (which may be running in user context)? This avoids the duplication
of having to re-implement the timeofday/clock_gettime functions in
fastcall asm code.

thanks
-john

