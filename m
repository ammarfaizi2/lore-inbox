Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUGBMJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUGBMJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 08:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGBMJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 08:09:19 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:27913 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id S264297AbUGBMI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 08:08:58 -0400
Message-ID: <40E55125.19A820F9@tv-sign.ru>
Date: Fri, 02 Jul 2004 16:12:21 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, David Gibson <david@gibson.dropbear.id.au>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [BUG] hugetlb MAP_PRIVATE mapping vs /dev/zero
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > We can fix hugetlbfs_file_mmap() or read_zero_pagealigned()
> > or both.
>
> This could break existing applications, yes?

Personally, i think that mmap(PROT_WRITE, MAP_PRIVATE, hugetlbfd)
should fail, just because kernel currently does not support this.
Well written application can break, beacuse it succeeds.

It is also security bug. Current behavior allows:
open("hugetlbfs_file_owned_by_root_with_mode:-rwxr-xr-x", O_RDONLY),
and then mmap(PROT_READ|PROT_WRITE, MAP_PRIVATE).

Perhaps, hugetlbfs_file_mmap() must do:
if (!(vma->vm_flags & VM_MAYSHARE) && (vma->vm_flags & VM_WRITE))
	return -EINVAL;

sys_mprotect() does not work with is_vm_hugetlb_page(vma), so it
seems to me, it is ok to allow private readonly hugetlb mappings.

David Gibson wrote:
> For now forcing VM_SHARED in the hugetlbfs code is sufficient, but if
> we ever allow (real) MAP_PRIVATE hugepage mappings (by implementing
> hugepage COW, for example), then the zeromap code will need fixing.
>
> Conceptually it's not so much the fact that the hugepage memory is
> shared which is tripping up zeromap as the fact that it isn't mapped
> in the normal way.

I completely agree.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -urp 2.6.7-clean/Documentation/vm/hugetlbpage.txt 2.6.7-mmap/Documentation/vm/hugetlbpage.txt
--- 2.6.7-clean/Documentation/vm/hugetlbpage.txt	2004-05-24 14:15:57.000000000 +0400
+++ 2.6.7-mmap/Documentation/vm/hugetlbpage.txt	2004-07-02 15:59:31.000000000 +0400
@@ -13,6 +13,8 @@ available.
 Users can use the huge page support in Linux kernel by either using the mmap
 system call or standard SYSv shared memory system calls (shmget, shmat).
 
+NOTE: private writable mappings are not supported.
+
 First the Linux kernel needs to be built with CONFIG_HUGETLB_PAGE (present
 under Processor types and feature)  and CONFIG_HUGETLBFS (present under file
 system option on config menu) config options.
diff -urp 2.6.7-clean/drivers/char/mem.c 2.6.7-mmap/drivers/char/mem.c
--- 2.6.7-clean/drivers/char/mem.c	2004-05-30 13:25:49.000000000 +0400
+++ 2.6.7-mmap/drivers/char/mem.c	2004-07-01 20:07:42.000000000 +0400
@@ -417,8 +417,9 @@ static inline size_t read_zero_pagealign
 
 		if (vma->vm_start > addr || (vma->vm_flags & VM_WRITE) == 0)
 			goto out_up;
-		if (vma->vm_flags & VM_SHARED)
+		if (vma->vm_flags & (VM_SHARED | VM_HUGETLB))
 			break;
+printk(KERN_CRIT "HERE!!!\n");
 		count = vma->vm_end - addr;
 		if (count > size)
 			count = size;
Only in 2.6.7-mmap/drivers/char: mem.c~
diff -urp 2.6.7-clean/fs/hugetlbfs/inode.c 2.6.7-mmap/fs/hugetlbfs/inode.c
--- 2.6.7-clean/fs/hugetlbfs/inode.c	2004-05-24 14:16:11.000000000 +0400
+++ 2.6.7-mmap/fs/hugetlbfs/inode.c	2004-07-02 15:40:41.000000000 +0400
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
+#include <asm/mman.h>
 
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6
@@ -52,6 +53,9 @@ static int hugetlbfs_file_mmap(struct fi
 	loff_t len, vma_len;
 	int ret;
 
+	if ((vma->vm_flags & (VM_MAYSHARE | VM_WRITE)) == VM_WRITE)
+		return -EINVAL;
+
 	if (vma->vm_start & ~HPAGE_MASK)
 		return -EINVAL;
