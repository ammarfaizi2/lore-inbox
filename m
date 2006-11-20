Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934293AbWKTSKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934293AbWKTSKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934287AbWKTSHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:07:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:53196 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934278AbWKTSHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:00 -0500
Message-Id: <20061120180523.464008000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:03 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 09/22] spufs: return correct event for data storage interrupt
Content-Disposition: inline; filename=spufs-dma-storage-error-return.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we attempt an MFC DMA to an unmapped address, the event
returned from spu_run should be SPE_EVENT_SPE_DATA_STORAGE,
not SPE_EVENT_INVALID_DMA.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
@@ -26,6 +26,7 @@ void spufs_dma_callback(struct spu *spu,
 	} else {
 		switch (type) {
 		case SPE_EVENT_DMA_ALIGNMENT:
+		case SPE_EVENT_SPE_DATA_STORAGE:
 		case SPE_EVENT_INVALID_DMA:
 			force_sig(SIGBUS, /* info, */ current);
 			break;
Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -507,7 +507,7 @@ int spu_irq_class_1_bottom(struct spu *s
 	if (!error) {
 		spu_restart_dma(spu);
 	} else {
-		__spu_trap_invalid_dma(spu);
+		spu->dma_callback(spu, SPE_EVENT_SPE_DATA_STORAGE);
 	}
 	return ret;
 }

--

