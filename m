Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312027AbSCTTKU>; Wed, 20 Mar 2002 14:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSCTTKL>; Wed, 20 Mar 2002 14:10:11 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:53439 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312027AbSCTTJw>; Wed, 20 Mar 2002 14:09:52 -0500
Date: Wed, 20 Mar 2002 11:09:05 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <127930000.1016651345@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please forgive the following for deliberate simplifiations and accidental misunderstandings. 
If you flame gently, *maybe* we can pull something useful out of the ashen remains ;-)

This is an evolution of my original plan to do per-cpu persisent kmap pools a
couple of months ago - thanks to Rik for pointing out this was not going to work.

OK, so currently we divide the virtual address space into user space (u-space) and kernel 
space (k-space) at the PAGE_OFFSET boundary, with two fundamental differences that I'm 
interested in for the sake of this argument.

1. u-space has different protections from k-space (ie user can't read/write it directly)

2. u-space is per task. k-space is common across all tasks.

Imagine we create a hybrid "u-k-space" with the protections of k-space, but the locality
of u-space .... either by making part of the current k-space per task or by making part of
the current u-space protected like k-space ... not sure which would be easier.

This u-k-space would be a good area for at least two things (and probably others):

1. A good place to put the process pagetables. We only use up the amount of virtual
address space (vaddr space) for one task's pagetables - if we map them into ZONE_NORMAL 
(as current mainline) we use up vaddr space for *all* task's pagetables - if we map them 
through kmap (atomic or persistent), we pay dearly in tlbflushes.

2. A good place to make a per-task kmap area. This would be on a pool system similar to
the current persistent kmap. We would potentially do only a local cpu tlb_flush_all when
this table ran out (though if we're clever, we can use the context switches tlb_flush to
do this for us). This would make copy_to_user stuff that's currently done under kmap
cheaper.

This, unfortunately, isn't a total solution - we may sometimes need to modify the task's
pagetables from outside the process context, eg. swapout (thanks to dmc for pointing
this out to me ;-)). For this, we'd just use the existing kmap mechanism to create another
mapping to use temporarily, and we're no worse off than before. But on the whole I think 
it wins us enough to be worthwhile.

Opinions?

Martin.



