Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWAYWPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWAYWPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWAYWPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:15:46 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:11268 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932172AbWAYWPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:15:45 -0500
Message-ID: <43D7F863.3080207@symas.com>
Date: Wed, 25 Jan 2006 14:14:59 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>	 <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe>
In-Reply-To: <1138223212.3087.16.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2006-01-25 at 10:26 -0800, Howard Chu wrote:
>   
>> The SUSv3 text seems pretty clear. It says "WHEN
>> pthread_mutex_unlock() 
>> is called, ... the scheduling policy SHALL decide ..." It doesn't say 
>> MAY, and it doesn't say "some undefined time after the call."  
>>     
>
> This does NOT require pthread_mutex_unlock() to cause the scheduler to
> immediately pick a new runnable process.  It only says it's up the the
> scheduling POLICY what to do.  The policy could be "let the unlocking
> thread finish its timeslice then reschedule".
>   

This is obviously some very old ground.

http://groups.google.com/groups?threadm=etai7.108188%24B37.2381726%40news1.rdc1.bc.home.com

Kaz's post clearly interprets the POSIX spec differently from you. The 
policy can decide *which of the waiting threads* gets the mutex, but the 
releasing thread is totally out of the picture. For good or bad, the 
current pthread_mutex_unlock() is not POSIX-compliant. Now then, if 
we're forced to live with that, for efficiency's sake, that's OK, 
assuming that valid workarounds exist, such as inserting a sched_yield() 
after the unlock.

http://groups.google.com/group/comp.programming.threads/msg/16c01eac398a1139?hl=en&

But then we have to deal with you folks' bizarre notion that 
sched_yield() can legitimately be a no-op, which also defies the POSIX 
spec. Again, in SUSv3 "The /sched_yield/() function shall force the 
running thread to relinquish the processor until it again becomes the 
head of its thread list. It takes no arguments." There is no language 
here saying "sched_yield *may* do nothing at all." There are of course 
cases where it will have no effect, such as when called in a 
single-threaded program, but those are the exceptions that define the 
rule. Otherwise, the expectation is that some other runnable thread will 
acquire the CPU. Again, note that sched_yield() is a core function of 
the Threads specification, while scheduling policies are an optional 
feature. The function's core behavior (give up the CPU and make some 
other runnable thread run) is invariant; the current thread gives up the 
CPU regardless of which scheduling policy is in effect or even if 
scheduling policies are implemented at all. The only behavior that's 
open to implementors is which *of the other runnable threads* is chosen 
to take the place of the current thread.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

