Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSJOSGX>; Tue, 15 Oct 2002 14:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSJOSGX>; Tue, 15 Oct 2002 14:06:23 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:60934 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264859AbSJOSGS>; Tue, 15 Oct 2002 14:06:18 -0400
Date: Tue, 15 Oct 2002 19:12:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10-aa1: unresolved symbol in xfs.o
Message-ID: <20021015191207.A2067@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Christian Guggenberger <christian.guggenberger@physik.uni-regensburg.de>,
	linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20021015172558.A3154@pc9391.uni-regensburg.de> <20021015161908.GC2546@dualathlon.random> <20021015184148.A5026@pc9391.uni-regensburg.de> <20021015171615.GF2546@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015171615.GF2546@dualathlon.random>; from andrea@suse.de on Tue, Oct 15, 2002 at 07:16:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 07:16:15PM +0200, Andrea Arcangeli wrote:
> On Tue, Oct 15, 2002 at 06:41:48PM +0200, Christian Guggenberger wrote:
> > On 15 Oct 2002 18:19:08 Andrea Arcangeli wrote:
> > >On Tue, Oct 15, 2002 at 05:25:58PM +0200, Christian Guggenberger wrote:
> > >> Hi Andrea,
> > >>
> > >> I'm trying to compile 2.4.20-pre10aa1 with xfs enabled as module.
> > >> make modules_install ends up in:
> > >>
> > >> depmod: *** Unresolved symbols in
> > >> /lib/modules/2.4.20-pre10aa1/kernel/fs/xfs/xfs.o
> > >> depmod: 	do_generic_file_write
> > >>
> > >> what to do?
> > >
> > >I logged it so it will be fixed. You can link it into the kernel in the
> > >meantime (select Y instead of M). For some reason bleeding edge gcc from
> > >CVS generates a flood of symbol errors when I run depmod before
> > >rebooting, so I don't easily notice these missing exports anymore (I
> > >should run depmod post reboot to notice them). thanks,
> > 
> > nope, static linking ends up in an error, too.
> > 
> > fs/fs.o: In function `xfs_write':
> > fs/fs.o(.text+0xa1158): undefined reference to `do_generic_file_write'
> > make: *** [vmlinux] Error 1
> 
> do_generic_file_write is missing, one patch is probably missing, I will
> fix it in a few days, the last usable xfs was probably in 2.4.20pre5aa1.

No.  you removed that patch in your last release because marcelo
merged a part of it..

Still required part of 00_o_direct-read-overflow-write-locking-xfs-1
below:

diff -urNp 2.4.19rc1/include/linux/fs.h odirect/include/linux/fs.h
--- 2.4.19rc1/include/linux/fs.h	Tue Jun 25 23:56:21 2002
+++ odirect/include/linux/fs.h	Wed Jun 26 17:42:48 2002
@@ -1434,6 +1434,7 @@ extern int generic_file_mmap(struct file
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
+extern ssize_t do_generic_file_write(struct file *, const char *, size_t, loff_t *);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
diff -urNp 2.4.19rc1/mm/filemap.c odirect/mm/filemap.c
--- 2.4.19rc1/mm/filemap.c	Tue Jun 25 23:56:23 2002
+++ odirect/mm/filemap.c	Wed Jun 26 17:42:50 2002
@@ -2914,7 +2917,7 @@ inline void remove_suid(struct inode *in
  *							okir@monad.swb.de
  */
 ssize_t
-generic_file_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
+do_generic_file_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
 {
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	struct inode	*inode = mapping->host;
@@ -2926,16 +2929,8 @@ generic_file_write(struct file *file,con
 	int		err;
 	unsigned	bytes;
 
-	if ((ssize_t) count < 0)
-		return -EINVAL;
-
-	if (!access_ok(VERIFY_READ, buf, count))
-		return -EFAULT;
-
 	cached_page = NULL;
 
-	down(&inode->i_sem);
-
 	pos = *ppos;
 	err = -EINVAL;
 	if (pos < 0)
@@ -3114,7 +3109,6 @@ out_status:	
 	err = written ? written : status;
 out:
 
-	up(&inode->i_sem);
 	return err;
 fail_write:
 	status = -EFAULT;
@@ -3141,7 +3135,6 @@ o_direct:
 			mark_inode_dirty(inode);
 		}
 		*ppos = end;
-		invalidate_inode_pages2(mapping);
 	}
 	/*
 	 * Sync the fs metadata but not the minor inode changes and
@@ -3152,6 +3145,30 @@ o_direct:
 	goto out_status;
 }
 
+EXPORT_SYMBOL(do_generic_file_write);
+
+ssize_t
+generic_file_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
+{
+	struct inode	*inode = file->f_dentry->d_inode->i_mapping->host;
+	int		err;
+
+	if ((ssize_t) count < 0)
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
+
+	down(&inode->i_sem);
+	err = do_generic_file_write(file, buf, count, ppos);
+
+	if ((err > 0) && (file->f_flags & O_DIRECT))
+		invalidate_inode_pages2(file->f_dentry->d_inode->i_mapping);
+	up(&inode->i_sem);
+
+	return err;
+}
+
 void __init page_cache_init(unsigned long mempages)
 {
 	unsigned long htable_size, order;
