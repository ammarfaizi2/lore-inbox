Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVAaSob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVAaSob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVAaSob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:44:31 -0500
Received: from alog0136.analogic.com ([208.224.220.151]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261306AbVAaSoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:44:19 -0500
Date: Mon, 31 Jan 2005 13:43:53 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Mark A. Greer" <mgreer@mvista.com>
cc: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] ST M41T00 I2C RTC chip driver
In-Reply-To: <41FE7368.1000307@mvista.com>
Message-ID: <Pine.LNX.4.61.0501311325570.4988@chaos.analogic.com>
References: <41FE7368.1000307@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On ix86 machines, it is appropriate to read the RTC clock
several times in a row until nothing changes. This protects
against getting bad readings when some values wrap (like
seconds). You can't stop the clock when you read it
or you will lose time. I don't see anything like 
this in your code. Also, when setting the clock it
is necessary to stop the clock so its settings don't
change while you are writing a new time. I also don't
see anything like this in your code either.

Also ix86 machines have a spin-lock, rtc_lock, so that
other procedures, even interrupts can access its registers.
I see you using a semaphore that can't be used in interrupt
context.

Notice: the RTC clock is used for high-precision timing
via interrupt in some ix86 drivers. If you modify the
RTC code on all platforms as you propose, you cannot
"keep" the RTC all to your self. Its interrupt must
be available to drivers and access to the hardware needs
to be locked with the existing spin-lock.

I note that on 2.6.9 on somebody broke it so that, the interrupt is
used for something only ONCE during startup and ONCE during shut-down.

            CPU0
   0:    6225448    IO-APIC-edge  timer
   1:      14002    IO-APIC-edge  i8042
   8:          1    IO-APIC-edge  rtc	<--- bingo
   9:          0   IO-APIC-level  acpi
   [snipped...]

I don't have a clue why anybody would grab that interrupt. Fortunately,
the interrupt-grabbing code can be loaded as a module and then
unloaded so that other drivers can use that device and its interrupt.
Any changes to the RTC code need to consider these things.

On Mon, 31 Jan 2005, Mark A. Greer wrote:

> This patch adds support for the ST M41T00 RTC chip.
>
> You will likely notice that it implements a PPC-specific interface 
> (/dev/rtc->drivers/char/genrtc.h->include/asm-ppc/rtc.h->this file).  This 
> was necessary to support a subset of ppc platforms that need to hook up the 
> rtc support at runtime.  If I implemented /dev/rtc directly or interfaced to 
> genrtc.c directly, those platforms couldn't use this driver.  Eventually, I 
> hope to work on more uniform rtc support across all the processor 
> architectures.
>
> Also, on ppc at least, the hw clock can be set from a timer interrupt if 
> STA_UNSYNC is not set (e.g., ntpd is running).  To handle this, a tasklet is 
> used to set the clock if in_interrupt() is true.
>
> I'd appreciate an comments or to have it pushed into the kernel.org tree if 
> its acceptable.
>
> Thanks,
>
> Mark
>
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> --
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
