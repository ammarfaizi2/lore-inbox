Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTIGEhw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 00:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTIGEhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 00:37:52 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:42501
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261940AbTIGEhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 00:37:50 -0400
Message-ID: <3F5AB612.6040708@cyberone.com.au>
Date: Sun, 07 Sep 2003 14:37:38 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au> <6470000.1062819391@[10.10.2.4]> <3F5980CD.2040600@cyberone.com.au> <139550000.1062861227@[10.10.2.4]>
In-Reply-To: <139550000.1062861227@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>I think the two will always related. One means giving a higher
>>dynamic priority, the other a bigger timeslice. So you want
>>say gcc to have a 100ms timeslice with lowest scheduling prio,
>>but X to have a 20ms slice and a very high scheduling priority.
>>
>
>Right.
> 
>
>>Unfortunately, the way the scheduler currently works, X might
>>use all its timeslice, then have to wait 100ms for gcc to finish
>>its. The way I do it is give a small timeslice to high prio tasks,
>>and lower priority tasks get progressively less.
>>
>
>If the interactive task uses all it's timeslice, then it's not really
>very interactive, it's chewing quite a bit of CPU ... presumably in
>the common case, these things don't finish their timeslices. I thought
>we preempted the running task when a higher prio one woke up, so this
>should still work, right?
>

No, you are _very_ right about that.

>
>So it would seem to make sense to boost the prio of a interactive task 
>*without* increasing the size of it's timeslice.
>

Well, what I do is boost their priority and make the timeslices of non
interactive apps smaller. And sometimes they do need small bursts of
using a lot of cpu.

>
>>When _only_ low priority tasks are running, they'll all get long
>>timeslices.
>>
>
>That at least makes sense. AFIAK at least the early versions of Con's
>stuff make cpu bound jobs' timeslices short even if there were no
>interactive jobs. I don't like that (or more relevantly, the benchmarks
>don't either ;-)).
>
>
>>OK well just as a rough idea of how mine works: worst case for
>>xmms is that X is at its highest dynamic priority (and reniced).
>>xmms will be at its highest dynamic prio, or maybe one or two
>>below that.
>>
>>X will get to run for maybe 30ms first, then xmms is allowed 6ms.
>>That is still 15% CPU. And X soon comes down in priority if it
>>continues to use a lot of CPU.
>>
>
>If it works in practice, it works, I guess. I just don't see why X
>is super special ... are we going to have to renice *all* interactive 
>tasks in order to get things to work properly?
>

The reason X is special is that it uses a lot of CPU, and it can be
continually using a lot of CPU, but it is "interactive" - it probably
requires the lowest scheduling latency of any other interactive process
because it runs the mouse, screen, keyboard etc, things that obviously
can't make use of much buffering, if any.

If you wanted X to be treated as any other process, thats fine, use
renice 0. It will be given low priorities when using lots of CPU
though.


