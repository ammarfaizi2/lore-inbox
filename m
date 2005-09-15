Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVIOH5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVIOH5D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVIOH5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:57:02 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:23513 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750729AbVIOH5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:57:00 -0400
Message-ID: <4329269E.1060003@linuxtv.org>
Date: Thu, 15 Sep 2005 11:45:34 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <43287712.3040503@gmail.com> <4328A3C8.6010501@linuxtv.org> <200509150843.33849@bilbo.math.uni-mannheim.de>
In-Reply-To: <200509150843.33849@bilbo.math.uni-mannheim.de>
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

>Manu Abraham wrote:
>  
>
>>Jiri Slaby wrote:
>>    
>>
>>>Manu Abraham napsal(a):
>>>      
>>>
>>>>Jiri Slaby wrote:
>>>>        
>>>>
>>>>>Manu Abraham napsal(a):
>>>>>          
>>>>>
>>>>>>Jiri Slaby wrote:
>>>>>>            
>>>>>>
>>>>>>>you do NOT do this at all, because you have pdev already (the param
>>>>>>>of the probe function)
>>>>>>>              
>>>>>>>
>>>>>>I rewrote the entire thing like this including the pci_remove
>>>>>>function too, but now it so seems that in the remove function,
>>>>>>pci_get_drvdata(pdev) returns NULL, and hence i get an Oops at
>>>>>>module removal.
>>>>>>            
>>>>>>
>>>>I just found that, pci_enable_device() fails. So what's the way to go
>>>>ahead ?
>>>>        
>>>>
>>>JESUS.
>>>      
>>>
>>Hmm.. i finally got it to work. It seems pci_get_device() is necessary,
>>i can't seem to enable the device or request for an IRQ the way you
>>suggested. It looks some quirks are there though ..
>>
>>If only i could explain why it works this way and not the other way ..
>>    
>>
>
>Because pci_enable_device() works like most other kernel (and also libc) 
>functions: it returns 0 if everything went fine.
>
>
>  
>
>>[   81.269655] mantis_pci_probe: Got a device
>>[   81.269825] mantis_pci_probe: We got an IRQ
>>[   81.269987] mantis_pci_probe: We finally enabled the device
>>[   81.270191] Mantis Rev 1, irq: 23, latency: 32
>>[   81.270289] memory: 0xefeff000, mmio: f9218000
>>[   81.270519] Trying to free free IRQ23
>>[   90.485885] mantis_pci_remove: Removing -->Mantis irq: 23, latency: 32
>>[   90.485887] memory: 0xefeff000, mmio: 0xf9218000
>>[   90.486293] Trying to free free IRQ23
>>[   90.486429] Trying to free nonexistent resource <efeff000-efefffff>
>>    
>>
>
>You should introduce a table of PCI devices here that your driver feels 
>responsible for. Then put this into a struct pci_driver which you pass to 
>  
>
I am in fact doing that ..

static *struct* pci_device_id mantis_pci_table[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, mantis_pci_table);

static *struct* pci_driver mantis_pci_driver = {
	.name = "Mantis PCI combo driver",
	.id_table = mantis_pci_table,
	.probe = mantis_pci_probe,
	.remove = mantis_pci_remove,
};

