Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287341AbSALTUj>; Sat, 12 Jan 2002 14:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287348AbSALTUa>; Sat, 12 Jan 2002 14:20:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15448 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S287341AbSALTUO>; Sat, 12 Jan 2002 14:20:14 -0500
Date: Sat, 12 Jan 2002 19:22:23 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
In-Reply-To: <20020112125625.E1482@inspiron.school.suse.de>
Message-ID: <Pine.LNX.4.21.0201121825200.1105-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2002, Andrea Arcangeli wrote:
> 
> for a fileserver (even more if in kernel like tux) it certainly make
> sense to have as much direct mapped memory as possible, it is not the
> recommended setup for a generic purpose kernel though. So I applied the
> patch (except the prefix thing which is distribution specific). thanks,

Please add in the patch below as well.  It needs some explanation!
A few weeks ago we noticed a compiler bug: in both egcs-2.91.66 and
gcc-2.95.3; not in RH 2.96-85; forget if I tried gcc-3.0, expect okay.

If CONFIG_HIGHMEM64G (PAE: 3 levels of page table, 64-bit pte),
the free_one_pgd code inlined in clear_page_tables is miscompiled:
the loop is terminated by a "jle" signed comparison of addresses
instead of a "jb" unsigned comparison.

Usually not a problem: but if you configure for 1GB of user virtual
and 3GB of kernel virtual, and you have more than 1GB of physical
memory (as you normally would if chose HIGHMEM64G), then there's
a page at physical address 0x3ffff000, directly mapped to virtual
address 0x7ffff000.  And if that page happens to get used for the
pmd of a process, then on exit the free_one_pgd loop wraps over
to carry on freeing "entries" at 0x80000000, 0x80000008, ...
A lot of pmd_ERROR messages, but eventually an entry scrapes
through the pmd_bad test and is wrongly freed, not so good.

The patch below seems to be enough to convince egcs-2.91.66 and
gcc-2.95.3 to use a "jb" comparison there.  I'm working on PIII,
prefetchw() just a stub, if that makes any difference.

This patch is not actually what we've used.  Paranoia (what other
such bugs might there be?) drove me to set physical pages 0x3ffff
and 0x40000 as Reserved in arch/i386/setup.c.  I don't think it's
appropriate to force that level of paranoia on others; but anyone
configuring 3GBK should remember that it's a less-travelled path.

Hugh

--- 2.4.18pre2aa2/mm/memory.c	Sat Jan 12 18:01:36 2002
+++ linux/mm/memory.c	Sat Jan 12 18:09:27 2002
@@ -106,8 +106,7 @@
 
 static inline void free_one_pgd(pgd_t * dir)
 {
-	int j;
-	pmd_t * pmd;
+	pmd_t * pmd, * md, * emd;
 
 	if (pgd_none(*dir))
 		return;
@@ -118,9 +117,9 @@
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++) {
-		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
-		free_one_pmd(pmd+j);
+	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
+		prefetchw(md+(PREFETCH_STRIDE/16));
+		free_one_pmd(md);
 	}
 	pmd_free(pmd);
 }

