Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUGAQ0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUGAQ0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUGAQ0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:26:06 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:10245 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id S266009AbUGAQ0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:26:00 -0400
Message-ID: <40E43BDE.85C5D670@tv-sign.ru>
Date: Thu, 01 Jul 2004 20:29:18 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [BUG] hugetlb MAP_PRIVATE mapping vs /dev/zero
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Hugetlbfs mmap with MAP_PRIVATE becomes MAP_SHARED
silently, but vma->vm_flags have no VM_SHARED bit.
I think it make sense to forbid MAP_PRIVATE in
hugetlbfs_file_mmap() because it may confuse user
space applications. But the real bug is that reading
from /dev/zero into hugetlb will do:

read_zero()
	read_zero_pagealigned()
		if (vma->vm_flags & VM_SHARED)
			break;	// OK if MAP_PRIVATE
		zap_page_range();
		zeromap_page_range();

We can fix hugetlbfs_file_mmap() or read_zero_pagealigned()
or both.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -urp 2.6.7-clean/drivers/char/mem.c 2.6.7-mmap/drivers/char/mem.c
--- 2.6.7-clean/drivers/char/mem.c	2004-05-30 13:25:49.000000000 +0400
+++ 2.6.7-mmap/drivers/char/mem.c	2004-07-01 19:51:52.000000000 +0400
@@ -417,7 +417,7 @@ static inline size_t read_zero_pagealign
 
 		if (vma->vm_start > addr || (vma->vm_flags & VM_WRITE) == 0)
 			goto out_up;
-		if (vma->vm_flags & VM_SHARED)
+		if (vma->vm_flags & (VM_SHARED | VM_HUGETLB))
 			break;
 		count = vma->vm_end - addr;
 		if (count > size)
diff -urp 2.6.7-clean/fs/hugetlbfs/inode.c 2.6.7-mmap/fs/hugetlbfs/inode.c
--- 2.6.7-clean/fs/hugetlbfs/inode.c	2004-05-24 14:16:11.000000000 +0400
+++ 2.6.7-mmap/fs/hugetlbfs/inode.c	2004-07-01 19:54:16.000000000 +0400
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
+#include <asm/mman.h>
 
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6
@@ -52,6 +53,9 @@ static int hugetlbfs_file_mmap(struct fi
 	loff_t len, vma_len;
 	int ret;
 
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return -EINVAL;
+
 	if (vma->vm_start & ~HPAGE_MASK)
 		return -EINVAL;
