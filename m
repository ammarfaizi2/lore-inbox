Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSGDRVw>; Thu, 4 Jul 2002 13:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSGDRVv>; Thu, 4 Jul 2002 13:21:51 -0400
Received: from h-64-105-34-244.SNVACAID.covad.net ([64.105.34.244]:10441 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S312254AbSGDRVu>; Thu, 4 Jul 2002 13:21:50 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 4 Jul 2002 10:24:11 -0700
Message-Id: <200207041724.KAA06758@adam.yggdrasil.com>
To: R.E.Wolff@BitWizard.nl
Subject: Re: Rusty's module talk at the Kernel Summit
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolfff wrote:
>Adam J. Richter wrote:
>> >The total saving over all 2.5.24 modules is 4% of the total module
>> >sizes, rounded to page boundaries.
>> 
>>       As individual space optimizations go, 4% is respectable,
>> especially for something that has no cost, helps detect bugs and
>> simplifies the kernel.  It is hard to think of many potential
>> other space improvements that would as effective, especially as
>> function of implementation effort.  In comparison, my vmlinux is
>> 5% init sections.  So, if init sections are worth it for the
>> core kernel, they should be worth it for modules.
>
>Ehmmm. You normally load one big 1Mb kernel, freeing about 40 or 50k
>at init time.
>
>You normally load a couple of modules, totalling much less. 
>
>Hmm. Just checked on a system with sound as modules, I see half a
>megabyte of modules. So maybe that 20k is worth it. On the other hand,
>you only load half a megabyte of shit if you have the RAM to spare.
>20k is not worth the time I spend typing this....

	The system that I am composing this email on has 1.1MB of
modules and does not have sound drivers loaded.  It has ipv4 and a
number of other facilities modularized that are not modules in the
stock kernels.  Every system that I use has a configuration like this.
With a lower per-module overhead, I would be more inclined to try to
modularize other facilities and break up some larger modules into
smaller ones, in the case where there is substantial code that is not
needed for some configurations.

	Just for fun, using your numbers and US dollars:

    20kB DRAM x $150/GB of DRAM    = $0.003
    $0.003/user x 10 million users = $30,000 contribution to Linux users


>> >Most of that saving comes from a few modules.
>> 
>>       This makes me wonder if __init procedures are not being
>> aggressively identified.  I wonder if people would use __init a little
>> more if they knew they would get the benefit of it in the module case.
>> Perhaps someday someone will write a tool to identify procedures that
>> are only called from init sections.
>
>Sometimes the "error path" will try to reset/reinit the chip. You will
>not see that happening during a normal usage cycle, but you will get
>bitten if you remove the init based on an actual call-trace.... 

	Such routines would correctly be skipped by the tool that I
described.

>>       Kernel modules have been a way of life for me for years, and I
>> don't think I've ever caught a kernel bug by the mechanism that you
>
>This happens often enough "during development" that the bugs get fixed
>before you get to see them....

	As I said, you could have the following facility for when you
want to force use of vmalloc:

>> describe.  However, I see no harm in having a debugging option that
>> always vmalloc'ed kernel modules.  This faciilty could be entirely
>> configuarable from user level by having insmod allocate a module of
>> *exactly* one page for modules that were less than a page (since you
>> would only want to kmalloc modules that were *less* than one page).
>
>As far as I know, kmallocing more than half a page will actually
>allocate the whole page.

	If so, then that could be retuned if it turns out to be
optimal to do so.  Even without the change, there could still be a lot
of modules under half a page, such as the logitech bus mouse driver
that is loaded on this system right now.

	Making efficient use of a resource like memory often involves
repeatedly grabbing small savings of a percent or two.  Maybe you
start by releasing .init.data for 2%.  Then somebody submits a patch
to release .init.text without substantial kernel modifications (even
if only on x86) for 2%.  Then somebody writes a script to identify
.text and .data labels that are only referenced from init sections,
and that saves another 1%.  Then somebody adds a flag to insmod to
load modules in a non-removable mode that does not load the exit
sections, saving another 0.25%.  Then somebody changes allocation of
modules that are less than a page to use kmalloc(GFP_HIGHMEM) instead
of vmalloc (~30% of modules on my system are already this small).
Then somebody figures out a way to have vmalloc's larger than a page
that do not need page alignment can sometimes start in the unused last
page of another vmalloc.  This reduction in the per-module memory
overhead encourages people chip off some parts of larger library
modules that are not used by all of the clients of that library.  Then
somebody adds an kernel option to configure out some kernel code that
is unnecessary in an "everything is a module" configuration, and so on.

	At the end of the day, somebody who is trying to deploy web
browsers on donated PC's for the local school district without
maintaining a custom kernel finds that they can, or someone is able to
squeeze IPSec into the wireless access point that they turned into a
router, or someone finds that they can run a more standard kernel on a
future wristwatch, or someone chooses Linux over Vxworks for a storage
area network disk drive dongle for lower engineering costs and greater
extensibility.  Incremental savings can add up to important advantages.
 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
