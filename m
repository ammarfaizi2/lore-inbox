Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTHSUyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTHSUyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:54:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57618 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261352AbTHSUwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:52:50 -0400
Date: Tue, 19 Aug 2003 21:52:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Standard driver call to enable/disable PCI ROM
Message-ID: <20030819215246.H23670@flint.arm.linux.org.uk>
Mail-Followup-To: Jon Smirl <jonsmirl@yahoo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030819210618.D23670@flint.arm.linux.org.uk> <20030819204643.75442.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030819204643.75442.qmail@web14913.mail.yahoo.com>; from jonsmirl@yahoo.com on Tue, Aug 19, 2003 at 01:46:43PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 01:46:43PM -0700, Jon Smirl wrote:
> --- Russell King <rmk@arm.linux.org.uk> wrote:
> > You should use pcibios_resource_to_bus() to convert a resource to a
> > representation suitable for a BAR.
> 
> I've never used pcibios_resource_to_bus(), what's the right way to do this?
> This is a good reason for making this into a common PCI driver function, 
> it will stop people like me from messing up PCI calls.

It's a 2.5/2.6 invention.

Here follows a cut-down version of pci_update_resource() to illustrate
its use when updating up a BAR (see drivers/pci/setup-res.c for the full
version):

static void
pci_update_resource(struct pci_dev *dev, struct resource *res, int resno)
{
        struct pci_bus_region region;

        pcibios_resource_to_bus(dev, &region, res);

        new = region.start | (res->flags & PCI_REGION_FLAG_MASK);

        if (resno < 6) {
                reg = PCI_BASE_ADDRESS_0 + 4 * resno;
        } else if (resno == PCI_ROM_RESOURCE) {
                new |= res->flags & PCI_ROM_ADDRESS_ENABLE;
                reg = dev->rom_base_reg;
        }

        pci_write_config_dword(dev, reg, new);
}

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

