Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTDUT7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTDUT7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:59:05 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:57579 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262258AbTDUT7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:59:04 -0400
Message-Id: <200304212014.h3LKE4bP002830@pasta.boston.redhat.com>
To: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.68 fs/ext3/super.c fix for orphan recovery error path
Date: Mon, 21 Apr 2003 16:14:04 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen/Andrew, please consider applying this patch to reverse the order
of checks in ext3_orphan_cleanup() for read-only mounts and prior errors.

The problem resolved by this patch is that if a root file system has an
error recorded from a previous mount, and then (when rebooting) the orphan
recovery procedure is initiated, the recovery is correctly skipped but the
file system is incorrectly left in a writable state.

This causes the subsequent fsck to fail due to the root file system
being dirty, and then requires manual intervention to get the system
fully booted.

Thanks in advance.  -ernie



diff -urpN linux-2.5.68/fs/ext3/super.c{.orig,}
--- linux-2.5.68/fs/ext3/super.c.orig	2003-04-19 22:50:47.000000000 -0400
+++ linux-2.5.68/fs/ext3/super.c	2003-04-21 15:18:08.000000000 -0400
@@ -982,12 +982,6 @@ static void ext3_orphan_cleanup (struct 
 		return;
 	}
 
-	if (s_flags & MS_RDONLY) {
-		printk(KERN_INFO "EXT3-fs: %s: orphan cleanup on readonly fs\n",
-		       sb->s_id);
-		sb->s_flags &= ~MS_RDONLY;
-	}
-
 	if (EXT3_SB(sb)->s_mount_state & EXT3_ERROR_FS) {
 		if (es->s_last_orphan)
 			jbd_debug(1, "Errors on filesystem, "
@@ -997,6 +991,12 @@ static void ext3_orphan_cleanup (struct 
 		return;
 	}
 
+	if (s_flags & MS_RDONLY) {
+		printk(KERN_INFO "EXT3-fs: %s: orphan cleanup on readonly fs\n",
+		       sb->s_id);
+		sb->s_flags &= ~MS_RDONLY;
+	}
+
 	while (es->s_last_orphan) {
 		struct inode *inode;
 
