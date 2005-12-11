Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbVLKFmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbVLKFmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbVLKFmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:42:38 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:53406 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161098AbVLKFmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:42:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=HxRYPN3WtlfDIZsMq/g9x7wGjiA5ugLNPn0pkNSMH1VRjR2dtF6VTPjSC7pxQUZqK9UovFS7fKcXKFbEAB4lM/ui0biMzfD9SoqmmBUmGdUp3mY7wujJ5DPWfpvBEm0Em2CFAgr21U4g+xzp7DGYm5icQ6pcrOSJNsZpvHHUpBI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Reduce nr of ptr derefs in drivers/pci/hotplug/pciehprm_acpi.c
Date: Sun, 11 Dec 2005 06:43:09 +0100
User-Agent: KMail/1.9
Cc: kristen.c.accardi@intel.com, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, greg@kroah.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512110643.10020.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to reduce the nr. of pointer dereferences in
drivers/pci/hotplug/pciehprm_acpi.c

Benefits:
 - micro speed optimization due to fewer pointer derefs
 - generated code is slightly smaller
 - better readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/pci/hotplug/pciehprm_acpi.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

orig:
   text    data     bss     dec     hex filename
   2013       0     256    2269     8dd drivers/pci/hotplug/pciehprm_acpi.o
patched:
   text    data     bss     dec     hex filename
   2002       0     256    2258     8d2 drivers/pci/hotplug/pciehprm_acpi.o

--- linux-2.6.15-rc5-git1-orig/drivers/pci/hotplug/pciehprm_acpi.c	2005-12-04 18:48:04.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/pci/hotplug/pciehprm_acpi.c	2005-12-11 05:27:16.000000000 +0100
@@ -174,7 +174,9 @@ int pciehp_get_hp_hw_control_from_firmwa
 	acpi_status status;
 	acpi_handle chandle, handle = DEVICE_ACPI_HANDLE(&(dev->dev));
 	struct pci_dev *pdev = dev;
+	struct pci_bus *parent;
 	u8 *path_name;
+
 	/*
 	 * Per PCI firmware specification, we should run the ACPI _OSC
 	 * method to get control of hotplug hardware before using it.
@@ -190,17 +192,18 @@ int pciehp_get_hp_hw_control_from_firmwa
 		 */
 		if (!pdev || !pdev->bus->parent)
 			break;
+		parent = pdev->bus->parent;
 		dbg("Could not find %s in acpi namespace, trying parent\n",
 				pci_name(pdev));
-		if (!pdev->bus->parent->self)
+		if (!parent->self)
 			/* Parent must be a host bridge */
 			handle = acpi_get_pci_rootbridge_handle(
-					pci_domain_nr(pdev->bus->parent),
-					pdev->bus->parent->number);
+					pci_domain_nr(parent),
+					parent->number);
 		else
 			handle = DEVICE_ACPI_HANDLE(
-					&(pdev->bus->parent->self->dev));
-		pdev = pdev->bus->parent->self;
+					&(parent->self->dev));
+		pdev = parent->self;
 	}
 
 	while (handle) {



