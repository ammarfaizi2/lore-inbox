Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161439AbWKHS03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161439AbWKHS03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbWKHS03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:26:29 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:62435 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161439AbWKHS02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:26:28 -0500
Date: Wed, 8 Nov 2006 19:26:26 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
In-Reply-To: <20061107231456.GB7796@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0611081921170.5694@artax.karlin.mff.cuni.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com>
 <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
 <20061107212614.GA6730@ucw.cz> <Pine.LNX.4.64.0611072328220.10497@artax.karlin.mff.cuni.cz>
 <20061107231456.GB7796@elf.ucw.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>>> Lets say time-spent-outside-spinlock == time-spent-in-spinlock and
>>> number-of-cpus == 2.
>>>
>>> 1 < 2 , so it should livelock according to you...
>>
>> There is off-by-one bug in the condition. It should be:
>> (time_spent_in_spinlock + time_spent_outside_spinlock) /
>> time_spent_in_spinlock < number_of_cpus
>>
>> ... or if you divide it by time_spent_in_spinlock:
>> time_spent_outside_spinlock / time_spent_in_spinlock + 1 < number_of_cpus
>>
>>> ...but afaict this should work okay. Even if spinlocks are very
>>> unfair, as long as time-outside and time-inside comes in big chunks,
>>> it should work.
>>>
>>> If you are unlucky, one cpu may stall for a while, but... I see no
>>> livelock.
>>
>> If some rogue threads (and it may not even be intetional) call the same
>> syscall stressing the one spinlock all the time, other syscalls needing
>> the same spinlock may stall.
>
> Fortunately, they'll unstall with probability of 1... so no, I do not
> think this is real problem.

You can't tell that CPUs behave exactly probabilistically --- it may 
happen that one gets out of the wait loop always too late.

SMP buses have complex protocols to prevent starvation in case all CPUs 
are writing to the same cache line and similar --- however it is unusable 
againt spinlock starvation.

> If someone takes semaphore in syscall (we do), same problem may
> happen, right...? Without need for 2048 cpus. Maybe semaphores/mutexes
> are fair (or mostly fair) these days, but rwlocks may not be or
> something.

Scheduler increases priority of sleeping process, so starving process 
should be waken up first. But if there are so many processes, that process 
that passed the semaphore, sleeps and tries to take the semaphore has 
already increased priority to the level of process that waited on the 
semaphor, livelock can happen too.

Mikulas

> 									Pavel
>
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
