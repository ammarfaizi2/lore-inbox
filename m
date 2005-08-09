Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVHIQGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVHIQGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVHIQGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:06:25 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:9092 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S964843AbVHIQGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:06:23 -0400
Date: Tue, 9 Aug 2005 18:06:19 +0200
Message-Id: <200508091606.j79G6JM0014337@wscnet.wsc.cz>
Subject: Re: [PATCH -mm] removes pci_find_device from i6300esb.c
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>
In-reply-to: <20050809055910.GB11457@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/05, Greg KH <greg@kroah.com> wrote:
> So, care to resend all of your pci changes, including the documentation
> ones, to me?
Sure:

This removes very old functions from pci docs, which aren't no longer in the
kernel.

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt
+++ b/Documentation/pci.txt
@@ -266,20 +266,6 @@ port an old driver to the new PCI interf
 in the kernel as they aren't compatible with hotplug or PCI domains or
 having sane locking.
 
-pcibios_present() and		Since ages, you don't need to test presence
-pci_present()			of PCI subsystem when trying to talk to it.
-				If it's not there, the list of PCI devices
-				is empty and all functions for searching for
-				devices just return NULL.
-pcibios_(read|write)_*		Superseded by their pci_(read|write)_*
-				counterparts.
-pcibios_find_*			Superseded by their pci_get_* counterparts.
-pci_for_each_dev()		Superseded by pci_get_device()
-pci_for_each_dev_reverse()	Superseded by pci_find_device_reverse()
-pci_for_each_bus()		Superseded by pci_find_next_bus()
 pci_find_device()		Superseded by pci_get_device()
 pci_find_subsys()		Superseded by pci_get_subsys()
 pci_find_slot()			Superseded by pci_get_slot()
-pcibios_find_class()		Superseded by pci_get_class()
-pci_find_class()		Superseded by pci_get_class()
-pci_(read|write)_*_nodev()	Superseded by pci_bus_(read|write)_*()
------------------
This patch changes pci_find_device to pci_get_device (encapsulated in
for_each_pci_dev) in i6300esb watchdog card with appropriate adding pci_dev_put.

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/drivers/char/watchdog/i6300esb.c b/drivers/char/watchdog/i6300esb.c
--- a/drivers/char/watchdog/i6300esb.c
+++ b/drivers/char/watchdog/i6300esb.c
@@ -368,12 +368,11 @@ static unsigned char __init esb_getdevic
          *      Find the PCI device
          */
 
-        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+        for_each_pci_dev(dev)
                 if (pci_match_id(esb_pci_tbl, dev)) {
                         esb_pci = dev;
                         break;
                 }
-        }
 
         if (esb_pci) {
         	if (pci_enable_device(esb_pci)) {
@@ -430,6 +429,7 @@ err_release:
 		pci_release_region(esb_pci, 0);
 err_disable:
 		pci_disable_device(esb_pci);
+		pci_dev_put(esb_pci);
 	}
 out:
 	return 0;
@@ -481,6 +481,7 @@ err_unmap:
 	pci_release_region(esb_pci, 0);
 /* err_disable: */
 	pci_disable_device(esb_pci);
+	pci_dev_put(esb_pci);
 /* out: */
         return ret;
 }
@@ -497,6 +498,7 @@ static void __exit watchdog_cleanup (voi
 	iounmap(BASEADDR);
 	pci_release_region(esb_pci, 0);
 	pci_disable_device(esb_pci);
+	pci_dev_put(esb_pci);
 }
 
 module_init(watchdog_init);
------------------
This patch changes pci_find_device to pci_get_device (encapsulated in
for_each_pci_dev).

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -3007,7 +3007,7 @@ static int __init parport_pc_init_superi
 	struct pci_dev *pdev = NULL;
 	int ret = 0;
 
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+	for_each_pci_dev(pdev) {
 		id = pci_match_id(parport_pc_pci_tbl, pdev);
 		if (id == NULL || id->driver_data >= last_sio)
 			continue;
------------------ [this was refused by you:]
This marks these functions as deprecated not to use in latest drivers (it
doesn't use reference counts and the device returned by it can disappear in
any time).

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -328,9 +328,11 @@ void pci_setup_cardbus(struct pci_bus *b
 
 /* Generic PCI functions exported to card drivers */
 
-struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
+struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device,
+	const struct pci_dev *from) __deprecated;
 struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
-struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
+struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn)
+	__deprecated;
 int pci_find_capability (struct pci_dev *dev, int cap);
 int pci_find_ext_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
