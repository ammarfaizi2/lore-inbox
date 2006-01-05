Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWAECO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWAECO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 21:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWAECO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 21:14:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:44527 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751200AbWAECO6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 21:14:58 -0500
In-Reply-To: <20051220155004.GA3906@in.ibm.com>
References: <20051214223912.GA4716@in.ibm.com> <43A1BD61.5070409@mvista.com> <20051220131956.GA24408@elte.hu> <20051220155004.GA3906@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <10843D42-7D91-11DA-AC71-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: Recursion bug in -rt
Date: Wed, 4 Jan 2006 18:14:56 -0800
To: dino@in.ibm.com
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar,
	I've got a more complete patch for deadlock detection for robust 
futexes.

	The patch is at 
http://source.mvista.com/~dsingleton/patch-2.6.15-rc7-rt3-rf2

	This patch handles pthread_mutex deadlocks in two ways:

1) POSIX states that non-recursive pthread_mutexes hang if locked twice.
This patch hangs the deadlocking thread on a waitqueue.  It releases
all other kernel locks, like the mmap_sem and robust_sem before waiting
on the waitqueue so as not to hang the kernel.

2) pthread_mutexes that are only robust, not PRIO_INHERIT,  do not
hang.  They have a new error code returned to them,  -EWOULDDEADLOCK.
Since there is no POSIX specification for robust pthread_mutexes yet,
returning EWOULDDEADLOCK to a robust mutex is more in the spirit
of robustness.  For robust pthread_mutexes we clean up if the holding
thread dies and we return EWOULDDEADLOCK to inform the
application that it is trying to deadlock itself.

	The patch handles both simple and circular deadlocks.  This is
something I've been wanting to do for a while, export deadlock
detection to all flavors of kernels.   The patch provides the correct
deadlock behavior while not hanging the system.

	It's also easier to see if a POSIX compliant app has deadlocked itself.
the 'ps' command will show that the wait channel of a deadlocked
application is waiting at 'futex_deadlock'.

	Let me know if it passes all your tests.

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

