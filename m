Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266577AbUGKMz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266577AbUGKMz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 08:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUGKMz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 08:55:58 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:2564 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id S266577AbUGKMzz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 08:55:55 -0400
Message-ID: <40F139BA.F1F10B22@tv-sign.ru>
Date: Sun, 11 Jul 2004 16:59:38 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] hugetlbfs private mappings.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Hugetlbfs silently coerce private mappings of hugetlb files
into shared ones. So private writable mapping has MAP_SHARED
semantics. I think, such mappings should be disallowed.

First, such behavior allows open hugetlbfs file O_RDONLY, and
overwrite it via mmap(PROT_READ|PROT_WRITE, MAP_PRIVATE), so
it is security bug.

Second, private writable mmap() should fail just because kernel
does not support this.

I beleive, it is ok to allow private readonly hugetlb mappings,
sys_mprotect() does not work with hugetlb vmas.

There is another problem. Hugetlb mapping is always prefaulted,
pages allocated at mmap() time. So even readonly mapping allows
to enlarge the size of the hugetlbfs file, and steal huge pages
without appropriative permissions.

Patch on top of vm_pgoff fixes, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=108938233708584

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.7-mm7/fs/hugetlbfs/inode.c.pgoff	2004-07-11 15:32:09.000000000 +0400
+++ 2.6.7-mm7/fs/hugetlbfs/inode.c	2004-07-11 16:09:27.000000000 +0400
@@ -52,6 +52,9 @@ static int hugetlbfs_file_mmap(struct fi
 	loff_t len, vma_len;
 	int ret;
 
+	if ((vma->vm_flags & (VM_MAYSHARE | VM_WRITE)) == VM_WRITE)
+		return -EINVAL;
+
 	if (vma->vm_pgoff & (HPAGE_SIZE / PAGE_SIZE - 1))
 		return -EINVAL;
 
@@ -70,10 +73,19 @@ static int hugetlbfs_file_mmap(struct fi
 	file_accessed(file);
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
+
+	ret = -ENOMEM;
+	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
+		goto out;
+
 	ret = hugetlb_prefault(mapping, vma);
-	len = vma_len +	((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	if (ret == 0 && inode->i_size < len)
+	if (ret)
+		goto out;
+
+	if (inode->i_size < len)
 		inode->i_size = len;
+out:
 	up(&inode->i_sem);
 
 	return ret;
