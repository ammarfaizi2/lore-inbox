Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVINRVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVINRVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbVINRVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:21:09 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:43741 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S965253AbVINRVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:21:07 -0400
Message-ID: <43285951.7050702@kromtek.com>
Date: Wed, 14 Sep 2005 21:09:37 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <4327F586.3030901@gmail.com> <4327F551.6070903@kromtek.com> <4327FB6C.3070708@gmail.com> <43280F2F.2060708@gmail.com> <432815FA.5040202@gmail.com> <43281C27.1060305@kromtek.com> <43284CE6.3080302@gmail.com>
In-Reply-To: <43284CE6.3080302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:

> you do NOT do this at all, because you have pdev already (the param of 
> the probe function)
> 

I rewrote the entire thing like this including the pci_remove function 
too, but now it so seems that in the remove function, 
pci_get_drvdata(pdev) returns NULL, and hence i get an Oops at module 
removal.


Manu


struct mantis_pci {
	/*	PCI stuff	*/
	__u16 id;
	__u16 vendor_id;
	__u16 device_id;
	__u16 sub_vendor_id;
	__u16 sub_device_id;
	__u8  latency;
	
	/*	Linux PCI	*/	
	struct pci_dev *pdev;

	__u32 mantis_addr;
	volatile __u8 __iomem *mantis_mmio;

	__u8  irq;
	__u8  revision;
	
	__u16 mantis_card_num;

	/*	RISC Core	*/
	__u32 block_count;
	__u32 block_bytes;
	__u32 line_bytes;
	__u32 line_count;
	
	__u32 risc_pos;
	
	__u32 buf_size;
	__u8  *buf_cpu;
	dma_addr_t buf_dma;
	
	__u32 risc_size;
	__u32 *risc_cpu;
	dma_addr_t risc_dma;
};


static int mantis_pci_probe(struct pci_dev *pdev, const struct 
pci_device_id *mantis_pci_table)
{
	struct mantis_pci *mantis;
	struct mantis_eeprom eeprom;
	u8 revision, latency;
	u8 data[2];	

	if (pci_enable_device(pdev)) {		
		dprintk(verbose, MANTIS_DEBUG, 1, "Found a mantis chip");
		if ((mantis = (struct mantis_pci *) kmalloc(sizeof (struct 
mantis_pci), GFP_KERNEL)) == NULL) {
			dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
			return -ENOMEM;
		}
		pci_set_master(pdev);
		mantis->mantis_addr = pci_resource_start(pdev, 0);
		if (!request_mem_region(pci_resource_start(pdev, 0),
			pci_resource_len(pdev, 0), DRIVER_NAME)) {
			kfree(mantis);
			return -EBUSY;
		}
		pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
		pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
		mantis->mantis_mmio = ioremap(mantis->mantis_addr, 0x1000);
		pci_set_drvdata(pdev, mantis);		

		if (request_irq(pdev->irq, (void *) mantis_pci_irq, SA_SHIRQ |
						SA_INTERRUPT, DRIVER_NAME, (void *) mantis) < 0) {
			dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ registration failed");
			release_mem_region(pci_resource_start(pdev, 0),
					pci_resource_len(pdev, 0));
			pci_disable_device(pdev);
			kfree(mantis);
			return -ENODEV;
		}


		mantis_reg_dump(mantis);	
	}

	
	return 0;
}


static void mantis_pci_remove(struct pci_dev *pdev)
{
	struct mantis_pci *mantis;
	dprintk(verbose, MANTIS_DEBUG, 1, "Removing Mantis device");			
	mantis = pci_get_drvdata(pdev);
	if (mantis == NULL)
		dprintk(verbose, MANTIS_DEBUG, 1, "Aeio, mantis");
		
	dprintk(verbose, MANTIS_ERROR, 1, "Mantis irq: %d, latency: %d\nmemory: 
0x%04x, mmio: 0x%p", pdev->irq, mantis->latency,
		mantis->mantis_addr, mantis->mantis_mmio);
	free_irq(pdev->irq, mantis);
	dprintk(verbose, MANTIS_ERROR, 1, "Mantis @ 0x%p", mantis->mantis_mmio);
	if (mantis->mantis_mmio)
		iounmap((u8 *) mantis->mantis_mmio);
	release_mem_region(pci_resource_start(pdev, 0),
			pci_resource_len(pdev, 0));
	pci_disable_device(pdev);
	pci_set_drvdata(pdev, NULL);
	kfree(mantis);
}

