Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319350AbSHVOOo>; Thu, 22 Aug 2002 10:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319351AbSHVOOo>; Thu, 22 Aug 2002 10:14:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319350AbSHVOOn>;
	Thu, 22 Aug 2002 10:14:43 -0400
Date: Thu, 22 Aug 2002 15:18:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] An option to make fcntl & flock locks fair
Message-ID: <20020822151848.W29958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Shlomi Fish asked about including first-come, first-served style locking
for posix and flock locks.  After some back-and-forth, we came up with
the following patch which seems unintrusive enough to bother including.
Personally, I doubt the utility of this, but someone might have an
application for it, and the code's already written.

diff -urpNX dontdiff linux-2.5.31/fs/locks.c linux-2.5.31-willy/fs/locks.c
--- linux-2.5.31/fs/locks.c	2002-08-01 14:16:39.000000000 -0700
+++ linux-2.5.31-willy/fs/locks.c	2002-08-21 08:29:29.000000000 -0700
@@ -126,6 +126,14 @@
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
+/* Defining FAIR_LOCKS prevents readers from starving writers.  I'm not
+ * sure anyone has a usage pattern where this is actually a problem, but
+ * it's a trivial change to allow you to enable this, so I added it.
+ * Note that we record the owner and check it first, so you can't deadlock
+ * on an attempt to modify your own lock.
+ */
+#undef FAIR_LOCKS
+
 #define IS_POSIX(fl)	(fl->fl_flags & FL_POSIX)
 #define IS_FLOCK(fl)	(fl->fl_flags & FL_FLOCK)
 #define IS_LEASE(fl)	(fl->fl_flags & FL_LEASE)
@@ -503,24 +508,22 @@ static void locks_delete_lock(struct fil
 	locks_free_lock(fl);
 }
 
-/* Determine if lock sys_fl blocks lock caller_fl. Common functionality
- * checks for shared/exclusive status of overlapping locks.
+/*
+ * Determine if lock sys_fl blocks lock caller_fl.  Write locks require
+ * exclusive access, read locks can share.  If you define FAIR_LOCKS,
+ * readers can only share until a writer comes along and blocks.
  */
 static int locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
 {
-	switch (caller_fl->fl_type) {
-	case F_RDLCK:
-		return (sys_fl->fl_type == F_WRLCK);
-
-	case F_WRLCK:
-		return (1);
-
-	default:
-		printk(KERN_ERR "locks_conflict(): impossible lock type - %d\n",
-		       caller_fl->fl_type);
-		break;
-	}
-	return (0);	/* This should never happen */
+	if (caller_fl->fl_type == F_WRLCK)
+		return 1;
+	if (sys_fl->fl_type == F_WRLCK)
+		return 1;
+#ifdef FAIR_LOCKS
+	if (!list_empty(&sys_fl->fl_block))
+		return 1;
+#endif
+	return 0;
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. POSIX specific

-- 
Revolutions do not require corporate support.
