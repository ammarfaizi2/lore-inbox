Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286297AbRLJQCO>; Mon, 10 Dec 2001 11:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286300AbRLJQCF>; Mon, 10 Dec 2001 11:02:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57106 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S286297AbRLJQBw>; Mon, 10 Dec 2001 11:01:52 -0500
Date: Mon, 10 Dec 2001 17:01:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011210170147.A24663@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy> <1007685691.6675.1.camel@localhost.localdomain> <20011207213313.A176@elf.ucw.cz> <1007876254.17062.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007876254.17062.0.camel@localhost.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hey, this gross hack fixed USB on HP OmniBook xe3. Good! (Perhaps you
> > know what interrupt is right for maestro3, also on omnibook? ;-).
> 
> On my Pavilion (and the other 5400's as far as I can tell), maestro's on
> irq 5. Wanna send me a "dump_pirq" and a "lspci -vvvxxx"? Could you try
> the patch below (inspired by/stolen from Kai Germaschewski)? Also, the
> newest acpi patch will print out the acpi irq routing table - might have
> your info. You can tell if the patch below had any effect because it
> will say it ASSIGNED IRQ XX instead of FOUND.
> 
> I believe the Omnibook XEs and the Pavilion N5400's are very similar
> hardware. Several of the drivers I've seen on HP's website appear to
> apply to both. If you want to help get the BIOS updated (the root cause,
> IMHO), please call HP support and reference case number 1429683616 (that
> 9 may be a 4 - my handwriting is horrible). That's the case I logged
> with thim about the broken PIR table (USB irq showing 9; being 11) and
> failure to enable sse on athlon 4/duron/xp chips.

I called them... The girl who received call was very friendly, wanted
to assign me bug#, but I resisted. I told her your bug#, but only
reply I got was something like "all our bug numbers begin with 1327",
and she apparently had no access to global database. I am not sure the
person knew what I was talking about.

He told me there's updated bios, somewhere. Did you try that?

What exactly is wrong? You said PIR tables are broken, but with patch
below, it seems to work. What's wrong?
								Pavel


> The "honor the irq mask" approach (works on my machine):
> --- /home/cbell/linux-2.4/arch/i386/kernel/pci-irq.c	Fri Dec  7 01:51:41 2001
> +++ /home/cbell/linux-2.4-test/arch/i386/kernel/pci-irq.c	Sat Dec  8 21:04:37 2001
> @@ -581,6 +581,7 @@
>  	 * reported by the device if possible.
>  	 */
>  	newirq = dev->irq;
> +	if (!((1 << newirq) & mask)) newirq = 0;
>  	if (!newirq && assign) {
>  		for (i = 0; i < 16; i++) {
>  			if (!(mask & (1 << i)))
> @@ -599,7 +600,7 @@
>  		irq = pirq & 0xf;
>  		DBG(" -> hardcoded IRQ %d\n", irq);
>  		msg = "Hardcoded";
> -	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
> +	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq) && ((1 << irq) & mask))) {
>  		DBG(" -> got IRQ %d\n", irq);
>  		msg = "Found";
>  	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
> @@ -633,7 +634,7 @@
>  			continue;
>  		if (info->irq[pin].link == pirq) {
>  			/* We refuse to override the dev->irq information. Give a warning! */
> -		    	if (dev2->irq && dev2->irq != irq) {
> +		    	if (dev2->irq && dev2->irq != irq && ((1 << dev2->irq) & mask)) {
>  		    		printk(KERN_INFO "IRQ routing conflict for %s, have irq %d, want irq %d\n",
>  				       dev2->slot_name, dev2->irq, irq);
>  		    		continue;

-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
