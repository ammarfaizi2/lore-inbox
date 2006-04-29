Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWD2Xnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWD2Xnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWD2XnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:43:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:58333 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750830AbWD2XnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:43:10 -0400
Message-Id: <20060429233921.629156000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:21 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 09/13] spufs: add a phys-id attribute to each SPU context
Content-Disposition: inline; filename=spufs-phys-id.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
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
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c	2006-04-29 22:53:41.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/file.c	2006-04-29 22:53:44.000000000 +0200
@@ -1328,6 +1328,22 @@
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
@@ -1351,5 +1367,6 @@
 	{ "spu_tag_mask", &spufs_spu_tag_mask_ops, 0666, },
 	{ "event_mask", &spufs_event_mask_ops, 0666, },
 	{ "srr0", &spufs_srr0_ops, 0666, },
+	{ "phys-id", &spufs_id_ops, 0666, },
 	{},
 };

--

