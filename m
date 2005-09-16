Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbVIPHBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbVIPHBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVIPHBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:01:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65260 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161071AbVIPHBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:01:10 -0400
Message-Id: <20050916123314.058417000@localhost>
References: <20050916121646.387617000@localhost>
Date: Fri, 16 Sep 2005 08:16:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       jordi_caubet@es.ibm.com, Hiroyuki Machida <machida@sm.sony.co.jp>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 06/11] spufs: allow O_ASYNC on mailbox files
Content-Disposition: inline; filename=spufs-fasync-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to receive user-defined
signals when the spufs ibox and wbox files are accessed
from an SPE, so data can be read/written from/to
them again.

Unlike what I wrote previously, we now intend to keep
this as an official interface, in order to implement
one of the OS-independent library interfaces (namely
spe_get_event).

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 arch/ppc64/kernel/spu_base.c |    7 +++++++
 fs/spufs/file.c              |   16 ++++++++++++++++
 include/asm-ppc64/spu.h      |    2 ++
 3 files changed, 25 insertions(+)

Index: linux-cg/arch/ppc64/kernel/spu_base.c
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/spu_base.c
+++ linux-cg/arch/ppc64/kernel/spu_base.c
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
Index: linux-cg/fs/spufs/file.c
===================================================================
--- linux-cg.orig/fs/spufs/file.c
+++ linux-cg/fs/spufs/file.c
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
Index: linux-cg/include/asm-ppc64/spu.h
===================================================================
--- linux-cg.orig/include/asm-ppc64/spu.h
+++ linux-cg/include/asm-ppc64/spu.h
@@ -128,6 +128,8 @@ struct spu {
 	wait_queue_head_t stop_wq;
 	wait_queue_head_t ibox_wq;
 	wait_queue_head_t wbox_wq;
+	struct fasync_struct *ibox_fasync;
+	struct fasync_struct *wbox_fasync;
 
 	char irq_c0[8];
 	char irq_c1[8];

--

