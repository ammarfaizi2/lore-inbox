Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbUKOIg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbUKOIg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 03:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUKOIg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 03:36:57 -0500
Received: from fmr17.intel.com ([134.134.136.16]:716 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261547AbUKOIgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 03:36:53 -0500
Subject: [PATCH]eepro100 resume failure
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Content-Type: multipart/mixed; boundary="=-IkgCgEdgkSGkBHO5rKjK"
Message-Id: <1100507449.31599.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 15 Nov 2004 16:30:50 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IkgCgEdgkSGkBHO5rKjK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
After resume from S3, eepro100 driver reported some errors and stop working in my Toshiba
laptop. Below patch fixes it.

Thanks,
Shaohua


Signed-off-by: Li Shaohua<shaohua.li@intel.com>
---

 2.6-root/drivers/net/eepro100.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/net/eepro100.c~eepro100-pm drivers/net/eepro100.c
--- 2.6/drivers/net/eepro100.c~eepro100-pm	2004-11-15 16:06:22.500880880 +0800
+++ 2.6-root/drivers/net/eepro100.c	2004-11-15 16:16:43.057541928 +0800
@@ -2327,7 +2327,7 @@ static int eepro100_suspend(struct pci_d
 	netif_device_detach(dev);
 	outl(PortPartialReset, ioaddr + SCBPort);
 	
-	/* XXX call pci_set_power_state ()? */
+	pci_set_power_state (pdev, 3);
 	return 0;
 }
 
@@ -2337,7 +2337,12 @@ static int eepro100_resume(struct pci_de
 	struct speedo_private *sp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
+	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
+	if (pdev->is_enabled)
+		pci_enable_device(pdev);
+	if (pdev->is_busmaster)
+		pci_set_master(pdev);
 
 	if (!netif_running(dev))
 		return 0;
_


--=-IkgCgEdgkSGkBHO5rKjK
Content-Disposition: attachment; filename=eepro100-pm.patch
Content-Type: text/x-patch; name=eepro100-pm.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit



---

 2.6-root/drivers/net/eepro100.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/net/eepro100.c~eepro100-pm drivers/net/eepro100.c
--- 2.6/drivers/net/eepro100.c~eepro100-pm	2004-11-15 16:06:22.500880880 +0800
+++ 2.6-root/drivers/net/eepro100.c	2004-11-15 16:16:43.057541928 +0800
@@ -2327,7 +2327,7 @@ static int eepro100_suspend(struct pci_d
 	netif_device_detach(dev);
 	outl(PortPartialReset, ioaddr + SCBPort);
 	
-	/* XXX call pci_set_power_state ()? */
+	pci_set_power_state (pdev, 3);
 	return 0;
 }
 
@@ -2337,7 +2337,12 @@ static int eepro100_resume(struct pci_de
 	struct speedo_private *sp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
+	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
+	if (pdev->is_enabled)
+		pci_enable_device(pdev);
+	if (pdev->is_busmaster)
+		pci_set_master(pdev);
 
 	if (!netif_running(dev))
 		return 0;
_

--=-IkgCgEdgkSGkBHO5rKjK--

