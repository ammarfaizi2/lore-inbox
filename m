Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966351AbWKTSMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966351AbWKTSMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966336AbWKTSLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:11:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:37626 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934281AbWKTSHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:04 -0500
Message-Id: <20061120180526.374170000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:11 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, <linux-arch@vger.kernel.org>,
       Dwayne Grant McConnell <decimal@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 17/22] coredump: Add SPU elf notes to coredump.
Content-Disposition: inline; filename=coredump-add-spu-elf-notes-to-coredump.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dwayne Grant McConnell <decimal@us.ibm.com>
This patch adds SPU elf notes to the coredump. It creates a separate note
for each of /regs, /fpcr, /lslr, /decr, /decr_status, /mem, /signal1,
/signal1_type, /signal2, /signal2_type, /event_mask, /event_status,
/mbox_info, /ibox_info, /wbox_info, /dma_info, /proxydma_info, /object-id.

A new macro, ARCH_HAVE_EXTRA_NOTES, was created for architectures to 
specify they have extra elf core notes.

A new macro, ELF_CORE_EXTRA_NOTES_SIZE, was created so the size of the
additional notes could be calculated and added to the notes phdr entry.

A new macro, ELF_CORE_WRITE_EXTRA_NOTES, was created so the new notes
would be written after the existing notes.

The SPU coredump code resides in spufs. Stub functions are provided in the 
kernel which are hooked into the spufs code which does the actual work via 
register_arch_coredump_calls().

A new set of __spufs_<file>_read/get() functions was provided to allow the 
coredump code to read from the spufs files without having to lock the 
SPU context for each file read from.

Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Dwayne Grant McConnell <decimal@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Cc'ing linux-arch because I couldn't find the right maintainer
for fs/binfmt_elf.c, and the patch adds architecture specific hooks.

Index: linux-2.6/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6/arch/powerpc/platforms/cell/Makefile
@@ -15,5 +15,6 @@ spufs-modular-$(CONFIG_SPU_FS)		+= spu_s
 spu-priv1-$(CONFIG_PPC_CELL_NATIVE)	+= spu_priv1_mmio.o
 
 obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
+					   spu_coredump.o \
 					   $(spufs-modular-m) \
 					   $(spu-priv1-y) spufs/
