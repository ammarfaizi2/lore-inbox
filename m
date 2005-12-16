Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVLPV0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVLPV0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVLPV0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:26:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:4849 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932439AbVLPV0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:26:38 -0500
Message-ID: <43A33114.6060701@mvista.com>
Date: Fri, 16 Dec 2005 13:26:44 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dino@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: Recursion bug in -rt
References: <20051214223912.GA4716@in.ibm.com> <9175126B-6D06-11DA-AA1B-000A959BB91E@mvista.com> <20051215194434.GA4741@in.ibm.com> <43F8915C-6DC7-11DA-A45A-000A959BB91E@mvista.com> <20051216184209.GD4732@in.ibm.com>
In-Reply-To: <20051216184209.GD4732@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar,

     I believe this patch will give you the behavior you expect.

    http://source.mvista.com/~dsingleton/patch-2.6.15-rc5-rt2-rf3
   
    With this patch your app that tries to lock a non-recursive 
pthread_mutex twice
    will not get EAGAIN back,  it will hang.

    I should point out that you will still get the new, and I had hoped, 
added
    benefit feature of being able to detect when you app would deadlock 
itself
    by turning on DEBUG_DEADLOCKS.  It will give you the same
    behavior that you originally posted.   The kernel will inform you
    of the deadlock.

    If you need the POSIX behavior of having an app hang if it tries
    to lock the same, non-recursive pthread_mutex twice then you need to 
turn off
    DEBUG_DEADLOCKS.
   
    If you can send on the Priority Boost test I can start looking at it 
as well.


David


>On Thu, Dec 15, 2005 at 04:02:36PM -0800, david singleton wrote:
>  
>
>>Dinakar,
>>
>>	I believe the problem we have is that the library is not checking
>>to see if the mutex is a recursive mutex, and then checking to see
>>if the recursive mutex is already owned by the calling thread.  If a 
>>recursive mutex
>>is owned by the calling thread the library should increment the lock
>>count (POSIX says recursive mutexes must be unlocked as
>>many times as they are locked) and return 0 (success) to the caller.
>>    
>>
>
>Sorry I seem to have confused you. I am _not_ talking about recursive
>mutexes here.
>
>I have two testcases. Here is a code snippet of testcase I
>
>        void* test_thread (void* arg)
>        {
>            pthread_mutex_lock(&child_mutex);
>            printf("test_thread got lock\n");
>
>            pthread_mutex_lock(&child_mutex);
>            printf("test_thread got lock 2nd time !!\n");
>
>            printf("test_thread exiting\n");
>            return NULL;
>        }
>
>        main ()
>        {
>            ...
>
>            if (pthread_mutexattr_init(&mutexattr) != 0) {
>              printf("Failed to init mutexattr\n");
>            };
>            if (pthread_mutexattr_setprotocol(&mutexattr,
>                                        PTHREAD_PRIO_INHERIT) != 0) {
>              printf("Can't set protocol prio inherit\n");
>            }
>            if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0) {
>              printf("Can't get mutexattr protocol\n");
>            } else {
>              printf("protocol in mutexattr is %d\n", protocol);
>            }
>            if ((retc = pthread_mutex_init(&child_mutex, &mutexattr)) != 0) {
>              printf("Failed to init mutex: %d\n", retc);
>            }
>
>            ...
>        }
>
>
>Clearly what the application is doing here is wrong. However,
>
>1. In the case of normal (non-robust) non recursive mutexes, the
>behaviour when we make the second pthread_mutex_lock call is for glibc
>to make a futex_wait call which will block forever.
>(Which is the right behaviour)
>
>2. In the case of a robust/PI non recursive mutex, the current
>behaviour is the glibc makes a futex_wait_robust call (which is right)
>The kernel (2.6.15-rc5-rt1) rt_mutex lock is currently unowned and
>since we do not call down_try_futex if current == owner_task, we end
>up grabbing the lock in __down_interruptible and returning succesfully !
>
>3. Adding the check below in down_futex is also wrong
>
>   if (!owner_task || owner_task == current) {
>        up(sem);
>        up_read(&current->mm->mmap_sem);
>        return -EAGAIN;
>   }
>
>   This will result in glibc calling the kernel continuosly in a
>   loop and we will end up context switching to death
>
>I guess we need to cleanup this path to ensure that the application
>blocks forever.
>
>I also have testcase II which does not do anything illegal as the
>above one, instead it exercises the PI boosting code path in the
>kernel and that is where I see the system hang up yet again
>and this is the race that I am currently investigating
>
>Hope that clearls up things a bit
>
>	-Dinakar
>
>  
>

