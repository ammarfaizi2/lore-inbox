Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVI2NE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVI2NE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 09:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVI2NE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 09:04:26 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:780 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751109AbVI2NE0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 09:04:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050928222738.95364.qmail@web34110.mail.mud.yahoo.com>
References: <20050928222738.95364.qmail@web34110.mail.mud.yahoo.com>
X-OriginalArrivalTime: 29 Sep 2005 13:04:21.0949 (UTC) FILETIME=[4F3046D0:01C5C4F6]
Content-class: urn:content-classes:message
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
Date: Thu, 29 Sep 2005 09:04:21 -0400
Message-ID: <Pine.LNX.4.61.0509290837500.22964@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Slow loading big kernel module in 2.6 on PPC platform
Thread-Index: AcXE9k83GeWESErpQjOTyUzxq87wLg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Wilson Li" <yongshenglee@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Sep 2005, Wilson Li wrote:

>
>
> --- "linux-os (Dick Johnson)" <linux-os@analogic.com> wrote:
>
>>
>> On Wed, 28 Sep 2005, Wilson Li wrote:
>>
>>> Hi,
>>>
>>> I am trying to port several third party kernel modules from
>> kernel
>>> 2.4 to 2.6 on a ppc (MPC824x) platform. For small size of
>> modules, it
>>> works perfectly in 2.6. But there's one huge kernel module which
>> size
>>> is about 2.7M bytes (size reported by lsmod after insmod), and it
>>> takes about 90 seconds to load this module before init_module
>> starts.
>>> I did not notice there's such obvious delay in 2.4 kernel.
>>>
>>
>> I don't think it's a problem with the size. Here is the
>> `lspci` output after I hacked a Rtc module to use 16 megabytes
>> of data space. It took about 1/4 second to load (`time insmod
>> Rtc.ko`).
>>
>> Module                  Size  Used by
>> Rtc                 16783748  0
>> floppy                 58964  0
>> loop                   18440  0
>> parport_pc             28740  1
>> lp                     14472  0
>> parport                37320  2 parport_pc,lp
>>
>> [SNIPPED...]
>>
>>
>>> Initially I suspected there might be a problem of the insmod of
>>> busybox I was using. I switched to module-init-tools-3.1 insmod.
>> It
>>> didn't help. I also tried other things like disabling
>> CONFIG_KALLSYMS
>>> and commenting out all the EXPORT_SYMBOLs in that module. Nothing
>>> works so far. I've not been able to find any relevant thread
>> about
>>> slow loading of big kernel module on PPC platform.
>>>
>>
>> The PPC might be a bit slower, but not as slow as you are
>> seeing. I suspect that you have something that is 'waiting'
>> for initialization.
>
> For debugging, my module init function will print a message first
> when it gets called. After insmod the module, the console hangs about
> 90 seconds for loading then my init function gets called and message
> prints. I even commented out all the initialization code, it still
> does not help. Anything else I am missing?
>
> Thanks,
> Wilson Li

I have a module I am currently working on. It has some assembly
stuff linked with it, so it was easy to modify. In the assembly
I allocated 16 megabytes of static storage (using the .space keyword),
first in the .data section, then in .rodata, then in .text. The
.text section is where code exists. In no case did the module take
more than 1/4 second to load. In all cases the size shown by `lsmod`
reflected the enormous size of the module.

Now, that's static storage. If your code uses kmalloc() and
friends to allocate a lot of storage when it is being loaded,
then that's a different story. FYI, when you see a kernel message
on the screen, that's not necessarily when it was "printed". It
gets buffered, you know. If you want to time-check when various
sections get control, to find out what's eating the time, then
put the jiffie count into your kernel messages.

A simple macro using the __FUNCTION__ string and the jiffie
count can go a long way towards finding out what's happening.

For instance, I once had a problem with continuous interrupts
from a device, that couldn't be cleared, until the device was
initialized. That slowed the system to a stand-still until
I found that. The fix was easy, do some initialization before
attaching the interrupt, at least enough to quiet the board.
This board had an empty FPGA, whos bits need to be loaded
with a bit-banger to make it work. The pin connected to an
interrupt was just whatever-it-was-from-the-factory, before
the intelligence was loaded. That system took about a minute
for the first kernel message to be printed. Sometimes the
system was very quiet <forever> and needed to be kicked.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
