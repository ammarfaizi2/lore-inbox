Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286317AbSAAWps>; Tue, 1 Jan 2002 17:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSAAWpj>; Tue, 1 Jan 2002 17:45:39 -0500
Received: from [217.9.226.246] ([217.9.226.246]:18561 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S286317AbSAAWp3>; Tue, 1 Jan 2002 17:45:29 -0500
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] mesh: target 0 aborted
From: Momchil Velikov <velco@fadata.bg>
Date: 02 Jan 2002 00:45:34 +0200
Message-ID: <87lmfhy9kh.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes mesh.c compile, by adapting it to the new
pmac_feature API (ported from the ppc tree). 

In addition it contains the fix from Thomas Capricelli for the
infamous "mesh: target 0 aborted" error, which I've been personally
observing since 2.1.13x. 

Regards,
-velco


--- 1.1/drivers/scsi/mesh.c	Sat Dec  8 02:14:29 2001
+++ edited/drivers/scsi/mesh.c	Wed Jan  2 00:02:23 2002
@@ -28,7 +28,8 @@
 #include <asm/irq.h>
 #include <asm/hydra.h>
 #include <asm/processor.h>
-#include <asm/feature.h>
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
 #ifdef CONFIG_PMAC_PBOOK
 #include <linux/adb.h>
 #include <linux/pmu.h>
@@ -155,7 +156,6 @@
 	struct mesh_target tgts[8];
 	void	*dma_cmd_space;
 	struct device_node *ofnode;
-	u8*	mio_base;
 #ifndef MESH_NEW_STYLE_EH
 	Scsi_Cmnd *completed_q;
 	Scsi_Cmnd *completed_qtail;
@@ -258,8 +258,6 @@
 	if (mesh == 0)
 		mesh = find_compatible_devices("scsi", "chrp,mesh0");
 	for (; mesh != 0; mesh = mesh->next) {
-		struct device_node *mio;
-		
 		if (mesh->n_addrs != 2 || mesh->n_intrs != 2) {
 			printk(KERN_ERR "mesh: expected 2 addrs and 2 intrs"
 			       " (got %d,%d)", mesh->n_addrs, mesh->n_intrs);
@@ -325,12 +323,6 @@
 		if (mesh_sync_period < minper)
 			mesh_sync_period = minper;
 
-		ms->mio_base = 0;
-		for (mio = ms->ofnode->parent; mio; mio = mio->parent)
-			if (strcmp(mio->name, "mac-io") == 0 && mio->n_addrs > 0)
-				break;
-		if (mio)
-			ms->mio_base = (u8 *) ioremap(mio->addrs[0].address, 0x40);
 		set_mesh_power(ms, 1);
 
 		mesh_init(ms);
@@ -363,11 +355,9 @@
 		iounmap((void *) ms->mesh);
 	if (ms->dma)
 		iounmap((void *) ms->dma);
-	if (ms->mio_base)
-		iounmap((void *) ms->mio_base);
 	kfree(ms->dma_cmd_space);
 	free_irq(ms->meshintr, ms);
-	feature_clear(ms->ofnode, FEATURE_MESH_enable);
+	pmac_call_feature(PMAC_FTR_MESH_ENABLE, ms->ofnode, 0, 0);
 	return 0;
 }
 
@@ -377,16 +367,10 @@
 	if (_machine != _MACH_Pmac)
 		return;
 	if (state) {
-		feature_set(ms->ofnode, FEATURE_MESH_enable);
-		/* This seems to enable the termination power. strangely
-		   this doesn't fully agree with OF, but with MacOS */
-		if (ms->mio_base)
-			out_8(ms->mio_base + 0x36, 0x70);
+		pmac_call_feature(PMAC_FTR_MESH_ENABLE, ms->ofnode, 0, 1);
 		mdelay(200);
 	} else {
-		feature_clear(ms->ofnode, FEATURE_MESH_enable);
-		if (ms->mio_base)
-			out_8(ms->mio_base + 0x36, 0x34);
+		pmac_call_feature(PMAC_FTR_MESH_ENABLE, ms->ofnode, 0, 1);
 		mdelay(10);
 	}
 }			
@@ -584,25 +568,17 @@
 
 	udelay(100);
 
-	out_le32(&md->control, (RUN|PAUSE|FLUSH|WAKE) << 16);	/* stop dma */
-	out_8(&mr->exception, 0xff);	/* clear all exception bits */
-	out_8(&mr->error, 0xff);	/* clear all error bits */
+	out_8(&mr->exception, 0xff);	
+	out_8(&mr->error, 0xff);	
 	out_8(&mr->sequence, SEQ_RESETMESH);
 	udelay(10);
+
+	out_8(&mr->interrupt, 0xff);	/* clear all interrupt bits */
 	out_8(&mr->intr_mask, INT_ERROR | INT_EXCEPTION | INT_CMDDONE);
 	out_8(&mr->source_id, ms->host->this_id);
 	out_8(&mr->sel_timeout, 25);	/* 250ms */
-	out_8(&mr->sync_params, ASYNC_PARAMS);
-
-	out_8(&mr->bus_status1, BS1_RST);	/* assert RST */
-	udelay(30);			/* leave it on for >= 25us */
-	out_8(&mr->bus_status1, 0);	/* negate RST */
-
-	out_8(&mr->sequence, SEQ_FLUSHFIFO);
-	udelay(1);
-	out_8(&mr->sync_params, ASYNC_PARAMS);
-	out_8(&mr->sequence, SEQ_ENBRESEL);
-	out_8(&mr->interrupt, 0xff);	/* clear all interrupt bits */
+	out_8(&mr->sync_params, ASYNC_PARAMS);	/* asynchronous initially */
+	out_le32(&md->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
 }
 
 /*

