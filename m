Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287202AbRL2W71>; Sat, 29 Dec 2001 17:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287223AbRL2W7S>; Sat, 29 Dec 2001 17:59:18 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:63778 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S287217AbRL2W7E> convert rfc822-to-8bit; Sat, 29 Dec 2001 17:59:04 -0500
Date: Sun, 30 Dec 2001 01:00:46 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sym53c8xx tape corruption squashed! (was: Re: SCSI Tape corruption
 - update)
In-Reply-To: <Pine.GSO.4.21.0112292224220.277-100000@vervain.sonytel.be>
Message-ID: <20011230001350.F613-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Dec 2001, Geert Uytterhoeven wrote:

> On Sat, 29 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:
> > On Sat, 29 Dec 2001, Geert Uytterhoeven wrote:
[...]
> > > I played a bit with sym-2 and setpci. Everything goes fine as long as the PCI
> > > latency timer value is smaller than 0x16 (yes, at first I thought it was
> > > decimal, but setpci parameters are in hex).
> >
> > Interesting result, even if it doesn't trigger any of my guessing
> > capabilities, for now. :-)
> >
> > Just it means that the 875 must release the PCI BUS if its GNT# signal is
> > deasserted by PCI arbiter and current transaction lasted 22 PCI cycles or
> > more since the assertion of FRAME#.
>
> Exactly my thoughts.

Note that this looks a bit less than 8 DWORDs. If your beast use such
cache line size, this can be related to.

> > If I remember correctly, the problem occurred when data is written to the
> > device. Is it ok?
>
> Yes.
>
> > If so, the MWI problem I pointed out in my previous posting is unlikely to
> > apply. But, for user data DMA write, the 875 may execute Memory Read Line
> > or Memory Read Multiple Lines transactions. It would be interesting to
> > know if it makes difference disabling those capabilities.
> >
> > Setting to zero the PCI cache line register in the PCI configuration space
> > does force the chip not to use any of the cache line based PCI
> > transactions. It is brute force but should work.
>
> Note that on my system the PCI cache line register in the PCI configuration
> space of the '875 is already set to zero.

Then, the 875 never used cache line based PCI transactions.

> > In order to disable separately those features, some IO register bits must
> > be set to zero. The faster way is to hack the driver (sym_hipd.c) at some
> > place, for example (entered by hand just for you):
>
> So I don't think it would help to test this, since PCI_CACHE_LINE_SIZE is set
> to 0?

Indeed. A least your system hasn't been bitten by PCI cache line related
bugs.

I donnot know how the 875 behaves when supplied with a zero latency timer.
Normally it should consider the timeout to happen immediately, but it must
and is allowed to perform at least one data phase. In this hypothesis, and
given that a latency timer greater than 22 PCI clocks makes problem, I may
risk the following:

Your hardware (probably the host bridge) is only able as a PCI target to
provide a limited amount of data for the current PCI read transaction in
some circumstances. It deasserts GNT#. If the master wants more data it
has to force transaction termination, otherwise it is the master that will
terminate the transaction.

Then the cause of the problem could be something like:

- The host bridge is unable to terminate a read transaction as a target
  and just feeds the master with stale data if it cannot get good ones.
  (Unlikely, but why not?)
- The host bridge just does not terminate the transaction in time in
  some circumstances and provides stale data to the master until the
  transaction terminates.

This is an example, probably just wrong.

Anyway, given that short latency timers hide (fix?) the problem, your
system seems to like much better PCI transactions to be preferently
(always?) terminated by the master.

  Gérard.

