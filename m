Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTIFGiT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 02:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbTIFGiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 02:38:19 -0400
Received: from dyn-ctb-203-221-72-243.webone.com.au ([203.221.72.243]:51460
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263068AbTIFGiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 02:38:14 -0400
Message-ID: <3F5980CD.2040600@cyberone.com.au>
Date: Sat, 06 Sep 2003 16:38:05 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au> <6470000.1062819391@[10.10.2.4]>
In-Reply-To: <6470000.1062819391@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>Yep, as Mike mentioned, renicing X causes it to get bigger
>>timeslices with the stock scheduler. If you had 2 nice -20 processes,
>>they would each get a timeslice of 200ms, so you're harming their
>>latency.
>>
>
>Well, if I can be naive for a second (and I'll fully admit I don't
>understand the implications of this), there are two things here - 
>either give it more of a timeslice (bandwidth increase), or make it 
>more interactive (latency increase). Those two seem to be separable,
>but we don't bother. Seems better to pass a more subtle hint to the
>scheduler that this is interactive - nice seems like a very large
>brick between the eyes.
>

I think the two will always related. One means giving a higher
dynamic priority, the other a bigger timeslice. So you want
say gcc to have a 100ms timeslice with lowest scheduling prio,
but X to have a 20ms slice and a very high scheduling priority.

Unfortunately, the way the scheduler currently works, X might
use all its timeslice, then have to wait 100ms for gcc to finish
its. The way I do it is give a small timeslice to high prio tasks,
and lower priority tasks get progressively less.

When _only_ low priority tasks are running, they'll all get long
timeslices.

>
>>>There may be some more details around this, and I'd love to hear them,
>>>but I fundmantally believe that explitit fiddling with particular
>>>processes because we believe they're somehow magic is wrong (and so
>>>does Linus, from previous discussions).
>>>
>>Well it would be nice if someone could find out how to do it, but I
>>think that if we want X to be able to get 80% CPU when 2 other CPU hogs
>>are running, you have to renice it.
>>
>
>OK. So you renice it ... then your two cpu jobs exit, and you kick off
>xmms. Every time you waggle a window, X will steal the cpu back from
>xmms, and it'll stall, surely? That's what seemed to happen before.
>I don't see how you can fix anything by doing static priority alterations
>(eg nice), because the workload changes.
>
>I'm probably missing something ... feel free to slap me ;-)
>

OK well just as a rough idea of how mine works: worst case for
xmms is that X is at its highest dynamic priority (and reniced).
xmms will be at its highest dynamic prio, or maybe one or two
below that.

X will get to run for maybe 30ms first, then xmms is allowed 6ms.
That is still 15% CPU. And X soon comes down in priority if it
continues to use a lot of CPU.


