Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313827AbSDPTXz>; Tue, 16 Apr 2002 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313828AbSDPTXy>; Tue, 16 Apr 2002 15:23:54 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:61700 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313827AbSDPTXx>; Tue, 16 Apr 2002 15:23:53 -0400
Message-ID: <3CBC7A41.384FD032@zip.com.au>
Date: Tue, 16 Apr 2002 12:23:45 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: readahead
In-Reply-To: <UTC200204161910.g3GJAx009370.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> ...
>     Do these cards not have a request queue?
> 
> The kernel views them as SCSI disks.
> So yes, I can do
> 
>    blockdev --setra 0 /dev/sdc
> 
> Unfortunately that does not help in the least.
> Indeed, the only user of the readahead info is
> readahead.c: get_max_readahead() and it does
> 
>         blk_ra_kbytes = blk_get_readahead(inode->i_dev) / 2;
>         if (blk_ra_kbytes < VM_MIN_READAHEAD)
>                 blk_ra_kbytes = VM_MAX_READAHEAD;
> 
> We need to distinguish between undefined, and explicily zero.

Yup.  The below (untested) patch should fix it up.  Assuming
that all drivers use blk_init_queue(), and heaven knows if
that's the case.  If not, the readahead window will have to be
set from userspace for those devices.

> ...
> 
>     Yes, but things should be OK as-is.  If the readahead attempt
>     gets an I/O error, do_generic_file_read will notice the non-uptodate
>     page and will issue a single-page read.  So everything up to
>     a page's distance from the bad block should be recoverable.
>     That's the theory; can't say that I've tested it.
> 
> It is really important to be able to tell the kernel to read and
> write only the blocks it has been asked to read and write and
> not to touch anything else.

That is really hard when there is a filesystem mounted.
Even with readahead set to zero, the kernel will go and
read PAGE_CACHE_SIZE chunks.  That's not worth changing 
to address this problem.  In the last resort, the
user would need to perform a sector-by-sector read of
the dud device into a regular file, recover from that.


--- 2.5.8/mm/readahead.c~readahead-fixes	Tue Apr 16 12:07:42 2002
+++ 2.5.8-akpm/mm/readahead.c	Tue Apr 16 12:13:52 2002
@@ -25,9 +25,6 @@
  * has a zero value of ra_sectors.
  */
 
-#define VM_MAX_READAHEAD	128	/* kbytes */
-#define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
-
 /*
  * Return max readahead size for this inode in number-of-pages.
  */
@@ -36,9 +33,6 @@ static int get_max_readahead(struct inod
 	unsigned blk_ra_kbytes = 0;
 
 	blk_ra_kbytes = blk_get_readahead(inode->i_dev) / 2;
-	if (blk_ra_kbytes < VM_MIN_READAHEAD)
-		blk_ra_kbytes = VM_MAX_READAHEAD;
-
 	return blk_ra_kbytes >> (PAGE_CACHE_SHIFT - 10);
 }
 
@@ -96,10 +90,10 @@ static int get_min_readahead(struct inod
  * second page) then the window will build more slowly.
  *
  * On a readahead miss (the application seeked away) the readahead window is shrunk
- * by 25%.  We don't want to drop it too aggressively, because it's a good assumption
- * that an application which has built a good readahead window will continue to
- * perform linear reads.  Either at the new file position, or at the old one after
- * another seek.
+ * by 25%.  We don't want to drop it too aggressively, because it is a good
+ * assumption that an application which has built a good readahead window will
+ * continue to perform linear reads.  Either at the new file position, or at the
+ * old one after another seek.
  *
  * There is a special-case: if the first page which the application tries to read
  * happens to be the first page of the file, it is assumed that a linear read is
@@ -109,9 +103,9 @@ static int get_min_readahead(struct inod
  * sequential file reading.
  *
  * This function is to be called for every page which is read, rather than when
- * it is time to perform readahead.  This is so the readahead algorithm can centrally
- * work out the access patterns.  This could be costly with many tiny read()s, so
- * we specifically optimise for that case with prev_page.
+ * it is time to perform readahead.  This is so the readahead algorithm can
+ * centrally work out the access patterns.  This could be costly with many tiny
+ * read()s, so we specifically optimise for that case with prev_page.
  */
 
 /*
@@ -208,8 +202,10 @@ void page_cache_readahead(struct file *f
 			goto out;
 	}
 
-	min = get_min_readahead(inode);
 	max = get_max_readahead(inode);
+	if (max == 0)
+		goto out;	/* No readahead */
+	min = get_min_readahead(inode);
 
 	if (ra->next_size == 0 && offset == 0) {
 		/*
@@ -310,7 +306,8 @@ void page_cache_readaround(struct file *
 {
 	unsigned long target;
 	unsigned long backward;
-	const int min = get_min_readahead(file->f_dentry->d_inode->i_mapping->host) * 2;
+	const int min =
+		get_min_readahead(file->f_dentry->d_inode->i_mapping->host) * 2;
 
 	if (file->f_ra.next_size < min)
 		file->f_ra.next_size = min;
--- 2.5.8/include/linux/mm.h~readahead-fixes	Tue Apr 16 12:11:39 2002
+++ 2.5.8-akpm/include/linux/mm.h	Tue Apr 16 12:12:14 2002
@@ -539,6 +539,8 @@ extern int filemap_sync(struct vm_area_s
 extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int);
 
 /* readahead.c */
+#define VM_MAX_READAHEAD	128	/* kbytes */
+#define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 void do_page_cache_readahead(struct file *file,
 			unsigned long offset, unsigned long nr_to_read);
 void page_cache_readahead(struct file *file, unsigned long offset);
--- 2.5.8/drivers/block/ll_rw_blk.c~readahead-fixes	Tue Apr 16 12:12:19 2002
+++ 2.5.8-akpm/drivers/block/ll_rw_blk.c	Tue Apr 16 12:13:43 2002
@@ -851,7 +851,7 @@ int blk_init_queue(request_queue_t *q, r
 	q->plug_tq.data		= q;
 	q->queue_flags		= (1 << QUEUE_FLAG_CLUSTER);
 	q->queue_lock		= lock;
-	q->ra_sectors		= 0;		/* Use VM default */
+	q->ra_sectors		= VM_MAX_READAHEAD << (PAGE_CACHE_SHIFT - 9);
 
 	blk_queue_segment_boundary(q, 0xffffffff);
 

-
