Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVINQQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVINQQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbVINQQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:16:55 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:42377 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1030227AbVINQQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:16:54 -0400
Message-ID: <43284CE6.3080302@gmail.com>
Date: Wed, 14 Sep 2005 18:16:38 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Manu Abraham <manu@kromtek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <4327F586.3030901@gmail.com> <4327F551.6070903@kromtek.com> <4327FB6C.3070708@gmail.com> <43280F2F.2060708@gmail.com> <432815FA.5040202@gmail.com> <43281C27.1060305@kromtek.com>
In-Reply-To: <43281C27.1060305@kromtek.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham napsal(a):

> Jiri Slaby wrote:
>
>> Manu Abraham napsal(a):
>>
>>> Jiri Slaby wrote:
>>>
>>>> Manu Abraham napsal(a):
>>>>
>>>>> Jiri Slaby wrote:
>>>>>
>>>>>> Manu Abraham napsal(a):
>>>>>>
>>>>>>> Now that i have been trying to implement the driver using the 
>>>>>>> new PCI API, i feel a bit lost at the different changes gone 
>>>>>>> into the PCI API. So if someone could give me a brief idea how a 
>>>>>>> minimal PCI probe routine should consist of, that would be quite 
>>>>>>> helpful.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Maybe, you want to read http://lwn.net/Kernel/LDD3/, chapter 12, 
>>>>>> pages 311+.
>>>>>>
>>>>>
>>>>> I have been updating myself from LDD2 to LDD3. What i was 
>>>>> wondering was in what order should i be calling the functions.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> You won't call anything, kernel does. You only register driver.
>>>> struct pcitbl {venids, devids}
>>>>
>>>> struct driver ... = {probe=a, remove=b, tbl=pcitbl};
>>>> a() { if device from pcitbl is in the system (or has been added 
>>>> before some little time) this function is called}
>>>> b() {if the device was removed from system: modules and hotplug: 
>>>> never called; modules: so if modules unload; if both: if the device 
>>>> was removed on the fly, or module unload}
>>>>
>>>> module_init() { register_driver(driver)}
>>>> module_exit() { unregister_driver(driver); }
>>>>
>>>
>>> I was wondering whether pci_enable_device() should come first or 
>>> pci_dev_put() in the probe routine.
>>
>>
>> pci_dev_put? No, it counts down reference count, so you would loose 
>> the structure. You do NOT do pci_dev_put anymore with pci probing 
>> (but some very very specific cases).
>
>
>
> Oh, i thought after a pci_dev_get() one does a pci_dev_put()
> I wrote something like this, i was now confused with what to do with
> pci_get_drvdata() and pci_set_drvdata()
> I am not very sure whether i am doing it right in the first place, since
> my mapped memory seems to be wrong, but first i have to clear up about
> pci_get/set_drvdata().
>
>
> Manu
>
> static int mantis_pci_probe(*struct* pci_dev *pdev, const *struct* 
> pci_device_id *mantis_pci_table)
> {
>     *struct* mantis_pci *mantis;
>     u8 revision, latency;
>
>     pdev = pci_get_device(PCI_VENDOR_ID_MANTIS, 
> PCI_DEVICE_ID_MANTIS_R11, NULL);

you do NOT do this at all, because you have pdev already (the param of 
the probe function)

>     *if* (pdev) {
>         dprintk(verbose, MANTIS_DEBUG, 1, "Found a mantis chip");
>         *if* ((mantis = (*struct* mantis_pci *) kmalloc(*sizeof* 
> (*struct* mantis_pci), GFP_KERNEL)) == NULL) {
>             dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
>             *return* -ENOMEM;
>         }
>         *if* (pci_enable_device(pdev) < 0) {

you do only this

>             dprintk(verbose, MANTIS_ERROR, 1, "Could not enable device");
>             kfree(mantis);
>             *return* -ENODEV;

gotos and return on one place

>         }
>         mantis->pdev = pdev;

you don't need this, need you? you put mantis with pci_setdrvdata and 
whenever you want it, you get it from it

>         mantis->mantis_addr = pci_resource_start(pdev, 0);
>         *if* (!request_mem_region(pci_resource_start(pdev, 0),
>             pci_resource_len(pdev, 0), DRIVER_NAME)) {
>             kfree(mantis);
>             *return* -EBUSY;
>         }
>         pci_read_config_byte(mantis->pdev, PCI_CLASS_REVISION, 
> &revision);
>         pci_read_config_byte(mantis->pdev, PCI_LATENCY_TIMER, &latency);
>         mantis->mantis_mmio = ioremap(mantis->mantis_addr, 0x1000);
>         mmwrite(0, MANTIS_INT_STAT); //*        Clear interrupts    *//
>         *if* (request_irq(mantis->pdev->irq, (void *) mantis_pci_irq, 
> SA_SHIRQ |
>                         SA_INTERRUPT, DRIVER_NAME, (void *) mantis) < 
> 0) {
>             dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ registration 
> failed");
>             release_mem_region(pci_resource_start(mantis->pdev, 0),
>                     pci_resource_len(mantis->pdev, 0));
>             pci_disable_device(pdev);
>             kfree(mantis);
>         }
>         pci_dev_put(pdev);

don't do that

>
>
>     }
>
>     
>     *return* 0;
> }
>
>