Index: linux-2.6/arch/powerpc/platforms/cell/spu_coredump.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/cell/spu_coredump.c
@@ -0,0 +1,81 @@
+/*
+ * SPU core dump code
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
+#include <linux/file.h>
+#include <linux/module.h>
+#include <linux/syscalls.h>
+
+#include <asm/spu.h>
+
+static struct spu_coredump_calls spu_coredump_calls;
+static DEFINE_MUTEX(spu_coredump_mutex);
+
+int arch_notes_size(void)
+{
+	long ret;
+	struct module *owner = spu_coredump_calls.owner;
+
+	ret = -ENOSYS;
+	mutex_lock(&spu_coredump_mutex);
+	if (owner && try_module_get(owner)) {
+		ret = spu_coredump_calls.arch_notes_size();
+		module_put(owner);
+	}
+	mutex_unlock(&spu_coredump_mutex);
+	return ret;
+}
+
+void arch_write_notes(struct file *file)
+{
+	struct module *owner = spu_coredump_calls.owner;
+
+	mutex_lock(&spu_coredump_mutex);
+	if (owner && try_module_get(owner)) {
+		spu_coredump_calls.arch_write_notes(file);
+		module_put(owner);
+	}
+	mutex_unlock(&spu_coredump_mutex);
+}
+
+int register_arch_coredump_calls(struct spu_coredump_calls *calls)
+{
+	if (spu_coredump_calls.owner)
+		return -EBUSY;
+
+	mutex_lock(&spu_coredump_mutex);
+	spu_coredump_calls.arch_notes_size = calls->arch_notes_size;
+	spu_coredump_calls.arch_write_notes = calls->arch_write_notes;
+	spu_coredump_calls.owner = calls->owner;
+	mutex_unlock(&spu_coredump_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_arch_coredump_calls);
+
+void unregister_arch_coredump_calls(struct spu_coredump_calls *calls)
+{
+	BUG_ON(spu_coredump_calls.owner != calls->owner);
+
+	mutex_lock(&spu_coredump_mutex);
+	spu_coredump_calls.owner = NULL;
+	mutex_unlock(&spu_coredump_mutex);
+}
+EXPORT_SYMBOL_GPL(unregister_arch_coredump_calls);
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/coredump.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -0,0 +1,238 @@
+/*
+ * SPU core dump code
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
+#include <linux/elf.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/syscalls.h>
+
+#include <asm/uaccess.h>
+
+#include "spufs.h"
+
+struct spufs_ctx_info {
+	struct list_head list;
+	int dfd;
+	int memsize; /* in bytes */
+	struct spu_context *ctx;
+};
+
+static LIST_HEAD(ctx_info_list);
+
+static ssize_t do_coredump_read(int num, struct spu_context *ctx, void __user *buffer,
+				size_t size, loff_t *off)
+{
+	u64 data;
+	int ret;
+
+	if (spufs_coredump_read[num].read)
+		return spufs_coredump_read[num].read(ctx, buffer, size, off);
+
+	data = spufs_coredump_read[num].get(ctx);
+	ret = copy_to_user(buffer, &data, 8);
+	return ret ? -EFAULT : 8;
+}
+
+/*
+ * These are the only things you should do on a core-file: use only these
+ * functions to write out all the necessary info.
+ */
+static int spufs_dump_write(struct file *file, const void *addr, int nr)
+{
+	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
+}
+
+static int spufs_dump_seek(struct file *file, loff_t off)
+{
+	if (file->f_op->llseek) {
+		if (file->f_op->llseek(file, off, 0) != off)
+			return 0;
+	} else
+		file->f_pos = off;
+	return 1;
+}
+
+static void spufs_fill_memsize(struct spufs_ctx_info *ctx_info)
+{
+	struct spu_context *ctx;
+	unsigned long long lslr;
+
+	ctx = ctx_info->ctx;
+	lslr = ctx->csa.priv2.spu_lslr_RW;
+	ctx_info->memsize = lslr + 1;
+}
+
+static int spufs_ctx_note_size(struct spufs_ctx_info *ctx_info)
+{
+	int dfd, memsize, i, sz, total = 0;
+	char *name;
+	char fullname[80];
+
+	dfd = ctx_info->dfd;
+	memsize = ctx_info->memsize;
+
+	for (i = 0; spufs_coredump_read[i].name; i++) {
+		name = spufs_coredump_read[i].name;
+		sz = spufs_coredump_read[i].size;
+
+		sprintf(fullname, "SPU/%d/%s", dfd, name);
+
+		total += sizeof(struct elf_note);
+		total += roundup(strlen(fullname) + 1, 4);
+		if (!strcmp(name, "mem"))
+			total += roundup(memsize, 4);
+		else
+			total += roundup(sz, 4);
+	}
+
+	return total;
+}
+
+static int spufs_add_one_context(struct file *file, int dfd)
+{
+	struct spu_context *ctx;
+	struct spufs_ctx_info *ctx_info;
+	int size;
+
+	ctx = SPUFS_I(file->f_dentry->d_inode)->i_ctx;
+	if (ctx->flags & SPU_CREATE_NOSCHED)
+		return 0;
+
+	ctx_info = kzalloc(sizeof(*ctx_info), GFP_KERNEL);
+	if (unlikely(!ctx_info))
+		return -ENOMEM;
+
+	ctx_info->dfd = dfd;
+	ctx_info->ctx = ctx;
+
+	spufs_fill_memsize(ctx_info);
+
+	size = spufs_ctx_note_size(ctx_info);
+	list_add(&ctx_info->list, &ctx_info_list);
+	return size;
+}
+
+/*
+ * The additional architecture-specific notes for Cell are various
+ * context files in the spu context.
+ *
+ * This function iterates over all open file descriptors and sees
+ * if they are a directory in spufs.  In that case we use spufs
+ * internal functionality to dump them without needing to actually
+ * open the files.
+ */
+static int spufs_arch_notes_size(void)
+{
+	struct fdtable *fdt = files_fdtable(current->files);
+	int size = 0, fd;
+
+	for (fd = 0; fd < fdt->max_fdset && fd < fdt->max_fds; fd++) {
+		if (FD_ISSET(fd, fdt->open_fds)) {
+			struct file *file = fcheck(fd);
+
+			if (file && file->f_op == &spufs_context_fops) {
+				int rval = spufs_add_one_context(file, fd);
+				if (rval < 0)
+					break;
+				size += rval;
+			}
+		}
+	}
+
+	return size;
+}
+
+static void spufs_arch_write_note(struct spufs_ctx_info *ctx_info, int i,
+				struct file *file)
+{
+	struct spu_context *ctx;
+	loff_t pos = 0;
+	int sz, dfd, rc, total = 0;
+	const int bufsz = 4096;
+	char *name;
+	char fullname[80], *buf;
+	struct elf_note en;
+
+	buf = kmalloc(bufsz, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	dfd = ctx_info->dfd;
+	name = spufs_coredump_read[i].name;
+
+	if (!strcmp(name, "mem"))
+		sz = ctx_info->memsize;
+	else
+		sz = spufs_coredump_read[i].size;
+
+	ctx = ctx_info->ctx;
+	if (!ctx) {
+		return;
+	}
+
+	sprintf(fullname, "SPU/%d/%s", dfd, name);
+	en.n_namesz = strlen(fullname) + 1;
+	en.n_descsz = sz;
+	en.n_type = NT_SPU;
+
+	if (!spufs_dump_write(file, &en, sizeof(en)))
+		return;
+	if (!spufs_dump_write(file, fullname, en.n_namesz))
+		return;
+	if (!spufs_dump_seek(file, roundup((unsigned long)file->f_pos, 4)))
+		return;
+
+	do {
+		rc = do_coredump_read(i, ctx, buf, bufsz, &pos);
+		if (rc > 0) {
+			if (!spufs_dump_write(file, buf, rc))
+				return;
+			total += rc;
+		}
+	} while (rc == bufsz && total < sz);
+
+	spufs_dump_seek(file, roundup((unsigned long)file->f_pos
+						- total + sz, 4));
+}
+
+static void spufs_arch_write_notes(struct file *file)
+{
+	int j;
+	struct spufs_ctx_info *ctx_info, *next;
+
+	list_for_each_entry_safe(ctx_info, next, &ctx_info_list, list) {
+		spu_acquire_saved(ctx_info->ctx);
+		for (j = 0; j < spufs_coredump_num_notes; j++)
+			spufs_arch_write_note(ctx_info, j, file);
+		spu_release(ctx_info->ctx);
+		list_del(&ctx_info->list);
+		kfree(ctx_info);
+	}
+}
+
+struct spu_coredump_calls spufs_coredump_calls = {
+	.arch_notes_size = spufs_arch_notes_size,
+	.arch_write_notes = spufs_arch_write_notes,
+	.owner = THIS_MODULE,
+};
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -39,7 +39,6 @@
 
 #define SPUFS_MMAP_4K (PAGE_SIZE == 0x1000)
 
-
 static int
 spufs_mem_open(struct inode *inode, struct file *file)
 {
@@ -52,18 +51,23 @@ spufs_mem_open(struct inode *inode, stru
 }
 
 static ssize_t
+__spufs_mem_read(struct spu_context *ctx, char __user *buffer,
+			size_t size, loff_t *pos)
+{
+	char *local_store = ctx->ops->get_ls(ctx);
+	return simple_read_from_buffer(buffer, size, pos, local_store,
+					LS_SIZE);
+}
+
+static ssize_t
 spufs_mem_read(struct file *file, char __user *buffer,
 				size_t size, loff_t *pos)
 {
-	struct spu_context *ctx = file->private_data;
-	char *local_store;
 	int ret;
+	struct spu_context *ctx = file->private_data;
 
 	spu_acquire(ctx);
-
-	local_store = ctx->ops->get_ls(ctx);
-	ret = simple_read_from_buffer(buffer, size, pos, local_store, LS_SIZE);
-
+	ret = __spufs_mem_read(ctx, buffer, size, pos);
 	spu_release(ctx);
 	return ret;
 }
@@ -262,18 +266,23 @@ spufs_regs_open(struct inode *inode, str
 }
 
 static ssize_t
+__spufs_regs_read(struct spu_context *ctx, char __user *buffer,
+			size_t size, loff_t *pos)
+{
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	return simple_read_from_buffer(buffer, size, pos,
+				      lscsa->gprs, sizeof lscsa->gprs);
+}
+
+static ssize_t
 spufs_regs_read(struct file *file, char __user *buffer,
 		size_t size, loff_t *pos)
 {
-	struct spu_context *ctx = file->private_data;
-	struct spu_lscsa *lscsa = ctx->csa.lscsa;
 	int ret;
+	struct spu_context *ctx = file->private_data;
 
 	spu_acquire_saved(ctx);
-
-	ret = simple_read_from_buffer(buffer, size, pos,
-				      lscsa->gprs, sizeof lscsa->gprs);
-
+	ret = __spufs_regs_read(ctx, buffer, size, pos);
 	spu_release(ctx);
 	return ret;
 }
@@ -308,18 +317,23 @@ static struct file_operations spufs_regs
 };
 
 static ssize_t
+__spufs_fpcr_read(struct spu_context *ctx, char __user * buffer,
+			size_t size, loff_t * pos)
+{
+	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	return simple_read_from_buffer(buffer, size, pos,
+				      &lscsa->fpcr, sizeof(lscsa->fpcr));
+}
+
+static ssize_t
 spufs_fpcr_read(struct file *file, char __user * buffer,
 		size_t size, loff_t * pos)
 {
-	struct spu_context *ctx = file->private_data;
-	struct spu_lscsa *lscsa = ctx->csa.lscsa;
 	int ret;
+	struct spu_context *ctx = file->private_data;
 
 	spu_acquire_saved(ctx);
-
-	ret = simple_read_from_buffer(buffer, size, pos,
-				      &lscsa->fpcr, sizeof(lscsa->fpcr));
-
+	ret = __spufs_fpcr_read(ctx, buffer, size, pos);
 	spu_release(ctx);
 	return ret;
 }
@@ -719,22 +733,19 @@ static int spufs_signal1_open(struct ino
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
+static ssize_t __spufs_signal1_read(struct spu_context *ctx, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx = file->private_data;
 	int ret = 0;
 	u32 data;
 
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire_saved(ctx);
 	if (ctx->csa.spu_chnlcnt_RW[3]) {
 		data = ctx->csa.spu_chnldata_RW[3];
 		ret = 4;
 	}
-	spu_release(ctx);
 
 	if (!ret)
 		goto out;
@@ -746,6 +757,19 @@ out:
 	return ret;
 }
 
+static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	int ret;
+	struct spu_context *ctx = file->private_data;
+
+	spu_acquire_saved(ctx);
+	ret = __spufs_signal1_read(ctx, buf, len, pos);
+	spu_release(ctx);
+
+	return ret;
+}
+
 static ssize_t spufs_signal1_write(struct file *file, const char __user *buf,
 			size_t len, loff_t *pos)
 {
@@ -816,22 +840,19 @@ static int spufs_signal2_open(struct ino
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t spufs_signal2_read(struct file *file, char __user *buf,
+static ssize_t __spufs_signal2_read(struct spu_context *ctx, char __user *buf,
 			size_t len, loff_t *pos)
 {
-	struct spu_context *ctx = file->private_data;
 	int ret = 0;
 	u32 data;
 
 	if (len < 4)
 		return -EINVAL;
 
-	spu_acquire_saved(ctx);
 	if (ctx->csa.spu_chnlcnt_RW[4]) {
 		data =  ctx->csa.spu_chnldata_RW[4];
 		ret = 4;
 	}
-	spu_release(ctx);
 
 	if (!ret)
 		goto out;
@@ -840,7 +861,20 @@ static ssize_t spufs_signal2_read(struct
 		return -EFAULT;
 
 out:
-	return 4;
+	return ret;
+}
+
+static ssize_t spufs_signal2_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	int ret;
+
+	spu_acquire_saved(ctx);
+	ret = __spufs_signal2_read(ctx, buf, len, pos);
+	spu_release(ctx);
+
+	return ret;
 }
 
 static ssize_t spufs_signal2_write(struct file *file, const char __user *buf,
@@ -916,13 +950,19 @@ static void spufs_signal1_type_set(void 
 	spu_release(ctx);
 }
 
+static u64 __spufs_signal1_type_get(void *data)
+{
+	struct spu_context *ctx = data;
+	return ctx->ops->signal1_type_get(ctx);
+}
+
 static u64 spufs_signal1_type_get(void *data)
 {
 	struct spu_context *ctx = data;
 	u64 ret;
 
 	spu_acquire(ctx);
-	ret = ctx->ops->signal1_type_get(ctx);
+	ret = __spufs_signal1_type_get(data);
 	spu_release(ctx);
 
 	return ret;
@@ -939,13 +979,19 @@ static void spufs_signal2_type_set(void 
 	spu_release(ctx);
 }
 
+static u64 __spufs_signal2_type_get(void *data)
+{
+	struct spu_context *ctx = data;
+	return ctx->ops->signal2_type_get(ctx);
+}
+
 static u64 spufs_signal2_type_get(void *data)
 {
 	struct spu_context *ctx = data;
 	u64 ret;
 
 	spu_acquire(ctx);
-	ret = ctx->ops->signal2_type_get(ctx);
+	ret = __spufs_signal2_type_get(data);
 	spu_release(ctx);
 
 	return ret;
@@ -1387,13 +1433,19 @@ static void spufs_decr_set(void *data, u
 	spu_release(ctx);
 }
 
-static u64 spufs_decr_get(void *data)
+static u64 __spufs_decr_get(void *data)
 {
 	struct spu_context *ctx = data;
 	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	return lscsa->decr.slot[0];
+}
+
+static u64 spufs_decr_get(void *data)
+{
+	struct spu_context *ctx = data;
 	u64 ret;
 	spu_acquire_saved(ctx);
-	ret = lscsa->decr.slot[0];
+	ret = __spufs_decr_get(data);
 	spu_release(ctx);
 	return ret;
 }
@@ -1409,13 +1461,19 @@ static void spufs_decr_status_set(void *
 	spu_release(ctx);
 }
 
-static u64 spufs_decr_status_get(void *data)
+static u64 __spufs_decr_status_get(void *data)
 {
 	struct spu_context *ctx = data;
 	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	return lscsa->decr_status.slot[0];
+}
+
+static u64 spufs_decr_status_get(void *data)
+{
+	struct spu_context *ctx = data;
 	u64 ret;
 	spu_acquire_saved(ctx);
-	ret = lscsa->decr_status.slot[0];
+	ret = __spufs_decr_status_get(data);
 	spu_release(ctx);
 	return ret;
 }
@@ -1431,30 +1489,43 @@ static void spufs_event_mask_set(void *d
 	spu_release(ctx);
 }
 
-static u64 spufs_event_mask_get(void *data)
+static u64 __spufs_event_mask_get(void *data)
 {
 	struct spu_context *ctx = data;
 	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	return lscsa->event_mask.slot[0];
+}
+
+static u64 spufs_event_mask_get(void *data)
+{
+	struct spu_context *ctx = data;
 	u64 ret;
 	spu_acquire_saved(ctx);
-	ret = lscsa->event_mask.slot[0];
+	ret = __spufs_event_mask_get(data);
 	spu_release(ctx);
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_event_mask_ops, spufs_event_mask_get,
 			spufs_event_mask_set, "0x%llx\n")
 
-static u64 spufs_event_status_get(void *data)
+static u64 __spufs_event_status_get(void *data)
 {
 	struct spu_context *ctx = data;
 	struct spu_state *state = &ctx->csa;
-	u64 ret = 0;
 	u64 stat;
-
-	spu_acquire_saved(ctx);
 	stat = state->spu_chnlcnt_RW[0];
 	if (stat)
-		ret = state->spu_chnldata_RW[0];
+		return state->spu_chnldata_RW[0];
+	return 0;
+}
+
+static u64 spufs_event_status_get(void *data)
+{
+	struct spu_context *ctx = data;
+	u64 ret = 0;
+
+	spu_acquire_saved(ctx);
+	ret = __spufs_event_status_get(data);
 	spu_release(ctx);
 	return ret;
 }
@@ -1499,12 +1570,18 @@ static u64 spufs_id_get(void *data)
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_id_ops, spufs_id_get, NULL, "0x%llx\n")
 
-static u64 spufs_object_id_get(void *data)
+static u64 __spufs_object_id_get(void *data)
 {
 	struct spu_context *ctx = data;
 	return ctx->object_id;
 }
 
+static u64 spufs_object_id_get(void *data)
+{
+	/* FIXME: Should there really be no locking here? */
+	return __spufs_object_id_get(data);
+}
+
 static void spufs_object_id_set(void *data, u64 id)
 {
 	struct spu_context *ctx = data;
@@ -1514,13 +1591,19 @@ static void spufs_object_id_set(void *da
 DEFINE_SIMPLE_ATTRIBUTE(spufs_object_id_ops, spufs_object_id_get,
 		spufs_object_id_set, "0x%llx\n");
 
+static u64 __spufs_lslr_get(void *data)
+{
+	struct spu_context *ctx = data;
+	return ctx->csa.priv2.spu_lslr_RW;
+}
+
 static u64 spufs_lslr_get(void *data)
 {
 	struct spu_context *ctx = data;
 	u64 ret;
 
 	spu_acquire_saved(ctx);
-	ret = ctx->csa.priv2.spu_lslr_RW;
+	ret = __spufs_lslr_get(data);
 	spu_release(ctx);
 
 	return ret;
@@ -1535,26 +1618,36 @@ static int spufs_info_open(struct inode 
 	return 0;
 }
 
+static ssize_t __spufs_mbox_info_read(struct spu_context *ctx,
+			char __user *buf, size_t len, loff_t *pos)
+{
+	u32 mbox_stat;
+	u32 data;
+
+	mbox_stat = ctx->csa.prob.mb_stat_R;
+	if (mbox_stat & 0x0000ff) {
+		data = ctx->csa.prob.pu_mb_R;
+	}
+
+	return simple_read_from_buffer(buf, len, pos, &data, sizeof data);
+}
+
 static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
 				   size_t len, loff_t *pos)
 {
+	int ret;
 	struct spu_context *ctx = file->private_data;
-	u32 mbox_stat;
-	u32 data;
 
 	if (!access_ok(VERIFY_WRITE, buf, len))
 		return -EFAULT;
 
 	spu_acquire_saved(ctx);
 	spin_lock(&ctx->csa.register_lock);
-	mbox_stat = ctx->csa.prob.mb_stat_R;
-	if (mbox_stat & 0x0000ff) {
-		data = ctx->csa.prob.pu_mb_R;
-	}
+	ret = __spufs_mbox_info_read(ctx, buf, len, pos);
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release(ctx);
 
-	return simple_read_from_buffer(buf, len, pos, &data, sizeof data);
+	return ret;
 }
 
 static struct file_operations spufs_mbox_info_fops = {
@@ -1563,26 +1656,36 @@ static struct file_operations spufs_mbox
 	.llseek  = generic_file_llseek,
 };
 
+static ssize_t __spufs_ibox_info_read(struct spu_context *ctx,
+				char __user *buf, size_t len, loff_t *pos)
+{
+	u32 ibox_stat;
+	u32 data;
+
+	ibox_stat = ctx->csa.prob.mb_stat_R;
+	if (ibox_stat & 0xff0000) {
+		data = ctx->csa.priv2.puint_mb_R;
+	}
+
+	return simple_read_from_buffer(buf, len, pos, &data, sizeof data);
+}
+
 static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
 				   size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	u32 ibox_stat;
-	u32 data;
+	int ret;
 
 	if (!access_ok(VERIFY_WRITE, buf, len))
 		return -EFAULT;
 
 	spu_acquire_saved(ctx);
 	spin_lock(&ctx->csa.register_lock);
-	ibox_stat = ctx->csa.prob.mb_stat_R;
-	if (ibox_stat & 0xff0000) {
-		data = ctx->csa.priv2.puint_mb_R;
-	}
+	ret = __spufs_ibox_info_read(ctx, buf, len, pos);
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release(ctx);
 
-	return simple_read_from_buffer(buf, len, pos, &data, sizeof data);
+	return ret;
 }
 
 static struct file_operations spufs_ibox_info_fops = {
@@ -1591,29 +1694,39 @@ static struct file_operations spufs_ibox
 	.llseek  = generic_file_llseek,
 };
 
-static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
-				   size_t len, loff_t *pos)
+static ssize_t __spufs_wbox_info_read(struct spu_context *ctx,
+			char __user *buf, size_t len, loff_t *pos)
 {
-	struct spu_context *ctx = file->private_data;
 	int i, cnt;
 	u32 data[4];
 	u32 wbox_stat;
 
+	wbox_stat = ctx->csa.prob.mb_stat_R;
+	cnt = 4 - ((wbox_stat & 0x00ff00) >> 8);
+	for (i = 0; i < cnt; i++) {
+		data[i] = ctx->csa.spu_mailbox_data[i];
+	}
+
+	return simple_read_from_buffer(buf, len, pos, &data,
+				cnt * sizeof(u32));
+}
+
+static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
+				   size_t len, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	int ret;
+
 	if (!access_ok(VERIFY_WRITE, buf, len))
 		return -EFAULT;
 
 	spu_acquire_saved(ctx);
 	spin_lock(&ctx->csa.register_lock);
-	wbox_stat = ctx->csa.prob.mb_stat_R;
-	cnt = (wbox_stat & 0x00ff00) >> 8;
-	for (i = 0; i < cnt; i++) {
-		data[i] = ctx->csa.spu_mailbox_data[i];
-	}
+	ret = __spufs_wbox_info_read(ctx, buf, len, pos);
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release(ctx);
 
-	return simple_read_from_buffer(buf, len, pos, &data,
-				cnt * sizeof(u32));
+	return ret;
 }
 
 static struct file_operations spufs_wbox_info_fops = {
@@ -1622,19 +1735,13 @@ static struct file_operations spufs_wbox
 	.llseek  = generic_file_llseek,
 };
 
-static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
-			      size_t len, loff_t *pos)
+static ssize_t __spufs_dma_info_read(struct spu_context *ctx,
+			char __user *buf, size_t len, loff_t *pos)
 {
-	struct spu_context *ctx = file->private_data;
 	struct spu_dma_info info;
 	struct mfc_cq_sr *qp, *spuqp;
 	int i;
 
-	if (!access_ok(VERIFY_WRITE, buf, len))
-		return -EFAULT;
-
-	spu_acquire_saved(ctx);
-	spin_lock(&ctx->csa.register_lock);
 	info.dma_info_type = ctx->csa.priv2.spu_tag_status_query_RW;
 	info.dma_info_mask = ctx->csa.lscsa->tag_mask.slot[0];
 	info.dma_info_status = ctx->csa.spu_chnldata_RW[24];
@@ -1649,25 +1756,40 @@ static ssize_t spufs_dma_info_read(struc
 		qp->mfc_cq_data2_RW = spuqp->mfc_cq_data2_RW;
 		qp->mfc_cq_data3_RW = spuqp->mfc_cq_data3_RW;
 	}
-	spin_unlock(&ctx->csa.register_lock);
-	spu_release(ctx);
 
 	return simple_read_from_buffer(buf, len, pos, &info,
 				sizeof info);
 }
 
+static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
+			      size_t len, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	int ret;
+
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+
+	spu_acquire_saved(ctx);
+	spin_lock(&ctx->csa.register_lock);
+	ret = __spufs_dma_info_read(ctx, buf, len, pos);
+	spin_unlock(&ctx->csa.register_lock);
+	spu_release(ctx);
+
+	return ret;
+}
+
 static struct file_operations spufs_dma_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_dma_info_read,
 };
 
-static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
-				   size_t len, loff_t *pos)
+static ssize_t __spufs_proxydma_info_read(struct spu_context *ctx,
+			char __user *buf, size_t len, loff_t *pos)
 {
-	struct spu_context *ctx = file->private_data;
 	struct spu_proxydma_info info;
-	int ret = sizeof info;
 	struct mfc_cq_sr *qp, *puqp;
+	int ret = sizeof info;
 	int i;
 
 	if (len < ret)
@@ -1676,8 +1798,6 @@ static ssize_t spufs_proxydma_info_read(
 	if (!access_ok(VERIFY_WRITE, buf, len))
 		return -EFAULT;
 
-	spu_acquire_saved(ctx);
-	spin_lock(&ctx->csa.register_lock);
 	info.proxydma_info_type = ctx->csa.prob.dma_querytype_RW;
 	info.proxydma_info_mask = ctx->csa.prob.dma_querymask_RW;
 	info.proxydma_info_status = ctx->csa.prob.dma_tagstatus_R;
@@ -1690,12 +1810,23 @@ static ssize_t spufs_proxydma_info_read(
 		qp->mfc_cq_data2_RW = puqp->mfc_cq_data2_RW;
 		qp->mfc_cq_data3_RW = puqp->mfc_cq_data3_RW;
 	}
+
+	return simple_read_from_buffer(buf, len, pos, &info,
+				sizeof info);
+}
+
+static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
+				   size_t len, loff_t *pos)
+{
+	struct spu_context *ctx = file->private_data;
+	int ret;
+
+	spu_acquire_saved(ctx);
+	spin_lock(&ctx->csa.register_lock);
+	ret = __spufs_proxydma_info_read(ctx, buf, len, pos);
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release(ctx);
 
-	if (copy_to_user(buf, &info, sizeof info))
-		ret = -EFAULT;
-
 	return ret;
 }
 
@@ -1760,3 +1891,27 @@ struct tree_descr spufs_dir_nosched_cont
 	{ "object-id", &spufs_object_id_ops, 0666, },
 	{},
 };
