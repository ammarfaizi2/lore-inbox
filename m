Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWFNWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWFNWuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWFNWuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:50:05 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:2035 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S964959AbWFNWuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:50:03 -0400
Message-ID: <44909292.2080005@de.ibm.com>
Date: Thu, 15 Jun 2006 00:49:54 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: statistics infrastructure (in -mm tree) review
References: <20060613232131.GA30196@kroah.com>	<20060613234739.GA30534@kroah.com> <p73slm8qqe4.fsf@verdi.suse.de>
In-Reply-To: <p73slm8qqe4.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Greg KH <greg@kroah.com> writes:
>>> + * exploiters don't update several statistics of the same entity in one go.
>>> + */
>>> +static inline void statistic_add(struct statistic *stat, int i,
>>> +				 s64 value, u64 incr)
>>> +{
>>> +	unsigned long flags;
>>> +	local_irq_save(flags);
>>> +	if (stat[i].state == STATISTIC_STATE_ON)
>>> +		stat[i].add(&stat[i], smp_processor_id(), value, incr);
> 
> 
> Indirect call in statistics hotpath?  You know how slow this is 
> on IA64 and even on other architectures it tends to disrupt 
> the pipeline.

Okay, let's try to improve it then. The options here are:

a) Replace the indirect function call by a switch statement which directly
    calls the add function of the data processing mode chosen by user.
    (e.g. simple counter, histogram, utilisation indicator etc.).

    No loss in functionality, slightly uglier code, acceptable performance(?).
    This would be my choice.

b) Export statistic_add_counter(), statistic_add_histogram() and the like
    as part of the programming API (maybe in addition to the flexible
    statistic_add()) for those exploiters that definitively can't effort
    branching into a function.

    Loss in functionality (exploiting kernel code dictates how users see the
    data), a bit faster than option a).

What do you think? Did I miss an option?

Thanks, Martin


