Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbTAWRq4>; Thu, 23 Jan 2003 12:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTAWRq4>; Thu, 23 Jan 2003 12:46:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:7301 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S265508AbTAWRqx>; Thu, 23 Jan 2003 12:46:53 -0500
Date: Thu, 23 Jan 2003 17:57:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.55-rmk1: user space lossage
In-Reply-To: <20030123020627.5603a268.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301231753430.2336-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, Andrew Morton wrote:
> 
> We cannot clear VM_MAYWRITE in there - it turns writeable MAP_PRIVATE
> mappings into readonly ones.
> 
> So change it back to the 2.4 form - disallow a writeable MAP_SHARED mapping
> against filesystems which do no implement ->writepage().

Sorry for late quibbles, but wouldn't patch below be better?  Linus
did intend that change to the occasionally criticized 2.4 behaviour,
this preserves that change while avoiding the bug which hit David.

You may notice I've sneaked a ~VM_SHARED in there too.  Not because
I can say it's necessary, but the VM_MAYWRITE, VM_SHARED treatment
is already weird, I'd feel safer if we keep to the same combination
as already exists in the !FMODE_WRITE case (see do_mmap_pgoff).

Hugh

--- 2.5.59-mm2/mm/filemap.c	Sat Jan 18 10:37:36 2003
+++ linux/mm/filemap.c	Thu Jan 23 16:50:34 2003
@@ -1310,9 +1310,11 @@
 
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
-		return -EINVAL;
-	vma->vm_flags &= ~VM_MAYWRITE;
+	if (vma->vm_flags & VM_SHARED) {
+		if (vma->vm_flags & VM_WRITE)
+			return -EINVAL;
+		vma->vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
+	}
 	return generic_file_mmap(file, vma);
 }
 #else

