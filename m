Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWDPWmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWDPWmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 18:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWDPWmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 18:42:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29834 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750812AbWDPWmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 18:42:16 -0400
Date: Sun, 16 Apr 2006 17:42:15 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Improve PCI config space writeback.
Message-ID: <20060416224215.GA732@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least one laptop blew up on resume from suspend with a black screen
due to a lack of this patch.  By only writing back config space that
is different, we minimise the possibility of accidents like this.

Signed-off-by: Dave Jones <davej@redhat.com>


--- linux-2.6.16.noarch/drivers/pci/pci.c~	2006-04-16 17:36:34.000000000 -0500
+++ linux-2.6.16.noarch/drivers/pci/pci.c	2006-04-16 17:37:42.000000000 -0500
@@ -461,9 +461,17 @@ int 
 pci_restore_state(struct pci_dev *dev)
 {
 	int i;
+	int val;
 
-	for (i = 0; i < 16; i++)
-		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
+	for (i = 0; i < 16; i++) {
+		pci_read_config_dword(dev, i * 4, &val);
+		if (val != dev->saved_config_space[i]) {
+			printk (KERN_DEBUG "PM: Writing back config space on device %s at offset %x. (Was %x, writing %x)\n",
+				pci_name(dev), i,
+				val, (int) dev->saved_config_space[i]);
+			pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
+		}
+	}
 	pci_restore_msi_state(dev);
 	pci_restore_msix_state(dev);
 	return 0;
