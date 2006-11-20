Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966298AbWKTSIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966298AbWKTSIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934299AbWKTSHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:07:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:16599 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934273AbWKTSH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:26 -0500
Message-Id: <20061120180522.364469000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:00 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Dwayne Grant McConnell <decimal@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 06/22] spufs: implement /mbox_info, /ibox_info, and /wbox_info.
Content-Disposition: inline; filename=spufs-mbox-info.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dwayne Grant McConnell <decimal@us.ibm.com>
This patch implements read only access to

/mbox_info - SPU Write Outbound Mailbox
/ibox_info - SPU Write Outbound Interrupt Mailbox
/wbox_info - SPU Read Inbound Mailbox

These files are used by gdb in order to look into the current mailbox
queues without changing the contents at the same time. They are
not meant for general programming use, since the access requires
a context save and is therefore rather slow.

It would be good to complement this patch with one that adds
write support as well.

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
@@ -1552,6 +1552,93 @@ static int spufs_info_open(struct inode 
 	return 0;
 }
 
+static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
+				   size_t len, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	u32 mbox_stat;
+	u32 data;
+
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+
+	spu_acquire_saved(ctx);
+	spin_lock(&ctx->csa.register_lock);
+	mbox_stat = ctx->csa.prob.mb_stat_R;
+	if (mbox_stat & 0x0000ff) {
+		data = ctx->csa.prob.pu_mb_R;
+	}
+	spin_unlock(&ctx->csa.register_lock);
+	spu_release(ctx);
+
+	return simple_read_from_buffer(buf, len, pos, &data, sizeof data);
+}
+
+static struct file_operations spufs_mbox_info_fops = {
+	.open = spufs_info_open,
+	.read = spufs_mbox_info_read,
+	.llseek  = generic_file_llseek,
+};
+
+static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
+				   size_t len, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	u32 ibox_stat;
+	u32 data;
+
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+
+	spu_acquire_saved(ctx);
+	spin_lock(&ctx->csa.register_lock);
+	ibox_stat = ctx->csa.prob.mb_stat_R;
+	if (ibox_stat & 0xff0000) {
+		data = ctx->csa.priv2.puint_mb_R;
+	}
+	spin_unlock(&ctx->csa.register_lock);
+	spu_release(ctx);
+
+	return simple_read_from_buffer(buf, len, pos, &data, sizeof data);
+}
+
+static struct file_operations spufs_ibox_info_fops = {
+	.open = spufs_info_open,
+	.read = spufs_ibox_info_read,
+	.llseek  = generic_file_llseek,
+};
+
+static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
+				   size_t len, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	int i, cnt;
+	u32 data[4];
+	u32 wbox_stat;
+
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+
+	spu_acquire_saved(ctx);
+	spin_lock(&ctx->csa.register_lock);
+	wbox_stat = ctx->csa.prob.mb_stat_R;
+	cnt = (wbox_stat & 0x00ff00) >> 8;
+	for (i = 0; i < cnt; i++) {
+		data[i] = ctx->csa.spu_mailbox_data[i];
+	}
+	spin_unlock(&ctx->csa.register_lock);
+	spu_release(ctx);
+
+	return simple_read_from_buffer(buf, len, pos, &data,
+				cnt * sizeof(u32));
+}
+
+static struct file_operations spufs_wbox_info_fops = {
+	.open = spufs_info_open,
+	.read = spufs_wbox_info_read,
+	.llseek  = generic_file_llseek,
+};
+
 static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
 			      size_t len, loff_t *pos)
 {
@@ -1661,6 +1748,9 @@ struct tree_descr spufs_dir_contents[] =
 	{ "psmap", &spufs_psmap_fops, 0666, },
 	{ "phys-id", &spufs_id_ops, 0666, },
 	{ "object-id", &spufs_object_id_ops, 0666, },
+	{ "mbox_info", &spufs_mbox_info_fops, 0444, },
+	{ "ibox_info", &spufs_ibox_info_fops, 0444, },
+	{ "wbox_info", &spufs_wbox_info_fops, 0444, },
 	{ "dma_info", &spufs_dma_info_fops, 0444, },
 	{ "proxydma_info", &spufs_proxydma_info_fops, 0444, },
 	{},

--

