Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbTHLLJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbTHLLJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:09:09 -0400
Received: from dyn-ctb-210-9-241-99.webone.com.au ([210.9.241.99]:22032 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S270009AbTHLLJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:09:02 -0400
Message-ID: <3F38CAC6.7010808@cyberone.com.au>
Date: Tue, 12 Aug 2003 21:08:54 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: rob@landley.net
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308110248.09399.rob@landley.net> <3F385633.3090807@cyberone.com.au> <200308120629.31476.rob@landley.net>
In-Reply-To: <200308120629.31476.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rob Landley wrote:

>On Monday 11 August 2003 22:51, Nick Piggin wrote:
>
>>Rob Landley wrote:
>>
>>>On Tuesday 05 August 2003 06:32, Nick Piggin wrote:
>>>
>>>>But by employing the kernel's services in the shape of a blocking
>>>>syscall, all sleeps are intentional.
>>>>
>>>Wrong.  Some sleeps indicate "I have run out of stuff to do right now, I'm
>>>going to wait for a timer or another process or something to wake me up
>>>with new work".
>>>
>>>
>>>
>>>Some sleeps indicate "ideally this would run on an enormous ramdisk
>>>attached to gigabit ethernet, but hard drives and internet connections
>>>are just too slow so my true CPU-hogness is hidden by the fact I'm
>>>running on a PC instead of a mainframe."
>>>
>>I don't quite understand what you are getting at, but if you don't want to
>>sleep you should be able to use a non blocking syscall.
>>
>
>So you can then block on poll instead, you mean?
>

Well if thats what you intend, yes. Or set poll to be non-blocking.

>
>>But in some cases
>>I think there are times when you may not be able to use a non blocking
>>call.
>>
>>And if a process is a CPU hog, its a CPU hog. If its not its not. Doesn't
>>matter how it would behave on another system.
>>
>
>Audio playback, video playback, animated gifs in your web browser, and even 
>first person shooters have built in rate limiting.  (Okay, games can go to an 
>insanely high framerate, but usually they achieve "good enough" and are happy 
>with that unless you're doing a benchmark with them.)
>
>There is a certain rate of work they do, and if they can manage that they stop 
>working.  On a system with twice as much CPU power and disks twice as fast, 
>kmail shouldn't use significantly more CPU keeping up with my typing.  These 
>are "interactive" tasks.
>
>Bug gzip, tar, gcc, and most cron jobs, are a different type of task.  They 
>have nobuilt-in rate limiting.  On a system with twice as much CPU and disks 
>twice as fast, they finish twice as quickly.  They never voluntarily go idle 
>until they exit; when they're idle it just means they hit a bottleneck.  The 
>system can never be "fast enough" that these quiesce themselves for a while 
>because they've run out of work just now.
>
>These are hogs, often both of CPU time and I/O bandwidth.  Being blocked on 
>I/O does not stop them from being hogs, it just means they're juggling their 
>hoggishness.
>

This is the CPU scheduler though. A program could be a disk/network
hog and use a few % cpu. Its obviously not a cpu hog, and should get
the cpu again soon after it is woken. Sooner than non running cpu hogs,
anyway.

>
>An mpeg player has times when it's neither blocked on CPU or on I/O, it's 
>waiting until it's time to display the next frame.
>
>Now some of this could be viewed as a spooler problem, where there's a slow 
>output device (the screen, the sound card, etc) and if you wanted to you 
>could precompute stuff into a big memory wasting buffer and then instead of 
>skipping because you're not getting scheduled fast enough you're skipping 
>because your precomputed buffer got swapped to disk.  But the difference here 
>is that xmms or  xine could do their output generation much faster than they 
>are, if they wanted to.  The output device could be sped up.  Your animated 
>gif can cycle too fast to see, you can fast-forward through your movie, you 
>can play an mpeg so it sounds like chip and dale on helium...  But they 
>don't, they intentionally rate limit the output, and what they want in return 
>is low latency when the rate limiting is up.
>
>When you're rate limiting the output, you want to accurately control the rate.  
>You don't want it to be too fast (timers are great at this), and you don't 
>want it to be too slow (you get skips or miss frames).
>
>That's what Con's detecting.  It's a heuristic.  But it's a good heuristic.  A 
>process that plays nice and yields the CPU regularly gets a priority boost.  
>(That's always BEEN a heuristic.)
>
>The current scheduler code has moved a bit beyond this, but this is the bit I 
>was talking about when I disagreed with you earlier.
>

Yeah, I know Con is trying to detect this. Its just that detecting
it using TASK_INTERRUPTIBLE/TASK_UNINTERRUPTIBLE may not be the best
way. Suddenly your kernel compile on an NFS mount becomes interactive
for example. Then again, the way things are, Con might not have any
other option.

Mostly I agree with what you've said above.


