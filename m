Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUDFKJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 06:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUDFKJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 06:09:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:63702 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263750AbUDFKIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 06:08:54 -0400
Date: Tue, 6 Apr 2004 15:43:20 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-ID: <20040406101320.GB1270@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040402043814.GA6993@in.ibm.com> <Pine.LNX.4.44L0.0404021629210.889-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0404021629210.889-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 04:41:16PM -0500, Alan Stern wrote:
> [CC: list pruned on the assumption that most recipients aren't interested]
> 
> On Fri, 2 Apr 2004, Maneesh Soni wrote:
> 
> > Yes, see the patch below. Probably the race window has become smaller but
> > Badness message is also an indication that somewhere kobject_cleanup has 
> > started. I have not yet seen why race is still there.
> 
> Yes.  Although the problem can't be due to a race if it involves code 
> that's protected by a semaphore.
> 
> Did this Badness message come from within check_perm()?  I don't see how
> that could happen with this patch.  You're guaranteed that the refcount is
> positive until after sysfs_remove_dir() returns.  It's _supposed_ to be
> positive, anyway; maybe it isn't.  You could try checking for that, at the
> end of sysf_remove_dir().
> 

Yes, it came from check_perm(). I think I found the reason for that. The
attribute group subdirectory's dentry also has a pointer to the same kobject
as the corresponding directory's dentry. The kobject directory dentry was
taken care of but the attribute group subdirectory was still pointing to the
kobject. And that badness message was coming while opening a file under 
attribute subdir. 

I am using dentry->d_flags and a new flag value DCACHE_SYSFS_CONNECTED to 
indicate that the dentry is connected to a vaild kobject. I could run my
stress test of insmod/rmmod for more than 3 hours without any badness message.

I am copying to the maintainers also and hope to get their comments for
this patch.

Thanks
Maneesh



o The following patch fixes the race involved between unregistering a kobject 
  and simultaneously opeing a corresponding attribute file in sysfs. 

  Ideally sysfs should take a ref. to the kobject as long as it has dentries 
  referring to the kobject, but because of current limitations in 
  module/kobject ref counting, sysfs's  pinning of kobject leads to 
  hang/delays in rmmod of certain modules. The patch uses a new flag to mark
  dentries as disconnected from a valid kobject in the process of unregistering
  the kobject. The ->open in sysfs is failed if it finds a disconnected dentry.
  Marking and checking for the flag is done under dentry->d_inode->i_sem.


 fs/sysfs/bin.c         |    8 +++++++-
 fs/sysfs/dir.c         |    6 ++++++
 fs/sysfs/file.c        |   11 ++++++++++-
 fs/sysfs/group.c       |   19 +++++++++++++------
 include/linux/dcache.h |    1 +
 5 files changed, 37 insertions(+), 8 deletions(-)

diff -puN include/linux/dcache.h~sysfs-d_fsdata-race-fix include/linux/dcache.h
--- linux-2.6.5-mm1/include/linux/dcache.h~sysfs-d_fsdata-race-fix	2004-04-06 15:04:08.000000000 +0530
+++ linux-2.6.5-mm1-maneesh/include/linux/dcache.h	2004-04-06 15:04:39.000000000 +0530
@@ -153,6 +153,7 @@ d_iput:		no		no		yes
 
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
 #define DCACHE_UNHASHED		0x0010	
+#define DCACHE_SYSFS_CONNECTED	0x0020	/* dentry connected to vaild kobject */
 
 extern spinlock_t dcache_lock;
 
diff -puN fs/sysfs/dir.c~sysfs-d_fsdata-race-fix fs/sysfs/dir.c
--- linux-2.6.5-mm1/fs/sysfs/dir.c~sysfs-d_fsdata-race-fix	2004-04-06 15:04:14.000000000 +0530
+++ linux-2.6.5-mm1-maneesh/fs/sysfs/dir.c	2004-04-06 15:04:39.000000000 +0530
@@ -34,6 +34,7 @@ static int create_dir(struct kobject * k
 					 init_dir);
 		if (!error) {
 			(*d)->d_fsdata = k;
+			(*d)->d_flags = DCACHE_SYSFS_CONNECTED;
 			p->d_inode->i_nlink++;
 		}
 		dput(*d);
@@ -119,6 +120,11 @@ void sysfs_remove_dir(struct kobject * k
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
 
+	/* avoid further references to kobject even if dentry
+	 * is alive after remove dir.
+	 */
+	dentry->d_flags &= ~DCACHE_SYSFS_CONNECTED;
+
 	spin_lock(&dcache_lock);
 restart:
 	node = dentry->d_subdirs.next;
diff -puN fs/sysfs/file.c~sysfs-d_fsdata-race-fix fs/sysfs/file.c
--- linux-2.6.5-mm1/fs/sysfs/file.c~sysfs-d_fsdata-race-fix	2004-04-06 15:04:18.000000000 +0530
+++ linux-2.6.5-mm1-maneesh/fs/sysfs/file.c	2004-04-06 15:04:39.000000000 +0530
@@ -134,6 +134,9 @@ static int flush_read_buffer(struct sysf
  *	is in the file's ->d_fsdata. The target object is in the directory's
  *	->d_fsdata.
  *
+ *	It is safe to use ->d_parent->d_fsdata as both dentry and the kobject 
+ *	are pinned in ->open().
+ *	
  *	We call fill_read_buffer() to allocate and fill the buffer from the
  *	object's show() method exactly once (if the read is happening from
  *	the beginning of the file). That should fill the entire buffer with
@@ -238,12 +241,18 @@ sysfs_write_file(struct file *file, cons
 
 static int check_perm(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
+	struct dentry * kobj_dir = file->f_dentry->d_parent;
+	struct kobject * kobj = NULL;
 	struct attribute * attr = file->f_dentry->d_fsdata;
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
 	int error = 0;
 
+	down(&kobj_dir->d_inode->i_sem);
+	if (kobj_dir->d_flags & DCACHE_SYSFS_CONNECTED)
+		kobj = kobject_get(kobj_dir->d_fsdata);
+	up(&kobj_dir->d_inode->i_sem);
+
 	if (!kobj || !attr)
 		goto Einval;
 
diff -puN fs/sysfs/bin.c~sysfs-d_fsdata-race-fix fs/sysfs/bin.c
--- linux-2.6.5-mm1/fs/sysfs/bin.c~sysfs-d_fsdata-race-fix	2004-04-06 15:04:21.000000000 +0530
+++ linux-2.6.5-mm1-maneesh/fs/sysfs/bin.c	2004-04-06 15:04:39.000000000 +0530
@@ -94,9 +94,15 @@ static ssize_t write(struct file * file,
 
 static int open(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
+	struct dentry * kobj_dir = file->f_dentry->d_parent;
+	struct kobject * kobj = NULL;
 	struct bin_attribute * attr = file->f_dentry->d_fsdata;
 	int error = -EINVAL;
+	
+	down(&kobj_dir->d_inode->i_sem);
+	if (kobj_dir->d_flags & DCACHE_SYSFS_CONNECTED) 
+		kobj = kobject_get(kobj_dir->d_fsdata);
+	up(&kobj_dir->d_inode->i_sem);
 
 	if (!kobj || !attr)
 		goto Done;
diff -puN fs/sysfs/group.c~sysfs-d_fsdata-race-fix fs/sysfs/group.c
--- linux-2.6.5-mm1/fs/sysfs/group.c~sysfs-d_fsdata-race-fix	2004-04-06 15:04:26.000000000 +0530
+++ linux-2.6.5-mm1-maneesh/fs/sysfs/group.c	2004-04-06 15:04:39.000000000 +0530
@@ -10,7 +10,7 @@
 
 #include <linux/kobject.h>
 #include <linux/module.h>
-#include <linux/dcache.h>
+#include <linux/fs.h>
 #include <linux/err.h>
 #include "sysfs.h"
 
@@ -70,11 +70,18 @@ void sysfs_remove_group(struct kobject *
 	else
 		dir = dget(kobj->dentry);
 
-	remove_files(dir,grp);
-	if (grp->name)
-		sysfs_remove_subdir(dir);
-	/* release the ref. taken in this routine */
-	dput(dir);
+	if (!IS_ERR(dir)) {
+		if (dir && dir->d_inode) {
+			down(&dir->d_inode->i_sem);
+			dir->d_flags &= ~DCACHE_SYSFS_CONNECTED;
+			up(&dir->d_inode->i_sem);
+			remove_files(dir,grp);
+			if (grp->name)
+				sysfs_remove_subdir(dir);
+			/* release the ref. taken in this routine */
+			dput(dir);
+		}
+	}
 }
 
 

_
 
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
