Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbRABRAD>; Tue, 2 Jan 2001 12:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbRABQ7x>; Tue, 2 Jan 2001 11:59:53 -0500
Received: from cd168990-a.ctjams1.mb.wave.home.com ([24.108.112.42]:2052 "EHLO
	cd168990-a.ctjams1.mb.wave.home.com") by vger.kernel.org with ESMTP
	id <S129465AbRABQ7p>; Tue, 2 Jan 2001 11:59:45 -0500
Date: Tue, 2 Jan 2001 10:29:00 -0600
From: Evan Thompson <evaner@bigfoot.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Additional info. for PCI VIA IDE crazyness.  Please read.
Message-ID: <20010102102900.A328@evaner.penguinpowered.com>
Reply-To: evaner@bigfoot.com
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010101203409.A335@evaner.penguinpowered.com> <200101020433.UAA23808@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101020433.UAA23808@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 01, 2001 at 08:33:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WOW...a mail from the guy himself, Linus Torvalds!

Beforehand, I'd like to point out that I forgot to add one little
point.  All the kernels I've used >2.2 put ide1 on IRQ 15 when I make
it do that (even the ones >-test11) because it gives me:

ide1 at 0x170-0x177,0x376 on irq 15

but it seems as though >-test11 kernels want to give me a whole bunch
of hdb: lost interrupt errors, not allowing me to boot into Linux
(unless I use some kind of floppy root...hey...there's an idea)

On Mon, Jan 01, 2001 at 08:33:53PM -0800, Linus Torvalds wrote:
> Please try a few things:
> 
>  - enabled DEBUG in arch/i386/kernel/pci-i386.h to see what the PCI irq
>    routing tables say.
> 
>  - don't pass the command line with the bogus irq
> 
>  - alternatively, pass the command line, but use "ide1=0x170,0x376,14"
>    instead (which will force it to use irq14 - the only difference from
>    no command line at all should be that it doesn't even try to probe it)

Okay.  With -test11, both of these alternatives give me the same
result.  The system boots, but I cannot access my two CD-ROM drives
(hdc and hdd) because of 'lost interrupts', with -test12, my system
refuses to bring up init because hdb (my Linux drive) keeps giving me
'lost interrupt', execpt now, -test12 gives me some more strange errors
(before I enable DEBUG):

hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x 1)

This repeats for at least 20 lines, then says the same thing for hdd.

When I enable DEBUG, I get a whole bunch of new stuff, most of which
makes any sense to me, but I'll try to give the relavent info:

PCI: BIOS32 Service Directory structure at 0xc00fdb40
PCI: BIOS32 Service Directory entry at 0xfdb50
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f85f0
00:07 slot=00 0:fe/4000 1:ff/8000 2:00/0000 3:04/deb8
00:08 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:04/deb8
00:09 slot=02 0:02/deb8 1:03/deb8 2:04/deb8 3:01/deb8
00:09 slot=03 0:03/deb8 1:04/deb8 2:01/deb8 3:02/deb8
c3:00 slot=72 0:60/0e1e 1:1f/e852 2:93/8b00 3:fa/1f5a
0a:18 slot=05 0:74/3c27 1:f0/0c73 2:e8/feb9 e:0a/74c0 
PCI: Scanning for ghost devices on bus 10
PCI: Discovered primary peer bus 0a [IRQ]
PCI: Scanning for ghost devices on bus 195
PCI: Discovered primary peer bus c3 [IRQ]
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
PCI: IRQ fixup
PCI: Allocating resources

(then it allocates resouces...a bunch of I/O ports from what I
understand...doesn't seem too important)

(then it goes on...)

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
IRQ for 00:07.1:0 -> PIRQ fe, mask 4000, excl 0000 -> newirq=14 ->
assigning IRQ
PCI: Assigned IRQ 14 for device 00:07.1

(then it goes on with the confused device errors and stops)

If I've left out something important, ask.  I've got the printout right
here, so I can type it in.
> 
>  - see what happens if VIA low-level driver support is disabled, so that
>    you end up using the non-chipset-specific code. It may be that the
>    chipset-specific code has some magic "change the irq setup" code that
>    clashes with the fact that the PCI layer has enabled the irq routing.
> 

I didn't enable low-level driver support in the first place.  Just
"Generic PCI IDE chipset support" (CONFIG_BLK_DEV_IDEPCI)

> (In particular, some of the low-level drivers have tried to do some
> things by hand, to work around the fact that the PCI layer hasn't done
> the kind of complete setup that it _does_ try to do these days.
> Sometimes that code is broken.).

Well, with the quailty of this low quailty POS m/b, I'm not surprised
if that is the case (if I had more money, I would throw this thing out
of the window, go outside in this minus 40 weather and jump on it until
it turns into a nice fine powder, then go and buy a new computer from
VA or something.  Then I'd have someone to complain to if it didn't
work. (I built my last one)).

Thanks,
-- 
| Evan Thompson                    | ICQ:    2233067   |
| Freelance Computer Nerd          | AIM:    Evaner517 |
| evaner@bigfoot.com               | Yahoo!: evanat    |
| http://evaner.penguinpowered.com | MSN:    evaner517 |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
