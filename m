Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965294AbWADT6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbWADT6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbWADT57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:57:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:58869 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965291AbWADT5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:42 -0500
Message-Id: <20060104194501.555900000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:29 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 09/13] spufs: move spu_run call to its own file
Content-Disposition: inline; filename=spufs-run-c-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The logic for sys_spu_run keeps growing and it does
not really belong into file.c any more since we
moved away from using regular file operations to our
own syscall.

No functional change in here.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/Makefile
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_SPU_FS) += spufs.o
 spufs-y += inode.o file.o context.o switch.o syscalls.o
-spufs-y += sched.o backing_ops.o hw_ops.o
+spufs-y += sched.o backing_ops.o hw_ops.o run.o
 
 # Rules to build switch.o with the help of SPU tool chain
 SPU_CROSS	:= spu-
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/file.c
@@ -304,34 +304,6 @@ static struct file_operations spufs_mbox
 	.read	= spufs_mbox_stat_read,
 };
 
-/*
- * spufs_wait
- * 	Same as wait_event_interruptible(), except that here
- *	we need to call spu_release(ctx) before sleeping, and
- *	then spu_acquire(ctx) when awoken.
- */
-
-#define spufs_wait(wq, condition)					\
-({									\
-	int __ret = 0;							\
-	DEFINE_WAIT(__wait);						\
-	for (;;) {							\
-		prepare_to_wait(&(wq), &__wait, TASK_INTERRUPTIBLE);	\
-		if (condition)						\
-			break;						\
-		if (!signal_pending(current)) {				\
-			spu_release(ctx);				\
-			schedule();					\
-			spu_acquire(ctx);				\
-			continue;					\
-		}							\
-		__ret = -ERESTARTSYS;					\
-		break;							\
-	}								\
-	finish_wait(&(wq), &__wait);					\
-	__ret;								\
-})
-
 /* low-level ibox access function */
 size_t spu_ibox_read(struct spu_context *ctx, u32 *data)
 {
@@ -529,130 +501,6 @@ static struct file_operations spufs_wbox
 	.read	= spufs_wbox_stat_read,
 };
 
-/* interrupt-level stop callback function. */
-void spufs_stop_callback(struct spu *spu)
-{
-	struct spu_context *ctx = spu->ctx;
-
-	wake_up_all(&ctx->stop_wq);
-}
-
-static inline int spu_stopped(struct spu_context *ctx, u32 * stat)
-{
-	struct spu *spu;
-	u64 pte_fault;
-
-	*stat = ctx->ops->status_read(ctx);
-	if (ctx->state != SPU_STATE_RUNNABLE)
-		return 1;
-	spu = ctx->spu;
-	pte_fault = spu->dsisr &
-	    (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED);
-	return (!(*stat & 0x1) || pte_fault || spu->class_0_pending) ? 1 : 0;
-}
-
-static inline int spu_run_init(struct spu_context *ctx, u32 * npc,
-			       u32 * status)
-{
-	int ret;
-
-	if ((ret = spu_acquire_runnable(ctx)) != 0)
-		return ret;
-	ctx->ops->npc_write(ctx, *npc);
-	ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_RUNNABLE);
-	return 0;
-}
-
-static inline int spu_run_fini(struct spu_context *ctx, u32 * npc,
-			       u32 * status)
-{
-	int ret = 0;
-
-	*status = ctx->ops->status_read(ctx);
-	*npc = ctx->ops->npc_read(ctx);
-	spu_release(ctx);
-
-	if (signal_pending(current))
-		ret = -ERESTARTSYS;
-	if (unlikely(current->ptrace & PT_PTRACED)) {
-		if ((*status & SPU_STATUS_STOPPED_BY_STOP)
-		    && (*status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
-			force_sig(SIGTRAP, current);
-			ret = -ERESTARTSYS;
-		}
-	}
-	return ret;
-}
-
-static inline int spu_reacquire_runnable(struct spu_context *ctx, u32 *npc,
-				         u32 *status)
-{
-	int ret;
-
-	if ((ret = spu_run_fini(ctx, npc, status)) != 0)
-		return ret;
-	if (*status & (SPU_STATUS_STOPPED_BY_STOP |
-		       SPU_STATUS_STOPPED_BY_HALT)) {
-		return *status;
-	}
-	if ((ret = spu_run_init(ctx, npc, status)) != 0)
-		return ret;
-	return 0;
-}
-
-static inline int spu_process_events(struct spu_context *ctx)
-{
-	struct spu *spu = ctx->spu;
-	u64 pte_fault = MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED;
-	int ret = 0;
-
-	if (spu->dsisr & pte_fault)
-		ret = spu_irq_class_1_bottom(spu);
-	if (spu->class_0_pending)
-		ret = spu_irq_class_0_bottom(spu);
-	if (!ret && signal_pending(current))
-		ret = -ERESTARTSYS;
-	return ret;
-}
-
-long spufs_run_spu(struct file *file, struct spu_context *ctx,
-		   u32 * npc, u32 * status)
-{
-	int ret;
-
-	if (down_interruptible(&ctx->run_sema))
-		return -ERESTARTSYS;
-
-	ret = spu_run_init(ctx, npc, status);
-	if (ret)
-		goto out;
-
-	do {
-		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, status));
-		if (unlikely(ret))
-			break;
-		if (unlikely(ctx->state != SPU_STATE_RUNNABLE)) {
-			ret = spu_reacquire_runnable(ctx, npc, status);
-			if (ret)
-				goto out;
-			continue;
-		}
-		ret = spu_process_events(ctx);
-
-	} while (!ret && !(*status & (SPU_STATUS_STOPPED_BY_STOP |
-				      SPU_STATUS_STOPPED_BY_HALT)));
-
-	ctx->ops->runcntl_stop(ctx);
-	ret = spu_run_fini(ctx, npc, status);
-	if (!ret)
-		ret = *status;
-	spu_yield(ctx);
-
-out:
-	up(&ctx->run_sema);
-	return ret;
-}
-
 static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/run.c
