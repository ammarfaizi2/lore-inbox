Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUGIOIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUGIOIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUGIOIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:08:13 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:48399 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id S264704AbUGIOIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:08:09 -0400
Message-ID: <40EEA7A7.646A8BB6@tv-sign.ru>
Date: Fri, 09 Jul 2004 18:11:51 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [BUG][PATCH] resend, /dev/zero vs hugetlb mappings.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Hugetlbfs mmap with MAP_PRIVATE becomes MAP_SHARED
silently, but vma->vm_flags have no VM_SHARED bit.
Reading from /dev/zero into hugetlb area will do:

read_zero()
    read_zero_pagealigned()
        if (vma->vm_flags & VM_SHARED)
            break;                      // fallback to clear_user()
        zap_page_range();
        zeromap_page_range();

It will hit BUG_ON() in unmap_hugepage_range() if
region is not huge page aligned, or silently convert
it into the private anonymous mapping.

Patch against mm7.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.7-mm7/drivers/char/mem.c.orig	2004-07-09 16:41:03.000000000 +0400
+++ 2.6.7-mm7/drivers/char/mem.c	2004-07-09 17:00:20.000000000 +0400
@@ -415,7 +415,7 @@ static inline size_t read_zero_pagealign
 
 		if (vma->vm_start > addr || (vma->vm_flags & VM_WRITE) == 0)
 			goto out_up;
-		if (vma->vm_flags & VM_SHARED)
+		if (vma->vm_flags & (VM_SHARED | VM_HUGETLB))
 			break;
 		count = vma->vm_end - addr;
 		if (count > size)
