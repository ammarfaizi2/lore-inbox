Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312444AbSDJFCq>; Wed, 10 Apr 2002 01:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312446AbSDJFCq>; Wed, 10 Apr 2002 01:02:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34309 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312444AbSDJFCg>;
	Wed, 10 Apr 2002 01:02:36 -0400
Message-ID: <3CB3C765.8C10D908@zip.com.au>
Date: Tue, 09 Apr 2002 22:02:29 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Neil Brown <neilb@cse.unsw.edu.au>
Subject: [patch] readahead
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch against 2.5.8-pre3+radix-tree pagecache.

I'd like to be able to claim amazing speedups, but
the best benchmark I could find was diffing two
256 megabyte files, which is about 10% quicker.  And
that is probably due to the window size being effectively
50% larger.

Fact is, any disk worth owning nowadays has a segmented
2-megabyte cache, and OS-level readahead mainly seems
to save on CPU cycles rather than overall throughput.
Once you start reading more streams than there are segments
in the disk cache we start to win.

Still.  The main motivation for this work is to
clean the code up, and to create a central point at
which many pages are marshalled together so that
they can all be encapsulated into the smallest possible
number of BIOs, and injected into the request layer.

A number of filesystems were poking around inside the
readahead state variables.  I'm not really sure what they
were up to, but I took all that out.  The readahead
code manages its own state autonomously and should not
need any hints.

Neil, this touches on your stuff a bit - nfsd and also
the RAID driver in places.  You may want to make some
adjustments there sometime.


- Unifies the current three readahead functions (mmap reads, read(2)
  and sys_readhead) into a single implementation.

- More aggressive in building up the readahead windows.

- More conservative in tearing them down.

- Special start-of-file heuristics.

- Preallocates the readahead pages, to avoid the (never demonstrated,
  but potentially catastrophic) scenario where allocation of readahead
  pages causes the allocator to perform VM writeout.

- Gets all the readahead pages gathered together in
  one spot, so they can be marshalled into big BIOs.

- reinstates the readahead ioctls, so hdparm(8) and blockdev(8)
  are working again.  The readahead settings are now per-request-queue,
  and the drivers never have to know about it.  I use blockdev(8).
  It works in units of 512 bytes.

- Identifies readahead thrashing.

  Also attempts to handle it.  Certainly the changes here
  delay the onset of catastrophic readahead thrashing by
  quite a lot, and decrease it seriousness as we get more
  deeply into it, but it's still pretty bad.



=====================================

--- 2.5.8-pre3/fs/block_dev.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/fs/block_dev.c	Tue Apr  9 21:33:04 2002
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <linux/blkpg.h>
 
 #include <asm/uaccess.h>
 
@@ -172,7 +173,6 @@ static loff_t block_llseek(struct file *
 	if (offset >= 0 && offset <= size) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
-			file->f_reada = 0;
 			file->f_version = ++event;
 		}
 		retval = offset;
@@ -692,9 +692,20 @@ int blkdev_close(struct inode * inode, s
 static int blkdev_ioctl(struct inode *inode, struct file *file, unsigned cmd,
 			unsigned long arg)
 {
-	if (inode->i_bdev->bd_op->ioctl)
-		return inode->i_bdev->bd_op->ioctl(inode, file, cmd, arg);
-	return -EINVAL;
+	int ret = -EINVAL;
+	switch (cmd) {
+	case BLKRAGET:
+	case BLKFRAGET:
+	case BLKRASET:
+	case BLKFRASET:
+		ret = blk_ioctl(inode->i_bdev, cmd, arg);
+		break;
+	default:
+		if (inode->i_bdev->bd_op->ioctl)
+			ret =inode->i_bdev->bd_op->ioctl(inode, file, cmd, arg);
+		break;
+	}
+	return ret;
 }
 
 struct address_space_operations def_blk_aops = {
--- 2.5.8-pre3/fs/hfs/file.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/fs/hfs/file.c	Tue Apr  9 21:33:04 2002
@@ -166,7 +166,6 @@ static hfs_rwret_t hfs_file_read(struct 
 	}
 	if ((read = hfs_do_read(inode, HFS_I(inode)->fork, pos, buf, left)) > 0) {
 	        *ppos += read;
-		filp->f_reada = 1;
 	}
 
 	return read;
--- 2.5.8-pre3/fs/hfs/file_cap.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/fs/hfs/file_cap.c	Tue Apr  9 21:33:04 2002
@@ -105,7 +105,6 @@ static loff_t cap_info_llseek(struct fil
 	if (offset>=0 && offset<=HFS_FORK_MAX) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
-			file->f_reada = 0;
 		}
 		retval = offset;
 	}
--- 2.5.8-pre3/fs/hfs/file_hdr.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/fs/hfs/file_hdr.c	Tue Apr  9 21:33:04 2002
@@ -361,7 +361,6 @@ loff_t hdr_llseek(struct file *file, lof
 	if (offset>=0 && offset<file->f_dentry->d_inode->i_size) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
-			file->f_reada = 0;
 		}
 		retval = offset;
 	}
