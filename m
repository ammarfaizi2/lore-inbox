Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUGGUw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUGGUw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265484AbUGGUwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:52:17 -0400
Received: from aun.it.uu.se ([130.238.12.36]:37298 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265483AbUGGUvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:51:31 -0400
Date: Wed, 7 Jul 2004 22:51:23 +0200 (MEST)
Message-Id: <200407072051.i67KpNxa019744@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.27-rc3] cardbus.c pointer truncation bug on 64-bitters
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4 kernel's drivers/pcmcia/cardbus.c generates this compilation warning:

cardbus.c:239: warning: implicit declaration of function `pci_scan_device_Raceae718'
cardbus.c:239: warning: assignment makes pointer from integer without a cast

pci_scan_device() returns pci_dev*, but has no prototype in <linux/pci.h>.
At the call site in cardbus.c (the only one not in pci.c), the compiler
must assume an 'int' return value and store that in a pci_dev* variable.
On a 64-bit machine with 32-bit int, this destroys the high 32 bits of
the original pointer.

Trivial fix for 2.4.27-rc3 below.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -ruN linux-2.4.27-rc3/include/linux/pci.h linux-2.4.27-rc3.cardbus-64bit-fix/include/linux/pci.h
--- linux-2.4.27-rc3/include/linux/pci.h	2004-07-07 21:45:19.000000000 +0200
+++ linux-2.4.27-rc3.cardbus-64bit-fix/include/linux/pci.h	2004-07-07 21:48:53.000000000 +0200
@@ -595,6 +595,7 @@
 int pci_bus_exists(const struct list_head *list, int nr);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_alloc_primary_bus(int bus);
+struct pci_dev *pci_scan_device(struct pci_dev *temp);
 struct pci_dev *pci_scan_slot(struct pci_dev *temp);
 int pci_proc_attach_device(struct pci_dev *dev);
 int pci_proc_detach_device(struct pci_dev *dev);
