Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVKVCNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVKVCNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVKVCNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:13:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31741 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964849AbVKVCNv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:13:51 -0500
In-Reply-To: <20051121212653.GA6143@elte.hu>
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9E9DCDB6-5AFD-11DA-A840-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: "David F. Carlson" <dave@chronolytics.com>,
       Dinakar Guniguntala <dino@in.ibm.com>, linux-kernel@vger.kernel.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: PI BUG with -rt13
Date: Mon, 21 Nov 2005 18:13:49 -0800
To: Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Carlson has tried the patch and although it works better, he's
discovered another race in the exit path.

I'll start working on the exit path race fix now that I have the race 
in down_futex
fixed.


Dave

On Nov 21, 2005, at 1:26 PM, Ingo Molnar wrote:

>
> * David Singleton <dsingleton@mvista.com> wrote:
>
>> Ingo,
>>    here is a patch that provides the correct locking for the rt_mutex
>> backing the robust pthread_mutex.   The patch also unifies the locking
>> for all the robust functions and adds support for pthread_mutexes on
>> the heap.
>
> thanks. Could you split up the patch into a fix and a 'heap' patch (at 
> a
> minimum)?
>
> it's this portion of the 'heap' patch that looks problematic:
>
>> --- base/linux-2.6.14/include/linux/mm.h	2005-11-18 
>> 20:36:53.000000000 -0800
>> +++ wip/linux-2.6.14/include/linux/mm.h	2005-11-21 10:51:19.000000000 
>> -0800
>> @@ -109,6 +109,11 @@
>>  #ifdef CONFIG_NUMA
>>  	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
>>  #endif
>> +#ifdef CONFIG_FUTEX
>> +	int robust_init;		/* robust initialized? */
>> +	struct list_head robust_list;	/* list of robust futexes in this vma 
>> */
>> +	struct semaphore robust_sem;	/* semaphore to protect the list */
>> +#endif
>>  };
>
> why is there per-vma info needed?
>
> Also, what testing did this patch have - should it solve Dinakar's
> problem(s)?
>
> 	Ingo

