Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130457AbRC1Ex0>; Tue, 27 Mar 2001 23:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131025AbRC1ExR>; Tue, 27 Mar 2001 23:53:17 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:47419 "EHLO devserv.devel.redhat.com") by vger.kernel.org with ESMTP id <S130457AbRC1ExL>; Tue, 27 Mar 2001 23:53:11 -0500
Date: Wed, 28 Mar 2001 05:49:30 +0100
From: Stephen Tweedie <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@transmeta.com>
Cc: Mark Mitchell <mmitchell@eurologic.com>, linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>, Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>, linux-mm@kvack.org, Helge Deller <hdeller@redhat.de>, Steve Lord <lord@sgi.com>
Subject: [PATCH-2.4.2ac26] fix raw IO
Message-ID: <20010328054930.A10669@redhat.com>
References: <3ABBA330.2ADCEBAA@eurologic.com> <E14gZoY-0005Xy-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14gZoY-0005Xy-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 23, 2001 at 10:13:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Mar 23, 2001 at 10:13:44PM +0000, Alan Cox wrote:
> > 
> > I really need to know any *specific* issues with RAWIO.
> 
> All I know is that Stephen said he had a set of patches needed to fix rawio.
> I've not applied them nor afaik has Linus.

Ben LaHaise has been testing Oracle on raw IO with the new patches,
and I only got the thumbs up on that yesterday.  Patch below.

This fixes:

 Fix two problems when faulting in pages for direct access:
  Check pmd and pgd entries for validity in follow page; 
  Be prepared to call handle_mm_fault more than once if necessary 
  to complete the page fault.

 Allow raw devices to be unbound by binding to dev (0,0)

 Use SetPageDirty to mark pages dirty in memory after a read from disk

 Wait for pending IO correctly if an error occurs during IO

 Return -EIO if an IO error occurs in the first block of the IO

Cheers,
 Stephen


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.2-ac26.raw-fixes.patch"

--- linux-2.4.2-ac26/drivers/char/raw.c.~1~	Tue Mar 27 18:41:07 2001
+++ linux-2.4.2-ac26/drivers/char/raw.c	Wed Mar 28 03:33:16 2001
@@ -184,7 +184,8 @@
 			 * major/minor numbers make sense. 
 			 */
 
-			if (rq.block_major == NODEV || 
+			if ((rq.block_major == NODEV && 
+			     rq.block_minor != NODEV) ||
 			    rq.block_major > MAX_BLKDEV ||
 			    rq.block_minor > MINORMASK) {
 				err = -EINVAL;
@@ -313,24 +314,21 @@
 		err = map_user_kiobuf(rw, iobuf, (unsigned long) buf, iosize);
 		if (err)
 			break;
-#if 0
-		err = lock_kiovec(1, &iobuf, 1);
-		if (err) 
-			break;
-#endif
-	
+
 		for (i=0; i < blocks; i++) 
 			b[i] = blocknr++;
 		
 		err = brw_kiovec(rw, 1, &iobuf, dev, b, sector_size);
-
+		if (rw == READ && err > 0)
+			mark_dirty_kiobuf(iobuf, err);
+		
 		if (err >= 0) {
 			transferred += err;
 			size -= err;
 			buf += err;
 		}
 
-		unmap_kiobuf(iobuf); /* The unlock_kiobuf is implicit here */
+		unmap_kiobuf(iobuf);
 
 		if (err != iosize)
 			break;
--- linux-2.4.2-ac26/fs/buffer.c.~1~	Tue Mar 27 18:41:40 2001
+++ linux-2.4.2-ac26/fs/buffer.c	Wed Mar 28 03:33:16 2001
@@ -2016,12 +2016,12 @@
 
 static int wait_kio(int rw, int nr, struct buffer_head *bh[], int size)
 {
-	int iosize;
+	int iosize, err;
 	int i;
 	struct buffer_head *tmp;
 
-
 	iosize = 0;
+	err = 0;
 	spin_lock(&unused_list_lock);
 
 	for (i = nr; --i >= 0; ) {
@@ -2038,13 +2038,16 @@
                            clearing iosize on error calculates the
                            amount of IO before the first error. */
 			iosize = 0;
+			err = -EIO;
 		}
 		__put_unused_buffer_head(tmp);
 	}
 	
 	spin_unlock(&unused_list_lock);
 
-	return iosize;
+	if (iosize)
+		return iosize;
+	return err;
 }
 
 /*
@@ -2157,29 +2160,22 @@
 		} /* End of page loop */		
 	} /* End of iovec loop */
 
