Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVCRSSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVCRSSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVCRSSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:18:23 -0500
Received: from bay20-f12.bay20.hotmail.com ([64.4.54.101]:8115 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261595AbVCRSSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:18:16 -0500
Message-ID: <BAY20-F12D2C7B3C608DE7BF487B9E54A0@phx.gbl>
X-Originating-IP: [66.146.138.130]
X-Originating-Email: [le_wen@hotmail.com]
From: "Le Wen" <le_wen@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Questions about request_irq and reading PCI_INTERRUPT_LINE
Date: Fri, 18 Mar 2005 13:18:14 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Mar 2005 18:18:15.0497 (UTC) FILETIME=[DA4E6390:01C52BE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, there,

I have problem to grab video from my ati all-in-wonder card. The card is in 
a PII Celeron machine with an on board video card (ATI Technologies Inc 3D 
Rage IIC AGP). there is no monitor connected with the on board video card. I 
only hook my AIW card with a monitor.

I use km-0.6 from gatos project. I load this km_drv module, but kernel 
always complains:

km: IRQ 0 busy

I checked code:
        km_probe(struct pci_dev *dev, const struct pci_device_id *pci_id)

here dev->irq with a value 0.

When km_probe gets called, it try to request an IRQ0 returns a -EBUSY:
        kms_irq=dev.irq;
        result=request_irq(kms->irq, handler, SA_SHIRQ, tag, (void *)kms);

        if(result==-EBUSY){
                printk(KERN_ERR "km: IRQ %ld busy\n", kms->irq);
                goto fail;
        }


So I tried to get right IRQ number using:
        u8 myirq;
        int rtn=pci_read_config_byte(dev,PCI_INTERRUPT_LINE, &myirq);
        dev->irq=myirq;
        kms->irq=dev_irq;
        result=request_irq(kms->irq, handler, SA_SHIRQ, tag, (void *)kms);

        if(result==-EBUSY){
                printk(KERN_ERR "km: IRQ %ld busy\n", kms->irq);
                goto fail;
        }
        if(result<0){
                printk(KERN_ERR "km: could not install irq handler: 
result=%d\n",result);
                goto fail;
        }
But this time I got:

km: kms->irq=24
km: could not install irq handler: result=-38


My questions are:
1. I don't know why dev->irq has value of 0?

2. Is an IRQ number of 24 valid for a Intel PII Celeron?

3. What does this result=-38 mean?


Wen, Le


