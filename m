Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVCRSrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVCRSrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVCRSrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:47:52 -0500
Received: from alog0452.analogic.com ([208.224.222.228]:54702 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261705AbVCRSrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:47:47 -0500
Date: Fri, 18 Mar 2005 13:44:36 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Le Wen <le_wen@hotmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Questions about request_irq and reading PCI_INTERRUPT_LINE
In-Reply-To: <BAY20-F12D2C7B3C608DE7BF487B9E54A0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0503181337240.27860@chaos.analogic.com>
References: <BAY20-F12D2C7B3C608DE7BF487B9E54A0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005, Le Wen wrote:

> Hi, there,
>
> I have problem to grab video from my ati all-in-wonder card. The card is in a 
> PII Celeron machine with an on board video card (ATI Technologies Inc 3D Rage 
> IIC AGP). there is no monitor connected with the on board video card. I only 
> hook my AIW card with a monitor.
>
> I use km-0.6 from gatos project. I load this km_drv module, but kernel always 
> complains:
>
> km: IRQ 0 busy
>
> I checked code:
>       km_probe(struct pci_dev *dev, const struct pci_device_id *pci_id)
>
> here dev->irq with a value 0.
>
> When km_probe gets called, it try to request an IRQ0 returns a -EBUSY:
>       kms_irq=dev.irq;
>       result=request_irq(kms->irq, handler, SA_SHIRQ, tag, (void *)kms);
>
>       if(result==-EBUSY){
>               printk(KERN_ERR "km: IRQ %ld busy\n", kms->irq);
>               goto fail;
>       }
>
>
> So I tried to get right IRQ number using:
>       u8 myirq;
>       int rtn=pci_read_config_byte(dev,PCI_INTERRUPT_LINE, &myirq);
>       dev->irq=myirq;
>       kms->irq=dev_irq;
>       result=request_irq(kms->irq, handler, SA_SHIRQ, tag, (void *)kms);
>
>       if(result==-EBUSY){
>               printk(KERN_ERR "km: IRQ %ld busy\n", kms->irq);
>               goto fail;
>       }
>       if(result<0){
>               printk(KERN_ERR "km: could not install irq handler: 
> result=%d\n",result);
>               goto fail;
>       }
> But this time I got:
>
> km: kms->irq=24
> km: could not install irq handler: result=-38
>
>
> My questions are:
> 1. I don't know why dev->irq has value of 0?
>

The PCI interface now needs to be enabled first. The IRQ value
returned is BAD until after one calls pci_enable_device(). This
is a BUG, now considered a FEATURE so it's unlikely to be fixed!
There are lots of people who have encountered this problem
with modules that are not in the "distribution".

> 2. Is an IRQ number of 24 valid for a Intel PII Celeron?
>

Could be, but it;s probably invalid considering the way you
got it.

> 3. What does this result=-38 mean?
>

Probably errno 38, i.e., ENOSYS

>
> Wen, Le
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
