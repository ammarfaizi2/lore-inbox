Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSGDHYC>; Thu, 4 Jul 2002 03:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317353AbSGDHYB>; Thu, 4 Jul 2002 03:24:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56047 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317352AbSGDHYA>;
	Thu, 4 Jul 2002 03:24:00 -0400
Message-ID: <3D23F88C.2050502@us.ibm.com>
Date: Thu, 04 Jul 2002 00:26:04 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from driverfs
References: <3D23EA93.7090106@us.ibm.com> <20020704071004.GI29657@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------060206050606050400050208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060206050606050400050208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Wed, Jul 03, 2002 at 11:26:27PM -0700, Dave Hansen wrote:
>>I saw your talk about driverfs at OLS and it got my attention.  When 
>>my BKL debugging patch showed some use of the BKL in driverfs, I was 
>>very dissapointed (you can blame Greg if you want).
> 
> Blame me?  Al Viro pushed that BKL into the file, not I :)

But you're so much closer :)  Did he push the mknod stuff too?

>>text from dmesg after BKL debugging patch:
>>release of recursive BKL hold, depth: 1
>>[ 0]main:492
>>[ 1]inode:149
> 
> This means what?

BKL was acquired at main.c:492 and current->lock_depth was 0
then
BKL was acquired at inode.c:149 and current->lock_depth was 1

>>I see no reason to hold the BKL in your situation.  I replaced it with 
>>i_sem in some places and just plain removed it in others.  I believe 
>>that you get all of the protection that you need from dcache_lock in 
>>the dentry insert and activate.  Can you prove me wrong?
> 
> I see no reason to really care :)
> Can you prove that driverfs (or pcihpfs or usbfs) accesses are on a
> critical path that removing the BKL usage here actually helps?

Nope.  I'm pretty sure that it isn't in a critical path anywhere, nor 
are there any performance benefits.  It is simply an annoying use that 
is relatively easy to remove.  It's kinda like using spaces instead of 
tabs; most people won't notice, but some people really care :)

> I think that driverfs_mknod() needs some kind of protection now that you
> have removed it.

Do you just want to make sure it isn't called concurrently, or is 
there some other BKL-protected area that you're concerned about. 
driverfs_mknod() doesn't appear to be doing anything sneaky like 
sleeping or calling itself, so I think a simple spinlock will work 
just fine.

> Um, you used spaces, please use tabs like the rest of the file, and how
> Documentation/CodingStyle mandates.

Arg.  I saw your talk twice so I really don't have an excuse.  fix 
attached.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------060206050606050400050208
Content-Type: text/plain;
 name="driverfs-bkl_remove-2.5.24-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driverfs-bkl_remove-2.5.24-1.patch"

--- linux-2.5.24-clean/fs/driverfs/inode.c	Thu Jun 20 15:53:45 2002
+++ linux/fs/driverfs/inode.c	Thu Jul  4 00:22:54 2002
@@ -128,6 +128,7 @@
 	return inode;
 }
 
+static spinlock_t driverfs_mknod_lock = SPIN_LOCK_UNLOCKED;
 static int driverfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
 {
 	struct inode *inode = driverfs_get_inode(dir->i_sb, mode, dev);
@@ -146,20 +147,20 @@
 static int driverfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int res;
-	lock_kernel();
 	dentry->d_op = &driverfs_dentry_dir_ops;
+	spin_lock(&driverfs_mknod_lock);
  	res = driverfs_mknod(dir, dentry, mode | S_IFDIR, 0);
-	unlock_kernel();
+	spin_unlock(&driverfs_mknod_lock);
 	return res;
 }
 
 static int driverfs_create(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int res;
-	lock_kernel();
 	dentry->d_op = &driverfs_dentry_file_ops;
+	spin_lock(&driverfs_mknod_lock);
  	res = driverfs_mknod(dir, dentry, mode | S_IFREG, 0);
-	unlock_kernel();
+	spin_unlock(&driverfs_mknod_lock);
 	return res;
 }
 
@@ -211,9 +212,9 @@
 	if (driverfs_empty(dentry)) {
 		struct inode *inode = dentry->d_inode;
 
-		lock_kernel();
+		down(&inode->i_sem);
 		inode->i_nlink--;
-		unlock_kernel();
+		up(&inode->i_sem);
 		dput(dentry);
 		error = 0;
 	}
@@ -353,8 +354,9 @@
 driverfs_file_lseek(struct file *file, loff_t offset, int orig)
 {
 	loff_t retval = -EINVAL;
+        struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	lock_kernel();
+	down(&inode->i_sem);	
 	switch(orig) {
 	case 0:
 		if (offset > 0) {
@@ -371,7 +373,7 @@
 	default:
 		break;
 	}
-	unlock_kernel();
+	up(&inode->i_sem);
 	return retval;
 }
 

--------------060206050606050400050208--

