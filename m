Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVC3LsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVC3LsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVC3LsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:48:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6281 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261873AbVC3Lr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:47:58 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Fix TLB miss mapping cache flush
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 30 Mar 2005 12:47:47 +0100
Message-ID: <28499.1112183267@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes the TLB miss mapping cache flush function.

The flush was attempting to invalidate the coverage start virtual addresses
for the cached page table mappings held in registers SCR0 and SCR1 by writing
0 into them. Unfortunately, 0x00000000-0x04000000 is itself a valid part of
the virtual address range. This patches places -1 in there instead, thus
specifying 0xfc000000-0xffffffff which is covered by a static I/O mapping, and
so shouldn't ever be seen by the TLB-miss handler.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-tlbmiss-2612rc1.diff 
 include/asm-frv/tlbflush.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.12-rc1/include/asm-frv/tlbflush.h linux-2.6.12-rc1-frv-tlbmiss/include/asm-frv/tlbflush.h
--- /warthog/kernels/linux-2.6.12-rc1/include/asm-frv/tlbflush.h	2005-03-02 12:08:45.000000000 +0000
+++ linux-2.6.12-rc1-frv-tlbmiss/include/asm-frv/tlbflush.h	2005-03-30 11:50:06.000000000 +0100
@@ -58,7 +58,8 @@ do {								\
 #define __flush_tlb_global()			flush_tlb_all()
 #define flush_tlb()				flush_tlb_all()
 #define flush_tlb_kernel_range(start, end)	flush_tlb_all()
-#define flush_tlb_pgtables(mm,start,end)	asm volatile("movgs gr0,scr0 ! movgs gr0,scr1");
+#define flush_tlb_pgtables(mm,start,end) \
+	asm volatile("movgs %0,scr0 ! movgs %0,scr1" :: "r"(ULONG_MAX) : "memory");
 
 #else
 
