Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVAaUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVAaUwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVAaUwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:52:47 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20220 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261360AbVAaUvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:51:16 -0500
Message-ID: <41FE9A3D.3050703@mvista.com>
Date: Mon, 31 Jan 2005 13:51:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] ST M41T00 I2C RTC chip driver
References: <41FE7368.1000307@mvista.com> <Pine.LNX.4.61.0501311325570.4988@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501311325570.4988@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

>
> On ix86 machines, it is appropriate to read the RTC clock
> several times in a row until nothing changes. This protects
> against getting bad readings when some values wrap (like
> seconds). You can't stop the clock when you read it
> or you will lose time. I don't see anything like this in your code. 
> Also, when setting the clock it
> is necessary to stop the clock so its settings don't
> change while you are writing a new time. I also don't
> see anything like this in your code either. 


This particular RTC chip provide no mechanism to manually stop the clock 
for reading or writing.  However, when you begin reading the clock 
registers, it delays updating the externally visible register values for 
250ms but contiues to keep time internally so time isn't lost.  I can't 
find anything in the manual WRT updating the clock.

There is a problem that if all the register reads don't happen within 
the 250ms window, it could return a bad value if a register wraps.  
Unless someone else points out why this is a bad idea, I'll add a loop 
to ensure the same values were read twice in a row.

>
>
> Also ix86 machines have a spin-lock, rtc_lock, so that
> other procedures, even interrupts can access its registers.
> I see you using a semaphore that can't be used in interrupt
> context. 


This is an I2C based RTC chip and the I2C subsystem used to access it 
assumes (AFAICT) that its not called from an interrupt handler (e.g., 
drivers/i2c/i2c-core.c:i2c_transfer calls() calls down()/up()).  So I 
need to handle an interrupt handler calling this driver which then calls 
into code that assumes its not in an interrupt handler.  That's why the 
'set' routine schedules a tasklet if its in an interrupt handler.  In 
ppc, at least, the 'get' routine isn't called from an interrupt so its 
not an issue.

>
>
> Notice: the RTC clock is used for high-precision timing
> via interrupt in some ix86 drivers. If you modify the
> RTC code on all platforms as you propose, you cannot
> "keep" the RTC all to your self. Its interrupt must
> be available to drivers and access to the hardware needs
> to be locked with the existing spin-lock. 


Hmm, interesting.  Note that this RTC doesn't generate an 
interrupt/initiate an i2c transaction.

>
>
> I note that on 2.6.9 on somebody broke it so that, the interrupt is
> used for something only ONCE during startup and ONCE during shut-down.
>
>            CPU0
>   0:    6225448    IO-APIC-edge  timer
>   1:      14002    IO-APIC-edge  i8042
>   8:          1    IO-APIC-edge  rtc    <--- bingo
>   9:          0   IO-APIC-level  acpi
>   [snipped...]
>
> I don't have a clue why anybody would grab that interrupt. Fortunately,
> the interrupt-grabbing code can be loaded as a module and then
> unloaded so that other drivers can use that device and its interrupt.
> Any changes to the RTC code need to consider these things. 


Okay, thanks for the insight.

Mark