+ error:
 	/* Is there any IO still left to submit? */
 	if (bhind) {
-		err = wait_kio(rw, bhind, bh, size);
-		if (err >= 0)
-			transferred += err;
+		int tmp_err;
+		tmp_err = wait_kio(rw, bhind, bh, size);
+		if (tmp_err >= 0)
+			transferred += tmp_err;
 		else
-			goto finished;
+			if (!err)
+				err = tmp_err;
 	}
 
  finished:
 	if (transferred)
 		return transferred;
 	return err;
-
- error:
-	/* We got an error allocating the bh'es.  Just free the current
-           buffer_heads and exit. */
-	spin_lock(&unused_list_lock);
-	for (i = bhind; --i >= 0; ) {
-		__put_unused_buffer_head(bh[i]);
-	}
-	spin_unlock(&unused_list_lock);
-	goto finished;
 }
 
 /*
--- linux-2.4.2-ac26/include/linux/iobuf.h.~1~	Thu Feb 22 00:10:12 2001
+++ linux-2.4.2-ac26/include/linux/iobuf.h	Wed Mar 28 03:33:16 2001
@@ -64,6 +64,7 @@
 void	unmap_kiobuf(struct kiobuf *iobuf);
 int	lock_kiovec(int nr, struct kiobuf *iovec[], int wait);
 int	unlock_kiovec(int nr, struct kiobuf *iovec[]);
+void	mark_dirty_kiobuf(struct kiobuf *iobuf, int bytes);
 
 /* fs/iobuf.c */
 
--- linux-2.4.2-ac26/mm/memory.c.~1~	Tue Mar 27 18:41:50 2001
+++ linux-2.4.2-ac26/mm/memory.c	Wed Mar 28 03:36:42 2001
@@ -382,20 +382,33 @@
 /*
  * Do a quick page-table lookup for a single page. 
  */
-static struct page * follow_page(unsigned long address) 
+static struct page * follow_page(unsigned long address, int write) 
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
+	pte_t *ptep, pte;
 
 	pgd = pgd_offset(current->mm, address);
+	if (pgd_none(*pgd) || pgd_bad(*pgd))
+		goto out;
+
 	pmd = pmd_offset(pgd, address);
-	if (pmd) {
-		pte_t * pte = pte_offset(pmd, address);
-		if (pte && pte_present(*pte))
-			return pte_page(*pte);
+	if (pmd_none(*pmd) || pmd_bad(*pmd))
+		goto out;
+
+	ptep = pte_offset(pmd, address);
+	if (!ptep)
+		goto out;
+
+	pte = *ptep;
+	if (pte_present(pte)) {
+		if (!write ||
+		    (pte_write(pte) && pte_dirty(pte)))
+			return pte_page(pte);
 	}
-	
-	return NULL;
+
+out:
+	return 0;
 }
 
 /* 
@@ -425,7 +438,7 @@
 	struct vm_area_struct *	vma = 0;
 	struct page *		map;
 	int			i;
-	int			datain = (rw == READ);
+	int			to_user = (rw == READ);
 	
 	/* Make sure the iobuf is not already mapped somewhere. */
 	if (iobuf->nr_pages)
@@ -448,13 +461,18 @@
 	iobuf->length = len;
 	
 	i = 0;
