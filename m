Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbUL0Plo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbUL0Plo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUL0Plo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:41:44 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46491 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261910AbUL0Plf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:41:35 -0500
Subject: PATCH: 2.6.10 - Incorrect return from PCI ide controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104158258.20952.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 14:37:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several IDE drivers return positive values as errors in the PCI setup
code. Unfortunately the PCI layer considers positive values as success
so the driver skips the device but still claims it and things then go
downhill.

This fixes the IT8172 driver. There are other drivers with this bug (eg
generic) but the -ac IDE is sufficiently diverged from base that someone
else needs to generate/test the more divergent cases.

Alan

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/ide/pci/it8172.c linux-2.6.10/drivers/ide/pci/it8172.c
--- linux.vanilla-2.6.10/drivers/ide/pci/it8172.c	2004-12-25 21:15:34.000000000 +0000
+++ linux-2.6.10/drivers/ide/pci/it8172.c	2004-12-26 17:22:17.577730520 +0000
@@ -270,7 +270,7 @@
 {
         if ((!(PCI_FUNC(dev->devfn) & 1) ||
             (!((dev->class >> 8) == PCI_CLASS_STORAGE_IDE))))
-                return 1; /* IT8172 is more than only a IDE controller */
+                return -EAGAIN; /* IT8172 is more than an IDE controller */
 	ide_setup_pci_device(dev, &it8172_chipsets[id->driver_data]);
 	return 0;
 }

