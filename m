Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUDNNQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264214AbUDNNQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:16:11 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2541 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264212AbUDNNP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:15:59 -0400
Date: Wed, 14 Apr 2004 18:50:15 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-ID: <20040414132015.GD5422@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040402043814.GA6993@in.ibm.com> <Pine.LNX.4.44L0.0404021629210.889-100000@ida.rowland.org> <20040406101320.GB1270@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406101320.GB1270@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 03:43:20PM +0530, Maneesh Soni wrote:
[..] 
> 
> o The following patch fixes the race involved between unregistering a kobject 
>   and simultaneously opeing a corresponding attribute file in sysfs. 
> 
>   Ideally sysfs should take a ref. to the kobject as long as it has dentries 
>   referring to the kobject, but because of current limitations in 
>   module/kobject ref counting, sysfs's  pinning of kobject leads to 
>   hang/delays in rmmod of certain modules. The patch uses a new flag to mark
>   dentries as disconnected from a valid kobject in the process of unregistering
>   the kobject. The ->open in sysfs is failed if it finds a disconnected dentry.
>   Marking and checking for the flag is done under dentry->d_inode->i_sem.
> 
[..]


Hi Greg / Andrew,
                                                                                
This problem can be solved without using the d_flags as I did previously. 
Viro suggested to just check for DCACHE_UNHASHED in check_perm() and this also 
solves the race. Please see the following patch instead of the previous one.


Thanks
Maneesh

PS: As you might have seen sysfs-symlinks-fix.patch the sysfs_get_kobject() is 
    repeated in this patch also. So, once you have decided about the 
    sysfs-syminks-fix.patch and this one, I can re-submit a combined one.

----------------------------------------------------------------------------

o The following patch fixes the race involved between unregistering a kobject 
  and simultaneously opeing a corresponding attribute file in sysfs. 

o Ideally sysfs should take a ref. to the kobject as long as it has dentries 
  referring to the kobjects, but because of current limitations in 
  module/kobject ref counting, sysfs's  pinning of kobject leads to 
  hang/delays in rmmod of certain modules. The patch checks for unhashed 
  dentries in check_perm() while opening a sysfs file. If the dentry is 
  still hashed then it goes ahead and takes the ref to kobject. This done
  under the per dentry lock. It does this in the inline routine 
  sysfs_get_kobject(dentry).


 fs/sysfs/bin.c   |    2 +-
 fs/sysfs/file.c  |    2 +-
 fs/sysfs/sysfs.h |   13 +++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff -puN fs/sysfs/sysfs.h~sysfs-d_fsdata-race-fix-2 fs/sysfs/sysfs.h
--- linux-2.6.5-mm5/fs/sysfs/sysfs.h~sysfs-d_fsdata-race-fix-2	2004-04-14 14:55:26.000000000 +0530
+++ linux-2.6.5-mm5-maneesh/fs/sysfs/sysfs.h	2004-04-14 15:29:51.000000000 +0530
@@ -11,3 +11,16 @@ extern void sysfs_hash_and_remove(struct
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
+
+
+static inline struct kobject * sysfs_get_kobject(struct dentry * dentry)
+{
+	struct kobject * kobj = NULL;
+
+	spin_lock(&dentry->d_lock);
+	if (!d_unhashed(dentry))
+		kobj = kobject_get(dentry->d_fsdata);
+	spin_unlock(&dentry->d_lock);
+
+	return kobj;
+}
diff -puN fs/sysfs/file.c~sysfs-d_fsdata-race-fix-2 fs/sysfs/file.c
--- linux-2.6.5-mm5/fs/sysfs/file.c~sysfs-d_fsdata-race-fix-2	2004-04-14 14:55:30.000000000 +0530
+++ linux-2.6.5-mm5-maneesh/fs/sysfs/file.c	2004-04-14 14:56:17.000000000 +0530
@@ -238,7 +238,7 @@ sysfs_write_file(struct file *file, cons
 
 static int check_perm(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
+	struct kobject * kobj = sysfs_get_kobject(file->f_dentry->d_parent);
 	struct attribute * attr = file->f_dentry->d_fsdata;
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
diff -puN fs/sysfs/bin.c~sysfs-d_fsdata-race-fix-2 fs/sysfs/bin.c
--- linux-2.6.5-mm5/fs/sysfs/bin.c~sysfs-d_fsdata-race-fix-2	2004-04-14 14:55:32.000000000 +0530
+++ linux-2.6.5-mm5-maneesh/fs/sysfs/bin.c	2004-04-14 14:56:17.000000000 +0530
@@ -94,7 +94,7 @@ static ssize_t write(struct file * file,
 
 static int open(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
+	struct kobject * kobj = sysfs_get_kobject(file->f_dentry->d_parent);
 	struct bin_attribute * attr = file->f_dentry->d_fsdata;
 	int error = -EINVAL;
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
