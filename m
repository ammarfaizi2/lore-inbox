Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269610AbUI3XVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269610AbUI3XVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269612AbUI3XVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:21:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:52113 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269610AbUI3XVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:21:14 -0400
Date: Thu, 30 Sep 2004 16:21:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: CaT <cat@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
In-Reply-To: <20040927084550.GA1134@zip.com.au>
Message-ID: <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org>
References: <20040927084550.GA1134@zip.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Sep 2004, CaT wrote:
>
> I have a Promise PDC20267 card in my desktop and whilst it works
> in 2.6.8-rc2, it no longer functions beginning with at least 2.6.9-rc2.
> Latest kernel I ran is 2.6.9-rc2-bk8 and it was still not available.
> 
> dmesg does mention it though as:
> 
> PDC20267: IDE controller at PCI slot 0000:00:0d.0
> PCI: Found IRQ 11 for device 0000:00:0d.0
> PCI: Unable to reserve I/O region #5:40@1080 for device 0000:00:0d.0

Please send along /proc/ioports for both the working and the non-working 
version (that's assuming that you can boot far enough in the nw version 
to get it, of course, but the nw version is actually the more interesting 
one, so please try ;).

Also, does the attached patch (written by Shaohua Li based on suggestions 
by me) solve the problem? My suspicion is that ACPI tables do bad things, 
and that this might fix it..

		Linus

-----
===== drivers/acpi/motherboard.c 1.2 vs edited =====
--- 1.2/drivers/acpi/motherboard.c	2004-08-04 11:12:54 +08:00
+++ edited/drivers/acpi/motherboard.c	2004-08-31 11:28:27 +08:00
@@ -170,4 +170,8 @@ static int __init acpi_motherboard_init(
 	return 0;
 }
 
-subsys_initcall(acpi_motherboard_init);
+/**
+ * Reserve motherboard resources after PCI claim BARs,
+ * but before PCI assign resources for uninitialized PCI devices
+ */
+fs_initcall(acpi_motherboard_init);
===== drivers/pnp/system.c 1.10 vs edited =====
--- 1.10/drivers/pnp/system.c	2004-03-21 00:38:56 +08:00
+++ edited/drivers/pnp/system.c	2004-08-31 11:29:35 +08:00
@@ -104,4 +104,8 @@ static int __init pnp_system_init(void)
 	return pnp_register_driver(&system_pnp_driver);
 }
 
-subsys_initcall(pnp_system_init);
+/**
+ * Reserve motherboard resources after PCI claim BARs,
+ * but before PCI assign resources for uninitialized PCI devices
+ */
+fs_initcall(pnp_system_init);
===== arch/i386/pci/i386.c 1.17 vs edited =====
--- 1.17/arch/i386/pci/i386.c	2004-08-25 14:35:30 +08:00
+++ edited/arch/i386/pci/i386.c	2004-08-31 11:34:29 +08:00
@@ -164,7 +164,7 @@ static void __init pcibios_allocate_reso
 	}
 }
 
-static void __init pcibios_assign_resources(void)
+static int __init pcibios_assign_resources(void)
 {
 	struct pci_dev *dev = NULL;
 	int idx;
@@ -204,6 +204,7 @@ static void __init pcibios_assign_resour
 				pci_assign_resource(dev, PCI_ROM_RESOURCE);
 		}
 	}
+	return 0;
 }
 
 void __init pcibios_resource_survey(void)
@@ -212,8 +213,13 @@ void __init pcibios_resource_survey(void
 	pcibios_allocate_bus_resources(&pci_root_buses);
 	pcibios_allocate_resources(0);
 	pcibios_allocate_resources(1);
-	pcibios_assign_resources();
 }
+
+/**
+ * called in fs_initcall (one below subsys_initcall),
+ * give a chance for motherboard reserve resources
+ */
+fs_initcall(pcibios_assign_resources);
 
 int pcibios_enable_resources(struct pci_dev *dev, int mask)
 {
