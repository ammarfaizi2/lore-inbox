Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVAYOYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVAYOYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVAYOYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:24:32 -0500
Received: from ozlabs.org ([203.10.76.45]:26605 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261956AbVAYOYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:24:21 -0500
Date: Wed, 26 Jan 2005 01:22:10 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org, nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org, spyro@f2s.com
Subject: [PATCH] Use MM_VM_SIZE in exit_mmap
Message-ID: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The 4 level pagetable code changed the exit_mmap code to rely on
TASK_SIZE. On some architectures (eg ppc64 and ia64), this is a per task
property and bad things can happen in certain circumstances when using
it.

It is possible for one task to end up "owning" an mm from another - we
have seen this with the procfs code when process 1 accesses
/proc/pid/cmdline of process 2 while it is exiting.  Process 2 exits
but does not tear its mm down. Later on process 1 finishes with the proc
file and the mm gets torn down at this point.

Now if process 1 was 32bit and process 2 was 64bit then we end up using
a bad value for TASK_SIZE in exit_mmap. We only tear down part of the
address space and leave half initialised pagetables and entries in the
MMU etc.

MM_VM_SIZE() was created for this purpose (and is used in the next line
for tlb_finish_mmu), so use it. I moved the PGD round up of TASK_SIZE
into the default MM_VM_SIZE.

As an aside, all architectures except one define FIRST_USER_PGD_NR as 0:

include/asm-arm26/pgtable.h:#define FIRST_USER_PGD_NR       1

It would be nice to get rid of one more magic constant and just clear
from 0 ... MM_VM_SIZE(). That would make it consistent with the
tlb_flush_mmu call below it too.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== include/linux/mm.h 1.212 vs edited =====
--- 1.212/include/linux/mm.h	2005-01-16 07:21:13 +11:00
+++ edited/include/linux/mm.h	2005-01-26 01:20:12 +11:00
@@ -38,7 +38,7 @@
 #include <asm/atomic.h>
 
 #ifndef MM_VM_SIZE
-#define MM_VM_SIZE(mm)	TASK_SIZE
+#define MM_VM_SIZE(mm)	((TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK)
 #endif
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
===== mm/mmap.c 1.161 vs edited =====
--- 1.161/mm/mmap.c	2005-01-13 03:26:28 +11:00
+++ edited/mm/mmap.c	2005-01-26 01:18:51 +11:00
@@ -1995,8 +1995,7 @@
 					~0UL, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
-	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE,
-			(TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK);
+	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE, MM_VM_SIZE(mm));
 	
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
 
