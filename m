Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbUDBEeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 23:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUDBEeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 23:34:18 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:22681 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263158AbUDBEeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 23:34:03 -0500
Date: Fri, 2 Apr 2004 10:08:14 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       viro@math.psu.edu,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-ID: <20040402043814.GA6993@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040401051740.GA1291@in.ibm.com> <Pine.LNX.4.44L0.0404010945210.838-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0404010945210.838-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 09:56:16AM -0500, Alan Stern wrote:
> On Thu, 1 Apr 2004, Maneesh Soni wrote:
> 
> > On Wed, Mar 31, 2004 at 10:11:37AM -0500, Alan Stern wrote:
> > > 
> > > Here's a suggestion.  At the start of check_perm() grab the dentry 
> > > semaphore, then check whether d_fsdata is NULL, if it isn't then do the 
> > > kobject_get(), then unlock the semaphore.
> > > 
> > 
> > I have tried this with no luck. I still get 
> > (Badness in kobject_get at lib/kobject.c:42) which means it is not correct fix.
> 
> Did you remember to set dentry->d_fsdata to NULL?  This has to be done in
> sysfs_remove_dir() sometime during the period when dentry->d_inode->i_sem
> is held.  Right now the pointer to the kobject never gets erased. That 
> Badness message is an indication that you are using a valid pointer to a 
> kobject whose refcount is 0.
> 

Yes, see the patch below. Probably the race window has become smaller but
Badness message is also an indication that somewhere kobject_cleanup has 
started. I have not yet seen why race is still there.

There is one more bigger problem in this approach. It may miss kobject_put() in 
sysfs_release() call and result will be memory leak, ->release() is not called,
rmmod hang, etc etc. So using ->d_fsdata for this purpose is not the proper
solution, IMO.

cpu 0                      kobj->refcount              cpu 1
kobject_unregister()         	 (1)               sysfs_open_file()
  kobject_del()                                      check_perm()
    sysfs_remove_dir()           (2)                    kobject_get(->d_fsdata) 
	(->d_fsdata = NULL)
  kobject_put()                  (1)                  
						   sysfs_release()
							kobj == NULL


diff -urN linux-2.6.5-rc2/fs/sysfs/dir.c linux-2.6.5-rc2-race-fix/fs/sysfs/dir.c
--- linux-2.6.5-rc2/fs/sysfs/dir.c	2004-03-20 05:41:05.000000000 +0530
+++ linux-2.6.5-rc2-race-fix/fs/sysfs/dir.c	2004-04-02 09:36:53.174323584 +0530
@@ -132,6 +132,11 @@
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
 
+	/* try to avoid further references to kobject even if dentry
+	 * is alive after remove dir.
+	 */
+	dentry->d_fsdata = NULL;
+
 	spin_lock(&dcache_lock);
 restart:
 	node = dentry->d_subdirs.next;
diff -urN linux-2.6.5-rc2/fs/sysfs/file.c linux-2.6.5-rc2-race-fix/fs/sysfs/file.c
--- linux-2.6.5-rc2/fs/sysfs/file.c	2004-03-20 05:41:01.000000000 +0530
+++ linux-2.6.5-rc2-race-fix/fs/sysfs/file.c	2004-04-02 09:51:37.409899344 +0530
@@ -78,11 +78,22 @@
 static int fill_read_buffer(struct file * file, struct sysfs_buffer * buffer)
 {
 	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct dentry * kobj_dir = file->f_dentry->d_parent;
+	struct kobject * kobj = NULL;
 	struct sysfs_ops * ops = buffer->ops;
 	int ret = 0;
 	ssize_t count;
 
+	down(&kobj_dir->d_inode->i_sem);
+	/* No need to take a ref. on kobject, as it has been taken
+  	 * during ->open(), but ->d_fsdata can become NULL
+	 */
+	if (kobj_dir->d_fsdata)
+		kobj = kobj_dir->d_fsdata;
+	up(&kobj_dir->d_inode->i_sem);
+
+	if (!kobj)
+		return -EINVAL;
 	if (!buffer->page)
 		buffer->page = (char *) get_zeroed_page(GFP_KERNEL);
 	if (!buffer->page)
@@ -199,9 +210,21 @@
 flush_write_buffer(struct file * file, struct sysfs_buffer * buffer, size_t count)
 {
 	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct dentry * kobj_dir = file->f_dentry->d_parent;
+	struct kobject * kobj = NULL;
 	struct sysfs_ops * ops = buffer->ops;
 
+	down(&kobj_dir->d_inode->i_sem);
+	/* No need to take a ref. on kobject, as it has been taken
+  	 * during ->open(), but ->d_fsdata can become NULL
+	 */
+	if (kobj_dir->d_fsdata) 
+		kobj = kobj_dir->d_fsdata;
+	up(&kobj_dir->d_inode->i_sem);
+
+	if (!kobj)
+		return -EINVAL;
+
 	return ops->store(kobj,attr,buffer->page,count);
 }
 
@@ -238,12 +261,18 @@
 
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
+	if (kobj_dir->d_fsdata)
+		kobj = kobject_get(kobj_dir->d_fsdata);
+	up(&kobj_dir->d_inode->i_sem);
+
 	if (!kobj || !attr)
 		goto Einval;
 
@@ -320,10 +349,19 @@
 
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
-	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
+	struct dentry * kobj_dir = file->f_dentry->d_parent;
+	struct kobject * kobj = NULL;
 	struct attribute * attr = filp->f_dentry->d_fsdata;
 	struct sysfs_buffer * buffer = filp->private_data;
 
+	down(&kobj_dir->d_inode->i_sem);
+	/* No need to take a ref. on kobject, as it has been taken
+  	 * during ->open(), but ->d_fsdata can become NULL
+	 */
+	if (kobj_dir->d_fsdata) 
+		kobj = kobj_dir->d_fsdata;
+	up(&kobj_dir->d_inode->i_sem);
+
 	if (kobj) 
 		kobject_put(kobj);
 	module_put(attr->owner);
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
