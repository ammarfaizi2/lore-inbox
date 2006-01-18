Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWARHXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWARHXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWARHXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:23:43 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:14277 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S964962AbWARHX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:23:26 -0500
Date: Wed, 18 Jan 2006 15:22:51 +0800
Message-Id: <200601180722.k0I7MpbW006136@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [PATCH 3/13] autofs4 - can't mount due to mount point dir not empty
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses a problem where stale dentrys stop mounts
from happening.

When a mount point directory is pre-created and a non-existent
entry within it is requested a dentry ends up being created within
the mount point directory which stops future mounts. The problem
is solved by ignoring negative, unhashed dentrys in the mount point 
d_subdirs list.

Additionally the apparent cacheing of -ENOENT returns from requests
is removed. The test on d_time is a tautology and d_time is not
initialised and has an unexpected value. In short it doesn't do
what it's meant to.

The cacheing of failed requests to the daemon is important and will
be followed up later.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-mm3/fs/autofs4/root.c.failed-lookup	2006-01-13 16:12:20.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/root.c	2006-01-13 16:13:33.000000000 +0800
@@ -294,14 +294,13 @@ static int try_to_fill_dentry(struct vfs
 
 		/* Turn this into a real negative dentry? */
 		if (status == -ENOENT) {
-			dentry->d_time = jiffies + AUTOFS_NEGATIVE_TIMEOUT;
 			spin_lock(&dentry->d_lock);
 			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 			spin_unlock(&dentry->d_lock);
-			return 1;
+			return 0;
 		} else if (status) {
 			/* Return a negative dentry, but leave it "pending" */
-			return 1;
+			return 0;
 		}
 	/* Trigger mount for path component or follow link */
 	} else if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY) ||
@@ -360,13 +359,13 @@ static int autofs4_revalidate(struct den
 
 	/* Negative dentry.. invalidate if "old" */
 	if (dentry->d_inode == NULL)
-		return (dentry->d_time - jiffies <= AUTOFS_NEGATIVE_TIMEOUT);
+		return 0;
 
 	/* Check for a non-mountpoint directory with no contents */
 	spin_lock(&dcache_lock);
 	if (S_ISDIR(dentry->d_inode->i_mode) &&
 	    !d_mountpoint(dentry) && 
-	    list_empty(&dentry->d_subdirs)) {
+	    simple_empty_nolock(dentry)) {
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
--- linux-2.6.15-mm3/fs/autofs4/autofs_i.h.failed-lookup	2006-01-13 16:05:10.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/autofs_i.h	2006-01-13 16:13:33.000000000 +0800
@@ -40,14 +40,6 @@
 
 #define AUTOFS_SUPER_MAGIC 0x0187
 
-/*
- * If the daemon returns a negative response (AUTOFS_IOC_FAIL) then the
- * kernel will keep the negative response cached for up to the time given
- * here, although the time can be shorter if the kernel throws the dcache
- * entry away.  This probably should be settable from user space.
- */
-#define AUTOFS_NEGATIVE_TIMEOUT (60*HZ)	/* 1 minute */
-
 /* Unified info structure.  This is pointed to by both the dentry and
    inode structures.  Each file in the filesystem has an instance of this
    structure.  It holds a reference to the dentry, so dentries are never
