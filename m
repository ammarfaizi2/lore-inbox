Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVIQTkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVIQTkK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 15:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVIQTkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 15:40:10 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:6044 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1751177AbVIQTkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 15:40:08 -0400
Message-ID: <432C6E67.7030602@linuxtv.org>
Date: Sat, 17 Sep 2005 23:28:39 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: free free irq and Oops on cat /proc/interrupts (2)
References: <432C344D.1030604@linuxtv.org> <20050917215646.78a05044.vsu@altlinux.ru> <432C5F93.80506@linuxtv.org> <20050917191058.GJ11302@procyon.home>
In-Reply-To: <20050917191058.GJ11302@procyon.home>
Content-Type: multipart/mixed;
 boundary="------------050703010807090401060309"
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
--------------050703010807090401060309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sergey Vlasov wrote:

>On Sat, Sep 17, 2005 at 10:25:23PM +0400, Manu Abraham wrote:
>[skip]
>  
>
>>static int __devinit mantis_pci_probe(struct pci_dev *pdev,
>>				const struct pci_device_id *mantis_pci_table)
>>{
>>	u8 revision, latency;
>>	struct mantis_pci *mantis;
>>
>>	mantis = (struct mantis_pci *)
>>				kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
>>	if (mantis == NULL) {
>>		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
>>		return -ENOMEM;
>>	}
>>	if (pci_enable_device(pdev)) {
>>		dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
>>		goto err;
>>	}
>>	dprintk(verbose, MANTIS_ERROR, 1, "<2:>IRQ=%d", pdev->irq);
>>
>>	dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
>>	if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ | SA_INTERRUPT, 
>>						DRIVER_NAME, mantis) < 0) {
>>    
>>
>
>Some code is obviously missing here...
>
>  
>
>>	dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
>>	return 0;
>>
>>err:
>>	dprintk(verbose, MANTIS_DEBUG, 1, "<freak out>");
>>	kfree(mantis);
>>	return -ENODEV;
>>}
>>
>>
>>
>>static void __devexit mantis_pci_remove(struct pci_dev *pdev)
>>{
>>	free_irq(pdev->irq, pdev);
>>    
>>
>
>Here is the next problem - you must give free_irq() the same pointer
>that you have passed to request_irq().  So you need a way to get from
>a struct pci_dev for your device to the corresponding struct
>mantis_pci.  This is done as follows:
>
>1) In your mantis_pci_probe(), when you have initialized the device
>successfully, put the pointer to you data structure into the PCI
>device structure:
>
>	pci_set_drvdata(pdev, mantis);
>
>2) In mantis_pci_remove() (and later in other PCI driver functions,
>like suspend/resume) get this pointer back:
>
>	struct mantis_pci *mantis = pci_get_drvdata(pdev);
>  
>
I had already done this ..

>Then use that pointer where you need it (e.g., in free_irq()).
>
>3) mantis_pci_remove() should also clear out the pointer to the driver
>data:
>
>	pci_set_drvdata(pdev, NULL);
>
>  
>
This too.. But the same error persists ..
Attached is that very same code ..


Manu


--------------050703010807090401060309
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

--------------050703010807090401060309--
