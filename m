Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315945AbSEGTEg>; Tue, 7 May 2002 15:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSEGTEf>; Tue, 7 May 2002 15:04:35 -0400
Received: from pD9E23EE2.dip.t-dialin.net ([217.226.62.226]:31131 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315945AbSEGTEf>; Tue, 7 May 2002 15:04:35 -0400
Date: Tue, 7 May 2002 13:04:34 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pfn-Functionset out of order for sparc64 in current Bk tree?
Message-ID: <Pine.LNX.4.44.0205051708420.23089-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Someone introduced, by Linus' request I remember, pfn_valid() instead of 
PAGE_INVALID() and such. Now I try to compile on Sparc, and /mm/memory.c 
is the first file which hits missing macros: pte_pfn, pfn_valid, 
pfn_to_page nd pfn_pte. I grepped for some declaration and hit only the 
two in the two-/three-level pagetable of i386. The only other occurrences 
of pte_pfn in *.[ch] were uses, not declarations. Global grep returned 
only two more occurrences in the Changeset.

 - pfn_to_page(pfn) is declared as (mem_map + (pfn)) for i386. Can this 
   apply to Sparc64 as well?
 - pte_pfn(x) is declared as
   ((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
   in 2-level pgtable,
   (((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT)))
   in 3-level. I suppose 2-level shouldn't exactly match here, how far 
   must the 3-level version be changed in order to fit sparc64? A lot?
 - pfn_valid(pfn) is described as ((pfn) < max_mapnr). Suppose this is OK 
   on Sparc64 either?
 - pfn_pte(page,prot) is defined as
   __pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
   How far does this go for Sparc64?

The compile error was:

# sparc64-linux-gcc -D__KERNEL__ -I/usr/src/thunder-2.5/include -Wall 
-Wstrict-pr\ototypes -Wno-trigraphs -O2  -fno-strict-aliasing -fno-common 
-m64 -pipe -mno-f\pu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 
-fcall-used-g5 -fcall-used-g7 -W\no-sign-compare -Wa,--undeclared-regs -pg 
-DKBUILD_BASENAME=memory  -c -o mm/m\emory.o mm/memory.c
mm/memory.c: In function `__free_pte':
mm/memory.c:80: warning: implicit declaration of function `pte_pfn'
mm/memory.c:81: warning: implicit declaration of function `pfn_valid'
mm/memory.c:83: warning: implicit declaration of function `pfn_to_page'
mm/memory.c:83: warning: assignment makes pointer from integer without a 
cast
mm/memory.c: In function `copy_page_range':
mm/memory.c:289: warning: assignment makes pointer from integer without a 
cast
mm/memory.c: In function `zap_pte_range':
mm/memory.c:369: warning: assignment makes pointer from integer without a 
cast
mm/memory.c: In function `follow_page':
mm/memory.c:490: warning: return makes pointer from integer without a cast
mm/memory.c: In function `remap_pte_range':
mm/memory.c:879: invalid type argument of `->'
mm/memory.c:880: warning: implicit declaration of function `pfn_pte'
mm/memory.c: In function `do_wp_page':
mm/memory.c:996: warning: assignment makes pointer from integer without a 
cast

							       Regards,
								Thunder
--
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");


