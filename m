Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWJATgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWJATgT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWJATgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:36:19 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:17843 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932262AbWJATgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:36:17 -0400
Date: Sun, 1 Oct 2006 13:36:16 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-scsi@vger.kernel.org, "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Frederik Deweerdt <deweerdt@free.fr>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [-mm patch] aic7xxx: check irq validity (was Re: 2.6.18-mm2)
Message-ID: <20061001193616.GF16272@parisc-linux.org>
References: <20060928014623.ccc9b885.akpm@osdl.org> <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org> <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159729523.2891.408.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 09:05:23PM +0200, Arjan van de Ven wrote:
> > int pci_request_irq(struct pci_dev *pdev, irq_handler_t handler,
> > 			unsigned long flags, const char *name, void *data)
> > {
> > 	if (!valid_irq(pdev->irq)) {
> > 		dev_printk(KERN_ERR, &pdev->dev, "invalid irq\n");
> > 		return -EINVAL;
> > 	}
> > 
> > 	return request_irq(pdev->irq, handler, flags | IRQF_SHARED, name, data);
> > }
> 
> well... why not go one step further and eliminate the flags argument
> entirely? And use pci_name() for the name (so eliminate the argument ;)
> and always pass pdev as data, so that that argument can go away too....
> 
> that'll cover 99% of the request_irq() users for pci devices.. and makes
> it really nicely simple and consistent.

hmm.  $ echo `cut -c34- /proc/interrupts`
timer i8042 cascade acpi yenta, ehci_hcd:usb1, Intel 82801DB-ICH4 yenta,
uhci_hcd:usb2 uhci_hcd:usb4, eth0 ide0 uhci_hcd:usb3, eth1

Network drivers use their eth%d name.  USB drivers use [eu]hci_hcd:usb%d.
Others tend to use the driver name.  Changing them all to be 0000:00:1d.2
isn't really an improvement in the readability of /proc/interrupts, IMO.

Passing pdev as the data is a good idea for practically no device driver.
It's rare to actually want the pci_device down in the interrupt handler;
normally you want the device private data.  Using pci_get_drvdata(pdev)
as the data would make sense for both sym2 and tg3.  I don't feel like
auditing other drivers to see if it'd make sense for them too.

So, current proposal:

int pci_request_irq(struct pci_dev *pdev, irq_handler_t handler,
			const char *name)
{
	if (!valid_irq(pdev->irq)) {
		dev_printk(KERN_ERR, &pdev->dev, "invalid irq\n");
		return -EINVAL;
	}

	return request_irq(pdev->irq, handler, IRQF_SHARED, name,
				pci_get_drvdata(pdev));
}

But what about IRQF_SAMPLE_RANDOM?
