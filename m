Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130765AbRA2VtF>; Mon, 29 Jan 2001 16:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130761AbRA2Vsz>; Mon, 29 Jan 2001 16:48:55 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:15216
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129396AbRA2Vsq>; Mon, 29 Jan 2001 16:48:46 -0500
Date: Mon, 29 Jan 2001 22:48:38 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: lnz@dandelion.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/BusLogic.c: No resource probing before pci_enable_device (241p11)
Message-ID: <20010129224838.I603@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/BusLogic.c wait with probing
pdev->irq and pdev->resource[] until we call pci_enable_device. This
is recommended due to hot-plug considerations (according to Jeff Garzik).

It applies against ac12 and 241p11.

Comments?


--- linux-ac12-clean/drivers/scsi/BusLogic.c	Sat Jan 27 21:16:24 2001
+++ linux-ac12/drivers/scsi/BusLogic.c	Sat Jan 27 21:32:33 2001
@@ -770,15 +770,19 @@
       BusLogic_ModifyIOAddressRequest_T ModifyIOAddressRequest;
       unsigned char Bus = PCI_Device->bus->number;
       unsigned char Device = PCI_Device->devfn >> 3;
-      unsigned int IRQ_Channel = PCI_Device->irq;
-      unsigned long BaseAddress0 = pci_resource_start(PCI_Device, 0);
-      unsigned long BaseAddress1 = pci_resource_start(PCI_Device, 1);
-      BusLogic_IO_Address_T IO_Address = BaseAddress0;
-      BusLogic_PCI_Address_T PCI_Address = BaseAddress1;
+      unsigned int IRQ_Channel;
+      unsigned long BaseAddress0;
+      unsigned long BaseAddress1;
+      BusLogic_IO_Address_T IO_Address;
+      BusLogic_PCI_Address_T PCI_Address;
 
       if (pci_enable_device(PCI_Device))
       	continue;
       
+      IRQ_Channel = PCI_Device->irq;
+      IO_Address  = BaseAddress0 = pci_resource_start(PCI_Device, 0);
+      PCI_Address = BaseAddress1 = pci_resource_start(PCI_Device, 1);
+
       if (pci_resource_flags(PCI_Device, 0) & IORESOURCE_MEM)
 	{
 	  BusLogic_Error("BusLogic: Base Address0 0x%X not I/O for "

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"The obvious mathematical breakthrough would be development of an easy way
to factor large prime numbers." 
  -- Bill Gates, The Road Ahead, Viking Penguin (1995)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
