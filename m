Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274294AbRITBhS>; Wed, 19 Sep 2001 21:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274295AbRITBhJ>; Wed, 19 Sep 2001 21:37:09 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:64138 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S274294AbRITBgz>; Wed, 19 Sep 2001 21:36:55 -0400
Date: Wed, 19 Sep 2001 21:37:14 -0400
To: sujal@sujal.net
Cc: codalist@TELEMANN.coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: [PATCH] Re: Coda and Ext3
Message-ID: <20010919213713.D8947@cs.cmu.edu>
Mail-Followup-To: sujal@sujal.net, codalist@coda.cs.cmu.edu,
	linux-kernel@vger.kernel.org, ext3-users@redhat.com
In-Reply-To: <3B9792FB.7020708@progress.com> <20010906115302.B826@cs.cmu.edu> <1000909441.2017.20.camel@pcsshah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1000909441.2017.20.camel@pcsshah>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 10:23:36AM -0400, Sujal Shah wrote:
>      The Linux Coda drivers and the ext3 patches don't seem to get along
> very well, at least in Linux 2.4.7.  I've got a stock 2.4.7 kernel with

The attached patch should fix it. I haven't tested it against ext3, but
with tmpfs which used to have the same problem, i.e. not using
generic_file_ functions to access the container files. I'll pass it on
to Linus and Alan once I get some feedback on whether this solves all
problems. I believe this will fix the whole batch of problems that are
have been reported with ext3fs, XFS, and tmpfs.

It should apply fine for kernel versions 2.4.4 and higher (both the AC
and the Linus trees).

btw. my comment about disabling ext3 data journalling fixing it was
bogus, there was a BUG() in Coda that got triggered because f_op->write
wasn't generic_file_write.

Jan

diff -urN --exclude-from=dontdiff linux-2.4.10-pre9/fs/coda/file.c linux/fs/coda/file.c
--- linux-2.4.10-pre9/fs/coda/file.c	Thu Sep  6 20:02:24 2001
+++ linux/fs/coda/file.c	Wed Sep 19 20:26:41 2001
@@ -31,28 +31,65 @@
 int use_coda_close;
 
 static ssize_t
-coda_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
+coda_file_read(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
+	struct inode *inode = file->f_dentry->d_inode;
+	struct coda_inode_info *cii = ITOC(inode);
 	struct file *cfile;
+
+	cfile = cii->c_container;
+	if (!cfile) BUG();
+
+	if (!cfile->f_op || !cfile->f_op->read)
+		return -EINVAL;
+
+	return cfile->f_op->read(cfile, buf, count, ppos);
+}
+
+static ssize_t
+coda_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
+{
 	struct inode *cinode, *inode = file->f_dentry->d_inode;
 	struct coda_inode_info *cii = ITOC(inode);
-	ssize_t n;
+	struct file *cfile;
+	ssize_t ret;
+	int flags;
 
 	cfile = cii->c_container;
 	if (!cfile) BUG();
 
-	if (!cfile->f_op || cfile->f_op->write != generic_file_write)
-		BUG();
+	if (!cfile->f_op || !cfile->f_op->write)
+		return -EINVAL;
 
 	cinode = cfile->f_dentry->d_inode;
-	down(&cinode->i_sem);
+	down(&inode->i_sem);
+	flags = cfile->f_flags;
+        cfile->f_flags |= file->f_flags & (O_APPEND | O_SYNC);
+
+	ret = cfile->f_op->write(cfile, buf, count, ppos);
 
-	n = generic_file_write(file, buf, count, ppos);
+	cfile->f_flags = flags;
 	inode->i_size = cinode->i_size;
+	up(&inode->i_sem);
+
+	return ret;
+}
+
+static int
+coda_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct coda_inode_info *cii = ITOC(inode);
+	struct file *cfile;
+
+	cfile = cii->c_container;
+
+	if (!cfile) BUG();
 
-	up(&cinode->i_sem);
+	if (!cfile->f_op || !cfile->f_op->mmap)
+		return -ENODEV;
 
-	return n;
+	return cfile->f_op->mmap(cfile, vma);
 }
 
 int coda_open(struct inode *i, struct file *f)
@@ -237,9 +274,9 @@
 
 struct file_operations coda_file_operations = {
 	llseek:		generic_file_llseek,
-	read:		generic_file_read,
+	read:		coda_file_read,
 	write:		coda_file_write,
-	mmap:		generic_file_mmap,
+	mmap:		coda_file_mmap,
 	open:		coda_open,
 	flush:  	coda_flush,
 	release:	coda_release,
diff -urN --exclude-from=dontdiff linux-2.4.10-pre9/fs/coda/psdev.c linux/fs/coda/psdev.c
--- linux-2.4.10-pre9/fs/coda/psdev.c	Wed Apr 25 19:18:54 2001
+++ linux/fs/coda/psdev.c	Wed Sep 19 18:45:46 2001
@@ -414,7 +414,7 @@
 static int __init init_coda(void)
 {
 	int status;
-	printk(KERN_INFO "Coda Kernel/Venus communications, v5.3.14, coda@cs.cmu.edu\n");
+	printk(KERN_INFO "Coda Kernel/Venus communications, v5.3.15, coda@cs.cmu.edu\n");
 
 	status = init_coda_psdev();
 	if ( status ) {
