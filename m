Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVIOLy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVIOLy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVIOLy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:54:27 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:21180 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1751109AbVIOLy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:54:26 -0400
Message-ID: <43295E41.8010808@linuxtv.org>
Date: Thu, 15 Sep 2005 15:42:57 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralph Metzler <rjkm@metzlerbros.de>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com>	<200509150843.33849@bilbo.math.uni-mannheim.de>	<4329269E.1060003@linuxtv.org>	<200509151018.20322@bilbo.math.uni-mannheim.de>	<4329362A.1030201@linuxtv.org> <17193.19739.213773.593444@localhost.localdomain>
In-Reply-To: <17193.19739.213773.593444@localhost.localdomain>
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

Ralph Metzler wrote:

>Hi Manu,
>
>Manu Abraham writes:
> > [  102.261264] mantis_pci_probe: Got a device
> > [  102.262852] mantis_pci_probe: We got an IRQ
> > [  102.264392] mantis_pci_probe: We finally enabled the device
> > [  102.266020] Mantis Rev 1, irq: 23, latency: 32
> > [  102.266118]          memory: 0xefeff000, mmio: f9218000
> > [  102.269162] Trying to free free IRQ23
> > [  110.297341] mantis_pci_remove: Removing -->Mantis irq: 23,         
> > latency: 32
> > [  110.297344]  memory: 0xefeff000, mmio: 0xf9218000
> > [  110.301326] Trying to free free IRQ23
> > [  110.303445] Trying to free nonexistent resource <efeff000-efefffff>
>
>
>I think you should call pci_enable_device() before request_irq, etc. 
>AFAIK, the pci_enable_device() can change resources like IRQ.
>  
>
>That's probably what causes these errors. Just print out the irq 
>number before and after pci_enable_device() to check if that's the 
>problem.
>
>  
>

Hmm.. not much of a change i can say ..


Manu


[  631.211320] mantis_pci_probe: <1:>IRQ=23
[  631.211495] mantis_pci_probe: <2:>IRQ=23
[  631.211664] mantis_pci_probe: Got a device
[  631.211850] mantis_pci_probe: We got an IRQ
[  631.212013] mantis_pci_probe: We finally enabled the device
[  631.212236] Mantis Rev 1, irq: 23, latency: 32
[  631.212322]          memory: 0xefeff000, mmio: f9218000
[  639.259136] mantis_pci_remove: Removing -->Mantis irq: 23,         
latency: 32
[  639.259138]  memory: 0xefeff000, mmio: 0xf9218000
[  639.259504] Trying to free free IRQ23
[  639.259673] Trying to free nonexistent resource <efeff000-efefffff>



static int __devinit mantis_pci_probe(struct pci_dev *pdev,
                const struct pci_device_id *mantis_pci_table)
{
    u8 revision, latency;
//    u8 data[2];   
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
err2:
    if (mantis->mantis_mmio)
        iounmap(mantis->mantis_mmio);
err1:
    release_mem_region(pci_resource_start(pdev, 0),
                pci_resource_len(pdev, 0));
err0:
    kfree(mantis);
err:
    return 0;
}

