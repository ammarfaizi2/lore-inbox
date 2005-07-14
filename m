Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVGNWp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVGNWp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVGNWnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:43:55 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:31449 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262476AbVGNWmc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:42:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mirSizfDZMfRTnrgkhfGVhcvNbJAt/mnOQje6TBTaOzENMQQbh34X6+UGAFh24GJ1oXaUmsSVSb69CSRMCUhTHFdWmwBuh3sW1zBkfOgr4mTSqNYU7xEigVLBppoX9q4BwSGtjQfYCDrb91mA3miXKONaLILxwUMZYU41E0VT0c=
Message-ID: <9e47339105071415423caabe8d@mail.gmail.com>
Date: Thu, 14 Jul 2005 18:42:30 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050715014436.A613@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050714155344.A27478@jurassic.park.msu.ru>
	 <20050714145327.B7314@flint.arm.linux.org.uk>
	 <20050715014436.A613@den.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/05, Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
> It shouldn't be a problem. These days we have a lot of arch hooks
> in the PCI layer. I'd probably start with the following:

You need to take this code into account, from arch/i386/pci/fixup.c

/*
 * Fixup to mark boot BIOS video selected by BIOS before it changes
 *
 * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
 *
 * The standard boot ROM sequence for an x86 machine uses the BIOS
 * to select an initial video card for boot display. This boot video
 * card will have it's BIOS copied to C0000 in system RAM.
 * IORESOURCE_ROM_SHADOW is used to associate the boot video
 * card with this copy. On laptops this copy has to be used since
 * the main ROM may be compressed or combined with another image.
 * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
 * is marked here since the boot video device will be the only enabled
 * video device at this point.
 */

static void __devinit pci_fixup_video(struct pci_dev *pdev)
{
        struct pci_dev *bridge;
        struct pci_bus *bus;
        u16 config;

        if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
                return;

        /* Is VGA routed to us? */
        bus = pdev->bus;
        while (bus) {
                bridge = bus->self;
                if (bridge) {
                        pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
                                                &config);
                        if (!(config & PCI_BRIDGE_CTL_VGA))
                                return;
                }
                bus = bus->parent;
        }
        pci_read_config_word(pdev, PCI_COMMAND, &config);
        if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
                pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
                printk(KERN_DEBUG "Boot video device is %s\n", pci_name(pdev));
        }
}
DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);

-- 
Jon Smirl
jonsmirl@gmail.com
