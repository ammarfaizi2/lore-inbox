Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSKTT15>; Wed, 20 Nov 2002 14:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSKTT14>; Wed, 20 Nov 2002 14:27:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38552 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262780AbSKTT1x>;
	Wed, 20 Nov 2002 14:27:53 -0500
Date: Wed, 20 Nov 2002 13:33:16 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Jens Axboe <axboe@suse.de>
cc: Paul Larson <plars@linuxtestproject.org>,
       lkml <linux-kernel@vger.kernel.org>, <davej@codemonkey.org.uk>
Subject: Re: writing to sysfs appears to hang
In-Reply-To: <20021120191451.GF4925@suse.de>
Message-ID: <Pine.LNX.4.33.0211201326190.1134-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Nov 2002, Jens Axboe wrote:

> On Wed, Nov 20 2002, Paul Larson wrote:
> > On Tue, 2002-11-19 at 11:02, Jens Axboe wrote:
> > > This has been in the deadline-rbtree patches for some time (uses writes
> > > to sysfs, too).
> > > 
> > > ===== fs/sysfs/inode.c 1.59 vs edited =====
> > > --- 1.59/fs/sysfs/inode.c	Wed Oct 30 21:27:35 2002
> > > +++ edited/fs/sysfs/inode.c	Fri Nov  8 14:33:59 2002
> > > @@ -243,7 +243,7 @@
> > >  	if (kobj && kobj->subsys)
> > >  		ops = kobj->subsys->sysfs_ops;
> > >  	if (!ops || !ops->store)
> > > -		return 0;
> > > +		return -EINVAL;
> > >  
> > >  	page = (char *)__get_free_page(GFP_KERNEL);
> > >  	if (!page)
> > 
> > No effect, the behaviour is still the same for me.
> 
> strace the program then, what is happening? What I saw was a program
> seeing write() return 0, assuming it didn't write anything, rewrite the
> whole thing. Repeat.
> 
> I bet this wouldn't happen if just sysfs didn't allow write open of a
> file that doesn't have any writeable bits. Smells like another sysfs
> bug. Pat?

Yes, it is. The attached patch (relative to current BK) should fix it. I'm
planning on sending Linus an update soon, and this is in it.


	-pat


--- linux-2.5-virgin/fs/sysfs/inode.c	Wed Nov 20 12:13:06 2002
+++ linux-2.5-kobject/fs/sysfs/inode.c	Wed Nov 20 12:15:18 2002
@@ -23,6 +23,8 @@
  * Please see Documentation/filesystems/sysfs.txt for more information.
  */
 
+#undef DEBUG 
+
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
@@ -173,17 +175,11 @@
 sysfs_read_file(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
 	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct sysfs_ops * ops = NULL;
-	struct kobject * kobj;
+	struct sysfs_ops * ops = file->private_data;
+	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
 	unsigned char *page;
 	ssize_t retval = 0;
 
-	kobj = file->f_dentry->d_parent->d_fsdata;
-	if (kobj && kobj->subsys)
-		ops = kobj->subsys->sysfs_ops;
-	if (!ops || !ops->show)
-		return 0;
-
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 
@@ -234,16 +230,11 @@
 sysfs_write_file(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
 	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct sysfs_ops * ops = NULL;
-	struct kobject * kobj;
+	struct sysfs_ops * ops = file->private_data;
+	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
 	ssize_t retval = 0;
 	char * page;
 
-	kobj = file->f_dentry->d_parent->d_fsdata;
-	if (kobj && kobj->subsys)
-		ops = kobj->subsys->sysfs_ops;
-	if (!ops || !ops->store)
-		return -EINVAL;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
@@ -275,21 +266,72 @@
 	return retval;
 }
 
-static int sysfs_open_file(struct inode * inode, struct file * filp)
+static int check_perm(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj;
+	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
+	struct attribute * attr = file->f_dentry->d_fsdata;
+	struct sysfs_ops * ops = NULL;
 	int error = 0;
 
-	kobj = filp->f_dentry->d_parent->d_fsdata;
-	if ((kobj = kobject_get(kobj))) {
-		struct attribute * attr = filp->f_dentry->d_fsdata;
-		if (!attr)
-			error = -EINVAL;
-	} else
-		error = -EINVAL;
+	if (!kobj || !attr)
+		goto Einval;
+	
+	if (kobj->subsys)
+		ops = kobj->subsys->sysfs_ops;
+
+	/* No sysfs operations, either from having no subsystem,
+	 * or the subsystem have no operations.
+	 */
+	if (!ops)
+		goto Eaccess;
+
+	/* File needs write support.
+	 * The inode's perms must say it's ok, 
+	 * and we must have a store method.
+	 */
+	if (file->f_mode & FMODE_WRITE) {
+
+		if (!(inode->i_mode & S_IWUGO))
+			goto Eperm;
+		if (!ops->store)
+			goto Eaccess;
+
+	}
+
+	/* File needs read support.
+	 * The inode's perms must say it's ok, and we there
+	 * must be a show method for it.
+	 */
+	if (file->f_mode & FMODE_READ) {
+		if (!(inode->i_mode & S_IRUGO))
+			goto Eperm;
+		if (!ops->show)
+			goto Eaccess;
+	}
+
+	/* No error? Great, store the ops in file->private_data
+	 * for easy access in the read/write functions.
+	 */
+	file->private_data = ops;
+	goto Done;
+
+ Einval:
+	error = -EINVAL;
+	goto Done;
+ Eaccess:
+	error = -EACCES;
+	goto Done;
+ Eperm:
+	error = -EPERM;
+ Done:
 	return error;
 }
 
+static int sysfs_open_file(struct inode * inode, struct file * filp)
+{
+	return check_perm(inode,filp);
+}
+
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
 	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;

