Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVCKXKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVCKXKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVCKXGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:06:45 -0500
Received: from fmr19.intel.com ([134.134.136.18]:36297 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261854AbVCKWzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:55:46 -0500
Date: Fri, 11 Mar 2005 16:15:53 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200503120015.j2C0Frse020317@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 4/6] PCI Express Advanced Error Reporting Driver
Cc: greg@kroah.com, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes the source code of Root callback-handle component
of PCI Express Advanced Error Reporting driver.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------------
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_rpc_handle.c patch-2.6.11-rc5-aerc3-split4/drivers/pci/pcie/aer/aerdrv_rpc_handle.c
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_rpc_handle.c	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split4/drivers/pci/pcie/aer/aerdrv_rpc_handle.c	2005-03-09 13:25:36.000000000 -0500
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2005 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+
+#include "aerdrv.h"
+
+static int aer_root_notify(unsigned short requestor_id, union aer_error *error);
+static int aer_root_get_header(unsigned short requestor_id, 
+	union aer_error *error, struct header_log_regs *log);
+
+/* AER callback handle data structure */
+struct pcie_aer_handle aer_root_handle = {
+	.notify 			= aer_root_notify,
+	.get_header 			= aer_root_get_header,
+};
+
+/**
+ * aer_root_notify - process an error being notified by AER Root driver
+ * @requestor_id: an identification
+ * @error: pointer to an error data structure
+ *
+ * Invoked when AER Root Port itself generates error messages.
+ **/
+static int aer_root_notify(unsigned short requestor_id, union aer_error *error)
+{
+	struct pci_dev *pdev = get_root_pci_dev(requestor_id);
+	int pos, retval = -EINVAL;
+	u32 status;
+	u16 reg16;
+	
+	if (error->type == AER_CORRECTABLE) {
+		pci_read_config_dword(pdev, 
+			CORRECTABLE_ERROR_STATUS_REG, &status);
+		if (status & ERR_CORRECTABLE_ERROR_MASK) {
+			pci_write_config_dword(pdev, 
+				CORRECTABLE_ERROR_STATUS_REG, status);
+			error->source.type = AER_CORRECTABLE;
+			error->source.status = status;
+			retval = 0;
+		}		
+	} else {
+		pci_read_config_dword(pdev, 
+			UNCORRECTABLE_ERROR_STATUS_REG, &status);
+		if (status & ERR_UNCORRECTABLE_ERROR_MASK) {
+			u32 severity;
+
+			pci_read_config_dword(pdev, 
+				UNCORRECTABLE_ERROR_SEVERITY_REG, &severity);
+			pci_write_config_dword(pdev, 
+				UNCORRECTABLE_ERROR_STATUS_REG, status);
+			if (status & severity)
+				error->source.type = AER_FATAL;
+			else
+				error->source.type = AER_NONFATAL;
+			error->source.status = status;
+			retval = 0;
+		}
+	}
+	
+	/* Clean up Root device status */
+	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+	pci_read_config_word(pdev, pos + PCIE_CAP_DEVICE_STATUS_REG_OFF,&reg16);
+	pci_write_config_word(pdev, pos + PCIE_CAP_DEVICE_STATUS_REG_OFF,reg16);
+
+	return retval;
+}
+
+/**
+ * aer_root_get_header - provide TLP header
+ * @requestor_id: an identification
+ * @error: pointer to a TLP header data structure
+ *
+ * Invoked when AER Root Port logs the header of TLP associated with an error.
+ **/
+static int aer_root_get_header(unsigned short requestor_id, 
+	union aer_error *error, struct header_log_regs *log)
+{
+	struct pci_dev *pdev = get_root_pci_dev(requestor_id);
+
+	if (error->type == AER_CORRECTABLE || 
+		!(error->source.status & AER_LOG_TLP_MASKS))
+		return AER_UNSUCCESS;
+		
+	pci_read_config_dword(pdev, HEADER_LOG_REG, &log->dw0);
+	pci_read_config_dword(pdev, HEADER_LOG_REG + 4, &log->dw1);
+	pci_read_config_dword(pdev, HEADER_LOG_REG + 8, &log->dw2);
+	pci_read_config_dword(pdev, HEADER_LOG_REG + 12, &log->dw3);
+
+	return AER_SUCCESS;
+}
+
