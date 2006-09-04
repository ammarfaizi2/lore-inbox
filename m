Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWIDA7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWIDA7T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 20:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWIDA7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 20:59:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46214 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932184AbWIDA7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 20:59:19 -0400
Date: Sun, 3 Sep 2006 17:58:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: sergio@sergiomb.no-ip.org
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wedgwood <cw@f00f.org>,
       greg@kroah.com, jeff@garzik.org, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
Subject: Re: VIA IRQ quirk fixup only in XT-PIC mode Take 3
Message-Id: <20060903175841.7a84c63c.akpm@osdl.org>
In-Reply-To: <1157330567.3046.24.camel@localhost.portugal>
References: <1157330567.3046.24.camel@localhost.portugal>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2006 01:42:47 +0100
Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:

> Hi, this patch (now for 2.6.18-rc5).
> 
> 
> I found, on my new VIA with IO-APIC working well, that quirks aren't
> good/needed.
> After, I found this interesting email http://lkml.org/lkml/2005/8/13/30
> by Karsten Wiese, after, Alan Cox writes this
> http://lkml.org/lkml/2005/8/16/160 (on same thread) and Karsten Wiese
> end ups with the solution on http://lkml.org/lkml/2005/8/18/92, which I
> want try to implement.  
> I have 2 VIAs with almost same IDs (others reporters have
> with exactly the same IDs) and in ones I need the quirks and in others
> don't, because one don't have APIC enabled, the other have it !?!
> 
> we have other reported of the same problem
> http://lkml.org/lkml/2006/7/30/59
> and 
> http://lkml.org/lkml/2006/9/1/106
> 
> Checking my emails that I send to Len Brown on May of 2005 about this
> subject. I found, what I want, is just revert one patch of Bjorn
> Helgaas, between kernel 2.6.12-rc5 and 6.14.
> Check this out
> http://sourceforge.net/mailarchive/message.php?msg_id=11858102
> 
> To finish I want put clear, the great work of Bjorn Helgaas which have
> made all of this, but at the end, I suspect with one false positive
> report introduce this regression, that I hopefully found.
> 

This thing is getting embarrassing.

> diff linux-2.6.17.x86_64/drivers/pci/quirks.c.orig linux-2.6.17.x86_64/drivers/pci/quirks.c -up
> --- linux-2.6.17.x86_64/drivers/pci/quirks.c.orig       2006-09-04 01:37:09.000000000 +0100
> +++ linux-2.6.17.x86_64/drivers/pci/quirks.c    2006-09-04 01:40:16.000000000 +0100
> @@ -654,22 +654,24 @@ static void quirk_via_irq(struct pci_dev
>  {
>         u8 irq, new_irq;
> 
> +#ifdef CONFIG_X86_IO_APIC
> +       if (nr_ioapics && !skip_ioapic_setup)
> +               return;
> +#endif
> +#ifdef CONFIG_ACPI
> +       if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
> +               return;
> +#endif
>         new_irq = dev->irq & 0xf;
>         pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>         if (new_irq != irq) {
> -               printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
> +               printk(KERN_INFO "PCI: VIA PIC IRQ fixup for %s, from %d to %d\n",
>                         pci_name(dev), irq, new_irq);
>                 udelay(15);     /* unknown if delay really needed */
>                 pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>         }
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

There's a similar patch in -mm: pci-quirk_via_irq-behaviour-change.patch. 
Does that work for you?
  

-- 
VGER BF report: H 0
