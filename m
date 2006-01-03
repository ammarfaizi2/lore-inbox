Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWACByq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWACByq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 20:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWACByp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 20:54:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:44797 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750777AbWACByp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 20:54:45 -0500
In-Reply-To: <20051220155004.GA3906@in.ibm.com>
References: <20051214223912.GA4716@in.ibm.com> <43A1BD61.5070409@mvista.com> <20051220131956.GA24408@elte.hu> <20051220155004.GA3906@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E8B90C30-7BFB-11DA-8CAD-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: Recursion bug in -rt
Date: Mon, 2 Jan 2006 17:54:43 -0800
To: dino@in.ibm.com
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar,
	can you try patch-2.6.15-rc7-rt3-rf1  on  
http://source.mvista.com/~dsingleton/ and see if it works for your 
tests?

	This new patch creates a 'futex_deadlock' semaphore that we hang 
applications that
are deadlocking themselves.    This method will only hang the 
application, not the system,
as no other locks are held, like the mmap_sem,  just the futex_deadlock 
semaphore.

	NOTE: for pthread_mutexes  that are robust but NOT POSIX priority 
inheriting I return -EWOULDDEADLOCK,
since there is no POSIX specfication for robust pthread_mutexes yet.    
POSIX PI pthread_mutexes will hang
on the futex_deadlock semaphore.

	Let me know how it works.

David




On Dec 20, 2005, at 7:50 AM, Dinakar Guniguntala wrote:

> On Tue, Dec 20, 2005 at 02:19:56PM +0100, Ingo Molnar wrote:
>>
>> hm, i'm looking at -rf4 - these changes look fishy:
>>
>> -       _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
>> +       if (current != lock_owner(lock)->task)
>> +               _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
>>
>> why is this done?
>>
>
> Ingo, this is to prevent a kernel hang due to application error.
>
> Basically when an application does a pthread_mutex_lock twice on a
> _nonrecursive_ mutex with robust/PI attributes the whole system hangs.
> Ofcourse the application clearly should not be doing anything like
> that, but it should not end up hanging the system either
>
> 	-Dinakar
>

