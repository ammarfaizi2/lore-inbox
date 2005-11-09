Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030631AbVKISKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030631AbVKISKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030649AbVKISKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:10:17 -0500
Received: from spirit.analogic.com ([204.178.40.4]:26886 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030631AbVKISKP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:10:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <7d40d7190511090949xc550b68k@mail.gmail.com>
References: <7d40d7190511090749j3de0e473x@mail.gmail.com> <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com> <7d40d7190511090856x24fd68f5g@mail.gmail.com> <200511091827.49144.arnd@arndb.de> <7d40d7190511090949xc550b68k@mail.gmail.com>
X-OriginalArrivalTime: 09 Nov 2005 18:10:11.0825 (UTC) FILETIME=[D380E610:01C5E558]
Content-class: urn:content-classes:message
Subject: Re: Stopping Kernel Threads at module unload time
Date: Wed, 9 Nov 2005 13:10:11 -0500
Message-ID: <Pine.LNX.4.61.0511091309470.11232@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stopping Kernel Threads at module unload time
Thread-Index: AcXlWNOIiMwXs4ZQSfyrp0gCaym3jg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Aritz Bastida" <aritzbastida@gmail.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Nov 2005, Aritz Bastida wrote:

> 2005/11/9, Arnd Bergmann <arnd@arndb.de>:
>> On Middeweken 09 November 2005 17:56, Aritz Bastida wrote:
>>> Now, if I call kthread_stop() in module unload time, does that code
>>> run in user process context just like system calls do? That is
>>> important, because if it cannot sleep, it would deadlock.
>>
>> Yes, it runs in the context of the delete_module system call.
>> I think it's more likely that you're not returning from your
>> thread loop.
>>
>> Please post a URL for your module source code so we can see
>> what goes wrong there.
>>
>>         Arnd <><
>
> Than you very much Arnd!
> You solved my problem. hehe
>
> I began to write a test module for showing you this and have just
> realized about the problem. As I create as many threads as CPUs, I
> have to delete them all when finishing.
>
> I killed them like this:
>
>        /* We don't need the distraction of CPUs appearing and vanishing. */
>        lock_cpu_hotplug();
>        for_each_online_cpu(cpu) {
>                p = per_cpu(ksensord_info, cpu);
>                kthread_stop(p);
>        }
>        unlock_cpu_hotplug();
>
> I locked the cpu hotplug lock to protect the for_each_online_cpu()
> code in case a cpu appears/vanishes, so I am actually calling
> kthread_stop() in an atomic context, so it wakes up the process, but
> dont let it run!
>
> This is quite a subtle error, but of course it's my complete fault :P
> May be a BUG_ON(in_atomic()) within kthread_stop() would let this kind of
> errors be acknowledged more easily.
>
> Thank you for your help
> Regards
>
> Aritz Bastida


Ah, yes.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
