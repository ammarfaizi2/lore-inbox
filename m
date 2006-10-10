Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWJJTSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWJJTSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWJJTSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:18:30 -0400
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:54679 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S932258AbWJJTS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:18:29 -0400
Date: Tue, 10 Oct 2006 20:18:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: RE: Hugepage regression
In-Reply-To: <000001c6ec92$871e5450$cb34030a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0610101958270.21452@blonde.wat.veritas.com>
References: <000001c6ec92$871e5450$cb34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Oct 2006 19:18:10.0628 (UTC) FILETIME=[D30B1840:01C6ECA0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Chen, Kenneth W wrote:
> 
> With the pending shared page table for hugetlb currently sitting in -mm,
> we serialize the all hugetlb unmap with a per file i_mmap_lock.  This
> race could well be solved by that pending patch?
> 
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/broken-out/shared-page-table-for-hugetlb-page-v4.patch

Hey, nice try, Ken!  But I don't think we can let you sneak shared
pagetables into 2.6.19 that way ;)

Sorry for not noticing this bug in your original TLB flush fix,
which had looked good to me.

Yes, I'd expect your i_mmap_lock to solve the problem: and since
you're headed in that direction anyway, it makes most sense to use
that solution rather than get into defining arrays, or sacrificing
the lazy flush, or risking page_count races.

So please extract the __unmap_hugepage_range mods from your shared
pagetable patch, and use that to fix the bug.  But again, I protest
the "if (vma->vm_file)" in your unmap_hugepage_range - how would a
hugepage area ever have NULL vma->vm_file?

Hugh
