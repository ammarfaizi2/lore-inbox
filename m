Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQJ3LqP>; Mon, 30 Oct 2000 06:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129034AbQJ3LqG>; Mon, 30 Oct 2000 06:46:06 -0500
Received: from ns.caldera.de ([212.34.180.1]:275 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129030AbQJ3Lpx>;
	Mon, 30 Oct 2000 06:45:53 -0500
Date: Mon, 30 Oct 2000 12:45:13 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
Message-ID: <20001030124513.A28667@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200010272123.OAA21478@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Oct 27, 2000 at 02:23:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 02:23:04PM -0700, Linus Torvalds wrote:
>
> [...]
>
> That solution, btw, might be as simple as just saying:
> 
>  - raw IO is based on physical pages, and the COW mapping crated by
>    fork() may cause the changes to be visibile to either child or parent
>    or both, depending on usage patterns to the page in question.  For
>    repeatable behaviour, do not have outstanding direct IO in progress
>    over a fork().
> 
> Ie, just _document_ it. It's not _wrong_, it can just be surprising (but
> it is actually entirely straightforward and sane if you just look at it
> the right way).

Ok, here is an updated patch witout that change, but instead with a little
piece of kiobuf documentation that does document this and other things
related to kiobufs.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.


--- linux.orig/drivers/char/raw.c	Thu Oct 19 13:21:24 2000
+++ linux/drivers/char/raw.c	Sun Oct 29 20:55:43 2000
@@ -277,8 +277,11 @@
 	
 	if ((*offp & sector_mask) || (size & sector_mask))
 		return -EINVAL;
-	if ((*offp >> sector_bits) > limit)
+	if ((*offp >> sector_bits) > limit) {
+		if (size)
+			return -ENXIO;
 		return 0;
+	}
 
 	/* 
 	 * We'll just use one kiobuf
--- linux.orig/fs/buffer.c	Fri Oct 27 12:28:40 2000
+++ linux/fs/buffer.c	Sun Oct 29 20:55:43 2000
@@ -1924,6 +1924,8 @@
 	
 	spin_unlock(&unused_list_lock);
 
+	if (!iosize)
+		return -EIO;
 	return iosize;
 }
 
--- linux.orig/mm/memory.c	Fri Oct 27 12:28:42 2000
+++ linux/mm/memory.c	Sun Oct 29 20:56:09 2000
@@ -382,9 +382,12 @@
 
 
 /*
- * Do a quick page-table lookup for a single page. 
+ * Do a quick page-table lookup for a single page. We have already verified
+ * access type, and done a fault in. But, kswapd might have stolen the page
+ * in the meantime. Return an indication of whether we should retry the fault
+ * in. Writability test is superfluous but conservative.
  */
-static struct page * follow_page(unsigned long address) 
+static struct page * follow_page(unsigned long address, int writeacc, int * ret) 
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -393,10 +396,15 @@
 	pmd = pmd_offset(pgd, address);
 	if (pmd) {
 		pte_t * pte = pte_offset(pmd, address);
-		if (pte && pte_present(*pte))
+		if (pte && pte_present(*pte)) {
+			if (writeacc && !pte_write(*pte))
+				goto retry;
 			return pte_page(*pte);
+		}
 	}
-	
+
+retry:
+	*ret = 1;
 	return NULL;
 }
 
@@ -428,7 +436,8 @@
 	struct page *		map;
 	int			i;
 	int			datain = (rw == READ);
-	
+	int			failed;
+
 	/* Make sure the iobuf is not already mapped somewhere. */
 	if (iobuf->nr_pages)
 		return -EINVAL;
@@ -467,18 +476,22 @@
 			}
 			if (((datain) && (!(vma->vm_flags & VM_WRITE))) ||
 					(!(vma->vm_flags & VM_READ))) {
-				err = -EACCES;
 				goto out_unlock;
 			}
 		}
+
+faultin:
 		if (handle_mm_fault(current->mm, vma, ptr, datain) <= 0) 
 			goto out_unlock;
 		spin_lock(&mm->page_table_lock);
