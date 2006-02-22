Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWBVVmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWBVVmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWBVVmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:42:12 -0500
Received: from mail.fieldses.org ([66.93.2.214]:7393 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1751467AbWBVVmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:42:12 -0500
Date: Wed, 22 Feb 2006 16:42:02 -0500
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Chris Wedgwood <cw@f00f.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Oleg Drokin <green@linuxhacker.ru>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060222214201.GI28219@fieldses.org>
References: <20060220221948.GC5733@linuxhacker.ru> <20060221103949.GD19349@infradead.org> <20060222010347.GA27318@taniwha.stupidest.org> <1140598740.6400.610.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140598740.6400.610.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 08:59:00AM +0000, Steven Whitehouse wrote:
> Hi,
> 
> Also GFS2 (which we hope to be ready to submit to the kernel shortly)
> would want to make use of this feature. Its been a long standing entry
> on our TODO list,

So there's a question here about ordering of these sorts of patches.

At CITI we've done some work on making nfsd play nicely with cluster
filesystems (e.g., to allow consistent locking across NFS clients
talking to different NFS servers exporting the same cluster filesystem).

The work is partly motivated by (and so far only tested with)
out-of-tree filesystems.  We've had some minor discussion with GFS2 and
OCFS2 hackers but assumed there was no use asking for serious review
until there was an in-tree filesystem that could take advantage of them.
(So we're happy to hear GFS2 is nearly ready--OCFS2 isn't attempting
cluster-coherent locking at all for now.)

Should we be pushing these sorts of patches earlier, at least as long as
they're fairly low-impact?  Or should we be observing an absolute rule
against introducing new interfaces without also introducing in-tree
users?

(Patch follows as an example--I'm not requesting it be applied for now.)

--b.


asynchronous locking api for lock managers on cluster filesystems

There is currently a filesystem ->lock() method, but it is defined only by
a few filesystems that are not exported via nfs.  So none of the lock
routines that are used by lockd or nfsv4 bother to call those methods.

Cluster filesystems would like to be able define their own ->lock() methods
and also would like to be exportable via NFS.

So we add vfs_lock_file, vfs_test_lock, and vfs_cancel_lock routines which
do call the underlying filesystem's lock routines.  These are intended to
be used by lockd and nfsd; lockd and nfsd changes to take advantage of them
are made by later patches.

Acquiring a lock may require communication with remote hosts, and to
avoid blocking lockd or nfsd threads during such communication, we allow
the results to be returned asynchronously.

When a ->lock() call needs to block, the file system will return
-EINPROGRESS, and then later return the results with a call to the routine
in the fl_vfs_callback of the lock_manager_operations struct.

Signed-off-by: Marc Eshel <eshel@almaden.ibm.com>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---

 fs/locks.c         |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    6 +++
 2 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index d3d4567..6acf318 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1011,6 +1011,103 @@ int posix_lock_file_wait(struct file *fi
 EXPORT_SYMBOL(posix_lock_file_wait);
 
 /**
+ * vfs_lock_file - file byte range lock
+ * @filp: The file to apply the lock to
+ * @fl: The lock to be applied
+ *
+ * To avoid blocking kernel daemons, such as lockd, that need to acquire POSIX
+ * locks, the ->lock() interface may return asynchronously, before the lock has
+ * been granted or denied by the underlying filesystem, if (and only if)
+ * fl_vfs_callback is set. Callers expecting ->lock() to return asynchronously
+ * will only use F_SETLK, not F_SETLKW; they will set FL_SLEEP if (and only if)
+ * the request is for a blocking lock. When ->lock() does return asynchronously,
+ * it must return -EINPROGRESS, and call ->fl_vfs_callback() when the lock
+ * request completes.
+ * If the request is for non-blocking lock the file system should return
+ * -EINPROGRESS then try to get the lock and call the callback routine with
+ * the result. If the request timed out the callback routine will return a
+ * nonzero return code and the file system should release the lock. The file
+ * system is also responsible to keep a corresponding posix lock when it
+ * grants a lock so the VFS can find out which locks are locally held and do
+ * the correct lock cleanup when required.
+ * The underlying filesystem must not drop the kernel lock or call
+ * ->fl_vfs_callback() before returning to the caller with a -EINPROGRESS
+ * return code.
+ */
+int vfs_lock_file(struct file *filp, struct file_lock *fl)
+{
+	if (filp->f_op && filp->f_op->lock)
+		return filp->f_op->lock(filp, F_SETLK, fl);
+	else
+		return __posix_lock_file_conf(filp->f_dentry->d_inode, fl, NULL);
+}
+EXPORT_SYMBOL(vfs_lock_file);
+
+/**
+ * vfs_lock_file - file byte range lock
+ * @filp: The file to apply the lock to
+ * @fl: The lock to be applied
+ * @conf: Place to return a copy of the conflicting lock, if found.
+ *
+ * read comments for vfs_lock_file()
+ */
+int vfs_lock_file_conf(struct file *filp, struct file_lock *fl, struct file_lock *conf)
+{
+       if (filp->f_op && filp->f_op->lock) {
+	       locks_copy_lock(conf, fl);
+	       return filp->f_op->lock(filp, F_SETLK, fl);
+       } else
+               return __posix_lock_file_conf(filp->f_dentry->d_inode, fl, conf);
+}
+EXPORT_SYMBOL(vfs_lock_file_conf);
+
+/**
+ * vfs_test_lock - test file byte range lock
+ * @filp: The file to test lock for
+ * @fl: The lock to test
+ * @conf: Place to return a copy of the conflicting lock, if found.
+ */
+int vfs_test_lock(struct file *filp, struct file_lock *fl, struct file_lock *conf)
+{
+	int error;
+
+	conf->fl_type = F_UNLCK;
+	if (filp->f_op && filp->f_op->lock) {
+ 		locks_copy_lock(conf, fl);
+		error = filp->f_op->lock(filp, F_GETLK, conf);
+		if (!error) {
+			if (conf->fl_type != F_UNLCK)
+				error =  1;
+		}
+		return error;
+ 	} else
+		return posix_test_lock(filp, fl, conf);
+}
+EXPORT_SYMBOL(vfs_test_lock);
+
+/**
+ * vfs_cancel_lock - file byte range unblock lock
+ * @filp: The file to apply the unblock to
+ * @fl: The lock to be unblocked
+ *
+ * FL_CANCELED is used to cancel blocked requests
+ */
+void vfs_cancel_lock(struct file *filp, struct file_lock *fl)
+{
+	lock_kernel();
+	fl->fl_flags |= FL_CANCEL;
+	if (filp->f_op && filp->f_op->lock) {
+		/* XXX: check locking */
+		unlock_kernel();
+		filp->f_op->lock(filp, F_SETLK, fl);
+	} else {
+		posix_unblock_lock(filp, fl);
+		unlock_kernel();
+	}
+}
+EXPORT_SYMBOL(vfs_cancel_lock);
+
+/**
  * locks_mandatory_locked - Check for an active lock
  * @inode: the file to check
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a57696c..4ac53c0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -666,6 +666,7 @@ extern spinlock_t files_lock;
 #define FL_POSIX	1
 #define FL_FLOCK	2
 #define FL_ACCESS	8	/* not trying to lock, just looking */
+#define FL_CANCEL	16	/* set to request cancelling a lock */
 #define FL_LEASE	32	/* lease held on this file */
 #define FL_LEASE_DENTRY	64	/* lease also broken by rename/unlink */
 #define FL_SLEEP	128	/* A blocking lock */
@@ -694,6 +695,7 @@ struct lock_manager_operations {
 	void (*fl_break)(struct file_lock *);
 	int (*fl_mylease)(struct file_lock *, struct file_lock *);
 	int (*fl_change)(struct file_lock **, int);
+	int (*fl_vfs_callback)(struct file_lock *, struct file_lock *, int result);
 };
 
 /* that will die - we need it for nfs_lock_info */
@@ -753,6 +755,10 @@ extern void locks_init_lock(struct file_
 extern void locks_copy_lock(struct file_lock *, struct file_lock *);
 extern void locks_remove_posix(struct file *, fl_owner_t);
 extern void locks_remove_flock(struct file *);
+extern int vfs_lock_file(struct file *, struct file_lock *);
+extern int vfs_lock_file_conf(struct file *, struct file_lock *, struct file_lock *);
+extern int vfs_test_lock(struct file *, struct file_lock *, struct file_lock *);
+extern void vfs_cancel_lock(struct file *, struct file_lock *);
 extern int posix_test_lock(struct file *, struct file_lock *, struct file_lock *);
 extern int posix_lock_file_conf(struct file *, struct file_lock *, struct file_lock *);
 extern int posix_lock_file(struct file *, struct file_lock *);
