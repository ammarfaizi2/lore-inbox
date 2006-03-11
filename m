Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWCKFeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWCKFeb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 00:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWCKFeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 00:34:31 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:2493 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750899AbWCKFea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 00:34:30 -0500
Message-ID: <44126163.7000106@bigpond.net.au>
Date: Sat, 11 Mar 2006 16:34:27 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
References: <200603102054.20077.kernel@kolivas.org> <200603111518.46474.kernel@kolivas.org> <441251DD.8080704@bigpond.net.au> <200603111534.53220.kernel@kolivas.org>
In-Reply-To: <200603111534.53220.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 11 Mar 2006 05:34:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 11 March 2006 15:28, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>>
>>>Because despite what anyone seems to want to believe, reading from disk
>>>hurts. Why it hurts so much I'm not really sure, but it's not a SCSI vs
>>>IDE with or without DMA issue. It's not about tweaking parameters. It
>>>doesn't seem to be only about cpu cycles. This is not a mistuned system
>>>that it happens on. It just plain hurts if we do lots of disk i/o,
>>>perhaps it's saturating the bus or something. Whatever it is, as much as
>>>I'd _like_ swap prefetch to just keep working quietly at ultra ultra low
>>>priority, the disk reads that swap prefetch does are not innocuous so I
>>>really do want them to only be done when nothing else wants cpu.
> 
> 
> I didn't make it clear here the things affected are not even doing any I/O of 
> their own. It's not about I/O resource allocation. However they are using 
> 100% cpu and probably doing a lot of gpu bus traffic.
> 
> 
>>Would you like to try a prototype version of the soft caps patch I'm
>>working on to see if it will help?
> 
> 
> What happens if it's using .01% cpu and spends most of its time in 
> uninterruptible sleep?

Probably not much as I have to let tasks with a soft cap of zero get 
some CPU to avoid problems with them holding resource other tasks may 
need and 0.01% is probably as low as I can keep it anyway.

Just to clarify.  At the moment, what I do to a task with a zero soft 
cap is give them a priority one above MAX_PRIO (i.e. 2 higher than any 
other task can have) and make sure they always go on the expired array 
at the end of their time slice.  They also get a load weight of zero to 
prevent them getting a CPU to themselves.  This means that any task that 
becomes runnable on their CPU should preempt them and if they're the 
only task on their CPU it will look idle and waking tasks may be moved 
there if the other CPUs are idle.  This may be enough to stop them 
interfering with your game's tasks.

I'm currently letting them have a time slice determined by their nice in 
an attempt to reduce context switching but this may change as it 
probably allows them to get CPU access when there are non background 
tasks on the expired array.  I'm still thinking about how to prevent 
this and keep context switching low.

Tasks with non zero soft caps go through a different process and (as far 
as possible) tasks without soft caps avoid the capping code.

Peter
PS This is still work in progress.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
