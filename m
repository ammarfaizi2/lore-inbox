Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVIQTgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVIQTgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 15:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVIQTgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 15:36:06 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:2221 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750895AbVIQTgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 15:36:05 -0400
Message-ID: <432C6D76.4020208@linuxtv.org>
Date: Sat, 17 Sep 2005 23:24:38 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: free free irq and Oops on cat /proc/interrupts (2)
References: <432C344D.1030604@linuxtv.org> <432C62D5.9080703@gmail.com>
In-Reply-To: <432C62D5.9080703@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------050003070609060404060306"
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050003070609060404060306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jiri Slaby wrote:

> Manu Abraham napsal(a):
>
>> Can somebody give me a pointer as to what i am possibly doing wrong.
>>
>> The module loads fine..
>> The module unloads fine.. But i get a "free free IRQ" on free_irq()..
>> I do a cat /proc/interrupts .. I get an Oops.. Attached dmesg [1]
>> I did an Oops trace down to vsprintf.c, using make EXTRA_CFLAGS="-g 
>> -Wa,-a,-ad" lib/vsprintf.o > lib/vsprintf.asm, but still couldn't 
>> find what the real bug is.
>
>
> Please, stop spamming list with your (almost all stupid) questions.
> At the first read some material. ldd3 is the book, which will help you 
> (the 3rd time I tell you that). There is explained how to write pci 
> devices.
> Then read some code, as Rolf Eike Beer wrote. Almost everything what 
> will you ever need was written at least once.
> Then think, if you didn't see the thing you want somewhere and take a 
> look there.


> And after all tries ask list, why the driver is not working.
>
> At least Rolf and me wrote you, that you need to call 
> pci_enable_device and you do NOT do that again. So?
>

This was what Rolf wrote.
http://marc.theaimsgroup.com/?l=linux-kernel&m=112680448728918&w=2

The code what i posted later on was to find out why even with that it 
happens ..

I had attached the code, which calls in pci_enable_device(). Haven't you 
seen that ?
If not, please do take a look at it. This was in the same lines as Rolf 
wrote, hence my post.




Manu



--------------050003070609060404060306
Content-Type: text/plain;
 name="mantis_pci.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_pci.c"

#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include <linux/kmod.h>
#include <linux/vmalloc.h>
#include <linux/init.h>
#include <linux/device.h>
#include "mantis_common.h"
#include "mantis_dma.h"
#include "mantis_i2c.h"
#include "mantis_eeprom.h"

#include <asm/irq.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/interrupt.h>

unsigned int verbose = 1;
module_param(verbose, int, 0644);
MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");

#define PCI_VENDOR_ID_MANTIS			0x1822
#define PCI_DEVICE_ID_MANTIS_R11		0x4e35
#define DRIVER_NAME				"Mantis"

static struct pci_device_id mantis_pci_table[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, mantis_pci_table);

static irqreturn_t mantis_pci_irq(int irq, void *dev_id, struct pt_regs *regs)
{
	struct mantis_pci *mantis;

	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis PCI IRQ");
	mantis = (struct mantis_pci *) dev_id;
	if (mantis == NULL)
		dprintk(verbose, MANTIS_DEBUG, 1, "Aeio, mantis ISR");

	/*	Events
	 *	(1) PCMCIA insert
	 *	(2) PCMCIA extract
	 *	(3) I2C complete
	 */
/*
	return IRQ_HANDLED;
*/
	return IRQ_NONE;	// temporary, for now
}

static int mantis_i2c_setup(struct mantis_pci *mantis)
{
	u32 config = 0;

//	mmwrite(0x80, MANTIS_DMA_CTL); // MCU i2c read
	config = mmread(MANTIS_DMA_CTL);
	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis Ctl reg=0x%04x", config);

	return 0;
}

static int mantis_reg_dump(struct mantis_pci *mantis)
{
	u32 ctlreg, intstat, intmask, i2cdata;

	ctlreg = mmread(MANTIS_DMA_CTL);
	intstat = mmread(MANTIS_INT_STAT);
	intmask = mmread(MANTIS_INT_MASK);
	i2cdata = mmread(MANTIS_I2C_DATA);
	dprintk(verbose, MANTIS_DEBUG, 1, "CTL_REG=0x%04x, INT_STAT=0x%04x, \
		INT_MASK=0x%04x, I2C_DATA=0x%04x", ctlreg, intstat,		\
		intmask, i2cdata);

	return 0;
}

