Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWE3RRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWE3RRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWE3RRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:17:42 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:10596 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932353AbWE3RRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:17:40 -0400
Message-ID: <447C7E1F.7020602@de.ibm.com>
Date: Tue, 30 May 2006 19:17:19 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 5/6] statistics infrastructure
References: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060524155735.04ed777a.akpm@osdl.org>
In-Reply-To: <20060524155735.04ed777a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin Peschke <mp3@de.ibm.com> wrote:
>> +static int statistic_alloc(struct statistic *stat,
>> +			   struct statistic_info *info)
>> +{
>> +	int cpu;
>> +	stat->age = sched_clock();
> 
> argh.  Didn't we end up finding a way to avoid this?
> 
> At the least, we should have statistics_clock(), or nsec_clock(), or
> something which is decoupled from this low-level scheduler-internal thing,
> and which architectures can implement (vis attribute-weak) if they have a
> preferred/better/more-accurate alternative.

I use clocks for two purposes. Both have used sched_clock() so far.

The statistics infrastructure itself uses a clock only for time stamps
that tell users what time a statistic has been switched on/off and reset.
This is what you have spotted here.

(The other and more important requirement regards exploiters of the
statistics infrastructure. They need a clock to measure latencies,
which they can report then.)

Regarding those time stamps, I think it best to make them look like other
timestamps, specifically the printk() time stamps in order not to confuse
users. That is why, one of my patches introduces nsec_to_timestamp()
based on some lines from printk(). Printk() uses printk_clock() as
source, which is nothing else than a sched_clock() call, unless
reimpelmented by architectures (only done for ia64).
If I want similar timestamps, I need the same time source too.

Now my question:

Would I get away with making printk_clock() a timestamp_clock() that
should be used by anyone exporting nsec_to_timestamp()-formated time
stamps to user space, including me?

I would then continue to see the use of sched_clock() in printk_clock()
... aehm timestamp_clock() as somebody else's problem (or at least
as a subordinate problem).
Thoughts?  <ducking down>

Martin

