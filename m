Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVJWVqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVJWVqR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVJWVqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:46:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26832 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750715AbVJWVqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:46:17 -0400
Date: Sun, 23 Oct 2005 22:46:11 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Laurent Riffard <laurent.riffard@free.fr>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, dmo@osdl.org, mike.miller@hp.com,
       iss_storagedev@hp.com, Jeff Garzik <garzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] drivers/block: updates .owner field of struct pci_driver
Message-ID: <20051023214611.GH7992@ftp.linux.org.uk>
References: <20051023204947.430464000@antares.localdomain> <20051023204956.213142000@antares.localdomain> <20051023211320.GB19915@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051023211320.GB19915@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 10:13:20PM +0100, Russell King wrote:
> On Sun, Oct 23, 2005 at 10:49:48PM +0200, Laurent Riffard wrote:
> > This patch updates .owner field of struct pci_driver.
> > 
> > This allows SYSFS to create the symlink from the driver to the
> > module which provides it.
> > 
> > Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
> 
> Wouldn't it be better to eliminate pci_driver's .owner field and
> set the generic device driver's owner field directly? (and fix
> the PCI code not to overwrite that if pci_driver's .owner field
> is NULL for compatibility.)
> 
> I ask for the second time recently on linux-kernel.  Is there
> *really* any point in duplicating these fields?

#define pci_register_driver(d) __pci_register_driver(d, THIS_MODULE)

#define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_MODULE)

__pci_register_driver(drv, module) - same as current pci_register_driver(),
except that instead of
        drv->driver.owner = drv->owner;
it does
        drv->driver.owner = module;

__ide_pci_register_driver(driver, module):
{
        if(!pre_init)
                return __pci_register_driver(driver, module);
	driver->driver.owner = module;
        list_add_tail(&driver->node, &ide_pci_drivers);
        return 0;
}

and in ide_scan_pcibus() turn
                pci_register_driver(d);
into
		__pci_register_driver(d, d->driver.owner);

Update exports (i.e. export __pci_register_driver and __ide_pci_register_driver
instead of pci_register_driver and ide_pci_register_driver resp.).

At which point pci_driver->owner become unused and can be killed at leisure.
Objections?
