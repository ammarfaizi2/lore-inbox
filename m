Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWGMLMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWGMLMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWGMLMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:12:36 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:37562 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750922AbWGMLMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:12:35 -0400
Message-ID: <44B62A9B.7000707@de.ibm.com>
Date: Thu, 13 Jul 2006 13:12:27 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 10
References: <1152707259.3028.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>	<20060712091024.c5bd19c7.akpm@osdl.org>	<1152722709.3028.28.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060713010004.63215f02.akpm@osdl.org>
In-Reply-To: <20060713010004.63215f02.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 12 Jul 2006 18:45:08 +0200
> Martin Peschke <mp3@de.ibm.com> wrote:
> 
>> On Wed, 2006-07-12 at 09:10 -0700, Andrew Morton wrote:
>>> On Wed, 12 Jul 2006 14:27:39 +0200
>>> Martin Peschke <mp3@de.ibm.com> wrote:
>>>
>>>> +#define statistic_ptr(stat, cpu) \
>>>> +	((struct percpu_data*)((stat)->data))->ptrs[(cpu)]
>>>
>>> This would be the only part of the kernel which uses percpu_data directly -
>>> everything else uses the APIs (ie: per_cpu_ptr()).  How come?
>>
>> The API, i.e. per_cpu_ptr(), doesn't allow to assign a value to any of
>> the pointers in struct percpu_data. I need that capability because I
>> make use of cpu hotplug notifications to fix per-cpu data at run time.
> 
> Fair enough, I guess.
> 
>> With regard to memory footprint this is much more efficient than using
>> alloc_percpu().
> 
> How much storage are we talking about here?  I find it a bit hard to work
> that out.

32 CPUs appears to be default during kernel build. My z/VM guest happens
to have 4 (virtual) CPUs right now. With alloc_percpu() the wasted/used
ratio would be 8:1.

Given one small logarithmic histogram (buckets: <=0, <=1, <=2, <=4, ...
<=1024, >1024) that would be a waste of:
next_power_of_2(13 buckets * 8 bytes/bucket) * 8 = 1kB.

>> Is it be preferable to add something like set_per_cpu_ptr() to the API?
> 
> hm.  Add a generic extension to a generic interface within a specific
> subsystem versus doing it generically.  Hard call ;)

pretty warm outside... making me lazy ;)

> I'd suggest that you:
> 
> - Create a new __alloc_percpu_mask(size_t size, cpumask_t cpus)
> 
> - Make that function use your newly added
> 
> 	percpu_data_populate(struct percpu_data *p, int cpu, size_t size, gfp_t gfp);
> 
> 	(maybe put `size' into 'struct percpu_data'?)
> 
> - implement __alloc_percpu() as __alloc_percpu_mask(size, cpu_possible_map)

Getting at the root of the problem. I will have a shot at it.
(It will take til next week, though - pretty warm outside...)

A question:
For symmetry's sake, should I add __free_percpu_mask(), which would
put NULL where __alloc_percpu_mask() has put a valid address earlier?
Otherwise, per_cpu_ptr() would return !NULL for an object released
during cpu hotunplug handling.
Or, is this not an issue because some cpu mask indicates that the cpu
is offline anyway, and that the contents of the pointer is not valid.

> - hack around madly until it compiles on uniprocessor.

;)

