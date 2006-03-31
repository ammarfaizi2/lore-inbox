Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWCaRat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWCaRat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWCaRat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:30:49 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:59879 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932096AbWCaRas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:30:48 -0500
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:26:25 +0200)
Subject: [PATCH 2/4] locks: don't unnecessarily fail posix lock operations
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNSB-0005VK-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:30:31 +0200
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
--- linux.orig/fs/locks.c	2006-03-31 18:55:33.000000000 +0200
+++ linux/fs/locks.c	2006-03-31 18:55:33.000000000 +0200
@@ -835,14 +835,7 @@ int __posix_lock_file(struct inode *inod
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
 	
@@ -939,6 +932,18 @@ int __posix_lock_file(struct inode *inod
 		before = &fl->fl_next;
 	}
 
+	/*
+	 * The above code only modifies existing locks in case of
+	 * merging or replacing.  If new lock(s) need to be inserted
+	 * all modifications are done bellow this, so it's safe yet to
+	 * bail out.
+	 */
+	error = -ENOLCK; /* "no luck" */
+	if (!added && request->fl_type != F_UNLCK && !new_fl)
+		goto out;
+	if (right && left == right && !new_fl2)
+		goto out;
+
 	error = 0;
 	if (!added) {
 		if (request->fl_type == F_UNLCK)
