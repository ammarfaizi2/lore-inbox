Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319555AbSH3MU6>; Fri, 30 Aug 2002 08:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319557AbSH3MU6>; Fri, 30 Aug 2002 08:20:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56079 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319555AbSH3MU4>;
	Fri, 30 Aug 2002 08:20:56 -0400
Date: Fri, 30 Aug 2002 13:25:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andy Tai <lichengtai@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file locking (fcntl) bug in 2.4.19
Message-ID: <20020830132521.Y28676@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, 2.4 & 2.5 are broken.  Here's a patch which both marcelo and alan
refuse to apply, but fixes the problem.

diff -urNX dontdiff linux-2418/fs/locks.c linux-2418-acct/fs/locks.c
--- linux-2418/fs/locks.c	Thu Oct 11 08:52:18 2001
+++ linux-2418-acct/fs/locks.c	Mon Jul  1 16:23:36 2002
@@ -134,15 +134,9 @@
 static kmem_cache_t *filelock_cache;
 
 /* Allocate an empty lock structure. */
-static struct file_lock *locks_alloc_lock(int account)
+static struct file_lock *locks_alloc_lock(void)
 {
-	struct file_lock *fl;
-	if (account && current->locks >= current->rlim[RLIMIT_LOCKS].rlim_cur)
-		return NULL;
-	fl = kmem_cache_alloc(filelock_cache, SLAB_KERNEL);
-	if (fl)
-		current->locks++;
-	return fl;
+	return kmem_cache_alloc(filelock_cache, SLAB_KERNEL);
 }
 
 /* Free a lock which is not in use. */
@@ -152,7 +146,6 @@
 		BUG();
 		return;
 	}
-	current->locks--;
 	if (waitqueue_active(&fl->fl_wait))
 		panic("Attempting to free lock with active wait queue");
 
@@ -219,7 +212,7 @@
 /* Fill in a file_lock structure with an appropriate FLOCK lock. */
 static struct file_lock *flock_make_lock(struct file *filp, unsigned int type)
 {
-	struct file_lock *fl = locks_alloc_lock(1);
+	struct file_lock *fl = locks_alloc_lock();
 	if (fl == NULL)
 		return NULL;
 
@@ -348,7 +341,7 @@
 /* Allocate a file_lock initialised to this type of lease */
 static int lease_alloc(struct file *filp, int type, struct file_lock **flp)
 {
-	struct file_lock *fl = locks_alloc_lock(1);
+	struct file_lock *fl = locks_alloc_lock();
 	if (fl == NULL)
 		return -ENOMEM;
 
@@ -712,7 +705,7 @@
 			 size_t count)
 {
 	struct file_lock *fl;
-	struct file_lock *new_fl = locks_alloc_lock(0);
+	struct file_lock *new_fl = locks_alloc_lock();
 	int error;
 
 	if (new_fl == NULL)
@@ -872,8 +865,8 @@
 	 * We may need two file_lock structures for this operation,
 	 * so we get them in advance to avoid races.
 	 */
-	new_fl = locks_alloc_lock(0);
-	new_fl2 = locks_alloc_lock(0);
+	new_fl = locks_alloc_lock();
+	new_fl2 = locks_alloc_lock();
 	error = -ENOLCK; /* "no luck" */
 	if (!(new_fl && new_fl2))
 		goto out_nolock;
@@ -1426,7 +1419,7 @@
 int fcntl_setlk(unsigned int fd, unsigned int cmd, struct flock *l)
 {
 	struct file *filp;
-	struct file_lock *file_lock = locks_alloc_lock(0);
+	struct file_lock *file_lock = locks_alloc_lock();
 	struct flock flock;
 	struct inode *inode;
 	int error;
@@ -1582,7 +1575,7 @@
 int fcntl_setlk64(unsigned int fd, unsigned int cmd, struct flock64 *l)
 {
 	struct file *filp;
-	struct file_lock *file_lock = locks_alloc_lock(0);
+	struct file_lock *file_lock = locks_alloc_lock();
 	struct flock64 flock;
 	struct inode *inode;
 	int error;

-- 
Revolutions do not require corporate support.
