Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSIOH65>; Sun, 15 Sep 2002 03:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317978AbSIOH64>; Sun, 15 Sep 2002 03:58:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11649 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317950AbSIOH6z>;
	Sun, 15 Sep 2002 03:58:55 -0400
Date: Sun, 15 Sep 2002 10:10:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] clone-fix-2.5.34-A0, BK-curr
Message-ID: <Pine.LNX.4.44.0209151007320.9906-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch fixes a clone-flags bug noticed by Roland McGrath. The current
CLONE_DETACHED & CLONE_THREAD forcing code did things in the wrong order,
which makes it possible to force an oops the following way:

        main () { syscall(120, 0x00400000); }

instead of changing the order of CLONE_SIGHAND and CLONE_THREAD flag
forcing (which would fix the bug), the proper approach is to fail with
-EINVAL if invalid combinations of clone flags are detected. This change
does not affect existing applications.

	Ingo

--- linux/kernel/fork.c.orig	Sun Sep 15 10:06:52 2002
+++ linux/kernel/fork.c	Sun Sep 15 10:06:54 2002
@@ -672,16 +672,13 @@
 		return ERR_PTR(-EINVAL);
 
 	/*
-	 * Thread groups must share signals as well:
+	 * Thread groups must share signals as well, and detached threads
+	 * can only be started up within the thread group.
 	 */
-	if (clone_flags & CLONE_THREAD)
-		clone_flags |= CLONE_SIGHAND;
-	/*
-	 * Detached threads can only be started up within the thread
-	 * group.
-	 */
-	if (clone_flags & CLONE_DETACHED)
-		clone_flags |= CLONE_THREAD;
+	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
+		return ERR_PTR(-EINVAL);
+	if ((clone_flags & CLONE_DETACHED) && !(clone_flags & CLONE_THREAD))
+		return ERR_PTR(-EINVAL);
 
 	retval = security_ops->task_create(clone_flags);
 	if (retval)

