Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWDTOFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWDTOFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWDTOFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:05:20 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:38671 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750755AbWDTOFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:05:20 -0400
Message-ID: <4447A2E7.6000407@brothom.nl>
Date: Thu, 20 Apr 2006 16:04:07 +0100
From: Bert Thomas <bert@brothom.nl>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI device driver writing newbie trouble
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-BroThom-MailScanner: Found to be clean
X-BroThom-MailScanner-From: bert@brothom.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm attempting to write a PCI device driver. I've read chapters 2, 9 and 
12 of the linux device driver book (3rd ed) and it got me going with the 
code below. However, I never see the message printed from cif50_probe, 
so appearantly the kernel doesn't consider my driver the correct driver 
for the hardware.

I tried to load the driver with insmod, but I also rebooted the system 
in the hope that some part of the kernel would find the hardware and try 
to load my driver. Is that how it is supposed to work? At least my 
driver is listed in /lib/modules/2.6.15.7/modules.pcimap. Modprobe 
doesn't find it, I don't know why. The hardware contains a PLX chip. The 
hardware is found by the kernel, as it correctly shows up in /proc/pci:

   Bus  1, device  13, function  0:
     Class 0680: PCI device 10b5:9050 (rev 1).
       IRQ 5.
       Non-prefetchable 32 bit memory at 0xd1005000 [0xd100507f].
       I/O at 0xd100 [0xd17f].
       Non-prefetchable 32 bit memory at 0xd1000000 [0xd1001fff].

Also in the corresponding /sys files.

Does anyone have a suggestion why my probe function is not being called?

TIA
Bert

#include <linux/init.h>
#include <linux/module.h>
#include <linux/pci.h>
MODULE_LICENSE("Dual BSD/GPL");

static const struct pci_device_id cif50_ids[] = {
         {
         .vendor = 0x10B5,
         .device = 0x9050,
         .subvendor = PCI_ANY_ID, //0x10B5,
         .subdevice = PCI_ANY_ID, //0x1080,
         .class = PCI_ANY_ID,
         .class_mask = PCI_ANY_ID
         },
         { 0 }
};

MODULE_DEVICE_TABLE(pci,cif50_ids);

int cif50_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
   printk("<1>Joehoe, de kernel wil me een PCI device geven!\n");
   return -1;
}

void cif50_remove(struct pci_dev *dev)
{
}

static struct pci_driver pci_driver = {
         .name = "cif50pb",
         .id_table = cif50_ids,
         .probe = cif50_probe,
         .remove = cif50_remove,
};
static int hello_init(void)
{
   printk("<1>Hello, world\n");
   return pci_register_driver(&pci_driver);
}
static void hello_exit(void)
{
   printk("<1>Goodbye cruel world\n");
   pci_unregister_driver(&pci_driver);
}
module_init(hello_init);
module_exit(hello_exit);
