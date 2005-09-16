Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbVIPHCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbVIPHCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbVIPHCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:02:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:12506 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161078AbVIPHBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:01:51 -0400
Message-Id: <20050916123314.704421000@localhost>
References: <20050916121646.387617000@localhost>
Date: Fri, 16 Sep 2005 08:16:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       jordi_caubet@es.ibm.com, Hiroyuki Machida <machida@sm.sony.co.jp>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 10/11] spufs: new entries for SPU special purpose registers.
Content-Disposition: inline; filename=spufs-add-sprs.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements SPUFS directory entries for various special 
purpose registers.  These include the SPU floating point control 
register (fpcr), decrementer (decr), and machine status register 
(srr0).  It should now be possible to query/set all user state 
from SPUFS, implement get/set_context interfaces, etc.

From: Mark Nutter <mnutter@us.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 file.c |  170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 170 insertions(+)

Index: linux-cg/fs/spufs/file.c
===================================================================
--- linux-cg.orig/fs/spufs/file.c
+++ linux-cg/fs/spufs/file.c
@@ -223,6 +223,60 @@ static struct file_operations spufs_regs
 	.llseek  = generic_file_llseek,
 };
 
+static ssize_t
+spufs_fpcr_read(struct file *file, char __user * buffer,
+		size_t size, loff_t * pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	int ret;
+
+	spu_acquire_saved(ctx);
+	if (ctx->state == SPU_STATE_LOCKED) {
+		spu_release(ctx);
+		return -EAGAIN;
+	}
+
+	ret = simple_read_from_buffer(buffer, size, pos,
+				      &lscsa->fpcr, sizeof(lscsa->fpcr));
+
+	spu_release(ctx);
+	return ret;
+}
+
+static ssize_t
+spufs_fpcr_write(struct file *file, const char __user * buffer,
+		 size_t size, loff_t * pos)
+{
+	struct spu_context *ctx = file->private_data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	int ret;
+
+	size = min_t(ssize_t, sizeof(lscsa->fpcr) - *pos, size);
+	if (size <= 0)
+		return -EFBIG;
+	*pos += size;
+
+	spu_acquire_saved(ctx);
+	if (ctx->state == SPU_STATE_LOCKED) {
+		spu_release(ctx);
+		return -EAGAIN;
+	}
+
+	ret = copy_from_user((char *)&lscsa->fpcr + *pos - size,
+			     buffer, size) ? -EFAULT : size;
+
+	spu_release(ctx);
+	return ret;
+}
+
+static struct file_operations spufs_fpcr_fops = {
+	.open = spufs_regs_open,
+	.read = spufs_fpcr_read,
+	.write = spufs_fpcr_write,
+	.llseek = generic_file_llseek,
+};
+
 /* generic open function for all pipe-like files */
 static int spufs_pipe_open(struct inode *inode, struct file *file)
 {
@@ -789,6 +843,116 @@ static u64 spufs_npc_get(void *data)
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_npc_ops, spufs_npc_get, spufs_npc_set, "%llx\n")
 
+static void spufs_decr_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->decr.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_decr_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->decr.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_decr_ops, spufs_decr_get, spufs_decr_set,
+			"%llx\n")
+
+static void spufs_decr_status_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->decr_status.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_decr_status_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->decr_status.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_decr_status_ops, spufs_decr_status_get,
+			spufs_decr_status_set, "%llx\n")
+
+static void spufs_spu_tag_mask_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->tag_mask.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_spu_tag_mask_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->tag_mask.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_spu_tag_mask_ops, spufs_spu_tag_mask_get,
+			spufs_spu_tag_mask_set, "%llx\n")
+
+static void spufs_event_mask_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->event_mask.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_event_mask_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->event_mask.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_event_mask_ops, spufs_event_mask_get,
+			spufs_event_mask_set, "%llx\n")
+
+static void spufs_srr0_set(void *data, u64 val)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	spu_acquire_saved(ctx);
+	lscsa->srr0.slot[0] = (u32) val;
+	spu_release(ctx);
+}
+
+static u64 spufs_srr0_get(void *data)
+{
+	struct spu_context *ctx = data;
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	u64 ret;
+	spu_acquire_saved(ctx);
+	ret = lscsa->srr0.slot[0];
+	spu_release(ctx);
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_srr0_ops, spufs_srr0_get, spufs_srr0_set,
+			"%llx\n")
+
 struct tree_descr spufs_dir_contents[] = {
 	{ "mem",  &spufs_mem_fops,  0666, },
 	{ "regs", &spufs_regs_fops,  0666, },
@@ -804,5 +968,11 @@ struct tree_descr spufs_dir_contents[] =
 	{ "signal1_type", &spufs_signal1_type, 0666, },
 	{ "signal2_type", &spufs_signal2_type, 0666, },
 	{ "npc", &spufs_npc_ops, 0666, },
+	{ "fpcr", &spufs_fpcr_fops, 0666, },
+	{ "decr", &spufs_decr_ops, 0666, },
+	{ "decr_status", &spufs_decr_status_ops, 0666, },
+	{ "spu_tag_mask", &spufs_spu_tag_mask_ops, 0666, },
+	{ "event_mask", &spufs_event_mask_ops, 0666, },
+	{ "srr0", &spufs_srr0_ops, 0666, },
 	{},
 };

--

