Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSKHWmV>; Fri, 8 Nov 2002 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSKHWmV>; Fri, 8 Nov 2002 17:42:21 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:38128 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262780AbSKHWmU>; Fri, 8 Nov 2002 17:42:20 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: linux-kernel@vger.kernel.org
Subject: RFC: mmap(PROT_READ, MAP_SHARED) fails if !writepage.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Nov 2002 22:49:02 +0000
Message-ID: <24305.1036795742@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does a _readonly_ mapping fail if the file system has no writepage 
method? 

do_mmap_pgoff() sets VM_MAYWRITE on the vma and then generic_file_mmap() 
refuses to allow it. 

Suggested patch below.... or should I just hack fsx-linux to use 
MAP_PRIVATE for its readonly mappings and ignore it?

--- 1.157/mm/filemap.c  Sun Nov  3 02:55:27 2002
+++ edited/mm/filemap.c Fri Nov  8 22:08:22 2002
@@ -1311,9 +1311,12 @@
        struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
        struct inode *inode = mapping->host;

-       if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE)) {
-               if (!mapping->a_ops->writepage)
+       if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE) &&
+           !mapping->a_ops->writepage) {
+               if (vma->vm_flags & VM_WRITE)
                        return -EINVAL;
+               else
+                       vma->vm_flags &= ~VM_MAYWRITE;
        }
        if (!mapping->a_ops->readpage)
                return -ENOEXEC;


--
dwmw2


