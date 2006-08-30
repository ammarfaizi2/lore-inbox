Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWH3QWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWH3QWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWH3QWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:22:14 -0400
Received: from www.osadl.org ([213.239.205.134]:54195 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751121AbWH3QWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:22:13 -0400
Subject: Re: [RFC] Simple userspace interface for PCI drivers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Matt Porter <mporter@embeddedalley.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       thomas.bauer@berger-lahr.com
In-Reply-To: <20060830143410.GB19477@gate.crashing.org>
References: <20060830062338.GA10285@kroah.com>
	 <20060830143410.GB19477@gate.crashing.org>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 18:25:55 +0200
Message-Id: <1156955155.29250.181.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 09:34 -0500, Matt Porter wrote:
> On Tue, Aug 29, 2006 at 11:23:38PM -0700, Greg KH wrote:
> > Thomas and I lamented that we were getting tired of seeing stuff like
> > this, and it was about time that we added the proper code to the kernel
> > to provide everything that would be needed in order to write PCI drivers
> > in userspace in a sane manner.  Really all that is needed is a way to
> > handle the interrupt, everything else can already be done in userspace
> > (look at X for an example of this...)
> 
> What about portable access to the PCI DMA API from userspace? I didn't
> think we had a way to handle DMA buffer management entirely from
> userspace. Looking at this code, it seems focused on one particular
> problem space of industrial control. If the goal is to allow most
> PCI drivers to be implemented in user space then I think it makes further
> sense to not limit the subsystem to PCI but any device (like things that
> are implemented as platform devices in kernel space).

The code was written to have a unified kernel / userspace interface for
a range of industrial I/O hardware - hence the name.

There is no real limitation for that type of devices and it is not
restricted to PCI in any way. We had no need for DMA in the first place,
but this should be an orthogonal extension.

> > And the name is a bit ackward, anyone have a better suggestion?
> 
> Well, if it's focused on industrial controls like it appears from
> the code here then the name is fine. If it's a starting point to
> become someting more generic then User Space Driver (USD) subsystem
> might be nice.

Yup.

> A more generic system would go a long way to get rid of the dubious
> secret-sauce binary kernel modules that are popular in embedded
> linux projects. 
> 
> > Thomas has also promised to come up with some userspace code that uses
> > this interface to show how to use it, but seems to have forgotten.
> > Consider this a reminder :)
> 
> That would be nice to see. I can't see how devices and drivers
> are registered from user space with what's here. I see
> iio_register_device() exported but no clue how userspace tells
> the kernel to claim a device or register an iio driver.

You still need a stub driver in the kernel. See below. The userspace
side is just opening the device which is created by udev and uses the
sysfs provided information to mmap the device space and to register
notifications, which might be replaced by kevent.

The example below is a driver for a SERCOS chip, which is a motion
control bus master. All we have in kernel is the register / unregister
function and the primary interrupt acknowledge of the chip, which allows
us to have this interrupt shared with other interrupt sources.

/**
* $Date: 2006-08-24 15:00:46 +0200 (Do, 24 Aug 2006) $
* $Author: baueh $
* $Rev: 370 $
*
* Sercos kernel stub driver
*
* Copyright (C) 2006 Berger Lahr GmbH
* Author: Thomas Bauer <thomas.bauer@berger-lahr.com>
*
* This code is GPL V2.
*/

#include <linux/fs.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/pci.h>
#include <linux/interrupt.h>
#include <linux/ioport.h>
#include <linux/iio.h>
#include <linux/delay.h>

#include "berger.h"

