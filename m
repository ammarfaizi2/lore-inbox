Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVH3RpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVH3RpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVH3RpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:45:03 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:63938 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932229AbVH3RpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:45:00 -0400
Date: Tue, 30 Aug 2005 19:44:57 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
In-Reply-To: <20050829091038.GA30073@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0508301928260.17275@artax.karlin.mff.cuni.cz>
References: <1125069494.18155.27.camel@betsy> <20050827124148.GE1109@openzaurus.ucw.cz>
 <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz>
 <20050828080959.GB2039@elf.ucw.cz> <Pine.LNX.4.62.0508282109040.1489@artax.karlin.mff.cuni.cz>
 <20050829083552.GD28077@elf.ucw.cz> <Pine.LNX.4.58.0508291057400.27754@fachschaft.cup.uni-muenchen.de>
 <20050829091038.GA30073@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>>>>>> I think he doesn't need to export it at all and he should write code to
>>>>>> park and disable hard disk instead.
>>>>>> (in userspace it's unsolvable --- i.e. you can't enable hard disk when
>>>>>> detected stable condition if the daemon is swapped out on that hard disk)
>>>>>
>>>>> man mlockall() :-).
>>>>
>>>> You also must not use any syscall that allocates even temporary memory in
>>>> kernel (select, poll, many others ...) or that waits on semaphore that
>>>> might be held while allocating memory (i.e. audit and rewrite ide ioctl
>>>> path).
>>>
>>> Kernel module would have exactly same problem.

In kernel there are many paths how to call something in ide driver. In 
userspace there is only one --- ioctl.

In kernel you can write something like
int register_panic_event(void (*fn)(void *opaque, int stable), void 
*opaque);
void unregister_panic_event(void (*fn)(void *opaque, int stable), void 
*opaque);
and
void generate_panic_event(int stable);
... so that drivers can make hooks to do things when notebook falls. And 
it can protect not only primary IDE, but also disks on additional cards, 
USB disks etc. In userspace it would be pain to let the driver support all 
types of devices, scan for them (how?) etc.

>> It has control of its memory allocations.
>
> It will have to be carefull with doing calls that allocate memory, and
> to avoid semaphores that may block it...
>
>>>> And you need extra flags to protect the daemon from being killed at
>>>> shutdown or blocked at suspend.
>>>
>>> Why?

If the daemon parks head and blocks ide queue and you kill it, the queue 
won't ever be unblocked.

>> Because the disk must be unlocked even if the laptop falls down while
>> a suspension or shutdown are under way.
>> And it should work until the heads are parked anyway.
>
> It can't. It has to be user controllable at any point, or you will not
> be able to shutdown your notebook while on bumpy road.

The whole userspace is paged, so if the daemon locks up disk forever, it 
would be impossible to turn it off anyway (you can with some pain make the 
daemon unpaged, but you can't do that for user's shell).

> Anyone who wants to put it into kernel _please_ read that IBM
> paper. It is really complex, with some signal processing, and it goes
> wrong at times, so it needs UI so you can disable it.

They use some auto-adjusting of values. BTW. they have a bug in bios that 
it waits until stable condition and refuses to boot on a road.


Maybe something like this woule be reliable: get some value how much the 
notebook moves, if the current value greater that the average (over some 
time), park disk. --- it can't lock-up forever because the value can't 
grow forever. If you tilt the notebook on a road or move it on the table, 
it would park (which exactly what you want).

Mikulas

> 								Pavel
> -- 
> if you have sharp zaurus hardware you don't need... you know my address
>