+
+struct spufs_coredump_reader spufs_coredump_read[] = {
+	{ "regs", __spufs_regs_read, NULL, 128 * 16 },
+	{ "fpcr", __spufs_fpcr_read, NULL, 16 },
+	{ "lslr", NULL, __spufs_lslr_get, 11 },
+	{ "decr", NULL, __spufs_decr_get, 11 },
+	{ "decr_status", NULL, __spufs_decr_status_get, 11 },
+	{ "mem", __spufs_mem_read, NULL, 256 * 1024, },
+	{ "signal1", __spufs_signal1_read, NULL, 4 },
+	{ "signal1_type", NULL, __spufs_signal1_type_get, 2 },
+	{ "signal2", __spufs_signal2_read, NULL, 4 },
+	{ "signal2_type", NULL, __spufs_signal2_type_get, 2 },
+	{ "event_mask", NULL, __spufs_event_mask_get, 8 },
+	{ "event_status", NULL, __spufs_event_status_get, 8 },
+	{ "mbox_info", __spufs_mbox_info_read, NULL, 4 },
+	{ "ibox_info", __spufs_ibox_info_read, NULL, 4 },
+	{ "wbox_info", __spufs_wbox_info_read, NULL, 16 },
+	{ "dma_info", __spufs_dma_info_read, NULL, 69 * 8 },
+	{ "proxydma_info", __spufs_proxydma_info_read, NULL, 35 * 8 },
+	{ "object-id", NULL, __spufs_object_id_get, 19 },
+	{ },
+};
+int spufs_coredump_num_notes = ARRAY_SIZE(spufs_coredump_read) - 1;
+
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -232,6 +232,7 @@ struct file_operations spufs_context_fop
 	.readdir	= dcache_readdir,
 	.fsync		= simple_sync_file,
 };
