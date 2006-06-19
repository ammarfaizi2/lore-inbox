Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWFSSoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWFSSoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWFSSoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:44:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:51415 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932533AbWFSSnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:23 -0400
Message-Id: <20060619183405.261655000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:24 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [patch 09/20] spufs: add a phys-id attribute to each SPU context
Content-Disposition: inline; filename=spufs-phys-id.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For performance analysis, it is often interesting to know
which physical SPE a thread is currently running on, and,
more importantly, if it is running at all.

This patch adds a simple attribute to each SPU directory
with that information.
The attribute is read-only and called 'phys-id'. It contains
an ascii string with the number of the physical SPU (e.g.
"0x5"), or alternatively the string "0xffffffff" (32 bit -1)
when it is not running at all at the time that the file
is read.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/file.c
@@ -1328,6 +1328,22 @@ static u64 spufs_srr0_get(void *data)
 DEFINE_SIMPLE_ATTRIBUTE(spufs_srr0_ops, spufs_srr0_get, spufs_srr0_set,
 			"%llx\n")
 
+static u64 spufs_id_get(void *data)
+{
+	struct spu_context *ctx = data;
+	u64 num;
+
+	spu_acquire(ctx);
+	if (ctx->state == SPU_STATE_RUNNABLE)
+		num = ctx->spu->number;
+	else
+		num = (unsigned int)-1;
+	spu_release(ctx);
+
+	return num;
+}
+DEFINE_SIMPLE_ATTRIBUTE(spufs_id_ops, spufs_id_get, 0, "0x%llx\n")
+
 struct tree_descr spufs_dir_contents[] = {
 	{ "mem",  &spufs_mem_fops,  0666, },
 	{ "regs", &spufs_regs_fops,  0666, },
@@ -1351,5 +1367,6 @@ struct tree_descr spufs_dir_contents[] =
 	{ "spu_tag_mask", &spufs_spu_tag_mask_ops, 0666, },
 	{ "event_mask", &spufs_event_mask_ops, 0666, },
 	{ "srr0", &spufs_srr0_ops, 0666, },
+	{ "phys-id", &spufs_id_ops, 0666, },
 	{},
 };

--