@@ -594,7 +593,6 @@ hfs_did_done:
 		} else if (fork) {
 			left = hfs_do_read(inode, fork, offset, buf, left);
 			if (left > 0) {
-				filp->f_reada = 1;
 			} else if (!read) {
 				return left;
 			} else {
--- 2.5.8-pre3/fs/intermezzo/vfs.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/fs/intermezzo/vfs.c	Tue Apr  9 21:33:04 2002
@@ -1884,7 +1884,6 @@ static struct file *presto_filp_dopen(st
 
         f->f_dentry = dentry;
         f->f_pos = 0;
-        f->f_reada = 0;
         f->f_op = NULL;
         if (inode->i_op)
                 /* XXX should we set to presto ops, or leave at cache ops? */
--- 2.5.8-pre3/fs/nfsd/vfs.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/fs/nfsd/vfs.c	Tue Apr  9 21:33:04 2002
@@ -67,11 +67,7 @@ struct raparms {
 	unsigned int		p_count;
 	ino_t			p_ino;
 	kdev_t			p_dev;
-	unsigned long		p_reada,
-				p_ramax,
-				p_raend,
-				p_ralen,
-				p_rawin;
+	struct file_ra_state	p_ra;
 };
 
 static struct raparms *		raparml;
@@ -564,11 +560,7 @@ nfsd_get_raparms(kdev_t dev, ino_t ino)
 	ra = *frap;
 	ra->p_dev = dev;
 	ra->p_ino = ino;
-	ra->p_reada = 0;
-	ra->p_ramax = 0;
-	ra->p_raend = 0;
-	ra->p_ralen = 0;
-	ra->p_rawin = 0;
+	memset(&ra->p_ra, 0, sizeof(ra->p_ra));
 found:
 	if (rap != &raparm_cache) {
 		*rap = ra->p_next;
@@ -611,31 +603,18 @@ nfsd_read(struct svc_rqst *rqstp, struct
 
 	/* Get readahead parameters */
 	ra = nfsd_get_raparms(inode->i_dev, inode->i_ino);
-	if (ra) {
-		file.f_reada = ra->p_reada;
-		file.f_ramax = ra->p_ramax;
-		file.f_raend = ra->p_raend;
-		file.f_ralen = ra->p_ralen;
-		file.f_rawin = ra->p_rawin;
-	}
+	if (ra)
+		file.f_ra = ra->p_ra;
 	file.f_pos = offset;
 
-	oldfs = get_fs(); set_fs(KERNEL_DS);
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
 	err = file.f_op->read(&file, buf, *count, &file.f_pos);
 	set_fs(oldfs);
 
 	/* Write back readahead params */
-	if (ra != NULL) {
-		dprintk("nfsd: raparms %ld %ld %ld %ld %ld\n",
-			file.f_reada, file.f_ramax, file.f_raend,
-			file.f_ralen, file.f_rawin);
-		ra->p_reada = file.f_reada;
-		ra->p_ramax = file.f_ramax;
-		ra->p_raend = file.f_raend;
-		ra->p_ralen = file.f_ralen;
-		ra->p_rawin = file.f_rawin;
-		ra->p_count -= 1;
-	}
+	if (ra)
+		ra->p_ra = file.f_ra;
 
 	if (err >= 0) {
 		nfsdstats.io_read += err;
--- 2.5.8-pre3/fs/open.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/fs/open.c	Tue Apr  9 21:33:04 2002
@@ -635,7 +635,6 @@ struct file *dentry_open(struct dentry *
 	f->f_dentry = dentry;
 	f->f_vfsmnt = mnt;
 	f->f_pos = 0;
-	f->f_reada = 0;
 	f->f_op = fops_get(inode->i_fop);
 	file_move(f, &inode->i_sb->s_files);
 
--- 2.5.8-pre3/fs/read_write.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/fs/read_write.c	Tue Apr  9 21:33:04 2002
@@ -37,7 +37,6 @@ loff_t generic_file_llseek(struct file *
 	if (offset>=0 && offset<=inode->i_sb->s_maxbytes) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
-			file->f_reada = 0;
 			file->f_version = ++event;
 		}
 		retval = offset;
@@ -62,7 +61,6 @@ loff_t remote_llseek(struct file *file, 
 	if (offset>=0 && offset<=file->f_dentry->d_inode->i_sb->s_maxbytes) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
-			file->f_reada = 0;
 			file->f_version = ++event;
 		}
 		retval = offset;
@@ -92,7 +90,6 @@ loff_t default_llseek(struct file *file,
 	if (offset >= 0) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
-			file->f_reada = 0;
 			file->f_version = ++event;
 		}
 		retval = offset;
--- 2.5.8-pre3/include/linux/fs.h~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/include/linux/fs.h	Tue Apr  9 21:33:04 2002
@@ -173,12 +173,10 @@ extern int leases_enable, dir_notify_ena
 #define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
 #define BLKGETSIZE _IO(0x12,96)	/* return device size /512 (long *arg) */
 #define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
-#if 0				/* Obsolete, these don't do anything. */
 #define BLKRASET   _IO(0x12,98)	/* set read ahead for block device */
 #define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
 #define BLKFRASET  _IO(0x12,100)/* set filesystem (mm/filemap.c) read-ahead */
 #define BLKFRAGET  _IO(0x12,101)/* get filesystem (mm/filemap.c) read-ahead */
-#endif
 #define BLKSECTSET _IO(0x12,102)/* set max sectors per request (ll_rw_blk.c) */
 #define BLKSECTGET _IO(0x12,103)/* get max sectors per request (ll_rw_blk.c) */
 #define BLKSSZGET  _IO(0x12,104)/* get block device sector size */
@@ -487,6 +485,18 @@ struct fown_struct {
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
+/*
+ * Track a single file's readahead state
+ */
+struct file_ra_state {
+	unsigned long start;		/* Current window */
+	unsigned long size;
+	unsigned long next_size;	/* Next window size */
+	unsigned long prev_page;	/* Cache last read() position */
+	unsigned long ahead_start;	/* Ahead window */
+	unsigned long ahead_size;
+};
+
 struct file {
 	struct list_head	f_list;
 	struct dentry		*f_dentry;
@@ -496,10 +506,10 @@ struct file {
 	unsigned int 		f_flags;
 	mode_t			f_mode;
 	loff_t			f_pos;
-	unsigned long 		f_reada, f_ramax, f_raend, f_ralen, f_rawin;
 	struct fown_struct	f_owner;
 	unsigned int		f_uid, f_gid;
 	int			f_error;
+	struct file_ra_state	f_ra;
 
 	unsigned long		f_version;
 
--- 2.5.8-pre3/mm/filemap.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/mm/filemap.c	Tue Apr  9 21:33:04 2002
@@ -26,6 +26,7 @@
 #include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/hash.h>
+#include <linux/blkdev.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -263,7 +264,6 @@ static int truncate_list_pages(struct ad
 	return unlocked;
 }
 
-
 /**
  * truncate_inode_pages - truncate *all* the pages from an offset
  * @mapping: mapping to truncate
@@ -661,28 +661,6 @@ static int page_cache_read(struct file *
 }
 
 /*
- * Read in an entire cluster at once.  A cluster is usually a 64k-
- * aligned block that includes the page requested in "offset."
- */
-static int FASTCALL(read_cluster_nonblocking(struct file * file, unsigned long offset,
-					     unsigned long filesize));
-static int read_cluster_nonblocking(struct file * file, unsigned long offset,
-	unsigned long filesize)
-{
-	unsigned long pages = CLUSTER_PAGES;
-
-	offset = CLUSTER_OFFSET(offset);
-	while ((pages-- > 0) && (offset < filesize)) {
-		int error = page_cache_read(file, offset);
-		if (error < 0)
-			return error;
-		offset ++;
-	}
-
-	return 0;
-}
-
-/*
  * In order to wait for pages to become available there must be
  * waitqueues associated with pages. By using a hash table of
  * waitqueues where the bucket discipline is to maintain all
@@ -954,232 +932,6 @@ struct page *grab_cache_page_nowait(stru
 	return page;
 }
 
-#if 0
-#define PROFILE_READAHEAD
-#define DEBUG_READAHEAD
-#endif
-
-/*
- * Read-ahead profiling information
- * --------------------------------
- * Every PROFILE_MAXREADCOUNT, the following information is written 
- * to the syslog:
- *   Percentage of asynchronous read-ahead.
- *   Average of read-ahead fields context value.
- * If DEBUG_READAHEAD is defined, a snapshot of these fields is written 
- * to the syslog.
- */
-
-#ifdef PROFILE_READAHEAD
-
-#define PROFILE_MAXREADCOUNT 1000
-
-static unsigned long total_reada;
-static unsigned long total_async;
-static unsigned long total_ramax;
-static unsigned long total_ralen;
-static unsigned long total_rawin;
-
-static void profile_readahead(int async, struct file *filp)
-{
-	unsigned long flags;
-
-	++total_reada;
-	if (async)
-		++total_async;
-
-	total_ramax	+= filp->f_ramax;
-	total_ralen	+= filp->f_ralen;
-	total_rawin	+= filp->f_rawin;
-
-	if (total_reada > PROFILE_MAXREADCOUNT) {
-		save_flags(flags);
-		cli();
-		if (!(total_reada > PROFILE_MAXREADCOUNT)) {
-			restore_flags(flags);
-			return;
-		}
-
-		printk("Readahead average:  max=%ld, len=%ld, win=%ld, async=%ld%%\n",
-			total_ramax/total_reada,
-			total_ralen/total_reada,
-			total_rawin/total_reada,
-			(total_async*100)/total_reada);
-#ifdef DEBUG_READAHEAD
-		printk("Readahead snapshot: max=%ld, len=%ld, win=%ld, raend=%Ld\n",
-			filp->f_ramax, filp->f_ralen, filp->f_rawin, filp->f_raend);
-#endif
-
-		total_reada	= 0;
-		total_async	= 0;
-		total_ramax	= 0;
-		total_ralen	= 0;
-		total_rawin	= 0;
-
-		restore_flags(flags);
-	}
-}
-#endif  /* defined PROFILE_READAHEAD */
-
-/*
- * Read-ahead context:
- * -------------------
- * The read ahead context fields of the "struct file" are the following:
- * - f_raend : position of the first byte after the last page we tried to
- *	       read ahead.
- * - f_ramax : current read-ahead maximum size.
- * - f_ralen : length of the current IO read block we tried to read-ahead.
- * - f_rawin : length of the current read-ahead window.
- *		if last read-ahead was synchronous then
- *			f_rawin = f_ralen
- *		otherwise (was asynchronous)
- *			f_rawin = previous value of f_ralen + f_ralen
- *
- * Read-ahead limits:
- * ------------------
- * MIN_READAHEAD   : minimum read-ahead size when read-ahead.
- * MAX_READAHEAD   : maximum read-ahead size when read-ahead.
- *
- * Synchronous read-ahead benefits:
- * --------------------------------
- * Using reasonable IO xfer length from peripheral devices increase system 
- * performances.
- * Reasonable means, in this context, not too large but not too small.
- * The actual maximum value is:
- *	MAX_READAHEAD + PAGE_CACHE_SIZE = 76k is CONFIG_READA_SMALL is undefined
- *      and 32K if defined (4K page size assumed).
- *
- * Asynchronous read-ahead benefits:
- * ---------------------------------
- * Overlapping next read request and user process execution increase system 
- * performance.
- *
- * Read-ahead risks:
- * -----------------
- * We have to guess which further data are needed by the user process.
- * If these data are often not really needed, it's bad for system 
- * performances.
- * However, we know that files are often accessed sequentially by 
- * application programs and it seems that it is possible to have some good 
- * strategy in that guessing.
- * We only try to read-ahead files that seems to be read sequentially.
- *
- * Asynchronous read-ahead risks:
- * ------------------------------
- * In order to maximize overlapping, we must start some asynchronous read
- * request from the device, as soon as possible.
- * We must be very careful about:
- * - The number of effective pending IO read requests.
- *   ONE seems to be the only reasonable value.
- * - The total memory pool usage for the file access stream.
- *   This maximum memory usage is implicitly 2 IO read chunks:
- *   2*(MAX_READAHEAD + PAGE_CACHE_SIZE) = 156K if CONFIG_READA_SMALL is undefined,
- *   64k if defined (4K page size assumed).
- */
-
-static void generic_file_readahead(int reada_ok,
-	struct file * filp, struct inode * inode,
-	struct page * page)
-{
-	unsigned long end_index;
-	unsigned long index = page->index;
-	unsigned long max_ahead, ahead;
-	unsigned long raend;
-
-	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
-
-	raend = filp->f_raend;
-	max_ahead = 0;
-
-/*
- * The current page is locked.
- * If the current position is inside the previous read IO request, do not
- * try to reread previously read ahead pages.
- * Otherwise decide or not to read ahead some pages synchronously.
- * If we are not going to read ahead, set the read ahead context for this 
- * page only.
- */
-	if (PageLocked(page)) {
-		if (!filp->f_ralen || index >= raend || index + filp->f_rawin < raend) {
-			raend = index;
-			if (raend < end_index)
-				max_ahead = filp->f_ramax;
-			filp->f_rawin = 0;
-			filp->f_ralen = 1;
-			if (!max_ahead) {
-				filp->f_raend  = index + filp->f_ralen;
-				filp->f_rawin += filp->f_ralen;
-			}
-		}
-	}
-/*
- * The current page is not locked.
- * If we were reading ahead and,
- * if the current max read ahead size is not zero and,
- * if the current position is inside the last read-ahead IO request,
- *   it is the moment to try to read ahead asynchronously.
- * We will later force unplug device in order to force asynchronous read IO.
- */
-	else if (reada_ok && filp->f_ramax && raend >= 1 &&
-		 index <= raend && index + filp->f_ralen >= raend) {
-/*
- * Add ONE page to max_ahead in order to try to have about the same IO max size
- * as synchronous read-ahead (MAX_READAHEAD + 1)*PAGE_CACHE_SIZE.
- * Compute the position of the last page we have tried to read in order to 
- * begin to read ahead just at the next page.
- */
-		raend -= 1;
-		if (raend < end_index)
-			max_ahead = filp->f_ramax + 1;
-
-		if (max_ahead) {
-			filp->f_rawin = filp->f_ralen;
-			filp->f_ralen = 0;
-			reada_ok      = 2;
-		}
-	}
-/*
- * Try to read ahead pages.
- * We hope that ll_rw_blk() plug/unplug, coalescence, requests sort and the
- * scheduler, will work enough for us to avoid too bad actuals IO requests.
- */
-	ahead = 0;
-	while (ahead < max_ahead) {
-		ahead ++;
-		if ((raend + ahead) >= end_index)
-			break;
-		if (page_cache_read(filp, raend + ahead) < 0)
-			break;
-	}
-/*
- * If we tried to read ahead some pages,
- * If we tried to read ahead asynchronously,
- *   Try to force unplug of the device in order to start an asynchronous
- *   read IO request.
- * Update the read-ahead context.
- * Store the length of the current read-ahead window.
- * Double the current max read ahead size.
- *   That heuristic avoid to do some large IO for files that are not really
- *   accessed sequentially.
- */
-	if (ahead) {
-		filp->f_ralen += ahead;
-		filp->f_rawin += filp->f_ralen;
-		filp->f_raend = raend + ahead + 1;
-
-		filp->f_ramax += filp->f_ramax;
-
-		if (filp->f_ramax > MAX_READAHEAD)
-			filp->f_ramax = MAX_READAHEAD;
-
-#ifdef PROFILE_READAHEAD
-		profile_readahead((reada_ok == 2), filp);
-#endif
-	}
-
-	return;
-}
-
 /*
  * Mark a page as having seen activity.
  *
@@ -1214,52 +966,12 @@ void do_generic_file_read(struct file * 
 	struct inode *inode = mapping->host;
 	unsigned long index, offset;
 	struct page *cached_page;
-	int reada_ok;
 	int error;
 
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
-/*
- * If the current position is outside the previous read-ahead window, 
- * we reset the current read-ahead context and set read ahead max to zero
- * (will be set to just needed value later),
- * otherwise, we assume that the file accesses are sequential enough to
- * continue read-ahead.
- */
-	if (index > filp->f_raend || index + filp->f_rawin < filp->f_raend) {
-		reada_ok = 0;
-		filp->f_raend = 0;
-		filp->f_ralen = 0;
-		filp->f_ramax = 0;
-		filp->f_rawin = 0;
-	} else {
-		reada_ok = 1;
-	}
-/*
- * Adjust the current value of read-ahead max.
- * If the read operation stay in the first half page, force no readahead.
- * Otherwise try to increase read ahead max just enough to do the read request.
- * Then, at least MIN_READAHEAD if read ahead is ok,
- * and at most MAX_READAHEAD in all cases.
- */
-	if (!index && offset + desc->count <= (PAGE_CACHE_SIZE >> 1)) {
-		filp->f_ramax = 0;
-	} else {
-		unsigned long needed;
-
-		needed = ((offset + desc->count) >> PAGE_CACHE_SHIFT) + 1;
-
-		if (filp->f_ramax < needed)
-			filp->f_ramax = needed;
-
-		if (reada_ok && filp->f_ramax < MIN_READAHEAD)
-			filp->f_ramax = MIN_READAHEAD;
-		if (filp->f_ramax > MAX_READAHEAD)
-			filp->f_ramax = MAX_READAHEAD;
-	}
-
 	for (;;) {
 		struct page *page;
 		unsigned long end_index, nr, ret;
@@ -1275,6 +987,8 @@ void do_generic_file_read(struct file * 
 				break;
 		}
 
+		page_cache_readahead(filp, index);
+
 		nr = nr - offset;
 
 		/*
@@ -1283,15 +997,18 @@ void do_generic_file_read(struct file * 
 
 		write_lock(&mapping->page_lock);
 		page = radix_tree_lookup(&mapping->page_tree, index);
-		if (!page)
+		if (!page) {
+			write_unlock(&mapping->page_lock);
+			handle_ra_thrashing(filp);
+			write_lock(&mapping->page_lock);
 			goto no_cached_page;
+		}
 found_page:
 		page_cache_get(page);
 		write_unlock(&mapping->page_lock);
 
 		if (!Page_Uptodate(page))
 			goto page_not_up_to_date;
-		generic_file_readahead(reada_ok, filp, inode, page);
 page_ok:
 		/* If users can be writing to this page using arbitrary
 		 * virtual addresses, take care about potential aliasing
@@ -1301,10 +1018,9 @@ page_ok:
 			flush_dcache_page(page);
 
 		/*
-		 * Mark the page accessed if we read the
-		 * beginning or we just did an lseek.
+		 * Mark the page accessed if we read the beginning.
 		 */
-		if (!offset || !filp->f_reada)
+		if (!offset)
 			mark_page_accessed(page);
 
 		/*
@@ -1327,12 +1043,7 @@ page_ok:
 			continue;
 		break;
 
-/*
- * Ok, the page was not immediately readable, so let's try to read ahead while we're at it..
- */
 page_not_up_to_date:
-		generic_file_readahead(reada_ok, filp, inode, page);
-
 		if (Page_Uptodate(page))
 			goto page_ok;
 
@@ -1359,9 +1070,6 @@ readpage:
 		if (!error) {
 			if (Page_Uptodate(page))
 				goto page_ok;
-
-			/* Again, try some read-ahead while waiting for the page to finish.. */
-			generic_file_readahead(reada_ok, filp, inode, page);
 			wait_on_page(page);
 			if (Page_Uptodate(page))
 				goto page_ok;
@@ -1415,7 +1123,6 @@ no_cached_page:
 	}
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
-	filp->f_reada = 1;
 	if (cached_page)
 		page_cache_release(cached_page);
 	UPDATE_ATIME(inode);
@@ -1740,24 +1447,12 @@ static ssize_t do_readahead(struct file 
 	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage)
 		return -EINVAL;
 
-	/* Limit it to the size of the file.. */
-	max = (mapping->host->i_size + ~PAGE_CACHE_MASK) >> PAGE_CACHE_SHIFT;
-	if (index > max)
-		return 0;
-	max -= index;
-	if (nr > max)
-		nr = max;
-
-	/* And limit it to a sane percentage of the inactive list.. */
+	/* Limit it to a sane percentage of the inactive list.. */
 	max = nr_inactive_pages / 2;
 	if (nr > max)
 		nr = max;
 
-	while (nr) {
-		page_cache_read(file, index);
-		index++;
-		nr--;
-	}
+	do_page_cache_readahead(file, index, nr);
 	return 0;
 }
 
@@ -1771,7 +1466,8 @@ asmlinkage ssize_t sys_readahead(int fd,
 	if (file) {
 		if (file->f_mode & FMODE_READ) {
 			unsigned long start = offset >> PAGE_CACHE_SHIFT;
-			unsigned long len = (count + ((long)offset & ~PAGE_CACHE_MASK)) >> PAGE_CACHE_SHIFT;
+			unsigned long end = (offset + count - 1) >> PAGE_CACHE_SHIFT;
+			unsigned long len = end - start + 1;
 			ret = do_readahead(file, start, len);
 		}
 		fput(file);
@@ -1780,60 +1476,6 @@ asmlinkage ssize_t sys_readahead(int fd,
 }
 
 /*
- * Read-ahead and flush behind for MADV_SEQUENTIAL areas.  Since we are
- * sure this is sequential access, we don't need a flexible read-ahead
- * window size -- we can always use a large fixed size window.
- */
-static void nopage_sequential_readahead(struct vm_area_struct * vma,
-	unsigned long pgoff, unsigned long filesize)
-{
-	unsigned long ra_window;
-
-	ra_window = CLUSTER_OFFSET(MAX_READAHEAD + CLUSTER_PAGES - 1);
-
-	/* vm_raend is zero if we haven't read ahead in this area yet.  */
-	if (vma->vm_raend == 0)
-		vma->vm_raend = vma->vm_pgoff + ra_window;
-
-	/*
-	 * If we've just faulted the page half-way through our window,
-	 * then schedule reads for the next window, and release the
-	 * pages in the previous window.
-	 */
-	if ((pgoff + (ra_window >> 1)) == vma->vm_raend) {
-		unsigned long start = vma->vm_pgoff + vma->vm_raend;
-		unsigned long end = start + ra_window;
-
-		if (end > ((vma->vm_end >> PAGE_SHIFT) + vma->vm_pgoff))
-			end = (vma->vm_end >> PAGE_SHIFT) + vma->vm_pgoff;
-		if (start > end)
-			return;
-
-		while ((start < end) && (start < filesize)) {
-			if (read_cluster_nonblocking(vma->vm_file,
-							start, filesize) < 0)
-				break;
-			start += CLUSTER_PAGES;
-		}
-		run_task_queue(&tq_disk);
-
-		/* if we're far enough past the beginning of this area,
-		   recycle pages that are in the previous window. */
-		if (vma->vm_raend > (vma->vm_pgoff + ra_window + ra_window)) {
-			unsigned long window = ra_window << PAGE_SHIFT;
-
-			end = vma->vm_start + (vma->vm_raend << PAGE_SHIFT);
-			end -= window + window;
-			filemap_sync(vma, end - window, window, MS_INVALIDATE);
-		}
-
-		vma->vm_raend += ra_window;
-	}
-
-	return;
-}
-
-/*
  * filemap_nopage() is invoked via the vma operations vector for a
  * mapped memory region to read in file data during a page fault.
  *
@@ -1841,6 +1483,7 @@ static void nopage_sequential_readahead(
  * it in the page cache, and handles the special cases reasonably without
  * having a lot of duplicated code.
  */
+
 struct page * filemap_nopage(struct vm_area_struct * area, unsigned long address, int unused)
 {
 	int error;
@@ -1867,6 +1510,20 @@ retry_all:
 		size = endoff;
 
 	/*
+	 * The readahead code wants to be told about each and every page
+	 * so it can build and shrink its windows appropriately
+	 */
+	if (VM_SequentialReadHint(area))
+		page_cache_readahead(area->vm_file, pgoff);
+
+	/*
+	 * If the offset is outside the mapping size we're off the end
+	 * of a privately mapped file, so we need to map a zero page.
+	 */
+	if ((pgoff < size) && !VM_RandomReadHint(area))
+		page_cache_readaround(file, pgoff);
+
+	/*
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
@@ -1882,12 +1539,6 @@ retry_find:
 		goto page_not_uptodate;
 
 success:
- 	/*
-	 * Try read-ahead for sequential areas.
-	 */
-	if (VM_SequentialReadHint(area))
-		nopage_sequential_readahead(area, pgoff, size);
-
 	/*
 	 * Found the page and have a reference on it, need to check sharing
 	 * and possibly copy it over to another page..
@@ -1898,16 +1549,10 @@ success:
 
 no_cached_page:
 	/*
-	 * If the requested offset is within our file, try to read a whole 
-	 * cluster of pages at once.
-	 *
-	 * Otherwise, we're off the end of a privately mapped file,
-	 * so we need to map a zero page.
+	 * We're only likely to ever get here if MADV_RANDOM is in
+	 * effect.
 	 */
-	if ((pgoff < size) && !VM_RandomReadHint(area))
-		error = read_cluster_nonblocking(file, pgoff, size);
-	else
-		error = page_cache_read(file, pgoff);
+	error = page_cache_read(file, pgoff);
 
 	/*
 	 * The page we want has now been added to the page cache.
@@ -2152,7 +1797,7 @@ static long madvise_behavior(struct vm_a
  * to make sure they are started.  Do not wait for completion.
  */
 static long madvise_willneed(struct vm_area_struct * vma,
-	unsigned long start, unsigned long end)
+				unsigned long start, unsigned long end)
 {
 	long error = -EBADF;
 	struct file * file;
@@ -2177,30 +1822,8 @@ static long madvise_willneed(struct vm_a
 	if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
 		return error;
 
-	/* round to cluster boundaries if this isn't a "random" area. */
-	if (!VM_RandomReadHint(vma)) {
-		start = CLUSTER_OFFSET(start);
-		end = CLUSTER_OFFSET(end + CLUSTER_PAGES - 1);
-
-		while ((start < end) && (start < size)) {
-			error = read_cluster_nonblocking(file, start, size);
-			start += CLUSTER_PAGES;
-			if (error < 0)
-				break;
-		}
-	} else {
-		while ((start < end) && (start < size)) {
-			error = page_cache_read(file, start);
-			start++;
-			if (error < 0)
-				break;
-		}
-	}
-
-	/* Don't wait for someone else to push these requests. */
-	run_task_queue(&tq_disk);
-
-	return error;
+	do_page_cache_readahead(file, start, end - start);
+	return 0;
 }
 
 /*
--- 2.5.8-pre3/include/linux/blkdev.h~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/include/linux/blkdev.h	Tue Apr  9 21:33:04 2002
@@ -153,6 +153,12 @@ struct request_queue
 	prep_rq_fn		*prep_rq_fn;
 
 	/*
+	 * The VM-level readahead tunable for this device.  In
+	 * units of 512-byte sectors.
+	 */
+	unsigned ra_sectors;
+
+	/*
 	 * The queue owner gets to use this for whatever they like.
 	 * ll_rw_blk doesn't touch it.
 	 */
@@ -308,6 +314,8 @@ extern void blk_queue_hardsect_size(requ
 extern void blk_queue_segment_boundary(request_queue_t *q, unsigned long);
 extern void blk_queue_assign_lock(request_queue_t *q, spinlock_t *);
 extern void blk_queue_prep_rq(request_queue_t *q, prep_rq_fn *pfn);
+extern int blk_set_readahead(kdev_t dev, unsigned sectors);
+extern unsigned blk_get_readahead(kdev_t dev);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
@@ -322,10 +330,6 @@ extern int * blksize_size[MAX_BLKDEV];
 
 #define MAX_SEGMENT_SIZE	65536
 
-/* read-ahead in pages.. */
-#define MAX_READAHEAD	31
-#define MIN_READAHEAD	3
-
 #define blkdev_entry_to_request(entry) list_entry((entry), struct request, queuelist)
 
 extern void drive_stat_acct(struct request *, int, int);
--- 2.5.8-pre3/drivers/block/blkpg.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/drivers/block/blkpg.c	Tue Apr  9 21:33:04 2002
@@ -237,6 +237,18 @@ int blk_ioctl(struct block_device *bdev,
 			intval = (is_read_only(dev) != 0);
 			return put_user(intval, (int *)(arg));
 
+		case BLKRASET:
+		case BLKFRASET:
+			if(!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+			return blk_set_readahead(dev, arg);
+
+		case BLKRAGET:
+		case BLKFRAGET:
+			if (!arg)
+				return -EINVAL;
+			return put_user(blk_get_readahead(dev), (long *)arg);
+
 		case BLKSECTGET:
 			if ((q = blk_get_queue(dev)) == NULL)
 				return -EINVAL;
--- 2.5.8-pre3/drivers/block/ll_rw_blk.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/drivers/block/ll_rw_blk.c	Tue Apr  9 21:33:04 2002
@@ -108,6 +108,47 @@ inline request_queue_t *blk_get_queue(kd
 		return &blk_dev[major(dev)].request_queue;
 }
 
+/**
+ * blk_set_readahead - set a queue's readahead tunable
+ * @dev:	device
+ * @sectors:	readahead, in 512 byte sectors
+ *
+ * Returns zero on success, else negative errno
+ */
+int blk_set_readahead(kdev_t dev, unsigned sectors)
+{
+	int ret = -EINVAL;
+	request_queue_t *q = blk_get_queue(dev);
+
+	if (q) {
+		q->ra_sectors = sectors;
+		ret = 0;
+	}
+	return ret;
+}
+
+/**
+ * blk_get_readahead - query a queue's readahead tunable
+ * @dev:	device
+ *
+ * Locates the passed device's request queue and returns its
+ * readahead setting.
+ *
+ * The returned value is in units of 512 byte sectors.
+ *
+ * Will return zero if the queue has never had its readahead
+ * setting altered.
+ */
+unsigned blk_get_readahead(kdev_t dev)
+{
+	unsigned ret = 0;
+	request_queue_t *q = blk_get_queue(dev);
+
+	if (q)
+		ret = q->ra_sectors;
+	return ret;
+}
+
 void blk_queue_prep_rq(request_queue_t *q, prep_rq_fn *pfn)
 {
 	q->prep_rq_fn = pfn;
@@ -810,7 +851,8 @@ int blk_init_queue(request_queue_t *q, r
 	q->plug_tq.data		= q;
 	q->queue_flags		= (1 << QUEUE_FLAG_CLUSTER);
 	q->queue_lock		= lock;
-	
+	q->ra_sectors		= 0;		/* Use VM default */
+
 	blk_queue_segment_boundary(q, 0xffffffff);
 
 	blk_queue_make_request(q, __make_request);
--- 2.5.8-pre3/drivers/md/md.c~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/drivers/md/md.c	Tue Apr  9 21:33:04 2002
@@ -1577,7 +1577,7 @@ static int device_size_calculation(mddev
 	if (!md_size[mdidx(mddev)])
 		md_size[mdidx(mddev)] = sb->size * data_disks;
 
-	readahead = MD_READAHEAD;
+	readahead = (blk_get_readahead(rdev->dev) * 512) / PAGE_SIZE;
 	if (!sb->level || (sb->level == 4) || (sb->level == 5)) {
 		readahead = (mddev->sb->chunk_size>>PAGE_SHIFT) * 4 * data_disks;
 		if (readahead < data_disks * (MAX_SECTORS>>(PAGE_SHIFT-9))*2)
@@ -3387,7 +3387,7 @@ recheck:
 	/*
 	 * Tune reconstruction:
 	 */
-	window = MAX_READAHEAD*(PAGE_SIZE/512);
+	window = 32*(PAGE_SIZE/512);
 	printk(KERN_INFO "md: using %dk window, over a total of %d blocks.\n",
 	       window/2,max_sectors/2);
 
@@ -3605,7 +3605,7 @@ static void md_geninit(void)
 	for(i = 0; i < MAX_MD_DEVS; i++) {
 		md_blocksizes[i] = 1024;
 		md_size[i] = 0;
-		md_maxreadahead[i] = MD_READAHEAD;
+		md_maxreadahead[i] = 32;
 	}
 	blksize_size[MAJOR_NR] = md_blocksizes;
 	blk_size[MAJOR_NR] = md_size;
--- 2.5.8-pre3/include/linux/raid/md_k.h~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/include/linux/raid/md_k.h	Tue Apr  9 21:33:04 2002
@@ -91,7 +91,6 @@ static inline mddev_t * kdev_to_mddev (k
 /*
  * default readahead
  */
-#define MD_READAHEAD	MAX_READAHEAD
 
 static inline int disk_faulty(mdp_disk_t * d)
 {
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.8-pre3-akpm/mm/readahead.c	Tue Apr  9 21:33:04 2002
@@ -0,0 +1,345 @@
+/*
+ * mm/readahead.c - address_space-level file readahead.
+ *
+ * Copyright (C) 2002, Linus Torvalds
+ *
+ * 09Apr2002	akpm@zip.com.au
+ *		Initial version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/blkdev.h>
+
+/*
+ * The readahead logic manages two readahead windows.  The "current"
+ * and the "ahead" windows.
+ *
+ * VM_MAX_READAHEAD specifies, in kilobytes, the maximum size of
+ * each of the two windows.  So the amount of readahead which is
+ * in front of the file pointer varies between VM_MAX_READAHEAD and
+ * VM_MAX_READAHEAD * 2.
+ *
+ * VM_MAX_READAHEAD only applies if the underlying request queue
+ * has a zero value of ra_sectors.
+ */
+
+#define VM_MAX_READAHEAD	128	/* kbytes */
+#define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
+
+/*
+ * Return max readahead size for this inode in number-of-pages.
+ */
+static int get_max_readahead(struct inode *inode)
+{
+	unsigned blk_ra_kbytes = 0;
+
+	blk_ra_kbytes = blk_get_readahead(inode->i_dev) / 2;
+	if (blk_ra_kbytes < VM_MIN_READAHEAD)
+		blk_ra_kbytes = VM_MAX_READAHEAD;
+
+	return blk_ra_kbytes >> (PAGE_CACHE_SHIFT - 10);
+}
+
+static int get_min_readahead(struct inode *inode)
+{
+	int ret = VM_MIN_READAHEAD / PAGE_CACHE_SIZE;
+
+	if (ret < 2)
+		ret = 2;
+	return ret;
+}
+
+/*
+ * Readahead design.
+ *
+ * The fields in struct file_ra_state represent the most-recently-executed
+ * readahead attempt:
+ *
+ * start:	Page index at which we started the readahead
+ * size:	Number of pages in that read
+ *              Together, these form the "current window".
+ *              Together, start and size represent the `readahead window'.
+ * next_size:   The number of pages to read when we get the next readahead miss.
+ * prev_page:   The page which the readahead algorithm most-recently inspected.
+ *              prev_page is mainly an optimisation: if page_cache_readahead sees
+ *              that it is again being called for a page which it just looked at,
+ *              it can return immediately without making any state changes.
+ * ahead_start,
+ * ahead_size:  Together, these form the "ahead window".
+ *
+ * The readahead code manages two windows - the "current" and the "ahead"
+ * windows.  The intent is that while the application is walking the pages
+ * in the current window, I/O is underway on the ahead window.  When the
+ * current window is fully traversed, it is replaced by the ahead window
+ * and the ahead window is invalidated.  When this copying happens, the
+ * new current window's pages are probably still locked.  When I/O has
+ * completed, we submit a new batch of I/O, creating a new ahead window.
+ *
+ * So:
+ *
+ *   ----|----------------|----------------|-----
+ *       ^start           ^start+size
+ *                        ^ahead_start     ^ahead_start+ahead_size
+ *
+ *         ^ When this page is read, we submit I/O for the
+ *           ahead window.
+ *
+ * A `readahead hit' occurs when a read request is made against a page which is
+ * inside the current window.  Hits are good, and the window size (next_size) is
+ * grown aggressively when hits occur.  Two pages are added to the next window
+ * size on each hit, which will end up doubling the next window size by the time
+ * I/O is submitted for it.
+ *
+ * If readahead hits are more sparse (say, the application is only reading every
+ * second page) then the window will build more slowly.
+ *
+ * On a readahead miss (the application seeked away) the readahead window is shrunk
+ * by 25%.  We don't want to drop it too aggressively, because it's a good assumption
+ * that an application which has built a good readahead window will continue to
+ * perform linear reads.  Either at the new file position, or at the old one after
+ * another seek.
+ *
+ * There is a special-case: if the first page which the application tries to read
+ * happens to be the first page of the file, it is assumed that a linear read is
+ * about to happen and the window is immediately set to half of the device maximum.
+ * 
+ * A page request at (start + size) is not a miss at all - it's just a part of
+ * sequential file reading.
+ *
+ * This function is to be called for every page which is read, rather than when
+ * it is time to perform readahead.  This is so the readahead algorithm can centrally
+ * work out the access patterns.  This could be costly with many tiny read()s, so
+ * we specifically optimise for that case with prev_page.
+ */
+
+/*
+ * do_page_cache_readahead actually reads a chunk of disk.  It allocates all the
+ * pages first, then submits them all for I/O. This avoids the very bad behaviour
+ * which would occur if page allocations are causing VM writeback.  We really don't
+ * want to intermingle reads and writes like that.
+ */
+void do_page_cache_readahead(struct file *file,
+			unsigned long offset, unsigned long nr_to_read)
+{
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	struct inode *inode = mapping->host;
+	struct page *page;
+	unsigned long end_index;	/* The last page we want to read */
+	LIST_HEAD(page_pool);
+	int page_idx;
+	int nr_to_really_read = 0;
+
+	if (inode->i_size == 0)
+		return;
+
+ 	end_index = ((inode->i_size - 1) >> PAGE_CACHE_SHIFT);
+
+	/*
+	 * Preallocate as many pages as we will need.
+	 */
+	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
+		unsigned long page_offset = offset + page_idx;
+		
+		if (page_offset > end_index)
+			break;
+
+		read_lock(&mapping->page_lock);
+		page = radix_tree_lookup(&mapping->page_tree, page_offset);
+		read_unlock(&mapping->page_lock);
+		if (page)
+			continue;
+
+		page = page_cache_alloc(mapping);
+		if (!page)
+			break;
+		page->index = page_offset;
+		list_add(&page->list, &page_pool);
+		nr_to_really_read++;
+	}
+
+	/*
+	 * Now start the IO.  We ignore I/O errors - if the page is not
+	 * uptodate then the caller will launch readpage again, and
+	 * will then handle the error.
+	 */
+	for (page_idx = 0; page_idx < nr_to_really_read; page_idx++) {
+		if (list_empty(&page_pool))
+			BUG();
+		page = list_entry(page_pool.prev, struct page, list);
+		list_del(&page->list);
+		if (!add_to_page_cache_unique(page, mapping, page->index))
+			mapping->a_ops->readpage(file, page);
+		page_cache_release(page);
+	}
+
+	/*
+	 * Do this now, rather than at the next wait_on_page().
+	 */
+	run_task_queue(&tq_disk);
+
+	if (!list_empty(&page_pool))
+		BUG();
+
+	return;
+}
+
+/*
+ * page_cache_readahead is the main function.  If performs the adaptive
+ * readahead window size management and submits the readahead I/O.
+ */
+void page_cache_readahead(struct file *file, unsigned long offset)
+{
+	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
+	struct file_ra_state *ra = &file->f_ra;
+	unsigned long max;
+	unsigned long min;
+
+	/*
+	 * Here we detect the case where the application is performing
+	 * sub-page sized reads.  We avoid doing extra work and bogusly
+	 * perturbing the readahead window expansion logic.
+	 * If next_size is zero, this is the very first read for this
+	 * file handle.
+	 */
+	if (offset == ra->prev_page) {
+		if (ra->next_size != 0)
+			goto out;
+	}
+
+	min = get_min_readahead(inode);
+	max = get_max_readahead(inode);
+
+	if (ra->next_size == 0 && offset == 0) {
+		/*
+		 * Special case - first read from first page.
+		 * We'll assume it's a whole-file read, and
+		 * grow the window fast.
+		 */
+		ra->next_size = max / 2;
+		goto do_io;
+	}
+
+	ra->prev_page = offset;
+
+	if (offset >= ra->start && offset <= (ra->start + ra->size)) {
+		/*
+		 * A readahead hit.  Either inside the window, or one
+		 * page beyond the end.  Expand the next readahead size.
+		 */
+		ra->next_size += 2;
+	} else {
+		/*
+		 * A miss - lseek, pread, etc.  Shrink the readahead window by 25%.
+		 */
+		ra->next_size -= ra->next_size / 4;
+		if (ra->next_size < min)
+			ra->next_size = min;
+	}
+
+	if (ra->next_size > max)
+		ra->next_size = max;
+	if (ra->next_size < min)
+		ra->next_size = min;
+
+	/*
+	 * Is this request outside the current window?
+	 */
+	if (offset < ra->start || offset >= (ra->start + ra->size)) {
+		/*
+		 * A miss against the current window.  Have we merely
+		 * advanced into the ahead window?
+		 */
+		if (offset == ra->ahead_start) {
+			/*
+			 * Yes, we have.  The ahead window now becomes
+			 * the current window.
+			 */
+			ra->start = ra->ahead_start;
+			ra->size = ra->ahead_size;
+			ra->prev_page = ra->start;
+			ra->ahead_start = 0;
+			ra->ahead_size = 0;
+			/*
+			 * Control now returns, probably to sleep until I/O
+			 * completes against the first ahead page.
+			 * When the second page in the old ahead window is
+			 * requested, control will return here and more I/O
+			 * will be submitted to build the new ahead window.
+			 */
+			goto out;
+		}
+do_io:
+		/*
+		 * This is the "unusual" path.  We come here during
+		 * startup or after an lseek.  We invalidate the
+		 * ahead window and get some I/O underway for the new
+		 * current window.
+		 */
+		ra->start = offset;
+		ra->size = ra->next_size;
+		ra->ahead_start = 0;		/* Invalidate these */
+		ra->ahead_size = 0;
+
+		do_page_cache_readahead(file, offset, ra->size);
+	} else {
+		/*
+		 * This read request is within the current window.  It
+		 * is time to submit I/O for the ahead window while
+		 * the application is crunching through the current
+		 * window.
+		 */
+		if (ra->ahead_start == 0) {
+			ra->ahead_start = ra->start + ra->size;
+			ra->ahead_size = ra->next_size;
+			do_page_cache_readahead(file,
+					ra->ahead_start, ra->ahead_size);
+		}
+	}
+out:
+	return;
+}
+
+/*
+ * For mmap reads (typically executables) the access pattern is fairly random,
+ * but somewhat ascending.  So readaround favours pages beyond the target one.
+ * We also boost the window size, as it can easily shrink due to misses.
+ */
+void page_cache_readaround(struct file *file, unsigned long offset)
+{
+	unsigned long target;
+	unsigned long backward;
+	const int min = get_min_readahead(file->f_dentry->d_inode->i_mapping->host) * 2;
+
+	if (file->f_ra.next_size < min)
+		file->f_ra.next_size = min;
+
+	target = offset;
+	backward = file->f_ra.next_size / 4;
+
+	if (backward > target)
+		target = 0;
+	else
+		target -= backward;
+	page_cache_readahead(file, target);
+}
+
+/*
+ * handle_ra_thrashing() is called when it is known that a page which should
+ * have been present (it's inside the readahead window) was in fact evicted by
+ * the VM.
+ *
+ * We shrink the readahead window by three pages.  This is because we grow it
+ * by two pages on a readahead hit.  Theory being that the readahead window size
+ * will stabilise around the maximum level at which there isn't any thrashing.
+ */
+void handle_ra_thrashing(struct file *file)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	const unsigned long min = get_min_readahead(inode);
+
+	file->f_ra.next_size -= 3;
+	if (file->f_ra.next_size < min)
+		file->f_ra.next_size = min;
+}
--- 2.5.8-pre3/include/linux/mm.h~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/include/linux/mm.h	Tue Apr  9 21:33:04 2002
@@ -531,6 +531,13 @@ extern void truncate_inode_pages(struct 
 extern int filemap_sync(struct vm_area_struct *, unsigned long,	size_t, unsigned int);
 extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int);
 
+/* readahead.c */
+void do_page_cache_readahead(struct file *file,
+			unsigned long offset, unsigned long nr_to_read);
+void page_cache_readahead(struct file *file, unsigned long offset);
+void page_cache_readaround(struct file *file, unsigned long offset);
+void handle_ra_thrashing(struct file *file);
+
 /* vma is the first one with  address < vma->vm_end,
  * and even  address < vma->vm_start. Have to extend vma. */
 static inline int expand_stack(struct vm_area_struct * vma, unsigned long address)
--- 2.5.8-pre3/mm/Makefile~dallocbase-20-readahead	Tue Apr  9 21:33:04 2002
+++ 2.5.8-pre3-akpm/mm/Makefile	Tue Apr  9 21:33:04 2002
@@ -14,6 +14,6 @@ export-objs := shmem.o filemap.o mempool
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
-	    shmem.o highmem.o mempool.o msync.o mincore.o
+	    shmem.o highmem.o mempool.o msync.o mincore.o readahead.o
 
 include $(TOPDIR)/Rules.make


-
