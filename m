Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbUKWRDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbUKWRDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbUKWRCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:02:43 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:44671 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261345AbUKWQP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:15:26 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123815.Ai338wEt3YqtY107@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:15:20 -0800
Message-Id: <20041123815.dUhm1PnERtccLLnp@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][11/21] Add Mellanox HCA low-level driver (initialization)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:15:26.0021 (UTC) FILETIME=[A4405750:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add device initializaton code for Mellanox HCA driver.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_profile.c	2004-11-23 08:10:20.600524828 -0800
@@ -0,0 +1,222 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: mthca_profile.c 1239 2004-11-15 23:14:21Z roland $
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include "mthca_profile.h"
+
+static int default_profile[MTHCA_RES_NUM] = {
+	[MTHCA_RES_QP]    = 1 << 16,
+	[MTHCA_RES_EQP]   = 1 << 16,
+	[MTHCA_RES_CQ]    = 1 << 16,
+	[MTHCA_RES_EQ]    = 32,
+	[MTHCA_RES_RDB]   = 1 << 18,
+	[MTHCA_RES_MCG]   = 1 << 13,
+	[MTHCA_RES_MPT]   = 1 << 17,
+	[MTHCA_RES_MTT]   = 1 << 20,
+	[MTHCA_RES_UDAV]  = 1 << 15
+};
+
+enum {
+	MTHCA_RDB_ENTRY_SIZE = 32,
+	MTHCA_MTT_SEG_SIZE   = 64
+};
+
+enum {
+	MTHCA_NUM_PDS = 1 << 15
+};
+
+int mthca_make_profile(struct mthca_dev *dev,
+		       struct mthca_dev_lim *dev_lim,
+		       struct mthca_init_hca_param *init_hca)
+{
+	/* just use default profile for now */
+	struct mthca_resource {
+		u64 size;
+		u64 start;
+		int type;
+		int num;
+		int log_num;
+	};
+
+	u64 total_size = 0;
+	struct mthca_resource *profile;
+	struct mthca_resource tmp;
+	int i, j;
+
+	default_profile[MTHCA_RES_UAR] = dev_lim->uar_size / PAGE_SIZE;
+
+	profile = kmalloc(MTHCA_RES_NUM * sizeof *profile, GFP_KERNEL);
+	if (!profile)
+		return -ENOMEM;
+
+	profile[MTHCA_RES_QP].size   = dev_lim->qpc_entry_sz;
+	profile[MTHCA_RES_EEC].size  = dev_lim->eec_entry_sz;
+	profile[MTHCA_RES_SRQ].size  = dev_lim->srq_entry_sz;
+	profile[MTHCA_RES_CQ].size   = dev_lim->cqc_entry_sz;
+	profile[MTHCA_RES_EQP].size  = dev_lim->eqpc_entry_sz;
+	profile[MTHCA_RES_EEEC].size = dev_lim->eeec_entry_sz;
+	profile[MTHCA_RES_EQ].size   = dev_lim->eqc_entry_sz;
+	profile[MTHCA_RES_RDB].size  = MTHCA_RDB_ENTRY_SIZE;
+	profile[MTHCA_RES_MCG].size  = MTHCA_MGM_ENTRY_SIZE;
+	profile[MTHCA_RES_MPT].size  = MTHCA_MPT_ENTRY_SIZE;
+	profile[MTHCA_RES_MTT].size  = MTHCA_MTT_SEG_SIZE;
+	profile[MTHCA_RES_UAR].size  = dev_lim->uar_scratch_entry_sz;
+	profile[MTHCA_RES_UDAV].size = MTHCA_AV_SIZE;
+
+	for (i = 0; i < MTHCA_RES_NUM; ++i) {
+		profile[i].type     = i;
+		profile[i].num      = default_profile[i];
+		profile[i].log_num  = max(ffs(default_profile[i]) - 1, 0);
+		profile[i].size    *= default_profile[i];
+	}
+
+	/* 
+	 * Sort the resources in decreasing order of size.  Since they
+	 * all have sizes that are powers of 2, we'll be able to keep
+	 * resources aligned to their size and pack them without gaps
+	 * using the sorted order.
+	 */
+	for (i = MTHCA_RES_NUM; i > 0; --i)
+		for (j = 1; j < i; ++j) {
+			if (profile[j].size > profile[j - 1].size) {
+				tmp            = profile[j];
+				profile[j]     = profile[j - 1];
+				profile[j - 1] = tmp;
+			}
+		}
+
+	for (i = 0; i < MTHCA_RES_NUM; ++i) {
+		if (profile[i].size) {
+			profile[i].start = dev->ddr_start + total_size;
+			total_size      += profile[i].size;
+		}
+		if (total_size > dev->fw.tavor.fw_start - dev->ddr_start) {
+			mthca_err(dev, "Profile requires 0x%llx bytes; "
+				  "won't fit between DDR start at 0x%016llx "
+				  "and FW start at 0x%016llx.\n",
+				  (unsigned long long) total_size,
+				  (unsigned long long) dev->ddr_start,
+				  (unsigned long long) dev->fw.tavor.fw_start);
+			kfree(profile);
+			return -ENOMEM;
+		}
+
+		if (profile[i].size)
+			mthca_dbg(dev, "profile[%2d]--%2d/%2d @ 0x%16llx "
+				  "(size 0x%8llx)\n",
+				  i, profile[i].type, profile[i].log_num,
+				  (unsigned long long) profile[i].start,
+				  (unsigned long long) profile[i].size);
+	}
+
+	mthca_dbg(dev, "HCA memory: allocated %d KB/%d KB (%d KB free)\n",
+		  (int) (total_size >> 10),
+		  (int) ((dev->fw.tavor.fw_start - dev->ddr_start) >> 10),
+		  (int) ((dev->fw.tavor.fw_start - dev->ddr_start - total_size) >> 10));
+
+	for (i = 0; i < MTHCA_RES_NUM; ++i) {
+		switch (profile[i].type) {
+		case MTHCA_RES_QP:
+			dev->limits.num_qps   = profile[i].num;
+			init_hca->qpc_base    = profile[i].start;
+			init_hca->log_num_qps = profile[i].log_num;
+			break;
+		case MTHCA_RES_EEC:
+			dev->limits.num_eecs   = profile[i].num;
+			init_hca->eec_base     = profile[i].start;
+			init_hca->log_num_eecs = profile[i].log_num;
+			break;
+		case MTHCA_RES_SRQ:
+			dev->limits.num_srqs   = profile[i].num;
+			init_hca->srqc_base    = profile[i].start;
+			init_hca->log_num_srqs = profile[i].log_num;
+			break;
+		case MTHCA_RES_CQ:
+			dev->limits.num_cqs   = profile[i].num;
+			init_hca->cqc_base    = profile[i].start;
+			init_hca->log_num_cqs = profile[i].log_num;
+			break;
+		case MTHCA_RES_EQP:
+			init_hca->eqpc_base = profile[i].start;
+			break;
+		case MTHCA_RES_EEEC:
+			init_hca->eeec_base = profile[i].start;
+			break;
+		case MTHCA_RES_EQ:
+			dev->limits.num_eqs   = profile[i].num;
+			init_hca->eqc_base    = profile[i].start;
+			init_hca->log_num_eqs = profile[i].log_num;
+			break;
+		case MTHCA_RES_RDB:
+			dev->limits.num_rdbs = profile[i].num;
+			init_hca->rdb_base   = profile[i].start;
+			break;
+		case MTHCA_RES_MCG:
+			dev->limits.num_mgms      = profile[i].num >> 1;
+			dev->limits.num_amgms     = profile[i].num >> 1;
+			init_hca->mc_base         = profile[i].start;
+			init_hca->log_mc_entry_sz = ffs(MTHCA_MGM_ENTRY_SIZE) - 1;
+			init_hca->log_mc_table_sz = profile[i].log_num;
+			init_hca->mc_hash_sz      = 1 << (profile[i].log_num - 1);
+			break;
+		case MTHCA_RES_MPT:
+			dev->limits.num_mpts = profile[i].num;
+			init_hca->mpt_base   = profile[i].start;
+			init_hca->log_mpt_sz = profile[i].log_num;
+			break;
+		case MTHCA_RES_MTT:
+			dev->limits.num_mtt_segs = profile[i].num;
+			dev->limits.mtt_seg_size = MTHCA_MTT_SEG_SIZE;
+			dev->mr_table.mtt_base   = profile[i].start;
+			init_hca->mtt_base       = profile[i].start;
+			init_hca->mtt_seg_sz     = ffs(MTHCA_MTT_SEG_SIZE) - 7;
+			break;
+		case MTHCA_RES_UAR:
+			init_hca->uar_scratch_base = profile[i].start;
+			break;
+		case MTHCA_RES_UDAV:
+			dev->av_table.ddr_av_base = profile[i].start;
+			dev->av_table.num_ddr_avs = profile[i].num;
+		default:
+			break;
+		}
+	}
+
+	/*
+	 * PDs don't take any HCA memory, but we assign them as part
+	 * of the HCA profile anyway.
+	 */
+	dev->limits.num_pds = MTHCA_NUM_PDS;
+
+	kfree(profile);
+	return 0;
+}
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_profile.h	2004-11-23 08:10:20.642518636 -0800
@@ -0,0 +1,58 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: mthca_profile.h 186 2004-05-24 02:23:08Z roland $
+ */
+
+#ifndef MTHCA_PROFILE_H
+#define MTHCA_PROFILE_H
+
+#include "mthca_dev.h"
+#include "mthca_cmd.h"
+
+enum {
+	MTHCA_RES_QP,
+	MTHCA_RES_EEC,
+	MTHCA_RES_SRQ,
+	MTHCA_RES_CQ,
+	MTHCA_RES_EQP,
+	MTHCA_RES_EEEC,
+	MTHCA_RES_EQ,
+	MTHCA_RES_RDB,
+	MTHCA_RES_MCG,
+	MTHCA_RES_MPT,
+	MTHCA_RES_MTT,
+	MTHCA_RES_UAR,
+	MTHCA_RES_UDAV,
+	MTHCA_RES_NUM
+};
+
+int mthca_make_profile(struct mthca_dev *mdev,
+		       struct mthca_dev_lim *dev_lim,
+		       struct mthca_init_hca_param *init_hca);
+
+#endif /* MTHCA_PROFILE_H */
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_reset.c	2004-11-23 08:10:20.724506547 -0800
@@ -0,0 +1,228 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: mthca_reset.c 950 2004-10-07 18:21:02Z roland $
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+
+#include "mthca_dev.h"
+#include "mthca_cmd.h"
+
+int mthca_reset(struct mthca_dev *mdev)
+{
+	int i;
+	int err = 0;
+	u32 *hca_header    = NULL;
+	u32 *bridge_header = NULL;
+	struct pci_dev *bridge = NULL;
+
+#define MTHCA_RESET_OFFSET 0xf0010
+#define MTHCA_RESET_VALUE  cpu_to_be32(1)
+
+	/*
+	 * Reset the chip.  This is somewhat ugly because we have to
+	 * save off the PCI header before reset and then restore it
+	 * after the chip reboots.  We skip config space offsets 22
+	 * and 23 since those have a special meaning.
+	 *
+	 * To make matters worse, for Tavor (PCI-X HCA) we have to
+	 * find the associated bridge device and save off its PCI
+	 * header as well.
+	 */
+
+	if (mdev->hca_type == TAVOR) {
+		/* Look for the bridge -- its device ID will be 2 more
+		   than HCA's device ID. */
+		while ((bridge = pci_get_device(mdev->pdev->vendor,
+						mdev->pdev->device + 2,
+						bridge)) != NULL) {
+			if (bridge->hdr_type    == PCI_HEADER_TYPE_BRIDGE &&
+			    bridge->subordinate == mdev->pdev->bus) {
+				mthca_dbg(mdev, "Found bridge: %s (%s)\n",
+					  pci_pretty_name(bridge), pci_name(bridge));
+				break;
+			}
+		}
+
+		if (!bridge) {
+			/*
+			 * Didn't find a bridge for a Tavor device --
+			 * assume we're in no-bridge mode and hope for
+			 * the best.
+			 */
+			mthca_warn(mdev, "No bridge found for %s (%s)\n",
+				  pci_pretty_name(mdev->pdev), pci_name(mdev->pdev));
+		}
+			
+	}
+
+	/* For Arbel do we need to save off the full 4K PCI Express header?? */
+	hca_header = kmalloc(256, GFP_KERNEL);
+	if (!hca_header) {
+		err = -ENOMEM;
+		mthca_err(mdev, "Couldn't allocate memory to save HCA "
+			  "PCI header, aborting.\n");
+		goto out;
+	}
+
+	for (i = 0; i < 64; ++i) {
+		if (i == 22 || i == 23)
+			continue;
+		if (pci_read_config_dword(mdev->pdev, i * 4, hca_header + i)) {
+			err = -ENODEV;
+			mthca_err(mdev, "Couldn't save HCA "
+				  "PCI header, aborting.\n");
+			goto out;
+		}
+	}
+
+	if (bridge) {
+		bridge_header = kmalloc(256, GFP_KERNEL);
+		if (!bridge_header) {
+			err = -ENOMEM;
+			mthca_err(mdev, "Couldn't allocate memory to save HCA "
+				  "bridge PCI header, aborting.\n");
+			goto out;
+		}
+
+		for (i = 0; i < 64; ++i) {
+			if (i == 22 || i == 23)
+				continue;
+			if (pci_read_config_dword(bridge, i * 4, bridge_header + i)) {
+				err = -ENODEV;
+				mthca_err(mdev, "Couldn't save HCA bridge "
+					  "PCI header, aborting.\n");
+				goto out;
+			}
+		}
+	}
+
+	/* actually hit reset */
+	{
+		void __iomem *reset = ioremap(pci_resource_start(mdev->pdev, 0) +
+					      MTHCA_RESET_OFFSET, 4);
+
+		if (!reset) {
+			err = -ENOMEM;
+			mthca_err(mdev, "Couldn't map HCA reset register, "
+				  "aborting.\n");
+			goto out;
+		}
+
+		writel(MTHCA_RESET_VALUE, reset);
+		iounmap(reset);
+	}
+
+	/* Docs say to wait one second before accessing device */
+	msleep(1000);
+
+	/* Now wait for PCI device to start responding again */
+	{
+		u32 v;
+		int c = 0;
+
+		for (c = 0; c < 100; ++c) {
+			if (pci_read_config_dword(bridge ? bridge : mdev->pdev, 0, &v)) {
+				err = -ENODEV;
+				mthca_err(mdev, "Couldn't access HCA after reset, "
+					  "aborting.\n");
+				goto out;
+			}
+
+			if (v != 0xffffffff)
+				goto good;
+
+			msleep(100);
+		}
+
+		err = -ENODEV;
+		mthca_err(mdev, "PCI device did not come back after reset, "
+			  "aborting.\n");
+		goto out;
+	}
+
+good:
+	/* Now restore the PCI headers */
+	if (bridge) {
+		/*
+		 * Bridge control register is at 0x3e, so we'll
+		 * naturally restore it last in this loop.
+		 */
+		for (i = 0; i < 16; ++i) {
+			if (i * 4 == PCI_COMMAND)
+				continue;
+
+			if (pci_write_config_dword(bridge, i * 4, bridge_header[i])) {
+				err = -ENODEV;
+				mthca_err(mdev, "Couldn't restore HCA bridge reg %x, "
+					  "aborting.\n", i);
+				goto out;
+			}
+		}
+
+		if (pci_write_config_dword(bridge, PCI_COMMAND,
+					   bridge_header[PCI_COMMAND / 4])) {
+			err = -ENODEV;
+			mthca_err(mdev, "Couldn't restore HCA bridge COMMAND, "
+				  "aborting.\n");
+			goto out;
+		}
+	}
+
+	for (i = 0; i < 16; ++i) {
+		if (i * 4 == PCI_COMMAND)
+			continue;
+
+		if (pci_write_config_dword(mdev->pdev, i * 4, hca_header[i])) {
+			err = -ENODEV;
+			mthca_err(mdev, "Couldn't restore HCA reg %x, "
+				  "aborting.\n", i);
+			goto out;
+		}
+	}
+
+	if (pci_write_config_dword(mdev->pdev, PCI_COMMAND,
+				   hca_header[PCI_COMMAND / 4])) {
+		err = -ENODEV;
+		mthca_err(mdev, "Couldn't restore HCA COMMAND, "
+			  "aborting.\n");
+		goto out;
+	}
+
+out:
+	if (bridge)
+		pci_dev_put(bridge);
+	kfree(bridge_header);
+	kfree(hca_header);
+
+	return err;
+}
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */

