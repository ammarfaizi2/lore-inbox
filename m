Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTIBCHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTIBCHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:07:39 -0400
Received: from fmr09.intel.com ([192.52.57.35]:17904 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S263415AbTIBCHf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:07:35 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
Date: Mon, 1 Sep 2003 19:07:32 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AEF1@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
Thread-Index: AcNw9vcGEX0NIHPkTdSPEsCpJrYoWw==
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Pawel Dziekonski" <pawel.dziekonski@pwr.wroc.pl>,
       <linux-kernel@vger.kernel.org>
Cc: "linux-acpi" <linux-acpi@intel.com>
X-OriginalArrivalTime: 02 Sep 2003 02:07:33.0467 (UTC) FILETIME=[F8C8A2B0:01C370F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try the following patch that I sent out the other day? I saw
this message when I was debugging, and it's gone with the patch. I
assume you have ACPI enabled.

Thanks,
Jun

> -----Original Message-----
> From: Pawel Dziekonski [mailto:pawel.dziekonski@pwr.wroc.pl]
> Sent: Monday, September 01, 2003 8:36 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
> 
> On nie, 31 sie 2003 at 04:11:25  +0200, Pawel Dziekonski wrote:
> > Hi,
> >
> > clean 2.4.22-ac1, load of usb-uhci.o locks my machine hard :-(
> > it was working OK with 2.4.22-rc2-ac2! machine is on KT133 chipset.
> > I cant use plain 2.4.22 because of trouble of compiling it with XFS
> > support (unofficial patch has no .config entries).
> 
> update: i have compiled usbcore and usb-uhci into the kernel
> and now it hangs with:
> spurious 8259A interrupt: IRQ7
> 
> anybody?
> --
> Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS
avatar:0:0:
> Wroclaw Networking & Supercomputing Center, HPC Department
> -> See message headers for privacy policy info.
> -
---
diff -ru /build/orig/linux-2.4.23-pre1/drivers/acpi/pci_link.c
linux-2.4.23-pre1/drivers/acpi/pci_link.c
--- /build/orig/linux-2.4.23-pre1/drivers/acpi/pci_link.c
2003-08-25 04:44:41.000000000 -0700
+++ linux-2.4.23-pre1/drivers/acpi/pci_link.c	2003-08-29
20:21:13.000000000 -0700
@@ -216,7 +216,6 @@
 	return AE_CTRL_TERMINATE;
 }
 
-
 static int
 acpi_pci_link_get_current (
 	struct acpi_pci_link	*link)
@@ -275,6 +274,26 @@
 	return_VALUE(result);
 }
 
+static int
+acpi_pci_link_try_get_current (
+	struct acpi_pci_link *link,
+	int irq)
+{
+	int result;
+
+	result = acpi_pci_link_get_current(link);
+	if (result && link->irq.active) {
+ 		return_VALUE(result);
+ 	}
+
+	if (!link->irq.active) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No active IRQ resource
found\n"));
+		printk(KERN_WARNING "_CRS returns NULL! Using IRQ %d for
device (%s [%s]).\n", irq, acpi_device_name(link->device),
acpi_device_bid(link->device));
+		link->irq.active = irq;
+	}
+	
+	return 0;
+}
 
 static int
 acpi_pci_link_set (
@@ -359,7 +378,7 @@
 	}
 
 	/* Make sure the active IRQ is the one we requested. */
-	result = acpi_pci_link_get_current(link);
+	result = acpi_pci_link_try_get_current(link, irq);
 	if (result) {
 		return_VALUE(result);
 	}
@@ -573,10 +592,6 @@
 		else
 			printk(" %d", link->irq.possible[i]);
 	}
-	if (!link->irq.active)
-		printk(", disabled");
-	else if (!found)
-		printk(", enabled at IRQ %d", link->irq.active);
 	printk(")\n");
 
 	/* TBD: Acquire/release lock */


