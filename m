Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbTELEW0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 00:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbTELEWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 00:22:25 -0400
Received: from dp.samba.org ([66.70.73.150]:63981 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261881AbTELEWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 00:22:21 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16063.9297.101375.193122@argo.ozlabs.ibm.com>
Date: Mon, 12 May 2003 14:34:25 +1000
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       benh@kernel.crashing.org
Subject: [PATCH] irqreturn_t in powermac scsi drivers
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch changes the mesh and mac53c94 SCSI host adaptor drivers to
return an irqreturn_t from their interrupt handlers.  Please apply.

Regards,
Paul.

diff -urN linux-2.5/drivers/scsi/mac53c94.c pmac-2.5/drivers/scsi/mac53c94.c
--- linux-2.5/drivers/scsi/mac53c94.c	2003-03-23 18:24:17.000000000 +1100
+++ pmac-2.5/drivers/scsi/mac53c94.c	2003-04-23 23:09:39.000000000 +1000
@@ -59,7 +59,7 @@
 static void mac53c94_init(struct fsc_state *);
 static void mac53c94_start(struct fsc_state *);
 static void mac53c94_interrupt(int, void *, struct pt_regs *);
-static void do_mac53c94_interrupt(int, void *, struct pt_regs *);
+static irqreturn_t do_mac53c94_interrupt(int, void *, struct pt_regs *);
 static void cmd_done(struct fsc_state *, int result);
 static void set_dma_cmds(struct fsc_state *, Scsi_Cmnd *);
 static int data_goes_out(Scsi_Cmnd *);
@@ -316,7 +316,7 @@
 		set_dma_cmds(state, cmd);
 }
 
-static void
+static irqreturn_t
 do_mac53c94_interrupt(int irq, void *dev_id, struct pt_regs *ptregs)
 {
 	unsigned long flags;
@@ -325,6 +325,7 @@
 	spin_lock_irqsave(dev->host_lock, flags);
 	mac53c94_interrupt(irq, dev_id, ptregs);
 	spin_unlock_irqrestore(dev->host_lock, flags);
+	return IRQ_HANDLED;
 }
 
 static void
diff -urN linux-2.5/drivers/scsi/mesh.c pmac-2.5/drivers/scsi/mesh.c
--- linux-2.5/drivers/scsi/mesh.c	2003-03-23 18:24:17.000000000 +1100
+++ pmac-2.5/drivers/scsi/mesh.c	2003-04-23 23:09:26.000000000 +1000
@@ -212,7 +212,7 @@
 static void handle_error(struct mesh_state *);
 static void handle_exception(struct mesh_state *);
 static void mesh_interrupt(int, void *, struct pt_regs *);
-static void do_mesh_interrupt(int, void *, struct pt_regs *);
+static irqreturn_t do_mesh_interrupt(int, void *, struct pt_regs *);
 static void handle_msgin(struct mesh_state *);
 static void mesh_done(struct mesh_state *, int);
 static void mesh_completed(struct mesh_state *, Scsi_Cmnd *);
@@ -1471,7 +1471,7 @@
 	out_8(&mr->sequence, SEQ_ENBRESEL);
 }
 
-static void
+static irqreturn_t
 do_mesh_interrupt(int irq, void *dev_id, struct pt_regs *ptregs)
 {
 	unsigned long flags;
@@ -1480,6 +1480,7 @@
 	spin_lock_irqsave(dev->host_lock, flags);
 	mesh_interrupt(irq, dev_id, ptregs);
 	spin_unlock_irqrestore(dev->host_lock, flags);
+	return IRQ_HANDLED;
 }
 
 static void handle_error(struct mesh_state *ms)
