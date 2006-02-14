Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161128AbWBNQch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbWBNQch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWBNQch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:32:37 -0500
Received: from rtr.ca ([64.26.128.89]:43734 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161127AbWBNQcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:32:35 -0500
Message-ID: <43F20621.5000808@rtr.ca>
Date: Tue, 14 Feb 2006 11:32:33 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Johannes Stezenbach <js@linuxtv.org>, dgc@sgi.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: dirty pages (Was: Re: [PATCH] Prevent large file writeback starvation)
References: <20060206040027.GI43335175@melbourne.sgi.com>	<20060205202733.48a02dbe.akpm@osdl.org>	<43E75ED4.809@rtr.ca>	<43E75FB6.2040203@rtr.ca>	<20060206121133.4ef589af.akpm@osdl.org>	<20060213135925.GA6173@linuxtv.org> <20060213120847.79215432.akpm@osdl.org> <43F11BA3.8060904@rtr.ca>
In-Reply-To: <43F11BA3.8060904@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Andrew Morton wrote:
>> Johannes Stezenbach <js@linuxtv.org> wrote:
>>> On Mon, Feb 06, 2006, Andrew Morton wrote:
>>>> Mark Lord <lkml@rtr.ca> wrote:
>>>>> A simple test I do for this:
>>>>>
>>>>>  $ mkdir t
>>>>>  $ cp /usr/src/*.bz2  t    (about 400-500MB worth of kernel tar files)
>>>>>  In another window, I do this:
>>>>>  $ while (sleep 1); do echo -n "`date`: "; grep Dirty 
>>>>> /proc/meminfo; done
>>>>>  And then watch the count get large, but take virtually forever
>>>>>  to count back down to a "safe" value.
>>>>>  Typing "sync" causes all the Dirty pages to immediately be flushed 
>>>>> to disk,
>>>>>  as expected.
> ...
>>> I've been seeing something like this for some time, but kept
>>> silent as I'm forced to use vmware on my Thinkpad T42p (1G RAM,
>>> but CONFIG_NOHIGHMEM=y).
>>> Sometimes 'sync' takes serveral seconds, even when the machine
>>> had been idle for >15mins. I don't have laptop mode enabled.
>>> so far I've not found a deterinistic way to reproduce this behaviour.
>>>
>>> Anyway, I temporarily deinstalled vmware (deleted the kernel
>>> modules and rebooted; kernel is still tainted because of madwifi
>>> if that matters).
>>> The behaviour I see with vmware (long 'sync' time) doesn't seem
>>> to happen without it so far ...
> 
> Mmm.. Okay, all of my machines normally have VMWare-WS installed on them,
> so that might just be the culprit.
> 
> MMMmm... isn't there an option somewhere in VMWare for lazy-writeback
> or something like that, intended to speed up use of snapshots and
> suspend/resume of VMs..  Ah, here is its description:
> 
> "Workstation uses a memory trimming technique to return unused virtual
> machine memory to the host machine for other uses. While trimming usually
> has little impact on performance and may be needed in low memory 
> situations,
> the I/O caused by memory trimming can sometimes interfere with 
> disk-oriented
> workload performance in a guest."
> 
> "Workstation uses a page sharing technique to allow guest memory pages with
> identical contents to be stored as a single copy-on-write page. Page 
> sharing
> decreases host memory usage, but consumes some system resources, 
> potentially
> including I/O bandwidth. You may want to avoid this overhead for guests for
> which host memory is plentiful and I/O latency is important."
> 
> Mmm.. so the intent is to affect only VMWare itself, not the rest of the
> system while VMWare is dormant.  I guess it's time to disable loading of
> the VMWare modules and reboot.  Bye bye uptime!   Maybe I'll install
> 2.6.16-rc3 while I'm at it.
> 
> I'll follow-up with results in an hour or two.

Okay, I fixed VMWare-WS-5.5.1 to work on 2.6.16-rc3, and tried my old test (above)
both *before* loading anything to do with VMWare, and again after using VMWare.

The old behaviour of keeping zillions of uncommitted dirty pages around is no
longer present, with or without VMWare.  So that issue appears to have gone away.

But the /proc/meminfo/Dirty value stays in the hundreds of megabytes
until I do a "sync", at which point it almost immediately drops to zero
without actually doing hundreds of MB of writes at that point.

Weird.

Cheers
