Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754096AbWKGH4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbWKGH4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 02:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754095AbWKGH4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 02:56:13 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48353
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1754096AbWKGH4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 02:56:12 -0500
Date: Mon, 06 Nov 2006 23:55:41 -0800 (PST)
Message-Id: <20061106.235541.74749213.davem@davemloft.net>
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH]: Fix PCI sysfs file deletion
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The PCI sysfs attributes are created after the initial PCI
bus scan.  With the addition of more return value checking
and assertions in the device and sysfs layers we now can
get dumps like this on sparc64:

[   20.135032] Call Trace:
[   20.135042]  [0000000000537f88] pci_remove_bus_device+0x30/0xc0
[   20.135076]  [000000000078f890] pci_fill_in_pbm_cookies+0x98/0x440
[   20.135109]  [000000000042e828] sabre_scan_bus+0x230/0x400
[   20.135139]  [000000000078c710] pcibios_init+0x58/0xa0
[   20.135159]  [0000000000416f14] init+0x9c/0x2e0
[   20.135190]  [0000000000417a50] kernel_thread+0x38/0x60
[   20.135211]  [0000000000417170] rest_init+0x18/0x40
[   20.135514] PCI0(PBMB): Bus running at 33MHz

It's triggering because removal of the "config" PCI sysfs
file for the device fails.

On sparc64, after probing the device, we'll delete the PCI
device via pci_remove_bus_device() if we cannot find the firmware
device tree node corresponding to it.

This is fine, but at this point the sysfs files for the PCI device
won't be setup yet.

So we should not try to do anything in pci_remove_sysfs_dev_files()
if pci_sysfs_init() has not run yet.

Greg, please apply and push to Linus.  Thanks a lot!

[PCI]: Don't try to remove sysfs files before they are setup.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a1d2e97..f952bfe 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -642,6 +642,9 @@ err:
  */
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
+	if (!sysfs_initialized)
+		return;
+
 	if (pdev->cfg_size < 4096)
 		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
