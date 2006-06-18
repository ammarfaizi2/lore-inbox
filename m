Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWFRPwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWFRPwY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWFRPwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:52:24 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:30607 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751200AbWFRPwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:52:23 -0400
Message-ID: <449576B4.9000605@bigpond.net.au>
Date: Mon, 19 Jun 2006 01:52:20 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, Sam Vilain <sam@vilain.net>,
       Srivatsa <vatsa@in.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 1/4] sched: Add CPU rate soft caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <20060618082648.6061.62247.sendpatchset@heathwren.pw.nest> <200606181838.36389.kernel@kolivas.org>
In-Reply-To: <200606181838.36389.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 18 Jun 2006 15:52:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Sunday 18 June 2006 18:26, Peter Williams wrote:
>> 3. Thanks to suggestions from Con Kolivas with respect to alternative
>> methods to reduce the possibility of a task being starved of CPU while
>> holding an important system resource, enforcement of caps is now
>> quite strict.  However, there will still be occasions where caps may be
>> exceeded due to this mechanism vetoing enforcement.
> 
> I hate to do this to you again but the mutexes held count advice I gave was 
> slightly off :|
>>  int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
>>  {
>> +	int ret;
>> +
>>  	might_sleep();
>> -	return __mutex_fastpath_lock_retval
>> +	ret = __mutex_fastpath_lock_retval
>>  			(&lock->count, __mutex_lock_interruptible_slowpath);
>> +
>> +	if (!ret)
>> +		inc_mutex_count();
>> +
>> +	return ret;
>>  }
>>
>>  EXPORT_SYMBOL(mutex_lock_interruptible);
>> @@ -357,8 +381,13 @@ static inline int __mutex_trylock_slowpa
>>   */
>>  int fastcall __sched mutex_trylock(struct mutex *lock)
>>  {
>> -	return __mutex_fastpath_trylock(&lock->count,
>> +	int ret = __mutex_fastpath_trylock(&lock->count,
>>  					__mutex_trylock_slowpath);
>> +
>> +	if (!ret)
>> +		inc_mutex_count();
>> +
>> +	return ret;
> 
> See my track-mutexes-1.patch I recently posted.
> 
>  int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
>  {
> +	int ret;
> +
>  	might_sleep();
> -	return __mutex_fastpath_lock_retval
> +	ret = __mutex_fastpath_lock_retval
>  			(&lock->count, __mutex_lock_interruptible_slowpath);
> +	if (likely(!ret))
> +		inc_mutex_count();
> +	return ret;
>  }
>  
>  EXPORT_SYMBOL(mutex_lock_interruptible);
> @@ -308,8 +325,12 @@ static inline int __mutex_trylock_slowpa
>   */
>  int fastcall mutex_trylock(struct mutex *lock)
>  {
> -	return __mutex_fastpath_trylock(&lock->count,
> +	int ret = __mutex_fastpath_trylock(&lock->count,
>  					__mutex_trylock_slowpath);
> +
> +	if (likely(ret))
> +		inc_mutex_count();
> +	return ret;
>  }
> 
> Note the if !ret in mutex_lock_interruptible vs the if ret in mutex_trylock(
> 
> I really should have given you the original debugging code that went with it, 
> sorry.
> 

That's OK.  I should have read the comments above mutex_trylock() more 
carefully myself.

Thanks
Peter
PS Have you thought about merging these caps into staircase in lieu of 
SCHED_IDLEPRIO?  Hard caps should be easy and soft caps not much harder.
If that was available I could merge the caps patch with plugsched.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
