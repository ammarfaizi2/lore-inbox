Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVCIWKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVCIWKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVCIWHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:07:09 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5054 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261390AbVCIWG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:06:26 -0500
Date: Wed, 9 Mar 2005 22:05:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/15] ptwalk: pagetable walker cleanup
Message-ID: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a cleanup of the pagetable walkers, in common and i386 code,
based on 2.6.11-bk5.  Mainly to make them all go the same simpler way,
so they're easier to follow with less room for error; but also to reduce
the code size and speed it up a little.  These are janitorial changes,
other arches may follow whenever it suits them.

A few patches slice across all the files, most dice them into nests of
functions to focus on: slicing looks confusing where the originals are
following different conventions.  11/15 works around hang from 10/15.

329 fewer source lines; ~3.5KB less kernel text; lmbench shows good
improvement with 2level pagetables (though not yet back to 2.6.10),
and a much less impressive improvement with 3level pagetables:

1*PIII 512MB    2*HT*P4 4GB     2*HT*P4 5GB  
fork exec sh  	fork exec sh  	fork exec sh  
proc proc proc	proc proc proc	proc proc proc
---- ---- ----	---- ---- ----	---- ---- ----
152. 541. 3687	249. 989. 4337	353. 1307 5646 2.6.11-bk5
152. 552. 3706	251. 973. 4344	348. 1310 5546
152. 537. 3689	250. 974. 4332	351. 1307 5556
--------------	--------------	--------------
86.4 438. 3471	199. 865. 4167	334. 1279 5499 2.6.11-bk5 + ptwalk
87.4 413. 3478	198. 910. 4176	333. 1261 5462
87.8 415. 3484	199. 870. 4183	331. 1251 5471
--------------	--------------	--------------
79.6 389. 3418	174. 800. 3981	226. 1095 5170 2.6.10
81.5 381. 3442	166. 807. 3986	226. 1093 5074
81.1 385. 3471	165. 800. 3978	227. 1101 5154

 arch/i386/kernel/vm86.c             |   21 
 arch/i386/mm/ioremap.c              |  112 ++---
 include/asm-generic/4level-fixup.h  |    4 
 include/asm-generic/pgtable-nopmd.h |    5 
 include/asm-generic/pgtable-nopud.h |    5 
 include/asm-generic/pgtable.h       |   69 +++
 mm/memory.c                         |  788 ++++++++++++++----------------------
 mm/mprotect.c                       |  131 ++---
 mm/mremap.c                         |   24 -
 mm/msync.c                          |  201 +++------
 mm/swapfile.c                       |  173 ++-----
 mm/vmalloc.c                        |  246 +++--------
 12 files changed, 725 insertions(+), 1054 deletions(-)

Hugh
