Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRCKWXh>; Sun, 11 Mar 2001 17:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRCKWX1>; Sun, 11 Mar 2001 17:23:27 -0500
Received: from ppp-97-248-an04u-dada6.iunet.it ([151.35.97.248]:14596 "HELO
	home.bogus") by vger.kernel.org with SMTP id <S129197AbRCKWXO>;
	Sun, 11 Mar 2001 17:23:14 -0500
Message-ID: <XFMail.20010312004622.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010312005448.A5439@linuxcare.com>
Date: Mon, 12 Mar 2001 00:46:22 +0100 (CET)
From: Davide Libenzi <davidel@xmailserver.org>
To: Anton Blanchard <anton@linuxcare.com.au>
Subject: Re: sys_sched_yield fast path
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11-Mar-2001 Anton Blanchard wrote:
>  
>> This is the linux thread spinlock acquire :
>> 
>> 
>> static void __pthread_acquire(int * spinlock)
>> {
>>   int cnt = 0;
>>   struct timespec tm;
>> 
>>   while (testandset(spinlock)) {
>>     if (cnt < MAX_SPIN_COUNT) {
>>       sched_yield();
>>       cnt++;
>>     } else {
>>       tm.tv_sec = 0;
>>       tm.tv_nsec = SPIN_SLEEP_DURATION;
>>       nanosleep(&tm, NULL);
>>       cnt = 0;
>>     }
>>   }
>> }
>> 
>> 
>> Yes, it calls sched_yield() but this is not a std wait for mutex but for
>> spinlocks that are hold a very short time.  Real wait are implemented using
>> signals.  More, with the new implementation of sys_sched_yield() the task
>> release all its time quantum so, even in a case where a task repeatedly
>> calls
>> sched_yield() the call rate is not so high if there is at least one process
>> to spin.  And if there isn't one task with goodness() > 0, nobody cares
>> about
>> sched_yield() performance.
> 
> The problem I found with sched_yield is that things break down with high
> levels of contention. If you have 3 processes and one has a lock then
> the other two can ping pong doing sched_yield() until their priority drops
> below the process with the lock. eg in a run I just did then where 2
> has the lock:
> 
> 1
> 0
> 1
> 0
> 1
> 0
> 1
> 0
> 1
> 0
> 1
> 0
> 1
> 0
> 1
> 0
> 1
> 0
> 2
> 
> Perhaps we need something like sched_yield that takes off some of 
> tsk->counter so the task with the spinlock will run earlier.

Which kernel are You running ?



- Davide

