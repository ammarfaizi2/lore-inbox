Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbUKWQtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUKWQtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 11:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUKWQtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 11:49:50 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:37247 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261338AbUKWQO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:14:59 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123814.UmUHBktptJzFvsrR@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:14:52 -0800
Message-Id: <20041123814.y2QOtktHRf35o3M9@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][7/21] Add Mellanox HCA low-level driver
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:14:58.0662 (UTC) FILETIME=[93F1B060:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a low-level driver for Mellanox MT23108 and MT25208 HCAs.  The
MT25208 is only fully supported when in MT23108 compatibility mode;
only the very beginnings of support for native MT25208 mode (required
for HCAs without local memory) is present.

(As a side note, I believe this driver would be the first in-tree
consumer of the PCI MSI/MSI-X API)

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/drivers/infiniband/Kconfig	2004-11-23 08:10:16.399144313 -0800
+++ linux-bk/drivers/infiniband/Kconfig	2004-11-23 08:10:19.036755403 -0800
@@ -8,4 +8,6 @@
 	  any protocols you wish to use as well as drivers for your
 	  InfiniBand hardware.
 
+source "drivers/infiniband/hw/mthca/Kconfig"
+
 endmenu
--- linux-bk.orig/drivers/infiniband/Makefile	2004-11-23 08:10:16.436138859 -0800
+++ linux-bk/drivers/infiniband/Makefile	2004-11-23 08:10:18.998761005 -0800
@@ -1 +1,2 @@
 obj-$(CONFIG_INFINIBAND)		+= core/
+obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mthca/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/Kconfig	2004-11-23 08:10:19.090747442 -0800
@@ -0,0 +1,26 @@
+config INFINIBAND_MTHCA
+	tristate "Mellanox HCA support"
+	depends on PCI && INFINIBAND
+	---help---
+	  This is a low-level driver for Mellanox InfiniHost host
+	  channel adapters (HCAs), including the MT23108 PCI-X HCA
+	  ("Tavor") and the MT25208 PCI Express HCA ("Arbel").
+
+config INFINIBAND_MTHCA_DEBUG
+	bool "Verbose debugging output"
+	depends on INFINIBAND_MTHCA
+	default n
+	---help---
+	  This option causes the mthca driver produce a bunch of debug
+	  messages.  Select this is you are developing the driver or
+	  trying to diagnose a problem.
+
+config INFINIBAND_MTHCA_SSE_DOORBELL
+	bool "SSE doorbell code"
+	depends on INFINIBAND_MTHCA && X86 && !X86_64
+	default n
+	---help---
+	  This option will have the mthca driver use SSE instructions
+	  to ring hardware doorbell registers.  This may improve
+	  performance for some workloads, but the driver will not run
+	  on processors without SSE instructions.
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/Makefile	2004-11-23 08:10:19.146739186 -0800
@@ -0,0 +1,12 @@
+EXTRA_CFLAGS += -Idrivers/infiniband/include
+
+ifdef CONFIG_INFINIBAND_MTHCA_DEBUG
+EXTRA_CFLAGS += -DDEBUG
+endif
+
+obj-$(CONFIG_INFINIBAND_MTHCA) += ib_mthca.o
+
+ib_mthca-y :=	mthca_main.o mthca_cmd.o mthca_profile.o mthca_reset.o \
+		mthca_allocator.o mthca_eq.o mthca_pd.o mthca_cq.o \
+		mthca_mr.o mthca_qp.o mthca_av.o mthca_mcg.o mthca_mad.o \
+		mthca_provider.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_allocator.c	2004-11-23 08:10:19.197731667 -0800
@@ -0,0 +1,175 @@
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
+ * $Id: mthca_allocator.c 182 2004-05-21 22:19:11Z roland $
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/bitmap.h> 
+
+#include "mthca_dev.h"
+
+/* Trivial bitmap-based allocator */
+u32 mthca_alloc(struct mthca_alloc *alloc)
+{
+	u32 obj;
+
+	spin_lock(&alloc->lock);
+	obj = find_next_zero_bit(alloc->table, alloc->max, alloc->last);
+	if (obj >= alloc->max) {
+		alloc->top = (alloc->top + alloc->max) & alloc->mask;
+		obj = find_first_zero_bit(alloc->table, alloc->max);
+	}
+
+	if (obj < alloc->max) {
+		set_bit(obj, alloc->table);
+		obj |= alloc->top;
+	} else
+		obj = -1;
+
+	spin_unlock(&alloc->lock);
+
+	return obj;
+}
+
+void mthca_free(struct mthca_alloc *alloc, u32 obj)
+{
+	obj &= alloc->max - 1;
+	spin_lock(&alloc->lock);
+	clear_bit(obj, alloc->table);
+	alloc->last = min(alloc->last, obj);
+	alloc->top = (alloc->top + alloc->max) & alloc->mask;
+	spin_unlock(&alloc->lock);
+}
+
+int mthca_alloc_init(struct mthca_alloc *alloc, u32 num, u32 mask,
+		     u32 reserved)
+{
+	int i;
+
+	/* num must be a power of 2 */
+	if (num != 1 << (ffs(num) - 1))
+		return -EINVAL;
+
+	alloc->last = 0;
+	alloc->top  = 0;
+	alloc->max  = num;
+	alloc->mask = mask;
+	spin_lock_init(&alloc->lock);
+	alloc->table = kmalloc(BITS_TO_LONGS(num) * sizeof (long),
+			       GFP_KERNEL);
+	if (!alloc->table)
+		return -ENOMEM;
+
+	bitmap_zero(alloc->table, num);
+	for (i = 0; i < reserved; ++i)
+		set_bit(i, alloc->table);
+
+	return 0;
+}
+
+void mthca_alloc_cleanup(struct mthca_alloc *alloc)
+{
+	kfree(alloc->table);
+}
+
+/*
+ * Array of pointers with lazy allocation of leaf pages.  Callers of
+ * _get, _set and _clear methods must use a lock or otherwise
+ * serialize access to the array.
+ */
+
+void *mthca_array_get(struct mthca_array *array, int index)
+{
+	int p = (index * sizeof (void *)) >> PAGE_SHIFT;
+
+	if (array->page_list[p].page) {
+		int i = index & (PAGE_SIZE / sizeof (void *) - 1);
+		return array->page_list[p].page[i];
+	} else
+		return NULL;
+}
+
+int mthca_array_set(struct mthca_array *array, int index, void *value)
+{
+	int p = (index * sizeof (void *)) >> PAGE_SHIFT;
+
+	/* Allocate with GFP_ATOMIC because we'll be called with locks held. */
+	if (!array->page_list[p].page)
+		array->page_list[p].page = (void **) get_zeroed_page(GFP_ATOMIC);
+
+	if (!array->page_list[p].page)
+		return -ENOMEM;
+
+	array->page_list[p].page[index & (PAGE_SIZE / sizeof (void *) - 1)] =
+		value;
+	++array->page_list[p].used;
+
+	return 0;
+}
+
+void mthca_array_clear(struct mthca_array *array, int index)
+{
+	int p = (index * sizeof (void *)) >> PAGE_SHIFT;
+
+	if (--array->page_list[p].used == 0) {
+		free_page((unsigned long) array->page_list[p].page);
+		array->page_list[p].page = NULL;
+	}
+
+	if (array->page_list[p].used < 0)
+		pr_debug("Array %p index %d page %d with ref count %d < 0\n",
+			 array, index, p, array->page_list[p].used);
+}
+
+int mthca_array_init(struct mthca_array *array, int nent)
+{
+	int npage = (nent * sizeof (void *) + PAGE_SIZE - 1) / PAGE_SIZE;
+	int i;
+
+	array->page_list = kmalloc(npage * sizeof *array->page_list, GFP_KERNEL);
+	if (!array->page_list)
+		return -ENOMEM;
+
+	for (i = 0; i < npage; ++i) {
+		array->page_list[i].page = NULL;
+		array->page_list[i].used = 0;
+	}
+
+	return 0;
+}
+
+void mthca_array_cleanup(struct mthca_array *array, int nent)
+{
+	int i;
+
+	for (i = 0; i < (nent * sizeof (void *) + PAGE_SIZE - 1) / PAGE_SIZE; ++i)
+		free_page((unsigned long) array->page_list[i].page);
+
+	kfree(array->page_list);
+}
+
+/*
+ * Local Variables:
+ *  c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_config_reg.h	2004-11-23 08:10:19.234726213 -0800
@@ -0,0 +1,51 @@
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
+ * $Id: mthca_config_reg.h 182 2004-05-21 22:19:11Z roland $
+ */
+
+#ifndef MTHCA_CONFIG_REG_H
+#define MTHCA_CONFIG_REG_H
+
+#include <asm/page.h>
+
+#define MTHCA_HCR_BASE         0x80680
+#define MTHCA_HCR_SIZE         0x0001c
+#define MTHCA_ECR_BASE         0x80700
+#define MTHCA_ECR_SIZE         0x00008
+#define MTHCA_ECR_CLR_BASE     0x80708
+#define MTHCA_ECR_CLR_SIZE     0x00008
+#define MTHCA_ECR_OFFSET       (MTHCA_ECR_BASE     - MTHCA_HCR_BASE)
+#define MTHCA_ECR_CLR_OFFSET   (MTHCA_ECR_CLR_BASE - MTHCA_HCR_BASE)
+#define MTHCA_CLR_INT_BASE     0xf00d8
+#define MTHCA_CLR_INT_SIZE     0x00008
+
+#define MTHCA_MAP_HCR_SIZE     (MTHCA_ECR_CLR_BASE   + \
+			        MTHCA_ECR_CLR_SIZE   - \
+			        MTHCA_HCR_BASE)
+
+#endif /* MTHCA_CONFIG_REG_H */
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_dev.h	2004-11-23 08:10:19.274720315 -0800
@@ -0,0 +1,387 @@
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
+ * $Id: mthca_dev.h 1229 2004-11-15 04:50:35Z roland $
+ */
+
+#ifndef MTHCA_DEV_H
+#define MTHCA_DEV_H
+
+#include <linux/spinlock.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <asm/semaphore.h>
+#include <asm/scatterlist.h>
+
+#include "mthca_provider.h"
+#include "mthca_doorbell.h"
+
+#define DRV_NAME	"ib_mthca"
+#define PFX		DRV_NAME ": "
+#define DRV_VERSION	"0.06-pre"
+#define DRV_RELDATE	"November 8, 2004"
+
+/* Types of supported HCA */
+enum {
+	TAVOR,			/* MT23108                        */
+	ARBEL_COMPAT,		/* MT25208 in Tavor compat mode   */
+	ARBEL_NATIVE		/* MT25208 with extended features */
+};
+
+enum {
+	MTHCA_FLAG_DDR_HIDDEN = 1 << 1,
+	MTHCA_FLAG_SRQ        = 1 << 2,
+	MTHCA_FLAG_MSI        = 1 << 3,
+	MTHCA_FLAG_MSI_X      = 1 << 4,
+	MTHCA_FLAG_NO_LAM     = 1 << 5
+};
+
+enum {
+	MTHCA_KAR_PAGE  = 1,
+	MTHCA_MAX_PORTS = 2
+};
+
+enum {
+	MTHCA_MPT_ENTRY_SIZE  =  0x40,
+	MTHCA_EQ_CONTEXT_SIZE =  0x40,
+	MTHCA_CQ_CONTEXT_SIZE =  0x40,
+	MTHCA_QP_CONTEXT_SIZE = 0x200,
+	MTHCA_AV_SIZE         =  0x20,
+	MTHCA_MGM_ENTRY_SIZE  =  0x40
+};
+
+enum {
+	MTHCA_EQ_CMD,
+	MTHCA_EQ_ASYNC,
+	MTHCA_EQ_COMP,
+	MTHCA_NUM_EQ
+};
+
+struct mthca_cmd {
+	int                       use_events;
+	struct semaphore          hcr_sem;
+	struct semaphore 	  poll_sem;
+	struct semaphore 	  event_sem;
+	int              	  max_cmds;
+	spinlock_t                context_lock;
+	int                       free_head;
+	struct mthca_cmd_context *context;
+	u16                       token_mask;
+};
+
+struct mthca_limits {
+	int      num_ports;
+	int      vl_cap;
+	int      mtu_cap;
+	int      gid_table_len;
+	int      pkey_table_len;
+	int      local_ca_ack_delay;
+	int      max_sg;
+	int      num_qps;
+	int      reserved_qps;
+	int      num_srqs;
+	int      reserved_srqs;
+	int      num_eecs;
+	int      reserved_eecs;
+	int      num_cqs;
+	int      reserved_cqs;
+	int      num_eqs;
+	int      reserved_eqs;
+	int      num_mpts;
+	int      num_mtt_segs;
+	int      mtt_seg_size;
+	int      reserved_mtts;
+	int      reserved_mrws;
+	int      num_rdbs;
+	int      reserved_uars;
+	int      num_mgms;
+	int      num_amgms;
+	int      reserved_mcgs;
+	int      num_pds;
+	int      reserved_pds;
+};
+
+struct mthca_alloc {
+	u32            last;
+	u32            top;
+	u32            max;
+	u32            mask;
+	spinlock_t     lock;
+	unsigned long *table;
+};
+
+struct mthca_array {
+	struct {
+		void    **page;
+		int       used;
+	} *page_list;
+};
+
+struct mthca_pd_table {
+	struct mthca_alloc alloc;
+};
+
+struct mthca_mr_table {
+	struct mthca_alloc mpt_alloc;
+	int                max_mtt_order;
+	unsigned long    **mtt_buddy;
+	u64                mtt_base;
+};
+
+struct mthca_eq_table {
+	struct mthca_alloc alloc;
+	void __iomem      *clr_int;
+	u32                clr_mask;
+	struct mthca_eq    eq[MTHCA_NUM_EQ];
+	int                have_irq;
+	u8                 inta_pin;
+};
+
+struct mthca_cq_table {
+	struct mthca_alloc alloc;
+	spinlock_t         lock;
+	struct mthca_array cq;
+};
+
+struct mthca_qp_table {
+	struct mthca_alloc alloc;
+	int                sqp_start;
+	spinlock_t         lock;
+	struct mthca_array qp;
+};
+
+struct mthca_av_table {
+	struct pci_pool   *pool;
+	int                num_ddr_avs;
+	u64                ddr_av_base;
+	void __iomem      *av_map;
+	struct mthca_alloc alloc;
+};
+
+struct mthca_mcg_table {
+	struct semaphore   sem;
+	struct mthca_alloc alloc;
+};
+
+struct mthca_dev {
+	struct ib_device  ib_dev;
+	struct pci_dev   *pdev;
+
+	int          	 hca_type;
+	unsigned long	 mthca_flags;
+
+	u32              rev_id;
+
+	/* firmware info */
+	u64              fw_ver;
+	union {
+		struct {
+			u64 fw_start;
+			u64 fw_end;
+		}        tavor;
+		struct {
+			u64 clr_int_base;
+			u64 eq_arm_base;
+			u64 eq_set_ci_base;
+			struct scatterlist *mem;
+			u16 fw_pages;
+		}        arbel;
+	}                fw;
+
+	u64              ddr_start;
+	u64              ddr_end;
+
+	MTHCA_DECLARE_DOORBELL_LOCK(doorbell_lock)
+
+	void __iomem    *hcr;
+	void __iomem    *clr_base;
+	void __iomem    *kar;
+
+	struct mthca_cmd    cmd;
+	struct mthca_limits limits;
+
+	struct mthca_pd_table  pd_table;
+	struct mthca_mr_table  mr_table;
+	struct mthca_eq_table  eq_table;
+	struct mthca_cq_table  cq_table;
+	struct mthca_qp_table  qp_table;
+	struct mthca_av_table  av_table;
+	struct mthca_mcg_table mcg_table;
+
+	struct mthca_pd       driver_pd;
+	struct mthca_mr       driver_mr;
+
+	struct ib_mad_agent  *send_agent[MTHCA_MAX_PORTS][2];
+	struct ib_ah         *sm_ah[MTHCA_MAX_PORTS];
+	spinlock_t            sm_lock;
+};
+
+#define mthca_dbg(mdev, format, arg...) \
+	dev_dbg(&mdev->pdev->dev, format, ## arg)
+#define mthca_err(mdev, format, arg...) \
+	dev_err(&mdev->pdev->dev, format, ## arg)
+#define mthca_info(mdev, format, arg...) \
+	dev_info(&mdev->pdev->dev, format, ## arg)
+#define mthca_warn(mdev, format, arg...) \
+	dev_warn(&mdev->pdev->dev, format, ## arg)
+
+extern void __buggy_use_of_MTHCA_GET(void);
+extern void __buggy_use_of_MTHCA_PUT(void);
+
+#define MTHCA_GET(dest, source, offset)                               \
+	do {                                                          \
+		void *__p = (char *) (source) + (offset);             \
+		switch (sizeof (dest)) {                              \
+			case 1: (dest) = *(u8 *) __p;       break;    \
+			case 2: (dest) = be16_to_cpup(__p); break;    \
+			case 4: (dest) = be32_to_cpup(__p); break;    \
+			case 8: (dest) = be64_to_cpup(__p); break;    \
+			default: __buggy_use_of_MTHCA_GET();          \
+		}                                                     \
+	} while (0)
+
+#define MTHCA_PUT(dest, source, offset)                               \
+	do {                                                          \
+		__typeof__(source) *__p =                             \
+			(__typeof__(source) *) ((char *) (dest) + (offset)); \
+		switch (sizeof(source)) {                             \
+			case 1: *__p = (source);            break;    \
+			case 2: *__p = cpu_to_be16(source); break;    \
+			case 4: *__p = cpu_to_be32(source); break;    \
+			case 8: *__p = cpu_to_be64(source); break;    \
+			default: __buggy_use_of_MTHCA_PUT();          \
+		}                                                     \
+	} while (0)
+
+int mthca_reset(struct mthca_dev *mdev);
+
+u32 mthca_alloc(struct mthca_alloc *alloc);
+void mthca_free(struct mthca_alloc *alloc, u32 obj);
+int mthca_alloc_init(struct mthca_alloc *alloc, u32 num, u32 mask,
+		     u32 reserved);
+void mthca_alloc_cleanup(struct mthca_alloc *alloc);
+void *mthca_array_get(struct mthca_array *array, int index);
+int mthca_array_set(struct mthca_array *array, int index, void *value);
+void mthca_array_clear(struct mthca_array *array, int index);
+int mthca_array_init(struct mthca_array *array, int nent);
+void mthca_array_cleanup(struct mthca_array *array, int nent);
+
+int mthca_init_pd_table(struct mthca_dev *dev);
+int mthca_init_mr_table(struct mthca_dev *dev);
+int mthca_init_eq_table(struct mthca_dev *dev);
+int mthca_init_cq_table(struct mthca_dev *dev);
+int mthca_init_qp_table(struct mthca_dev *dev);
+int mthca_init_av_table(struct mthca_dev *dev);
+int mthca_init_mcg_table(struct mthca_dev *dev);
+
+void mthca_cleanup_pd_table(struct mthca_dev *dev);
+void mthca_cleanup_mr_table(struct mthca_dev *dev);
+void mthca_cleanup_eq_table(struct mthca_dev *dev);
+void mthca_cleanup_cq_table(struct mthca_dev *dev);
+void mthca_cleanup_qp_table(struct mthca_dev *dev);
+void mthca_cleanup_av_table(struct mthca_dev *dev);
+void mthca_cleanup_mcg_table(struct mthca_dev *dev);
+
+int mthca_register_device(struct mthca_dev *dev);
+void mthca_unregister_device(struct mthca_dev *dev);
+
+int mthca_pd_alloc(struct mthca_dev *dev, struct mthca_pd *pd);
+void mthca_pd_free(struct mthca_dev *dev, struct mthca_pd *pd);
+
+int mthca_mr_alloc_notrans(struct mthca_dev *dev, u32 pd,
+			   u32 access, struct mthca_mr *mr);
+int mthca_mr_alloc_phys(struct mthca_dev *dev, u32 pd,
+			u64 *buffer_list, int buffer_size_shift,
+			int list_len, u64 iova, u64 total_size,
+			u32 access, struct mthca_mr *mr);
+void mthca_free_mr(struct mthca_dev *dev, struct mthca_mr *mr);
+
+int mthca_poll_cq(struct ib_cq *ibcq, int num_entries,
+		  struct ib_wc *entry);
+void mthca_arm_cq(struct mthca_dev *dev, struct mthca_cq *cq,
+		  int solicited);
+int mthca_init_cq(struct mthca_dev *dev, int nent,
+		  struct mthca_cq *cq);
+void mthca_free_cq(struct mthca_dev *dev,
+		   struct mthca_cq *cq);
+void mthca_cq_event(struct mthca_dev *dev, u32 cqn);
+void mthca_cq_clean(struct mthca_dev *dev, u32 cqn, u32 qpn);
+
+void mthca_qp_event(struct mthca_dev *dev, u32 qpn,
+		    enum ib_event_type event_type);
+int mthca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask);
+int mthca_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
+		    struct ib_send_wr **bad_wr);
+int mthca_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
+		       struct ib_recv_wr **bad_wr);
+int mthca_free_err_wqe(struct mthca_qp *qp, int is_send,
+		       int index, int *dbd, u32 *new_wqe);
+int mthca_alloc_qp(struct mthca_dev *dev,
+		   struct mthca_pd *pd,
+		   struct mthca_cq *send_cq,
+		   struct mthca_cq *recv_cq,
+		   enum ib_qp_type type,
+		   enum ib_sig_type send_policy,
+		   enum ib_sig_type recv_policy,
+		   struct mthca_qp *qp);
+int mthca_alloc_sqp(struct mthca_dev *dev,
+		    struct mthca_pd *pd,
+		    struct mthca_cq *send_cq,
+		    struct mthca_cq *recv_cq,
+		    enum ib_sig_type send_policy,
+		    enum ib_sig_type recv_policy,
+		    int qpn,
+		    int port,
+		    struct mthca_sqp *sqp);
+void mthca_free_qp(struct mthca_dev *dev, struct mthca_qp *qp);
+int mthca_create_ah(struct mthca_dev *dev,
+		    struct mthca_pd *pd,
+		    struct ib_ah_attr *ah_attr,
+		    struct mthca_ah *ah);
+int mthca_destroy_ah(struct mthca_dev *dev, struct mthca_ah *ah);
+int mthca_read_ah(struct mthca_dev *dev, struct mthca_ah *ah,
+		  struct ib_ud_header *header);
+
+int mthca_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid);
+int mthca_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid);
+
+int mthca_process_mad(struct ib_device *ibdev,
+		      int mad_flags,
+		      u8 port_num,
+		      u16 slid,
+		      struct ib_mad *in_mad,
+		      struct ib_mad *out_mad);
+int mthca_create_agents(struct mthca_dev *dev);
+void mthca_free_agents(struct mthca_dev *dev);
+
+static inline struct mthca_dev *to_mdev(struct ib_device *ibdev)
+{
+	return container_of(ibdev, struct mthca_dev, ib_dev);
+}
+
+#endif /* MTHCA_DEV_H */
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_doorbell.h	2004-11-23 08:10:19.314714418 -0800
@@ -0,0 +1,119 @@
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
+ * $Id: mthca_doorbell.h 1238 2004-11-15 21:58:14Z roland $
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/preempt.h>
+
+#define MTHCA_RD_DOORBELL      0x00
+#define MTHCA_SEND_DOORBELL    0x10
+#define MTHCA_RECEIVE_DOORBELL 0x18
+#define MTHCA_CQ_DOORBELL      0x20
+#define MTHCA_EQ_DOORBELL      0x28
+
+#if BITS_PER_LONG == 64
+/*
+ * Assume that we can just write a 64-bit doorbell atomically.  s390
+ * actually doesn't have writeq() but S/390 systems don't even have
+ * PCI so we won't worry about it.
+ */
+
+#define MTHCA_DECLARE_DOORBELL_LOCK(name)
+#define MTHCA_INIT_DOORBELL_LOCK(ptr)    do { } while (0)
+#define MTHCA_GET_DOORBELL_LOCK(ptr)      (NULL)
+
+static inline void mthca_write64(u32 val[2], void __iomem *dest,
+				 spinlock_t *doorbell_lock)
+{
+	__raw_writeq(*(u64 *) val, dest);
+}
+
+#elif defined(CONFIG_INFINIBAND_MTHCA_SSE_DOORBELL)
+/* Use SSE to write 64 bits atomically without a lock. */
+
+#define MTHCA_DECLARE_DOORBELL_LOCK(name)
+#define MTHCA_INIT_DOORBELL_LOCK(ptr)    do { } while (0)
+#define MTHCA_GET_DOORBELL_LOCK(ptr)      (NULL)
+
+static inline unsigned long mthca_get_fpu(void)
+{
+	unsigned long cr0;
+
+	preempt_disable();
+	asm volatile("mov %%cr0,%0; clts" : "=r" (cr0));
+	return cr0;
+}
+
+static inline void mthca_put_fpu(unsigned long cr0)
+{
+	asm volatile("mov %0,%%cr0" : : "r" (cr0));
+	preempt_enable();
+}
+
+static inline void mthca_write64(u32 val[2], void __iomem *dest,
+				 spinlock_t *doorbell_lock)
+{
+	/* i386 stack is aligned to 8 bytes, so this should be OK: */
+	u8 xmmsave[8] __attribute__((aligned(8)));
+	unsigned long cr0;
+
+	cr0 = mthca_get_fpu();
+
+	asm volatile (
+		"movlps %%xmm0,(%0); \n\t"
+		"movlps (%1),%%xmm0; \n\t"
+		"movlps %%xmm0,(%2); \n\t"
+		"movlps (%0),%%xmm0; \n\t"
+		:
+		: "r" (xmmsave), "r" (val), "r" (dest)
+		: "memory" );
+
+	mthca_put_fpu(cr0);
+}
+
+#else
+/* Just fall back to a spinlock to protect the doorbell */
+
+#define MTHCA_DECLARE_DOORBELL_LOCK(name) spinlock_t name;
+#define MTHCA_INIT_DOORBELL_LOCK(ptr)     spin_lock_init(ptr)
+#define MTHCA_GET_DOORBELL_LOCK(ptr)      (ptr)
+
+static inline void mthca_write64(u32 val[2], void __iomem *dest,
+				 spinlock_t *doorbell_lock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(doorbell_lock, flags);
+	__raw_writel(val[0], dest);
+	__raw_writel(val[1], dest + 4);
+	spin_unlock_irqrestore(doorbell_lock, flags);
+}
+
+#endif
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_main.c	2004-11-23 08:10:19.352708816 -0800
@@ -0,0 +1,888 @@
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
+ * $Id: mthca_main.c 1229 2004-11-15 04:50:35Z roland $
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+
+#ifdef CONFIG_INFINIBAND_MTHCA_SSE_DOORBELL
+#include <asm/cpufeature.h>
+#endif
+
+#include "mthca_dev.h"
+#include "mthca_config_reg.h"
+#include "mthca_cmd.h"
+#include "mthca_profile.h"
+
+MODULE_AUTHOR("Roland Dreier");
+MODULE_DESCRIPTION("Mellanox InfiniBand HCA low-level driver");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION(DRV_VERSION);
+
+#ifdef CONFIG_PCI_MSI
+
+static int msi_x = 0;
+module_param(msi_x, int, 0444);
+MODULE_PARM_DESC(msi_x, "attempt to use MSI-X if nonzero");
+
+static int msi = 0;
+module_param(msi, int, 0444);
+MODULE_PARM_DESC(msi, "attempt to use MSI if nonzero");
+
+#else /* CONFIG_PCI_MSI */
+
+#define msi_x (0)
+#define msi   (0)
+
+#endif /* CONFIG_PCI_MSI */
+
+static const char mthca_version[] __devinitdata =
+	"ib_mthca: Mellanox InfiniBand HCA driver v"
+	DRV_VERSION " (" DRV_RELDATE ")\n";
+
+static int __devinit mthca_tune_pci(struct mthca_dev *mdev)
+{
+	int cap;
+	u16 val;
+
+	/* First try to max out Read Byte Count */
+	cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_PCIX);
+	if (cap) {
+		if (pci_read_config_word(mdev->pdev, cap + PCI_X_CMD, &val)) {
+			mthca_err(mdev, "Couldn't read PCI-X command register, "
+				  "aborting.\n");
+			return -ENODEV;
+		}
+		val = (val & ~PCI_X_CMD_MAX_READ) | (3 << 2);
+		if (pci_write_config_word(mdev->pdev, cap + PCI_X_CMD, val)) {
+			mthca_err(mdev, "Couldn't write PCI-X command register, "
+				  "aborting.\n");
+			return -ENODEV;
+		}
+	} else if (mdev->hca_type == TAVOR)
+		mthca_info(mdev, "No PCI-X capability, not setting RBC.\n");
+
+	cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_EXP);
+	if (cap) {
+		if (pci_read_config_word(mdev->pdev, cap + PCI_EXP_DEVCTL, &val)) {
+			mthca_err(mdev, "Couldn't read PCI Express device control "
+				  "register, aborting.\n");
+			return -ENODEV;
+		}
+		val = (val & ~PCI_EXP_DEVCTL_READRQ) | (5 << 12);
+		if (pci_write_config_word(mdev->pdev, cap + PCI_EXP_DEVCTL, val)) {
+			mthca_err(mdev, "Couldn't write PCI Express device control "
+				  "register, aborting.\n");
+			return -ENODEV;
+		}
+	} else if (mdev->hca_type == ARBEL_NATIVE ||
+		   mdev->hca_type == ARBEL_COMPAT)
+		mthca_info(mdev, "No PCI Express capability, "
+			   "not setting Max Read Request Size.\n");
+
+	return 0;
+}
+
+static int __devinit mthca_init_tavor(struct mthca_dev *mdev)
+{
+	u8 status;
+	int err;
+	struct mthca_dev_lim        dev_lim;
+	struct mthca_init_hca_param init_hca;
+	struct mthca_adapter        adapter;
+
+	err = mthca_SYS_EN(mdev, &status);
+	if (err) {
+		mthca_err(mdev, "SYS_EN command failed, aborting.\n");
+		return err;
+	}
+	if (status) {
+		mthca_err(mdev, "SYS_EN returned status 0x%02x, "
+			  "aborting.\n", status);
+		return -EINVAL;
+	}
+
+	err = mthca_QUERY_FW(mdev, &status);
+	if (err) {
+		mthca_err(mdev, "QUERY_FW command failed, aborting.\n");
+		goto err_out_disable;
+	}
+	if (status) {
+		mthca_err(mdev, "QUERY_FW returned status 0x%02x, "
+			  "aborting.\n", status);
+		err = -EINVAL;
+		goto err_out_disable;
+	}
+	err = mthca_QUERY_DDR(mdev, &status);
+	if (err) {
+		mthca_err(mdev, "QUERY_DDR command failed, aborting.\n");
+		goto err_out_disable;
+	}
+	if (status) {
+		mthca_err(mdev, "QUERY_DDR returned status 0x%02x, "
+			  "aborting.\n", status);
+		err = -EINVAL;
+		goto err_out_disable;
+	}
+	err = mthca_QUERY_DEV_LIM(mdev, &dev_lim, &status);
+	if (err) {
+		mthca_err(mdev, "QUERY_DEV_LIM command failed, aborting.\n");
+		goto err_out_disable;
+	}
+	if (status) {
+		mthca_err(mdev, "QUERY_DEV_LIM returned status 0x%02x, "
+			  "aborting.\n", status);
+		err = -EINVAL;
+		goto err_out_disable;
+	}
+	if (dev_lim.min_page_sz > PAGE_SIZE) {
+		mthca_err(mdev, "HCA minimum page size of %d bigger than "
+			  "kernel PAGE_SIZE of %ld, aborting.\n",
+			  dev_lim.min_page_sz, PAGE_SIZE);
+		err = -ENODEV;
+		goto err_out_disable;
+	}
+	if (dev_lim.num_ports > MTHCA_MAX_PORTS) {
+		mthca_err(mdev, "HCA has %d ports, but we only support %d, "
+			  "aborting.\n",
+			  dev_lim.num_ports, MTHCA_MAX_PORTS);
+		err = -ENODEV;
+		goto err_out_disable;
+	}
+
+	mdev->limits.num_ports      	= dev_lim.num_ports;
+	mdev->limits.vl_cap             = dev_lim.max_vl;
+	mdev->limits.mtu_cap            = dev_lim.max_mtu;
+	mdev->limits.gid_table_len  	= dev_lim.max_gids;
+	mdev->limits.pkey_table_len 	= dev_lim.max_pkeys;
+	mdev->limits.local_ca_ack_delay = dev_lim.local_ca_ack_delay;
+	mdev->limits.max_sg             = dev_lim.max_sg;
+	mdev->limits.reserved_qps       = dev_lim.reserved_qps;
+	mdev->limits.reserved_srqs      = dev_lim.reserved_srqs;
+	mdev->limits.reserved_eecs      = dev_lim.reserved_eecs;
+	mdev->limits.reserved_cqs       = dev_lim.reserved_cqs;
+	mdev->limits.reserved_eqs       = dev_lim.reserved_eqs;
+	mdev->limits.reserved_mtts      = dev_lim.reserved_mtts;
+	mdev->limits.reserved_mrws      = dev_lim.reserved_mrws;
+	mdev->limits.reserved_uars      = dev_lim.reserved_uars;
+	mdev->limits.reserved_pds       = dev_lim.reserved_pds;
+
+	if (dev_lim.flags & DEV_LIM_FLAG_SRQ)
+		mdev->mthca_flags |= MTHCA_FLAG_SRQ;
+	
+	err = mthca_make_profile(mdev, &dev_lim, &init_hca);
+	if (err)
+		goto err_out_disable;
+
+	err = mthca_INIT_HCA(mdev, &init_hca, &status);
+	if (err) {
+		mthca_err(mdev, "INIT_HCA command failed, aborting.\n");
+		goto err_out_disable;
+	}
+	if (status) {
+		mthca_err(mdev, "INIT_HCA returned status 0x%02x, "
+			  "aborting.\n", status);
+		err = -EINVAL;
+		goto err_out_disable;
+	}
+
+	err = mthca_QUERY_ADAPTER(mdev, &adapter, &status);
+	if (err) {
+		mthca_err(mdev, "QUERY_ADAPTER command failed, aborting.\n");
+		goto err_out_disable;
+	}
+	if (status) {
+		mthca_err(mdev, "QUERY_ADAPTER returned status 0x%02x, "
+			  "aborting.\n", status);
+		err = -EINVAL;
+		goto err_out_close;
+	}
+
+	mdev->eq_table.inta_pin = adapter.inta_pin;
+	mdev->rev_id            = adapter.revision_id;
+
+	return 0;
+
+err_out_close:
+	mthca_CLOSE_HCA(mdev, 0, &status);
+
+err_out_disable:
+	mthca_SYS_DIS(mdev, &status);
+
+	return err;
+}
+
+static int __devinit mthca_load_fw(struct mthca_dev *mdev)
+{
+	u8 status;
+	int err;
+	int num_sg;
+	int i;
+
+	/* FIXME: use HCA-attached memory for FW if present */
+
+	mdev->fw.arbel.mem = kmalloc(sizeof *mdev->fw.arbel.mem *
+				     mdev->fw.arbel.fw_pages,
+				     GFP_KERNEL);
+	if (!mdev->fw.arbel.mem) {
+		mthca_err(mdev, "Couldn't allocate FW area, aborting.\n");
+		return -ENOMEM;
+	}
+
+	memset(mdev->fw.arbel.mem, 0,
+	       sizeof *mdev->fw.arbel.mem * mdev->fw.arbel.fw_pages);
+
+	for (i = 0; i < mdev->fw.arbel.fw_pages; ++i) {
+		mdev->fw.arbel.mem[i].page   = alloc_page(GFP_HIGHUSER);
+		mdev->fw.arbel.mem[i].length = PAGE_SIZE;
+		if (!mdev->fw.arbel.mem[i].page) {
+			mthca_err(mdev, "Couldn't allocate FW area, aborting.\n");
+			err = -ENOMEM;
+			goto err_free;
+		}
+	}
+	num_sg = pci_map_sg(mdev->pdev, mdev->fw.arbel.mem,
+					   mdev->fw.arbel.fw_pages, PCI_DMA_BIDIRECTIONAL);
+	if (num_sg <= 0) {
+		mthca_err(mdev, "Couldn't allocate FW area, aborting.\n");
+		err = -ENOMEM;
+		goto err_free;
+	}
+
+	err = mthca_MAP_FA(mdev, num_sg, mdev->fw.arbel.mem, &status);
+	if (err) {
+		mthca_err(mdev, "MAP_FA command failed, aborting.\n");
+		goto err_unmap;
+	}
+	if (status) {
+		mthca_err(mdev, "MAP_FA returned status 0x%02x, aborting.\n", status);
+		err = -EINVAL;
+		goto err_unmap;
+	}
+
+	err = mthca_RUN_FW(mdev, &status);
+	if (err) {
+		mthca_err(mdev, "RUN_FW command failed, aborting.\n");
+		goto err_unmap_fa;
+	}
+	if (status) {
+		mthca_err(mdev, "RUN_FW returned status 0x%02x, aborting.\n", status);
+		err = -EINVAL;
+		goto err_unmap_fa;
+	}
+
+	return 0;
+
+err_unmap_fa:
+	mthca_UNMAP_FA(mdev, &status);
+
+err_unmap:
+	pci_unmap_sg(mdev->pdev, mdev->fw.arbel.mem,
+		   mdev->fw.arbel.fw_pages, PCI_DMA_BIDIRECTIONAL);
+err_free:
+	for (i = 0; i < mdev->fw.arbel.fw_pages; ++i)
+		if (mdev->fw.arbel.mem[i].page)
+			__free_page(mdev->fw.arbel.mem[i].page);
+	kfree(mdev->fw.arbel.mem);
+	return err;
+}
+
+static int __devinit mthca_init_arbel(struct mthca_dev *mdev)
+{
+	u8 status;
+	int err;
+
+	err = mthca_QUERY_FW(mdev, &status);
+	if (err) {
+		mthca_err(mdev, "QUERY_FW command failed, aborting.\n");
+		return err;
+	}
+	if (status) {
+		mthca_err(mdev, "QUERY_FW returned status 0x%02x, "
+			  "aborting.\n", status);
+		return -EINVAL;
+	}
+
+	err = mthca_ENABLE_LAM(mdev, &status);
+	if (err) {
+		mthca_err(mdev, "ENABLE_LAM command failed, aborting.\n");
+		return err;
+	}
+	if (status == MTHCA_CMD_STAT_LAM_NOT_PRE) {
+		mthca_dbg(mdev, "No HCA-attached memory (running in MemFree mode)\n");
+		mdev->mthca_flags |= MTHCA_FLAG_NO_LAM;
+	} else if (status) {
+		mthca_err(mdev, "ENABLE_LAM returned status 0x%02x, "
+			  "aborting.\n", status);
+		return -EINVAL;
+	}
+
+	err = mthca_load_fw(mdev);
+	if (err) {
+		mthca_err(mdev, "Failed to start FW, aborting.\n");
+		goto err_out_disable;
+	}
+
+	mthca_warn(mdev, "Sorry, native MT25208 mode support is not done, "
+		   "aborting.\n");
+	return -ENODEV;
+
+err_out_disable:
+	if (!(mdev->mthca_flags & MTHCA_FLAG_NO_LAM))
+		mthca_DISABLE_LAM(mdev, &status);
+	return err;
+}
+
+static int __devinit mthca_init_hca(struct mthca_dev *mdev)
+{
+	if (mdev->hca_type == ARBEL_NATIVE)
+		return mthca_init_arbel(mdev);
+	else
+		return mthca_init_tavor(mdev);
+}
+
+static int __devinit mthca_setup_hca(struct mthca_dev *dev)
+{
+	int err;
+
+	MTHCA_INIT_DOORBELL_LOCK(&dev->doorbell_lock);
+
+	err = mthca_init_pd_table(dev);
+	if (err) {
+		mthca_err(dev, "Failed to initialize "
+			  "protection domain table, aborting.\n");
+		return err;
+	}
+
+	err = mthca_init_mr_table(dev);
+	if (err) {
+		mthca_err(dev, "Failed to initialize "
+			  "memory region table, aborting.\n");
+		goto err_out_pd_table_free;
+	}
+
+	err = mthca_pd_alloc(dev, &dev->driver_pd);
+	if (err) {
+		mthca_err(dev, "Failed to create driver PD, "
+			  "aborting.\n");
+		goto err_out_mr_table_free;
+	}
+
+	err = mthca_init_eq_table(dev);
+	if (err) {
+		mthca_err(dev, "Failed to initialize "
+			  "event queue table, aborting.\n");
+		goto err_out_pd_free;
+	}
+
+	err = mthca_cmd_use_events(dev);
+	if (err) {
+		mthca_err(dev, "Failed to switch to event-driven "
+			  "firmware commands, aborting.\n");
+		goto err_out_eq_table_free;
+	}
+
+	err = mthca_init_cq_table(dev);
+	if (err) {
+		mthca_err(dev, "Failed to initialize "
+			  "completion queue table, aborting.\n");
+		goto err_out_cmd_poll;
+	}
+
+	err = mthca_init_qp_table(dev);
+	if (err) {
+		mthca_err(dev, "Failed to initialize "
+			  "queue pair table, aborting.\n");
+		goto err_out_cq_table_free;
+	}
+
+	err = mthca_init_av_table(dev);
+	if (err) {
+		mthca_err(dev, "Failed to initialize "
+			  "address vector table, aborting.\n");
+		goto err_out_qp_table_free;
+	}
+
+	err = mthca_init_mcg_table(dev);
+	if (err) {
+		mthca_err(dev, "Failed to initialize "
+			  "multicast group table, aborting.\n");
+		goto err_out_av_table_free;
+	}
+
+	return 0;
+
+err_out_av_table_free:
+	mthca_cleanup_av_table(dev);
+
+err_out_qp_table_free:
+	mthca_cleanup_qp_table(dev);
+
+err_out_cq_table_free:
+	mthca_cleanup_cq_table(dev);
+
+err_out_cmd_poll:
+	mthca_cmd_use_polling(dev);
+
+err_out_eq_table_free:
+	mthca_cleanup_eq_table(dev);
+
+err_out_pd_free:
+	mthca_pd_free(dev, &dev->driver_pd);
+
+err_out_mr_table_free:
+	mthca_cleanup_mr_table(dev);
+
+err_out_pd_table_free:
+	mthca_cleanup_pd_table(dev);
+	return err;
+}
+
+static int __devinit mthca_request_regions(struct pci_dev *pdev,
+					   int ddr_hidden)
+{
+	int err;
+
+	/*
+	 * We request our first BAR in two chunks, since the MSI-X
+	 * vector table is right in the middle.
+	 *
+	 * This is why we can't just use pci_request_regions() -- if
+	 * we did then setting up MSI-X would fail, since the PCI core
+	 * wants to do request_mem_region on the MSI-X vector table.
+	 */
+	if (!request_mem_region(pci_resource_start(pdev, 0) +
+				MTHCA_HCR_BASE,
+				MTHCA_MAP_HCR_SIZE,
+				DRV_NAME))
+		return -EBUSY;
+
+	if (!request_mem_region(pci_resource_start(pdev, 0) +
+				MTHCA_CLR_INT_BASE,
+				MTHCA_CLR_INT_SIZE,
+				DRV_NAME)) {
+		err = -EBUSY;
+		goto err_out_bar0_beg;
+	}
+
+	err = pci_request_region(pdev, 2, DRV_NAME);
+	if (err)
+		goto err_out_bar0_end;
+
+	if (!ddr_hidden) {
+		err = pci_request_region(pdev, 4, DRV_NAME);
+		if (err)
+			goto err_out_bar2;
+	}
+
+	return 0;
+
+err_out_bar0_beg:
+	release_mem_region(pci_resource_start(pdev, 0) +
+			   MTHCA_HCR_BASE,
+			   MTHCA_MAP_HCR_SIZE);
+
+err_out_bar0_end:
+	release_mem_region(pci_resource_start(pdev, 0) +
+			   MTHCA_CLR_INT_BASE,
+			   MTHCA_CLR_INT_SIZE);
+
+err_out_bar2:
+	pci_release_region(pdev, 2);
+	return err;
+}
+
+static void mthca_release_regions(struct pci_dev *pdev,
+				  int ddr_hidden)
+{
+	release_mem_region(pci_resource_start(pdev, 0) +
+			   MTHCA_HCR_BASE,
+			   MTHCA_MAP_HCR_SIZE);
+	release_mem_region(pci_resource_start(pdev, 0) +
+			   MTHCA_CLR_INT_BASE,
+			   MTHCA_CLR_INT_SIZE);
+	pci_release_region(pdev, 2);
+	if (!ddr_hidden)
+		pci_release_region(pdev, 4);
+}
+
+static int __devinit mthca_enable_msi_x(struct mthca_dev *mdev)
+{
+	struct msix_entry entries[3];
+	int err;
+
+	entries[0].entry = 0;
+	entries[1].entry = 1;
+	entries[2].entry = 2;
+
+	err = pci_enable_msix(mdev->pdev, entries, ARRAY_SIZE(entries));
+	if (err) {
+		if (err > 0)
+			mthca_info(mdev, "Only %d MSI-X vectors available, "
+				   "not using MSI-X\n", err);
+		return err;
+	}
+
+	mdev->eq_table.eq[MTHCA_EQ_COMP ].msi_x_vector = entries[0].vector;
+	mdev->eq_table.eq[MTHCA_EQ_ASYNC].msi_x_vector = entries[1].vector;
+	mdev->eq_table.eq[MTHCA_EQ_CMD  ].msi_x_vector = entries[2].vector;
+
+	return 0;
+}
+
+static void mthca_close_hca(struct mthca_dev *mdev)
+{
+	u8 status;
+	int i;
+
+	mthca_CLOSE_HCA(mdev, 0, &status);
+
+	if (mdev->hca_type == ARBEL_NATIVE) {
+		mthca_UNMAP_FA(mdev, &status);
+
+		pci_unmap_sg(mdev->pdev, mdev->fw.arbel.mem,
+			     mdev->fw.arbel.fw_pages, PCI_DMA_BIDIRECTIONAL);
+
+		for (i = 0; i < mdev->fw.arbel.fw_pages; ++i)
+			__free_page(mdev->fw.arbel.mem[i].page);
+		kfree(mdev->fw.arbel.mem);
+
+		if (!(mdev->mthca_flags & MTHCA_FLAG_NO_LAM))
+			mthca_DISABLE_LAM(mdev, &status);
+	} else
+		mthca_SYS_DIS(mdev, &status);
+}
+
+static int __devinit mthca_init_one(struct pci_dev *pdev,
+				    const struct pci_device_id *id)
+{
+	static int mthca_version_printed = 0;
+	int ddr_hidden = 0;
+	int err;
+	unsigned long mthca_base;
+	struct mthca_dev *mdev;
+
+	if (!mthca_version_printed) {
+		printk(KERN_INFO "%s", mthca_version);
+		++mthca_version_printed;
+	}
+
+	printk(KERN_INFO PFX "Initializing %s (%s)\n",
+	       pci_pretty_name(pdev), pci_name(pdev));
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot enable PCI device, "
+			"aborting.\n");
+		return err;
+	}
+
+	/*
+	 * Check for BARs.  We expect 0: 1MB, 2: 8MB, 4: DDR (may not
+	 * be present)
+	 */
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
+	    pci_resource_len(pdev, 0) != 1 << 20) {
+		dev_err(&pdev->dev, "Missing DCS, aborting.");
+		err = -ENODEV;
+		goto err_out_disable_pdev;
+	}
+	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM) ||
+	    pci_resource_len(pdev, 2) != 1 << 23) {
+		dev_err(&pdev->dev, "Missing UAR, aborting.");
+		err = -ENODEV;
+		goto err_out_disable_pdev;
+	}
+	if (!(pci_resource_flags(pdev, 4) & IORESOURCE_MEM))
+		ddr_hidden = 1;
+
+	err = mthca_request_regions(pdev, ddr_hidden);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot obtain PCI resources, "
+			"aborting.\n");
+		goto err_out_disable_pdev;
+	}
+
+	pci_set_master(pdev);
+
+	err = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
+	if (err) {
+		dev_warn(&pdev->dev, "Warning: couldn't set 64-bit PCI DMA mask.\n");
+		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+		if (err) {
+			dev_err(&pdev->dev, "Can't set PCI DMA mask, aborting.\n");
+			goto err_out_free_res;
+		}
+	}
+	err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+	if (err) {
+		dev_warn(&pdev->dev, "Warning: couldn't set 64-bit "
+			 "consistent PCI DMA mask.\n");
+		err = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+		if (err) {
+			dev_err(&pdev->dev, "Can't set consistent PCI DMA mask, "
+				"aborting.\n");
+			goto err_out_free_res;
+		}
+	}
+
+	mdev = (struct mthca_dev *) ib_alloc_device(sizeof *mdev);
+	if (!mdev) {
+		dev_err(&pdev->dev, "Device struct alloc failed, "
+			"aborting.\n");
+		err = -ENOMEM;
+		goto err_out_free_res;
+	}
+
+	mdev->pdev     = pdev;
+	mdev->hca_type = id->driver_data;
+
+	if (ddr_hidden)
+		mdev->mthca_flags |= MTHCA_FLAG_DDR_HIDDEN;
+
+	/*
+	 * Now reset the HCA before we touch the PCI capabilities or
+	 * attempt a firmware command, since a boot ROM may have left
+	 * the HCA in an undefined state.
+	 */
+	err = mthca_reset(mdev);
+	if (err) {
+		mthca_err(mdev, "Failed to reset HCA, aborting.\n");
+		goto err_out_free_dev;
+	}
+
+	if (msi_x && !mthca_enable_msi_x(mdev))
+		mdev->mthca_flags |= MTHCA_FLAG_MSI_X;
+	if (msi && !(mdev->mthca_flags & MTHCA_FLAG_MSI_X) &&
+	    !pci_enable_msi(pdev))
+		mdev->mthca_flags |= MTHCA_FLAG_MSI;
+
+	sema_init(&mdev->cmd.hcr_sem, 1);
+	sema_init(&mdev->cmd.poll_sem, 1);
+	mdev->cmd.use_events = 0;
+
+	mthca_base = pci_resource_start(pdev, 0);
+	mdev->hcr = ioremap(mthca_base + MTHCA_HCR_BASE, MTHCA_MAP_HCR_SIZE);
+	if (!mdev->hcr) {
+		mthca_err(mdev, "Couldn't map command register, "
+			  "aborting.\n");
+		err = -ENOMEM;
+		goto err_out_free_dev;
+	}
+	mdev->clr_base = ioremap(mthca_base + MTHCA_CLR_INT_BASE,
+				 MTHCA_CLR_INT_SIZE);
+	if (!mdev->clr_base) {
+		mthca_err(mdev, "Couldn't map command register, "
+			  "aborting.\n");
+		err = -ENOMEM;
+		goto err_out_iounmap;
+	}
+
+	mthca_base = pci_resource_start(pdev, 2);
+	mdev->kar = ioremap(mthca_base + PAGE_SIZE * MTHCA_KAR_PAGE, PAGE_SIZE);
+	if (!mdev->kar) {
+		mthca_err(mdev, "Couldn't map kernel access region, "
+			  "aborting.\n");
+		err = -ENOMEM;
+		goto err_out_iounmap_clr;
+	}
+
+	err = mthca_tune_pci(mdev);
+	if (err)
+		goto err_out_iounmap_kar;
+
+	err = mthca_init_hca(mdev);
+	if (err)
+		goto err_out_iounmap_kar;
+
+	err = mthca_setup_hca(mdev);
+	if (err)
+		goto err_out_close;
+
+	err = mthca_register_device(mdev);
+	if (err)
+		goto err_out_cleanup;
+
+	err = mthca_create_agents(mdev);
+	if (err)
+		goto err_out_unregister;
+
+	pci_set_drvdata(pdev, mdev);
+
+	return 0;
+
+err_out_unregister:
+	mthca_unregister_device(mdev);
+
+err_out_cleanup:
+	mthca_cleanup_mcg_table(mdev);
+	mthca_cleanup_av_table(mdev);
+	mthca_cleanup_qp_table(mdev);
+	mthca_cleanup_cq_table(mdev);
+	mthca_cmd_use_polling(mdev);
+	mthca_cleanup_eq_table(mdev);
+
+	mthca_pd_free(mdev, &mdev->driver_pd);
+
+	mthca_cleanup_mr_table(mdev);
+	mthca_cleanup_pd_table(mdev);
+
+err_out_close:
+	mthca_close_hca(mdev);
+
+err_out_iounmap_kar:
+	iounmap(mdev->kar);
+
+err_out_iounmap_clr:
+	iounmap(mdev->clr_base);
+
+err_out_iounmap:
+	iounmap(mdev->hcr);
+
+err_out_free_dev:
+	if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
+		pci_disable_msix(pdev);
+	if (mdev->mthca_flags & MTHCA_FLAG_MSI)
+		pci_disable_msi(pdev);
+
+	ib_dealloc_device(&mdev->ib_dev);
+
+err_out_free_res:
+	mthca_release_regions(pdev, ddr_hidden);
+
+err_out_disable_pdev:
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	return err;
+}
+
+static void __devexit mthca_remove_one(struct pci_dev *pdev)
+{
+	struct mthca_dev *mdev = pci_get_drvdata(pdev);
+	u8 status;
+	int p;
+
+	if (mdev) {
+		mthca_free_agents(mdev);
+		mthca_unregister_device(mdev);
+
+		for (p = 1; p <= mdev->limits.num_ports; ++p)
+			mthca_CLOSE_IB(mdev, p, &status);
+
+		mthca_cleanup_mcg_table(mdev);
+		mthca_cleanup_av_table(mdev);
+		mthca_cleanup_qp_table(mdev);
+		mthca_cleanup_cq_table(mdev);
+		mthca_cmd_use_polling(mdev);
+		mthca_cleanup_eq_table(mdev);
+
+		mthca_pd_free(mdev, &mdev->driver_pd);
+
+		mthca_cleanup_mr_table(mdev);
+		mthca_cleanup_pd_table(mdev);
+
+		mthca_close_hca(mdev);
+
+		iounmap(mdev->hcr);
+		iounmap(mdev->clr_base);
+
+		if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
+			pci_disable_msix(pdev);
+		if (mdev->mthca_flags & MTHCA_FLAG_MSI)
+			pci_disable_msi(pdev);
+
+		ib_dealloc_device(&mdev->ib_dev);
+		mthca_release_regions(pdev, mdev->mthca_flags &
+				      MTHCA_FLAG_DDR_HIDDEN);
+		pci_disable_device(pdev);
+		pci_set_drvdata(pdev, NULL);
+	}
+}
+
+static struct pci_device_id mthca_pci_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR),
+	  .driver_data = TAVOR },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOPSPIN, PCI_DEVICE_ID_MELLANOX_TAVOR),
+	  .driver_data = TAVOR },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT),
+	  .driver_data = ARBEL_COMPAT },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOPSPIN, PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT),
+	  .driver_data = ARBEL_COMPAT },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_ARBEL),
+	  .driver_data = ARBEL_NATIVE },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOPSPIN, PCI_DEVICE_ID_MELLANOX_ARBEL),
+	  .driver_data = ARBEL_NATIVE },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, mthca_pci_table);
+
+static struct pci_driver mthca_driver = {
+	.name		= "ib_mthca",
+	.id_table	= mthca_pci_table,
+	.probe		= mthca_init_one,
+	.remove		= __devexit_p(mthca_remove_one)
+};
+
+static int __init mthca_init(void)
+{
+	int ret;
+
+	/*
+	 * TODO: measure whether dynamically choosing doorbell code at
+	 * runtime affects our performance.  Is there a "magic" way to
+	 * choose without having to follow a function pointer every
+	 * time we ring a doorbell?
+	 */
+#ifdef CONFIG_INFINIBAND_MTHCA_SSE_DOORBELL
+	if (!cpu_has_xmm) {
+		printk(KERN_ERR PFX "mthca was compiled with SSE doorbell code, but\n");
+		printk(KERN_ERR PFX "the current CPU does not support SSE.\n");
+		printk(KERN_ERR PFX "Turn off CONFIG_INFINIBAND_MTHCA_SSE_DOORBELL "
+		       "and recompile.\n");
+		return -ENODEV;
+	}
+#endif
+
+	ret = pci_register_driver(&mthca_driver);
+	return ret < 0 ? ret : 0;
+}
+
+static void __exit mthca_cleanup(void)
+{
+	pci_unregister_driver(&mthca_driver);
+}
+
+module_init(mthca_init);
+module_exit(mthca_cleanup);
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */

