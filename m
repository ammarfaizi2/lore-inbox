Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946392AbWJSTRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946392AbWJSTRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946395AbWJSTRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:17:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42121 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946392AbWJSTRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:17:21 -0400
Message-ID: <4537CF3E.7060105@us.ibm.com>
Date: Thu, 19 Oct 2006 14:17:18 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <john@stoffel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>	 <17719.35854.477605.398170@smtp.charter.net> <1161269405.17335.80.camel@localhost.localdomain> <4537C8B3.5050501@us.ibm.com> <4537CD94.2070706@qumranet.com>
In-Reply-To: <4537CD94.2070706@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>>
>> ioctls are probably wrong here though.  Ideally, you would want to be 
>> able to support an SMP guest.  This means you need to have two 
>> virtual processors executing in kernel space.  If you use ioctls, it 
>> forces you to have two separate threads in userspace.  This would be 
>> hard for something like QEMU which is currently single threaded (and 
>> not at all thread safe).
>>
>
> Since we're using the Linux scheduler, we need a task per virtual cpu 
> anyway, so a thread per vcpu is not a problem.
>

You miss my point I think.  Using ioctls *requires* a thread per-vcpu in 
userspace.  This is unnecessary since you could simply provide a 
char-device based read/write interface.  You could then multiplex events 
and poll.

If for nothing else, you have to be able to run timers in userspace and 
interrupt the kernel execution (to signal DMA completion for instance).  
Even in the UP case, this gets ugly quickly.

read/write is really just a much cleaner interface for anything that has 
blocking semantics.

Regards,

Anthony Liguori

>> If you used a read/write interface, you could poll for any number of 
>> processors and handle IO emulation in a single userspace thread 
>> (which seems closer to how hardware really works anyway).
>>
>
> We can still do that by having the thread write an I/O request to 
> hardware service thread, and read back the response.  However that 
> will not be too good for scheduling.  For now the smp plan is to slap 
> a single lock on the qemu device model, and later fine-grain the 
> locking on individual devices as necessary.
>
> Qemu's transition to aio will probably help in reducing the amount of 
> work done under lock.
>

