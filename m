Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272478AbTHEKdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272535AbTHEKdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:33:15 -0400
Received: from dyn-ctb-203-221-74-83.webone.com.au ([203.221.74.83]:4100 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272478AbTHEKdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:33:09 -0400
Message-ID: <3F2F87DA.7040103@cyberone.com.au>
Date: Tue, 05 Aug 2003 20:32:58 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <1060060568.3f2f3d989683f@kolivas.org> <3F2F4076.1030009@cyberone.com.au> <200308052022.01377.kernel@kolivas.org>
In-Reply-To: <200308052022.01377.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Tue, 5 Aug 2003 15:28, Nick Piggin wrote:
>
>>Con Kolivas wrote:
>>
>>>Quoting Nick Piggin <piggin@cyberone.com.au>:
>>>
>>Yes yes, but we come to the same conclusion no matter why you have decided
>>to make the change ;) namely that you're only papering over a flaw in the
>>scheduler!
>>
>
>This would take a redesign in the interactivity estimator. I worked on one for 
>a while but decided it best to stick to one infrastructure and tune it as 
>much as possible; especially in this stage of 2.6 blah blah...
>
>
>>What happens in the same sort of workload that is using interruptible
>>sleeps?
>>Say the same make -j NFS mounted interrruptible (I think?).
>>
>
>Dunno. Can't say. I've only ever seen NFS D but I don't have enough test 
>material...
>
>
>>I didn't really understand your answer a few emails ago... please just
>>reiterate: if the problem is that processes sleeping too long on IO get
>>too high a priority, then give all processes the same boost after they
>>have slept for half a second?
>>
>>Also, why is this a problem exactly? Is there a difference between a
>>process that would be a CPU hog but for its limited disk bandwidth, and
>>a process that isn't a CPU hog? Disk IO aside, they are exactly the same
>>thing to the CPU scheduler, aren't they?
>>
>>_wants_ to be a CPU hog, but can't due to disk
>>
>
>You're on the right track; I'll try and explain differently. 
>
>A truly interactive task has periods of sleeping irrespective of disk 
>activity. It is the time spent sleeping that the estimator uses to decide 
>"this task is interactive, improve it's dynamic priority by 5". A true cpu 
>hog (eg cc1) never sleeps intentionally and the estimator sees this as "I'm a 
>hog; drop my priority by 5". Now if the cpu hog sleeps while waiting on disk 
>i/o the estimator suddenly decides to elevate it's priority. If it gets to 
>maximum boost and then stops doing I/O and goes back to being a hog it now 
>starts starving other processes till it's dynamic priority drops enough 
>again. As I said it's a design quirk (bug?) and _limiting_ how high the 
>priority goes if the sleep is due to I/O would be ideal but I don't have a 
>simple way to tell that apart from knowing that the sleep was 
>UNINTERRUPTIBLE. This is not as bad as it sounds as for the most part it 
>still is counted as sleep except that it can't ever get maximum priority 
>boost to be a sustained starver.
>

But by employing the kernel's services in the shape of a blocking
syscall, all sleeps are intentional. I think what you see is interactive
apps sleep in select which is interruptible. Anyway, I'll grant you that
a true cpu hog never sleeps, but then you don't have to worry about what
happens if it were to submit IO ;)

If cc1 is doing a lot of waiting on IO, I fail to see how it should be
called a CPU hog. OK I'll stop being difficult! I understand the problem
is that its behaviour suddenly changes from IO bound to CPU hog, right?
Then it seems like the scheduler's problem is that it doesn't adapt
quickly enough to this change.

What you are doing is restricting some range so it can adapt more quickly
right? So you still have the problem in the cases where you are not
restricting this range.


