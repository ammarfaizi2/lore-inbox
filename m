Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318935AbSICVm1>; Tue, 3 Sep 2002 17:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318937AbSICVm1>; Tue, 3 Sep 2002 17:42:27 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:59028 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S318935AbSICVm0>;
	Tue, 3 Sep 2002 17:42:26 -0400
Message-ID: <3D752DA3.6030000@colorfullife.com>
Date: Tue, 03 Sep 2002 23:46:11 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Terence Ripperda <TRipperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: lockup on Athlon systems, kernel race condition?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Terence Ripperda wrote:
>> 
>> ...
>>
>> asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
>> {
>>         struct file * filp;
>>         unsigned int flag;
>>         int on, error = -EBADF;
>> 
>>         filp = fget(fd);
>>         if (!filp)
>>                 goto out;
>>         error = 0;
>>         lock_kernel();    <====
Which compiler to you use, and which kernel? Which additional patches?

With my 2.4.20-pre4-ac1 kernel, the lock_kernel is at offset +3a, 
according to your dump it's at +6a.

>>         switch (cmd) {
> 
> This CPU is spinning, waiting for kernel_flag.  It will take the IPI
> and the other CPU's smp_call_function() will succeed.
> 
> Possibly the IPI has got lost - seems that this is a popular failure mode
> for flakey chipsets/motherboards.
> 
> Or someone has called sys_ioctl() with interrupts disabled.  That's very
> doubtful.

Is it possible to display the cpu registers with kdb? Could you check 
that the interrupts are enabled?

I'd add a quick test into sys_ioctl() or lock_kernel: save_flags, and 
check that bit 9 is always enabled. Check __global_cli for sample code.
The X server probably runs with enough priveledges to disable the 
interrupts, perhaps it's doing something stupid.

--
	Manfred


