Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUFPVDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUFPVDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUFPVDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:03:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39844 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266349AbUFPU5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:57:37 -0400
Date: Wed, 16 Jun 2004 16:57:17 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: PATCH: 2.6.7 still hangs on boot with many i960 based boards
Message-ID: <20040616205717.GA10995@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of a patch from before. Without it the megaraid driver
crashes compaq management cards, Symbios FC920 fibre channel cards, Promise
Supertrak 100 IDE and the list continues. 

This replaces essential code from the 2.4 tree that went walkies breaking
everyone elses hardware.


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/megaraid.c 2.6.7-ac/drivers/scsi/megaraid.c
--- linux-2.6.7/drivers/scsi/megaraid.c	2004-06-16 21:11:36.456369864 +0100
+++ 2.6.7-ac/drivers/scsi/megaraid.c	2004-06-16 21:28:01.434630408 +0100
@@ -4610,6 +4610,21 @@
 
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
