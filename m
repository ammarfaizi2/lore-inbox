Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVAZQSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVAZQSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVAZQSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:18:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262344AbVAZQSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:18:15 -0500
Date: Wed, 26 Jan 2005 11:18:08 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: don't let mmap allocate down to zero
Message-ID: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With some programs the 2.6 kernel can end up allocating memory
at address zero, for a non-MAP_FIXED mmap call!  This causes
problems with some programs and is generally rude to do. This
simple patch fixes the problem in my tests.

Make sure that we don't allocate memory all the way down to zero,
so the NULL pointer never gets covered up with anonymous memory
and we don't end up violating the C standard.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.9/mm/mmap.c.nullmmap	2005-01-25 18:00:26.000000000 -0500
+++ linux-2.6.9/mm/mmap.c	2005-01-26 08:48:03.438701673 -0500
@@ -1114,6 +1114,8 @@ void arch_unmap_area(struct vm_area_stru
  		area->vm_mm->free_area_cache = area->vm_start;
  }

+#define SHLIB_BASE             0x00111000
+
  /*
   * This mmap-allocator allocates new areas top-down from below the
   * stack's low limit (the base):
@@ -1162,6 +1164,13 @@ try_again:
  			return addr;

  		/*
+		 * Make sure we don't allocate all the way down to
+		 * zero, which would break NULL pointer detection.
+		 */
+		if (addr < SHLIB_BASE)
+			goto fail;
+
+		/*
  		 * new region fits between prev_vma->vm_end and
  		 * vma->vm_start, use it:
  		 */
@@ -1258,8 +1267,6 @@ get_unmapped_area_prot(struct file *file
  EXPORT_SYMBOL(get_unmapped_area_prot);


-#define SHLIB_BASE             0x00111000
-
  unsigned long arch_get_unmapped_exec_area(struct file *filp, unsigned long 
addr0,
  		unsigned long len0, unsigned long pgoff, unsigned long flags)
  {
