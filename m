Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUKOCmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUKOCmX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUKOCk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:40:27 -0500
Received: from ozlabs.org ([203.10.76.45]:63410 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261467AbUKOCiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:38:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16792.6011.333956.119717@cargo.ozlabs.ibm.com>
Date: Mon, 15 Nov 2004 13:42:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Do power_state conversion for mesh.c
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes dev.power_state to dev.power.power_state in
drivers/scsi/mesh.c, and fixes an uninitialized variable use in a
printk.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/scsi/mesh.c test-pmac/drivers/scsi/mesh.c
--- linux-2.5/drivers/scsi/mesh.c	2004-11-15 08:06:14.000000000 +1100
+++ test-pmac/drivers/scsi/mesh.c	2004-11-15 09:09:09.000000000 +1100
@@ -1231,8 +1231,8 @@
 			} else if (code != cmd->device->lun + IDENTIFY_BASE) {
 				printk(KERN_WARNING "mesh: lun mismatch "
 				       "(%d != %d) on reselection from "
-				       "target %d\n", i, cmd->device->lun,
-				       ms->conn_tgt);
+				       "target %d\n", code - IDENTIFY_BASE,
+				       cmd->device->lun, ms->conn_tgt);
 			}
 			break;
 		}
@@ -1762,7 +1762,7 @@
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
 
-	if (state == mdev->ofdev.dev.power_state || state < 2)
+	if (state == mdev->ofdev.dev.power.power_state || state < 2)
 		return 0;
 
 	scsi_block_requests(ms->host);
@@ -1777,7 +1777,7 @@
 	disable_irq(ms->meshintr);
 	set_mesh_power(ms, 0);
 
-	mdev->ofdev.dev.power_state = state;
+	mdev->ofdev.dev.power.power_state = state;
 
 	return 0;
 }
@@ -1787,7 +1787,7 @@
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
 
-	if (mdev->ofdev.dev.power_state == 0)
+	if (mdev->ofdev.dev.power.power_state == 0)
 		return 0;
 
 	set_mesh_power(ms, 1);
@@ -1798,7 +1798,7 @@
 	enable_irq(ms->meshintr);
 	scsi_unblock_requests(ms->host);
 
-	mdev->ofdev.dev.power_state = 0;
+	mdev->ofdev.dev.power.power_state = 0;
 
 	return 0;
 }