+EXPORT_SYMBOL_GPL(spufs_context_fops);
 
 static int
 spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
@@ -647,6 +648,7 @@ static struct file_system_type spufs_typ
 static int __init spufs_init(void)
 {
 	int ret;
+
 	ret = -ENOMEM;
 	spufs_inode_cache = kmem_cache_create("spufs_inode_cache",
 			sizeof(struct spufs_inode_info), 0,
@@ -664,8 +666,12 @@ static int __init spufs_init(void)
 	ret = register_spu_syscalls(&spufs_calls);
 	if (ret)
 		goto out_fs;
+	ret = register_arch_coredump_calls(&spufs_coredump_calls);
+	if (ret)
+		goto out_fs;
 
 	spufs_init_isolated_loader();
+
 	return 0;
 out_fs:
 	unregister_filesystem(&spufs_type);
@@ -679,6 +685,7 @@ module_init(spufs_init);
 static void __exit spufs_exit(void)
 {
 	spu_sched_exit();
+	unregister_arch_coredump_calls(&spufs_coredump_calls);
 	unregister_spu_syscalls(&spufs_calls);
 	unregister_filesystem(&spufs_type);
 	kmem_cache_destroy(spufs_inode_cache);
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/Makefile
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/Makefile
@@ -1,7 +1,7 @@
 obj-y += switch.o
 
 obj-$(CONFIG_SPU_FS) += spufs.o
-spufs-y += inode.o file.o context.o syscalls.o
+spufs-y += inode.o file.o context.o syscalls.o coredump.o
 spufs-y += sched.o backing_ops.o hw_ops.o run.o gang.o
 
 # Rules to build switch.o with the help of SPU tool chain
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -223,4 +223,15 @@ void spufs_stop_callback(struct spu *spu
 void spufs_mfc_callback(struct spu *spu);
 void spufs_dma_callback(struct spu *spu, int type);
 
+extern struct spu_coredump_calls spufs_coredump_calls;
+struct spufs_coredump_reader {
+	char *name;
+	ssize_t (*read)(struct spu_context *ctx,
+			char __user *buffer, size_t size, loff_t *pos);
+	u64 (*get)(void *data);
+	size_t size;
+};
+extern struct spufs_coredump_reader spufs_coredump_read[];
+extern int spufs_coredump_num_notes;
+
 #endif
Index: linux-2.6/fs/binfmt_elf.c
===================================================================
--- linux-2.6.orig/fs/binfmt_elf.c
+++ linux-2.6/fs/binfmt_elf.c
@@ -1582,6 +1582,10 @@ static int elf_core_dump(long signr, str
 		
 		sz += thread_status_size;
 
+#ifdef ELF_CORE_WRITE_EXTRA_NOTES
+		sz += ELF_CORE_EXTRA_NOTES_SIZE;
+#endif
+
 		fill_elf_note_phdr(&phdr, sz, offset);
 		offset += sz;
 		DUMP_WRITE(&phdr, sizeof(phdr));
@@ -1622,6 +1626,10 @@ static int elf_core_dump(long signr, str
 		if (!writenote(notes + i, file, &foffset))
 			goto end_coredump;
 
+#ifdef ELF_CORE_WRITE_EXTRA_NOTES
+	ELF_CORE_WRITE_EXTRA_NOTES;
+#endif
+
 	/* write out the thread status notes section */
 	list_for_each(t, &thread_list) {
 		struct elf_thread_status *tmp =
Index: linux-2.6/include/asm-powerpc/elf.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/elf.h
+++ linux-2.6/include/asm-powerpc/elf.h
@@ -411,4 +411,17 @@ do {									\
 /* Keep this the last entry.  */
 #define R_PPC64_NUM		107
 
+#ifdef CONFIG_PPC_CELL
+/* Notes used in ET_CORE. Note name is "SPU/<fd>/<filename>". */
+#define NT_SPU		1
+
+extern int arch_notes_size(void);
+extern void arch_write_notes(struct file *file);
+
+#define ELF_CORE_EXTRA_NOTES_SIZE arch_notes_size()
+#define ELF_CORE_WRITE_EXTRA_NOTES arch_write_notes(file)
+
+#define ARCH_HAVE_EXTRA_ELF_NOTES
+#endif /* CONFIG_PPC_CELL */
+
 #endif /* _ASM_POWERPC_ELF_H */
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -172,6 +172,13 @@ extern struct spufs_calls {
 	struct module *owner;
 } spufs_calls;
 
+/* coredump calls implemented in spufs */
+struct spu_coredump_calls {
+	asmlinkage int (*arch_notes_size)(void);
+	asmlinkage void (*arch_write_notes)(struct file *file);
+	struct module *owner;
+};
+
 /* return status from spu_run, same as in libspe */
 #define SPE_EVENT_DMA_ALIGNMENT		0x0008	/*A DMA alignment error */
 #define SPE_EVENT_SPE_ERROR		0x0010	/*An illegal instruction error*/
@@ -203,6 +210,9 @@ static inline void unregister_spu_syscal
 }
 #endif /* MODULE */
 
+int register_arch_coredump_calls(struct spu_coredump_calls *calls);
+void unregister_arch_coredump_calls(struct spu_coredump_calls *calls);
+
 int spu_add_sysdev_attr(struct sysdev_attribute *attr);
 void spu_remove_sysdev_attr(struct sysdev_attribute *attr);
 
Index: linux-2.6/include/linux/elf.h
===================================================================
--- linux-2.6.orig/include/linux/elf.h
+++ linux-2.6/include/linux/elf.h
@@ -368,5 +368,12 @@ extern Elf64_Dyn _DYNAMIC [];
 
 #endif
 
+#ifndef ARCH_HAVE_EXTRA_ELF_NOTES
+static inline int arch_notes_size(void) { return 0; }
+static inline int arch_write_notes(void) { return 0; }
+
+#define ELF_CORE_EXTRA_NOTES_SIZE arch_notes_size()
+#define ELF_CORE_WRITE_EXTRA_NOTES arch_write_notes(file)
+#endif /* ARCH_HAVE_EXTRA_ELF_NOTES */
 
 #endif /* _LINUX_ELF_H */

--

