Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUJLN7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUJLN7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 09:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUJLN7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 09:59:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:5607 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263664AbUJLN7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 09:59:21 -0400
Date: Tue, 12 Oct 2004 15:59:19 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: 4level page tables for Linux
Message-ID: <20041012135919.GB20992@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I released a 4level page table patch for 2.6.9rc4.  It is available
from ftp://ftp.suse.com/pub/people/ak/4level/4level-2.6.9rc4-1.gz

It changes the Linux MM which currently only supports 3 levels of 
page tables to support a fourth level (PML4). This is needed to 
exceed more than 512GB of virtual address space per process on x86-64. 
People have been running into the 512GB limit when mmaping large files.

The patch extends all the code in the VM that walks the 3level
hierarchy to handle the fourth level too.

The patch changes x86-64 to now support 47bits (128TB) of virtual
address space per process. 

The changes are fortunately quite localized. Only mm/* had to change
(mostly in straight forward ways), drivers etc. already were well
isolated from the page tables with the get_user_pages() function.
The only exception was DRM, which needed a small patch.

Excluding the i386/x86-64 architecture specific parts the patch looks like:

 drivers/char/drm/drm_memory.h        |    3 
 fs/exec.c                            |    6 
 include/asm-generic/nopml4-page.h    |   11 
 include/asm-generic/nopml4-pgalloc.h |   21 +
 include/asm-generic/nopml4-pgtable.h |   39 ++
 include/asm-generic/pgtable.h        |    2 
 include/asm-generic/tlb.h            |    6 
 include/linux/init_task.h            |    2 
 include/linux/mm.h                   |   10 
 include/linux/sched.h                |    2 
 kernel/fork.c                        |    6 
 mm/fremap.c                          |   18 -
 mm/memory.c                          |  584 ++++++++++++++++++++++++-----------
 mm/mempolicy.c                       |   18 -
 mm/mmap.c                            |   36 +-
 mm/mprotect.c                        |   44 ++
 mm/mremap.c                          |   21 +
 mm/msync.c                           |   43 ++
 mm/rmap.c                            |   21 +
 mm/swapfile.c                        |   61 ++-
 mm/vmalloc.c                         |   85 ++++-

For architectures with less levels of page tables the code should be mostly a 
nop. 

The patch currently only supports x86-64 and i386. Other architectures
will need some changes to compile. The changes to convert an architecture
over are quite straight forward, please see the changes to i386 in
the patch. I renamed all functions that need changing so things
that are broken will not compile.

I will need some help to do this conversion because I can only test
i386 and x86-64 easily.  I can convert architectures over, but someone
will need to test the result.

Plan is to merge it into -mm* ASAP, when the major architectures

have been ported over.

-Andi
