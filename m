Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262701AbSJCA21>; Wed, 2 Oct 2002 20:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262703AbSJCA21>; Wed, 2 Oct 2002 20:28:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32953 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262701AbSJCA2Z>;
	Wed, 2 Oct 2002 20:28:25 -0400
Message-ID: <3D9B8F9F.9040507@us.ibm.com>
Date: Wed, 02 Oct 2002 17:30:23 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [rfc][patch] kernel/sched.c oddness?
References: <3D9B3DC4.4030209@us.ibm.com> <3D9B89FD.1060400@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me...

Ingo, are we both crazy?  It's entirely possible as no one else seems to 
  have noticed the 'oddities' that Nick, Michael, and myself have... 
It'd be nice to know for sure either way...

Cheers!

-Matt

Nick Piggin wrote:
> Hi Matt,
> I think your patch is good except that it would be fine to use a /= 2 as 
> the
> compiler will turn this into a shift, and imbalance is not really valid (or
> used) if busiest == NULL. Actually there are a number of things (I think)
> still wrong with this! I posted a patch to Ingo - I guess I should have
> cc'ed the list - we should combine our efforts! Here is my explanation and
> a new patch including both our fixes.
> 
> Regards,
> Nick
> 
> Nick Piggin wrote:
> 
>> Just a quick follow up
>> * using imbalance (not divided by 2) instead of nr_running in 
>> is_unbalanced
>>  would save a multiply by 3
>> * it is a more accurate with a small number of processes due to no 
>> divisions
>> * perhaps the last test should actually be
>>  if(busiest->nr_running <= nr_running)
>>
>> Regards,
>> Nick
>>
>> Nick Piggin wrote:
>>
>>> Dear Ingo,
>>> I apologise in advance if the current behaviour of the scheduler is 
>>> the result
>>> of tuning / special casing you did in the scheduler I didn't follow its
>>> development closely. However, I noticed on my 2xSMP system that quite
>>> unbalanced loads weren't getting even CPU time best example - 3 
>>> processes in
>>> busywait loops - one would get 100% of one cpu while two would get 
>>> 50% each of
>>> the other.
>>>
>>> I think find_busiest_queue might have a few problems:
>>> * the "imbalance" value divided by 2 loses meaning and precision esp. 
>>> with
>>>  small number of processes
>>>
>>> * in the 25% imbalance calculation presumably the + should be a *
>>>
>>> * the 25% calculation uses the divided imbalance value which is 
>>> inaccurate
>>>
>>> * i think the 25% imbalance calculation should use a quarter of 
>>> max_load, not
>>>  three quarters.
>>>
>>> * the second test (after the lock) isn't very good, its cheaper than 
>>> the mul
>>>  but having battled contention and claimed the lock it would be a 
>>> shame to
>>>  not do anything with it!
>>>
>>> Now top says the patch has fixed up the balancing but perhaps some of 
>>> these
>>> aren't bugs - perhaps they need a comment because they are a bit 
>>> subtle! If
>>> they are, please recommend the patch to Linus.
>>>
>>> Regards,
>>> Nick
>>>
>>>
>>
> 
> 
> Matthew Dobson wrote:
> 
>> This snippet of code appears wrong...  Either that, or the 
>> accompanying comment is wrong?
>>
>> from kernel/sched.c::find_busiest_queue():
>>
>> | *imbalance = (max_load - nr_running) / 2;
>> |
>> | /* It needs an at least ~25% imbalance to trigger balancing. */
>> | if (!idle && (*imbalance < (max_load + 3)/4)) {
>> |     busiest = NULL;
>> |     goto out;
>> | }
>>
>> The comment says 25% imbalance, but the code is really checking for a 
>> ~50% imbalance.  The attatched patch moves the division by two to the 
>> pull_task function where the imbalance number is actually used.  This 
>> patch makes the code match the comment, and divides the imbalance by 
>> two where it is needed.
>>
>> Please let me know if I've misinterpreted what this code is supposed 
>> to be doing, -or- if we really want the comment to match the current 
>> code.
>>
>> Cheers!
>>
>> -Matt
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.5/kernel/sched.c.old	2002-10-02 23:14:12.000000000 +1000
> +++ linux-2.5/kernel/sched.c	2002-10-03 10:03:41.000000000 +1000
> @@ -689,10 +689,10 @@
>  	if (likely(!busiest))
>  		goto out;
>  
> -	*imbalance = (max_load - nr_running) / 2;
> +	*imbalance = max_load - nr_running;
>  
>  	/* It needs an at least ~25% imbalance to trigger balancing. */
> -	if (!idle && (*imbalance < (max_load + 3)/4)) {
> +	if (!idle && (*imbalance*4 < max_load)) {
>  		busiest = NULL;
>  		goto out;
>  	}
> @@ -702,10 +702,11 @@
>  	 * Make sure nothing changed since we checked the
>  	 * runqueue length.
>  	 */
> -	if (busiest->nr_running <= nr_running + 1) {
> +	if (busiest->nr_running <= nr_running) {
>  		spin_unlock(&busiest->lock);
>  		busiest = NULL;
>  	}
> +
>  out:
>  	return busiest;
>  }
> @@ -748,7 +749,12 @@
>  	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
>  	if (!busiest)
>  		goto out;
> -
> +	/*
> +	 * We only want to steal a number of tasks equal to 1/2 the imbalance,
> +	 * otherwise, we'll just shift the imbalance to the new queue.
> +	 */
> +	imbalance /= 2;
> +	
>  	/*
>  	 * We first consider expired tasks. Those will likely not be
>  	 * executed in the near future, and they are most likely to


