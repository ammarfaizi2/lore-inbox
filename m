Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290490AbSBGRdY>; Thu, 7 Feb 2002 12:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290615AbSBGRdS>; Thu, 7 Feb 2002 12:33:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:36298 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290490AbSBGRdE>; Thu, 7 Feb 2002 12:33:04 -0500
From: Janet Morgan <janetmor@us.ibm.com>
Message-Id: <200202071732.g17HWsw19233@eng4.beaverton.ibm.com>
Subject: [RFC] [PATCH] vectored raw io performance improvement
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Feb 2002 09:32:53 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below improves the performance of vectored raw I/O by combining 
the iovecs passed by a readv/writev call into a single kiobuf and issuing 
one call to brw_kiovec to submit the io.  Without this patch, the readv/writev 
system calls (effectively) serially invoke the read/write system calls for 
each iovec.

With the patch applied, raw readv/writev approximates the speed of a 
read/write for the aggregate iov_len's (rather than vectored I/O running
2 or 3 times slower).  In preliminary DB2 testing, the time for a single 
tablescan was reduced from 621 seconds to 172 seconds with the patch applied.   

Comments are most welcome,

-Janet
janetmor@us.ibm.com
P.S. The patch can also be downloaded from https://sourceforge.net/projects/lse/io. 


--- 2417orig/linux/include/linux/iobuf.h	Thu Nov 22 11:46:26 2001
+++ 2417vio/linux/include/linux/iobuf.h	Tue Jan 29 15:38:12 2002
@@ -28,6 +28,12 @@
 #define KIO_STATIC_PAGES	(KIO_MAX_ATOMIC_IO / (PAGE_SIZE >> 10) + 1)
 #define KIO_MAX_SECTORS		(KIO_MAX_ATOMIC_IO * 2)
 
+struct pinfo
+{
+        int poffset[KIO_STATIC_PAGES];
+        int plen[KIO_STATIC_PAGES];
+};
+
 /* The main kiobuf struct used for all our IO! */
 
 struct kiobuf 
@@ -56,6 +62,7 @@
 	int		errno;		/* Status of completed IO */
 	void		(*end_io) (struct kiobuf *); /* Completion callback */
 	wait_queue_head_t wait_queue;
+	struct pinfo * 	pinfo;
 };
 
 
--- 2417orig/linux/include/linux/fs.h	Fri Dec 21 09:42:03 2001
+++ 2417vio/linux/include/linux/fs.h	Tue Jan 29 15:37:37 2002
@@ -828,8 +828,8 @@
 	int (*fsync) (struct file *, struct dentry *, int datasync);
 	int (*fasync) (int, struct file *, int);
 	int (*lock) (struct file *, int, struct file_lock *);
-	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long, loff_t *);
-	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long, loff_t *);
+	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long, loff_t *, size_t);
+	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long, loff_t *, size_t);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 };
--- 2417orig/linux/fs/iobuf.c	Fri Apr 27 14:23:25 2001
+++ 2417vio/linux/fs/iobuf.c	Wed Jan 30 16:25:59 2002
@@ -100,6 +100,8 @@
 	
 	if (iobuf->array_len >= wanted)
 		return 0;
+
+        if (iobuf->pinfo) BUG();
 	
 	maplist = (struct page **) 
 		kmalloc(wanted * sizeof(struct page **), GFP_KERNEL);
--- 2417orig/linux/fs/read_write.c	Sun Aug  5 13:12:41 2001
+++ 2417vio/linux/fs/read_write.c	Tue Jan 29 11:54:36 2002
@@ -203,7 +203,7 @@
 			       unsigned long count)
 {
 	typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
-	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
+	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *, size_t);
 
 	size_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
@@ -258,8 +258,9 @@
 
 	fnv = (type == VERIFY_WRITE ? file->f_op->readv : file->f_op->writev);
 	if (fnv) {
-		ret = fnv(file, iov, count, &file->f_pos);
-		goto out;
+		ret = fnv(file, iov, count, &file->f_pos, tot_len);
+		if (ret != -ENOSYS)
+			goto out;
 	}
 
 	/* VERIFY_WRITE actually means a read, as we write to user space */
