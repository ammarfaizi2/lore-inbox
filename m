Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291352AbSAaV7o>; Thu, 31 Jan 2002 16:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291353AbSAaV71>; Thu, 31 Jan 2002 16:59:27 -0500
Received: from zero.tech9.net ([209.61.188.187]:56076 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291352AbSAaV6T>;
	Thu, 31 Jan 2002 16:58:19 -0500
Subject: Re: [PATCH] 2.5: further llseek cleanup (1/3)
From: Robert Love <rml@tech9.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201311649460.17860-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201311649460.17860-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 31 Jan 2002 17:04:23 -0500
Message-Id: <1012514664.3213.186.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-31 at 16:51, Alexander Viro wrote:
>
> On 31 Jan 2002, Robert Love wrote:
> > I'd be happy to keep Coda using the new generic_file_llseek if Al Viro
> > agrees with you.  Al?
> 
> I'm OK with that.

OK, updated patch in my ftp as well as attached below.

Linus, this patch supersedes the previous patch #1.  2 and 3 are
separate and up for inclusion.

	Robert Love

diff -urN linux-2.5.3/fs/ncpfs/file.c linux/fs/ncpfs/file.c
--- linux-2.5.3/fs/ncpfs/file.c	Thu Jan 31 01:08:54 2002
+++ linux/fs/ncpfs/file.c	Thu Jan 31 01:09:47 2002
@@ -281,7 +281,7 @@
 
 struct file_operations ncp_file_operations =
 {
-	llseek:		generic_file_llseek,
+	llseek:		remote_llseek,
 	read:		ncp_file_read,
 	write:		ncp_file_write,
 	ioctl:		ncp_ioctl,
diff -urN linux-2.5.3/fs/nfs/file.c linux/fs/nfs/file.c
--- linux-2.5.3/fs/nfs/file.c	Thu Jan 31 01:08:54 2002
+++ linux/fs/nfs/file.c	Thu Jan 31 01:09:47 2002
@@ -41,7 +41,7 @@
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
 
 struct file_operations nfs_file_operations = {
-	llseek:		generic_file_llseek,
+	llseek:		remote_llseek,
 	read:		nfs_file_read,
 	write:		nfs_file_write,
 	mmap:		nfs_file_mmap,
diff -urN linux-2.5.3/fs/read_write.c linux/fs/read_write.c
--- linux-2.5.3/fs/read_write.c	Thu Jan 31 01:08:54 2002
+++ linux/fs/read_write.c	Thu Jan 31 01:12:09 2002
@@ -51,6 +51,31 @@
 	return retval;
 }
 
+loff_t remote_llseek(struct file *file, loff_t offset, int origin)
+{
+	long long retval;
+
+	lock_kernel();
+	switch (origin) {
+		case 2:
+			offset += file->f_dentry->d_inode->i_size;
+			break;
+		case 1:
+			offset += file->f_pos;
+	}
+	retval = -EINVAL;
+	if (offset>=0 && offset<=file->f_dentry->d_inode->i_sb->s_maxbytes) {
+		if (offset != file->f_pos) {
+			file->f_pos = offset;
+			file->f_reada = 0;
+			file->f_version = ++event;
+		}
+		retval = offset;
+	}
+	unlock_kernel();
+	return retval;
+}
+
 loff_t no_llseek(struct file *file, loff_t offset, int origin)
 {
 	return -ESPIPE;
diff -urN linux-2.5.3/fs/smbfs/file.c linux/fs/smbfs/file.c
--- linux-2.5.3/fs/smbfs/file.c	Thu Jan 31 01:08:54 2002
+++ linux/fs/smbfs/file.c	Thu Jan 31 01:09:47 2002
@@ -381,7 +381,7 @@
 
 struct file_operations smb_file_operations =
 {
-	llseek:		generic_file_llseek,
+	llseek:		remote_llseek,
 	read:		smb_file_read,
 	write:		smb_file_write,
 	ioctl:		smb_ioctl,
diff -urN linux-2.5.3/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.3/include/linux/fs.h	Thu Jan 31 01:08:54 2002
+++ linux/include/linux/fs.h	Thu Jan 31 01:10:37 2002
@@ -1449,6 +1449,7 @@
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
+extern loff_t remote_llseek(struct file *file, loff_t offset, int origin);
 extern ssize_t generic_read_dir(struct file *, char *, size_t, loff_t *);
 extern int generic_file_open(struct inode * inode, struct file * filp);
 
diff -urN linux-2.5.3/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.3/kernel/ksyms.c	Thu Jan 31 01:08:54 2002
+++ linux/kernel/ksyms.c	Thu Jan 31 01:10:06 2002
@@ -251,6 +251,7 @@
 EXPORT_SYMBOL(vfs_statfs);
 EXPORT_SYMBOL(generic_read_dir);
 EXPORT_SYMBOL(generic_file_llseek);
+EXPORT_SYMBOL(remote_llseek);
 EXPORT_SYMBOL(no_llseek);
 EXPORT_SYMBOL(__pollwait);
 EXPORT_SYMBOL(poll_freewait);

