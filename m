Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTBKJqz>; Tue, 11 Feb 2003 04:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbTBKJqz>; Tue, 11 Feb 2003 04:46:55 -0500
Received: from hera.cwi.nl ([192.16.191.8]:34530 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267599AbTBKJqy>;
	Tue, 11 Feb 2003 04:46:54 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 11 Feb 2003 10:56:34 +0100 (MET)
Message-Id: <UTC200302110956.h1B9uYH25149.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] signal error return fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Tue Feb 11 09:14:18 2003
+++ b/kernel/sys.c	Tue Feb 11 10:13:26 2003
@@ -916,6 +916,7 @@
 	p = find_task_by_pid(pid);
 	if (!p)
 		goto out;
+
 	err = -EINVAL;
 	if (!thread_group_leader(p))
 		goto out;
@@ -927,11 +928,16 @@
 		err = -EACCES;
 		if (p->did_exec)
 			goto out;
-	} else if (p != current)
-		goto out;
+	} else {
+		err = -ESRCH;
+		if (p != current)
+			goto out;
+	}
+
 	err = -EPERM;
 	if (p->leader)
 		goto out;
+
 	if (pgid != pid) {
 		struct task_struct *p;
 		struct pid *pid;
