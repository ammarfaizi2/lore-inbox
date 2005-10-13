Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVJMAp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVJMAp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVJMAp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:45:28 -0400
Received: from gold.veritas.com ([143.127.12.110]:40209 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751233AbVJMAp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:45:27 -0400
Date: Thu, 13 Oct 2005 01:44:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] mm: page fault scalability nearer
Message-ID: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:45:27.0307 (UTC) FILETIME=[677745B0:01C5CF8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here comes the second batch of my page fault scalability patches.
It starts off with a few small adjustments, takes a detour around
update_mem_hiwater in 06/21, then really gets under way with 09/21.

It ends with almost all of the changes complete in the common core, but
still using page_table_lock unscalably.  Scattered changes to arch files,
nothing major, needed before finally splitting the lock in the third batch.

This batch is against 2.6.14-rc2-mm2 plus Nick's core remove PageReserved.
18/21 is a small fix to that patch, you may want to move it down there.

Hugh

 Documentation/cachetlb.txt         |    9 
 arch/alpha/mm/remap.c              |    6 
 arch/arm/mm/consistent.c           |    6 
 arch/arm/mm/ioremap.c              |    4 
 arch/arm/mm/mm-armv.c              |   14 
 arch/arm/oprofile/backtrace.c      |   46 --
 arch/arm26/mm/memc.c               |   18 -
 arch/cris/mm/ioremap.c             |    4 
 arch/frv/mm/dma-alloc.c            |    5 
 arch/i386/mm/ioremap.c             |    4 
 arch/i386/oprofile/backtrace.c     |   38 --
 arch/ia64/mm/fault.c               |   34 --
 arch/ia64/mm/init.c                |   13 
 arch/ia64/mm/tlb.c                 |    2 
 arch/m32r/mm/ioremap.c             |    4 
 arch/m68k/mm/kmap.c                |    2 
 arch/m68k/sun3x/dvma.c             |    2 
 arch/mips/mm/ioremap.c             |    4 
 arch/parisc/kernel/pci-dma.c       |    2 
 arch/parisc/mm/ioremap.c           |    6 
 arch/ppc/kernel/dma-mapping.c      |    6 
 arch/ppc/mm/4xx_mmu.c              |    4 
 arch/ppc/mm/pgtable.c              |    4 
 arch/ppc64/mm/imalloc.c            |    5 
 arch/ppc64/mm/init.c               |    4 
 arch/s390/mm/ioremap.c             |    4 
 arch/sh/mm/ioremap.c               |    4 
 arch/sh64/mm/ioremap.c             |    4 
 arch/sparc/mm/generic.c            |    4 
 arch/sparc64/mm/generic.c          |    6 
 arch/um/kernel/skas/mmu.c          |    3 
 arch/x86_64/mm/ioremap.c           |    4 
 fs/compat.c                        |    1 
 fs/exec.c                          |   15 
 fs/hugetlbfs/inode.c               |    4 
 fs/proc/task_mmu.c                 |   43 +-
 include/asm-generic/4level-fixup.h |   11 
 include/asm-i386/pgtable.h         |    3 
 include/asm-parisc/tlbflush.h      |    3 
 include/asm-um/pgtable.h           |    2 
 include/linux/hugetlb.h            |    2 
 include/linux/mm.h                 |   85 +++--
 include/linux/rmap.h               |    4 
 include/linux/sched.h              |   29 +
 kernel/exit.c                      |    5 
 kernel/fork.c                      |    2 
 kernel/futex.c                     |    6 
 kernel/sched.c                     |    2 
 mm/filemap_xip.c                   |   15 
 mm/fremap.c                        |   67 +---
 mm/hugetlb.c                       |   27 -
 mm/memory.c                        |  609 +++++++++++++++----------------------
 mm/mempolicy.c                     |    7 
 mm/mmap.c                          |   44 +-
 mm/mprotect.c                      |    7 
 mm/mremap.c                        |   64 +--
 mm/msync.c                         |   21 -
 mm/nommu.c                         |   18 -
 mm/rmap.c                          |  113 +++---
 mm/swapfile.c                      |   20 -
 mm/vmalloc.c                       |    4 
 61 files changed, 623 insertions(+), 885 deletions(-)
