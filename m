Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVIOJD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVIOJD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVIOJD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:03:26 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:25730 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S932295AbVIOJD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:03:26 -0400
Message-ID: <4329362A.1030201@linuxtv.org>
Date: Thu, 15 Sep 2005 12:51:54 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <200509150843.33849@bilbo.math.uni-mannheim.de> <4329269E.1060003@linuxtv.org> <200509151018.20322@bilbo.math.uni-mannheim.de>
In-Reply-To: <200509151018.20322@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Rolf Eike Beer wrote:

>That is true, but you should not call pci_get_device() in this function at 
>all.
>
>  
>
I reworked the whole thing over  .. but i am feeling that something's a 
bit wrong somewhere ..

The log i get on a load - unload ..

[  102.261264] mantis_pci_probe: Got a device
[  102.262852] mantis_pci_probe: We got an IRQ
[  102.264392] mantis_pci_probe: We finally enabled the device
[  102.266020] Mantis Rev 1, irq: 23, latency: 32
[  102.266118]          memory: 0xefeff000, mmio: f9218000
[  102.269162] Trying to free free IRQ23
[  110.297341] mantis_pci_remove: Removing -->Mantis irq: 23,         
latency: 32
[  110.297344]  memory: 0xefeff000, mmio: 0xf9218000
[  110.301326] Trying to free free IRQ23
[  110.303445] Trying to free nonexistent resource <efeff000-efefffff>


#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include <linux/interrupt.h>
#include <linux/kmod.h>
#include <linux/vmalloc.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/device.h>
#include "mantis_common.h"
#include "mantis_dma.h"
#include "mantis_i2c.h"
#include "mantis_eeprom.h"

#define DRIVER_NAME                "Mantis"

static struct pci_device_id mantis_pci_table[] = {
    { PCI_DEVICE(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11) },
    { 0 },
};

MODULE_DEVICE_TABLE(pci, mantis_pci_table);

static irqreturn_t mantis_pci_irq(int irq, void *dev_id, struct pt_regs 
*regs)
{
    struct mantis_pci *mantis;
   
    dprintk(verbose, MANTIS_DEBUG, 1, "Mantis PCI IRQ");
    mantis = (struct mantis_pci *) dev_id;
    if (mantis == NULL)
        dprintk(verbose, MANTIS_DEBUG, 1, "Aeio, mantis ISR");
   
    /*    Events
     *    (1) PCMCIA insert
     *    (2) PCMCIA extract
     *    (3) I2C complete
     */
   
    return IRQ_HANDLED;
}

static int mantis_i2c_setup(struct mantis_pci *mantis)
{
    u32 config = 0;
   
//    mmwrite(0x80, MANTIS_DMA_CTL); // MCU i2c read
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
        INT_MASK=0x%04x, I2C_DATA=0x%04x", ctlreg, intstat,        \
        intmask, i2cdata);
   
    return 0;
}

static int __devinit mantis_pci_probe(struct pci_dev *pdev,
                const struct pci_device_id *mantis_pci_table)
{
    u8 revision, latency;
//    u8 data[2];   
    struct mantis_pci *mantis;
    mantis = (struct mantis_pci *)
                kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
    if (mantis == NULL) {
        dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
        return -ENOMEM;
    }
    dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
    mantis->mantis_addr = pci_resource_start(pdev, 0);
    if (!request_mem_region(pci_resource_start(pdev, 0),
        pci_resource_len(pdev, 0), DRIVER_NAME)) {
        dprintk(verbose, MANTIS_ERROR, 1, "Request mem region failed");
        goto err0;
    }
    if ((mantis->mantis_mmio =
                ioremap(mantis->mantis_addr, 0x1000)) == NULL) {
        dprintk(verbose, MANTIS_ERROR, 1, "IO remap failed");
        goto err1;
    }
    if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ |
                SA_INTERRUPT, DRIVER_NAME, mantis) < 0) {
        dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ reg failed");
        goto err2;
    }
    dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
    if (pci_enable_device(pdev)) {
        dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
        goto err3;       
    }
    dprintk(verbose, MANTIS_DEBUG, 1, "We finally enabled the device");
    pci_set_master(pdev);
    pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
    pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
    mantis->latency = latency;
    mantis->revision = revision;
    if (!latency) {
        pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
    }
    pci_set_drvdata(pdev, mantis);   
    dprintk(verbose, MANTIS_ERROR, 0, "Mantis Rev %d, ", mantis->revision);
    dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\n \
        memory: 0x%04x, mmio: %p\n", pdev->irq, mantis->latency,    \
        mantis->mantis_addr, mantis->mantis_mmio);   
err3:
    free_irq(pdev->irq, pdev);   
err2:
    if (mantis->mantis_mmio)
        iounmap(mantis->mantis_mmio);
err1:
    release_mem_region(pci_resource_start(pdev, 0),
                pci_resource_len(pdev, 0));
err0:
    kfree(mantis);
   
    return 0;
}

static void __devexit mantis_pci_remove(struct pci_dev *pdev)
{
    struct mantis_pci *mantis = pci_get_drvdata(pdev);
    if (mantis == NULL) {
        dprintk(verbose, MANTIS_ERROR, 1, "Aeio, MAntis NULL ptr");
        return;
    }
    dprintk(verbose, MANTIS_ERROR, 1, "Removing -->Mantis irq: %d, \
        latency: %d\n memory: 0x%04x, mmio: 0x%p",
        pdev->irq, mantis->latency, mantis->mantis_addr,
        mantis->mantis_mmio);

    free_irq(pdev->irq, pdev);
   
    release_mem_region(pci_resource_start(pdev, 0),
        pci_resource_len(pdev, 0));
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



