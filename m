Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271130AbTGPVGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271126AbTGPVFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:05:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:58885 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271119AbTGPVD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:03:29 -0400
Date: Wed, 16 Jul 2003 23:18:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20 RTC Timer bug
Message-ID: <20030716211805.GB643@alpha.home.local>
References: <Pine.LNX.4.53.0307161626240.30604@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307161626240.30604@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick,

0x71 is the DATA register ! The thing that modifies what you read from it
is the RTC clock itself, because seconds are stored at index 0x00 IIRC, which
is often assumed if you read without writing.

maybe it's time to go to bed ? :-)

Cheers,
Willy

On Wed, Jul 16, 2003 at 04:31:15PM -0400, Richard B. Johnson wrote:
> 
> #if 0
> 
> In Linux 2.4.20, some rogue is incrementing the value
> in register 0x71 at about 1 second intervals!  This
> port is the index register for the CMOS timer chip
> and it must be left alone when the chip is not being
> accessed and it must be left at an unused offset,
> typically 0xff, after access. This is to prevent
> destruction of CMOS data during the power-down
> transient.
> 
> This code clearly shows that somebody is mucking with
> this chip. Here, I have reviewed the only drivers
> installed, SCSI and network, and have not found anybody
> messing with this chip so I think it must be something
> in the kernel proper. The numbers increase at 1 second
> intervals from 0 to 89 and then restart. This shows that
> it is not residual from the system clock code that will
> read only the timer registers.
> 
> These are the only modules installed...
> 
> Module                  Size  Used by
> ipchains               41400   7
> 3c59x                  28224   1  (autoclean)
> nls_cp437               4376   4  (autoclean)
> BusLogic               35768   7
> sd_mod                 10184  14
> scsi_mod               54572   2  [BusLogic sd_mod]
> 
> This running of the CMOS timer index register is the
> reason why the CMOS checksum and parameters are being
> lost on several systems that run 2.4.20. If any of
> these system are turned off when the index register
> points to checksummed data, the byte at that location
> will get smashed to whatever is on the bus when the
> power fails. To non-believers, note that the chip-select
> goes low to enable ... and that's what a power failure
> does ... goes low, while internally, the chip still has
> power from its battery.
> 
> #endif
> 
> #include <stdio.h>
> 
> __inline__ int inb()
> {
> 	register int eax = 0;
> 	__asm__ volatile ("inb	$0x71, %%al" : "=eax" (eax));
> 	return eax;
> }
> 
> extern int iopl(int);
> extern int usleep(int);
> 
> int main()
> {
>     iopl(3);
> 
>     for(;;)
>     {
>         printf("%d\n", inb());
>         usleep(100000);
>     }
> }
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
>             Note 96.3% of all statistics are fiction.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
