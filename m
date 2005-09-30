Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbVI3PrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVI3PrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVI3Pq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:46:59 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:39186 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030341AbVI3Pq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:46:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050929235025.13166.qmail@web34103.mail.mud.yahoo.com>
References: <20050929235025.13166.qmail@web34103.mail.mud.yahoo.com>
X-OriginalArrivalTime: 30 Sep 2005 15:46:51.0299 (UTC) FILETIME=[2CAAC730:01C5C5D6]
Content-class: urn:content-classes:message
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
Date: Fri, 30 Sep 2005 11:46:51 -0400
Message-ID: <Pine.LNX.4.61.0509301135040.30825@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Slow loading big kernel module in 2.6 on PPC platform
Thread-Index: AcXF1iyxuihBMN/iRD+mkudT9zLLAQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Wilson Li" <yongshenglee@yahoo.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Samuel Masham" <Samuel.Masham@jp.sony.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Sep 2005, Wilson Li wrote:

>
>
>> --- "linux-os (Dick Johnson)" <linux-os@analogic.com> wrote:
>>
>> On Wed, 28 Sep 2005, Wilson Li wrote:
>>
>> I have a module I am currently working on. It has some assembly
>> stuff linked with it, so it was easy to modify. In the assembly
>> I allocated 16 megabytes of static storage (using the .space
>> keyword),
>> first in the .data section, then in .rodata, then in .text. The
>> .text section is where code exists. In no case did the module take
>> more than 1/4 second to load. In all cases the size shown by
>> `lsmod`
>> reflected the enormous size of the module.
>>
>> Now, that's static storage. If your code uses kmalloc() and
>> friends to allocate a lot of storage when it is being loaded,
>> then that's a different story. FYI, when you see a kernel message
>> on the screen, that's not necessarily when it was "printed". It
>> gets buffered, you know. If you want to time-check when various
>> sections get control, to find out what's eating the time, then
>> put the jiffie count into your kernel messages.
>>
>> A simple macro using the __FUNCTION__ string and the jiffie
>> count can go a long way towards finding out what's happening.
>>
>> For instance, I once had a problem with continuous interrupts
>> from a device, that couldn't be cleared, until the device was
>> initialized. That slowed the system to a stand-still until
>> I found that. The fix was easy, do some initialization before
>> attaching the interrupt, at least enough to quiet the board.
>> This board had an empty FPGA, whos bits need to be loaded
>> with a bit-banger to make it work. The pin connected to an
>> interrupt was just whatever-it-was-from-the-factory, before
>> the intelligence was loaded. That system took about a minute
>> for the first kernel message to be printed. Sometimes the
>> system was very quiet <forever> and needed to be kicked.
>>
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.13 on an i686 machine (5589.55
>> BogoMips).
>> Warning : 98.36% of all statistics are fiction.
>>
>> ****************************************************************
>> The information transmitted in this message is confidential and may
>> be privileged.  Any review, retransmission, dissemination, or other
>> use of this information by persons or entities other than the
>> intended recipient is prohibited.  If you are not the intended
>> recipient, please notify Analogic Corporation immediately - by
>> replying to this message or by sending an email to
>> DeliveryErrors@analogic.com - and destroy all copies of this
>> information, including any attachments, without reading or
>> disclosing them.
>>
>> Thank you.
>
> Appreciate your advice and help. I finally tracked it down to the
> function called in init_module() in kernel/module.c.
>
> /* Allow arches to frob section contents and sizes.  */
> err = module_frob_arch_sections(hdr, sechdrs, secstrings, mod);
>
> which takes most of time (more then 99%) during module loading just
> as the reply from Semuel earlier.
>
> Wilson Li
>

Yes. Look at the code in .../arch/ppc/kernel/module.c count_relocs()
and you will see a quadratic (n ^2) example of how not to do something!

This probably could be fixed as (n * 2) order, two passes, however in
the meantime, you might want to make as many symbols as you can in
your code static. Because of the quadratic relationship, a small
change in the number of symbols will make a large change in the
load-time!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
