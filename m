Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285955AbRLHVDY>; Sat, 8 Dec 2001 16:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285942AbRLHVDR>; Sat, 8 Dec 2001 16:03:17 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:54033 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285948AbRLHVBt>; Sat, 8 Dec 2001 16:01:49 -0500
Date: Fri, 7 Dec 2001 21:33:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: John Clemens <john@deater.net>, linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011207213313.A176@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy> <1007685691.6675.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007685691.6675.1.camel@localhost.localdomain>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You are absolutely correct :) I did the same thing a few weeks ago (when i
> > was really working on it), and traced the lspci -vvxxx output and
> > interpreted everything linux was saying about it.  I was looking at it
> > from the acpect of maybe just changing the PCI router in config space as
> > well as the PCI irq from user space without requiring kernel changes at
> > all.  The reason why I didn't try that was because i chickened out and
> > didn't know wether changing the PIRQ table woudl a) work or b) permanently
> > screw up my machine.  This may still be the "correct way" however...
> 
> Well, the *actual* PIRQ table is supposed to be static, according to the
> spec. I don't see the $PIR signature anywhere in the ROM, so it may be
> generated on boot. As for changing the IRQ router PCI config space, the
> last patch is doing that already - r->set is just calling pirq_ali_set,
> which fiddles the bit in question.
> 
> Could you try a new patch? Works fine for me...
> 
> --- linux/arch/i386/kernel/pci-irq.c.dist	Sun Nov  4 09:31:58 2001
> +++ linux/arch/i386/kernel/pci-irq.c	Thu Dec  6 15:09:54 2001
> @@ -157,6 +157,13 @@
>  {
>  	static unsigned char irqmap[16] = { 0, 9, 3, 10, 4, 5, 7, 6, 1, 11, 0, 12, 0, 14, 0, 15 };
>  
> +	if ( pirq == 0x59 && 
> +	irqmap[read_config_nybble(router, 0x48, pirq-1)] == 9) {
> +		write_config_nybble(router, 0x48, pirq-1, 9);
> +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
> +		dev->irq = 11;
> +		DBG(" GROSS HP/ALi Hack Enabled!!");
> +	}
>  	return irqmap[read_config_nybble(router, 0x48, pirq-1)];
>  }

Hey, this gross hack fixed USB on HP OmniBook xe3. Good! (Perhaps you
know what interrupt is right for maestro3, also on omnibook? ;-).

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
