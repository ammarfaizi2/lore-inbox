Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161826AbWKJPUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161826AbWKJPUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161829AbWKJPUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:20:41 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:55467 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161826AbWKJPUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:20:40 -0500
Date: Fri, 10 Nov 2006 16:20:38 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
In-Reply-To: <20061110090303.GB3196@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0611101606090.20654@artax.karlin.mff.cuni.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com>
 <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
 <20061107212614.GA6730@ucw.cz> <Pine.LNX.4.64.0611072328220.10497@artax.karlin.mff.cuni.cz>
 <20061107231456.GB7796@elf.ucw.cz> <Pine.LNX.4.64.0611081921170.5694@artax.karlin.mff.cuni.cz>
 <20061110090303.GB3196@elf.ucw.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>>>> If some rogue threads (and it may not even be intetional) call the same
>>>> syscall stressing the one spinlock all the time, other syscalls needing
>>>> the same spinlock may stall.
>>>
>>> Fortunately, they'll unstall with probability of 1... so no, I do not
>>> think this is real problem.
>>
>> You can't tell that CPUs behave exactly probabilistically --- it may
>> happen that one gets out of the wait loop always too late.
>
> Well,  I don't need them to be _exactly_ probabilistical.
>
> Anyway, if you have 2048 CPUs... you can perhaps get some non-broken
> ones.

No intel document guarantees you that if more CPUs simultaneously execute 
locked cmpxchg in a loop that a CPU will see compare success in a finite 
time. In fact, CPUs can't guarantee this at all, because they don't know 
that they're executing a spinlock --- for them its just an instruction 
stream like anything else.

Intel only guarantees that cmpxchg (or any other instruction) completes in 
finite time, but it doesn't say anything about the result of it.

>>> If someone takes semaphore in syscall (we do), same problem may
>>> happen, right...? Without need for 2048 cpus. Maybe semaphores/mutexes
>>> are fair (or mostly fair) these days, but rwlocks may not be or
>>> something.
>>
>> Scheduler increases priority of sleeping process, so starving process
>> should be waken up first. But if there are so many processes, that
>> process
>
> I do not think this is how Linux scheduler works.
> 								Pavel

<= 2.4 scheduler worked exactly like this. 2.6 has it more complicated, 
but does similar thing. But you are right that starvation on semaphore can 
happen, if the process has too high nice value, it will never be risen 
above other processes.

Mikulas
