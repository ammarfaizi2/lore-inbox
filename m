Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRDHMH1>; Sun, 8 Apr 2001 08:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132546AbRDHMHS>; Sun, 8 Apr 2001 08:07:18 -0400
Received: from endjinn.austria.eu.net ([193.81.13.2]:39555 "EHLO
	relay2.austria.eu.net") by vger.kernel.org with ESMTP
	id <S132545AbRDHMHC>; Sun, 8 Apr 2001 08:07:02 -0400
Message-ID: <3AD05410.495A2BDC@eunet.at>
Date: Sun, 08 Apr 2001 14:05:36 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "=?iso-8859-1?Q?G=E9rard?= Roudier" <groudier@club-internet.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <Pine.LNX.4.10.10104071043360.1085-100000@linux.local> <20010407200053.B3280@redhat.com> <3ACF6D1D.63A2A2FE@mandrakesoft.com> <20010407205204.H3280@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Sat, Apr 07, 2001 at 03:40:13PM -0400, Jeff Garzik wrote:
> 
> > Who said you have to have a separate driver for every single multi-IO
> > card?  A single driver could support all serial+parallel multi-IO cards,
> > for example.
> 
> Okay, I misunderstood.  I'll take a look at doing this for 2.4.
> 
> First of all, parport_pc will need to export the equivalent of
> register_serial (its equivalent is probably parport_pc_probe_port).
> [It actually already does this (conditionally on parport_cs).]
> 
> drivers/parport/parport_serial.c sound okay, or is a different place
> better?

Heh. These multi-I/O-cards come in a lot of different fashions. Let me
explain the NetMos chips a bit:

My card shows up with lspci like that:

lizard:~ # lspci -s 00:0c -vn
00:0c.0 Class 0780: 9710:9835 (rev 01)
        Subsystem: 1000:0012
        Flags: medium devsel, IRQ 11
        I/O ports at 9400 [size=8]
        I/O ports at 9000 [size=8]
        I/O ports at 8800 [size=8]
        I/O ports at 8400 [size=8]
        I/O ports at 8000 [size=8]
        I/O ports at 7800 [size=16]

as you can see, it's class is PCI_CLASS_COMMUNICATION_OTHER

There are 8 different chips from Netmos, they differ mainly in the
number of serial and parallel ports:

9705  -/1P
9735 2S/1P
9745 2S/-
9805  -/1P
9815  -/2P
9835 2S/1P
9845 2S/-
9855  -/2P

the chip id is the same as the PCI device ID. So there are chips with
only serial or parallel ports, and chips with both of them. A chip
without a parallel port (9845) does not really belong to
parport/parport_serial.c :-) On the other hand, a chip without a serial
port should have nothing to do whith serial.c.

At the moment there is a clean solution: serial.c contains only the
device ids of cards with serial ports, the same for parport_pc.c


to summarize the discussion, there are 3 possible solution. I wanted a
simple _and_ clean solution, this seems impossible. 

The simple solution: Gunters 'multifunction quirks'
clean solution #1: a new module according to Jeffs sample code
clean solution #2: 'invisible PCI bridge' from Linus

For both clean solutions I don't know how autoloading/hotplugging would
be handled. But they look good, especially Linus' one.

The simple solution would be _very_ easy to integrate, would not break
existing configurations, and would not require any design changes.

Suggestion: multifunction quirks for 2.4, one of the clean solutions for
2.5?

bye, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
