Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbSLEHmJ>; Thu, 5 Dec 2002 02:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbSLEHlI>; Thu, 5 Dec 2002 02:41:08 -0500
Received: from holomorphy.com ([66.224.33.161]:54408 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267252AbSLEHlA>;
	Thu, 5 Dec 2002 02:41:00 -0500
Date: Wed, 04 Dec 2002 23:48:27 -0800
From: wli@holomorphy.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [pidhash] [2/4] make cap_set_pg() use for_each_task_pid()
Message-ID: <0212042348.YbGc0avcIbVdPbDdOcLb4dba4d.aQaVd15950@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212042348.MagbHaKdKcEaTd3dPb5dTdIcCb8dWbca15950@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

capset_set_pg() hunts for a task with the right pgrp. It neither wants
nor needs to examine all tasks.

 capability.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)


diff -urpN mm1-2.5.50-4/kernel/capability.c mm1-2.5.50-5/kernel/capability.c
--- mm1-2.5.50-4/kernel/capability.c	2002-11-27 14:35:50.000000000 -0800
+++ mm1-2.5.50-5/kernel/capability.c	2002-12-04 14:55:10.000000000 -0800
@@ -84,13 +84,15 @@ static inline void cap_set_pg(int pgrp, 
 			      kernel_cap_t *inheritable,
 			      kernel_cap_t *permitted)
 {
-     task_t *g, *target;
-
-     do_each_thread(g, target) {
-             if (target->pgrp != pgrp)
-                     continue;
-	     security_capset_set(target, effective, inheritable, permitted);
-     } while_each_thread(g, target);
+	task_t *g, *target;
+	struct list_head *l;
+	struct pid *pid;
+
+	for_each_task_pid(pgrp, PIDTYPE_PGID, g, l, pid) {
+		target = g;
+		while_each_thread(g, target)
+			security_capset_set(target, effective, inheritable, permitted);
+	}
 }
 
 /*
