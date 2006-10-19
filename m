Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946384AbWJSTJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946384AbWJSTJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946386AbWJSTJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:09:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38314 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946384AbWJSTJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:09:10 -0400
Message-ID: <4537CD54.8020006@us.ibm.com>
Date: Thu, 19 Oct 2006 14:09:08 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com> <4537C807.4@us.ibm.com> <4537CC24.2070708@qumranet.com>
In-Reply-To: <4537CC24.2070708@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>> Sorry if I missed this, but can you provide a link to the QEMU changes?
>>
>
> I'll do that once I get my sourceforge page and post it here.  Watch 
> this space.
>
>
>> It's hard to tell what's going on without seeing the userspace 
>> portions of this.
>>
>> My initial impression is that you've taken the Xen approach of trying 
>> to use QEMU only for IO emulation.  If this is the case, it won't 
>> work long term.  While you can use vm86 mode for 16 bit 
>> virtualization for most cases, it cannot handle big real mode.  You 
>> need the ability to transfer down to QEMU and allow it to do emulation.
>>
>
> We started using VT only for 64 bit, then added 32 bit, then 16-bit 
> protected, then vm86 and real mode.  We'd transfer the x86 state on 
> each mode change, but it was (a) fragile (b) considered unclean.
>
> You're right that "big real" mode is not supported, but so far that 
> hasn't been a problem.  Do you know of an OS that needs big real mode?

AFAIK the SLES boot splash patches to grub use it.  It's definitely a 
requirement.  Currently, there is an effort in Xen to use QEMU for 
partial emulation.  Hopefully, it will be there for the next release.

Allowing QEMU to do emulation also will help with IO performance.  
Instead of having to take many trips to userspace for MMIO especially, 
you can allow QEMU to execute a certain number of basic blocks and then 
return.  Minimizing trips between userspace and the kernel is going to 
be critical performance wise.

>> Ideally, instead of having as large of an x86 emulator in kernel 
>> space, you would just drop down to QEMU to do emulation as needed 
>> (doing only a single basic block and returning).  This would let you 
>> have a much reduced partial emulator in kernel space that only did 
>> the most common (and performance critical) instructions.
>>
>
> Over time that emulator would grow as OSes and compilers evolve... and 
> we'd really like to keep basic things like the apic in the kernel (as 
> does Xen).

I've been tossing around the idea of doing partial IO emulation in the 
kernel.  If you could sync the device states between userspace and 
kernel, it should be possible.  Given that the you're already in the 
kernel at VMEXIT time, if you could feed something right to the block 
driver or network driver, you ought to be able to get pretty darn good 
performance.

However, I do agree that it's better to start simple.  I actually think 
you could simplify more by using QEMU for more instruction emulation and 
focus only on the hand full of instructions in the critical path for the 
kernel.

Regards,

Anthony Liguori

