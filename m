Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265904AbUBPVrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbUBPVrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:47:46 -0500
Received: from galileo.bork.org ([66.11.174.156]:64644 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S265904AbUBPVrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:47:41 -0500
Date: Mon, 16 Feb 2004 16:47:40 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: steiner@sgi.com, linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Subject: [PATCH] Inefficient TLB flush fix
Message-ID: <20040216214740.GE12142@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CMEQapY8OuP5ao1l"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CMEQapY8OuP5ao1l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Andrew,

This is a patch based on one that Jack Steiner sent to the ia64 list in
November.  The original thread can be found at:

http://marc.theaimsgroup.com/?l=linux-ia64&m=106869606922555&w=2

I created the little wrapper function that was requested.  I think the only
other arch, other than ia64, that doesn't at least include asm-generic/tlb.h
is arm.

The patch booted fine on a 12-way Altix.  Against 2.6.3-rc3-mm1

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

--CMEQapY8OuP5ao1l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tlb-flush-fix.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1679  -> 1.1680 
#	include/asm-generic/tlb.h	1.19    -> 1.20   
#	include/asm-arm/tlb.h	1.8     -> 1.9    
#	include/asm-ia64/tlb.h	1.17    -> 1.18   
#	         mm/memory.c	1.150   -> 1.151  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/16	mort@tomahawk.engr.sgi.com	1.1680
# TLB flush optimization.  Here's the original blurb by Jack Steiner <steiner@sgi.com>
# 
# Something appears broken in TLB flushing on IA64 (& possibly other
# architectures). Functionally, it works but performance is bad on
# systems with large cpu counts.
# 
# The result is that TLB flushing in exit_mmap() is frequently being done via
# IPIs to all cpus rather than with a "ptc" instruction or with a new context..
# --------------------------------------------
#
diff -Nru a/include/asm-arm/tlb.h b/include/asm-arm/tlb.h
--- a/include/asm-arm/tlb.h	Mon Feb 16 13:46:29 2004
+++ b/include/asm-arm/tlb.h	Mon Feb 16 13:46:29 2004
@@ -70,6 +70,12 @@
 	check_pgt_cache();
 }
 
+static inline unsigned int
+tlb_is_full_mm(struct mmu_gather *tlb)
+{
+     return tlb->fullmm;
+}
+
 #define tlb_remove_tlb_entry(tlb,ptep,address)	do { } while (0)
 
 #define tlb_start_vma(tlb,vma)						\
diff -Nru a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
--- a/include/asm-generic/tlb.h	Mon Feb 16 13:46:29 2004
+++ b/include/asm-generic/tlb.h	Mon Feb 16 13:46:29 2004
@@ -98,6 +98,11 @@
 	check_pgt_cache();
 }
 
+static inline unsigned int
+tlb_is_full_mm(struct mmu_gather *tlb)
+{
+	return tlb->fullmm;
+}
 
 /* tlb_remove_page
  *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)), while
diff -Nru a/include/asm-ia64/tlb.h b/include/asm-ia64/tlb.h
--- a/include/asm-ia64/tlb.h	Mon Feb 16 13:46:29 2004
+++ b/include/asm-ia64/tlb.h	Mon Feb 16 13:46:29 2004
@@ -173,6 +173,12 @@
 	check_pgt_cache();
 }
 
+static inline unsigned int
+tlb_is_full_mm(struct mmu_gather *tlb)
+{
+     return tlb->fullmm;
+}
+
 /*
  * Logically, this routine frees PAGE.  On MP machines, the actual freeing of the page
  * must be delayed until after the TLB has been flushed (see comments at the beginning of
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Mon Feb 16 13:46:29 2004
+++ b/mm/memory.c	Mon Feb 16 13:46:29 2004
@@ -581,9 +581,10 @@
 			if ((long)zap_bytes > 0)
 				continue;
 			if (need_resched()) {
+				int fullmm = tlb_is_full_mm(*tlbp);
 				tlb_finish_mmu(*tlbp, tlb_start, start);
 				cond_resched_lock(&mm->page_table_lock);
-				*tlbp = tlb_gather_mmu(mm, 0);
+				*tlbp = tlb_gather_mmu(mm, fullmm);
 				tlb_start_valid = 0;
 			}
 			zap_bytes = ZAP_BLOCK_SIZE;

--CMEQapY8OuP5ao1l--
