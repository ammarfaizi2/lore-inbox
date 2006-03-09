Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWCIDBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWCIDBH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWCIDBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:01:06 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:20178 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1160999AbWCIDBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:01:05 -0500
Date: Thu, 9 Mar 2006 08:28:24 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: problem with duplicate sysfs directories and files
Message-ID: <20060309025824.GA4483@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20060308075342.GA17718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308075342.GA17718@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 11:53:42PM -0800, Greg KH wrote:
> Hi,
> 
> I spent some time tonight trying to track down how to fix the issue of
> duplicate sysfs files and/or directories.  This happens when you try to
> create a kobject with the same name in the same directory.  The creation
> of the second kobject will fail, but the directory will remain in sysfs.
> 

Let me understand this. Lets say we have sysfs directory tree like 
	/sys/a/b/c
and someone is trying to create one more kobject with name "c" for the
parent kobject "b" ? 

And are you saying that though the new creation fails but the existing
directory remains in sysfs? I think failing the new creation and leaving
the exisiting directoy is ok. But there is sysfs_dirent leakage which 
does need fixing.

> Now I know this isn't a normal operation, but it would be good to fix
> this eventually.  I traced the issue down to fs/sysfs/dir.c:create_dir()
> and the check for:
> 	if (error && (error != -EEXIST)) {
> 
> Problem is, error is set to -EEXIST, so we don't clean up properly.  Now
> I know we can't just not check for this, as if you do that error
> cleanup, the original kobject's sysfs entry gets very messed up (ls -l
> does not like it at all...)
> 
> But I can't seem to figure out what exactly we need to do to clean up
> properly here.
> 
> Do you, or anyone else, have any pointers or ideas?
> 

If you are talking about the example above, to me it appears that except
a possible sysfs_dirent leakage, we are some what ok, else there would have 
been more catastrophic results because of the duplicate directory dentry/inode.

As per the current code 

static int create_dir(struct kobject * k, struct dentry * p,
                      const char * n, struct dentry ** d)
{
        int error;
        umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;

        mutex_lock(&p->d_inode->i_mutex);

        *d = lookup_one_len(n, p, strlen(n));

^^^^ lookup_one_len() will return the existing dentry corresponding to
     the last component "c" in "/sys/a/b/c" without any error. Just note
     that VFS is not going to allocate a new dentry for it. The existing
     dentry's ref count will be increased by one.

        if (!IS_ERR(*d)) {
                error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);

^^^^ we do have problem here, a new sysfs_dirent is allocated which
     replaces the existing dentry->d_fsdata and yuk... the old sysfs_dirent
     is no more linked with the existing directory, there by leaking 
     one sysfs_dirent.


Not only for sysfs_create_dir(), I think the problem of existing sysfs_dirent
is also there with sysfs_add_file() and sysfs_add_link(). I am working on a 
patch to plug this leak.

Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-51776416





o Following patch checks for existing sysfs_dirent before allocation new one.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.16-rc5-git10-maneesh/fs/sysfs/dir.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

diff -puN fs/sysfs/dir.c~sysfs-check-existing-dirent fs/sysfs/dir.c
--- linux-2.6.16-rc5-git10/fs/sysfs/dir.c~sysfs-check-existing-dirent	2006-03-08 17:50:00.857712216 +0530
+++ linux-2.6.16-rc5-git10-maneesh/fs/sysfs/dir.c	2006-03-08 17:50:00.864711152 +0530
@@ -50,11 +50,28 @@ static struct sysfs_dirent * sysfs_new_d
 	return sd;
 }
 
+/**
+ * Initialise a newly allocated sysfs_dirent and attach it to
+ * the corresponding dentry if present.
+ *
+ * Return -EEXIST if there is already a sysfs element with the same name for
+ * the same parent.
+ *
+ * called with parent inode's i_mutex held
+ */
 int sysfs_make_dirent(struct sysfs_dirent * parent_sd, struct dentry * dentry,
 			void * element, umode_t mode, int type)
 {
 	struct sysfs_dirent * sd;
 
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		const unsigned char * existing = sysfs_get_name(sd);
+		if (strcmp(existing, new))
+			continue;
+		else
+			return -EEXIST;
+	}
+
 	sd = sysfs_new_dirent(parent_sd, element);
 	if (!sd)
 		return -ENOMEM;
_
