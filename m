Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUJTSyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUJTSyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUJTSvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:51:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:62690 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268937AbUJTSuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:50:11 -0400
Date: Wed, 20 Oct 2004 11:49:53 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, davej@codemonkey.org.uk
Subject: [RFT 2.6] amd64-agp.c replace pci_find_device with pci_get_device
Message-ID: <15300000.1098298193@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away soon I have converted this file to use
pci_get_device instead. I have compile tested it. If anyone has this hardware
and could test it that would be great.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---

diff -Nrup linux-2.6.9cln/drivers/char/agp/amd64-agp.c linux-2.6.9patch/drivers/char/agp/amd64-agp.c
--- linux-2.6.9cln/drivers/char/agp/amd64-agp.c	2004-10-18 16:35:52.000000000 -0700
+++ linux-2.6.9patch/drivers/char/agp/amd64-agp.c	2004-10-18 16:43:38.000000000 -0700
@@ -355,7 +355,7 @@ static __devinit int cache_nbs (struct p
 	int i = 0;
 
 	/* cache pci_devs of northbridges. */
-	while ((loop_dev = pci_find_device(PCI_VENDOR_ID_AMD, 0x1103, loop_dev))
+	while ((loop_dev = pci_get_device(PCI_VENDOR_ID_AMD, 0x1103, loop_dev))
 			!= NULL) {
 		if (i == MAX_HAMMER_GARTS) {
 			printk(KERN_ERR PFX "Too many northbridges for AGP\n");
@@ -625,6 +625,11 @@ static struct pci_driver agp_amd64_pci_d
 int __init agp_amd64_init(void)
 {
 	int err = 0;
+	static struct pci_device_id amd64nb[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1103) },
+		{ },
+	};
+
 	if (agp_off)
 		return -EINVAL;
 	if (pci_module_init(&agp_amd64_pci_driver) > 0) {
@@ -640,13 +645,13 @@ int __init agp_amd64_init(void)
 		}
 
 		/* First check that we have at least one AMD64 NB */
-		if (!pci_find_device(PCI_VENDOR_ID_AMD, 0x1103, NULL))
+		if (!pci_dev_present(amd64nb))
 			return -ENODEV;
 
 		/* Look for any AGP bridge */
 		dev = NULL;
 		err = -ENODEV;
-		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev))) {
+		for_each_pci_dev(dev) {
 			if (!pci_find_capability(dev, PCI_CAP_ID_AGP))
 				continue;
 			/* Only one bridge supported right now */


