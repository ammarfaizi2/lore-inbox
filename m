Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTJFN5N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTJFN5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:57:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48770 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262116AbTJFN5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:57:07 -0400
Date: Mon, 6 Oct 2003 09:58:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Dave Jones <davej@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FDC motor left on
In-Reply-To: <16257.26407.439415.325123@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.53.0310060932340.8753@chaos>
References: <Pine.LNX.4.53.0310031322430.499@chaos> <20031003235801.GA5183@redhat.com>
 <Pine.LNX.4.53.0310060834180.8593@chaos> <16257.26407.439415.325123@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Mikael Pettersson wrote:

> Richard B. Johnson writes:
>  > On Sat, 4 Oct 2003, Dave Jones wrote:
>  >
>  > > On Fri, Oct 03, 2003 at 01:25:30PM -0400, Richard B. Johnson wrote:
>  > >  > In linux-2.4.22 and earlier, if there is no FDC driver installed,
>  > >  > the FDC motor may continue to run after boot if the motor was
>  > >  > started as part of the BIOS boot sequence.
>  > >  > This patch turns OFF the motor once Linux gets control.
>  > >  >
>  > >  >
>  > >  > --- linux-2.4.22/arch/i386/boot/setup.S.orig	Fri Aug  2 20:39:42 2002
>  > >  > +++ linux-2.4.22/arch/i386/boot/setup.S	Fri Oct  3 11:50:43 2003
>  > >  > @@ -59,6 +59,8 @@
>  > >
>  > > Does this mean the 'kill_motor' function in bootsect.S isn't doing
>  > > what it should be? If so, maybe that needs fixing instead of turning
>  > > it off in two places ?
>  > >
>  > > 		Dave
>  >
>  > Yes. I didn't even see that. The code there makes me kinda sick.
>  > Anyway, the kill_motor function executes "reset diskette/disk" function
>  > which will never turn OFF the drive. Instead, it will restart
>  > the motor timer because, as a condition of reseting the diskette,
>  > it must make sure the motor is running.
>  >
>  > I suggest that the FDC control byte be read, then the result be
>  > ANDed with ~0x10, then written back. The ifed-out code clears
>  > the whole control word which is inappropriate at a time the
>  > diskette channel may be still be active.
>
> Do NOT do any outbs to the FDC unless you've done the equivalent of
> the HW detection done in the floppy driver. The BIOS call in kill_motor
> is a workaround for the fact that the original raw accesses lock up
> the FDCs in some SuperIO chips (including the one in my ASUS P4T-E).
>
> The floppy driver gets it right, but it also does HW detection
> first and does the reset differently for non-ancient FDCs.
>
> /Mikael
>

The write of zero to the FDC control byte may be the reason your
machine has its FDCs locked up. I assure you that all of the
super-io FDC emulation chips expect the FDC motors to be turned
OFF or ON with the bits at FDC_BASE+Offset 2. They are:

0x01	Drive Select
0x02	Drive select
0x04	Reset controller (always reads 0)
0x08	DMA enable
0x10	Drive 0 motor on
0x20	Drive 1 motor on
0x40	Drive 2 motor on
0x80	Drive 3 motor on

>From this, you can see that if this byte is written to zero,
then DMA is disabled. An attempt later on to access this
drive will result in a DMA operation that doesn't complete.

Any hardware detection of which you speak, is not required.
If you can end up with another floppy drive motor on under
any condition when the kernel is given control, then you
can simply reset both (or all) floppy motor control bits.

Any attempt to be cute and reset only the one that is
associated with the current drive-select bits will fail
because all the motor control bits can be on from a
previous access.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


