Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269476AbRHGVwV>; Tue, 7 Aug 2001 17:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269473AbRHGVwL>; Tue, 7 Aug 2001 17:52:11 -0400
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:41466 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S269476AbRHGVwE>;
	Tue, 7 Aug 2001 17:52:04 -0400
Date: Tue, 7 Aug 2001 17:53:17 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Ben Greear <greearb@candelatech.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        "eepro100@scyld.com" <eepro100@scyld.com>
Subject: Re: [eepro100] Problem with Linux 2.4.7 and builtin eepro on Intel's
 EEA2 motherboard.
In-Reply-To: <3B704BBE.A3AA1C99@candelatech.com>
Message-ID: <Pine.LNX.4.10.10108071740170.976-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Ben Greear wrote:

> Subject: [eepro100] Problem with Linux 2.4.7 and builtin eepro on Intel's
    EEA2 motherboard.
> 
> The driver seems to lock up for a while and then recover...

Presumably this is the driver in the 2.4.7 kernel, not the Scyld driver.

> Aug  7 11:56:07 lanf1 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Aug  7 11:56:07 lanf1 kernel: eth0: Transmit timed out: status 0050  0cf0 at 900/928 command 000c0000.
> Aug  7 11:58:53 lanf1 kernel: eepro100: wait_for_cmd_done timeout!

Hmmm, the chip didn't reset.


> [root@lanf1 bin]# eepro100-diag eth0 -aa -ee -mm -f
> eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
>  http://www.scyld.com/diag/index.html
> Index #1: Found a Intel i82562 EEPro100 adapter at 0xdf00.
> i82557 chip registers at 0xdf00:
>   0c000090 0f1123e0 00000000 00080002 18250021 00000600
>   No interrupt sources are pending.
>    The transmit unit state is 'Active'.

..and the transmit unit is still trying to do something (transmit?).

>    The receive unit state is 'Ready'.
>   This status is unusual for an activated interface.
>  The Command register has an unprocessed command 0c00(?!).

This is a little misleading.  The driver you are using is trying to mask
the early receive interrupt, but the proper approach is to configure the
chip to not generate the event, rather than mask the interrupt.

...
>  MII PHY #1 transceiver registers:
>   3100 782d 02a8 0330 05e1 0021 0000 0000
>   0000 0000 0000 0000 0000 0000 0000 0000
>   2404 0000 0000 0000 0000 0000 0000 0000
>   0000 0000 0000 0000 0010 0000 0000 0000.
>   Baseline value of MII status register is 782d.
> 
> NOTE:  The eepro100-diag program hangs here, and will not
> continue after at least 2 minutes.  Ctrl-c does stop it
> though...

It hasn't hung.  It's doing what it's documented to do -- polling the
MII register for state transititions.  Pull the network cable and you'll
see timestamped events as the link is lost and autonegotiation occurs.

> Interestingly enough, a minute after I did this, the whole
> machine locked up hard :(

That shouldn't happen -- polling the MII register should be safe.  This
might be due to the underlying problem that cause the eepro100 driver to
stop working.


Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

