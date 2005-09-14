Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVINWio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVINWio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVINWio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:38:44 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:24012 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S965076AbVINWin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:38:43 -0400
Message-ID: <4328A3C8.6010501@linuxtv.org>
Date: Thu, 15 Sep 2005 02:27:20 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <4327F586.3030901@gmail.com> <4327F551.6070903@kromtek.com> <4327FB6C.3070708@gmail.com> <43280F2F.2060708@gmail.com> <432815FA.5040202@gmail.com> <43281C27.1060305@kromtek.com> <43284CE6.3080302@gmail.com> <43285951.7050702@kromtek.com> <4328734E.2080607@gmail.com> <4328735B.70800@kromtek.com> <43287712.3040503@gmail.com>
In-Reply-To: <43287712.3040503@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: manu@kromtek.com
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

Jiri Slaby wrote:
> Manu Abraham napsal(a):
> 
>> Jiri Slaby wrote:
>>
>>> Manu Abraham napsal(a):
>>>
>>>> Jiri Slaby wrote:
>>>>
>>>>> you do NOT do this at all, because you have pdev already (the param 
>>>>> of the probe function)
>>>>>
>>>>
>>>> I rewrote the entire thing like this including the pci_remove 
>>>> function too, but now it so seems that in the remove function, 
>>>> pci_get_drvdata(pdev) returns NULL, and hence i get an Oops at 
>>>> module removal.
>>>
>> I just found that, pci_enable_device() fails. So what's the way to go 
>> ahead ?
> 
> JESUS.

Hmm.. i finally got it to work. It seems pci_get_device() is necessary, 
i can't seem to enable the device or request for an IRQ the way you 
suggested. It looks some quirks are there though ..

If only i could explain why it works this way and not the other way ..

Thanks for the help,
Regards,
Manu



[   81.269655] mantis_pci_probe: Got a device
[   81.269825] mantis_pci_probe: We got an IRQ
[   81.269987] mantis_pci_probe: We finally enabled the device
[   81.270191] Mantis Rev 1, irq: 23, latency: 32
[   81.270289] memory: 0xefeff000, mmio: f9218000
[   81.270519] Trying to free free IRQ23
[   90.485885] mantis_pci_remove: Removing -->Mantis irq: 23, latency: 32
[   90.485887] memory: 0xefeff000, mmio: 0xf9218000
[   90.486293] Trying to free free IRQ23
[   90.486429] Trying to free nonexistent resource <efeff000-efefffff>




static int __devinit mantis_pci_probe(struct pci_dev *pdev, const struct 
pci_device_id *mantis_pci_table)
{
	u8 revision, latency;
	u8 data[2];	
	struct mantis_pci *mantis;
	mantis = (struct mantis_pci *) kmalloc(sizeof (struct mantis_pci), 
GFP_KERNEL);
	if (mantis == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
		return -ENOMEM;
	}
	
	pdev = pci_get_device(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11, 
NULL);
	if (pdev) {
		dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
		mantis->mantis_addr = pci_resource_start(pdev, 0);
		if (!request_mem_region(pci_resource_start(pdev, 0),
			pci_resource_len(pdev, 0), DRIVER_NAME)) {
			dprintk(verbose, MANTIS_ERROR, 1, "Request for memory region failed");
			goto err0;
		}
		if ((mantis->mantis_mmio = ioremap(mantis->mantis_addr, 0x1000)) == 
NULL) {
			dprintk(verbose, MANTIS_ERROR, 1, "IO remap failed");
			goto err1;
		}
		if (request_irq(pdev->irq, (void *) mantis_pci_irq, SA_SHIRQ |
						SA_INTERRUPT, DRIVER_NAME, (void *) mantis) < 0) {
			dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ registration failed");
			goto err2;
		}
		dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
		if (pci_enable_device(pdev)) {
			dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI device enable failed");
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
		dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\nmemory: 
0x%04x, mmio: %p\n", pdev->irq, mantis->latency,
			mantis->mantis_addr, mantis->mantis_mmio);

		pci_dev_put(pdev);		

	} else {
		dprintk(verbose, MANTIS_ERROR, 1, "No device found");
		return -ENODEV;
	}
	
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
	}
	dprintk(verbose, MANTIS_ERROR, 1, "Removing -->Mantis irq: %d, latency: 
%d\nmemory: 0x%04x, mmio: 0x%p", pdev->irq, mantis->latency,
			mantis->mantis_addr, mantis->mantis_mmio);

	free_irq(pdev->irq, pdev);
	
	release_mem_region(pci_resource_start(pdev, 0),
		pci_resource_len(pdev, 0));
	pci_disable_device(pdev);
	pci_set_drvdata(pdev, NULL);
	kfree(mantis);
}



