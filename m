Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934289AbWKTSIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934289AbWKTSIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934273AbWKTSIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:08:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:11495 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934289AbWKTSIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:08:37 -0500
Message-Id: <20061120180521.612934000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:44:58 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Dwayne Grant McConnell <decimal@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 04/22] spufs: add /lslr, /dma_info and /proxydma files
Content-Disposition: inline; filename=spufs-gdb-interfaces-addon-5.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dwayne Grant McConnell <decimal@us.ibm.com>
The /lslr file gives read access to the SPU_LSLR register in hex; 0x3fff
for example The /dma_info file provides read access to the SPU Command
Queue in a binary format. The /proxydma_info files provides read access
access to the Proxy Command Queue in a binary format. The spu_info.h
file provides data structures for interpreting the binary format of
/dma_info and /proxydma_info.

Signed-off-by: Dwayne Grant McConnell <decimal@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/backing_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/backing_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/backing_ops.c
@@ -36,6 +36,7 @@
 #include <asm/io.h>
 #include <asm/spu.h>
 #include <asm/spu_csa.h>
+#include <asm/spu_info.h>
 #include <asm/mmu_context.h>
 #include "spufs.h"
 
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -32,6 +32,7 @@
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/spu.h>
+#include <asm/spu_info.h>
 #include <asm/uaccess.h>
 
 #include "spufs.h"
@@ -1482,6 +1483,23 @@ static u64 spufs_event_mask_get(void *da
 DEFINE_SIMPLE_ATTRIBUTE(spufs_event_mask_ops, spufs_event_mask_get,
 			spufs_event_mask_set, "0x%llx\n")
 
+static u64 spufs_event_status_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_state *state = &ctx->csa;
+	u64 ret = 0;
+	u64 stat;
+
+	spu_acquire_saved(ctx);
+	stat = state->spu_chnlcnt_RW[0];
+	if (stat)
+		ret = state->spu_chnldata_RW[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_event_status_ops, spufs_event_status_get,
+			NULL, "0x%llx\n")
+
 static void spufs_srr0_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
@@ -1535,6 +1553,109 @@ static void spufs_object_id_set(void *da
 DEFINE_SIMPLE_ATTRIBUTE(spufs_object_id_ops, spufs_object_id_get,
 		spufs_object_id_set, "0x%llx\n");
 
+static u64 spufs_lslr_get(void *data)
+{
+	struct spu_context *ctx = data;
+	u64 ret;
+
+	spu_acquire_saved(ctx);
+	ret = ctx->csa.priv2.spu_lslr_RW;
+	spu_release(ctx);
+
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_lslr_ops, spufs_lslr_get, NULL, "0x%llx\n")
+
+static int spufs_info_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
+	file->private_data = ctx;
+	return 0;
+}
+
+static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
+			      size_t len, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu_dma_info info;
+	struct mfc_cq_sr *qp, *spuqp;
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+
+	spu_acquire_saved(ctx);
+	spin_lock(&ctx->csa.register_lock);
+	info.dma_info_type = ctx->csa.priv2.spu_tag_status_query_RW;
+	info.dma_info_mask = ctx->csa.lscsa->tag_mask.slot[0];
+	info.dma_info_status = ctx->csa.spu_chnldata_RW[24];
+	info.dma_info_stall_and_notify = ctx->csa.spu_chnldata_RW[25];
+	info.dma_info_atomic_command_status = ctx->csa.spu_chnldata_RW[27];
+	for (i = 0; i < 16; i++) {
+		qp = &info.dma_info_command_data[i];
+		spuqp = &ctx->csa.priv2.spuq[i];
+
+		qp->mfc_cq_data0_RW = spuqp->mfc_cq_data0_RW;
+		qp->mfc_cq_data1_RW = spuqp->mfc_cq_data1_RW;
+		qp->mfc_cq_data2_RW = spuqp->mfc_cq_data2_RW;
+		qp->mfc_cq_data3_RW = spuqp->mfc_cq_data3_RW;
+	}
+	spin_unlock(&ctx->csa.register_lock);
+	spu_release(ctx);
+
+	return simple_read_from_buffer(buf, len, pos, &info,
+				sizeof info);
+}
+
+static struct file_operations spufs_dma_info_fops = {
+	.open = spufs_info_open,
+	.read = spufs_dma_info_read,
+};
+
+static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
+				   size_t len, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu_proxydma_info info;
+	int ret = sizeof info;
+	struct mfc_cq_sr *qp, *puqp;
+	int i;
+
+	if (len < ret)
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+
+	spu_acquire_saved(ctx);
+	spin_lock(&ctx->csa.register_lock);
+	info.proxydma_info_type = ctx->csa.prob.dma_querytype_RW;
+	info.proxydma_info_mask = ctx->csa.prob.dma_querymask_RW;
+	info.proxydma_info_status = ctx->csa.prob.dma_tagstatus_R;
+	for (i = 0; i < 8; i++) {
+		qp = &info.proxydma_info_command_data[i];
+		puqp = &ctx->csa.priv2.puq[i];
+
+		qp->mfc_cq_data0_RW = puqp->mfc_cq_data0_RW;
+		qp->mfc_cq_data1_RW = puqp->mfc_cq_data1_RW;
+		qp->mfc_cq_data2_RW = puqp->mfc_cq_data2_RW;
+		qp->mfc_cq_data3_RW = puqp->mfc_cq_data3_RW;
+	}
+	spin_unlock(&ctx->csa.register_lock);
+	spu_release(ctx);
+
+	if (copy_to_user(buf, &info, sizeof info))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static struct file_operations spufs_proxydma_info_fops = {
+	.open = spufs_info_open,
+	.read = spufs_proxydma_info_read,
+};
+
 struct tree_descr spufs_dir_contents[] = {
 	{ "mem",  &spufs_mem_fops,  0666, },
 	{ "regs", &spufs_regs_fops,  0666, },
@@ -1548,19 +1669,23 @@ struct tree_descr spufs_dir_contents[] =
 	{ "signal2", &spufs_signal2_fops, 0666, },
 	{ "signal1_type", &spufs_signal1_type, 0666, },
 	{ "signal2_type", &spufs_signal2_type, 0666, },
-	{ "mss", &spufs_mss_fops, 0666, },
-	{ "mfc", &spufs_mfc_fops, 0666, },
 	{ "cntl", &spufs_cntl_fops,  0666, },
-	{ "npc", &spufs_npc_ops, 0666, },
 	{ "fpcr", &spufs_fpcr_fops, 0666, },
+	{ "lslr", &spufs_lslr_ops, 0444, },
+	{ "mfc", &spufs_mfc_fops, 0666, },
+	{ "mss", &spufs_mss_fops, 0666, },
+	{ "npc", &spufs_npc_ops, 0666, },
+	{ "srr0", &spufs_srr0_ops, 0666, },
 	{ "decr", &spufs_decr_ops, 0666, },
 	{ "decr_status", &spufs_decr_status_ops, 0666, },
 	{ "spu_tag_mask", &spufs_spu_tag_mask_ops, 0666, },
 	{ "event_mask", &spufs_event_mask_ops, 0666, },
-	{ "srr0", &spufs_srr0_ops, 0666, },
+	{ "event_status", &spufs_event_status_ops, 0444, },
 	{ "psmap", &spufs_psmap_fops, 0666, },
 	{ "phys-id", &spufs_id_ops, 0666, },
 	{ "object-id", &spufs_object_id_ops, 0666, },
+	{ "dma_info", &spufs_dma_info_fops, 0444, },
+	{ "proxydma_info", &spufs_proxydma_info_fops, 0444, },
 	{},
 };
 
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -29,6 +29,7 @@
 
 #include <asm/spu.h>
 #include <asm/spu_csa.h>
