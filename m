Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVHYWFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVHYWFD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVHYWEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:04:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:16600 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964924AbVHYWED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:04:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 6/7] spufs: allow O_ASYNC on mailbox files
Date: Fri, 26 Aug 2005 00:04:33 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508260004.34216.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to receive user-defined
signals when the spufs ibox and wbox files are accessed
from an SPE, so data can be read/written from/to
them again.

Unfortunately, this kind of messes with the layering
of the high- and low-level parts of the code, so I'm
currently thinking about dropping the functionality
again.

If anyone has strong opinions on how useful or harmful
this patch is, please tell me.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 arch/ppc64/kernel/spu_base.c |    7 +++++++
 fs/spufs/file.c              |   16 ++++++++++++++++
 include/asm-ppc64/spu.h      |    2 ++
 3 files changed, 25 insertions(+)

--- linux-cg.orig/arch/ppc64/kernel/spu_base.c	2005-08-25 23:12:30.395914664 -0400
+++ linux-cg/arch/ppc64/kernel/spu_base.c	2005-08-25 23:12:46.857941720 -0400
@@ -136,6 +136,7 @@ static int __spu_trap_data_map(struct sp
 static int __spu_trap_mailbox(struct spu *spu)
 {
 	wake_up_all(&spu->ibox_wq);
+	kill_fasync(&spu->ibox_fasync, SIGIO, POLLIN);
 
 	/* atomically disable SPU mailbox interrupts */
 	spin_lock(&spu->register_lock);
@@ -171,6 +172,7 @@ static int __spu_trap_tag_group(struct s
 static int __spu_trap_spubox(struct spu *spu)
 {
 	wake_up_all(&spu->wbox_wq);
+	kill_fasync(&spu->wbox_fasync, SIGIO, POLLOUT);
 
 	/* atomically disable SPU mailbox interrupts */
 	spin_lock(&spu->register_lock);
@@ -394,6 +396,8 @@ EXPORT_SYMBOL(spu_alloc);
 void spu_free(struct spu *spu)
 {
 	down(&spu_mutex);
+	spu->ibox_fasync = NULL;
+	spu->wbox_fasync = NULL;
 	list_add_tail(&spu->list, &spu_list);
 	up(&spu_mutex);
 }
@@ -676,6 +680,9 @@ static int __init create_spu(struct devi
 	init_waitqueue_head(&spu->wbox_wq);
 	init_waitqueue_head(&spu->ibox_wq);
 
+	spu->ibox_fasync = NULL;
+	spu->wbox_fasync = NULL;
+
 	down(&spu_mutex);
 	spu->number = number++;
 	ret = spu_request_irqs(spu);
--- linux-cg.orig/fs/spufs/file.c	2005-08-25 23:12:36.584905696 -0400
+++ linux-cg/fs/spufs/file.c	2005-08-25 23:12:46.858941568 -0400
@@ -198,6 +198,13 @@ size_t spu_ibox_read(struct spu *spu, u3
 }
 EXPORT_SYMBOL(spu_ibox_read);
 
+static int spufs_ibox_fasync(int fd, struct file *file, int on)
+{
+	struct spu_context *ctx;
+	ctx = file->private_data;
+	return fasync_helper(fd, file, on, &ctx->spu->ibox_fasync);
+}
+
 static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
@@ -253,6 +260,7 @@ static struct file_operations spufs_ibox
 	.open	= spufs_pipe_open,
 	.read	= spufs_ibox_read,
 	.poll	= spufs_ibox_poll,
+	.fasync	= spufs_ibox_fasync,
 };
 
 static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
@@ -302,6 +310,13 @@ size_t spu_wbox_write(struct spu *spu, u
 }
 EXPORT_SYMBOL(spu_wbox_write);
 
+static int spufs_wbox_fasync(int fd, struct file *file, int on)
+{
+	struct spu_context *ctx;
+	ctx = file->private_data;
+	return fasync_helper(fd, file, on, &ctx->spu->wbox_fasync);
+}
+
 static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 			size_t len, loff_t *pos)
 {
@@ -353,6 +368,7 @@ static struct file_operations spufs_wbox
 	.open	= spufs_pipe_open,
 	.write	= spufs_wbox_write,
 	.poll	= spufs_wbox_poll,
+	.fasync	= spufs_wbox_fasync,
 };
 
 static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
--- linux-cg.orig/include/asm-ppc64/spu.h	2005-08-25 23:12:30.400913904 -0400
+++ linux-cg/include/asm-ppc64/spu.h	2005-08-25 23:12:46.860941264 -0400
@@ -127,6 +127,8 @@ struct spu {
 	wait_queue_head_t stop_wq;
 	wait_queue_head_t ibox_wq;
 	wait_queue_head_t wbox_wq;
+	struct fasync_struct *ibox_fasync;
+	struct fasync_struct *wbox_fasync;
 
 	char irq_c0[8];
 	char irq_c1[8];

