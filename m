Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbUKWRPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbUKWRPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUKWROu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:14:50 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:49535 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261347AbUKWQPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:15:48 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123815.KMR5AMwRXU875N9Z@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:15:38 -0800
Message-Id: <20041123815.NWFV7rNrbnpqbYAH@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][13/21] Add Mellanox HCA low-level driver (last bits)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:15:46.0990 (UTC) FILETIME=[B0BFF4E0:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add code for remaining InfiniBand objects (address vectors, multicast
groups, memory regions and protection domains)

Signed-off-by: Roland Dreier <roland@topspin.com>


--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_av.c	2004-11-23 08:10:21.345414995 -0800
@@ -0,0 +1,212 @@
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
+ * $Id: mthca_av.c 1180 2004-11-09 05:12:12Z roland $
+ */
+
+#include <linux/init.h>
+
+#include <ib_verbs.h>
+#include <ib_cache.h>
+
+#include "mthca_dev.h"
+
+struct mthca_av {
+	u32 port_pd;
+	u8  reserved1;
+	u8  g_slid;
+	u16 dlid;
+	u8  reserved2;
+	u8  gid_index;
+	u8  msg_sr;
+	u8  hop_limit;
+	u32 sl_tclass_flowlabel;
+	u32 dgid[4];
+} __attribute__((packed));
+
+int mthca_create_ah(struct mthca_dev *dev,
+		    struct mthca_pd *pd,
+		    struct ib_ah_attr *ah_attr,
+		    struct mthca_ah *ah)
+{
+	u32 index = -1;
+	struct mthca_av *av = NULL;
+
+	ah->on_hca = 0;
+
+	if (!atomic_read(&pd->sqp_count) &&
+	    !(dev->mthca_flags & MTHCA_FLAG_DDR_HIDDEN)) {
+		index = mthca_alloc(&dev->av_table.alloc);
+
+		/* fall back to allocate in host memory */
+		if (index == -1)
+			goto host_alloc;
+
+		av = kmalloc(sizeof *av, GFP_KERNEL);
+		if (!av)
+			goto host_alloc;
+			
+		ah->on_hca = 1;
+		ah->avdma  = dev->av_table.ddr_av_base +
+			index * MTHCA_AV_SIZE;
+	}
+
+ host_alloc:
+	if (!ah->on_hca) {
+		ah->av = pci_pool_alloc(dev->av_table.pool,
+					SLAB_KERNEL, &ah->avdma);
+		if (!ah->av)
+			return -ENOMEM;
+
+		av = ah->av;
+	}
+
+	ah->key = pd->ntmr.ibmr.lkey;
+
+	memset(av, 0, MTHCA_AV_SIZE);
+
+	av->port_pd = cpu_to_be32(pd->pd_num | (ah_attr->port_num << 24));
+	av->g_slid  = ah_attr->src_path_bits;
+	av->dlid    = cpu_to_be16(ah_attr->dlid);
+	av->msg_sr  = (3 << 4) | /* 2K message */
+		ah_attr->static_rate;
+	av->sl_tclass_flowlabel = cpu_to_be32(ah_attr->sl << 28);
+	if (ah_attr->ah_flags & IB_AH_GRH) {
+		av->g_slid |= 0x80;
+		av->gid_index = (ah_attr->port_num - 1) * dev->limits.gid_table_len +
+			ah_attr->grh.sgid_index;
+		av->hop_limit = ah_attr->grh.hop_limit;
+		av->sl_tclass_flowlabel |=
+			cpu_to_be32((ah_attr->grh.traffic_class << 20) |
+				    ah_attr->grh.flow_label);
+		memcpy(av->dgid, ah_attr->grh.dgid.raw, 16);
+	}
+
+	if (0) {
+		int j;
+		
+		mthca_dbg(dev, "Created UDAV at %p/%08lx:\n",
+			  av, (unsigned long) ah->avdma);
+		for (j = 0; j < 8; ++j)
+			printk(KERN_DEBUG "  [%2x] %08x\n",
+			       j * 4, be32_to_cpu(((u32 *) av)[j]));
+	}
+
+	if (ah->on_hca) {
+		memcpy_toio(dev->av_table.av_map + index * MTHCA_AV_SIZE,
+			    av, MTHCA_AV_SIZE);
+		kfree(av);
+	}
+
+	return 0;
+}
+
+int mthca_destroy_ah(struct mthca_dev *dev, struct mthca_ah *ah)
+{
+	if (ah->on_hca)
+		mthca_free(&dev->av_table.alloc,
+ 			   (ah->avdma - dev->av_table.ddr_av_base) /
+			   MTHCA_AV_SIZE);
+	else
+		pci_pool_free(dev->av_table.pool, ah->av, ah->avdma);
+
+	return 0;
+}
+
+int mthca_read_ah(struct mthca_dev *dev, struct mthca_ah *ah,
+		  struct ib_ud_header *header)
+{
+	if (ah->on_hca)
+		return -EINVAL;
+
+	header->lrh.service_level   = be32_to_cpu(ah->av->sl_tclass_flowlabel) >> 28;
+	header->lrh.destination_lid = ah->av->dlid;
+	header->lrh.source_lid      = ah->av->g_slid & 0x7f;
+	if (ah->av->g_slid & 0x80) {
+		header->grh_present = 1;
+		header->grh.traffic_class =
+			(be32_to_cpu(ah->av->sl_tclass_flowlabel) >> 20) & 0xff;
+		header->grh.flow_label    =
+			ah->av->sl_tclass_flowlabel & cpu_to_be32(0xfffff);
+		ib_cached_gid_get(&dev->ib_dev,
+				  be32_to_cpu(ah->av->port_pd) >> 24,
+				  ah->av->gid_index,
+				  &header->grh.source_gid);
+		memcpy(header->grh.destination_gid.raw,
+		       ah->av->dgid, 16);
+	} else {
+		header->grh_present = 0;
+	}
+
+	return 0;
+}
+
+int __devinit mthca_init_av_table(struct mthca_dev *dev)
+{
+	int err;
+
+	err = mthca_alloc_init(&dev->av_table.alloc,
+			       dev->av_table.num_ddr_avs,
+			       dev->av_table.num_ddr_avs - 1,
+			       0);
+	if (err)
+		return err;
+
+	dev->av_table.pool = pci_pool_create("mthca_av", dev->pdev,
+					     MTHCA_AV_SIZE,
+					     MTHCA_AV_SIZE, 0);
+	if (!dev->av_table.pool)
+		goto out_free_alloc;
+
+	if (!(dev->mthca_flags & MTHCA_FLAG_DDR_HIDDEN)) {
+		dev->av_table.av_map = ioremap(pci_resource_start(dev->pdev, 4) +
+					       dev->av_table.ddr_av_base -
+					       dev->ddr_start,
+					       dev->av_table.num_ddr_avs *
+					       MTHCA_AV_SIZE);
+		if (!dev->av_table.av_map)
+			goto out_free_pool;
+	} else
+		dev->av_table.av_map = NULL;
+
+	return 0;
+
+ out_free_pool:
+	pci_pool_destroy(dev->av_table.pool);
+
+ out_free_alloc:
+	mthca_alloc_cleanup(&dev->av_table.alloc);
+	return -ENOMEM;
+}
+
+void __devexit mthca_cleanup_av_table(struct mthca_dev *dev)
+{
+	if (dev->av_table.av_map)
+		iounmap(dev->av_table.av_map);
+	pci_pool_destroy(dev->av_table.pool);
+	mthca_alloc_cleanup(&dev->av_table.alloc);
+}
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_mcg.c	2004-11-23 08:10:21.371411162 -0800
@@ -0,0 +1,372 @@
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
+ * $Id: mthca_mcg.c 639 2004-08-13 17:54:32Z roland $
+ */
+
+#include <linux/init.h>
+
+#include "mthca_dev.h"
+#include "mthca_cmd.h"
+
+enum {
+	MTHCA_QP_PER_MGM = 4 * (MTHCA_MGM_ENTRY_SIZE / 16 - 2)
+};
+
+struct mthca_mgm {
+	u32 next_gid_index;
+	u32 reserved[3];
+	u8  gid[16];
+	u32 qp[MTHCA_QP_PER_MGM];
+} __attribute__((packed));
+
+static const u8 zero_gid[16];	/* automatically initialized to 0 */
+
+/*
+ * Caller must hold MCG table semaphore.  gid and mgm parameters must
+ * be properly aligned for command interface.
+ *
+ *  Returns 0 unless a firmware command error occurs.
+ *
+ * If GID is found in MGM or MGM is empty, *index = *hash, *prev = -1
+ * and *mgm holds MGM entry.
+ *
+ * if GID is found in AMGM, *index = index in AMGM, *prev = index of
+ * previous entry in hash chain and *mgm holds AMGM entry.
+ *
+ * If no AMGM exists for given gid, *index = -1, *prev = index of last
+ * entry in hash chain and *mgm holds end of hash chain.
+ */
+static int find_mgm(struct mthca_dev *dev,
+		    u8 *gid, struct mthca_mgm *mgm,
+		    u16 *hash, int *prev, int *index)
+{
+	void *mailbox;
+	u8 *mgid;
+	int err;
+	u8 status;
+
+	mailbox = kmalloc(16 + MTHCA_CMD_MAILBOX_EXTRA, GFP_KERNEL);
+	if (!mailbox)
+		return -ENOMEM;
+	mgid = MAILBOX_ALIGN(mailbox);
+
+	memcpy(mgid, gid, 16);
+
+	err = mthca_MGID_HASH(dev, mgid, hash, &status);
+	if (err)
+		goto out;
+	if (status) {
+		mthca_err(dev, "MGID_HASH returned status %02x\n", status);
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (0)
+		mthca_dbg(dev, "Hash for %04x:%04x:%04x:%04x:"
+			  "%04x:%04x:%04x:%04x is %04x\n",
+			  be16_to_cpu(((u16 *) gid)[0]), be16_to_cpu(((u16 *) gid)[1]),
+			  be16_to_cpu(((u16 *) gid)[2]), be16_to_cpu(((u16 *) gid)[3]),
+			  be16_to_cpu(((u16 *) gid)[4]), be16_to_cpu(((u16 *) gid)[5]),
+			  be16_to_cpu(((u16 *) gid)[6]), be16_to_cpu(((u16 *) gid)[7]),
+			  *hash);
+
+	*index = *hash;
+	*prev  = -1;
+
+	do {
+		err = mthca_READ_MGM(dev, *index, mgm, &status);
+		if (err)
+			goto out;
+		if (status) {
+			mthca_err(dev, "READ_MGM returned status %02x\n", status);
+			return -EINVAL;
+		}
+
+		if (!memcmp(mgm->gid, zero_gid, 16)) {
+			if (*index != *hash) {
+				mthca_err(dev, "Found zero MGID in AMGM.\n");
+				err = -EINVAL;
+			}
+			goto out;
+		}
+
+		if (!memcmp(mgm->gid, gid, 16))
+			goto out;
+
+		*prev = *index;
+		*index = be32_to_cpu(mgm->next_gid_index) >> 5;
+	} while (*index);
+
+	*index = -1;
+
+ out:
+	kfree(mailbox);
+	return err;
+}
+
+int mthca_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	struct mthca_dev *dev = to_mdev(ibqp->device);
+	void *mailbox;
+	struct mthca_mgm *mgm;
+	u16 hash;
+	int index, prev;
+	int link = 0;
+	int i;
+	int err;
+	u8 status;
+
+	mailbox = kmalloc(sizeof *mgm + MTHCA_CMD_MAILBOX_EXTRA, GFP_KERNEL);
+	if (!mailbox)
+		return -ENOMEM;
+	mgm = MAILBOX_ALIGN(mailbox);
+
+	if (down_interruptible(&dev->mcg_table.sem))
+		return -EINTR;
+
+	err = find_mgm(dev, gid->raw, mgm, &hash, &prev, &index);
+	if (err)
+		goto out;
+
+	if (index != -1) {
+		if (!memcmp(mgm->gid, zero_gid, 16))
+			memcpy(mgm->gid, gid->raw, 16);
+	} else {
+		link = 1;
+
+		index = mthca_alloc(&dev->mcg_table.alloc);
+		if (index == -1) {
+			mthca_err(dev, "No AMGM entries left\n");
+			err = -ENOMEM;
+			goto out;
+		}
+
+		err = mthca_READ_MGM(dev, index, mgm, &status);
+		if (err)
+			goto out;
+		if (status) {
+			mthca_err(dev, "READ_MGM returned status %02x\n", status);
+			err = -EINVAL;
+			goto out;
+		}
+
+		memcpy(mgm->gid, gid->raw, 16);
+		mgm->next_gid_index = 0;
+	}
+
+	for (i = 0; i < MTHCA_QP_PER_MGM; ++i)
+		if (!(mgm->qp[i] & cpu_to_be32(1 << 31))) {
+			mgm->qp[i] = cpu_to_be32(ibqp->qp_num | (1 << 31));
+			break;
+		}
+
+	if (i == MTHCA_QP_PER_MGM) {
+		mthca_err(dev, "MGM at index %x is full.\n", index);
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = mthca_WRITE_MGM(dev, index, mgm, &status);
+	if (err)
+		goto out;
+	if (status) {
+		mthca_err(dev, "WRITE_MGM returned status %02x\n", status);
+		err = -EINVAL;
+	}
+
+	if (!link)
+		goto out;
+
+	err = mthca_READ_MGM(dev, prev, mgm, &status);
+	if (err)
+		goto out;
+	if (status) {
+		mthca_err(dev, "READ_MGM returned status %02x\n", status);
+		err = -EINVAL;
+		goto out;
+	}
+
+	mgm->next_gid_index = cpu_to_be32(index << 5);
+
+	err = mthca_WRITE_MGM(dev, prev, mgm, &status);
+	if (err)
+		goto out;
+	if (status) {
+		mthca_err(dev, "WRITE_MGM returned status %02x\n", status);
+		err = -EINVAL;
+	}
+
+ out:
+	up(&dev->mcg_table.sem);
+	kfree(mailbox);
+	return err;
+}
+
+int mthca_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	struct mthca_dev *dev = to_mdev(ibqp->device);
+	void *mailbox;
+	struct mthca_mgm *mgm;
+	u16 hash;
+	int prev, index;
+	int i, loc;
+	int err;
+	u8 status;
+
+	mailbox = kmalloc(sizeof *mgm + MTHCA_CMD_MAILBOX_EXTRA, GFP_KERNEL);
+	if (!mailbox)
+		return -ENOMEM;
+	mgm = MAILBOX_ALIGN(mailbox);
+
+	if (down_interruptible(&dev->mcg_table.sem))
+		return -EINTR;
+
+	err = find_mgm(dev, gid->raw, mgm, &hash, &prev, &index);
+	if (err)
+		goto out;
+
+	if (index == -1) {	
+		mthca_err(dev, "MGID %04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x "
+			  "not found\n",
+			  be16_to_cpu(((u16 *) gid->raw)[0]),
+			  be16_to_cpu(((u16 *) gid->raw)[1]),
+			  be16_to_cpu(((u16 *) gid->raw)[2]),
+			  be16_to_cpu(((u16 *) gid->raw)[3]),
+			  be16_to_cpu(((u16 *) gid->raw)[4]),
+			  be16_to_cpu(((u16 *) gid->raw)[5]),
+			  be16_to_cpu(((u16 *) gid->raw)[6]),
+			  be16_to_cpu(((u16 *) gid->raw)[7]));
+		err = -EINVAL;
+		goto out;
+	}
+
+	for (loc = -1, i = 0; i < MTHCA_QP_PER_MGM; ++i) {
+		if (mgm->qp[i] == cpu_to_be32(ibqp->qp_num | (1 << 31)))
+			loc = i;
+		if (!(mgm->qp[i] & cpu_to_be32(1 << 31)))
+			break;
+	}
+
+	if (loc == -1) {
+		mthca_err(dev, "QP %06x not found in MGM\n", ibqp->qp_num);
+		err = -EINVAL;
+		goto out;
+	}
+
+	mgm->qp[loc]   = mgm->qp[i - 1];
+	mgm->qp[i - 1] = 0;
+
+	err = mthca_WRITE_MGM(dev, index, mgm, &status);
+	if (err)
+		goto out;
+	if (status) {
+		mthca_err(dev, "WRITE_MGM returned status %02x\n", status);
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (i != 1)
+		goto out;
+
+	goto out;
+
+	if (prev == -1) {
+		/* Remove entry from MGM */
+		if (be32_to_cpu(mgm->next_gid_index) >> 5) {
+			err = mthca_READ_MGM(dev,
+					     be32_to_cpu(mgm->next_gid_index) >> 5,
+					     mgm, &status);
+			if (err)
+				goto out;
+			if (status) {
+				mthca_err(dev, "READ_MGM returned status %02x\n",
+					  status);
+				err = -EINVAL;
+				goto out;
+			}
+		} else
+			memset(mgm->gid, 0, 16);
+
+		err = mthca_WRITE_MGM(dev, index, mgm, &status);
+		if (err)
+			goto out;
+		if (status) {
+			mthca_err(dev, "WRITE_MGM returned status %02x\n", status);
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		/* Remove entry from AMGM */
+		index = be32_to_cpu(mgm->next_gid_index) >> 5;
+		err = mthca_READ_MGM(dev, prev, mgm, &status);
+		if (err)
+			goto out;
+		if (status) {
+			mthca_err(dev, "READ_MGM returned status %02x\n", status);
+			err = -EINVAL;
+			goto out;
+		}
+
+		mgm->next_gid_index = cpu_to_be32(index << 5);
+
+		err = mthca_WRITE_MGM(dev, prev, mgm, &status);
+		if (err)
+			goto out;
+		if (status) {
+			mthca_err(dev, "WRITE_MGM returned status %02x\n", status);
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+ out:
+	up(&dev->mcg_table.sem);
+	kfree(mailbox);
+	return err;
+}
+
+int __devinit mthca_init_mcg_table(struct mthca_dev *dev)
+{
+	int err;
+
+	err = mthca_alloc_init(&dev->mcg_table.alloc,
+			       dev->limits.num_amgms,
+			       dev->limits.num_amgms - 1,
+			       0);
+	if (err)
+		return err;
+
+	init_MUTEX(&dev->mcg_table.sem);
+
+	return 0;
+}
+
+void __devexit mthca_cleanup_mcg_table(struct mthca_dev *dev)
+{
+	mthca_alloc_cleanup(&dev->mcg_table.alloc);
+}
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_mr.c	2004-11-23 08:10:21.410405413 -0800
@@ -0,0 +1,389 @@
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
+ * $Id: mthca_mr.c 1029 2004-10-20 23:16:28Z roland $
+ */
+
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+
+#include "mthca_dev.h"
+#include "mthca_cmd.h"
+
+struct mthca_mpt_entry {
+	u32 flags;
+	u32 page_size;
+	u32 key;
+	u32 pd;
+	u64 start;
+	u64 length;
+	u32 lkey;
+	u32 window_count;
+	u32 window_count_limit;
+	u64 mtt_seg;
+	u32 reserved[3];
+} __attribute__((packed));
+
+#define MTHCA_MPT_FLAG_SW_OWNS       (0xfUL << 28)
+#define MTHCA_MPT_FLAG_MIO           (1 << 17)
+#define MTHCA_MPT_FLAG_BIND_ENABLE   (1 << 15)
+#define MTHCA_MPT_FLAG_PHYSICAL      (1 <<  9)
+#define MTHCA_MPT_FLAG_REGION        (1 <<  8)
+
+#define MTHCA_MTT_FLAG_PRESENT       1
+
+/*
+ * Buddy allocator for MTT segments (currently not very efficient
+ * since it doesn't keep a free list and just searches linearly
+ * through the bitmaps)
+ */
+
+static u32 mthca_alloc_mtt(struct mthca_dev *dev, int order)
+{
+	int o;
+	int m;
+	u32 seg;
+
+	spin_lock(&dev->mr_table.mpt_alloc.lock);
+
+	for (o = order; o <= dev->mr_table.max_mtt_order; ++o) {
+		m = 1 << (dev->mr_table.max_mtt_order - o);
+		seg = find_first_bit(dev->mr_table.mtt_buddy[o], m);
+		if (seg < m)
+			goto found;
+	}
+
+	spin_unlock(&dev->mr_table.mpt_alloc.lock);
+	return -1;
+
+ found:
+	clear_bit(seg, dev->mr_table.mtt_buddy[o]);
+
+	while (o > order) {
+		--o;
+		seg <<= 1;
+		set_bit(seg ^ 1, dev->mr_table.mtt_buddy[o]);
+	}
+					  
+	spin_unlock(&dev->mr_table.mpt_alloc.lock);
+
+	seg <<= order;
+
+	return seg;
+}
+
+static void mthca_free_mtt(struct mthca_dev *dev, u32 seg, int order)
+{
+	seg >>= order;
+
+	spin_lock(&dev->mr_table.mpt_alloc.lock);
+
+	while (test_bit(seg ^ 1, dev->mr_table.mtt_buddy[order])) {
+		clear_bit(seg ^ 1, dev->mr_table.mtt_buddy[order]);
+		seg >>= 1;
+		++order;
+	}
+
+	set_bit(seg, dev->mr_table.mtt_buddy[order]);
+
+	spin_unlock(&dev->mr_table.mpt_alloc.lock);
+}
+
+int mthca_mr_alloc_notrans(struct mthca_dev *dev, u32 pd,
+			   u32 access, struct mthca_mr *mr)
+{
+	void *mailbox;
+	struct mthca_mpt_entry *mpt_entry;
+	int err;
+	u8 status;
+
+	might_sleep();
+
+	mr->order = -1;
+	mr->ibmr.lkey = mthca_alloc(&dev->mr_table.mpt_alloc);
+	if (mr->ibmr.lkey == -1)
+		return -ENOMEM;
+	mr->ibmr.rkey = mr->ibmr.lkey;
+
+	mailbox = kmalloc(sizeof *mpt_entry + MTHCA_CMD_MAILBOX_EXTRA,
+			  GFP_KERNEL);
+	if (!mailbox) {
+		mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
+		return -ENOMEM;
+	}
+	mpt_entry = MAILBOX_ALIGN(mailbox);
+
+	mpt_entry->flags = cpu_to_be32(MTHCA_MPT_FLAG_SW_OWNS     |
+				       MTHCA_MPT_FLAG_MIO         |
+				       MTHCA_MPT_FLAG_PHYSICAL    |
+				       MTHCA_MPT_FLAG_REGION      |
+				       access);
+	mpt_entry->page_size = 0;
+	mpt_entry->key       = cpu_to_be32(mr->ibmr.lkey);
+	mpt_entry->pd        = cpu_to_be32(pd);
+	mpt_entry->start     = 0;
+	mpt_entry->length    = ~0ULL;
+
+	memset(&mpt_entry->lkey, 0,
+	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, lkey));
+
+	err = mthca_SW2HW_MPT(dev, mpt_entry,
+			      mr->ibmr.lkey & (dev->limits.num_mpts - 1),
+			      &status);
+	if (err)
+		mthca_warn(dev, "SW2HW_MPT failed (%d)\n", err);
+	else if (status) {
+		mthca_warn(dev, "SW2HW_MPT returned status 0x%02x\n",
+			   status);
+		err = -EINVAL;
+	}
+
+	kfree(mailbox);
+	return err;
+}
+
+int mthca_mr_alloc_phys(struct mthca_dev *dev, u32 pd,
+			u64 *buffer_list, int buffer_size_shift,
+			int list_len, u64 iova, u64 total_size,
+			u32 access, struct mthca_mr *mr)
+{
+	void *mailbox;
+	u64 *mtt_entry;
+	struct mthca_mpt_entry *mpt_entry;
+	int err = -ENOMEM;
+	u8 status;
+	int i;
+
+	might_sleep();
+	WARN_ON(buffer_size_shift >= 32);
+
+	mr->ibmr.lkey = mthca_alloc(&dev->mr_table.mpt_alloc);
+	if (mr->ibmr.lkey == -1)
+		return -ENOMEM;
+	mr->ibmr.rkey = mr->ibmr.lkey;
+
+	for (i = dev->limits.mtt_seg_size / 8, mr->order = 0;
+	     i < list_len;
+	     i <<= 1, ++mr->order)
+		/* nothing */ ;
+
+	mr->first_seg = mthca_alloc_mtt(dev, mr->order);
+	if (mr->first_seg == -1)
+		goto err_out_mpt_free;
+
+	/*
+	 * If list_len is odd, we add one more dummy entry for
+	 * firmware efficiency.
+	 */
+	mailbox = kmalloc(max(sizeof *mpt_entry,
+			      (size_t) 8 * (list_len + (list_len & 1) + 2)) +
+			  MTHCA_CMD_MAILBOX_EXTRA,
+			  GFP_KERNEL);
+	if (!mailbox)
+		goto err_out_free_mtt;
+
+	mtt_entry = MAILBOX_ALIGN(mailbox);
+
+	mtt_entry[0] = cpu_to_be64(dev->mr_table.mtt_base +
+				   mr->first_seg * dev->limits.mtt_seg_size);
+	mtt_entry[1] = 0;
+	for (i = 0; i < list_len; ++i)
+		mtt_entry[i + 2] = cpu_to_be64(buffer_list[i] |
+					       MTHCA_MTT_FLAG_PRESENT);
+	if (list_len & 1) {
+		mtt_entry[i + 2] = 0;
+		++list_len;
+	}
+
+	if (0) {
+		mthca_dbg(dev, "Dumping MPT entry\n");
+		for (i = 0; i < list_len + 2; ++i)
+			printk(KERN_ERR "[%2d] %016llx\n",
+			       i, (unsigned long long) be64_to_cpu(mtt_entry[i]));
+	}
+
+	err = mthca_WRITE_MTT(dev, mtt_entry, list_len, &status);
+	if (err) {
+		mthca_warn(dev, "WRITE_MTT failed (%d)\n", err);
+		goto err_out_mailbox_free;
+	}
+	if (status) {
+		mthca_warn(dev, "WRITE_MTT returned status 0x%02x\n",
+			   status);
+		err = -EINVAL;
+		goto err_out_mailbox_free;
+	}
+
+	mpt_entry = MAILBOX_ALIGN(mailbox);
+
+	mpt_entry->flags = cpu_to_be32(MTHCA_MPT_FLAG_SW_OWNS     |
+				       MTHCA_MPT_FLAG_MIO         |
+				       MTHCA_MPT_FLAG_REGION      |
+				       access);
+
+	mpt_entry->page_size = cpu_to_be32(buffer_size_shift - 12);
+	mpt_entry->key       = cpu_to_be32(mr->ibmr.lkey);
+	mpt_entry->pd        = cpu_to_be32(pd);
+	mpt_entry->start     = cpu_to_be64(iova);
+	mpt_entry->length    = cpu_to_be64(total_size);
+	memset(&mpt_entry->lkey, 0,
+	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, lkey));
+	mpt_entry->mtt_seg   = cpu_to_be64(dev->mr_table.mtt_base +
+					   mr->first_seg * dev->limits.mtt_seg_size);
+
+	if (0) {
+		mthca_dbg(dev, "Dumping MPT entry %08x:\n", mr->ibmr.lkey);
+		for (i = 0; i < sizeof (struct mthca_mpt_entry) / 4; ++i) {
+			if (i % 4 == 0)
+				printk("[%02x] ", i * 4);
+			printk(" %08x", be32_to_cpu(((u32 *) mpt_entry)[i]));
+			if ((i + 1) % 4 == 0)
+				printk("\n");
+		}
+	}
+
+	err = mthca_SW2HW_MPT(dev, mpt_entry,
+			      mr->ibmr.lkey & (dev->limits.num_mpts - 1),
+			      &status);
+	if (err)
+		mthca_warn(dev, "SW2HW_MPT failed (%d)\n", err);
+	else if (status) {
+		mthca_warn(dev, "SW2HW_MPT returned status 0x%02x\n",
+			   status);
+		err = -EINVAL;
+	}
+
+	kfree(mailbox);
+	return err;
+
+ err_out_mailbox_free:
+	kfree(mailbox);
+
+ err_out_free_mtt:
+	mthca_free_mtt(dev, mr->first_seg, mr->order);
+
+ err_out_mpt_free:
+	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
+	return err;
+}
+
+void mthca_free_mr(struct mthca_dev *dev, struct mthca_mr *mr)
+{
+	int err;
+	u8 status;
+
+	might_sleep();
+
+	err = mthca_HW2SW_MPT(dev, NULL,
+			      mr->ibmr.lkey & (dev->limits.num_mpts - 1),
+			      &status);
+	if (err)
+		mthca_warn(dev, "HW2SW_MPT failed (%d)\n", err);
+	else if (status)
+		mthca_warn(dev, "HW2SW_MPT returned status 0x%02x\n",
+			   status);
+
+	if (mr->order >= 0)
+		mthca_free_mtt(dev, mr->first_seg, mr->order);
+
+	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);		   
+}
+
+int __devinit mthca_init_mr_table(struct mthca_dev *dev)
+{
+	int err;
+	int i, s;
+
+	err = mthca_alloc_init(&dev->mr_table.mpt_alloc,
+			       dev->limits.num_mpts,
+			       ~0, dev->limits.reserved_mrws);
+	if (err)
+		return err;
+
+	err = -ENOMEM;
+
+	for (i = 1, dev->mr_table.max_mtt_order = 0;
+	     i < dev->limits.num_mtt_segs;
+	     i <<= 1, ++dev->mr_table.max_mtt_order)
+		/* nothing */ ;
+
+	dev->mr_table.mtt_buddy = kmalloc((dev->mr_table.max_mtt_order + 1) *
+					  sizeof (long *),
+					  GFP_KERNEL);
+	if (!dev->mr_table.mtt_buddy)
+		goto err_out;
+
+	for (i = 0; i <= dev->mr_table.max_mtt_order; ++i)
+		dev->mr_table.mtt_buddy[i] = NULL;
+
+	for (i = 0; i <= dev->mr_table.max_mtt_order; ++i) {
+		s = BITS_TO_LONGS(1 << (dev->mr_table.max_mtt_order - i));
+		dev->mr_table.mtt_buddy[i] = kmalloc(s * sizeof (long),
+						     GFP_KERNEL);
+		if (!dev->mr_table.mtt_buddy[i])
+			goto err_out_free;
+		bitmap_zero(dev->mr_table.mtt_buddy[i],
+			    1 << (dev->mr_table.max_mtt_order - i));
+	}
+
+	set_bit(0, dev->mr_table.mtt_buddy[dev->mr_table.max_mtt_order]);
+
+	for (i = 0; i < dev->mr_table.max_mtt_order; ++i)
+		if (1 << i >= dev->limits.reserved_mtts)
+			break;
+
+	if (i == dev->mr_table.max_mtt_order) {
+		mthca_err(dev, "MTT table of order %d is "
+			  "too small.\n", i);
+		goto err_out_free;
+	}
+
+	(void) mthca_alloc_mtt(dev, i);
+
+	return 0;
+
+ err_out_free:
+	for (i = 0; i <= dev->mr_table.max_mtt_order; ++i)
+		kfree(dev->mr_table.mtt_buddy[i]);
+
+ err_out:
+	mthca_alloc_cleanup(&dev->mr_table.mpt_alloc);
+
+	return err;
+}
+
+void __devexit mthca_cleanup_mr_table(struct mthca_dev *dev)
+{
+	int i;
+
+	/* XXX check if any MRs are still allocated? */
+	for (i = 0; i <= dev->mr_table.max_mtt_order; ++i)
+		kfree(dev->mr_table.mtt_buddy[i]);
+	kfree(dev->mr_table.mtt_buddy);
+	mthca_alloc_cleanup(&dev->mr_table.mpt_alloc);
+}
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_pd.c	2004-11-23 08:10:21.436401580 -0800
@@ -0,0 +1,76 @@
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
+ * $Id: mthca_pd.c 1029 2004-10-20 23:16:28Z roland $
+ */
+
+#include <linux/init.h>
+#include <linux/errno.h>
+
+#include "mthca_dev.h"
+
+int mthca_pd_alloc(struct mthca_dev *dev, struct mthca_pd *pd)
+{
+	int err;
+
+	might_sleep();
+
+	atomic_set(&pd->sqp_count, 0);
+	pd->pd_num = mthca_alloc(&dev->pd_table.alloc);
+	if (pd->pd_num == -1)
+		return -ENOMEM;
+
+	err = mthca_mr_alloc_notrans(dev, pd->pd_num,
+				     MTHCA_MPT_FLAG_LOCAL_READ |
+				     MTHCA_MPT_FLAG_LOCAL_WRITE,
+				     &pd->ntmr);
+	if (err)
+		mthca_free(&dev->pd_table.alloc, pd->pd_num);
+
+	return err;
+}
+
+void mthca_pd_free(struct mthca_dev *dev, struct mthca_pd *pd)
+{
+	might_sleep();
+	mthca_free_mr(dev, &pd->ntmr);
+	mthca_free(&dev->pd_table.alloc, pd->pd_num);
+}
+
+int __devinit mthca_init_pd_table(struct mthca_dev *dev)
+{
+	return mthca_alloc_init(&dev->pd_table.alloc,
+				dev->limits.num_pds,
+				(1 << 24) - 1,
+				dev->limits.reserved_pds);
+}
+
+void __devexit mthca_cleanup_pd_table(struct mthca_dev *dev)
+{
+	/* XXX check if any PDs are still allocated? */
+	mthca_alloc_cleanup(&dev->pd_table.alloc);
+}
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */

