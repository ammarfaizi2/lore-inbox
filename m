Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUING1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUING1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269164AbUINGYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:24:35 -0400
Received: from [12.177.129.25] ([12.177.129.25]:29123 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269147AbUINGXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:23:45 -0400
Message-Id: <200409140727.i8E7RWL7005643@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - finish the signals across a reboot fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 03:27:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to me not refreshing this patch earlier, the last reboot signals patch was
missing the actual fix.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/main.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/main.c	2004-09-14 02:03:52.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/main.c	2004-09-14 02:03:59.000000000 -0400
@@ -149,7 +149,21 @@
 
 	/* Reboot */
 	if(ret){
+		int err;
+
 		printf("\n");
+
+		/* Let any pending signals fire, then disable them.  This 
+		 * ensures that they won't be delivered after the exec, when 
+		 * they are definitely not expected.
+		 */
+		unblock_signals();
+		disable_timer();
+		err = deactivate_all_fds();
+		if(err)
+			printf("deactivate_all_fds failed, errno = %d\n", 
+			       -err);
+
 		execvp(new_argv[0], new_argv);
 		perror("Failed to exec kernel");
 		ret = 1;

