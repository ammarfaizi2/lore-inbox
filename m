Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbUL3AJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUL3AJl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUL3AJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:09:41 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:61829 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261454AbUL3AIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:08:52 -0500
Date: Thu, 30 Dec 2004 01:04:55 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.10-bk1 2/5] pci-ide: clean up error path in do_ide_setup_pci_device
Message-ID: <20041230000455.GA2217@electric-eye.fr.zoreil.com>
References: <1104158258.20952.44.camel@localhost.localdomain> <20041228205553.GA18525@electric-eye.fr.zoreil.com> <58cb370e04122813152759d94f@mail.gmail.com> <20041230000302.GA4267@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230000302.GA4267@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up error path in do_ide_setup_pci_device.

ide_setup_pci_controller() puts the device in a PCI enabled state.
The patch adds a small helper to balance it when things go wrong.

Actually the helper does not *exactly* balance the setup: if it can
not do a better job, ide_setup_pci_controller() may only enable some
BARS whereas the new counterpart will try to disable everything.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/ide/setup-pci.c~ata-020 drivers/ide/setup-pci.c
--- linux-2.6.10-bk1/drivers/ide/setup-pci.c~ata-020	2004-12-29 23:42:44.511302710 +0100
+++ linux-2.6.10-bk1-romieu/drivers/ide/setup-pci.c	2004-12-29 23:42:44.514302222 +0100
@@ -542,6 +542,13 @@ static int ide_setup_pci_controller(stru
 	return 0;
 }
 
+static void ide_release_pci_controller(struct pci_dev *dev, ide_pci_device_t *d,
+				       int noisy)
+{
+	/* Balance ide_pci_enable() */
+	pci_disable_device(dev);
+}
+
 /**
  *	ide_pci_setup_ports	-	configure ports/devices on PCI IDE
  *	@dev: PCI device
@@ -672,7 +679,7 @@ static int do_ide_setup_pci_device (stru
 		 */
 		ret = d->init_chipset ? d->init_chipset(dev, d->name) : 0;
 		if (ret < 0)
-			goto out;
+			goto err_release_pci_controller;
 		pciirq = ret;
 	} else if (tried_config) {
 		if (noisy)
@@ -687,7 +694,7 @@ static int do_ide_setup_pci_device (stru
 		if (d->init_chipset) {
 			ret = d->init_chipset(dev, d->name);
 			if (ret < 0)
-				goto out;
+				goto err_release_pci_controller;
 		}
 		if (noisy)
 #ifdef __sparc__
@@ -705,6 +712,10 @@ static int do_ide_setup_pci_device (stru
 	ide_pci_setup_ports(dev, d, pciirq, index);
 out:
 	return ret;
+
+err_release_pci_controller:
+	ide_release_pci_controller(dev, d, noisy);
+	goto out;
 }
 
 int ide_setup_pci_device (struct pci_dev *dev, ide_pci_device_t *d)

_
