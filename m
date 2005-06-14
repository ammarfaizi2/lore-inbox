Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVFNSLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVFNSLV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFNSLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:11:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63479 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261275AbVFNSLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:11:17 -0400
Date: Tue, 14 Jun 2005 11:11:09 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
Subject: Re: [PATCH 0/4] new timeofday-based soft-timer subsystem
Message-ID: <20050614181109.GG4180@us.ibm.com>
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com> <20050614034655.GA4180@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614034655.GA4180@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.2005 [20:46:55 -0700], Nishanth Aravamudan wrote:
> On 08.06.2005 [20:11:42 -0700], john stultz wrote:
> > Hey Everyone,
> > 	I'm heading out on vacation until Monday, so I'm just re-spinning my
> > current tree for testing. If there's no major issues on Monday, I'll re-
> > diff against Andrew's tree and re-submit the patches for inclusion.
> 
> Here is an update of my soft-timer rework to John's latest patches. I
> have made some major changes in this revision. I would still greatly
> appreciate any comments.

First, one consideration I forgot:

Would it be beneficial to encapsulate the timer_list structure? That way
if the units change underneath and we eventually move to timer_fsecs
(for femtoseconds), we don't need to change all the callers of
set_timer_nsecs() again?

I'm envisioning something along the lines of:

init_and_set_timer_nsecs((void *)(function), unsigned long data, nsec_t
				expires_nsecs);

I guess the trick then, is that a pointer to the created timer_list in
init_and_set_timer_nsecs() needs to be handed back to the caller, to
guarantee they can delete the timer if needed. Maybe that won't work :/

Just a thought, which might make this the hard transition, but should
make extensibility easier to handle.

<snip>

Also, some updates:

> [1] Benchmark Differentials on various machines

There was a bug in my ppc64 emulation (was just using jiffies not
(jiffies - INITIAL_JIFFIES)), here's is the update value for tod-timer:

> ppc64, 8-way 1.2GHz Power4, 12GB RAM
> 			Elapsed	User	System	CPU
> 2.6.12-rc6		100%	100%	100%	100%
> 2.6.12-rc6-tod	95.59%	100.04%	101.28%	104.81%
2.6.12-rc6-tod-timer	97.53%	100.18%	100.75%	102.81%

Also, here are the differentials between 2.6.12-rc6 and
2.6.12-rc6-tod-timer with emulation of do_monotonic_clock() on NUMA-Q.

numaq, 16-way 700 MHz, PIII, 16GB RAM
			Elapsed	User	System	CPU
2.6.12-rc6		100%	100%	100%	100%
2.6.12-rc6-tod-timer	100.99%	98.1%	99.13%	98.02%

Thanks,
Nish
