Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292594AbSCMHgY>; Wed, 13 Mar 2002 02:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292595AbSCMHgO>; Wed, 13 Mar 2002 02:36:14 -0500
Received: from maillog.promise.com.tw ([210.244.60.166]:38032 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S292594AbSCMHf5>; Wed, 13 Mar 2002 02:35:57 -0500
Message-ID: <03f301c1ca61$a050c190$59cca8c0@hank>
From: "Hank Yang" <hanky@promise.com.tw>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
        <dalecki@evision-ventures.com>
In-Reply-To: <E16jKMr-0006AG-00@the-village.bc.nu>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Wed, 13 Mar 2002 15:35:12 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We do hope the linux kernel add some code on ide-pci.c like following.

void __init ide_scan_pcidev (struct pci_dev *dev)
{
 ide_pci_devid_t  devid;
 ide_pci_device_t *d;

 devid.vid = dev->vendor;
 devid.did = dev->device;
 for (d = ide_pci_chipsets; d->devid.vid && !IDE_PCI_DEVID_EQ(d->devid,
devid); ++d);
 //Ignored by Promise
 if ((dev->vendor==PCI_VENDOR_ID_PROMISE) && ((dev->class
>>8)==PCI_CLASS_STORAGE_RAID))
 {
  printk("%s: ignored FastTrak series by PROMISE.\n", d->name);
  return;
 }

Then, we won't affect other IDE controller or ATA-RAID controllers.
We can provide our ATA-RAID controller's driver by our own.

Hank

> > > The ataraid driver in the standard kernel requires the IDE drive is
seen
> > > by the ide layer otherwise ataraid cannot bind it into a raid module
> >
> > First, the IDE driver doesn't check the controller's class code is raid
> > controller (0x0104) or other controller(0x0180). So If our raid
controller
> > (FastTrak series) be seen by IDE driver. It will snatch the same IRQ.
> > It will cause our trouble.
>
> It wants to. What happens is this
>
> - The IDE layer detects the raid chip
> - We check it isnt a supertrak hardware raid
> - If it isnt we add the chips as basic ide devices
> - The ataraid module loaded on top of those opens the ide disks and
> hunts for promise and hpt raid descriptors
> - When it finds the raid descriptor it creates an additional
> /dev/ataraid/.... device
>
> Because our ataraid driver actually sits on top of the existing IDE
drivers it
> requires they grab the devices. This also allows end users to issue
commands
> directly to the drives (for example for SMART)
>
> Alan

