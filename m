Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWAWTvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWAWTvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWAWTvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:51:14 -0500
Received: from gold.veritas.com ([143.127.12.110]:33701 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932461AbWAWTvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:51:13 -0500
Date: Mon, 23 Jan 2006 19:51:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Don Dupuis <dondster@gmail.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Adam Litke <agl@us.ibm.com>, William Irwin <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't mlock hugetlb in 2.6.15
In-Reply-To: <632b79000601221832w4cb44582y823ee7dc80e9a34f@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601231917210.5915@goblin.wat.veritas.com>
References: <632b79000601181149o67f1c013jfecc5e32ee17fe7e@mail.gmail.com> 
 <20060120235240.39d34279.akpm@osdl.org>  <43D24167.1010007@yahoo.com.au>
 <632b79000601221832w4cb44582y823ee7dc80e9a34f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Jan 2006 19:51:12.0654 (UTC) FILETIME=[5D0542E0:01C62056]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006, Don Dupuis wrote:
> On 1/21/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > Andrew Morton wrote:
> > > Don Dupuis <dondster@gmail.com> wrote:
> > >>I have an app that mlocks hugepages. The same app works just fine in 2.6.14.
> > > That being said, we shouldn't have broken your application.
> > Don, an strace log of the failing sequence of syscalls could be helpful.
> 
> sducstart:
> open("/pivot3/mem/sduc", O_RDWR|O_CREAT, 0666) = 3
> mmap2(NULL, 1761607680, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_LOCKED,
> 3, 0) = 0x4e000000
> 
> This is the strace output of sductest that is a test program to access
> the shared memory that was setup by sducstart:
> open("/pivot3/mem/sduc", O_RDWR)        = 3
> mmap2(NULL, 4194304, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_LOCKED, 3,
> 0) = -1 ENOMEM (Cannot allocate memory)

Thanks a lot for the strace, that indeed helped to track it down.

This has nothing to do with mlock or MAP_LOCKED - which by the way do
make more sense in 2.6.15, since they provide a way of prefaulting the
hugepage area like in earlier releases (now hugepages are being faulted
in on demand, though never paged out, as Andrew said).

Please try the patch below, and let us know if it works for you - thanks.
Looks like we'll need this in 2.6.16-rc-git and 2.6.15-stable.


2.6.15's hugepage faulting introduced huge_pages_needed accounting into
hugetlbfs: to count how many pages are already in cache, for spot check
on how far a new mapping may be allowed to extend the file.  But it's
muddled: each hugepage found covers HPAGE_SIZE, not PAGE_SIZE.  Once
pages were already in cache, it would overshoot, wrap its hugepages
count backwards, and so fail a harmless repeat mapping with -ENOMEM.
Fixes the problem found by Don Dupuis.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/hugetlbfs/inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- 2.6.15/fs/hugetlbfs/inode.c	2006-01-03 03:21:10.000000000 +0000
+++ linux/fs/hugetlbfs/inode.c	2006-01-23 18:39:47.000000000 +0000
@@ -71,8 +71,8 @@ huge_pages_needed(struct address_space *
 	unsigned long start = vma->vm_start;
 	unsigned long end = vma->vm_end;
 	unsigned long hugepages = (end - start) >> HPAGE_SHIFT;
-	pgoff_t next = vma->vm_pgoff;
-	pgoff_t endpg = next + ((end - start) >> PAGE_SHIFT);
+	pgoff_t next = vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT);
+	pgoff_t endpg = next + hugepages;
 
 	pagevec_init(&pvec, 0);
 	while (next < endpg) {
