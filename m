Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVLSULc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVLSULc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVLSULc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:11:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:22525 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964937AbVLSULb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:11:31 -0500
Message-ID: <43A713FE.60206@mvista.com>
Date: Mon, 19 Dec 2005 12:11:42 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dino@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: Recursion bug in -rt
References: <20051214223912.GA4716@in.ibm.com> <9175126B-6D06-11DA-AA1B-000A959BB91E@mvista.com> <20051215194434.GA4741@in.ibm.com> <43F8915C-6DC7-11DA-A45A-000A959BB91E@mvista.com> <20051216184209.GD4732@in.ibm.com> <43A33114.6060701@mvista.com> <20051219115611.GA3945@in.ibm.com>
In-Reply-To: <20051219115611.GA3945@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:

Dinakar,
    the new patch is available at

     http://source.mvista.com/~dsingleton/patch-2.6.15-rc5-rt2-rf4

thanks for the patch and the testing.

David


>On Fri, Dec 16, 2005 at 01:26:44PM -0800, David Singleton wrote:
>  
>
>>Dinakar,
>>
>>    I believe this patch will give you the behavior you expect.
>>
>>   http://source.mvista.com/~dsingleton/patch-2.6.15-rc5-rt2-rf3
>>    
>>
>
>Not really, the reason, quoting from my previous mail
>
>   So IMO the above check is not right. However removing this check
>   is not the end of story.  This time it gets to task_blocks_on_lock
>   and tries to grab the task->pi_lock of the owvner which is itself
>   and results in a system hang. (Assuming CONFIG_DEBUG_DEADLOCKS
>   is not set). So it looks like we need to add some check to
>   prevent this below in case lock_owner happens to be current.
>
>    _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
>
>The patch that works for me is attached below
>
>	-Dinakar
>
>
>  
>
>------------------------------------------------------------------------
>
>Index: linux-2.6.14-rt22-rayrt5/kernel/rt.c
>===================================================================
>--- linux-2.6.14-rt22-rayrt5.orig/kernel/rt.c	2005-12-15 02:15:13.000000000 +0530
>+++ linux-2.6.14-rt22-rayrt5/kernel/rt.c	2005-12-19 15:51:26.000000000 +0530
>@@ -1042,7 +1042,8 @@
> 		return;
> 	}
> #endif
>-	_raw_spin_lock(&lock_owner(lock)->task->pi_lock);
>+	if (current != lock_owner(lock)->task)
>+		_raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> 	plist_add(&waiter->pi_list, &lock_owner(lock)->task->pi_waiters);
> 	/*
> 	 * Add RT tasks to the head:
>@@ -1055,7 +1056,8 @@
> 	 */
> 	if (task->prio < lock_owner(lock)->task->prio)
> 		pi_setprio(lock, lock_owner(lock)->task, task->prio);
>-	_raw_spin_unlock(&lock_owner(lock)->task->pi_lock);
>+	if (current != lock_owner(lock)->task)
>+		_raw_spin_unlock(&lock_owner(lock)->task->pi_lock);
> }
> 
> /*
>@@ -3016,8 +3018,7 @@
> 	 * the first waiter and we'll just block on the down_interruptible.
> 	 */
> 
>-	if (owner_task != current)
>-		down_try_futex(lock, owner_task->thread_info __EIP__);
>+	down_try_futex(lock, owner_task->thread_info __EIP__);
> 
> 	/*
> 	 * we can now drop the locks because the rt_mutex is held.
>  
>

