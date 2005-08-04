Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVHDPA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVHDPA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVHDO62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:58:28 -0400
Received: from spirit.analogic.com ([208.224.221.4]:19208 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S262482AbVHDO4y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:56:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1123163846.12009.15.camel@localhost.localdomain>
References: <42F20CEC.60206@anagramm.de> <Pine.LNX.4.61.0508040900300.3410@chaos.analogic.com> <42F21A86.8030408@anagramm.de> <1123163846.12009.15.camel@localhost.localdomain>
X-OriginalArrivalTime: 04 Aug 2005 14:56:52.0349 (UTC) FILETIME=[BF9B92D0:01C59904]
Content-class: urn:content-classes:message
Subject: Re: How to get the physical page addresses from a kernel virtualaddress for DMA SG List?
Date: Thu, 4 Aug 2005 10:56:17 -0400
Message-ID: <Pine.LNX.4.61.0508041009350.3645@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to get the physical page addresses from a kernel virtualaddress for DMA SG List?
thread-index: AcWZBL+iqln0ucu9TXms61IP2O0p2Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Clemens Koller" <clemens.koller@anagramm.de>,
       "LKML List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Aug 2005, Steven Rostedt wrote:

> On Thu, 2005-08-04 at 15:39 +0200, Clemens Koller wrote:
>>> You are trying to do it backwards. You need to have your driver
>>> use get_dma_pages() to acquire pages suitable for DMA. Your
>>> driver then impliments mmap().
>>
>> Okay, I have seen that, too. I've seen that some drivers do it the other
>> way around as I do, but I still try to follow my idea that the
>> application allocs the memory and the dma / the driver fills it up.
>> Or are there fundamental problems I get with my approach which I haven't seen yet?
>
> The driver doing the allocation would probably be easier.  Do you mean
> that the application will do some large malloc and then pass that
> address to the driver?  The driver would then need to map in those pages
> since most of them would probably not be even allocated yet (no physical
> memory associated to them).  Then there's always the point to prevent
> abuse by the user.  If the driver did the allocation, it would just be
> easier to control.
>
>>> The user-mode application then mmaps() the dma-able pages into
>>> its address-space. FYI, the pages may be from anywhere, some
>>> archs can only DMA to/from memory below 16MB.
>>
>> My DMA machine (ppc32, mpc8540 cpu) can do the whole 32bit phys address
>> space so, that's not an issue here.
>
> I guess you don't mind that your driver will be locked to a specific
> architecture. Or at least one that can handle these requirements. Is
> this just for a single use?
>
>>
>>> The pages do not have
>>> to be continuous because you will build a scatter-list for
>>> the DMA engine and you will mmap() the pages so they are
>>> contiguous to the user.
>>
>> Yes, only virtual space is contigous. The DMA can do nice
>> sg_lists and chained sg_lists, so, this should not be a problem,
>> too.
>>
>>> Also 400 Megabytes is absurd.
>>
>> Why?
>> Actually I am planning to alloc more than 1.5GByte at once,
>> lock that down, build a big sg_list for all that memory because
>> I need to _continously_ feed it with data from the DMA. I get
>> about 200MBytes/sec and I cannot stop in between!
>
> Wow! what a system you must have :-)   With a 32 bit address space that
> really does take a big chunck out of it.  Well I guess whatever device
> this driver is for must be for some specific architecture.
>
> -- Steve

The software architecture is simply wrong. He wants to DMA data
into user-space, continuously, faster than the CPU can do anything
with the data. If the data is anything more than an experiment
in "how fast can DMA write to RAM", then the data needs to be
used, i.e., processed. In the real world of high-speed data
processing (like image processing), one writes, using DMA or
whatever, into a buffer that is to be processed. DMA is often
used so that more data can be received while the previously-
received data is being processed. The buffers are usually
allocated as a linked-list or as a pair of buffers to be
ping/ponged. Allocating a gigantic buffer for any purpose,
including sorting databases, is simply wrong.

Data processing involves accessing data in arrays or
structures that emulate arrays of aggregate types. This
means that nearby elements are usually accessed, not elements
that are randomly scattered throughout address-space. This
locality of action is well known and is in fact why
paging is possible to provide virtual address-space.

Allocation of DMA pages by the user will fail. This is
because many of the user's pages will likely point to
the exact same page of (probably non-existant) RAM.
That's how a virtual memory system works. In fact,
allocation of virtual address space from user-mode
just tells the kernel not to seg-fault the user if
an access is made that hasn't been allocated yet.

When the access is made, a page-fault occurs and
the kernel tries to find some RAM to satisfy that access.
So, the physical addresses of any pages of allocated
RAM are not known until the pages are accessed. With
demand-zero paging, they all point to the same page
and won't change until an attempt to write to the
page occurs. After that, they may even change again.

Attempts to prevent that using mlockall() may simply
return -ENOMEM with such a large amount of virtual
address allocated. Getting the physical addresses
of user-mode virtual address RAM, involves searching
through page-tables to find out where the kernel
got a particular allocation from. This is because
every process has the exact same virtual address-space
but they share only the kernel and 'C' runtime
library address-space. All other virtual to physical
address-translations are different for different
processes.

This is why the driver must obtain the DMA pages and
the user must use mmap() to map those pages into its
address space. It's not a matter of being "easier",
it's a matter of it being the only way that will work.

Also, if Mr. Koller insists upon doing the absurd, i.e.,
allocating gigabytes of DMA RAM, he is going to have to
reserve memory that only his driver knows about, using
the "mem=" parameter on the boot command line. Then the
"extra" RAM above the kernel can be mapped using
ioremap_nocache() and made available for DMA and mmap().


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
