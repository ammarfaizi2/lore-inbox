Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282042AbRLKRSx>; Tue, 11 Dec 2001 12:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281926AbRLKRSm>; Tue, 11 Dec 2001 12:18:42 -0500
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:19195 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S281923AbRLKRSc>; Tue, 11 Dec 2001 12:18:32 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: Pavel Machek <pavel@suse.cz>
Cc: John Clemens <john@deater.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011211163641.A25464@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy>
	<1007685691.6675.1.camel@localhost.localdomain>
	<20011207213313.A176@elf.ucw.cz>
	<1007876254.17062.0.camel@localhost.localdomain>
	<20011211111458.A15007@atrey.karlin.mff.cuni.cz>
	<1008083964.17062.30.camel@localhost.localdomain> 
	<20011211163641.A25464@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Dec 2001 09:08:58 -0800
Message-Id: <1008090540.2923.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-11 at 07:36, Pavel Machek wrote:
> Hi!
> 
> > > The patch should contain:
> > > 
> > > 
> > > > The "honor the irq mask" approach (works on my machine):
> > > > --- /home/cbell/linux-2.4/arch/i386/kernel/pci-irq.c	Fri Dec  7 01:51:41 2001
> > > > +++ /home/cbell/linux-2.4-test/arch/i386/kernel/pci-irq.c	Sat Dec  8 21:04:37 2001
> > > > @@ -581,6 +581,7 @@
> > > >  	 * reported by the device if possible.
> > > >  	 */
> > > >  	newirq = dev->irq;
> > > > +	if (!((1 << newirq) & mask)) newirq = 0;
> > > 	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > printk(KERN_ERR "$PIR table inconsistent; chipset dependend code told
> > > us interrupt is at %d, but irq mask is %lx\n", dev->irq, newirq);
> > >   
> > > We should never ever workaround BIOS problem without complaining.
> > 
> > It may not be a bios problem. mask = (info->irq[pin].bitmap &
> > pcibios_irq_mask). So an IRQ might not match the mask because the user
> > specified a more restrictive mask than the $PIR table.
> 
> Okay, so it might be user error, but it is worth a printk, for sure.

I think it's more like using the mem= parameter (user choice as opposed
to user error). If you have 256MB, but you specify "mem=64m", you don't
get a kernel message saying "e820 table incorrect: motherboard says you
have 256MB, only detected 64MB".

Note that I'm not saying we shouldn't warn if the PIR table really is
inconsistent, I'm just saying we shouldn't warn about an explicit
configuration choice.

What if we did the warning earlier (before we get into the irq
detection/assignment code) in pcibios_lookup_irq()? Just complain if
!(info->irq[pin].bitmap & (1 << r->get(pirq_router_dev, dev, pirq))).

Thoughts?

> > > Otherwise patch looks sane. Did you try submitting it to
> > > linus/marcelo?
> > 
> > Not yet. Wanted to do a bit more testing, especially considering the
> > pcmcia problems people have had. Do your pcmcia difficulties occur
> > without the patch, as well?
> 
> Yep. That machine was always touchy w.r.t. pcmcia.

Just copied 572MB from a cdrom hung off a pcmcia scsi adapter to my
desktop box via pcmcia ethernet card - everything went fine. I don't
have any cardbus cards to test, but I imagine they would work as well. I
was assigned irq 3 and irq 10 for the two devices. I did notice that it
seemed to prefer one device inserted at a time (as opposed to coming up
with both plugged in). Odd.

-Cory

