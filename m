Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285345AbRLGAvJ>; Thu, 6 Dec 2001 19:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285346AbRLGAuu>; Thu, 6 Dec 2001 19:50:50 -0500
Received: from mtiwmhc25.worldnet.att.net ([204.127.131.50]:3781 "EHLO
	mtiwmhc25.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S285345AbRLGAuh>; Thu, 6 Dec 2001 19:50:37 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: John Clemens <john@deater.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 06 Dec 2001 16:41:29 -0800
Message-Id: <1007685691.6675.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-06 at 07:11, John Clemens wrote:
> You are absolutely correct :) I did the same thing a few weeks ago (when i
> was really working on it), and traced the lspci -vvxxx output and
> interpreted everything linux was saying about it.  I was looking at it
> from the acpect of maybe just changing the PCI router in config space as
> well as the PCI irq from user space without requiring kernel changes at
> all.  The reason why I didn't try that was because i chickened out and
> didn't know wether changing the PIRQ table woudl a) work or b) permanently
> screw up my machine.  This may still be the "correct way" however...

Well, the *actual* PIRQ table is supposed to be static, according to the
spec. I don't see the $PIR signature anywhere in the ROM, so it may be
generated on boot. As for changing the IRQ router PCI config space, the
last patch is doing that already - r->set is just calling pirq_ali_set,
which fiddles the bit in question.

Could you try a new patch? Works fine for me...

--- linux/arch/i386/kernel/pci-irq.c.dist	Sun Nov  4 09:31:58 2001
+++ linux/arch/i386/kernel/pci-irq.c	Thu Dec  6 15:09:54 2001
@@ -157,6 +157,13 @@
 {
 	static unsigned char irqmap[16] = { 0, 9, 3, 10, 4, 5, 7, 6, 1, 11, 0, 12, 0, 14, 0, 15 };
 
+	if ( pirq == 0x59 && 
+	irqmap[read_config_nybble(router, 0x48, pirq-1)] == 9) {
+		write_config_nybble(router, 0x48, pirq-1, 9);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
+		dev->irq = 11;
+		DBG(" GROSS HP/ALi Hack Enabled!!");
+	}
 	return irqmap[read_config_nybble(router, 0x48, pirq-1)];
 }
 
It special cases link 0x59 so we can do all our nastiness in one place
(and as a bonus, we're now completely out of the generic irq code). It's
still my gut feeling that the upper bits of 0x59 mean something special,
though. Hmmm.

> The other reason I stopped was that USB works, on IRQ 9, under windows
> (although, it does reset the bus about once every 5 minutes or so...
> highly annoying when playing games).  So maybe, just maybe, the IRQ table
> is right, and maybe its linux's acpi implementation that's not playing
> nice.

Would you consider running powertweak or a similar utlity under windows
and sending me a config space dump of the 00:02 and 00:07 (USB and IRQ
Router)? I'd bet windows just "probed" for the IRQ somehow. Maybe it's
even operating in some sort of "polling" mode. Since it works more
reliably under linux forced to IRQ 11 than windows on IRQ ?, I'd say the
way windows is doing thing is probably not correct. I'd do it myself,
but I don't have windows on my laptop (unless you count WINE, for
playing fallout :>).

WRT ACPI, I think for linux, it's more like A_PI, i.e. I don't think it
touches any config code, just PM stuff. They haven't even let PnPBIOS
stuff into the mainstream kernel yet, so I doubt ACPI will replace the
PCI configuration code anytime soon. Besides, I get the same behavior
with acpi=off, and you see weird things under windows.

> Actually, i think the BIOS might "adjust" the pIRQ table at boot to match
> it's view of the world.  I don't know.

I looked in the ROM file came with my latest BIOS update. I don't see
the $PIR signature in there anywhere, so it may be generated, but
static.

> I would really appreciate comments from someone who'se had more experience
> than us with pIRQ problems...

That makes two of us.

> I guess the question is where to we proceed from here.  Our "best option"
> may be to, at DMI scan time, recognise our laptops and change both PCI
> config space and the routing table to point to irq 11.  And then we just
> have to be brave enough to try it.  PCI config spae I don't mind mucking
> with... internal chipset registers on the ISA bridge, that scares me
> without proper documentation.  Maybe we should ask ALi for it?

Possibilities:
1) pirq_ali_get nastiness (above)
2) previous patch nastiness
3) DMI & 1
4) DMI & 2
5) ?

What do you think? Option 1 & 3 bother me a little, given that I find it
conceptually dirty to write to registers from a function intended to
read from registers. Still, is IS more separated from the generic code,
and it's all in one place.
 
WRT DMI: Would we just create an is_broken_hp_pavilion_bios variable,
similar to the is_sony_vaio_laptop variable? Declare it extern in
dmi_scan.c and declare it int pci-irq.c or the other way around? Would
it have to be a global variable?

I'm not really a C coder (I don't even play one on TV), I just code by
example...and I learn fairly quickly.

I'll call ALi USA tomorrow morning. I used their "tech support page",
but got no response. Supposedly, Darlene Brown (in the San Jose, USA)
office is the one to speak to (I spoke to a secretary today). The
secretary told me they don't generally release datasheets to
individuals, but maybe I can get ahold of one, who knows. I also emailed
Dan Hollis, who posted looking for a datasheet a while ago, but he said
he never got one.

-Cory

