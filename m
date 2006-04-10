Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWDJUhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWDJUhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWDJUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:37:48 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:9403 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932134AbWDJUhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:37:47 -0400
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <E1FT36W-0004KP-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 10 Apr 2006 22:35:20 +0200)
Subject: [PATCH 1/3] locks: don't unnecessarily fail posix lock operations
References: <E1FT36W-0004KP-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FT38e-0004L2-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Apr 2006 22:37:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

posix_lock_file() was too cautious, failing operations on OOM, even if
they didn't actually require an allocation.

This has the disadvantage, that a failing unlock on process exit could
lead to a memory leak.  There are two possibilites for this:

- filesystem implements .lock() and calls back to posix_lock_file().
On cleanup of files_struct locks_remove_posix() is called which should
remove all locks belonging to files_struct.  However if filesystem
calls posix_lock_file() which fails, then those locks will never be
freed.

- if a file is closed while a lock is blocked, then after acquiring
fcntl_setlk() will undo the lock.  But this unlock itself might fail
on OOM, again possibly leaking the lock.

The solution is to move the checking of the allocations until after it
is sure that they will be needed.  This will solve the above problem
since unlock will always succeed unless it splits an existing region.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-04-09 10:39:58.000000000 +0200
+++ linux/fs/locks.c	2006-04-09 11:07:10.000000000 +0200
@@ -830,14 +830,7 @@ static int __posix_lock_file_conf(struct
 	if (request->fl_flags & FL_ACCESS)
 		goto out;
 
-	error = -ENOLCK; /* "no luck" */
-	if (!(new_fl && new_fl2))
-		goto out;
-
 	/*
-	 * We've allocated the new locks in advance, so there are no
-	 * errors possible (and no blocking operations) from here on.
-	 * 
 	 * Find the first old lock with the same owner as the new lock.
 	 */
 	
@@ -934,10 +927,25 @@ static int __posix_lock_file_conf(struct
 		before = &fl->fl_next;
 	}
 
+	/*
+	 * The above code only modifies existing locks in case of
+	 * merging or replacing.  If new lock(s) need to be inserted
+	 * all modifications are done bellow this, so it's safe yet to
+	 * bail out.
+	 */
+	error = -ENOLCK; /* "no luck" */
+	if (right && left == right && !new_fl2)
+		goto out;
+
 	error = 0;
 	if (!added) {
 		if (request->fl_type == F_UNLCK)
 			goto out;
+
+		if (!new_fl) {
+			error = -ENOLCK;
+			goto out;
+		}
 		locks_copy_lock(new_fl, request);
 		locks_insert_lock(before, new_fl);
 		new_fl = NULL;
