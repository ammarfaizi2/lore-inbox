Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130167AbRA2Xot>; Mon, 29 Jan 2001 18:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131249AbRA2Xoi>; Mon, 29 Jan 2001 18:44:38 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:60431 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S130167AbRA2XoY>; Mon, 29 Jan 2001 18:44:24 -0500
Message-ID: <3A7600D0.7040101@redhat.com>
Date: Mon, 29 Jan 2001 17:46:24 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@norran.net>
CC: Andrew Morton <andrewm@uow.edu.au>, yodaiken@fsmlabs.com,
        Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <01012923315600.01404@dox>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roger Larsson wrote:

> On Sunday 28 January 2001 17:17, Joe deBlaquiere wrote:
> 
>> Andrew Morton wrote:
>> 
>>> There has been surprisingly little discussion here about the
>>> desirability of a preemptible kernel.
>> 
>> And I think that is a very intersting topic... (certainly more
>> interesting than hotmail's firewalling policy ;o)
>> 
>> Alright, so suppose I dream up an application which I think really
>> really needs preemption (linux heart pacemaker project? ;o) I'm just not
>> convinced that linux would ever be the correct codebase to start with.
>> The fundamental design of every driver in the system presumes that there
>> is no preemption.
> 
> 
> please, no linux heart pacemaker at sourceforge... :-)
> 
> 
>> A recent example I came across is in the MTD code which invokes the
>> erase algorithm for CFI memory. This algorithm spews a command sequence
>> to the flash chips followed by a list of sectors to erase. Following
>> each sector adress, the chip will wait for 50usec for another address,
>> after which timeout it begins the erase cycle. With a RTLinux-style
>> approach the driver is eventually going to fail to issue the command in
>> time. There isn't any logic to detect and correct the preemption case,
>> so it just gets confused and thinks the erase failed. Ergo, RTLinux and
>> MTD are mutually exclusive. (I should probably note that I do not intend
>> this as an indictment of RTLinux or MTD, but just an example of why
>> preemption breaks the Linux driver model).
> 
> 
> Can't that happen in the 2.4.0 kernel too?
> If interrupts are not disabled during the command queuing any (with more than 
> 50 us execution time) interrupt might disturb the setup.
> That part of the code should either:
> a) accept partial success, and continue (can it check current success)
> b) disable interrupts, then shouldn't it use
>      spin_lock_irq(...) instead of spin_lock_bh(...)
> 
> Where is the code BTW? (file:line)
> is it the functions named do_erase_1_by_16_oneblock?
> 
> 

that's basically the one, just slightly modified to loop through a list 
addresses instead of the single address. It's a negligible performance 
gain, but simplified some other code I was testing.

The point is that some small set of operations may need to be atomic and 
or executed in a critical time period. Allowing these portions of code 
to be preempted opens the door for unexpected failure cases.

 
A 'perfect' driver would of course still be able to recover (or at least 
guarantee it wouldn't crash). Sometimes the timing issues aren't known 
or explictly stated, so the driver has 'never failed that way before' 
because it hasn't been tested that way.

> What about introducing a  timecritical_lock()
> #define timecritical_lock(int maxtime_us)  {__cli(); } 
> 	/* local processor only */
> 
> 
> Any driver using the timecritical_lock are not 100% RTLinux compatible,
> but should be ok in a preemtive kernel where timecritical_locks are 
> short compared to "guarantees".
> The parameter maxtime_us is a hint to system integrators - don't use drivers 
> with high maxtime in a RT system.
> 
> But it will be extremly hart to make any guarantees...
> If the driver needs the PCI bus, it might be locked for burst transfer...
> SMP issues...
> 
> 
>> Do we
>> push drivers like MTD down into preemptable-Linux? Do we push all
>> drivers down?
> 
> 
> All drivers should be compatible with preemtive-Linux, they who are not are
> unlikely to be compatible with the current Linux.
> 
> 

some kind of timecritical_lock() is a possibility. It would seem that 
such a construct would coexist with SMP and RTLinux. I guess I'm just a 
pessimist in that I expect that having not an explicit lock on time 
critical sections will eventually mean that something will invalidate 
the timing.

-- 
Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
