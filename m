Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRABFFQ>; Tue, 2 Jan 2001 00:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRABFFG>; Tue, 2 Jan 2001 00:05:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39438 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129387AbRABFEw>; Tue, 2 Jan 2001 00:04:52 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Additional info. for PCI VIA IDE crazyness.  Please read.
Date: 1 Jan 2001 20:33:52 -0800
Organization: Transmeta Corporation
Message-ID: <92rlng$n7o$1@penguin.transmeta.com>
In-Reply-To: <20010101203409.A335@evaner.penguinpowered.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010101203409.A335@evaner.penguinpowered.com>,
Evan Thompson  <evaner@bigfoot.com> wrote:
>
>-- THE PROBLEM --
>
>I know that any kernel version in the 2.2, 2.3, 2.3.99pre series and
>2.4.0-test kernels =<2.4.0-test11, I need to append
>'ide1=0x170,0x376,15' to get my (so called) PCI VIA IDE controller to
>put the secondary channel on IRQ 15 (otherwise, it'd put it on IRQ 14,
>causing hdc/hdd: lost interrupt errors and would take 5 or so minutes
>too boot).

Hmm..

The PCI irq code will parse your BIOS pirq tables, and enforce the fact
that those tables do seem to say that it's irq 14.

It obviously appears that the tables are wrong, which is kind of sad. 
Especially as a lot of machines _have_ to trust the tables in order to
get a working setup. 

What happens if you don't try to override the ide logic with the command
line? It looks like Linux has always wanted to put it on irq14, which
implies that the BIOS really set it up that way, and your irq15 thing
was always something that the driver disagreed with.

In particular, notice how even before, the IDE driver ignored the fact
that you had specified irq15. The driver was very aware of the fact that
it really had irq14 allocated:

>2.4.0-test11:
>
>Uniform Multi-Platform E-IDE driver Revision: 6.31
>ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx
>VP_IDE: IDE controller on PCI bus 00 dev 39
>VP_IDE: chipset revision 6
>VP_IDE: 100% native mode on irq 14

and it may be that what the irq=15 thing did was just hide some other
bug. 

For example, what the PCI irq routing code will do is to not just enable
irq14 (which looks like it was enabled even in test11), but it will also
mark it as being level-triggered.  It may be that the IDE driver itself
has problems with this: it used to ignore the (real) irq14 before
because you had specified irq15 by hand, and if that was an
edge-triggered irq it didn't hurt.  Now, when the PCI irq is properly
set up as a level-triggered one, ignoring the real interrupt will result
in an infinite flood of interrupts - they will _not_ go away until they
are handled (which they never will be, because you lied to it and said
it had irq 15). 

Please try a few things:

 - enabled DEBUG in arch/i386/kernel/pci-i386.h to see what the PCI irq
   routing tables say.

 - don't pass the command line with the bogus irq

 - alternatively, pass the command line, but use "ide1=0x170,0x376,14"
   instead (which will force it to use irq14 - the only difference from
   no command line at all should be that it doesn't even try to probe it)

 - see what happens if VIA low-level driver support is disabled, so that
   you end up using the non-chipset-specific code. It may be that the
   chipset-specific code has some magic "change the irq setup" code that
   clashes with the fact that the PCI layer has enabled the irq routing.

(In particular, some of the low-level drivers have tried to do some
things by hand, to work around the fact that the PCI layer hasn't done
the kind of complete setup that it _does_ try to do these days.
Sometimes that code is broken.).

Thanks,

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
