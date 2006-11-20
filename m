Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934274AbWKTSHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934274AbWKTSHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934279AbWKTSHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:07:00 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:63696 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934274AbWKTSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:06:59 -0500
Message-Id: <20061120180522.956875000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:01 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Dwayne Grant McConnell <decimal@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 07/22] spufs: read from signal files only if data is there
Content-Disposition: inline; filename=spufs-require-context-save-for-signal-read-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dwayne Grant McConnell <decimal@us.ibm.com>
We need to check the channel count of the signal notification registers
before reading them, because it can be undefined when the count is
zero. In order to read count and data atomically, we read from the
saved context.

This patch uses spu_acquire_saved() to force a context save before a
/signal1 or /signal2 read. Because of this it is no longer necessary to
have backing_ops and hw_ops versions of this function so they have been
removed.

Regular applications should not rely on reading this register
to be fast, as it's conceptually a write-only file from the PPE
perspective.

Signed-off-by: Dwayne Grant McConnell <decimal@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Dwayne Grant McConnell <decimal@us.ibm.com>
Lotus Notes Mail: Dwayne McConnell [Mail]/Austin/IBM@IBMUS
Lotus Notes Calendar: Dwayne McConnell [Calendar]/Austin/IBM@IBMUS

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -723,19 +723,27 @@ static ssize_t spufs_signal1_read(struct
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
+	int ret = 0;
 	u32 data;
 
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire(ctx);
-	data = ctx->ops->signal1_read(ctx);
+	spu_acquire_saved(ctx);
+	if (ctx->csa.spu_chnlcnt_RW[3]) {
+		data = ctx->csa.spu_chnldata_RW[3];
+		ret = 4;
+	}
 	spu_release(ctx);
 
+	if (!ret)
+		goto out;
+
 	if (copy_to_user(buf, &data, 4))
 		return -EFAULT;
 
-	return 4;
+out:
+	return ret;
 }
 
 static ssize_t spufs_signal1_write(struct file *file, const char __user *buf,
@@ -811,21 +819,27 @@ static int spufs_signal2_open(struct ino
 static ssize_t spufs_signal2_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx;
+	struct spu_context *ctx = file->private_data;
+	int ret = 0;
 	u32 data;
 
-	ctx = file->private_data;
-
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire(ctx);
-	data = ctx->ops->signal2_read(ctx);
+	spu_acquire_saved(ctx);
+	if (ctx->csa.spu_chnlcnt_RW[4]) {
+		data =  ctx->csa.spu_chnldata_RW[4];
+		ret = 4;
+	}
 	spu_release(ctx);
 
+	if (!ret)
+		goto out;
+
 	if (copy_to_user(buf, &data, 4))
 		return -EFAULT;
 
+out:
 	return 4;
 }
 
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -135,21 +135,11 @@ static int spu_hw_wbox_write(struct spu_
 	return ret;
 }
 
-static u32 spu_hw_signal1_read(struct spu_context *ctx)
-{
-	return in_be32(&ctx->spu->problem->signal_notify1);
-}
-
 static void spu_hw_signal1_write(struct spu_context *ctx, u32 data)
 {
 	out_be32(&ctx->spu->problem->signal_notify1, data);
 }
 
-static u32 spu_hw_signal2_read(struct spu_context *ctx)
-{
-	return in_be32(&ctx->spu->problem->signal_notify2);
-}
-
 static void spu_hw_signal2_write(struct spu_context *ctx, u32 data)
 {
 	out_be32(&ctx->spu->problem->signal_notify2, data);
@@ -294,9 +284,7 @@ struct spu_context_ops spu_hw_ops = {
 	.mbox_stat_poll = spu_hw_mbox_stat_poll,
 	.ibox_read = spu_hw_ibox_read,
 	.wbox_write = spu_hw_wbox_write,
-	.signal1_read = spu_hw_signal1_read,
 	.signal1_write = spu_hw_signal1_write,
-	.signal2_read = spu_hw_signal2_read,
 	.signal2_write = spu_hw_signal2_write,
 	.signal1_type_set = spu_hw_signal1_type_set,
 	.signal1_type_get = spu_hw_signal1_type_get,

--

