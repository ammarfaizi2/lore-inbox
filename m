Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTE2ESn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 00:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTE2ESn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 00:18:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:65435 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261861AbTE2ESl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 00:18:41 -0400
Date: Thu, 29 May 2003 10:13:12 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Inline vm_acct_memory
Message-ID: <20030529044312.GG5604@in.ibm.com>
References: <20030528110552.GF5604@in.ibm.com> <Pine.LNX.4.44.0305281631030.1240-100000@localhost.localdomain> <20030528192330.77d3d9e9.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528192330.77d3d9e9.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 07:23:30PM -0700, Andrew Morton wrote:
>... 
> Maybe I'm wrong.  kernbench is not some silly tight-loop microbenchmark. 
> It is a "real" workload: gcc.
> 
> The thing about pagetable setup and teardown is that it tends to be called
> in big lumps: for a while the process is establishing thousands of pages
> and then later it is tearing down thousands.  So the cache-thrashing impact
> of having those eighteen instances sprinkled around the place is less
> than it would be if they were all being called randomly.  If you can believe
> such waffle.
> 
> Kiran, do you still have the raw data available?  profiles and runtimes?

Yeah I kinda overlooked vm_unacct_memory 'til I wondered why I had put
the inlines in the header file earlier :).  But I do have the profiles
and checking on all calls to vm_unacct_memory, I find there is no 
regression at significant callsites.  
I can provide the detailed profile if required,
but here is the summary for 4 runs of kernbench -- nos against routines
are profile ticks (oprofile) for 4 runs.


Vanilla
-------
vm_enough_memory 786 778 780 735
vm_acct_memory	870 952 884 898
-----------------------------------
tot of above    1656 1730 1664 1633

do_mmap_pgoff 	3559 3673 3669 3807
expand_stack	27 34 33 42
unmap_region	236 267 280 280
do_brk		594 596 615 615
exit_mmap	51 52 44 52	
mprotect_fixup	47 55 55 57
do_mremap	0 2 1 1
shmem_notify_change 0 0 0 0
shmem_notify_change 0 0 0 0	
shmem_delete_inode  0 0 0 0
shmem_file_write 0 0 0 0	
shmem_symlink  0 0 0 0
shmem_file_setup 0 0 0 0
sys_swapoff	0 0 0 0
poll_idle	101553 108687 89281 86251

Inline
------
vm_enough_memory 1539 1488 1488 1472
do_mmap_pgoff 	3510 3523 3436 3475
expand_stack	27 33 32 27
unmap_region	295 340 311 349
do_brk		641 583 659 640
exit_mmap	33 52 44 42
mprotect_fixup	54 65 73 64
do_mremap	2 0 0 0
shmem_notify_change 0 0 0 0
shmem_notify_change 0 0 0 0	
shmem_delete_inode  0 0 0 0
shmem_file_write 0 0 0 0	
shmem_symlink  0 0 0 0
shmem_file_setup 0 0 0 0
sys_swapoff	0 0 0 0
poll_idle	98733 85659 104994 103096


Thanks,
Kiran
