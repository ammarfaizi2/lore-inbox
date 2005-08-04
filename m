Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVHDSJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVHDSJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVHDSJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:09:50 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:21486 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261973AbVHDSJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:09:47 -0400
Message-ID: <42F259DE.9050500@anagramm.de>
Date: Thu, 04 Aug 2005 20:09:34 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: How to get the physical page addresses from a kernel virtualaddress
 for DMA SG List?
References: <42F20CEC.60206@anagramm.de>	 <Pine.LNX.4.61.0508040900300.3410@chaos.analogic.com>	 <42F21A86.8030408@anagramm.de>	 <1123163846.12009.15.camel@localhost.localdomain>	 <Pine.LNX.4.61.0508041009350.3645@chaos.analogic.com> <1123174907.12009.27.camel@localhost.localdomain>
In-Reply-To: <1123174907.12009.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, colleagues!

Thanks again for your points!
I understand that we do the malloc the other way around and that this
might be wrong from your point of view. I also see that there are
issues with that, which I am about to carry into our software
development for discussion. Maybe we will change things there.

But the basic idea is still to use all amount of free physical ram for
dma'ing our data... for that it shouldn't matter who allocates it
(user or kernel). As long as I can get my physical address to it, which
was my problem.
It would be also nice to alloc that dynamically (not mem=, ioremap/mmap)
to allow the system to use the memory for other things, when
our application is not doing it's crazy job.

To give you some details about the application:
Our system and so the driver is specific to our hardware, which is
an embedded mpc8540 based highspeed framegrabber for 200MByte/sec.
All memory acces granularity is page oriented... so there are no
shared pages or other things like that. The memory gets alloced
by the app once, locked once, and re-used until the app exits.
There is no swapping or other tricky things.
The CPU's task is to process the data already while there is still
new data coming in. Processed data gets written to a RAID system
as fast as possible via another DMA engine.

Just for an example:
A frame of an image has about 40MBytes size.
The system is able to do multishot images as fast as possible until
the physical memory is full. If memory gets released as a processed frame
is written to disk, we can trigger another frame from the framegrabber
dma. etc. pp.
So, this system for sure is "special" - it's all about performance here.
And some hacks are okay as long as we know what we do (with your help).
It's not an academic thing... it's a product :-)

And, finally, I got the answer to my question of
how I can get the physical address of my virtual?:

-> the baby is called    iopa()

it takes a virtual address and gives me the physical address. :-)
It does this by walking through the page tables (which is afaik not
a trivial thing and maybe not portable, too).

It seems to work fine... and I can now blow data the way I want...
And yes, it is fast! B-)

Best greets,

Clemens


Steven Rostedt wrote:
> On Thu, 2005-08-04 at 10:56 -0400, linux-os (Dick Johnson) wrote:
> 
>>On Thu, 4 Aug 2005, Steven Rostedt wrote:
>>
>>>The driver doing the allocation would probably be easier.  Do you mean
>>>that the application will do some large malloc and then pass that
>>>address to the driver?  The driver would then need to map in those pages
>>>since most of them would probably not be even allocated yet (no physical
>>>memory associated to them).  Then there's always the point to prevent
>>>abuse by the user.  If the driver did the allocation, it would just be
>>>easier to control.
>>>
> 
> [...]
> 
>>The software architecture is simply wrong. He wants to DMA data
>>into user-space, continuously, faster than the CPU can do anything
>>with the data. If the data is anything more than an experiment
>>in "how fast can DMA write to RAM", then the data needs to be
>>used, i.e., processed. In the real world of high-speed data
>>processing (like image processing), one writes, using DMA or
>>whatever, into a buffer that is to be processed. DMA is often
>>used so that more data can be received while the previously-
>>received data is being processed. The buffers are usually
>>allocated as a linked-list or as a pair of buffers to be
>>ping/ponged. Allocating a gigantic buffer for any purpose,
>>including sorting databases, is simply wrong.
>>
> 
> 
> I just figured that his system was something unique and that he knows
> what he's doing in regard to that.
> 
> 
>>Data processing involves accessing data in arrays or
>>structures that emulate arrays of aggregate types. This
>>means that nearby elements are usually accessed, not elements
>>that are randomly scattered throughout address-space. This
>>locality of action is well known and is in fact why
>>paging is possible to provide virtual address-space.
>>
>>Allocation of DMA pages by the user will fail. This is
>>because many of the user's pages will likely point to
>>the exact same page of (probably non-existant) RAM.
>>That's how a virtual memory system works. In fact,
>>allocation of virtual address space from user-mode
>>just tells the kernel not to seg-fault the user if
>>an access is made that hasn't been allocated yet.
> 
> 
> [snip long explaination of the VM layer]
> 
> 
>>This is why the driver must obtain the DMA pages and
>>the user must use mmap() to map those pages into its
>>address space. It's not a matter of being "easier",
>>it's a matter of it being the only way that will work.
> 
> 
> Well it definitely looks easier to me :-) I wouldn't say it's the only
> way it will work, I would be kinder and say any other way would be
> excruciatingly harder! As you explained.
> 
> 
>>Also, if Mr. Koller insists upon doing the absurd, i.e.,
>>allocating gigabytes of DMA RAM, he is going to have to
>>reserve memory that only his driver knows about, using
>>the "mem=" parameter on the boot command line. Then the
>>"extra" RAM above the kernel can be mapped using
>>ioremap_nocache() and made available for DMA and mmap().
>>
> 
> 
> Yeah the reserving of 1.5+G would be difficult in a 32 bit address
> space. But I'm sure there's ways around it.
> 
> He never actually said what his goal was. This could be simply academic,
> I don't know.  But if he got it to work, at least that would be cool.
> (although I would never do such a thing in the "real" world ;-)
> 
> 
> -- Steve
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
