Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUKPUNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUKPUNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUKPUMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:12:01 -0500
Received: from alog0040.analogic.com ([208.224.220.55]:16512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261792AbUKPUJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:09:43 -0500
Date: Tue, 16 Nov 2004 15:09:30 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Work around a lockup?
In-Reply-To: <Pine.LNX.4.53.0411162038490.8374@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0411161456030.983@chaos.analogic.com>
References: <Pine.LNX.4.53.0411162038490.8374@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Jan Engelhardt wrote:

> Hello,
>
>
> I am currently looking into an issue where a host sporadically locks up. I will
> retrieve the SYSRQ+P tomorrow when I am back at the machine.
> Until then, here's the real question:
>
> Given that some kernel code (possibly a module) runs in an infinite loop, and
> thus not giving back control to the user (in an UP environment), is there a
> possibility to force a schedule?
> Something like the normal scheduler does to processes ("you got your timeslice,
> and not more"), but also when they are in kernel mode.
>
>
>
> Jan Engelhardt
> --

No driver code should ever wait forever. Some module code may
be broken where the writter assumed that some bit must eventually
be set or some FIFO must eventually empty, etc. Hardware breaks.

Every loop in kernel code, not just in drivers, needs some way
"out" if things don't go according to plan. To do that, you
have a course timer called "jiffies" and you have finer granularity
from counted-spin-loops. Never assume anything. DMA may never
complete, UART data-ready bits may never be true, SNICS (Network)
controllers may never be able to receive data, etc. Always have
a way to nicely fail a hardware interface request.

If you need to wait a long time for something, you can execute
schedule_timeout(n) in your counted loop. This will give up
the CPU to other tasks while you are waiting. More sophisticated
code sleeps until interrupted, etc. Of course, the interrupt
may never happen so your driver needs to plan for that too.

There are numerous examples of kernel driver code where
the CPU schedules while the code waits for some event. But,
beware, that some procedures are being removed and some
methods are broken by design. Copy the code in newer drivers.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
