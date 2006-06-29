Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWF2BbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWF2BbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 21:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWF2BbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 21:31:22 -0400
Received: from mga06.intel.com ([134.134.136.21]:26550 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750769AbWF2BbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 21:31:21 -0400
X-IronPort-AV: i="4.06,190,1149490800"; 
   d="scan'208"; a="58235432:sNHT100505790"
Subject: Re: [PATCH 4/6] PCI-Express AER implemetation
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1151544150.28493.78.camel@ymzhang-perf.sh.intel.com>
References: <1151543547.28493.70.camel@ymzhang-perf.sh.intel.com>
	 <1151543881.28493.74.camel@ymzhang-perf.sh.intel.com>
	 <1151544150.28493.78.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1151544614.28493.82.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 29 Jun 2006 09:30:14 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Patch 4 implements the error output by printk.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.17/drivers/pci/pcie/aer/aerdrv_errprint.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17_aer/drivers/pci/pcie/aer/aerdrv_errprint.c	2006-06-22 16:46:29.000000000 +0800
@@ -0,0 +1,216 @@
+/*
+ * Copyright (C) 2006 Intel
+ *	Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *	Zhang Yanmin (yanmin.zhang@intel.com)
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+#include <linux/suspend.h>
+
+#include "aerdrv.h"
+
+#define AER_AGENT_RECEIVER		0
+#define AER_AGENT_REQUESTER		1
+#define AER_AGENT_COMPLETER		2
+#define AER_AGENT_TRANSMITTER		3		
+
+#define AER_AGENT_REQUESTER_MASK	(PCI_ERR_UNC_COMP_TIME|	\
+					PCI_ERR_UNC_UNSUP)
+
+#define AER_AGENT_COMPLETER_MASK	PCI_ERR_UNC_COMP_ABORT
+
+#define AER_AGENT_TRANSMITTER_MASK(t, e) (e & (PCI_ERR_COR_REP_ROLL| \
+	((t == AER_CORRECTABLE) ? PCI_ERR_COR_REP_TIMER: 0))) 
+
+#define AER_GET_AGENT(t, e)						\
+	((e & AER_AGENT_COMPLETER_MASK) ? AER_AGENT_COMPLETER :		\
+	(e & AER_AGENT_REQUESTER_MASK) ? AER_AGENT_REQUESTER :		\
+	(AER_AGENT_TRANSMITTER_MASK(t, e)) ? AER_AGENT_TRANSMITTER :	\
+	AER_AGENT_RECEIVER)
+
+#define AER_PHYSICAL_LAYER_ERROR_MASK	PCI_ERR_COR_RCVR
+#define AER_DATA_LINK_LAYER_ERROR_MASK(t, e)	\
+		(PCI_ERR_UNC_DLP|		\
+		PCI_ERR_COR_BAD_TLP| 		\
+		PCI_ERR_COR_BAD_DLLP|		\
+		PCI_ERR_COR_REP_ROLL| 		\
+		((t == AER_CORRECTABLE) ?	\
+		PCI_ERR_COR_REP_TIMER: 0))
+
+#define AER_PHYSICAL_LAYER_ERROR	0
+#define AER_DATA_LINK_LAYER_ERROR	1
+#define AER_TRANSACTION_LAYER_ERROR	2
+
+#define AER_GET_LAYER_ERROR(t, e)				\
+	((e & AER_PHYSICAL_LAYER_ERROR_MASK) ?			\
+	AER_PHYSICAL_LAYER_ERROR :				\
+	(e & AER_DATA_LINK_LAYER_ERROR_MASK(t, e)) ?		\
+		AER_DATA_LINK_LAYER_ERROR : 			\
+		AER_TRANSACTION_LAYER_ERROR)
+
+/* 
+ * AER error strings 
+ */
+static char* aer_error_severity_string[] = {
+	"Uncorrected (Non-Fatal)", 
+	"Uncorrected (Fatal)",
+	"Corrected"
+};
+
+static char* aer_error_layer[] = {
+	"Physical Layer",
+	"Data Link Layer",
+	"Transaction Layer" 
+};
+static char* aer_correctable_error_string[] = {
+	"Receiver Error        ",	/* Bit Position 0 	*/
+	"Unknown Error Bit 1   ", 	/* Bit Position 1	*/
+	"Unknown Error Bit 2   ",	/* Bit Position 2	*/
+	"Unknown Error Bit 3   ", 	/* Bit Position 3	*/
+	"Unknown Error Bit 4   ", 	/* Bit Position 4 	*/
+	"Unknown Error Bit 5   ",	/* Bit Position 5	*/
+	"Bad TLP               ",	/* Bit Position 6 	*/
+	"Bad DLLP              ",	/* Bit Position 7 	*/
+	"RELAY_NUM Rollover    ",	/* Bit Position 8 	*/
+	"Unknown Error Bit 9   ", 	/* Bit Position 9	*/
+	"Unknown Error Bit 10  ",	/* Bit Position 10	*/
+	"Unknown Error Bit 11  ", 	/* Bit Position 11	*/
+	"Replay Timer Timeout  ",	/* Bit Position 12 	*/
+	"Advisory Non-Fatal    ", 	/* Bit Position 13	*/
+	"Unknown Error Bit 14  ",	/* Bit Position 14	*/
+	"Unknown Error Bit 15  ", 	/* Bit Position 15	*/
+	"Unknown Error Bit 16  ", 	/* Bit Position 16 	*/
+	"Unknown Error Bit 17  ",	/* Bit Position 17	*/
+	"Unknown Error Bit 18  ", 	/* Bit Position 18	*/
+	"Unknown Error Bit 19  ",	/* Bit Position 19	*/
+	"Unknown Error Bit 20  ", 	/* Bit Position 20	*/
+	"Unknown Error Bit 21  ", 	/* Bit Position 21 	*/
+	"Unknown Error Bit 22  ",	/* Bit Position 22	*/
+	"Unknown Error Bit 23  ", 	/* Bit Position 23	*/
+	"Unknown Error Bit 24  ",	/* Bit Position 24	*/
+	"Unknown Error Bit 25  ", 	/* Bit Position 25	*/
+	"Unknown Error Bit 26  ", 	/* Bit Position 26 	*/
+	"Unknown Error Bit 27  ",	/* Bit Position 27	*/
+	"Unknown Error Bit 28  ",	/* Bit Position 28	*/
+	"Unknown Error Bit 29  ", 	/* Bit Position 29	*/
+	"Unknown Error Bit 30  ", 	/* Bit Position 30 	*/
+	"Unknown Error Bit 31  "	/* Bit Position 31	*/
+};
+
+static char* aer_uncorrectable_error_string[] = {
+	"Unknown Error Bit 0   ", 	/* Bit Position 0	*/
+	"Unknown Error Bit 1   ", 	/* Bit Position 1	*/
+	"Unknown Error Bit 2   ",	/* Bit Position 2	*/
+	"Unknown Error Bit 3   ", 	/* Bit Position 3	*/
+	"Data Link Protocol    ",	/* Bit Position 4	*/
+	"Unknown Error Bit 5   ", 	/* Bit Position 5	*/
+	"Unknown Error Bit 6   ", 	/* Bit Position 6	*/
+	"Unknown Error Bit 7   ",	/* Bit Position 7	*/
+	"Unknown Error Bit 8   ", 	/* Bit Position 8	*/
+	"Unknown Error Bit 9   ", 	/* Bit Position 9	*/
+	"Unknown Error Bit 10  ",	/* Bit Position 10	*/
+	"Unknown Error Bit 11  ", 	/* Bit Position 11	*/
+	"Poisoned TLP          ",	/* Bit Position 12 	*/
+	"Flow Control Protocol ",	/* Bit Position 13	*/
+	"Completion Timeout    ",	/* Bit Position 14 	*/
+	"Completer Abort       ",	/* Bit Position 15 	*/
+	"Unexpected Completion ",	/* Bit Position 16	*/
+	"Receiver Overflow     ",	/* Bit Position 17	*/
+	"Malformed TLP         ",	/* Bit Position 18	*/
+	"ECRC                  ",	/* Bit Position 19	*/
+	"Unsupported Request   ",	/* Bit Position 20	*/
+	"Unknown Error Bit 21  ", 	/* Bit Position 21 	*/
+	"Unknown Error Bit 22  ",	/* Bit Position 22	*/
+	"Unknown Error Bit 23  ", 	/* Bit Position 23	*/
+	"Unknown Error Bit 24  ",	/* Bit Position 24	*/
+	"Unknown Error Bit 25  ", 	/* Bit Position 25	*/
+	"Unknown Error Bit 26  ", 	/* Bit Position 26 	*/
+	"Unknown Error Bit 27  ",	/* Bit Position 27	*/
+	"Unknown Error Bit 28  ",	/* Bit Position 28	*/
+	"Unknown Error Bit 29  ", 	/* Bit Position 29	*/
+	"Unknown Error Bit 30  ", 	/* Bit Position 30 	*/
+	"Unknown Error Bit 31  "	/* Bit Position 31	*/
+};
+
+static char* aer_agent_string[] = {
+	"Receiver ID", 
+	"Requester ID", 
+	"Completer ID", 
+	"Transmitter ID" 
+};
+
+static char* aer_get_error_source_name(int severity, unsigned int status)
+{
+        int i;
+
+        for (i = 0; i < 32; i++) {
+                if (!(status & (1 << i)))
+                        continue;
+
+                if (severity == AER_CORRECTABLE)
+                        return aer_correctable_error_string[i];
+                else
+                        return aer_uncorrectable_error_string[i];
+        }
+
+        return NULL;
+}
+
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
+{
+	char * errmsg;
+	int err_layer, agent;
+
+	printk(KERN_ERR "+------ PCI-Express Device Error ------+\n");
+	printk(KERN_ERR "Error Severity\t\t: %s\n",
+		aer_error_severity_string[info->severity]);
+
+	if ( info->status == 0) {
+                printk(KERN_ERR "PCIE Bus Error type\t: (Unaccessible)\n");
+                printk(KERN_ERR "Unaccessible Received\t: %s\n",
+			info->flags & AER_MULTI_ERROR_VALID_FLAG ?
+				"Multiple" : "First");
+                printk(KERN_ERR "Unregistered Agent ID\t: %04x\n",
+			(dev->bus->number << 8) | dev->devfn);
+	} else {
+		err_layer = AER_GET_LAYER_ERROR(info->severity, info->status);
+		printk(KERN_ERR "PCIE Bus Error type\t: %s\n",
+			aer_error_layer[err_layer]);
+
+		errmsg = aer_get_error_source_name(info->severity, info->status);
+		printk(KERN_ERR "%s\t: %s\n", errmsg,
+			info->flags & AER_MULTI_ERROR_VALID_FLAG ?
+				"Multiple" : "First");
+
+		agent = AER_GET_AGENT(info->severity, info->status);
+		printk(KERN_ERR "%s\t\t: %04x\n",
+			aer_agent_string[agent],
+			(dev->bus->number << 8) | dev->devfn);
+
+		printk(KERN_ERR "VendorID=%04xh, DeviceID=%04xh,"
+			" Bus=%02xh, Device=%02xh, Function=%02xh\n",
+			dev->vendor,
+			dev->device,
+			dev->bus->number,
+			PCI_SLOT(dev->devfn),
+			PCI_FUNC(dev->devfn));
+
+		if (info->flags & AER_TLP_HEADER_VALID_FLAG) {
+			unsigned char *tlp = (unsigned char *) &info->tlp;
+			printk(KERN_ERR "TLB Header:\n");
+			printk(KERN_ERR "%02x%02x%02x%02x %02x%02x%02x%02x"
+				" %02x%02x%02x%02x %02x%02x%02x%02x\n",
+				*(tlp + 3), *(tlp + 2), *(tlp + 1), *tlp,
+				*(tlp + 7), *(tlp + 6), *(tlp + 5), *(tlp + 4),
+				*(tlp + 11), *(tlp + 10), *(tlp + 9),
+				*(tlp + 8), *(tlp + 15), *(tlp + 14),
+				*(tlp + 13), *(tlp + 12));
+		}
+	}
+}
+
