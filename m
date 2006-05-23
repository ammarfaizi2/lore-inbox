Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWEWRQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWEWRQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWEWRQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:16:34 -0400
Received: from mga05.intel.com ([192.55.52.89]:43302 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750941AbWEWRQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:16:34 -0400
X-IronPort-AV: i="4.05,161,1146466800"; 
   d="scan'208"; a="41347792:sNHT51588789"
Date: Tue, 23 May 2006 10:14:36 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, ak@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Allow MSI to work on kexec kernel
Message-ID: <20060523101436.A25249@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently ran into a problem where the e1000 device failed to
work properly on the kexec kernel. MSI was enabled for the
device in the main kernel when it crashed. The e1000 driver
tried to enable MSI on the kexec kernel, but the code bailed
early when it found that MSI was already enabled in the hardware,
even though the software state was not properly set up in the
kexec'd kernel. This patch fixes the problem by moving the
early return to after making sure that the software state
is properly initialized.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

 drivers/pci/msi.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: linux/drivers/pci/msi.c
===================================================================
--- linux.orig/drivers/pci/msi.c	2006-05-18 12:35:00.000000000 -0700
+++ linux/drivers/pci/msi.c	2006-05-19 23:07:11.000000000 -0700
@@ -879,14 +879,13 @@
    	if (!(pos = pci_find_capability(dev, PCI_CAP_ID_MSI)))
 		return -EINVAL;
 
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
-	if (control & PCI_MSI_FLAGS_ENABLE)
-		return 0;			/* Already in MSI mode */
-
 	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
 		/* Lookup Sucess */
 		unsigned long flags;
 
+		pci_read_config_word(dev, msi_control_reg(pos), &control);
+		if (control & PCI_MSI_FLAGS_ENABLE)
+			return 0;	/* Already in MSI mode */
 		spin_lock_irqsave(&msi_lock, flags);
 		if (!vector_irq[dev->irq]) {
 			msi_desc[dev->irq]->msi_attrib.state = 0;