static int __devinit mantis_pci_probe(struct pci_dev *pdev,
				const struct pci_device_id *mantis_pci_table)
{
	u8 revision, latency;
//	u8 data[2];
	struct mantis_pci *mantis;

	dprintk(verbose, MANTIS_ERROR, 1, "<1:>IRQ=%d", pdev->irq);
	if (pci_enable_device(pdev)) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
		goto err;
	}
	dprintk(verbose, MANTIS_ERROR, 1, "<2:>IRQ=%d", pdev->irq);

	mantis = (struct mantis_pci *)
				kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
	if (mantis == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
		return -ENOMEM;
	}
	dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
	mantis->mantis_addr = (pci_resource_start(pdev, 0) & ~0x08UL);
	if (!request_mem_region(pci_resource_start(pdev, 0),
		pci_resource_len(pdev, 0), DRIVER_NAME)) {
		dprintk(verbose, MANTIS_ERROR, 1, "Request mem region failed");
		goto err0;
	}

//	if (pci_request_regions(pdev, DRIVER_NAME) < 0)
//		goto err0;
			
	if ((mantis->mantis_mmio =
				ioremap(mantis->mantis_addr, 0x1000)) == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "IO remap failed");
		goto err1;
	}
	mmwrite(0, MANTIS_INT_STAT);
	if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ | SA_INTERRUPT, 
						DRIVER_NAME, mantis) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ reg failed");
		goto err2;
	}

	dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
	dprintk(verbose, MANTIS_DEBUG, 1, "We finally enabled the device");
	pci_set_master(pdev);
	pci_set_drvdata(pdev, mantis);
	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
	pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
	mantis->latency = latency;
	mantis->revision = revision;
	if (!latency) {
		pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
	}
//	pci_set_drvdata(pdev, mantis);
	dprintk(verbose, MANTIS_ERROR, 0, "Mantis Rev %d, ", mantis->revision);
	dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\
	\nmemory: 0x%lx, mmio: %p\n", pdev->irq, mantis->latency,	\
		mantis->mantis_addr, mantis->mantis_mmio);

	return 0;
err2:
	dprintk(verbose, MANTIS_DEBUG, 1, "<freak out (2)> IO Unmap");
	if (mantis->mantis_mmio)
		iounmap(mantis->mantis_mmio);
err1:
	dprintk(verbose, MANTIS_DEBUG, 1, "<freak out (1)> Release regions");
	release_mem_region(pci_resource_start(pdev, 0),
				pci_resource_len(pdev, 0));
	pci_disable_device(pdev);
err0:
	dprintk(verbose, MANTIS_DEBUG, 1, "<freak out (0)> Free");
	kfree(mantis);
err:
	dprintk(verbose, MANTIS_DEBUG, 1, "<freak out (err)");
	return -ENODEV;
}



static void __devexit mantis_pci_remove(struct pci_dev *pdev)
{
	struct mantis_pci *mantis = pci_get_drvdata(pdev);
	if (mantis == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "Aeio, MAntis NULL ptr");
		return;
	}
	dprintk(verbose, MANTIS_ERROR, 1, "Removing -->Mantis irq: %d, \
		latency: %d\n memory: 0x%lx, mmio: 0x%p",
		pdev->irq, mantis->latency, mantis->mantis_addr,
		mantis->mantis_mmio);

	free_irq(pdev->irq, pdev);
//	release_mem_region(pci_resource_start(pdev, 0),
//		pci_resource_len(pdev, 0));
	pci_release_regions(pdev);
	pci_set_drvdata(pdev, NULL);
	pci_disable_device(pdev);
	kfree(mantis);
}

static struct pci_driver mantis_pci_driver = {
	.name = "Mantis PCI combo driver",
	.id_table = mantis_pci_table,
	.probe = mantis_pci_probe,
	.remove = mantis_pci_remove,
};

static int __devinit mantis_pci_init(void)
{
	return pci_register_driver(&mantis_pci_driver);
}

static void __devexit mantis_pci_exit(void)
{
	pci_unregister_driver(&mantis_pci_driver);
}

module_init(mantis_pci_init);
module_exit(mantis_pci_exit);

MODULE_DESCRIPTION("Mantis PCI DTV bridge driver");
MODULE_AUTHOR("Manu Abraham");
MODULE_LICENSE("GPL");

--------------050003070609060404060306--