--- 2417orig/linux/net/socket.c	Fri Dec 21 09:42:06 2001
+++ 2417vio/linux/net/socket.c	Tue Jan 29 17:21:42 2002
@@ -100,7 +100,7 @@
 		      unsigned int cmd, unsigned long arg);
 static int sock_fasync(int fd, struct file *filp, int on);
 static ssize_t sock_readv(struct file *file, const struct iovec *vector,
-			  unsigned long count, loff_t *ppos);
+			  unsigned long count, loff_t *ppos, size_t tot_len);
 static ssize_t sock_writev(struct file *file, const struct iovec *vector,
 			  unsigned long count, loff_t *ppos);
 static ssize_t sock_sendpage(struct file *file, struct page *page,
@@ -648,12 +648,8 @@
 }
 
 static ssize_t sock_readv(struct file *file, const struct iovec *vector,
-			  unsigned long count, loff_t *ppos)
+			  unsigned long count, loff_t *ppos, size_t tot_len)
 {
-	size_t tot_len = 0;
-	int i;
-        for (i = 0 ; i < count ; i++)
-                tot_len += vector[i].iov_len;
 	return sock_readv_writev(VERIFY_WRITE, file->f_dentry->d_inode,
 				 file, vector, count, tot_len);
 }
--- 2417orig/linux/mm/memory.c	Fri Dec 21 09:42:05 2001
+++ 2417vio/linux/mm/memory.c	Wed Jan 30 14:28:06 2002
@@ -551,6 +551,73 @@
 	return 0;
 }
 
