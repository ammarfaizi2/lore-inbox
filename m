Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293210AbSBWWJ4>; Sat, 23 Feb 2002 17:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293220AbSBWWJr>; Sat, 23 Feb 2002 17:09:47 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:49611 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S293210AbSBWWJ3>;
	Sat, 23 Feb 2002 17:09:29 -0500
Message-ID: <3C781362.7070103@sgi.com>
Date: Sat, 23 Feb 2002 16:10:42 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014444810.1003.53.camel@phantasy.suse.lists.linux.kernel> <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <3C77FB35.16844FE7@zip.com.au.suse.lists.linux.kernel>,		Andrew Morton's message of "23 Feb 2002 21:36:17 +0100" <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au> <3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Stephen Lord wrote:
>
>>You do want to avoid a leak in one direction or the other, the os would
>>start to think it
>>had lots of dirty pages, but not be able to find them, or think there is
>>no shortage
>>when in fact there was.
>>
>
>Oh absolutely.  Even a one-page-per-hour leak would be catastrophic.
>
>But there is a problem.  If CPUA is always setting pages dirty,
>and CPUB is always setting them clean, CPUA's counter will eventually
>overflow, and CPUB's will underflow.  Drat. 
>
>One fix for this would be special-case over- and under-flow handling:
>
>	if (TestSetPageDirty(page)) {
>		preempt_disable();
>		nr_dirty_pages[smp_processor_id()]++;
>		if (nr_dirty_pages[smp_processor_id()] > 2,000,000) {
>			fit_it_up();
>		}
>		preempt_enable();
>	}
>
>	void fix_it_up()
>	{
>		spin_lock(&global_counter_lock);
>		global_counter += 1,000,000;
>		nr_dirty_pages[smp_processor_id()] -= 1,000,000;
>		spin_unlock(&global_counter_lock);
>	}
>
>	int approx_total_dirty_pages()
>	{
>		int ret;
>
>		spin_lock(&global_counter_lock);
>		ret = global_counter;
>		for (all cpus) {
>			ret += nr_dirty_pages[cpu];
>		}
>		spin_unlock(&global_counter_lock);
>		return ret;
>	}
>
>Or something like that.
>
>Then again, maybe the underflows and overflows don't matter, because the
>sum of all counters is always correct.   Unless there's a counter roll-over
>during the summation.  No.  Even then it's OK.
>
>hmmm.
>
>-
>

As I was plumbing in a sink ;-) the thought also occurred that you could 
have allocate
and free counters per cpu. The fix up code could do leveling between 
them. Are you
sure you only want to look at the actual value infrequently though? 
Every time you
put a page into delalloc state you need to do something similar to 
balance_dirty(),
if you only poll the value periodically then it could get way out of 
balance before
you noticed. It is very easy to dirty memory this way, cat /dev/zero > 
xxxx runs
very quickly.

I would almost say you need to get a 'reservation' of a delalloc page 
before you
grab the memory. There are extra memory costs associated with getting the
page out of this state, and if you do not hold threads back from 
dirtying pages
you can end up in a situation where you cannot clean up again.

Steve


