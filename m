Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbTFSBtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265696AbTFSBtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:49:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48376 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265695AbTFSBtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:49:19 -0400
Message-ID: <3EF119AD.9050000@mvista.com>
Date: Wed, 18 Jun 2003 19:02:21 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: "'Andrew Morton'" <akpm@digeo.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
 sks
References: <A46BBDB345A7D5118EC90002A5072C780DD16D38@orsmsx116.jf.intel.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780DD16D38@orsmsx116.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
>>From: Andrew Morton [mailto:akpm@digeo.com]
>>
>>Various things like character drivers do rely upon keventd services.  So
> 
> it
> 
>>is possible that bash is stuck waiting on keyboard input, but there is no
>>keyboard input because keventd is locked out.
>>
>>I'll take a closer look at this, see if there is a specific case which can
>>be fixed.
>>
>>Arguably, keventd should be running max-prio RT because it is a kernel
>>service, providing "process context interrupt service".
> 
> 
> Now that we are at that, it might be wise to add a higher-than-anything
> priority that the kernel code can use (what would be 100 for user space,
> but off-limits), so even FIFO 99 code in user space cannot block out
> the migration thread, keventd and friends.

Wait a bit (or even a byte) here.  I think the proper thing to do, IF 
we want to go down this road, is to seperate out the various 
subsystems and give them each their own kernel task or workqueue. 
Then  those who need to could adjust, for example, network code to run 
after real time process control and prior to print jobs, priority 
wise, that is.  Likewise, you could adjust the console access to be 
higher priority than the network so that we call always talk to the 
system.  If you give any kernel thread an untouchable priority, you 
might just as well move the work back to a bottom half or even the 
interrupt code.

-g
> 
> 
>>IIRC, Andrea's kernel runs keventd as SCHED_FIFO.  I've tried to avoid
>>making this change for ideological reasons ;) Userspace is more important
>>than the kernel and the kernel has no damn right to be saying "oh my stuff
>>is so important that it should run before latency-critical user code".
> 
> 
> I agree with that, but the consequence is kind of ugly; not that a true
> real-time embedded process is going to be printing to the console, but 
> it might be outputting to a serial line, so now they rely on the keventd.
> 
> BTW, I have seen similar problems wrt to the migration thread, where a
> FIFO 20 process would get stuck in CPU1, that is taken by a FIFO 40
> while CPU0 was running a FIFO 10 -- however, I am not that positive
> that it is a migration thread problem; I blame it more on the scheduler
> not taking into account priorities for firing the load balancer. It is
> a tricky thingie, though. Affinity helps, in this case.
> 
> Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
> (and my fault)
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

