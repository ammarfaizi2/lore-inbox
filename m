Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135403AbREHVGL>; Tue, 8 May 2001 17:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135404AbREHVGC>; Tue, 8 May 2001 17:06:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17537 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135403AbREHVFt>; Tue, 8 May 2001 17:05:49 -0400
Date: Tue, 8 May 2001 17:05:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <E14xENe-0000aK-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010508164343.30336A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, Alan Cox wrote:

> > I have a driver which needs to wait for some hardware.
> > Basically, it needs to have some code added to the run-queue
> > so it can get some CPU time even though it's not being called.
> 
> Wht does it have to wait ? Why cant it just poll and come back next time ?
> 

Good question. I wanted to be able to call the exact same routine(s)
that other routines (exected from read() and write()), execute.
These routines are complex and sleep while waiting for events. I
didn't want to duplicate that code with different time-out mechanisms.

GPIB is nasty because you can't do anything unless the 'controller'
tells you to do it. When "addressed to talk", you have to parse
all the stuff sent via interrupt (ATN bit set, control byte, which
address from the control byte, etc.), then let somebody sleeping
in poll() know that they can now "write()". That can all be handled
via interrupt. But, now for the receive <grin>. The user-mode code
needs to be sleeping until some data are available. That data
may never be available. Something in the driver needs to wait
until the hardware is addressed to receive. Since it is not now
receiving, there is no interrupt! It takes time for the controller
to tell you to listen and then tell somebody else to talk to you.
This means that I need some timeout to recover from the fact
that the other guy may never talk.

Once the other guy starts sending data, the interrupts can be
used to handle the data and, once there are valid data, the
device owner can be awakened, presumably sleeping in poll() or
select(). It's the intermediate time where there are no
interrupts that needs the CPU to determine that we've waited
too long for interrupts so the device had better get off the
bus to start the error recovery procedure.

Bright an early tommorrow, I will check out both ways. A kernel
thread might be "neat". However, I may just look to see if
I can just poll while using existing code.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


