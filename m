Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVK3A7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVK3A7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVK3A7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:59:54 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:27095 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750752AbVK3A7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:59:37 -0500
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net,
       john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com,
       trini@kernel.crashing.org, george@mvista.com
In-Reply-To: <20051129205108.GQ19515@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com>
	 <20051129195336.GP19515@wotan.suse.de> <1133296540.4627.7.camel@mindpipe>
	 <20051129205108.GQ19515@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 18:55:05 -0500
Message-Id: <1133308505.4627.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 21:51 +0100, Andi Kleen wrote:
> On Tue, Nov 29, 2005 at 03:35:39PM -0500, Lee Revell wrote:
> > On Tue, 2005-11-29 at 20:53 +0100, Andi Kleen wrote:
> > > We're mostly addressing it - there are problems left, but
> > > overall it's looking good. The remaining problem is 
> > > an education issue of users to not use RDTSC directly, 
> > > but use gettimeofday/clock_gettime 
> > 
> > No the issue is to make gettimeofday fast enough that the people who
> > currently have to use the TSC can use it.  Right now it's 1500-3000 nsec
> > or so, Vojtech mentioned that he has a patch that could reduce that to
> 
> It's only that slow if the hardware can't do better.
> 
> And the kernel makes it only slow when using RDTSC directly
> is unsafe - so if you use it directly thinking the kernel cheats
> you for your cycles you're just shoting yourself in the own foot.
> 
> > 150-300 nsec.
> 
> If you have capable hardware it can already do much better.
> 

But on my system gettimeofday uses the TSC and it's still ~35x slower
than RDTSC:

rlrevell@mindpipe:~$ ./timetest 
rdtsc: 10000 calls in 1079 usecs
gettimeofday: 10000 calls in 36628 usecs

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

typedef unsigned long long cycles_t;

#define rdtscll(val) \
     __asm__ __volatile__("rdtsc" : "=A" (val))

static inline cycles_t get_cycles_tsc (void)
{
	unsigned long long ret;

	rdtscll(ret);
	return ret;
}

static inline cycles_t get_cycles_gtod (void)
{
       struct timeval tv;
       gettimeofday (&tv, NULL);

       return tv.tv_usec;
}

int main (void) {
	int i;
	cycles_t start_time;
	start_time= get_cycles_gtod();
	for (i = 0; i < 10000; i++) {
		get_cycles_tsc();
	}
	printf("rdtsc: %i calls in %llu usecs\n", i, get_cycles_gtod() - start_time);
	start_time = get_cycles_gtod();
	for (i = 0; i < 10000; i++) {
		get_cycles_gtod();
	}
	printf("gettimeofday: %i calls in %llu usecs\n", i, get_cycles_gtod() - start_time);
	return 0;
}


