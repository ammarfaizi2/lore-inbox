Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWEKWsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWEKWsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 18:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWEKWsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 18:48:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:41173 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750819AbWEKWsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 18:48:51 -0400
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
From: Badari Pulavarty <pbadari@us.ibm.com>
To: cel@citi.umich.edu
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <4463B7B0.4000102@citi.umich.edu>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060511114743.53120432.akpm@osdl.org>
	 <1147374464.12421.24.camel@dyn9047017100.beaverton.ibm.com>
	 <20060511132136.569d59c1.akpm@osdl.org> <4463A269.2080601@us.ibm.com>
	 <4463AB55.2010105@citi.umich.edu> <4463B368.9050602@us.ibm.com>
	 <4463B7B0.4000102@citi.umich.edu>
Content-Type: text/plain
Date: Thu, 11 May 2006 15:50:03 -0700
Message-Id: <1147387803.12421.34.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 18:16 -0400, Chuck Lever wrote:
> Badari Pulavarty wrote:
> > 
> > 
> > Chuck Lever wrote:
> > 
> >>
> >> Noticed these four file systems still appear to invoke 
> >> generic_file_read/write:
> >>
> >> 0 fs/sysv/file.c  <global>        25 .write = generic_file_write,
> >> 1 fs/ufs/file.c   <global>        37 .write = generic_file_write,
> >> 2 fs/smbfs/file.c smb_file_write 341 result = generic_file_write(file, 
> >> buf, count, ppos);
> >> 3 fs/udf/file.c   udf_file_write 139 retval = generic_file_write(file, 
> >> buf, count, ppos);
> > 
> > 
> > Hmm ? My 4th patch would get rid of generic_file_read() and 
> > generic_file_write()
> > and all its users. (basically converted to do_sync_read/write).
> > 
> > Where do you see these, after applying all 4 patches ? I can't see them 
> > in my tree.
> 
> Yes, I applied all 4 of the patches you mailed out today to the latest 
> 2.6.17-rc3 git tree.  Could be my mistake... but when I try to build the 
> kernel with UDF enabled, the build fails because it can't find 
> generic_file_read.
> 

Hi Andrew,

Some how I missed updates to few filesystems. Here is the patch to fix
them.

Thanks,
Badari

Missed to convert few filesystems not to use generic_file_read
and generic_file_write interfaces.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

diff -Naurp -X /usr/src/dontdiff linux-2.6.17-rc3/fs/smbfs/file.c linux-2.6.17-rc3.save/fs/smbfs/file.c
--- linux-2.6.17-rc3/fs/smbfs/file.c	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/smbfs/file.c	2006-05-09 15:30:32.000000000 -0700
@@ -233,7 +233,7 @@ smb_file_read(struct file * file, char _
 		(long)dentry->d_inode->i_size,
 		dentry->d_inode->i_flags, dentry->d_inode->i_atime);
 
-	status = generic_file_read(file, buf, count, ppos);
+	status = do_sync_read(file, buf, count, ppos);
 out:
 	return status;
 }
@@ -338,7 +338,7 @@ smb_file_write(struct file *file, const 
 		goto out;
 
 	if (count > 0) {
-		result = generic_file_write(file, buf, count, ppos);
+		result = do_sync_write(file, buf, count, ppos);
 		VERBOSE("pos=%ld, size=%ld, mtime=%ld, atime=%ld\n",
 			(long) file->f_pos, (long) dentry->d_inode->i_size,
 			dentry->d_inode->i_mtime, dentry->d_inode->i_atime);
diff -Naurp -X /usr/src/dontdiff linux-2.6.17-rc3/fs/sysv/file.c linux-2.6.17-rc3.save/fs/sysv/file.c
--- linux-2.6.17-rc3/fs/sysv/file.c	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/sysv/file.c	2006-05-09 15:25:00.000000000 -0700
@@ -21,8 +21,10 @@
  */
 const struct file_operations sysv_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.fsync		= sysv_sync_file,
 	.sendfile	= generic_file_sendfile,
diff -Naurp -X /usr/src/dontdiff linux-2.6.17-rc3/fs/udf/file.c linux-2.6.17-rc3.save/fs/udf/file.c
--- linux-2.6.17-rc3/fs/udf/file.c	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/udf/file.c	2006-05-09 15:27:28.000000000 -0700
@@ -136,7 +136,7 @@ static ssize_t udf_file_write(struct fil
 		}
 	}
 
-	retval = generic_file_write(file, buf, count, ppos);
+	retval = do_sync_write(file, buf, count, ppos);
 
 	if (retval > 0)
 		mark_inode_dirty(inode);
@@ -249,11 +249,13 @@ static int udf_release_file(struct inode
 }
 
 const struct file_operations udf_file_operations = {
-	.read			= generic_file_read,
+	.read			= do_sync_read,
+	.aio_read		= generic_file_aio_read,
 	.ioctl			= udf_ioctl,
 	.open			= generic_file_open,
 	.mmap			= generic_file_mmap,
 	.write			= udf_file_write,
+	.aio_write		= generic_file_aio_write,
 	.release		= udf_release_file,
 	.fsync			= udf_fsync_file,
 	.sendfile		= generic_file_sendfile,
diff -Naurp -X /usr/src/dontdiff linux-2.6.17-rc3/fs/ufs/file.c linux-2.6.17-rc3.save/fs/ufs/file.c
--- linux-2.6.17-rc3/fs/ufs/file.c	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3.save/fs/ufs/file.c	2006-05-09 15:28:16.000000000 -0700
@@ -33,8 +33,10 @@
  
 const struct file_operations ufs_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.aio_read	= generic_file_aio_read,
+	.write		= do_sync_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.open           = generic_file_open,
 	.sendfile	= generic_file_sendfile,



