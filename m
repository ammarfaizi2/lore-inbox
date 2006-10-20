Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992567AbWJTHga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992567AbWJTHga (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992566AbWJTHg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:36:29 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:51413 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S2992567AbWJTHg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:36:28 -0400
Message-ID: <45387C77.4050106@qumranet.com>
Date: Fri, 20 Oct 2006 09:36:23 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <john@stoffel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>	 <17719.35854.477605.398170@smtp.charter.net> <1161269405.17335.80.camel@localhost.localdomain> <4537C8B3.5050501@us.ibm.com> <4537CD94.2070706@qumranet.com> <4537CF3E.7060105@us.ibm.com>
In-Reply-To: <4537CF3E.7060105@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2006 07:36:28.0180 (UTC) FILETIME=[7428DD40:01C6F41A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
> Avi Kivity wrote:
>> Anthony Liguori wrote:
>>>
>>> ioctls are probably wrong here though.  Ideally, you would want to 
>>> be able to support an SMP guest.  This means you need to have two 
>>> virtual processors executing in kernel space.  If you use ioctls, it 
>>> forces you to have two separate threads in userspace.  This would be 
>>> hard for something like QEMU which is currently single threaded (and 
>>> not at all thread safe).
>>>
>>
>> Since we're using the Linux scheduler, we need a task per virtual cpu 
>> anyway, so a thread per vcpu is not a problem.
>>
>
> You miss my point I think.  Using ioctls *requires* a thread per-vcpu 
> in userspace.  This is unnecessary since you could simply provide a 
> char-device based read/write interface.  You could then multiplex 
> events and poll.
>

Yes, ioctl()s require userspace threads, but that's okay, because 
they're free for us, since we need a kernel thread for each vcpu.

On the other hand, a single device model thread polling the vcpus is 
guaranteed to be on the wrong physical cpu for half of the time 
(assuming 2 cpus and 2 vcpus), requiring IPIs and suspending a vcpu in 
order to run.

> If for nothing else, you have to be able to run timers in userspace 
> and interrupt the kernel execution (to signal DMA completion for 
> instance).  Even in the UP case, this gets ugly quickly.
>

The timers aren't pretty (we use signals), yes.  But avoiding the extra 
thread is critical for performance IMO.

> read/write is really just a much cleaner interface for anything that 
> has blocking semantics.
>

Ah, but scheduling a vcpu doesn't just block, it consumes the physical cpu.

All other uses of read() yield the cpu apart from setup and copying of 
the data.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

