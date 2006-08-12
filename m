Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWHLWg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWHLWg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWHLWg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:36:59 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:61365 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751135AbWHLWg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:36:58 -0400
Message-ID: <44DE5A6F.50500@gentoo.org>
Date: Sat, 12 Aug 2006 23:47:11 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060811)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       greg@kroah.com, jeff@garzik.org, harmon@ksu.edu
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
References: <1154091662.7200.9.camel@localhost.localdomain>
In-Reply-To: <1154091662.7200.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> Hi, this patch (now for 2.6.18-rc2) is more readable.

Ok, it looks like I was wrong in my earlier mails, ACPI vs APIC 
confusion. In the bug reports I mentioned, APIC was not being used in 
any circumstances (however it is still a bit strange how these systems 
do not need quirks when acpi=off).

I'm reasonably certain that this patch will apply the quirks on the 
affected systems again, so I'm happy for it to be applied, people will 
be able to use their hardware again. However I'm not sure how good a 
solution it is, because in some circumstances it will apply the quirks 
to VIA PCI cards on non-VIA boards, which was the reason we messed with 
this code in the first place. We could possibly merge it with the 
southbridge detection hack, but it gets a bit silly at that point...

Jeff/Chris: any thoughts?

> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: "Scott J. Harmon" <harmon@ksu.edu>
> Cc: Andrew Morton <akpm@osdl.org>
> Cc: Chris Wedgwood <cw@f00f.org>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
> ---
>  quirks.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.17.i686/drivers/pci/quirks.c.orig	2006-07-28 12:59:04.000000000 +0100
> +++ linux-2.6.17.i686/drivers/pci/quirks.c	2006-07-28 13:26:49.000000000 +0100
> @@ -648,11 +648,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
>   *
>   * Some of the on-chip devices are actually '586 devices' so they are
>   * listed here.
> + * 
> + * if flags say that we have working apic(s), we don't need to quirk these
> + * devices
>   */
>  static void quirk_via_irq(struct pci_dev *dev)
>  {
>  	u8 irq, new_irq;
>  
> +	if ((smp_found_config && !skip_ioapic_setup && nr_ioapics) || cpu_has_apic)
> +		return;
> +
>  	new_irq = dev->irq & 0xf;
>  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>  	if (new_irq != irq) {
> @@ -662,13 +668,7 @@ static void quirk_via_irq(struct pci_dev
>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>  	}
>  }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
>  
>  /*
>   * VIA VT82C598 has its device ID settable and many BIOSes
> 
> 
> 
> 

