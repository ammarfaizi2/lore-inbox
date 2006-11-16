Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162265AbWKPCse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162265AbWKPCse (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162261AbWKPCr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:47:57 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8328 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162259AbWKPCrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:47:19 -0500
Message-Id: <20061116024825.903082000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:56 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, maks@sternwelten.at,
       David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 24/30] pci: dont try to remove sysfs files before they are setup.
Content-Disposition: inline; filename=pci-don-t-try-to-remove-sysfs-files-before-they-are-setup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

The PCI sysfs attributes are created after the initial PCI bus scan.  With
the addition of more return value checking and assertions in the device and
sysfs layers we now can get dumps like this on sparc64:

[   20.135032] Call Trace:
[   20.135042]  [0000000000537f88] pci_remove_bus_device+0x30/0xc0
[   20.135076]  [000000000078f890] pci_fill_in_pbm_cookies+0x98/0x440
[   20.135109]  [000000000042e828] sabre_scan_bus+0x230/0x400
[   20.135139]  [000000000078c710] pcibios_init+0x58/0xa0
[   20.135159]  [0000000000416f14] init+0x9c/0x2e0
[   20.135190]  [0000000000417a50] kernel_thread+0x38/0x60
[   20.135211]  [0000000000417170] rest_init+0x18/0x40
[   20.135514] PCI0(PBMB): Bus running at 33MHz

It's triggering because removal of the "config" PCI sysfs file for the
device fails.

On sparc64, after probing the device, we'll delete the PCI device via
pci_remove_bus_device() if we cannot find the firmware device tree node
corresponding to it.

This is fine, but at this point the sysfs files for the PCI device won't be
setup yet.

So we should not try to do anything in pci_remove_sysfs_dev_files() if
pci_sysfs_init() has not run yet.

Signed-off-by: David S. Miller <davem@davemloft.net>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/pci/pci-sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.18.2.orig/drivers/pci/pci-sysfs.c
+++ linux-2.6.18.2/drivers/pci/pci-sysfs.c
@@ -571,6 +571,9 @@ int pci_create_sysfs_dev_files (struct p
  */
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
+	if (!sysfs_initialized)
+		return;
+
 	if (pdev->cfg_size < 4096)
 		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else

--
