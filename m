Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUDDDct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 22:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUDDDct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 22:32:49 -0500
Received: from fmr04.intel.com ([143.183.121.6]:29828 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262132AbUDDDcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 22:32:43 -0500
Message-Id: <200404040331.i343VSF02496@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ray Bryant'" <raybry@sgi.com>
Cc: "'Andy Whitcroft'" <apw@shadowen.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <anton@samba.org>, <sds@epoch.ncsc.mil>,
       <ak@suse.de>, <lse-tech@lists.sourceforge.net>,
       <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH] HUGETLB memory commitment
Date: Sat, 3 Apr 2004 19:31:30 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQZLs0naZSwwrMERgOmQX3qNMQK7gAwmbyw
In-Reply-To: <406E3613.6080609@sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Ray Bryant wrote on Fri, April 02, 2004 7:57 PM
> Chen, Kenneth W wrote:
> >
> > Can we just RIP this whole hugetlb page overcommit?
> >
>
> Ken et al,
>
> Perhaps the following patch might be more to your liking.  I'm
> sorry I haven't been contributing to this discussion -- I've been
> off doing this code first for Altix under 2.4.21 (one's got to eat,
> after all).  Now I've ported the changes forward to Linux 2.6.5-rc3
> and tested them.  The patch below is relative to that version of Linux.

Somehow the patch came through with extra white space at beginning of
each line, but s/^  / / fix that up.


> The hugetlb memory commit code does this with a single global counter:
> htlbzone_reserved, and a per inode reserved page count.  The latter is
> used to decrement the global reserved page count when the inode is
> deleted or the file is truncated.

A simple counter won't work for different file offset mapping.  It has to
be some sort of per-inode, per-block reservation tracking.  I think we are
steering in the right direction though.


> diff -Nru a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> --- a/fs/hugetlbfs/inode.c	Fri Apr  2 19:31:56 2004
> +++ b/fs/hugetlbfs/inode.c	Fri Apr  2 19:31:56 2004
> @@ -59,19 +58,34 @@
>   	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
>   		return -EINVAL;
>
> -	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
> + 	reserved_pages = (vma->vm_end - vma->vm_start) >> HPAGE_SHIFT;
>
>   	down(&inode->i_sem);
>   	file_accessed(file);
> +
> + 	/* a second mmap() (or a rmap()) can change the reservation */
> + 	prev_reserved_pages = inode->u.data;
> +
> + 	/*
> + 	 * if current mmap() is smaller than previous reservation,
> + 	 * we don't change reservation or quota
> + 	 */
> + 	if (reserved_pages >= prev_reserved_pages) {
> + 		new_reservation = reserved_pages - prev_reserved_pages;
> + 		if ((hugetlb_get_quota(mapping, new_reservation) < 0) ||
> + 			(hugetlb_reserve(new_reservation) < 0)) {
> + 				up(&inode->i_sem);
> + 				return -ENOMEM;
> + 		}
> + 		inode->i_size = reserved_pages << HPAGE_SHIFT;
> + 		inode->u.data = reserved_pages;
> + 	}
> +	up(&inode->i_sem);
> +

This assumes all mmap start from the same file offset. IMO, it's not
generic enough. This code will only reserve 1 page for the following
case, but actually there are 4 mapping totaling 4 pages:

mmap 1 page at file offset 0
mmap 1 page at file offset HPAGE_SIZE,
mmap 1 page at file offset HPAGE_SIZE*2,
mmap 1 page at file offset HPAGE_SIZE*3,

Oh, this code broke file system quota accounting as well.

- Ken


