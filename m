Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUFET4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUFET4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 15:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUFET4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 15:56:25 -0400
Received: from aun.it.uu.se ([130.238.12.36]:51381 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261867AbUFET4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 15:56:24 -0400
Date: Sat, 5 Jun 2004 21:56:11 +0200 (MEST)
Message-Id: <200406051956.i55JuBrt012803@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [BUG] asm-ppc/pgtable.h breakage from 2.6.7-rc1-bk4
Cc: linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current 2.6.7-rc2 kernel hangs after starting INIT
on my PowerMac 4400. I traced the problem to the
ptep_set_access_flags() patch in 2.6.7-rc1-bk4, which
replaces ptep_establish()'s set_pte();flush_tlb_page()
sequence with a single pte_update() in two places in
mm/memory.c.

The patch below disables this change on ppc32, and
allows my 603ev-based PM4400 to finally boot 2.6.7-rc2.

/Mikael

diff -ruN linux-2.6.7-rc2/include/asm-ppc/pgtable.h linux-2.6.7-rc2.ppc-pgtable-fix/include/asm-ppc/pgtable.h
--- linux-2.6.7-rc2/include/asm-ppc/pgtable.h	2004-06-05 19:56:55.000000000 +0200
+++ linux-2.6.7-rc2.ppc-pgtable-fix/include/asm-ppc/pgtable.h	2004-06-05 19:58:43.000000000 +0200
@@ -548,6 +548,7 @@
 	pte_update(ptep, 0, _PAGE_DIRTY);
 }
 
+#if 0
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry, int dirty)
 {
@@ -557,6 +558,7 @@
 }
 #define  ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
         __ptep_set_access_flags(__ptep, __entry, __dirty)
+#endif
 
 /*
  * Macro to mark a page protection value as "uncacheable".
