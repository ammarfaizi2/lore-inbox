Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267056AbRGIMzI>; Mon, 9 Jul 2001 08:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbRGIMy7>; Mon, 9 Jul 2001 08:54:59 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:40643 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267056AbRGIMym>; Mon, 9 Jul 2001 08:54:42 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 9 Jul 2001 05:54:43 -0700
Message-Id: <200107091254.FAA26244@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Based on the advice and testing of Bob Dunlop, Alexander Griesser,
arjan@fenrus.demon.nl, and Stelian Pop, here is a modified sonpypi.c
patch that detects Sony Vaio computers by requiring a Cardbus bridge
that has a subsystem vendor ID of Sony, rather than just any PCI device.
This should avoid erroneous(?) installation and (possible hangs?) from
this module on Sony desktop machines, although this may break if Sony
decides to make a PCI-to-Cardbus bridge card and puts its vendor ID
in the subsystem vendor ID of that device.

	I've tried this code on a machine that is a Sony Vaio
notebook computer and one that is not, and it gets it right in
both cases.

	I am interested in figuring out a more perfect test, but,
in all cases, this patch should be better than the current 2.4.7-pre3
tree and the earlier patches that Bob and I have posted, so it would
be fine to apply it now.  (In particular, I am following the discussion
about using "DMI tables"--something I'm not familiar with--but I have
to leave for a two day trip in a few hours.)

	Anyhow, I hope this patch is helpful.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--- linux-2.4.7-pre3/drivers/char/sonypi.c	Mon Jul  9 05:32:41 2001
+++ linux/drivers/char/sonypi.c	Mon Jul  9 05:30:22 2001
@@ -689,8 +689,23 @@
 	remove:		sonypi_remove,
 };
 
+static int __init sony_notebook(void) {
+	struct pci_dev *dev;
+
+	dev = NULL;
+	while ((dev = pci_find_class(PCI_CLASS_BRIDGE_CARDBUS, NULL)) != NULL){
+		if (dev->subsystem_vendor == PCI_VENDOR_ID_SONY)
+			return 1;
+	}
+
+	return 0;
+}
+
 static int __init sonypi_init_module(void) {
-	return pci_module_init(&sonypi_driver);
+	if (sony_notebook())
+		return pci_module_init(&sonypi_driver);
+	else
+		return -ENODEV;
 }
 
 static void __exit sonypi_cleanup_module(void) {
