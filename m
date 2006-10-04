Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161562AbWJDQbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161562AbWJDQbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161557AbWJDQbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:31:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:17113 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161562AbWJDQa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:30:57 -0400
Message-Id: <20061004161458.745590000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:13 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       HyeonSeung Jang <hs8848.jang@samsung.com>
Subject: [PATCH 03/14] spufs: fix context switch during page fault
Content-Disposition: inline; filename=spufs-fix-context-switch-during-fault.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: HyeonSeung Jang <hs8848.jang@samsung.com>

For better explanation, I break down the page fault handling into steps:

1) There is a page fault caused by DMA operation initiated by SPU and
DMA is suspended.

2) The interrupt handler 'spu_irq_class_1()/__spu_trap_data_map()' is
called and it just wakes up the sleeping spe-manager thread.

3) by PPE scheduler, the corresponding bottom half,
spu_irq_class_1_bottom() is called in process context and DMA is
restarted.

There can be a quite large time gap between 2) and 3) and I found
the following problem:

Between 2) and 3) If the context becomes unbound, 3) is not executed
because when the spe-manager thread is awaken, the context is already
saved. (This situation can happen, for example, when a high priority spe
thread newly started in that time gap)

But the actual problem is that the corresponding SPU context does not
work even if it is bound again to a SPU.

Besides I can see the following warning in mambo simulator when the
context becomes
unbound(in save_mfc_cmd()), i.e. when unbind() is called for the
context after step 2) before 3) :

'WARNING: 61392752237: SPE2: MFC_CMD_QUEUE channel count of 15 is
inconsistent with number of available DMA queue entries of 16'

After I go through available documents, I found that the problem is
because the suspended DMA is not restarted when it is bound again.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -1779,6 +1779,15 @@ static inline void restore_mfc_cntl(stru
 	 */
 	out_be64(&priv2->mfc_control_RW, csa->priv2.mfc_control_RW);
 	eieio();
+	/*
+	 * FIXME: this is to restart a DMA that we were processing
+	 *        before the save. better remember the fault information
+	 *        in the csa instead.
+	 */
+	if ((csa->priv2.mfc_control_RW & MFC_CNTL_SUSPEND_DMA_QUEUE_MASK)) {
+		out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESTART_DMA_COMMAND);
+		eieio();
+	}
 }
 
 static inline void enable_user_access(struct spu_state *csa, struct spu *spu)

--

