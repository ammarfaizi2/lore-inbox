Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbUKPUmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUKPUmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKPUkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:40:52 -0500
Received: from alog0453.analogic.com ([208.224.222.229]:17280 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261783AbUKPUi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:38:27 -0500
Date: Tue, 16 Nov 2004 15:38:17 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Work around a lockup?
In-Reply-To: <Pine.LNX.4.53.0411162111440.32739@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0411161524450.1562@chaos.analogic.com>
References: <Pine.LNX.4.53.0411162038490.8374@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0411161456030.983@chaos.analogic.com>
 <Pine.LNX.4.53.0411162111440.32739@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Jan Engelhardt wrote:

>> No driver code should ever wait forever. Some module code may
>> be broken where the writter assumed that some bit must eventually
>> be set or some FIFO must eventually empty, etc. Hardware breaks.
>
> The box has locked up and I would like to know if there's a way around it.
>
>> If you need to wait a long time for something, you can execute
>> schedule_timeout(n) in your counted loop. This will give up
>> the CPU to other tasks while you are waiting. More sophisticated
>> code sleeps until interrupted, etc. Of course, the interrupt
>> may never happen so your driver needs to plan for that too.
>
> Let's *do* assume that some module's algorithm is not perfect, and further
> assume that ATM, it's in an endless loop. Moreover, editing the module's
> source is not an option.
>
> This is not a homework or something, it's real. And I do not know where it's
> hanging. Sure, SYSRQ+P would tell me where, but that could get hard to
> track if it's the Nth stack frame (seen from the inner-most) for big N.
>
> So for the moment to keep downtimes small, best option would be to have
> something to circumvent the blocker process. E.g. putting it to sleep and
> (then, finally, when I regain control) poke with the module's/kernel's source.
>
> I've generalized the case into the above-mentioned for(;;); because that's the
> worst case for uniprocessors, and I think it's best to start tackling there.
>
>
> Jan Engelhardt

If there is a continuous loop inside the kernel, something outside
the kernel (you) are never going to get control except from an
interrupt. The keyboard interrupt is going to let you see what
is happening, but you won't get any real control because the
kernel is not a task. If the kernel were a task (like VMS),
you could (maybe) context-switch out of the kernel. But,
the kernel is some common code that executes on behalf of
all the tasks in the context of "current". If the current
task is stuck inside the kernel code, it has nowhere to go.
If the current task is looping while sleeping then other tasks
can be scheduled including yours, but if it's not sleeping
(never calling the scheduler), the reboot-switch is the only
way out.

When some user task executes outside the kernel, it doesn't
have the priviliges to loop forever. A context switch will
occur and the CPU will be shared with others. However, when
that user task calls some kernel function, perhaps from
a driver interface, that function has the priviliges to
keep the CPU forever. If the driver is improperly written,
it will.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
