Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWIGDrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWIGDrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 23:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWIGDrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 23:47:11 -0400
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:22224 "EHLO
	smtp141.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1422694AbWIGDrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 23:47:09 -0400
Message-ID: <44FF9656.1020309@gentoo.org>
Date: Wed, 06 Sep 2006 23:47:34 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: sergio@sergiomb.no-ip.org
CC: Linus Torvalds <torvalds@osdl.org>, Stian Jordet <liste@jordet.net>,
       akpm@osdl.org, jeff@garzik.org, greg@kroah.com, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
Subject: Re: [NEW PATCH] VIA IRQ quirk behaviour change
References: <20060906020429.6ECE67B40A0@zog.reactivated.net>	 <44FE8EBA.4060104@jordet.net>  <44FCE36D.4000708@gentoo.org>	 <1157557765.5091.1.camel@localhost.localdomain>	 <44FF5E90.9030808@gentoo.org> <1157594442.4700.9.camel@localhost.portugal>
In-Reply-To: <1157594442.4700.9.camel@localhost.portugal>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> yap, is the obvious conclusion, but no, my bet is one problem with USB
> and USB guys could put the USB things working. 

I'm not convinced, I'm pretty sure they'd say something like "this 
appears to be an IRQ routing problem" and send it somewhere else. I saw 
a bug report (introduced by the recent mainline via_irq_quirk() changes) 
where exactly this happened, but I can't find it.

> I just had remember, my Asrock with VIA8237 and VIA SATA (where I am
> write now) is working without quirks and USB guys made a patch, by
> coincidence. Since then have been working great.
> http://bugzilla.kernel.org/show_bug.cgi?id=6419#c19

Where's the patch?
This report seems to be inconclusive. Your USB problem (comment #19) was 
clearly something to do with UHCI itself, whereas Stian's problem is 
much more generic and outside the control of the USB HCD: nobody cared
Plus the only issue related to IRQ routing on that bug is triggered by 
the closed nvidia driver...

> About Linus patch I have to correct me about what I had write,
> http://lkml.org/lkml/2005/9/27/113
> «(it used to say "if we have an IO-APIC, don't do this" (my patch), now
> it says "if this irq is bound to an IO-APIC, don't do this")»
> Or my patch or the Linus patch, not both.

Sorry, I can't figure out what you are trying to say here. Can you 
rephrase it?

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c 
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -546,7 +546,10 @@ static void quirk_via_irq(struct pci_dev
>  {
>  	u8 irq, new_irq;
>  
> -	new_irq = dev->irq & 0xf;
> +	new_irq = dev->irq;
> +	if (!new_irq || new_irq >= 15)
> +		return;
> +
>  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>  	if (new_irq != irq) {
> 
> but I look to this Linus patch and I see 2 bugs
> one should be > not >=

I think you might be right here. Firstly IRQ 15 is a legacy IRQ, 
secondly the existing "&15" thing has no effect on IRQ 15 obviously.

> and new_irq after tests new_irq should be dev->irq & 0xf;
> like this:
> -	new_irq = dev->irq & 0xf;
> +	new_irq = dev->irq;
> +	if (!new_irq || new_irq > 15)
> +		return;
> +	new_irq = dev->irq & 0xf;
> 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>  	if (new_irq != irq) {

No, there is no bug, think about the logic:

We bail out if dev->irq is higher than 15. Therefore when we get to the 
lines of code in question, dev->irq is 15 or less. Performing a logical 
AND operation with the value 15 (0xf) is going to have no effect at all.

> About Stian computer, looking for /proc/interrupts 
> 
> 11:      30696      27559   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
> 
> have USB on irq 11, with IO-APIC-level, which less acpi is not normal on
> low numbers ( <=15  )  be IO-APIC-level,  normally is IO-APIC-edge. 
> Could be a ACPI problem .

I beg to differ. Usually APIC interrupts are level triggered. In fact 
(just as an example!) most NAPI-based network drivers will not work with 
edge-triggered interrupts. Additionally, if my understanding is correct, 
multiple devices sharing an edge triggered interrupt is bad news 
(interrupts likely to get lost so devices do not get serviced).

Daniel
