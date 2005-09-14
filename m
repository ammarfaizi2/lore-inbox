Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVINM75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVINM75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVINM75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:59:57 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:56226 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S965172AbVINM74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:59:56 -0400
Message-ID: <43281C27.1060305@kromtek.com>
Date: Wed, 14 Sep 2005 16:48:39 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <4327F586.3030901@gmail.com> <4327F551.6070903@kromtek.com> <4327FB6C.3070708@gmail.com> <43280F2F.2060708@gmail.com> <432815FA.5040202@gmail.com>
In-Reply-To: <432815FA.5040202@gmail.com>
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

> Manu Abraham napsal(a):
>
>> Jiri Slaby wrote:
>>
>>> Manu Abraham napsal(a):
>>>
>>>> Jiri Slaby wrote:
>>>>
>>>>> Manu Abraham napsal(a):
>>>>>
>>>>>> Now that i have been trying to implement the driver using the new 
>>>>>> PCI API, i feel a bit lost at the different changes gone into the 
>>>>>> PCI API. So if someone could give me a brief idea how a minimal 
>>>>>> PCI probe routine should consist of, that would be quite helpful.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Maybe, you want to read http://lwn.net/Kernel/LDD3/, chapter 12, 
>>>>> pages 311+.
>>>>>
>>>>
>>>> I have been updating myself from LDD2 to LDD3. What i was wondering 
>>>> was in what order should i be calling the functions.
>>>
>>>
>>>
>>>
>>> You won't call anything, kernel does. You only register driver.
>>> struct pcitbl {venids, devids}
>>>
>>> struct driver ... = {probe=a, remove=b, tbl=pcitbl};
>>> a() { if device from pcitbl is in the system (or has been added 
>>> before some little time) this function is called}
>>> b() {if the device was removed from system: modules and hotplug: 
>>> never called; modules: so if modules unload; if both: if the device 
>>> was removed on the fly, or module unload}
>>>
>>> module_init() { register_driver(driver)}
>>> module_exit() { unregister_driver(driver); }
>>>
>>
>> I was wondering whether pci_enable_device() should come first or 
>> pci_dev_put() in the probe routine.
>
> pci_dev_put? No, it counts down reference count, so you would loose 
> the structure. You do NOT do pci_dev_put anymore with pci probing (but 
> some very very specific cases).


Oh, i thought after a pci_dev_get() one does a pci_dev_put()
I wrote something like this, i was now confused with what to do with
pci_get_drvdata() and pci_set_drvdata()
I am not very sure whether i am doing it right in the first place, since
my mapped memory seems to be wrong, but first i have to clear up about
pci_get/set_drvdata().


Manu

static int mantis_pci_probe(*struct* pci_dev *pdev, const *struct* 
pci_device_id *mantis_pci_table)
{
	*struct* mantis_pci *mantis;
	u8 revision, latency;

	pdev = pci_get_device(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11, 
NULL);
	*if* (pdev) {
		dprintk(verbose, MANTIS_DEBUG, 1, "Found a mantis chip");
		*if* ((mantis = (*struct* mantis_pci *) kmalloc(*sizeof* (*struct* 
mantis_pci), GFP_KERNEL)) == NULL) {
			dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
			*return* -ENOMEM;
		}
		*if* (pci_enable_device(pdev) < 0) {
			dprintk(verbose, MANTIS_ERROR, 1, "Could not enable device");
			kfree(mantis);
			*return* -ENODEV;
		}
		mantis->pdev = pdev;
		mantis->mantis_addr = pci_resource_start(pdev, 0);
		*if* (!request_mem_region(pci_resource_start(pdev, 0),
			pci_resource_len(pdev, 0), DRIVER_NAME)) {
			kfree(mantis);
			*return* -EBUSY;
		}
		pci_read_config_byte(mantis->pdev, PCI_CLASS_REVISION, &revision);
		pci_read_config_byte(mantis->pdev, PCI_LATENCY_TIMER, &latency);
		mantis->mantis_mmio = ioremap(mantis->mantis_addr, 0x1000);
		mmwrite(0, MANTIS_INT_STAT); //*		Clear interrupts	*//
		*if* (request_irq(mantis->pdev->irq, (void *) mantis_pci_irq, SA_SHIRQ |
						SA_INTERRUPT, DRIVER_NAME, (void *) mantis) < 0) {
			dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ registration failed");
			release_mem_region(pci_resource_start(mantis->pdev, 0),
					pci_resource_len(mantis->pdev, 0));
			pci_disable_device(pdev);
			kfree(mantis);
		}
		pci_dev_put(pdev);


	}

	
	*return* 0;
}




