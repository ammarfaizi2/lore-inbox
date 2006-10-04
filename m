Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161563AbWJDQfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161563AbWJDQfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161585AbWJDQfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:35:00 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:59643 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161559AbWJDQa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:30:56 -0400
Message-Id: <20061004161509.115503000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:21 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 11/14] spufs: add infrastructure for finding elf objects
Content-Disposition: inline; filename=spufs-object-id.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an 'object-id' file that the spe library can
use to store a pointer to its ELF object. This was
originally meant for use by oprofile, but is now
also used by the GNU debugger, if available.

In order for oprofile to find the location in an spu-elf
binary where an event counter triggered, we need a way
to identify the binary in the first place.

Unfortunately, that binary itself can be embedded in a
powerpc ELF binary. Since we can assume it is mapped into
the effective address space of the running process,
have that one write the pointer value into a new spufs
file.

When a context switch occurs, pass the user value to
the profiler so that can look at the mapped file (with
some care).

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -1487,6 +1487,21 @@ static u64 spufs_id_get(void *data)
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_id_ops, spufs_id_get, NULL, "0x%llx\n")
 
+static u64 spufs_object_id_get(void *data)
+{
+	struct spu_context *ctx = data;
+	return ctx->object_id;
+}
+
+static void spufs_object_id_set(void *data, u64 id)
+{
+	struct spu_context *ctx = data;
+	ctx->object_id = id;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(spufs_object_id_ops, spufs_object_id_get,
+		spufs_object_id_set, "0x%llx\n");
+
 struct tree_descr spufs_dir_contents[] = {
 	{ "mem",  &spufs_mem_fops,  0666, },
 	{ "regs", &spufs_regs_fops,  0666, },
@@ -1510,7 +1525,8 @@ struct tree_descr spufs_dir_contents[] =
 	{ "spu_tag_mask", &spufs_spu_tag_mask_ops, 0666, },
 	{ "event_mask", &spufs_event_mask_ops, 0666, },
 	{ "srr0", &spufs_srr0_ops, 0666, },
-	{ "phys-id", &spufs_id_ops, 0666, },
 	{ "psmap", &spufs_psmap_fops, 0666, },
+	{ "phys-id", &spufs_id_ops, 0666, },
+	{ "object-id", &spufs_object_id_ops, 0666, },
 	{},
 };
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -50,6 +50,7 @@ struct spu_context {
 	struct address_space *cntl; 	   /* 'control' area mappings. */
 	struct address_space *signal1; 	   /* 'signal1' area mappings. */
 	struct address_space *signal2; 	   /* 'signal2' area mappings. */
+	u64 object_id;		   /* user space pointer for oprofile */
 
 	enum { SPU_STATE_RUNNABLE, SPU_STATE_SAVED } state;
 	struct rw_semaphore state_sema;
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/sched.c
@@ -35,6 +35,7 @@
 #include <linux/unistd.h>
 #include <linux/numa.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 
 #include <asm/io.h>
 #include <asm/mmu_context.h>
@@ -75,6 +76,25 @@ static inline void mm_needs_global_tlbie
 	__cpus_setall(&mm->cpu_vm_mask, nr);
 }
 
+static BLOCKING_NOTIFIER_HEAD(spu_switch_notifier);
+
+static void spu_switch_notify(struct spu *spu, struct spu_context *ctx)
+{
+	blocking_notifier_call_chain(&spu_switch_notifier,
+			    ctx ? ctx->object_id : 0, spu);
+}
+
+int spu_switch_event_register(struct notifier_block * n)
+{
+	return blocking_notifier_chain_register(&spu_switch_notifier, n);
+}
+
+int spu_switch_event_unregister(struct notifier_block * n)
+{
+	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
+}
+
+
 static inline void bind_context(struct spu *spu, struct spu_context *ctx)
 {
 	pr_debug("%s: pid=%d SPU=%d NODE=%d\n", __FUNCTION__, current->pid,
@@ -97,12 +117,14 @@ static inline void bind_context(struct s
 	spu_restore(&ctx->csa, spu);
 	spu->timestamp = jiffies;
 	spu_cpu_affinity_set(spu, raw_smp_processor_id());
+	spu_switch_notify(spu, ctx);
 }
 
 static inline void unbind_context(struct spu *spu, struct spu_context *ctx)
 {
 	pr_debug("%s: unbind pid=%d SPU=%d NODE=%d\n", __FUNCTION__,
 		 spu->pid, spu->number, spu->node);
+	spu_switch_notify(spu, NULL);
 	spu_unmap_mappings(ctx);
 	spu_save(&ctx->csa, spu);
 	spu->timestamp = jiffies;
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -201,6 +201,24 @@ static inline void unregister_spu_syscal
 
 
 /*
+ * Notifier blocks:
+ *
+ * oprofile can get notified when a context switch is performed
+ * on an spe. The notifer function that gets called is passed
+ * a pointer to the SPU structure as well as the object-id that
+ * identifies the binary running on that SPU now.
+ *
+ * For a context save, the object-id that is passed is zero,
+ * identifying that the kernel will run from that moment on.
+ *
+ * For a context restore, the object-id is the value written
+ * to object-id spufs file from user space and the notifer
+ * function can assume that spu->ctx is valid.
+ */
+int spu_switch_event_register(struct notifier_block * n);
+int spu_switch_event_unregister(struct notifier_block * n);
+
+/*
  * This defines the Local Store, Problem Area and Privlege Area of an SPU.
  */
 

--

