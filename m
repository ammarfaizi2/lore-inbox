Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316804AbSGBPmN>; Tue, 2 Jul 2002 11:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSGBPmM>; Tue, 2 Jul 2002 11:42:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12045 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316798AbSGBPmK>;
	Tue, 2 Jul 2002 11:42:10 -0400
Date: Tue, 2 Jul 2002 16:44:33 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Stephen C. Tweedie" <sct@redhat.com>,
       David Ford <david+cert@blue-labs.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Yusuf Goolamabbas <yusufg@outblaze.com>,
       Jason Baron <jbaron@redhat.com>, arjanv@redhat.com,
       Richard A Nelson <cowboy@debian.org>,
       Pat Knight <pknight@eurologic.com>,
       Jeff Sutherland <jeffs@accelent.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: broken flock()
Message-ID: <20020702164433.A27706@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I seem to have accumulated at least 4 different bug reports of the
same problem over the last year (!).  I've cc'd everyone who's sent mail
about it that I could find.  Please exercise common sense when replying
to this...

The problem is definitely in the file lock accounting.  Since it's
effectively useless anyway, taking it out seems to be the right thing
to do for 2.4.  Here's a patch to do that:

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
