Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVKJBnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVKJBnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVKJBnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:43:18 -0500
Received: from silver.veritas.com ([143.127.12.111]:32295 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751373AbVKJBnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:43:18 -0500
Date: Thu, 10 Nov 2005 01:42:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] mm: struct page lock and counts
Message-ID: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:43:17.0576 (UTC) FILETIME=[1F794C80:01C5E598]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here comes a batch of fifteen against 2.6.14-mm1.  The first eight tie
up various loose ends of the page fault scalability patches (but I've
not yet got to Documentation/vm/locking).  The last seven are about page
count overflow, resolving that issue made more immediate by refcounting
the ZERO_PAGE.  So I'd like to see these as 2.6.15 material: and mostly
the patches do apply to 2.6.14-git12; but there's two reiser4 patches I
separated out, an assumption that Andi's x86_64-page-flags-cleanup.patch
will go in ahead, and an obvious reject in vmscan.c.  You may see them
rather differently!  I think there could be two views on the overflow
patches: you might find them neat, you might find them too oblique; but
they do avoid extra tests in the hotter paths.  In some cases I've put
an additional comment below the --- cutoff.

Hugh

 arch/frv/mm/pgalloc.c                    |    4 
 arch/i386/mm/pgtable.c                   |    8 
 arch/powerpc/mm/4xx_mmu.c                |    4 
 arch/powerpc/mm/hugetlbpage.c            |    4 
 arch/powerpc/mm/mem.c                    |    2 
 arch/powerpc/mm/tlb_32.c                 |    6 
 arch/powerpc/mm/tlb_64.c                 |    4 
 arch/ppc/mm/pgtable.c                    |   13 -
 arch/ppc64/kernel/vdso.c                 |    6 
 arch/sh64/lib/dbg.c                      |    2 
 drivers/char/drm/drm_vm.c                |    2 
 fs/afs/file.c                            |    4 
 fs/buffer.c                              |    2 
 fs/jfs/jfs_metapage.c                    |   12 -
 fs/proc/task_mmu.c                       |    2 
 fs/reiser4/flush_queue.c                 |    2 
 fs/reiser4/jnode.c                       |   10 -
 fs/reiser4/page_cache.c                  |    4 
 fs/reiser4/page_cache.h                  |    2 
 fs/reiser4/plugin/file/tail_conversion.c |    2 
 fs/reiser4/txnmgr.c                      |    6 
 fs/xfs/linux-2.6/xfs_buf.c               |    7 
 include/asm-alpha/atomic.h               |    7 
 include/asm-ppc/pgtable.h                |   10 -
 include/asm-s390/atomic.h                |   10 -
 include/asm-sparc64/atomic.h             |    1 
 include/asm-x86_64/atomic.h              |   49 ++++-
 include/linux/buffer_head.h              |    6 
 include/linux/mm.h                       |  262 +++++++++++++++++++++++--------
 include/linux/page-flags.h               |    1 
 include/linux/rmap.h                     |   12 -
 kernel/futex.c                           |   15 -
 kernel/kexec.c                           |    4 
 mm/Kconfig                               |    6 
 mm/filemap.c                             |    2 
 mm/fremap.c                              |    3 
 mm/memory.c                              |   50 +++--
 mm/page_alloc.c                          |  113 ++++++++++++-
 mm/page_io.c                             |    6 
 mm/rmap.c                                |   29 +--
 mm/shmem.c                               |   22 +-
 mm/swap.c                                |    2 
 mm/swap_state.c                          |    8 
 mm/swapfile.c                            |   14 -
 mm/vmscan.c                              |    2 
 45 files changed, 485 insertions(+), 257 deletions(-)
