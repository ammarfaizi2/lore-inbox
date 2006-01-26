Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWAZATe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWAZATe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWAZATe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:19:34 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:41854 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751263AbWAZATe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:19:34 -0500
Date: Wed, 25 Jan 2006 18:16:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
In-reply-to: <43D7F863.3080207@symas.com>
To: Howard Chu <hyc@symas.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <43D814E1.7030600@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <20060124225919.GC12566@suse.de>
 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>
 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>
 <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com>
 <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Kaz's post clearly interprets the POSIX spec differently from you. The 
> policy can decide *which of the waiting threads* gets the mutex, but the 
> releasing thread is totally out of the picture. For good or bad, the 
> current pthread_mutex_unlock() is not POSIX-compliant. Now then, if 
> we're forced to live with that, for efficiency's sake, that's OK, 
> assuming that valid workarounds exist, such as inserting a sched_yield() 
> after the unlock.
> 
> http://groups.google.com/group/comp.programming.threads/msg/16c01eac398a1139?hl=en& 

Did you read the rest of this post?

"In any event, all the mutex fairness in the world won't solve the
problem. Consider if this lock/unlock cycle is inside a larger
lock/unlock cycle. Yielding at the unlock or blocking at the lock will
increase the dreadlock over the larger mutex.

The fact is, the threads library can't read the programmer's mind. So
it shouldn't try to, especially if that makes the common cases much
worse for the benefit of excruciatingly rare cases."

And earlier in that thread ("old behavior" referring to an old 
LinuxThreads version which allowed "unfair" locking):

"Notice however that even the old "unfair" behavior is perfectly
acceptable with respect to the POSIX standard: for the default
scheduling policy, POSIX makes no guarantees of fairness, such as "the
thread waiting for the mutex for the longest time always acquires it
first". Properly written multithreaded code avoids that kind of heavy
contention on mutexes, and does not run into fairness problems. If you
need scheduling guarantees, you should consider using the real-time
scheduling policies SCHED_RR and SCHED_FIFO, which have precisely
defined scheduling behaviors. "

If you indeed have some thread which is trying to do an essentially 
infinite amount of work, you really should not have that thread locking 
a mutex, which other threads need to acquire, for a large part of each 
cycle. Correctness aside, this is simply not efficient.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