@@ -0,0 +1,131 @@
+#include <linux/wait.h>
+#include <linux/ptrace.h>
+
+#include <asm/spu.h>
+
+#include "spufs.h"
+
+/* interrupt-level stop callback function. */
+void spufs_stop_callback(struct spu *spu)
+{
+	struct spu_context *ctx = spu->ctx;
+
+	wake_up_all(&ctx->stop_wq);
+}
+
+static inline int spu_stopped(struct spu_context *ctx, u32 * stat)
+{
+	struct spu *spu;
+	u64 pte_fault;
+
+	*stat = ctx->ops->status_read(ctx);
+	if (ctx->state != SPU_STATE_RUNNABLE)
+		return 1;
+	spu = ctx->spu;
+	pte_fault = spu->dsisr &
+	    (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED);
+	return (!(*stat & 0x1) || pte_fault || spu->class_0_pending) ? 1 : 0;
+}
+
+static inline int spu_run_init(struct spu_context *ctx, u32 * npc,
+			       u32 * status)
+{
+	int ret;
+
+	if ((ret = spu_acquire_runnable(ctx)) != 0)
+		return ret;
+	ctx->ops->npc_write(ctx, *npc);
+	ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_RUNNABLE);
+	return 0;
+}
+
+static inline int spu_run_fini(struct spu_context *ctx, u32 * npc,
+			       u32 * status)
+{
+	int ret = 0;
+
+	*status = ctx->ops->status_read(ctx);
+	*npc = ctx->ops->npc_read(ctx);
+	spu_release(ctx);
+
+	if (signal_pending(current))
+		ret = -ERESTARTSYS;
+	if (unlikely(current->ptrace & PT_PTRACED)) {
+		if ((*status & SPU_STATUS_STOPPED_BY_STOP)
+		    && (*status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
+			force_sig(SIGTRAP, current);
+			ret = -ERESTARTSYS;
+		}
+	}
+	return ret;
+}
+
+static inline int spu_reacquire_runnable(struct spu_context *ctx, u32 *npc,
+				         u32 *status)
+{
+	int ret;
+
+	if ((ret = spu_run_fini(ctx, npc, status)) != 0)
+		return ret;
+	if (*status & (SPU_STATUS_STOPPED_BY_STOP |
+		       SPU_STATUS_STOPPED_BY_HALT)) {
+		return *status;
+	}
+	if ((ret = spu_run_init(ctx, npc, status)) != 0)
+		return ret;
+	return 0;
+}
+
+static inline int spu_process_events(struct spu_context *ctx)
+{
+	struct spu *spu = ctx->spu;
+	u64 pte_fault = MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED;
+	int ret = 0;
+
+	if (spu->dsisr & pte_fault)
+		ret = spu_irq_class_1_bottom(spu);
+	if (spu->class_0_pending)
+		ret = spu_irq_class_0_bottom(spu);
+	if (!ret && signal_pending(current))
+		ret = -ERESTARTSYS;
+	return ret;
+}
+
+long spufs_run_spu(struct file *file, struct spu_context *ctx,
+		   u32 * npc, u32 * status)
+{
+	int ret;
+
+	if (down_interruptible(&ctx->run_sema))
+		return -ERESTARTSYS;
+
+	ret = spu_run_init(ctx, npc, status);
+	if (ret)
+		goto out;
+
+	do {
+		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, status));
+		if (unlikely(ret))
+			break;
+		if (unlikely(ctx->state != SPU_STATE_RUNNABLE)) {
+			ret = spu_reacquire_runnable(ctx, npc, status);
+			if (ret)
+				goto out;
+			continue;
+		}
+		ret = spu_process_events(ctx);
+
+	} while (!ret && !(*status & (SPU_STATUS_STOPPED_BY_STOP |
+				      SPU_STATUS_STOPPED_BY_HALT)));
+
+	ctx->ops->runcntl_stop(ctx);
+	ret = spu_run_fini(ctx, npc, status);
+	if (!ret)
+		ret = *status;
+	spu_yield(ctx);
+
+out:
+	up(&ctx->run_sema);
+	return ret;
+}
+
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -124,6 +124,34 @@ void spu_yield(struct spu_context *ctx);
 int __init spu_sched_init(void);
 void __exit spu_sched_exit(void);
 
+/*
+ * spufs_wait
+ * 	Same as wait_event_interruptible(), except that here
+ *	we need to call spu_release(ctx) before sleeping, and
+ *	then spu_acquire(ctx) when awoken.
+ */
+
+#define spufs_wait(wq, condition)					\
+({									\
+	int __ret = 0;							\
+	DEFINE_WAIT(__wait);						\
+	for (;;) {							\
+		prepare_to_wait(&(wq), &__wait, TASK_INTERRUPTIBLE);	\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			spu_release(ctx);				\
+			schedule();					\
+			spu_acquire(ctx);				\
+			continue;					\
+		}							\
+		__ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	finish_wait(&(wq), &__wait);					\
+	__ret;								\
+})
+
 size_t spu_wbox_write(struct spu_context *ctx, u32 data);
 size_t spu_ibox_read(struct spu_context *ctx, u32 *data);
 

--

