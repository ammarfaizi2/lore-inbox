Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWJVIKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWJVIKR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWJVIKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:10:17 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:1414 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S932191AbWJVIKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:10:15 -0400
Message-ID: <453B2761.5020103@qumranet.com>
Date: Sun, 22 Oct 2006 10:10:09 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <john@stoffel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>	 <17719.35854.477605.398170@smtp.charter.net> <1161269405.17335.80.camel@localhost.localdomain> <4537C8B3.5050501@us.ibm.com> <4537CD94.2070706@qumranet.com> <4537CF3E.7060105@us.ibm.com> <45387C77.4050106@qumranet.com> <4538EC4A.1000600@us.ibm.com>
In-Reply-To: <4538EC4A.1000600@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 08:10:14.0673 (UTC) FILETIME=[80DEA810:01C6F5B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
>>>
>>> You miss my point I think.  Using ioctls *requires* a thread 
>>> per-vcpu in userspace.  This is unnecessary since you could simply 
>>> provide a char-device based read/write interface.  You could then 
>>> multiplex events and poll.
>>>
>>
>> Yes, ioctl()s require userspace threads, but that's okay, because 
>> they're free for us, since we need a kernel thread for each vcpu.
>>
>> On the other hand, a single device model thread polling the vcpus is 
>> guaranteed to be on the wrong physical cpu for half of the time 
>> (assuming 2 cpus and 2 vcpus), requiring IPIs and suspending a vcpu 
>> in order to run.
>
> And your previously proposed solution of having one big lock would do 
> the same thing except require additional round trips to the kernel :-)

No, with no contention locks stay in userspace.  And if there is 
contention, we fine-grain the locks.

>
> Moreover, you could get clever and use mmap() to expose a ring queue 
> if you're really concerned about SMP.
>
> Really though, it comes down to one simple thing: blocking ioctl()s 
> are a real ugly interface.
>

I don't think they can be termed "blocking".

Most (all?) blocking calls offload work to some other device, like a 
disk or a network card, and sleep if that device has to do any 
processing.  They follow the same basic procedure:

- if data (or bufferspace) is available, read (or write) it
- otherwise, sleep

But in this case the "other device" is the processor, so the that model 
doesn't fit very well, as it *forces* a context switch.

Moreover, we need to both read and write, which ioctls() allow, but 
read()/write() require two system calls.

>>> If for nothing else, you have to be able to run timers in userspace 
>>> and interrupt the kernel execution (to signal DMA completion for 
>>> instance).  Even in the UP case, this gets ugly quickly.
>>>
>>
>> The timers aren't pretty (we use signals), yes.  But avoiding the 
>> extra thread is critical for performance IMO.
>
> We've had a lot of problems in QEMU with timers and kqemu.  Forcing 
> the guest to return to userspace to allow periodic timers to run 
> (which may simply be the VGA refresh which the guest doesn't care 
> about) is at best a hack.

You can also have an additional thread to the periodic stuff.

>   Being able to poll an FD would make this so much nicer...
>
> I've posted some patches on qemu-devel attempting to deal with these 
> issues (look for threads on optimizing char device performance).  None 
> of them are very pretty.
>

Xen is different since you already have a context switch by going to 
domain 0.

-- 
error compiling committee.c: too many arguments to function