-		map = follow_page(ptr);
-		if (!map) {
+		map = follow_page(ptr, datain, &failed);
+		if (failed) {
+			/*
+			 * Page got stolen before we could lock it down.
+			 * Retry.
+			 */
 			spin_unlock(&mm->page_table_lock);
-			dprintk (KERN_ERR "Missing page in map_user_kiobuf\n");
-			goto out_unlock;
+			goto faultin;
 		}
 		map = get_page_map(map);
 		if (map)
diff -uNr linux.orig/Documentation/kiobuf.txt linux/Documentation/kiobuf.txt
--- linux.orig/Documentation/kiobuf.txt	Thu Jan  1 01:00:00 1970
+++ linux/Documentation/kiobuf.txt	Sun Oct 29 21:38:20 2000
@@ -0,0 +1,100 @@
+		Abstract Kernel IO Buffers
+		      Under Linux
+	
+	    Christoph Hellwig <hch@caldera.de>
+
+
+This document describes the kiobuf concept used in the Linux Kernel
+IO/memory subsystem.  It describes it's usages, functions working
+with kernel IO buffers and show some examples for kiobuf usage.
+
+
+The main reason for implementing kernel IO buffers (by Stephen Tweedie)
+was the lack of raw devices support in Linux kernels <= 2.2.  Raw devices
+are the character devices that AT&T derived UNIX version implement to
+allow character based uncached access to mass storage devices.  In
+Linux kernels <= 2.2 all blockdevice IO goes either through the buffer-
+or pagecache, so that applications like databases cannot get full
+control over their data.
+
+The solution in Linux 2.3 an higher is that the new raw devices driver
+locks down the virtual memory it gets passed by the ->read and ->write
+methods and does physical page io on them, bypassing the caches.
+NOTE: the physical memory referenced by kiobufs does - unlike nearly
+everything else in the Linux memory managment - not have reasonable COW
+semenantics. So don't even try to fork when doing rawio or using
+user-space memory in kiobufs in an other way.
+
+
+To use iobufs in this way you need to allocate one or more kiobufs (an
+array of kiobufs is called kiovec - do not confuse those with BSD iovecs).
+
+	err = alloc_kiovec (count, iovec);
+
+This allocates the memory for the wanted number of kiobufs (and adds them
+to a cache) and initalizes some variables - in an OO-language this would be
+the constructor.  Then you force the virtual memory to faulted in and locked
+in physical memory and reference it by the kiobuf. (NOTE: this must be done
+for each iobuf, not for the whole iovec).
+
+	err = map_user_kiobuf (rw, iobuf, address, len);
+
+After that you request IO against the wanted device.  For the case of
+raw devices where IO should be requested against a blockdevice, there
+is a function in fs/buffer.c that does exactly this. (the parameter 
+'blocks' is an array of the block numbers the IO should be requested
+against)
+
+	err = brw_kiovec (rw, count, iovec, dev, blocks, sector_size);
+
+After the IO for this iobuf is done, unmap the virtual memory.
+
+	unmap_kiobuf (iobuf);
+
+And when we are finished with the iovev, free it.
+
+	free_kiovec (count, iovec);
+
+
+Locking down user memory and doing mass storage device IO with it is not
+the only purpose of kiobufs.  Another use for kiobufs is allowing
+user-space mmaping dma memory, e.g in sound drivers.  To do so you
+need to lock-down kernel virtual memory and refernece it using kiobufs.
+The code that does exactly this is not yet in the kernel - get Stephen
+Tweedie's kiobuf patchset if you want to use this.
+
+
+In the long term it looks like all blockdev IO will be done using
+kiobufs.  In the SGI XFS tree there is code that allows passing kiovecs
+to the individual low-level block drivers.  There are lots of advantages
+of doing it this way:  the page cache doesn't need to fit the outstanding
+io into lots of bufferheads, passing each bufferhead to ll_rw_block()
+where the elevator merges some of them together for better device usage
+and submits them to the drivers.  Instead the cache locks down the pages
+and submits the kiovec to the low-level driver.  The lowlevel driver knows
+better how the request should be splitted for dmaing or whatever.  On the
+other hand software RAID or LVM get more complicated:  instead of just
+doing block-remapping they must split the kiobufs and - in case of LVM -
+find ways to do efficient IO on continguos areas.
+
+
+
+References:
+
+	Linux Kernel Sourcecode
+	    (fs/buffer.c, fs/iobufs.c, mm/memory.c, drivers/char/raw.c)
+	
+	SGI XFS for Linux
+	    (http://oss.sgi.com/projects/linux-xfs/)
+	
+	Stephen Tweedies kiobuf patchset
+	    (ftp://ftp.linux.org.uk/pub/linux/sct/fs/raw-io/)
+
+	Linux MM mailinglist
+	    (http://humbolt.geo.uu.nl/Linux-MM/linux-mm.html)
+
+
+Thanks to Arjan van de Ven, Daniel Phillips and Marcelo Tosatti for
+proofreading this document and giving usefull hints.
+
+$Id: kiobuf.txt,v 1.2 2000/10/29 20:37:54 hch Exp hch $
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