static struct pci_device_id sercos_table[] __devinitdata = {
	{ MY_VENDOR_ID, MY_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
	{ 0, }
};

MODULE_DEVICE_TABLE(pci, sercos_table);

/*
 * Use the generic file operations
 */
static struct file_operations generic_fops = {
	.open = iio_open,
	.release = iio_release,
	.read = iio_read,
	.write = iio_write,
	.llseek = iio_lseek,
	.mmap = iio_mmap,
};

/*
 * The chip specific portion of the interrupt handler. The framework code
 * takes care of userspace notification when we return IRQ_HANDLED
 */
static irqreturn_t sercos_handler (int irq, void *dev_id, struct pt_regs *reg)
{
	struct iio_device *idev = (struct iio_device *) dev_id;

	/* Check, if this interrupt is originated from the SERCOS chip */
	if (!(*((u16 *)(idev->virtaddr + SERCOS_INTERRUPT_STATUS)) & SERCOS_INTERRUPT_MASK))
		return IRQ_NONE;

	/* Acknowledge the chip interrupts */
	*((u16 *)(idev->virtaddr + SERCOS_INTERRUPT_ACK1_OFFSET)) = SERCOS_INTERRUPT_ACK1;
	*((u16 *)(idev->virtaddr + SERCOS_INTERRUPT_ACK2_OFFSET)) = SERCOS_INTERRUPT_ACK2;

	return IRQ_HANDLED;
}

static struct iio_device sercos_idev = {
	.name = "SERCON816",
	.version = "0x0010",
	.fops = &generic_fops,
	.handler = sercos_handler,
};

static struct sercos_idevs
{
	int sercos;
} sercos_idevs;

static int sercos_register (struct pci_dev *pdev, const struct pci_device_id *ent)
{
	if (pci_enable_device(pdev) != 0) {
		printk(KERN_ERR "sercos: Cannot enable PCI device\n");
		return -ENODEV;
	}

	/* FIXME: Read this from PCI ! */
	sercos_idev.size = SERCOS_SIZE;
	sercos_idev.virtaddr = ioremap(pci_resource_start (pdev, 0), sercos_idev.size);
	sercos_idev.physaddr = pci_resource_start(pdev, 0);
	sercos_idev.irq = SERCOS_IRQ;

	sercos_idevs.sercos = iio_register_device(&pdev->dev, &sercos_idev);

	printk(KERN_INFO "SERCOS = %d\n",sercos_idevs.sercos);
	printk(KERN_INFO "SERCOS registered at Phys. address 0x%lx \n", sercos_idev.physaddr);
	printk(KERN_INFO "SERCOS registered at Virt. address 0x%x \n", (unsigned int) sercos_idev.virtaddr);
	printk(KERN_INFO "SERCOS SIZE 0x%lx \n", sercos_idev.size);

	pdev->dev.driver_data = &sercos_idevs;
	return 0;
}


static void __devexit sercos_unregister (struct pci_dev *pdev)
{
	if (sercos_idevs.sercos)
		iio_unregister_device(sercos_idevs.sercos);

	release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
}

static struct pci_driver sercos_driver = {
	.name		= "sercos",
	.id_table	= sercos_table,
	.probe		= sercos_register,
	.remove		= __devexit_p(sercos_unregister),
};

static int __init sercos_init (void)
{
	return pci_register_driver (&sercos_driver);
}

static void __exit sercos_exit (void)
{
	pci_unregister_driver (&sercos_driver);
}

module_init(sercos_init);
module_exit(sercos_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("BergerLahr");
MODULE_DESCRIPTION("sercos driver");

/* 
 * Userspace portion of the SERCOS driver - simplified
 *
 * iionum - the iio device number to access:
 * /dev/iioX
 * /dev/iioX_event
 * /sys/class/iio/iioX
 */
int sercos_driver(int iionum)
{
	int fd;
	char fnam[64];
	size_t maplen;
	uint16_t *sercos;

	sprintf(fnam, "/dev/iio%d", iionum);
	fd = open(fnam, O_RDWR);
	if (fd < 0)
		return -EIO;

	/* Get map length from /sys/class/iioX/size */
	if (iiolib_getmaplen(iionum, &maplen)) {
		close(fd);
		return -ENODEV;
	}
	
	/* Map the chip space */
	sercos = mmap(NULL, maplen, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (sercos == MAP_FAILED) {
		close(fd);
		return -ENODEV;
	}
	close(fd);
	
	/* Initialize the chip */
	sercos_init_chip(sercos);

	/* 
	 * Open the event channel. We are the only user, but this could also
	 * be done by requesting notification by a signal.
	 */
	sprintf(fnam, "/dev/iio%d_event", iionum);
	fd = open(fnam, O_RDONLY);
	if (fd < 0) {
		sercos_reset_chip(sercos);
		munmap(sercos, maplen);
		return -EIO;
	}

	/* interrupt event loop */
	while (!stop_sercos) {
		char c;
		/* Block on the interrupt event */
                read(fd, &c, 1);
		sercos_handle_interrupt(sercos);
	}

	sercos_reset_chip(sercos);
	munmap(sercos, maplen);

	return 0;
}


