Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422876AbWJFTFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422876AbWJFTFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422893AbWJFTFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:05:22 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:19405 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422876AbWJFTFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:05:20 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Fri, 06 Oct 2006 13:05:18 -0600
Message-Id: <1160161519800-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since some devices may not implement the MWI bit, we should check that
the write did set it and return an error if it didn't.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a544997..3d041f4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -900,13 +900,17 @@ #endif
 		return rc;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (! (cmd & PCI_COMMAND_INVALIDATE)) {
-		pr_debug("PCI: Enabling Mem-Wr-Inval for device %s\n", pci_name(dev));
-		cmd |= PCI_COMMAND_INVALIDATE;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	
-	return 0;
+	if (cmd & PCI_COMMAND_INVALIDATE)
+		return 0;
+
+	pr_debug("PCI: Enabling Mem-Wr-Inval for device %s\n", pci_name(dev));
+	cmd |= PCI_COMMAND_INVALIDATE;
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+	/* read result from hardware (in case bit refused to enable) */
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+
+	return (cmd & PCI_COMMAND_INVALIDATE) ? 0 : -EINVAL;
 }
 
 /**
