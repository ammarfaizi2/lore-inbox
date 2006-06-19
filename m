Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWFSSoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWFSSoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWFSSn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:43:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:38360 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932542AbWFSSnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:24 -0400
Message-Id: <20060619183406.626878000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:33 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Masato Noguchi <Masato.Noguchi@jp.sony.com>
Subject: [patch 18/20] spufs: clear class2 interrupt status before wakeup
Content-Disposition: inline; filename=spufs-fix-class2-clear-stat-before-wakeup.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

SPU interrupt status must be cleared before handle it.
Otherwise, kernel may drop some interrupt packet.

Currently, class2 interrupt treated like:
 1) call callback to wake up waiting process
 2) mask raised mailbox interrupt
 3) clear interrupt status

I changed like:
 1) mask raised mailbox interrupt
 2) clear interrupt status
 3) call callback to wake up waiting process

Clearing status before masking will make spurious interrupt.
Thus, it is necessary to hold by steps I described above, I think.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
 arch/powerpc/platforms/cell/spu_base.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

Index: powerpc.git/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_base.c
+++ powerpc.git/arch/powerpc/platforms/cell/spu_base.c
@@ -140,55 +140,7 @@ static int __spu_trap_data_map(struct sp
 	spu->dar = ea;
 	spu->dsisr = dsisr;
 	mb();
-	if (spu->stop_callback)
-		spu->stop_callback(spu);
-	return 0;
-}
-
-static int __spu_trap_mailbox(struct spu *spu)
-{
-	if (spu->ibox_callback)
-		spu->ibox_callback(spu);
-
-	/* atomically disable SPU mailbox interrupts */
-	spin_lock(&spu->register_lock);
-	spu_int_mask_and(spu, 2, ~0x1);
-	spin_unlock(&spu->register_lock);
-	return 0;
-}
-
-static int __spu_trap_stop(struct spu *spu)
-{
-	pr_debug("%s\n", __FUNCTION__);
-	if (spu->stop_callback)
-		spu->stop_callback(spu);
-	return 0;
-}
-
-static int __spu_trap_halt(struct spu *spu)
-{
-	pr_debug("%s\n", __FUNCTION__);
-	if (spu->stop_callback)
-		spu->stop_callback(spu);
-	return 0;
-}
-
-static int __spu_trap_tag_group(struct spu *spu)
-{
-	pr_debug("%s\n", __FUNCTION__);
-	spu->mfc_callback(spu);
-	return 0;
-}
-
-static int __spu_trap_spubox(struct spu *spu)
-{
-	if (spu->wbox_callback)
-		spu->wbox_callback(spu);
-
-	/* atomically disable SPU mailbox interrupts */
-	spin_lock(&spu->register_lock);
-	spu_int_mask_and(spu, 2, ~0x10);
-	spin_unlock(&spu->register_lock);
+	spu->stop_callback(spu);
 	return 0;
 }
 
@@ -199,8 +151,7 @@ spu_irq_class_0(int irq, void *data, str
 
 	spu = data;
 	spu->class_0_pending = 1;
-	if (spu->stop_callback)
-		spu->stop_callback(spu);
+	spu->stop_callback(spu);
 
 	return IRQ_HANDLED;
 }
@@ -278,29 +229,38 @@ spu_irq_class_2(int irq, void *data, str
 	unsigned long mask;
 
 	spu = data;
+	spin_lock(&spu->register_lock);
 	stat = spu_int_stat_get(spu, 2);
 	mask = spu_int_mask_get(spu, 2);
+	/* ignore interrupts we're not waiting for */
+	stat &= mask;
+	/*
+	 * mailbox interrupts (0x1 and 0x10) are level triggered.
+	 * mask them now before acknowledging.
+	 */
+	if (stat & 0x11)
+		spu_int_mask_and(spu, 2, ~(stat & 0x11));
+	/* acknowledge all interrupts before the callbacks */
+	spu_int_stat_clear(spu, 2, stat);
+	spin_unlock(&spu->register_lock);
 
 	pr_debug("class 2 interrupt %d, %lx, %lx\n", irq, stat, mask);
 
-	stat &= mask;
-
 	if (stat & 1)  /* PPC core mailbox */
-		__spu_trap_mailbox(spu);
+		spu->ibox_callback(spu);
 
 	if (stat & 2) /* SPU stop-and-signal */
-		__spu_trap_stop(spu);
+		spu->stop_callback(spu);
 
 	if (stat & 4) /* SPU halted */
-		__spu_trap_halt(spu);
+		spu->stop_callback(spu);
 
 	if (stat & 8) /* DMA tag group complete */
-		__spu_trap_tag_group(spu);
+		spu->mfc_callback(spu);
 
 	if (stat & 0x10) /* SPU mailbox threshold */
-		__spu_trap_spubox(spu);
+		spu->wbox_callback(spu);
 
-	spu_int_stat_clear(spu, 2, stat);
 	return stat ? IRQ_HANDLED : IRQ_NONE;
 }
 

--