+
+	spin_lock(&mm->page_table_lock);
 	
 	/* 
 	 * First of all, try to fault in all of the necessary pages
 	 */
 	while (ptr < end) {
 		if (!vma || ptr >= vma->vm_end) {
+
+			spin_unlock(&mm->page_table_lock);
 			vma = find_vma(current->mm, ptr);
+
 			if (!vma) 
 				goto out_unlock;
 			if (vma->vm_start > ptr) {
@@ -463,34 +481,49 @@
 				if (expand_stack(vma, ptr))
 					goto out_unlock;
 			}
-			if (((datain) && (!(vma->vm_flags & VM_WRITE))) ||
-					(!(vma->vm_flags & VM_READ))) {
+			if (((to_user) && (!(vma->vm_flags & VM_WRITE))) ||
+			    (!(vma->vm_flags & VM_READ))) {
 				err = -EACCES;
 				goto out_unlock;
 			}
+
+			spin_lock(&mm->page_table_lock);
 		}
-		if (handle_mm_fault(current->mm, vma, ptr, datain) <= 0) 
-			goto out_unlock;
-		spin_lock(&mm->page_table_lock);
-		map = follow_page(ptr);
-		if (!map) {
+		while (1) {
+			int ret;
+			
+			map = follow_page(ptr, to_user);
+			if (map) {
+				map = get_page_map(map);
+				if (map) {
+					flush_dcache_page(map);
+					atomic_inc(&map->count);
+				} else
+					printk (KERN_INFO
+						"Mapped page missing [%d]\n", 
+						i);
+				break;
+			}
+			
 			spin_unlock(&mm->page_table_lock);
-			dprintk (KERN_ERR "Missing page in map_user_kiobuf\n");
-			goto out_unlock;
+
+			ret = handle_mm_fault(current->mm, vma, ptr, to_user);
+			if (ret <= 0) {
+				if (ret)
+					err = -ENOMEM;
+				goto out_unlock;
+			}
+
+			spin_lock(&mm->page_table_lock);
 		}
-		map = get_page_map(map);
-		if (map) {
-			flush_dcache_page(map);
-			atomic_inc(&map->count);
-		} else
-			printk (KERN_INFO "Mapped page missing [%d]\n", i);
-		spin_unlock(&mm->page_table_lock);
+		
 		iobuf->maplist[i] = map;
 		iobuf->nr_pages = ++i;
 		
 		ptr += PAGE_SIZE;
 	}
 
+	spin_unlock(&mm->page_table_lock);
 	up_write(&mm->mmap_sem);
 	dprintk ("map_user_kiobuf: end OK\n");
 	return 0;
@@ -524,6 +557,39 @@
 	
 	iobuf->nr_pages = 0;
 	iobuf->locked = 0;
+}
+
+
+/*
+ * Mark all of the pages in a kiobuf as dirty 
+ *
+ * We need to be able to deal with short reads from disk: if an IO error
+ * occurs, the number of bytes read into memory may be less than the
+ * size of the kiobuf, so we have to stop marking pages dirty once the
+ * requested byte count has been reached.
+ */
+
+void mark_dirty_kiobuf(struct kiobuf *iobuf, int bytes)
+{
+	int index, offset, remaining;
+	struct page *page;
+	
+	index = iobuf->offset >> PAGE_SHIFT;
+	offset = iobuf->offset & ~PAGE_MASK;
+	remaining = bytes;
+	if (remaining > iobuf->length)
+		remaining = iobuf->length;
+	
+	while (remaining > 0 && index < iobuf->nr_pages) {
+		page = iobuf->maplist[index];
+		
+		if (!PageReserved(page))
+			SetPageDirty(page);
+
+		remaining -= (PAGE_SIZE - offset);
+		offset = 0;
+		index++;
+	}
 }
 
 

--EVF5PPMfhYS0aIcm--
