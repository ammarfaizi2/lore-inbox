Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750771AbWFEIhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWFEIhF (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFEIgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:36:50 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29838 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750786AbWFEIgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:36:46 -0400
Subject: [PATCH 8/9] PCI PM: clear IO and MEM when disabling a device
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:46:16 -0400
Message-Id: <1149497176.7831.162.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies pci_disable_device() to clear IO and MEM from the
COMMAND PCI config register.  This is required before entering D3,  but
also probably a good general practice for system suspend.

Signed-off-by: Adam Belay <abelay@novell.com>

---
 pci.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff -urN a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2006-05-31 20:40:25.000000000 -0400
+++ b/drivers/pci/pci.c	2006-06-04 15:09:16.000000000 -0400
@@ -312,8 +312,12 @@
 	u16 pci_command;
 	
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_MASTER) {
-		pci_command &= ~PCI_COMMAND_MASTER;
+	if (pci_command & (PCI_COMMAND_MASTER |
+			   PCI_COMMAND_IO |
+			   PCI_COMMAND_MEMORY)) {
+		pci_command &= ~ (PCI_COMMAND_MASTER |
+				  PCI_COMMAND_IO |
+				  PCI_COMMAND_MEMORY);
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
 	dev->is_busmaster = 0;


