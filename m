Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSFIQm7>; Sun, 9 Jun 2002 12:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSFIQm6>; Sun, 9 Jun 2002 12:42:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6406 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313477AbSFIQm4>;
	Sun, 9 Jun 2002 12:42:56 -0400
Date: Sun, 9 Jun 2002 17:42:56 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/locks.c and fs/nfs/file.c cleanup
Message-ID: <20020609174256.V27186@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for applying the last series of patches.  Here's a new one,
all cleanup:

 - Inline locks_notify_blocked.
 - Remove a couple of now-bogus comments.
 - Remove the obsolete F_SHLCK and F_EXLCK cases.
 - Remove the last remaining reference to FL_BROKEN.

diff -urNX dontdiff linux-2.5.21/fs/locks.c linux-2.5.21-flock/fs/locks.c
--- linux-2.5.21/fs/locks.c	Sun Jun  9 06:09:49 2002
+++ linux-2.5.21-flock/fs/locks.c	Sun Jun  9 08:14:27 2002
@@ -443,15 +446,6 @@
 	list_add(&waiter->fl_link, &blocked_list);
 }
 
-static inline
-void locks_notify_blocked(struct file_lock *waiter)
-{
-	if (waiter->fl_notify)
-		waiter->fl_notify(waiter);
-	else
-		wake_up(&waiter->fl_wait);
-}
-
 /* Wake up processes blocked waiting for blocker.
  * If told to wait then schedule the processes until the block list
  * is empty, otherwise empty the block list ourselves.
@@ -459,12 +453,13 @@
 static void locks_wake_up_blocks(struct file_lock *blocker)
 {
 	while (!list_empty(&blocker->fl_block)) {
-		struct file_lock *waiter = list_entry(blocker->fl_block.next, struct file_lock, fl_block);
-		/* Remove waiter from the block list, because by the
-		 * time it wakes up blocker won't exist any more.
-		 */
+		struct file_lock *waiter = list_entry(blocker->fl_block.next,
+				struct file_lock, fl_block);
 		locks_delete_block(waiter);
-		locks_notify_blocked(waiter);
+		if (waiter->fl_notify)
+			waiter->fl_notify(waiter);
+		else
+			wake_up(&waiter->fl_wait);
 	}
 }
 
@@ -1405,8 +1408,6 @@
 	if (copy_from_user(&flock, l, sizeof(flock)))
 		goto out;
 
-	/* Get arguments and validate them ...
-	 */
 	inode = filp->f_dentry->d_inode;
 
 	/* Don't allow mandatory locks on files that may be memory mapped
@@ -1438,23 +1439,6 @@
 		break;
 	case F_UNLCK:
 		break;
-	case F_SHLCK:
-	case F_EXLCK:
-#ifdef __sparc__
-/* warn a bit for now, but don't overdo it */
-{
-	static int count = 0;
-	if (!count) {
-		count=1;
-		printk(KERN_WARNING
-		       "fcntl_setlk() called by process %d (%s) with broken flock() emulation\n",
-		       current->pid, current->comm);
-	}
-}
-		if (!(filp->f_mode & 3))
-			goto out;
-		break;
-#endif
 	default:
 		error = -EINVAL;
 		goto out;
@@ -1543,8 +1527,6 @@
 	if (copy_from_user(&flock, l, sizeof(flock)))
 		goto out;
 
-	/* Get arguments and validate them ...
-	 */
 	inode = filp->f_dentry->d_inode;
 
 	/* Don't allow mandatory locks on files that may be memory mapped
@@ -1576,8 +1558,6 @@
 		break;
 	case F_UNLCK:
 		break;
-	case F_SHLCK:
-	case F_EXLCK:
 	default:
 		error = -EINVAL;
 		goto out;
diff -urNX dontdiff linux-2.5.21/fs/nfs/file.c linux-2.5.21-flock/fs/nfs/file.c
--- linux-2.5.21/fs/nfs/file.c	Sun Jun  2 18:44:51 2002
+++ linux-2.5.21-flock/fs/nfs/file.c	Fri Jun  7 06:19:22 2002
@@ -272,7 +272,7 @@
 	 * Not sure whether that would be unique, though, or whether
 	 * that would break in other places.
 	 */
-	if (!fl->fl_owner || (fl->fl_flags & (FL_POSIX|FL_BROKEN)) != FL_POSIX)
+	if (!fl->fl_owner || (fl->fl_flags & FL_POSIX) != FL_POSIX)
 		return -ENOLCK;
 
 	/*

-- 
Revolutions do not require corporate support.
