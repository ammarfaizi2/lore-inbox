Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbVIYPqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbVIYPqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbVIYPqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:46:52 -0400
Received: from gold.veritas.com ([143.127.12.110]:62378 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751521AbVIYPqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:46:51 -0400
Date: Sun, 25 Sep 2005 16:46:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] mm: page fault scalability prep
Message-ID: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:46:51.0399 (UTC) FILETIME=[58A94970:01C5C1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here comes the preparatory batch for my page fault scalability patches.
This batch makes a few fixes - I suggest 01 and 02 should go in 2.6.14 -
and a lot of tidyups, clearing some undergrowth for the real patches.

Just occasionally there's a hint of where we shall be heading: as in the
prototype posted to linux-mm a month ago, narrowing the scope of the mm
page_table_lock, so we can descend pgd,pud,pmd without it; and then, on
machines with more cpus, using a lock per page-table page for the ptes.
Thanks to Christoph Lameter for his generous endorsement of that approach.

This first batch is one half to one third of the work.  The next batch
should follow in a few days' time.  The long delay, mainly an odyssey
through the architectures to satisfy myself of safety, should be over -
though I still need to clarify some issues with maintainers, perhaps
by posting a few dubious arch patches.

This batch is against 2.6.14-rc2-mm1 plus Hirofumi's msync patch;
or against 2.6.14-rc2-git5 plus that and Nick's move_pte patch.

21/21 unfairly weights the deletions in the diffstat, without it we're
 36 files changed, 404 insertions(+), 702 deletions(-)

Hugh

 Documentation/kernel-parameters.txt   |    2 
 Documentation/m68k/kernel-options.txt |   24 
 arch/ia64/kernel/perfmon.c            |    3 
 arch/ia64/mm/fault.c                  |    2 
 arch/m68k/Kconfig                     |   24 
 arch/m68k/atari/stram.c               |  918 ----------------------------------
 arch/mips/kernel/irixelf.c            |    1 
 arch/sh/mm/hugetlbpage.c              |    2 
 arch/sh64/mm/hugetlbpage.c            |  188 ------
 arch/sparc64/kernel/binfmt_aout32.c   |    1 
 arch/sparc64/mm/tlb.c                 |    4 
 arch/x86_64/ia32/ia32_aout.c          |    1 
 fs/binfmt_aout.c                      |    1 
 fs/binfmt_elf.c                       |    1 
 fs/binfmt_elf_fdpic.c                 |    7 
 fs/binfmt_flat.c                      |    1 
 fs/binfmt_som.c                       |    1 
 fs/exec.c                             |    2 
 fs/proc/array.c                       |    2 
 fs/proc/task_mmu.c                    |    8 
 include/asm-arm/tlb.h                 |   23 
 include/asm-arm26/tlb.h               |   47 -
 include/asm-generic/tlb.h             |   23 
 include/asm-ia64/tlb.h                |   19 
 include/asm-ppc64/pgtable.h           |    4 
 include/asm-sparc64/tlb.h             |   29 -
 include/linux/mm.h                    |   17 
 include/linux/sched.h                 |    4 
 kernel/acct.c                         |    2 
 kernel/fork.c                         |   29 -
 mm/fremap.c                           |    4 
 mm/hugetlb.c                          |   37 -
 mm/memory.c                           |  325 ++++++------
 mm/mmap.c                             |   87 +--
 mm/mprotect.c                         |    4 
 mm/mremap.c                           |  170 ++----
 mm/msync.c                            |   38 -
 mm/nommu.c                            |    2 
 mm/rmap.c                             |    8 
 mm/swapfile.c                         |    9 
 40 files changed, 421 insertions(+), 1653 deletions(-)
