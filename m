Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVCKDt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVCKDt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVCKDob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:44:31 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:42519 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261709AbVCKDjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:39:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=R8w/KKYMEbrqoc89j6m3+QBBMDkeMiY1P/hlcbQo3HIJdG6rU9S1u8uQvxj+aGDmiKRtdQC7QTmN29hWOXdTNRTviyRjyvft5gH44RStu/oZWC8p1qu6sh4od51O7s7Szgnqu6/CqUDRb4T58rnrMuK8AJRcj2VG+2BiNXxT28E=
Message-ID: <9e47339105031019393ce91f60@mail.gmail.com>
Date: Thu, 10 Mar 2005 22:39:10 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pci_fixup_video() bogosity
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <1110266266.13607.264.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110256709.13607.248.camel@gaston>
	 <9e473391050307215776f5c06@mail.gmail.com>
	 <1110266266.13607.264.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to make detection of boot video device more robust. Should I
leave the printk in?

-- 
Jon Smirl
jonsmirl@gmail.com

===== arch/i386/pci/fixup.c 1.24 vs edited =====
--- 1.24/arch/i386/pci/fixup.c	2005-01-11 19:42:41 -05:00
+++ edited/arch/i386/pci/fixup.c	2005-03-10 22:32:35 -05:00
@@ -355,11 +355,12 @@
  * is marked here since the boot video device will be the only enabled
  * video device at this point.
  *
- */static void __devinit pci_fixup_video(struct pci_dev *pdev)
+ */
+static void __devinit pci_fixup_video(struct pci_dev *pdev)
 {
 	struct pci_dev *bridge;
 	struct pci_bus *bus;
-	u16 l;
+	u16 config;
 
 	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
 		return;
@@ -369,12 +370,16 @@
 	while (bus) {
 		bridge = bus->self;
 		if (bridge) {
-			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &l);
-			if (!(l & PCI_BRIDGE_CTL_VGA))
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &config);
+			if (!(config & PCI_BRIDGE_CTL_VGA))
 				return;
 		}
 		bus = bus->parent;
 	}
-	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+	pci_read_config_word(pdev, PCI_COMMAND, &config);
+	if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+		printk(KERN_INFO "Boot video device is %s\n", pci_name(pdev));
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
