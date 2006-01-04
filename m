Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWADT6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWADT6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWADT6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:45287 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965279AbWADT5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:35 -0500
Message-Id: <20060104194501.381895000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:28 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 08/13] spufs: clean up use of bitops
Content-Disposition: inline; filename=spufs-test-bit-cleanup.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

checking bits manually might not be synchonized with
the use of set_bit/clear_bit. Make sure we always use
the correct bitops by removing the unnecessary
identifiers.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/sched.c
@@ -214,14 +214,14 @@ static void spu_reaper(void *data)
 
 	down_write(&ctx->state_sema);
 	spu = ctx->spu;
-	if (spu && (ctx->flags & SPU_CONTEXT_PREEMPT)) {
+	if (spu && test_bit(SPU_CONTEXT_PREEMPT, &ctx->flags)) {
 		if (atomic_read(&spu->rq->prio.nr_blocked)) {
 			pr_debug("%s: spu=%d\n", __func__, spu->number);
 			ctx->ops->runcntl_stop(ctx);
 			spu_deactivate(ctx);
 			wake_up_all(&ctx->stop_wq);
 		} else {
-			clear_bit(SPU_CONTEXT_PREEMPT_nr, &ctx->flags);
+			clear_bit(SPU_CONTEXT_PREEMPT, &ctx->flags);
 		}
 	}
 	up_write(&ctx->state_sema);
@@ -234,7 +234,7 @@ static void schedule_spu_reaper(struct s
 	unsigned long now = jiffies;
 	unsigned long expire = spu->timestamp + SPU_MIN_TIMESLICE;
 
-	set_bit(SPU_CONTEXT_PREEMPT_nr, &ctx->flags);
+	set_bit(SPU_CONTEXT_PREEMPT, &ctx->flags);
 	INIT_WORK(&ctx->reap_work, spu_reaper, ctx);
 	if (time_after(now, expire))
 		schedule_work(&ctx->reap_work);
@@ -250,7 +250,7 @@ static void check_preempt_active(struct 
 	list_for_each(p, &rq->active_list) {
 		struct spu *spu = list_entry(p, struct spu, sched_list);
 		struct spu_context *ctx = spu->ctx;
-		if (!(ctx->flags & SPU_CONTEXT_PREEMPT)) {
+		if (!test_bit(SPU_CONTEXT_PREEMPT, &ctx->flags)) {
 			if (!worst || (spu->prio > worst->prio)) {
 				worst = spu;
 			}
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -37,8 +37,7 @@ enum {
 
 struct spu_context_ops;
 
-#define SPU_CONTEXT_PREEMPT_nr          0UL
-#define SPU_CONTEXT_PREEMPT             (1UL << SPU_CONTEXT_PREEMPT_nr)
+#define SPU_CONTEXT_PREEMPT          0UL
 
 struct spu_context {
 	struct spu *spu;		  /* pointer to a physical SPU */
Index: linux-2.6.15-rc/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.15-rc.orig/include/asm-powerpc/spu.h
+++ linux-2.6.15-rc/include/asm-powerpc/spu.h
@@ -102,10 +102,8 @@
 #define MFC_MULTI_SRC_EVENT                 0x00001000
 
 /* Flags indicating progress during context switch. */
-#define SPU_CONTEXT_SWITCH_PENDING_nr	0UL
-#define SPU_CONTEXT_SWITCH_ACTIVE_nr	1UL
-#define SPU_CONTEXT_SWITCH_PENDING	(1UL << SPU_CONTEXT_SWITCH_PENDING_nr)
-#define SPU_CONTEXT_SWITCH_ACTIVE	(1UL << SPU_CONTEXT_SWITCH_ACTIVE_nr)
+#define SPU_CONTEXT_SWITCH_PENDING	0UL
+#define SPU_CONTEXT_SWITCH_ACTIVE	1UL
 
 struct spu_context;
 struct spu_runqueue;
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
@@ -63,7 +63,7 @@ static void spu_restart_dma(struct spu *
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
 
-	if (!test_bit(SPU_CONTEXT_SWITCH_PENDING_nr, &spu->flags))
+	if (!test_bit(SPU_CONTEXT_SWITCH_PENDING, &spu->flags))
 		out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESTART_DMA_COMMAND);
 }
 
@@ -75,7 +75,7 @@ static int __spu_trap_data_seg(struct sp
 
 	pr_debug("%s\n", __FUNCTION__);
 
-	if (test_bit(SPU_CONTEXT_SWITCH_ACTIVE_nr, &spu->flags)) {
+	if (test_bit(SPU_CONTEXT_SWITCH_ACTIVE, &spu->flags)) {
 		/* SLBs are pre-loaded for context switch, so
 		 * we should never get here!
 		 */
@@ -122,7 +122,7 @@ static int __spu_trap_data_map(struct sp
 		return 0;
 	}
 
-	if (test_bit(SPU_CONTEXT_SWITCH_ACTIVE_nr, &spu->flags)) {
+	if (test_bit(SPU_CONTEXT_SWITCH_ACTIVE, &spu->flags)) {
 		printk("%s: invalid access during switch!\n", __func__);
 		return 1;
 	}
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/switch.c
@@ -165,7 +165,7 @@ static inline void set_switch_pending(st
 	 * Restore, Step 5:
 	 *     Set a software context switch pending flag.
 	 */
-	set_bit(SPU_CONTEXT_SWITCH_PENDING_nr, &spu->flags);
+	set_bit(SPU_CONTEXT_SWITCH_PENDING, &spu->flags);
 	mb();
 }
 
@@ -767,8 +767,8 @@ static inline void set_switch_active(str
 	 *     Change the software context switch pending flag
 	 *     to context switch active.
 	 */
-	set_bit(SPU_CONTEXT_SWITCH_ACTIVE_nr, &spu->flags);
-	clear_bit(SPU_CONTEXT_SWITCH_PENDING_nr, &spu->flags);
+	set_bit(SPU_CONTEXT_SWITCH_ACTIVE, &spu->flags);
+	clear_bit(SPU_CONTEXT_SWITCH_PENDING, &spu->flags);
 	mb();
 }
 
@@ -1786,7 +1786,7 @@ static inline void reset_switch_active(s
 	/* Restore, Step 74:
 	 *     Reset the "context switch active" flag.
 	 */
-	clear_bit(SPU_CONTEXT_SWITCH_ACTIVE_nr, &spu->flags);
+	clear_bit(SPU_CONTEXT_SWITCH_ACTIVE, &spu->flags);
 	mb();
 }
 

--

