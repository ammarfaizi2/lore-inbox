Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272413AbTGaGqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272421AbTGaGqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:46:12 -0400
Received: from dyn-ctb-210-9-243-68.webone.com.au ([210.9.243.68]:2067 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272413AbTGaGqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:46:06 -0400
Message-ID: <3F28BB20.6040707@cyberone.com.au>
Date: Thu, 31 Jul 2003 16:45:52 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: as / scheduler question
References: <200307290908.09065.kernel@kolivas.org> <20030728160117.3f679f01.akpm@osdl.org> <200307290925.10876.kernel@kolivas.org>
In-Reply-To: <200307290925.10876.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Tue, 29 Jul 2003 09:01, Andrew Morton wrote:
>
>>Con Kolivas <kernel@kolivas.org> wrote:
>>
>>>Nick
>>>
>>>With the sheduler work Ingo and I have been doing I was wondering if
>>>there was possibly a problem with requeuing kernel threads at certain
>>>intervals? Ingo's current version requeues all threads at 25ms and I just
>>>wondered if this number might be a multiple or factor of a magic number
>>>in the AS workings, as we're seeing a few changes in behaviour with AS
>>>only. I'm planning on leaving kernel threads out of this requeuing, but I
>>>thought I could also pick your brain.
>>>
>>What does "requeues all threads at 25ms" mean?
>>
>>The only dependency we should have there is that kblockd should be
>>scheduled promptly after it is woken.  It is reniced by -10 so it should be
>>OK. Renicing it further or making it SCHED_RR/FIFO would be interesting.
>>
>
>Ingo introduced the concept of TIMESLICE_GRANULARITY a while ago. All 
>processes currently running on the active queue get interrupted in their 
>timeslice after TIMESLICE_GRANULARITY (currently set at 25ms and the subject 
>of another thread), and put on the tail of the active array to continue their 
>timeslice after other processes at the same priority on the active queue get 
>to run, also for at most TIMESLICE_GRANULARITY. If kblockd is reniced to -10 
>it wont have a problem unless something else ends up with the same dynamic 
>priority which would only happen if there are interactive tasks reniced to 
>-10. If it's the only process on the active array at that priority it 
>_should_ run unaffected.
>

OK, well if they've been running for more than 6ms then AS goes out of
the picture, so no, shouldn't make a difference.

In general, on the read side, the disk scheduler can determine how
tasks get woken after waiting on reads, and on the write side its more
the request allocation. If CPU bound processes are running as well
though, then its a process scheduler decision about how soon a woken
process gets to run - I think IO performance wants this figure to be
nice and low.


