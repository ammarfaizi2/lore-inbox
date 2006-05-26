Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWEZDAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWEZDAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 23:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWEZDAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 23:00:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:7206 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751272AbWEZDAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 23:00:05 -0400
X-IronPort-AV: i="4.05,174,1146466800"; 
   d="scan'208"; a="41595676:sNHT54146862"
Subject: [RFC]disable msi mode in pci_disable_device
From: Shaohua Li <shaohua.li@intel.com>
To: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg <greg@kroah.com>,
       tom long <tom.l.nguyen@intel.com>, Brice Goglin <brice@myri.com>,
       Rajesh Shah <rajesh.shah@intel.com>
Content-Type: text/plain
Date: Fri, 26 May 2006 10:58:27 +0800
Message-Id: <1148612307.32046.132.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice said the pci_save_msi_state breaks his driver in his special usage
(not in suspend/resume), as pci_save_msi_state will disable msi mode. In
his usage, pci_save_state will be called at runtime, and later (after
the device operates for some time and has an error) pci_restore_state
will be called.
In another hand, suspend/resume needs disable msi mode, as device should
stop working completely. This patch try to workaround this issue.
Drivers are expected call pci_disable_device in suspend time after
pci_save_state.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc4-root/drivers/pci/msi.c   |    6 ++++--
 linux-2.6.17-rc4-root/drivers/pci/pci.c   |    9 ++++++++-
 linux-2.6.17-rc4-root/include/linux/pci.h |    2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff -puN drivers/pci/msi.c~disable-msi-in-pci_disable_device drivers/pci/msi.c
--- linux-2.6.17-rc4/drivers/pci/msi.c~disable-msi-in-pci_disable_device	2006-05-25 08:18:23.000000000 +0800
+++ linux-2.6.17-rc4-root/drivers/pci/msi.c	2006-05-25 08:25:19.000000000 +0800
@@ -442,9 +442,11 @@ static void enable_msi_mode(struct pci_d
 		/* Set enabled bits to single MSI & enable MSI_enable bit */
 		msi_enable(control, 1);
 		pci_write_config_word(dev, msi_control_reg(pos), control);
+		dev->msi_enabled = 1;
 	} else {
 		msix_enable(control);
 		pci_write_config_word(dev, msi_control_reg(pos), control);
+		dev->msix_enabled = 1;
 	}
     	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
 		/* PCI Express Endpoint device detected */
@@ -461,9 +463,11 @@ void disable_msi_mode(struct pci_dev *de
 		/* Set enabled bits to single MSI & enable MSI_enable bit */
 		msi_disable(control);
 		pci_write_config_word(dev, msi_control_reg(pos), control);
+		dev->msi_enabled = 0;
 	} else {
 		msix_disable(control);
 		pci_write_config_word(dev, msi_control_reg(pos), control);
+		dev->msix_enabled = 0;
 	}
     	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
 		/* PCI Express Endpoint device detected */
@@ -538,7 +542,6 @@ int pci_save_msi_state(struct pci_dev *d
 		pci_read_config_dword(dev, pos + PCI_MSI_DATA_32, &cap[i++]);
 	if (control & PCI_MSI_FLAGS_MASKBIT)
 		pci_read_config_dword(dev, pos + PCI_MSI_MASK_BIT, &cap[i++]);
-	disable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 	save_state->cap_nr = PCI_CAP_ID_MSI;
 	pci_add_saved_cap(dev, save_state);
 	return 0;
@@ -593,7 +596,6 @@ int pci_save_msix_state(struct pci_dev *
 	}
 	*((u16 *)&save_state->data[0]) = control;
 
-	disable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
 	save_state->cap_nr = PCI_CAP_ID_MSIX;
 	pci_add_saved_cap(dev, save_state);
 	return 0;
diff -puN include/linux/pci.h~disable-msi-in-pci_disable_device include/linux/pci.h
--- linux-2.6.17-rc4/include/linux/pci.h~disable-msi-in-pci_disable_device	2006-05-25 08:18:36.000000000 +0800
+++ linux-2.6.17-rc4-root/include/linux/pci.h	2006-05-25 08:19:34.000000000 +0800
@@ -163,6 +163,8 @@ struct pci_dev {
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
+	unsigned int 	msi_enabled:1;
+	unsigned int	msix_enabled:1;
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct hlist_head saved_cap_space;
diff -puN drivers/pci/pci.c~disable-msi-in-pci_disable_device drivers/pci/pci.c
--- linux-2.6.17-rc4/drivers/pci/pci.c~disable-msi-in-pci_disable_device	2006-05-25 08:20:42.000000000 +0800
+++ linux-2.6.17-rc4-root/drivers/pci/pci.c	2006-05-25 08:32:33.000000000 +0800
@@ -533,7 +533,14 @@ void
 pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
-	
+
+	if (dev->msi_enabled)
+		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
+			PCI_CAP_ID_MSI);
+	if (dev->msix_enabled)
+		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
+			PCI_CAP_ID_MSIX);
+
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
_
