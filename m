Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTE0GFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 02:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTE0GFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 02:05:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10698 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261182AbTE0GFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 02:05:04 -0400
Date: Tue, 27 May 2003 03:16:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: 00_drop-broken-flock-account-1
Message-ID: <Pine.LNX.4.55L.0305270313550.813@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Is this patch suitable for mainline inclusion?

        per-task flock accounting was broken across tasks sharing the same
        files. Removed temporarly. This should fix sendmail. If somebody
        wanted to bypass the rlimit he needed simply to use fcntl instead
        so it's not going to make much difference for 2.4. Fix from
        Matthew Wilcox.

>From willy@www.linux.org.uk Tue Jul  2 11:20:04 2002
Date: Tue, 2 Jul 2002 00:01:32 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Andrew Morton <akpm@zip.com.au>, Yusuf Goolamabbas <yusufg@outblaze.com>,
   viro@math.psu.edu, Jason Baron <jbaron@redhat.com>
Subject: Re: Sendmail/Cyrus claim Linux flock broken. Switching to fcntl
Message-ID: <20020702000132.D10312@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020701231355.C10312@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Mon, Jul 01, 2002 at 11:13:55PM +0100
Sender: <willy@www.linux.org.uk>
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
Status: RO
Content-Length: 2979
Lines: 99

On Mon, Jul 01, 2002 at 11:13:55PM +0100, Matthew Wilcox wrote:
> The file lock accounting code is horribly broken (and I wrote it, I
> should know).  I think the best solution to 2.4 is simply to delete it,
> at least for BSD-style flocks.
>
> Patch to follow.  Note that 2.5 has the same issue, but I'll fix it
> differently there.

Here's the patch for 2.4:

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


