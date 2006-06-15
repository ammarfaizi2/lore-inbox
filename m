Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWFOJQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWFOJQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWFOJQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:16:17 -0400
Received: from palrel12.hp.com ([156.153.255.237]:3998 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932447AbWFOJPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:15:08 -0400
Date: Thu, 15 Jun 2006 02:07:38 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606150907.k5F97coF008178@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/16] 2.6.17-rc6 perfmon2 patch for review: kernel-level API support (kapi)
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the kernel-level API support.




--- linux-2.6.17-rc6.orig/perfmon/perfmon_kapi.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc6/perfmon/perfmon_kapi.c	2006-06-08 01:49:22.000000000 -0700
@@ -0,0 +1,458 @@
+/*
+ * perfmon_kapi.c: perfmon2 kernel level interface
+ *
+ * This file implements the perfmon2 interface which
+ * provides access to the hardware performance counters
+ * of the host processor.
+ *
+ * Copyright (c) 2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * More information about perfmon available at:
+ * 	http://perfmon2.sf.net
+ *
+ * perfmon2 KAPI overview:
+ *  The goal is to allow kernel-level code to use the perfmon2
+ *  interface for both counting and sampling. It is not possible
+ *  to directly use the system calls because they expected parameters
+ *  from user level. The kernel-level interface is more restrictive
+ *  because of inherent kernel constraints.  The limited interface
+ *  is comosed by a set of functions  implemented in this this. For
+ *  ease of use, the mimic the names of the user level interface, e.g.
+ *  pfmk_create_context()  is the equivalent of pfm_create_context().
+ *  The pfmk_ prefix is used on all calls. Those can be called from
+ *  kernel modules or core kernel files.
+ *
+ *  The kernel-level perfmon api (KAPI) does not use file descriptors
+ *  to identify a context. Instead an opaque (void *) descriptor is used.
+ *  It is returned by pfmk_create_context() and must be passed to all
+ *  subsequence pfmk_*() calls. List of calls is:
+ *  	pfmk_create_context();
+ *  	pfmk_write_pmcs();
+ *  	pfmk_write_pmds();
+ *  	pfmk_read_pmds();
+ *  	pfmk_restart();
+ *  	pfmk_stop();
+ *  	pfmk_start();
+ *  	pfmk_load_context();
+ *  	pfmk_unload_context();
+ *  	pfmk_delete_evtsets();
+ *  	pfmk_create_evtsets();
+ *  	pfmk_getinfo_evtsets();
+ *  	pfmk_close();
+ *  	pfmk_read();
+ *
+ *  Unlike pfm_create_context(), the KAPI equivalent, pfmk_create_context()
+ *  does not trigger the PMU description module to be inserted automatically
+ *  (if known). That means that the call may fail if no PMU description module
+ *  is inserted in advance. This is a restriction to avoid deadlocks during
+ *  insmod.
+ *
+ *  When sampling, the kernel level sampling buffer base address is directly
+ *  returned by pfmk_create_context(). There is no re-mapping necessary.
+ * 
+ * When sampling, the buffer overflow notification can generate a message.
+ * But given that there is no file descriptor, it is not possible to use a
+ * plain read() call. Instead the pfmk_read() function must be invoke. It
+ * returns one message at a time. The pfmk_read() function can be blocking
+ * when there is no message, unless the noblock parameter is set to 1.
+ * Because there is no file descriptor, it would be hard for a kernel thread
+ * to wait on an overflow notification message and something else. It would
+ * be hard to get out, should the thread need to terminate. To avoid this
+ * problem, the pfmk_create_context() requires a completion structure be
+ * passed. It is used during pfmk_read() to wait on an event. But the completion
+ * is visible outside the perfmon context and can be used to signal other events
+ * as well. Upon return from pfmk_read() the caller must check the return value,
+ * if zero no message was extracted and the reason for waking up is outside the
+ * scope of perfmon.
+ *
+ * pefmon2 KAPI known restrictions:
+ * 	- only system-wide contexts are supported
+ * 	- with a sampling buffer defined, it is not possible
+ * 	  to call pfmk_close() from an interrupt context
+ * 	  (e.g. from IPI handler)
+ */
+#include <linux/kernel.h>
+#include <linux/perfmon.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+static int pfmk_get_smpl_arg(pfm_uuid_t uuid, void *addr, size_t size,
+		     struct pfm_smpl_fmt **fmt)
+{
+	struct pfm_smpl_fmt *f;
+	size_t sz;
+	int ret;
+
+	if (!pfm_use_smpl_fmt(uuid))
+		return 0;
+
+	/*
+	 * find fmt and increase refcount
+	 */
+	f = pfm_smpl_fmt_get(uuid);
+	if (f == NULL) {
+		PFM_DBG("buffer format not found");
+		return -EINVAL;
+	}
+
+	sz = f->fmt_arg_size;
+
+	/*
+	 * usize = -1 is for IA-64 backward compatibility
+	 */
+	ret = -EINVAL;
+	if (sz != size && size != -1) {
+		PFM_DBG("invalid arg size %zu, format expects %zu",
+			size, sz);
+		goto error;
+	}
+	*fmt = f;
+	return 0;
+
+error:
+	pfm_smpl_fmt_put(f);
+	return ret;
+}
+
+/*
+ * req: pointer to context creation  argument. ctx_flags msut have
+ *      PFM_FL_SYSTEM_WIDE set.
+ *
+ * smpl_arg: optional sampling format option argument. NULL if unused
+ * smpl_size: sizeof of optional sampling format argument. 0 if unused
+ * c       : pointer to completion structure. Call does not initialization
+ * 	     struct (i.e. no init_completion). Completion used with pfmk_read()
+ * Return:
+ * desc    : pointer to opaque context descriptor. unique identifier for context
+ * smpl_buf: pointer to base of sampling buffer. Pass NULL if unused
+ */
+int pfmk_create_context(struct pfarg_ctx *req, void *smpl_arg,
+			size_t smpl_size,
+			struct completion *c,
+			void **desc,
+			void **buf)
+{
+	struct pfm_context *new_ctx;
+	struct pfm_smpl_fmt *fmt = NULL;
+	int ret = -EFAULT;
+
+	if (desc == NULL)
+		return -EINVAL;
+
+	if (c == NULL)
+		return -EINVAL;
+
+	if ((req->ctx_flags & PFM_FL_SYSTEM_WIDE) == 0) {
+		PFM_DBG("kapi only supoprts system-wide context\n");
+		return -EINVAL;
+	}
+
+	ret = pfmk_get_smpl_arg(req->ctx_smpl_buf_id, smpl_arg, smpl_size, &fmt);
+	if (ret)
+		return ret;
+
+	ret = __pfm_create_context(req, fmt, smpl_arg, PFM_KAPI, c, &new_ctx);
+	if (!ret) {
+		*desc = new_ctx;
+		/*
+		 * return base of sampling buffer
+		 */
+		if (buf)
+			*buf = new_ctx->smpl_addr;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_create_context);
+
+int pfmk_write_pmcs(void *desc, struct pfarg_pmc *req, int count)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+	if (count < 0 || desc == NULL)
+		return -EINVAL;
+
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_write_pmcs(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_write_pmcs);
+
+int pfmk_write_pmds(void *desc, struct pfarg_pmd *req, int count)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+	if (count < 0 || desc == NULL)
+		return -EINVAL;
+
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_write_pmds(ctx, req, count, 0);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_write_pmds);
+
+int pfmk_read_pmds(void *desc, struct pfarg_pmd *req, int count)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+	if (count < 0 || desc == NULL)
+		return -EINVAL;
+
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_read_pmds(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_read_pmds);
+
+int pfmk_restart(void *desc)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret = 0;
+
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, 0, &flags);
+	if (ret == 0)
+		ret = __pfm_restart(ctx);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_restart);
+
+
+int pfmk_stop(void *desc)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_stop(ctx);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_stop);
+
+int pfmk_start(void *desc, struct pfarg_start *req)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret = 0;
+
+	if (desc == NULL)
+		return -EINVAL;
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_start(ctx, req);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_start);
+
+int pfmk_load_context(void *desc, struct pfarg_load *req)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+	if (desc == NULL)
+		return -EINVAL;
+
+	ctx = desc;
+
+	spin_lock(&ctx->lock);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED, &flags);
+	if (ret == 0)
+		ret = __pfm_load_context(ctx, req);
+
+	spin_unlock(&ctx->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_load_context);
+
+
+int pfmk_unload_context(void *desc)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret = 0;
+
+	if (desc == NULL)
+		return -EINVAL;
+
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_STOPPED|PFM_CMD_UNLOAD, &flags);
+	if (ret == 0)
+		ret = __pfm_unload_context(ctx, 0);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_unload_context);
+
+int pfmk_delete_evtsets(void *desc, struct pfarg_setinfo *req, int count)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+	if (count < 0 || desc == NULL)
+		return -EINVAL;
+
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
+	if (ret == 0)
+		ret = __pfm_delete_evtsets(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_delete_evtsets);
+
+int pfmk_create_evtsets(void *desc, struct pfarg_setdesc  *req, int count)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+	if (count < 0 || desc == NULL)
+		return -EINVAL;
+
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, PFM_CMD_UNLOADED, &flags);
+	if (ret == 0)
+		ret = __pfm_create_evtsets(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_create_evtsets);
+
+int pfmk_getinfo_evtsets(void *desc, struct pfarg_setinfo *req, int count)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret;
+
+	if (count < 0 || desc == NULL)
+		return -EINVAL;
+
+	ctx = desc;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	ret = pfm_check_task_state(ctx, 0, &flags);
+	if (ret == 0)
+		ret = __pfm_getinfo_evtsets(ctx, req, count);
+
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfmk_getinfo_evtsets);
+
+int pfmk_close(void *desc)
+{
+	struct pfm_context *ctx;
+
+	if (desc == NULL)
+		return -EINVAL;
+
+	ctx = desc;
+
+	return __pfm_close(ctx, NULL);
+}
+EXPORT_SYMBOL(pfmk_close);
+
+/*
+ * desc   : opaque context descriptor
+ * msg    : pointer to message structure
+ * sz     : sizeof of message argument. Must be equal to 1 message 
+ * noblock: 1 means do not wait for messages. 0 means wait for completion
+ *          signal.
+ *
+ * Note on completion:
+ *	- completion structure can be shared with code outside the perfmon2
+ *	  core. This function will return with 0, if there was a completion
+ *	  signal but no messages to read.
+ *
+ * Return:
+ *    0           : no message extracted, but awaken
+ *    sizeof(*msg): one message extracted
+ *    -EAGAIN     : noblock=1 and nothing to read
+ *    -ERESTARTSYS: noblock=0, signal pending
+ */
+ssize_t pfmk_read(void *desc, union pfm_msg *msg, size_t sz, int noblock)
+{
+	struct pfm_context *ctx;
+	union pfm_msg msg_buf;
+
+	if (desc == NULL || msg == NULL || sz != sizeof(*msg))
+		return -EINVAL;
+
+	ctx = desc;
+
+	return __pfmk_read(ctx, &msg_buf, noblock);
+}
+EXPORT_SYMBOL(pfmk_read);
