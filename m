Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUEVPrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUEVPrI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUEVPrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:47:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261426AbUEVPrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:47:04 -0400
Date: Sat, 22 May 2004 11:46:59 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com, akpm@osdl.org
Subject: PATCH: Stop megaraid trashing other i960 based devices
Message-ID: <20040522154659.GA17320@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4 the megaraid driver was careful to avoid stepping on wrong devices.
Specifically the megaraid3 series devices used an intel pci ID (8086:1960)
which is the generic i960 identifier not their own.

The code to do this in 2.4 worked for almost all cases, but even that
code has mysteriously vanished in 2.6 meaning the megaraid driver trashes
stuff like promise i2o cards and compaq management cards.

The following patch puts back the 2.4 stuff + one additional check so that
the driver isn't quite as rude as it was before.


--- drivers/scsi/megaraid.c~	2004-05-22 16:34:01.976198176 +0100
+++ drivers/scsi/megaraid.c	2004-05-22 16:38:58.176168936 +0100
@@ -4609,6 +4609,21 @@
 
 	pci_bus = pdev->bus->number;
 	pci_dev_func = pdev->devfn;
+	
+	if(pdev->vendor == PCI_VENDOR_ID_INTEL)		/* The megaraid3 stuff reports the id of the intel
+							   part which is not remotely specific to the megaraid */
+	{
+		u16 magic;
+		/* Don't fall over the Compaq management cards using the same PCI identifier */
+		if(pdev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ &&
+		   pdev->subsystem_device == 0xC000)
+		   	return -ENODEV;
+		/* Now check the magic signature byte */
+		pci_read_config_word(pdev, PCI_CONF_AMISIG, &magic);
+		if(magic != HBA_SIGNATURE_471 && magic != HBA_SIGNATURE)
+			return -ENODEV;
+		/* Ok it is probably a megaraid */
+	}
 
 	/*
 	 * For these vendor and device ids, signature offsets are not
