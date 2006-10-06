Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422891AbWJFTF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWJFTF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422892AbWJFTFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:05:25 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:20429 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422891AbWJFTFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:05:20 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH 2/2] [TULIP] Check the return value from pci_set_mwi()
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Fri, 06 Oct 2006 13:05:19 -0600
Message-Id: <11601615192857-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <1160161519800-git-send-email-matthew@wil.cx>
References: <1160161519800-git-send-email-matthew@wil.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We used to check whether pci_set_mwi() had succeeded by testing the
hardware MWI bit.  Now we need only check the return value (and failing
to do so is a warning).  Also, pci_set_mwi() will fail if the cache line
size is 0, so we don't need to check that ourselves any more.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
index d11d28c..64d999b 100644
--- a/drivers/net/tulip/tulip_core.c
+++ b/drivers/net/tulip/tulip_core.c
@@ -1135,7 +1135,6 @@ static void __devinit tulip_mwi_config (
 {
 	struct tulip_private *tp = netdev_priv(dev);
 	u8 cache;
-	u16 pci_command;
 	u32 csr0;
 
 	if (tulip_debug > 3)
@@ -1153,21 +1152,15 @@ static void __devinit tulip_mwi_config (
 	/* set or disable MWI in the standard PCI command bit.
 	 * Check for the case where  mwi is desired but not available
 	 */
-	if (csr0 & MWI)	pci_set_mwi(pdev);
-	else		pci_clear_mwi(pdev);
-
-	/* read result from hardware (in case bit refused to enable) */
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-	if ((csr0 & MWI) && (!(pci_command & PCI_COMMAND_INVALIDATE)))
-		csr0 &= ~MWI;
-
-	/* if cache line size hardwired to zero, no MWI */
-	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache);
-	if ((csr0 & MWI) && (cache == 0)) {
-		csr0 &= ~MWI;
+	if (csr0 & MWI)	{
+		if (pci_set_mwi(pdev))
+			csr0 &= ~MWI;
+	} else {
 		pci_clear_mwi(pdev);
 	}
 
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache);
+
 	/* assign per-cacheline-size cache alignment and
 	 * burst length values
 	 */
