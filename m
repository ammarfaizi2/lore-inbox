Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSKATs3>; Fri, 1 Nov 2002 14:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265740AbSKATs3>; Fri, 1 Nov 2002 14:48:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:31104 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265711AbSKATs1>; Fri, 1 Nov 2002 14:48:27 -0500
Date: Fri, 1 Nov 2002 14:56:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ken Ryan <newsryan@leesburg-geeks.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5] October 30, 2002
In-Reply-To: <Pine.LNX.4.21.0211011405370.2728-100000@meetpoint.home>
Message-ID: <Pine.LNX.3.95.1021101145008.2251A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Ken Ryan wrote:

> 
> >Given that, "scrubbing" RAM seems to be somewhat useless on a
> >running system. The next write to the affected area will fix the
> >ECC bits, that't what is supposed to clear up the condition. 
> 
> If a region of RAM isn't written to it won't help, and may accumulate
> additional errors.  Kernel code, for instance, can then rot
> away.  Scrubbing guarantees that all locations in memory get rewritten
> periodically, so correctable errors are removed.
> 
> I first saw this when I was brought in to help on a design for a
> spacecraft.  Even rad-hard devices (these weren't) will flip a bit in a
> matter of hours due to background radiation.  Non-hardened memories can
> get errors within minutes.  Scrubbing assured the system would only notice
> once every few years (when too many bits get flipped in a word during the
> scrub interval).
> 
> 		Ken Ryan
> 

Hang with me a second. This gets complicated and is
not anything that naive "scrubbing" can fix on a
desktop machine.

With a conventional ix86 machine, you have uncorrectable
errors reported via NMI. Some specialized machines have
correctable errors reported by maskable interrupt. For
instance, the AMD SC520's SDRAM memory controller can
set a bit upon a correctable error and this can be mapped
to a maskable interrupt but you still have little information
about what caused the interrupt. Upon either interrupt,
the return address points to code to be continued. Nothing
points to the address of the memory causing an error.
Now, internal to the SDRAM controller, there are registers
that can be used to identify the "bank" that caused the
problem. It would require the kernel to completely understand
the memory configuration in order to isolate this to an
address. Further, to read the SDRAM controller, requires that
refresh be turned OFF, etc. Not a good thing to do on a
live system.

But, in principle, one could read all the pages addressable
from each of the segments, CS, SS, DS, ES, FS, GS, and try to
do what? Make another error, causing a double-fault?
I think not. That is the problem with handling ECC errors.
That's also the reason why VAX/VMS would map out any RAM that
caused such an error, by killing off the process and making
all the RAM accessible to the process (without a page-fault),
"owned" by a non-existent process called "Bad Pages". There
wasn't really anything else you could do. If the RAM was
owned by the kernel, you got a "Fatal machine-check" and
that's all she wrote.

Now, given this, if you read all the RAM in the machine at, say
ten-second intervals, do you think you would fix anything? What
would happen is the memory locations that got corrupt would be
read and you would have a fatal ECC error. Most of these memory
locations would have never even been accessed, and therefore
the fatal error would have never happened if you didn't force
the fatality by reading bad locations. If you turned OFF ECC
when you read all the memory, you just made good ECC check-bits
out of bad ones. The data is corrupt and will never be reported.

So, ten seconds after you have some cosmic-ray upset, you guarantee
that your machine will crash if you read everything every ten
seconds. This will never be acceptable. You need to leave the
machine alone and not try to "pick scabs". That's how you get
the best reliability. Also, at some periodic intervals, you
re-boot (restart) the whole machine, reinitializing everything
including all the RAM.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


