Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbTACQGn>; Fri, 3 Jan 2003 11:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbTACQGn>; Fri, 3 Jan 2003 11:06:43 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:40346 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267562AbTACQG2>;
	Fri, 3 Jan 2003 11:06:28 -0500
Date: Fri, 3 Jan 2003 17:14:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Teodor Iacob <Teodor.Iacob@astral.kappa.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
Message-ID: <20030103171433.A4502@ucw.cz>
References: <20030102182932.GA27340@linux.kappa.ro> <1041536269.24901.47.camel@irongate.swansea.linux.org.uk> <3E14B698.8030107@inet6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E14B698.8030107@inet6.fr>; from Lionel.Bouton@inet6.fr on Thu, Jan 02, 2003 at 11:00:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 11:00:56PM +0100, Lionel Bouton wrote:
> Happy new year everybody
> 
> 
> Alan Cox wrote:
> 
> >It got CRC errors, not suprisingly and will drop back. Nevertheless it
> >shouldnt have gotten this wrong, so more info would be good.
> >  
> >
> 
> I'm wondering some things about IDE 40/80 pin cables since some time ago :
> - somehow the circuitry can make the difference between 40 and 80 pin 
> (probably some pins are shorted or not by the cables or some 
> cable-type-dependent impedance between wires is mesured) and set a bit 
> for us to use.

Yes. There are two types of this circuitry:

1) Just-a-capacitor-on-mainboard. When the pin in question (CBLID) is
connected to ground via a capacitor on the mainboard, the attached
devices can detect the cable and the IDE driver can ask them.

2) GPIO pin on mainboard. One of the chipset's GPIO pins gets wired to
CBLID and then the chipset can see what cable is installed.
Unfortunately, the wiring is mainboard (not chipset) dependent, and thus
only the BIOS can know.

Anyway, mixing various types of devices and mainboards there are always
cases where you get incorrect results. For some reason the ATA people
couldn't get this ever right.

The second method is safer, and mostly works for chipsets where there is
a 'cable detect scratch register', where the BIOS writes the 80/40 pin
cable information. Modern chipsets (Intel, AMD) implement this. VIA
doesn't. There is no way for a driver to read the cable type on a VIA
mainboard - it can ask the drives (but they can lie if they're mixed
with older devices, and if there is no cap on the mainboard), and it can
guess from the settings the BIOS used to program the UDMA speeds.

Currently it does the later, because it works in 99% of cases - the BIOS
will only set the chipset to UDMA66+ if it sees the cable on the right
GPIO pins.

> - most probably the same circuitry can't verify the length of the cables 
> or their overall quality but I'm unsure.

It can not. Very modern drives and chipsets can adapt the termination
and various aspects of signalling, but cannot measure whether the cable
is suitable for a certain speed or not. The only way to really know is
to try to do a transfer. Or two. Or a thousand.

> #1 How is the 40/80 pin detection done at the hardware level ?

See above. Also see the ATA specs, it's there.

> #2 Are there any other cable-quality hardware tests done by the chipsets 
> ? How ?

Not really.

> I've encountered a barebone design (Mocha P4, uses 2.5" drives) where 
> the IDE cable was 40-pin but :
> - has a single drive connector instead of the common two,
> - its length is only around 10 or 15 cm.
> A buyer contacted me for SiS IDE driver directions on this platform and 
> confirmed this at least for his purchase.
> 
> #3 Is the above cable electrically able to sustain 66+ UDMA transfers 
> (could I hack a driver in order to bypass the 80pin cable detection and 
> make it work properly) ?

If you use ide0=ata66, the cable should be forced to 80pin. Also, it can
work if the cable is short and there is only one drive. Make sure it's
not bent too much, too.

> #4 Are the electrical specs for 66+ UDMA transfers public (couldn't find 
> by googling) ? Where can we find them ?
> Here I mean some really basic specs (max Resistance/Capacity/Inductance 
> between wires, max signal propagation delays and so on) and not general 
> high level specs (material, connector design, length ranges allowed in 
> the general 80-pin, 2 drives case).

Mostly. See the ATA spec.

> Any hints on these Andre ?

-- 
Vojtech Pavlik
SuSE Labs
