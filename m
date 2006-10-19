Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946398AbWJST0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946398AbWJST0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946399AbWJST0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:26:50 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:55904 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1946398AbWJST0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:26:49 -0400
Message-ID: <4537D174.8090204@qumranet.com>
Date: Thu, 19 Oct 2006 21:26:44 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com> <4537C807.4@us.ibm.com> <4537CC24.2070708@qumranet.com> <4537CD54.8020006@us.ibm.com>
In-Reply-To: <4537CD54.8020006@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 19:26:48.0583 (UTC) FILETIME=[857C8170:01C6F3B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
>>
>> We started using VT only for 64 bit, then added 32 bit, then 16-bit 
>> protected, then vm86 and real mode.  We'd transfer the x86 state on 
>> each mode change, but it was (a) fragile (b) considered unclean.
>>
>> You're right that "big real" mode is not supported, but so far that 
>> hasn't been a problem.  Do you know of an OS that needs big real mode?
>
> AFAIK the SLES boot splash patches to grub use it.  It's definitely a 
> requirement.  Currently, there is an effort in Xen to use QEMU for 
> partial emulation.  Hopefully, it will be there for the next release.
>

Ouch.  Boot splash patches.

Well, we had real mode in qemu once, we can put it there again.

> Allowing QEMU to do emulation also will help with IO performance.  
> Instead of having to take many trips to userspace for MMIO especially, 
> you can allow QEMU to execute a certain number of basic blocks and 
> then return.  Minimizing trips between userspace and the kernel is 
> going to be critical performance wise.
>

My plan was to allow userspace to register certain mmio addresses for 
cacheing, so that if the guest code had a code sequence like

  writel(dst_x_reg, x);
  writel(dst_y_reg, y)
  writel(width_reg, w);
  writel(height_reg, h);
  writel(blt_cmd_reg, fill);

then kvm would cache the first four in a mmap()able memory area and only 
exit to userspace on the fifth.  Userspace would then read the cached 
registers from memory and emulate the command.

This saves userspace transitions but not guest/host switches.  I'm 
counting on Intel and AMD to reduce the cost of these, but it will 
probably never be cheap.

Paravirtualized drivers are also an option; we may try to keep 
compatibility with Xen's.


>
> I've been tossing around the idea of doing partial IO emulation in the 
> kernel.  If you could sync the device states between userspace and 
> kernel, it should be possible.  Given that the you're already in the 
> kernel at VMEXIT time, if you could feed something right to the block 
> driver or network driver, you ought to be able to get pretty darn good 
> performance.
>

Do you mean putting the device model into the kernel?


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

