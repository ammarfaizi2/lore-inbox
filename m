Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTATVyf>; Mon, 20 Jan 2003 16:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTATVye>; Mon, 20 Jan 2003 16:54:34 -0500
Received: from hera.cwi.nl ([192.16.191.8]:43410 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266998AbTATVyd>;
	Mon, 20 Jan 2003 16:54:33 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 20 Jan 2003 23:03:31 +0100 (MET)
Message-Id: <UTC200301202203.h0KM3V602042.aeb@smtp.cwi.nl>
To: mingo@redhat.com, torvalds@transmeta.com
Subject: [PATCH] fix setpgid
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In patch-2.5.37 a return code of setpgid(pid,pgid) was broken.
If pid is not the current process and is not a child of
the current process it should return ESRCH, but the 2.5.37
patch turned this into EINVAL. The below fixes this again.

Andries

--- /linux/2.5/linux-2.5.59/linux/kernel/sys.c	Tue Dec 10 18:42:42 2002
+++ /linux/2.5/linux-2.5.59a/linux/kernel/sys.c	Mon Jan 20 22:04:52 2003
@@ -916,6 +916,7 @@
 	p = find_task_by_pid(pid);
 	if (!p)
 		goto out;
+
 	err = -EINVAL;
 	if (!thread_group_leader(p))
 		goto out;
@@ -927,8 +928,12 @@
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