+int map_user_kiobuf_iovecs(int rw, struct kiobuf *iobuf, struct iovec *iov, int iov_count)
+{
+ 	int i, j;
+ 	int pgcount, err, iovpages;
+ 	struct mm_struct *	mm;
+ 	ulong va;
+ 	size_t len, plen;
+ 	int offset;
+ 	
+ 	/* Make sure the iobuf is not already mapped somewhere. */
+ 	if (iobuf->nr_pages)
+ 		return -EINVAL;
+ 
+ 	mm = current->mm;
+ 	dprintk ("map_user_kiobuf_iovecs: begin\n");
+ 	
+ 	iobuf->locked = 0;
+ 	iobuf->length = 0;
+        for (i=0, pgcount=0; i<iov_count; i++) {
+         	va = iov[i].iov_base;
+ 		offset = va & ~PAGE_MASK;
+         	len = iov[i].iov_len;
+        	iobuf->length += len;
+
+ 		iovpages = (va + len + PAGE_SIZE - 1)/PAGE_SIZE - va/PAGE_SIZE;
+  
+ 		/* Try to fault in all of the necessary pages */
+ 		down_read(&mm->mmap_sem);
+ 		/* rw==READ means read from disk, write into memory area */
+ 		err = get_user_pages(current, mm, va, iovpages,
+ 		   (rw==READ), 0, &iobuf->maplist[pgcount], NULL);
+ 		up_read(&mm->mmap_sem);
+ 
+ 		if (err < 0) {
+ 			iobuf->nr_pages = pgcount;
+ 			unmap_kiobuf(iobuf);
+ 			dprintk ("map_user_kiobuf_iovecs: end %d\n", err);
+ 			return err;
+ 		}
+
+ 		for (j=pgcount; j<pgcount+iovpages; j++) {
+                 	iobuf->pinfo->poffset[j] = offset;
+                 	plen = PAGE_SIZE - offset;
+                 	if (plen > len) {
+                         	iobuf->pinfo->plen[j] = len;
+ 	                } else {
+                         	iobuf->pinfo->plen[j] = plen;
+                         	len -= plen;
+                 	}
+                 	offset = 0;
+ 		}
+ 		pgcount += iovpages;
+ 	}
+
+ 	if ( (!pgcount)||(pgcount > KIO_STATIC_PAGES) )
+		BUG();
+ 	iobuf->nr_pages = pgcount;
+ 	while (pgcount--) {
+ 		/* FIXME: flush superflous for rw==READ,
+ 		 * probably wrong function for rw==WRITE
+ 		 */
+ 		flush_dcache_page(iobuf->maplist[pgcount]);
+ 	}
+ 	dprintk ("map_user_kiobuf_iovecs: end OK\n");
+ 	return 0;
+}
+ 
 /*
  * Mark all of the pages in a kiobuf as dirty 
  *
@@ -581,6 +648,28 @@
 		offset = 0;
 		index++;
 	}
+}
+
+void mark_dirty_kiobuf_iovec(struct kiobuf *iobuf, int bytes)
+{
+ 	int index, remaining, plen;
+ 	struct page *page;
+ 	
+ 	index = 0;
+ 	remaining = bytes;
+ 	if (remaining > iobuf->length)
+ 		remaining = iobuf->length;
+ 	
+ 	while (remaining > 0 && index < iobuf->nr_pages) {
+ 		page = iobuf->maplist[index];
+ 	 	plen = iobuf->pinfo->plen[index];	
+ 		
+ 		if (!PageReserved(page))
+ 			SetPageDirty(page);
+ 
+ 		remaining -= plen;
+ 		index++;
+ 	}
 }
 
 /*
--- 2417orig/linux/fs/buffer.c	Fri Dec 21 09:41:55 2001
+++ 2417vio/linux/fs/buffer.c	Tue Jan 29 11:54:36 2002
@@ -2152,6 +2152,11 @@
 				err = -EFAULT;
 				goto finished;
 			}
+
+			if (iobuf->pinfo) {
+                                offset = iobuf->pinfo->poffset[pageind]; 
+                                length = iobuf->pinfo->plen[pageind]; 
+                        }
 			
 			while (length > 0) {
 				blocknr = b[bufind++];
--- 2417orig/linux/drivers/char/raw.c	Sat Sep 22 20:35:43 2001
+++ 2417vio/linux/drivers/char/raw.c	Wed Jan 30 17:33:16 2002
@@ -34,6 +34,9 @@
 int	raw_open(struct inode *, struct file *);
 int	raw_release(struct inode *, struct file *);
 int	raw_ctl_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+ssize_t raw_readv(struct file *, const struct iovec *, unsigned long, loff_t *, size_t);
+ssize_t raw_writev(struct file *, const struct iovec *, unsigned long, loff_t *,size_t);
+static ssize_t rwvec_raw_dev(int rw, struct file *, const struct iovec *, unsigned long, loff_t *, size_t);
 
 
 static struct file_operations raw_fops = {
@@ -41,6 +44,8 @@
 	write:		raw_write,
 	open:		raw_open,
 	release:	raw_release,
+	readv:          raw_readv,
+	writev:         raw_writev,
 };
 
 static struct file_operations raw_ctl_fops = {
@@ -48,6 +53,10 @@
 	open:		raw_open,
 };
 
+extern int map_user_kiobuf_iovecs(int, struct kiobuf *, struct iovec *, int); 
+extern void mark_dirty_kiobuf_iovec(struct kiobuf *, int);
+
+
 static int __init raw_init(void)
 {
 	int i;
@@ -380,4 +388,159 @@
 		free_kiovec(1, &iobuf);
  out:	
 	return err;
+}
+
+
+
+ssize_t raw_readv(struct file *filp, const struct iovec *iov,
+                 unsigned long nr, loff_t *offp, size_t tot_len)
+{
+        return rwvec_raw_dev(READ, filp, iov, nr, offp, tot_len);
+}
+
+ssize_t raw_writev(struct file *filp, const struct iovec *iov,
+                 unsigned long nr, loff_t *offp, size_t tot_len)
+{
+        return rwvec_raw_dev(WRITE, filp, iov, nr, offp, tot_len);
+}
+
+
+#define PAGES(va, len) \
+   (((ulong)va + (size_t)len + PAGE_SIZE - 1)/PAGE_SIZE - (ulong)va/PAGE_SIZE)
+
+ssize_t rwvec_raw_dev(int rw, struct file * filp, const struct iovec *iov, ulong iov_count, loff_t *offp, size_t tot_len)
+{
+   	kdev_t 	dev;
+        size_t 	transferred, len;
+	struct	pinfo  pinfo;
+	struct 	kiobuf * iobuf;
+	ulong   blocknr, blocks, limit;
+        int 	i, minor, err, new_iobuf;
+	int  	sector_size, sector_bits, sector_mask, max_sectors;
+	int     curr, lastiov, num_iovecs, save_index;
+	int	pgcount, lookahead_pgcount;
+
+        minor = MINOR(filp->f_dentry->d_inode->i_rdev);
+
+	new_iobuf = 0;
+        iobuf = filp->f_iobuf;
+        if (test_and_set_bit(0, &filp->f_iobuf_lock)) {
+                /*
+                 * A parallel read/write is using the preallocated iobuf
+                 * so just run slow and allocate a new one.
+                 */
+                err = alloc_kiovec(1, &iobuf);
+                if (err)
+                        goto out;
+                new_iobuf = 1;
+        }
+	iobuf->pinfo = &pinfo;
+
+	dev = to_kdev_t(raw_devices[minor].binding->bd_dev);
+	sector_size = raw_devices[minor].sector_size;
+	sector_bits = raw_devices[minor].sector_bits;
+	sector_mask = sector_size - 1;
+	max_sectors = KIO_MAX_SECTORS >> (sector_bits - 9);
+
+        if (blk_size[MAJOR(dev)])
+                limit = (((loff_t) blk_size[MAJOR(dev)][MINOR(dev)]) << BLOCK_SIZE_BITS) >> sector_bits;
+        else
+                limit = INT_MAX;
+
+        if (*offp & sector_mask) {
+		err = -EINVAL;
+                goto out_free;
+	}
+
+        err = 0;
+        if ((*offp >> sector_bits) >= limit) {
+		if (tot_len)
+			err = -ENXIO;
+                goto out_free;
+	}
+
+	 blocks = tot_len >> sector_bits;
+        if (!blocks) 
+                goto out_free;
+        blocknr = *offp >> sector_bits;
+
+	/* 
+         * Revert to rw_raw_dev to handle a partial transfer if the request 
+         * will overrun the end of the device or if we need to split up a 
+         * large iov_len ( > max_sectors).
+	 */ 
+        err = -ENOSYS; 
+        if ( blocks > (limit - blocknr) ) 
+                 goto out_free;
+        else if ( blocks > max_sectors ) {
+		for (i = 0; i < iov_count; i++)  
+			if ( (iov[i].iov_len >> sector_bits) > max_sectors )
+                  		goto out_free;
+        }
+
+ 	/*
+         * Split the IO into KIO_STATIC_PAGES chunks, mapping and
+         * unmapping the single kiobuf as we go to perform each chunk of
+         * IO.
+         */
+
+	err = transferred = len = save_index = pgcount = 0;
+
+	for (curr=0; curr<iov_count; curr++)  { 
+
+		len += iov[curr].iov_len;
+	 	pgcount += PAGES(iov[curr].iov_base, iov[curr].iov_len);
+
+		lastiov = ((curr+1) == iov_count) ? 1 : 0;
+
+		if (lastiov) {
+			lookahead_pgcount = 0;
+		} else {
+			lookahead_pgcount = 
+			   PAGES(iov[curr+1].iov_base, iov[curr+1].iov_len);
+		}
+
+		if ( ((pgcount + lookahead_pgcount) > KIO_STATIC_PAGES) 
+			|| lastiov ) {
+		
+			num_iovecs = curr-save_index+1;
+
+                	err = map_user_kiobuf_iovecs
+		         	(rw, iobuf, &iov[save_index], num_iovecs);
+                	if (err)
+				break;
+
+			blocks = len >> sector_bits;
+                	for (i=0; i < blocks; i++)
+                        	iobuf->blocks[i] = blocknr++;
+
+                	err = brw_kiovec(rw, 1, &iobuf, dev, iobuf->blocks, sector_size);
+                	if (rw == READ && err > 0)
+                        	mark_dirty_kiobuf_iovec(iobuf, err);
+                	if (err > 0) 
+                        	transferred += err;
+
+                	unmap_kiobuf(iobuf);
+
+                 	if (err != len)
+                        	break;
+
+			save_index += num_iovecs;
+			len = pgcount = 0; 
+		} 
+        }
+        if (transferred) {
+                *offp += transferred;
+                err = transferred;
+        }
+
+ out_free:
+        iobuf->pinfo = NULL;
+
+        if (!new_iobuf)
+                clear_bit(0, &filp->f_iobuf_lock);
+        else
+                free_kiovec(1, &iobuf);
+ out:  
+        return err;
 }
