Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbSLJHsA>; Tue, 10 Dec 2002 02:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbSLJHsA>; Tue, 10 Dec 2002 02:48:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:39332 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266731AbSLJHr6>;
	Tue, 10 Dec 2002 02:47:58 -0500
Message-ID: <3DF59DF7.F1E18835@digeo.com>
Date: Mon, 09 Dec 2002 23:55:35 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kingsley Cheung <kingsley@aurema.com>
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [TRIVIAL PATCH 2.4.20] madvise_willneed makes bad limit comparison
References: <20021209150426.D12270@aurema.com> <3DF43855.19F24E73@digeo.com> <20021210170841.D8843@aurema.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2002 07:55:35.0885 (UTC) FILETIME=[85CB3FD0:01C2A021]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kingsley Cheung wrote:
> 
>...
> So then something of the following without the check is more
> appropriate or a starting point then?
> 

Looks good to me.   Here's a 2.5 version...

 include/linux/mm.h |    1 +
 mm/filemap.c       |   12 +-----------
 mm/madvise.c       |   23 +++++------------------
 mm/readahead.c     |   13 +++++++++++++
 4 files changed, 20 insertions(+), 29 deletions(-)

--- 25/mm/filemap.c~max_sane_readahead	Mon Dec  9 23:44:47 2002
+++ 25-akpm/mm/filemap.c	Mon Dec  9 23:47:14 2002
@@ -898,20 +898,10 @@ static ssize_t
 do_readahead(struct address_space *mapping, struct file *filp,
 	     unsigned long index, unsigned long nr)
 {
-	unsigned long max;
-	unsigned long active;
-	unsigned long inactive;
-
 	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage)
 		return -EINVAL;
 
-	/* Limit it to a sane percentage of the inactive list.. */
-	get_zone_counts(&active, &inactive);
-	max = inactive / 2;
-	if (nr > max)
-		nr = max;
-
-	do_page_cache_readahead(mapping, filp, index, nr);
+	do_page_cache_readahead(mapping, filp, index, max_sane_readahead(nr));
 	return 0;
 }
 
--- 25/mm/readahead.c~max_sane_readahead	Mon Dec  9 23:44:55 2002
+++ 25-akpm/mm/readahead.c	Mon Dec  9 23:48:39 2002
@@ -465,3 +465,16 @@ void handle_ra_miss(struct address_space
 			ra->next_size = min;
 	}
 }
+
+/*
+ * Given a desired number of PAGE_CACHE_SIZE readahead pages, return a
+ * sensible upper limit.
+ */
+unsigned long max_sane_readahead(unsigned long nr)
+{
+	unsigned long active;
+	unsigned long inactive;
+
+	get_zone_counts(&active, &inactive);
+	return min(nr, inactive / 2);
+}
--- 25/include/linux/mm.h~max_sane_readahead	Mon Dec  9 23:47:45 2002
+++ 25-akpm/include/linux/mm.h	Mon Dec  9 23:48:06 2002
@@ -524,6 +524,7 @@ void page_cache_readaround(struct addres
 			   unsigned long offset);
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra);
+unsigned long max_sane_readahead(unsigned long nr);
 
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct * vma, unsigned long address);
--- 25/mm/madvise.c~max_sane_readahead	Mon Dec  9 23:52:37 2002
+++ 25-akpm/mm/madvise.c	Mon Dec  9 23:52:41 2002
@@ -51,36 +51,23 @@ static long madvise_behavior(struct vm_a
 }
 
 /*
- * Schedule all required I/O operations, then run the disk queue
- * to make sure they are started.  Do not wait for completion.
+ * Schedule all required I/O operations.  Do not wait for completion.
  */
 static long madvise_willneed(struct vm_area_struct * vma,
 			     unsigned long start, unsigned long end)
 {
-	long error = -EBADF;
-	struct file * file;
-	unsigned long size, rlim_rss;
+	struct file *file = vma->vm_file;
 
-	/* Doesn't work if there's no mapped file. */
 	if (!vma->vm_file)
-		return error;
-	file = vma->vm_file;
-	size = (file->f_dentry->d_inode->i_size + PAGE_CACHE_SIZE - 1) >>
-							PAGE_CACHE_SHIFT;
+		return -EBADF;
 
 	start = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 	if (end > vma->vm_end)
 		end = vma->vm_end;
 	end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 
-	/* Make sure this doesn't exceed the process's max rss. */
-	error = -EIO;
-	rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
-				LONG_MAX; /* default: see resource.h */
-	if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
-		return error;
-
-	do_page_cache_readahead(file->f_dentry->d_inode->i_mapping, file, start, end - start);
+	do_page_cache_readahead(file->f_dentry->d_inode->i_mapping,
+			file, start, max_sane_readahead(end - start));
 	return 0;
 }
 

_
