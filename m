Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUIANvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUIANvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUIANj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:39:58 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:50560
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S266319AbUIANh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:37:28 -0400
To: akpm@osdl.org
Subject: [PATCH 1/2] topdown support for ppc64
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Message-Id: <E1C2VIe-0005pb-P5@localhost.localdomain>
From: Andy Whitcroft <apw@shadowen.org>
Date: Wed, 01 Sep 2004 14:37:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent patches introduced a top down user process address space
allocation policy; further patches enable this for ppc64.
Although these work correctly for normal maps, the topdown
algorithm does not take into account stringent mixing constraints
for small and large pages on this architecture.  These patches
introduce a ppc64 specific arch_get_unused_area_topdown() variant.
The first introduces infrastructure to allow replacement of the
generic arch_get_unused_area_topdown() and the second utilises
this infrastructure.

In this patch I have followed the pattern set by the
arch_get_unused_area() using HAVE_ARCH_UNMAPPED_AREA_TOPDOWN to
be consistent.  However, it would also be possible to simply have
a ppc64_get_unused_area_topdown() in the arch/ppc64/mm/mmap.c or
to use weak bindings.

-apw

=== 8< ===
Allow an architecture to override the default definition of
arch_get_unmapped_area_topdown().

Revision: $Rev: 602 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat 090-arch_topdown
---
 mmap.c |    2 ++
 1 files changed, 2 insertions(+)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/mmap.c current/mm/mmap.c
--- reference/mm/mmap.c	2004-08-25 12:33:42.000000000 +0100
+++ current/mm/mmap.c	2004-08-26 12:26:59.000000000 +0100
@@ -1078,6 +1078,7 @@ void arch_unmap_area(struct vm_area_stru
  * This mmap-allocator allocates new areas top-down from below the
  * stack's low limit (the base):
  */
+#ifndef HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 unsigned long
 arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 			  const unsigned long len, const unsigned long pgoff,
@@ -1162,6 +1163,7 @@ fail:
 
 	return addr;
 }
+#endif
 
 void arch_unmap_area_topdown(struct vm_area_struct *area)
 {
