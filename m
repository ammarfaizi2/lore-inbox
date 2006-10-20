Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946374AbWJTPdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946374AbWJTPdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946379AbWJTPdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:33:35 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39066 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946374AbWJTPdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:33:33 -0400
Message-ID: <4538EC4A.1000600@us.ibm.com>
Date: Fri, 20 Oct 2006 10:33:30 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <john@stoffel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>	 <17719.35854.477605.398170@smtp.charter.net> <1161269405.17335.80.camel@localhost.localdomain> <4537C8B3.5050501@us.ibm.com> <4537CD94.2070706@qumranet.com> <4537CF3E.7060105@us.ibm.com> <45387C77.4050106@qumranet.com>
In-Reply-To: <45387C77.4050106@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>> Avi Kivity wrote:
>>> Anthony Liguori wrote:
>>>>
>>>> ioctls are probably wrong here though.  Ideally, you would want to 
>>>> be able to support an SMP guest.  This means you need to have two 
>>>> virtual processors executing in kernel space.  If you use ioctls, 
>>>> it forces you to have two separate threads in userspace.  This 
>>>> would be hard for something like QEMU which is currently single 
>>>> threaded (and not at all thread safe).
>>>>
>>>
>>> Since we're using the Linux scheduler, we need a task per virtual 
>>> cpu anyway, so a thread per vcpu is not a problem.
>>>
>>
>> You miss my point I think.  Using ioctls *requires* a thread per-vcpu 
>> in userspace.  This is unnecessary since you could simply provide a 
>> char-device based read/write interface.  You could then multiplex 
>> events and poll.
>>
>
> Yes, ioctl()s require userspace threads, but that's okay, because 
> they're free for us, since we need a kernel thread for each vcpu.
>
> On the other hand, a single device model thread polling the vcpus is 
> guaranteed to be on the wrong physical cpu for half of the time 
> (assuming 2 cpus and 2 vcpus), requiring IPIs and suspending a vcpu in 
> order to run.

And your previously proposed solution of having one big lock would do 
the same thing except require additional round trips to the kernel :-)

Moreover, you could get clever and use mmap() to expose a ring queue if 
you're really concerned about SMP.

Really though, it comes down to one simple thing: blocking ioctl()s are 
a real ugly interface.

>> If for nothing else, you have to be able to run timers in userspace 
>> and interrupt the kernel execution (to signal DMA completion for 
>> instance).  Even in the UP case, this gets ugly quickly.
>>
>
> The timers aren't pretty (we use signals), yes.  But avoiding the 
> extra thread is critical for performance IMO.

We've had a lot of problems in QEMU with timers and kqemu.  Forcing the 
guest to return to userspace to allow periodic timers to run (which may 
simply be the VGA refresh which the guest doesn't care about) is at best 
a hack.  Being able to poll an FD would make this so much nicer...

I've posted some patches on qemu-devel attempting to deal with these 
issues (look for threads on optimizing char device performance).  None 
of them are very pretty.

Regards,

Anthony Liguori

>> read/write is really just a much cleaner interface for anything that 
>> has blocking semantics.
>>
>
> Ah, but scheduling a vcpu doesn't just block, it consumes the physical 
> cpu.
>
> All other uses of read() yield the cpu apart from setup and copying of 
> the data.
>
>

