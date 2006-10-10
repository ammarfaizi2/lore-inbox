Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWJJTaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWJJTaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWJJTaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:30:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:29741 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030222AbWJJTaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:30:08 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="144296164:sNHT21428246"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>
Cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Hugepage regression
Date: Tue, 10 Oct 2006 12:30:07 -0700
Message-ID: <000101c6eca2$7e84fe60$cb34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbsoNunZiHMtnHETdC+/w8B4doNFgAADO3g
In-Reply-To: <Pine.LNX.4.64.0610101958270.21452@blonde.wat.veritas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote on Tuesday, October 10, 2006 12:18 PM
> On Tue, 10 Oct 2006, Chen, Kenneth W wrote:
> > 
> > With the pending shared page table for hugetlb currently sitting in -mm,
> > we serialize the all hugetlb unmap with a per file i_mmap_lock.  This
> > race could well be solved by that pending patch?
> > 
> >
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/broken-out/shared-page-table-for-hugetlb-page-v
4.patch
> 
> Hey, nice try, Ken!  But I don't think we can let you sneak shared
> pagetables into 2.6.19 that way ;)

It wasn't my intention to sneak in shared page table, though it does
sort of look like so.


> Yes, I'd expect your i_mmap_lock to solve the problem: and since
> you're headed in that direction anyway, it makes most sense to use
> that solution rather than get into defining arrays, or sacrificing
> the lazy flush, or risking page_count races.
> 
> So please extract the __unmap_hugepage_range mods from your shared
> pagetable patch, and use that to fix the bug.

OK, I was about to do so too.


> But again, I protest
> the "if (vma->vm_file)" in your unmap_hugepage_range - how would a
> hugepage area ever have NULL vma->vm_file?

It's coming from do_mmap_pgoff(), file->f_op->mmap can fail with error
code (e.g. not enough hugetlb page) and in the error recovery path, it
nulls out vma->vm_file first before calls down to unmap_region().  I
asked that question before: can we reverse that order (call unmap_region
and then nulls out vma->vmfile and fput)?

unmap_and_free_vma:
        if (correct_wcount)
                atomic_inc(&inode->i_writecount);
        vma->vm_file = NULL;
        fput(file);

        /* Undo any partial mapping done by a device driver. */
        unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);

