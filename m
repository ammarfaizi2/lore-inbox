Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275569AbTHMVI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275570AbTHMVI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:08:56 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:41981 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S275569AbTHMVIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:08:54 -0400
Date: Wed, 13 Aug 2003 23:08:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bogus serial port ttyS02
In-Reply-To: <20030813193418.D20676@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0308132305210.11378-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Russell King wrote:
> On Wed, Aug 13, 2003 at 05:40:23PM +0200, Geert Uytterhoeven wrote:
> > Linux always finds 3 serial ports instead of 2:
> > 
> > | ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > | ttyS01 at 0x02f8 (irq = 3) is a 16550A
> > | ttyS02 at 0x03e8 (irq = 4) is a 16450
> > 
> > The last one is bogus.
> 
> Do you know that it absolutely does not exist?  Can it exist on any
> PPC box?  If the answer to both those questions is no, I suggest
> you don't probe for it in the first place.

Not on my box. But since it has an ISA slot, you can add legacy serial ports.

> You could enable DEBUG_AUTOCONF in 8250.c in 2.6.0-test3 and give
> further probing information. 8)

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0: autoconf (0x03f8, 00000000): iir=3 iir1=6 iir2=6 type=16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1: autoconf (0x02f8, 00000000): iir=3 iir1=6 iir2=6 type=16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2: autoconf (0x03e8, 00000000): iir=0 type=16450
ttyS2 at I/O 0x3e8 (irq = 4) is a 16450
ttyS3: autoconf (0x02e8, 00000000): LOOP test failed (10) type=unknown

> Looking at PPC's pc_serial.h, it seems that you've told it to probe
> there using ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ.
> 
> ASYNC_SKIP_TEST means that we use a reduced test to probe for a port -
> we just check that we can read back a value written to 0x3e9.  If this
> suceeds, we decide that there is a port present, and go on to try and
> derive its type.
> 
> If you want to enable the more rigorous tests, remove ASYNC_SKIP_TEST
> from the port flags.  This will make us check that the device behaves
> like a UART before deciding that it is one.

If I remove the ASYNC_SKIP_TEST flag, I get

ttyS2: autoconf (0x03e8, 00000000): LOOP test failed (10) type=unknown

and only the 2 existing ports are detected! Thanks!

Why is the ASYNC_SKIP_TEST flag needed? Would it be safe to remove it for PPC,
or are there possible side effects?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

