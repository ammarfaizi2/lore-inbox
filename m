Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271429AbTGQLJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271430AbTGQLJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:09:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18567 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271429AbTGQLJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:09:26 -0400
Date: Thu, 17 Jul 2003 07:25:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Willy Tarreau <willy@w.ods.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20 RTC Timer bug
In-Reply-To: <20030716211805.GB643@alpha.home.local>
Message-ID: <Pine.LNX.4.53.0307170709080.682@chaos>
References: <Pine.LNX.4.53.0307161626240.30604@chaos> <20030716211805.GB643@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003, Willy Tarreau wrote:

> Dick,
>
> 0x71 is the DATA register ! The thing that modifies what you read from it
> is the RTC clock itself, because seconds are stored at index 0x00 IIRC, which
> is often assumed if you read without writing.
>
> maybe it's time to go to bed ? :-)
>
> Cheers,
> Willy

It's so easy to kill the messenger instead of finding the problem.
Most modern RTC emulations will return 0xff when you read the index
register at 0x70 because it's a write-only register. Therefore, to
discover what it has been set to, one must read the data register at
0x71. If it increments at one second intervals from 0 to 59 (BCD) ,
(you change the "%d" to "%x" to read BCD within that range), then
the index register has left at 0. This is okay except that the
time may get trashed upon power off.

In machines tested here, running linux-2.4.20, the value read from
0x71 increments from 0 to 99 with a few missing codes in-between so
it's not possible to guess what it's been set to, maybe the
'B' register (status), then something else. That something else
is the killer.

When the power fails, most all systems running Linux will fail to
restart because of CMOS corruption. You can easily check. Run linux,
`init 1`, dismount drives, then pull the plug. Don't use the
front panel power switch because, again, modern power supplies
protect devices during 'normal' shutdown by using the reset
circuitry.


If you use the same motherboard, but leave it is CMOS setup so
Linux isn't running, you can pull the plug and never cause
corruption.


>
> On Wed, Jul 16, 2003 at 04:31:15PM -0400, Richard B. Johnson wrote:
> >
> > #if 0
> >
> > In Linux 2.4.20, some rogue is incrementing the value
> > in register 0x71 at about 1 second intervals!  This
> > port is the index register for the CMOS timer chip
> > and it must be left alone when the chip is not being
> > accessed and it must be left at an unused offset,
> > typically 0xff, after access. This is to prevent
> > destruction of CMOS data during the power-down
> > transient.
> >
> > This code clearly shows that somebody is mucking with
> > this chip. Here, I have reviewed the only drivers
> > installed, SCSI and network, and have not found anybody
> > messing with this chip so I think it must be something
> > in the kernel proper. The numbers increase at 1 second
> > intervals from 0 to 89 and then restart. This shows that
> > it is not residual from the system clock code that will
> > read only the timer registers.
> >
> > These are the only modules installed...
> >
> > Module                  Size  Used by
> > ipchains               41400   7
> > 3c59x                  28224   1  (autoclean)
> > nls_cp437               4376   4  (autoclean)
> > BusLogic               35768   7
> > sd_mod                 10184  14
> > scsi_mod               54572   2  [BusLogic sd_mod]
> >
> > This running of the CMOS timer index register is the
> > reason why the CMOS checksum and parameters are being
> > lost on several systems that run 2.4.20. If any of
> > these system are turned off when the index register
> > points to checksummed data, the byte at that location
> > will get smashed to whatever is on the bus when the
> > power fails. To non-believers, note that the chip-select
> > goes low to enable ... and that's what a power failure
> > does ... goes low, while internally, the chip still has
> > power from its battery.
> >
> > #endif
> >
> > #include <stdio.h>
> >
> > __inline__ int inb()
> > {
> > 	register int eax = 0;
> > 	__asm__ volatile ("inb	$0x71, %%al" : "=eax" (eax));
> > 	return eax;
> > }
> >
> > extern int iopl(int);
> > extern int usleep(int);
> >
> > int main()
> > {
> >     iopl(3);
> >
> >     for(;;)
> >     {
> >         printf("%d\n", inb());
> >         usleep(100000);
> >     }
> > }
> >
> >
> > Cheers,
> > Dick Johnson
> > Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
> >             Note 96.3% of all statistics are fiction.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.