+#include <asm/spu_info.h>
 
 /* The magic number for our file system */
 enum {
@@ -119,8 +120,12 @@ struct spu_context_ops {
 	int (*set_mfc_query)(struct spu_context * ctx, u32 mask, u32 mode);
 	u32 (*read_mfc_tagstatus)(struct spu_context * ctx);
 	u32 (*get_mfc_free_elements)(struct spu_context *ctx);
-	int (*send_mfc_command)(struct spu_context *ctx,
-					struct mfc_dma_command *cmd);
+	int (*send_mfc_command)(struct spu_context * ctx,
+				struct mfc_dma_command * cmd);
+	void (*dma_info_read) (struct spu_context * ctx,
+			       struct spu_dma_info * info);
+	void (*proxydma_info_read) (struct spu_context * ctx,
+				    struct spu_proxydma_info * info);
 };
 
 extern struct spu_context_ops spu_hw_ops;
Index: linux-2.6/include/asm-powerpc/Kbuild
===================================================================
--- linux-2.6.orig/include/asm-powerpc/Kbuild
+++ linux-2.6/include/asm-powerpc/Kbuild
@@ -17,6 +17,7 @@ header-y += ipc.h
 header-y += poll.h
 header-y += shmparam.h
 header-y += sockios.h
+header-y += spu_info.h
 header-y += ucontext.h
 header-y += ioctl.h
 header-y += linkage.h
Index: linux-2.6/include/asm-powerpc/spu_info.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-powerpc/spu_info.h
@@ -0,0 +1,54 @@
+/*
+ * SPU info structures
+ *
+ * (C) Copyright 2006 IBM Corp.
+ *
+ * Author: Dwayne Grant McConnell <decimal@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _SPU_INFO_H
+#define _SPU_INFO_H
+
+#ifdef __KERNEL__
+#include <asm/spu.h>
+#include <linux/types.h>
+#else
+struct mfc_cq_sr {
+	__u64 mfc_cq_data0_RW;
+	__u64 mfc_cq_data1_RW;
+	__u64 mfc_cq_data2_RW;
+	__u64 mfc_cq_data3_RW;
+};
+#endif /* __KERNEL__ */
+
+struct spu_dma_info {
+	__u64 dma_info_type;
+	__u64 dma_info_mask;
+	__u64 dma_info_status;
+	__u64 dma_info_stall_and_notify;
+	__u64 dma_info_atomic_command_status;
+	struct mfc_cq_sr dma_info_command_data[16];
+};
+
+struct spu_proxydma_info {
+	__u64 proxydma_info_type;
+	__u64 proxydma_info_mask;
+	__u64 proxydma_info_status;
+	struct mfc_cq_sr proxydma_info_command_data[8];
+};
+
+#endif

--

