Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVCRT0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVCRT0t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVCRT0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:26:49 -0500
Received: from alog0452.analogic.com ([208.224.222.228]:38889 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261969AbVCRT0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:26:42 -0500
Date: Fri, 18 Mar 2005 14:22:25 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Le Wen <le_wen@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Questions about request_irq and reading PCI_INTERRUPT_LINE
In-Reply-To: <BAY20-F284EE2A7DE004B2A2FECC7E54A0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0503181407300.28091@chaos.analogic.com>
References: <BAY20-F284EE2A7DE004B2A2FECC7E54A0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005, Le Wen wrote:

> On Fri, 18 Mar 2005, Le Wen wrote:
>
>> Hi, there,
>> 
>> I have problem to grab video from my ati all-in-wonder card. The card is in 
>> a PII Celeron machine with an on board video card (ATI Technologies Inc 3D 
>> Rage IIC AGP). there is no monitor connected with the on board video card. 
>> I only hook my AIW card with a monitor.
>> 
>> I use km-0.6 from gatos project. I load this km_drv module, but kernel 
>> always complains:
>> 
>> km: IRQ 0 busy
>> 
>> I checked code:
>>       km_probe(struct pci_dev *dev, const struct pci_device_id *pci_id)
>> 
>> here dev->irq with a value 0.
>> 
>> When km_probe gets called, it try to request an IRQ0 returns a -EBUSY:
>>       kms_irq=dev.irq;
>>       result=request_irq(kms->irq, handler, SA_SHIRQ, tag, (void *)kms);
>> 
>>       if(result==-EBUSY){
>>               printk(KERN_ERR "km: IRQ %ld busy\n", kms->irq);
>>               goto fail;
>>       }
>> 
>> 
>> So I tried to get right IRQ number using:
>>       u8 myirq;
>>       int rtn=pci_read_config_byte(dev,PCI_INTERRUPT_LINE, &myirq);
>>       dev->irq=myirq;
>>       kms->irq=dev_irq;
>>       result=request_irq(kms->irq, handler, SA_SHIRQ, tag, (void *)kms);
>> 
>>       if(result==-EBUSY){
>>               printk(KERN_ERR "km: IRQ %ld busy\n", kms->irq);
>>               goto fail;
>>       }
>>       if(result<0){
>>               printk(KERN_ERR "km: could not install irq handler: 
>> result=%d\n",result);
>>               goto fail;
>>       }
>> But this time I got:
>> 
>> km: kms->irq=24
>> km: could not install irq handler: result=-38
>> 
>> 
>> My questions are:
>> 1. I don't know why dev->irq has value of 0?
>> 
>
> The PCI interface now needs to be enabled first. The IRQ value
> returned is BAD until after one calls pci_enable_device(). This
> is a BUG, now considered a FEATURE so it's unlikely to be fixed!
> There are lots of people who have encountered this problem
> with modules that are not in the "distribution".
>
>> 2. Is an IRQ number of 24 valid for a Intel PII Celeron?
>> 
>
> Could be, but it;s probably invalid considering the way you
> got it.
>
>> 3. What does this result=-38 mean?
>> 
>
> Probably errno 38, i.e., ENOSYS
>
>> 
>> Wen, Le
>> 
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
> Notice : All mail here is now cached for review by Dictator Bush.
>                 98.36% of all statistics are fiction.
>
> Thank you Dick!
>
> But pci_enable_device(dev) was called sucussful before read 
> pci_read_config_byte():
>
> static int __devinit km_probe(struct pci_dev *dev, const struct pci_device_id 
> *pci_id)
> {
> ...
> if (pci_enable_device(dev))
>               return -EIO;
>       printk(KERN_DEBUG "pci_read_config_byte(dev,PCI_INTERRUPT_LINE, 
> &testirq)\n");
>       u8 myirq;//=0;
>       int rtn=pci_read_config_byte(dev,PCI_INTERRUPT_LINE, &myirq);
>       kms->dev=dev;
>       dev->irq=myirq;
>       kms->irq=dev->irq;
> and then call
>      result=request_irq(kms->irq, handler, SA_SHIRQ, tag, (void *)kms);
>

Whatever you do, do NOT read the PCI_INTERRUPT_LINE and think that
it is an IRQ. It's not. The low 4-bits show some stuff called an
"interrupt line", then there is the next 4-bits that is called
"interrupt pin". None of these values show you the IRQ to use!
In fact, INTA is required to be used for a "single-function"
device to generate interrupts. Therefore everything on the
usual PCI/Bus will be connected to INTA. INTA is some pin
that gets connected to a PC-board trace that only the vendor
(and BIOS group) knows. The Linux PCI interface gets its
information from the BIOS so it "knows" what the actual
IRQ is. You can't get that information by reading a PCI/Bus
device configuration register.

You code should do:
         .... find your device, then:
 	pci_enable_device(dev);
         irq = dev->irq;
         result=request_irq(irq, handler, SA_INTERRUPT|SA_SHIRQ,
                           "device name", (void *)parameters);


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