static int __devinit mantis_pci_init(void)
{ 
	*return* pci_register_driver(&mantis_pci_driver);
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



>pci_module_init. Take a look on a random other PCI driver, 
>drivers/net/8139too.c, drivers/scsi/aic7xxx/aic7xxx_osm_pci.c, whatever.
>
>  
>
>>static int __devinit mantis_pci_probe(struct pci_dev *pdev, const struct
>>pci_device_id *mantis_pci_table)
>>{
>>	u8 revision, latency;
>>	u8 data[2];
>>	struct mantis_pci *mantis;
>>	mantis = (struct mantis_pci *) kmalloc(sizeof (struct mantis_pci),
>>GFP_KERNEL);
>>	if (mantis == NULL) {
>>		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
>>		return -ENOMEM;
>>	}
>>
>>	pdev = pci_get_device(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11,
>>NULL);
>>    
>>
>
>This is not needed anymore then. Your probe function will get called with for 
>any pci dev your driver can handle.
>
>  
>

I will just check it up again to see what went wrong ..

>>	if (pdev) {
>>		dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
>>		mantis->mantis_addr = pci_resource_start(pdev, 0);
>>		if (!request_mem_region(pci_resource_start(pdev, 0),
>>			pci_resource_len(pdev, 0), DRIVER_NAME)) {
>>			dprintk(verbose, MANTIS_ERROR, 1, "Request for memory region failed");
>>    
>>
>
>Line length is maximum 80 characters. See Documentation/CodingStyle
>  
>

That was not meant to go into the kernel straight away, as it needs 
*lot* of work, the PCI part is only something extremely small.

>  
>
>>			goto err0;
>>		}
>>		if ((mantis->mantis_mmio = ioremap(mantis->mantis_addr, 0x1000)) == NULL) {
>>			dprintk(verbose, MANTIS_ERROR, 1, "IO remap failed");
>>			goto err1;
>>		}
>>		if (request_irq(pdev->irq, (void *) mantis_pci_irq, SA_SHIRQ |
>>						SA_INTERRUPT, DRIVER_NAME, (void *) mantis) < 0) {
>>    
>>
>
>You don't need to cast a pointer to void* or vice versa.
>
>  
>
Ah, thanks ...

>>			dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ registration failed");
>>			goto err2;
>>		}
>>		dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
>>		if (pci_enable_device(pdev)) {
>>			dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI device enable failed");
>>			goto err3;
>>		}
>>		dprintk(verbose, MANTIS_DEBUG, 1, "We finally enabled the device");
>>		pci_set_master(pdev);
>>		pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
>>		pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
>>		mantis->latency = latency;
>>		mantis->revision = revision;
>>		if (!latency) {
>>			pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
>>		}
>>    
>>
>
>The value in mantis->latency and the one in the card's address space now differ.
>  
>

Yes, i set it to the default latency as specified by vendor.. But 
temporarily to test the card ..

>  
>
>>		pci_set_drvdata(pdev, mantis);
>>		dprintk(verbose, MANTIS_ERROR, 0, "Mantis Rev %d, ", mantis->revision);
>>		dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\nmemory:
>>0x%04x, mmio: %p\n", pdev->irq, mantis->latency,
>>			mantis->mantis_addr, mantis->mantis_mmio);
>>
>>		pci_dev_put(pdev);
>>    
>>
>
>No, DON'T DO THAT! This will drop the a reference count from the struct 
>pci_dev, which means it can get freed while your driver still wants to work 
>with it.
>
>  
>

Hmm.. I thought after i make a call to pci_get_device(), i have to do a 
pci_dev_put() after the usage ..
I was a bit lost when to use pci_dev_put() in this case.

>>	} else {
>>		dprintk(verbose, MANTIS_ERROR, 1, "No device found");
>>		return -ENODEV;
>>	}
>>
>>err3:
>>	free_irq(pdev->irq, pdev);
>>err2:
>>	if (mantis->mantis_mmio)
>>		iounmap(mantis->mantis_mmio);
>>err1:
>>	release_mem_region(pci_resource_start(pdev, 0),
>>				pci_resource_len(pdev, 0));
>>err0:
>>	kfree(mantis);
>>
>>	return 0;
>>}
>>
>>
>>static void __devexit mantis_pci_remove(struct pci_dev *pdev)
>>{
>>	struct mantis_pci *mantis = pci_get_drvdata(pdev);
>>	if (mantis == NULL) {
>>		dprintk(verbose, MANTIS_ERROR, 1, "Aeio, MAntis NULL ptr");
>>    
>>
>
>a) this should really never happen. If it happens, it's a kernel bug.
>b) if you catch this error while debugging, you should return here so you do
>   not dereference this NULL pointer.
>
>  
>
Ack.

>>	}
>>	dprintk(verbose, MANTIS_ERROR, 1, "Removing -->Mantis irq: %d, latency:
>>%d\nmemory: 0x%04x, mmio: 0x%p", pdev->irq, mantis->latency,
>>			mantis->mantis_addr, mantis->mantis_mmio);
>>
>>	free_irq(pdev->irq, pdev);
>>
>>	release_mem_region(pci_resource_start(pdev, 0),
>>		pci_resource_len(pdev, 0));
>>	pci_disable_device(pdev);
>>	pci_set_drvdata(pdev, NULL);
>>	kfree(mantis);
>>}
>>    
>>

Thanks ..

Regards,
Manu

