Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUEZVqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUEZVqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 17:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbUEZVqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 17:46:05 -0400
Received: from fmr06.intel.com ([134.134.136.7]:14239 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265823AbUEZVpP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 17:45:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Resume enhancement: restore pci config space 
Date: Wed, 26 May 2004 14:44:37 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730182B53A@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Resume enhancement: restore pci config space 
thread-index: AcRDYaNIxfCYKUcrRcaRaFrdYZpPQwABhY5Q
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Arjan van de Ven" <arjanv@redhat.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Cc: "linux-acpi" <linux-acpi@intel.com>
X-OriginalArrivalTime: 26 May 2004 21:44:38.0916 (UTC) FILETIME=[A5202C40:01C4436A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Arjan van de Ven
>Sent: Wednesday, May 26, 2004 1:35 PM
>To: greg@kroah.com; linux-kernel@vger.kernel.org
>Subject: Resume enhancement: restore pci config space
>
>Hi,
>
>The patch below enhances the PCI layer with 2 things
>1) enable and busmaster state are stored in the pci device struct
>2) pci config space is stored to the pci device struct
>
>with that, it is possible to make a generic pci resume method that
restores
>config space and reenables the device, including busmaster when
appropriate.
>
>One can rightfully argue that the driver resume method should do this,
and
>yes that is right. So the patch only does it for devices that don't
have a
>resume method. Like the main PCI bridge on my testbox of which the bios
so
>nicely forgets to restore the bus master bit during resume.. With this
>patch
>my testbox resumes just fine while it, well, wasn't all too happy as
you
>can
>imagine without a busmaster pci bridge.
>
>Comments?

Arjan, Hi

We need this kind of functionality in the kernel to get suspend/resume
work, because the BIOS resets the PCI config spaces as they were at the
initial boot upon resume. Actually we've been working on issue too, and
glad to see the code ;-). Whatever changes (e.g. BARs, bridge settings)
the kernel (or driver) made after the boot, need to be restored by the
kernel. 

I'll ask the ACPI team if this fixes, for example,
http://bugme.osdl.org/show_bug.cgi?id=2467

Jun
>
>
>Greetings,
>   Arjan van de Ven
>
>
>diff -urNp linux-1100/drivers/pci/pci.c linux-1110/drivers/pci/pci.c
>--- linux-1100/drivers/pci/pci.c
>+++ linux-1110/drivers/pci/pci.c
>@@ -385,6 +385,7 @@ pci_enable_device_bars(struct pci_dev *d
> int
> pci_enable_device(struct pci_dev *dev)
> {
>+	dev->is_enabled = 1;
> 	return pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) -
1);
> }
>
>@@ -399,6 +400,9 @@ void
> pci_disable_device(struct pci_dev *dev)
> {
> 	u16 pci_command;
>+
>+	dev->is_enabled = 0;
>+	dev->is_busmaster = 0;
>
> 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> 	if (pci_command & PCI_COMMAND_MASTER) {
>@@ -601,6 +605,7 @@ pci_set_master(struct pci_dev *dev)
> 		cmd |= PCI_COMMAND_MASTER;
> 		pci_write_config_word(dev, PCI_COMMAND, cmd);
> 	}
>+	dev->is_busmaster = 1;
> 	pcibios_set_master(dev);
> }
>
>diff -urNp linux-1100/drivers/pci/pci-driver.c
linux-1110/drivers/pci/pci-
>driver.c
>--- linux-1100/drivers/pci/pci-driver.c
>+++ linux-1110/drivers/pci/pci-driver.c
>@@ -299,10 +299,30 @@ static int pci_device_suspend(struct dev
> {
> 	struct pci_dev * pci_dev = to_pci_dev(dev);
> 	struct pci_driver * drv = pci_dev->driver;
>+	int i = 0;
>
> 	if (drv && drv->suspend)
>-		return drv->suspend(pci_dev,state);
>-	return 0;
>+		i = drv->suspend(pci_dev,state);
>+
>+	pci_save_state(pci_dev, pci_dev->saved_config_space);
>+	return i;
>+}
>+
>+
>+/*
>+ * Default resume method for devices that have no driver provided
resume,
>+ * or not even a driver at all.
>+ */
>+static void pci_default_resume(struct pci_dev *pci_dev)
>+{
>+	/* restore the PCI config space */
>+	pci_restore_state(pci_dev, pci_dev->saved_config_space);
>+	/* if the device was enabled before suspend, reenable */
>+	if (pci_dev->is_enabled)
>+		pci_enable_device(pci_dev);
>+	/* if the device was busmaster before the suspend, make it
busmaster
>again */
>+	if (pci_dev->is_busmaster)
>+		pci_set_master(pci_dev);
> }
>
> static int pci_device_resume(struct device * dev)
>@@ -312,6 +332,8 @@ static int pci_device_resume(struct devi
>
> 	if (drv && drv->resume)
> 		drv->resume(pci_dev);
>+	else
>+		pci_default_resume(pci_dev);
> 	return 0;
> }
>
>diff -urNp linux-1100/include/linux/pci.h
linux-1110/include/linux/pci.h
>--- linux-1100/include/linux/pci.h
>+++ linux-1110/include/linux/pci.h
>@@ -488,6 +488,11 @@ struct pci_dev {
> 	/* These fields are used by common fixups */
> 	unsigned int	transparent:1;	/* Transparent PCI bridge */
> 	unsigned int	multifunction:1;/* Part of multi-function device
*/
>+	/* keep track of device state */
>+	unsigned int	is_enabled:1;	/* pci_enable_device has been
>called */
>+	unsigned int	is_busmaster:1; /* device is busmaster */
>+
>+	unsigned int 	saved_config_space[16]; /* config space saved at
>suspend time */
> #ifdef CONFIG_PCI_NAMES
> #define PCI_NAME_SIZE	96
> #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop
>*/
