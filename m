Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbTAWJ5I>; Thu, 23 Jan 2003 04:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbTAWJ5I>; Thu, 23 Jan 2003 04:57:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:18332 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265074AbTAWJ5H>;
	Thu, 23 Jan 2003 04:57:07 -0500
Date: Thu, 23 Jan 2003 02:06:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: ch@murgatroid.com, fbecker@intrinsyc.com,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.55-rmk1: user space lossage
Message-Id: <20030123020627.5603a268.akpm@digeo.com>
In-Reply-To: <17281.1043316072@passion.cambridge.redhat.com>
References: <20030123015659.422e8179.akpm@digeo.com>
	<000001c2c287$ffa8eef0$800b040f@bergamot>
	<15943.1043315303@passion.cambridge.redhat.com>
	<17281.1043316072@passion.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jan 2003 10:06:10.0769 (UTC) FILETIME=[0DECAC10:01C2C2C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> 
> 
> -  	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
> +-  	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
> ++ 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))

Yup.



We cannot clear VM_MAYWRITE in there - it turns writeable MAP_PRIVATE
mappings into readonly ones.

So change it back to the 2.4 form - disallow a writeable MAP_SHARED mapping
against filesystems which do no implement ->writepage().


 filemap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN mm/filemap.c~generic_file_readonly_mmap-fix mm/filemap.c
--- 25/mm/filemap.c~generic_file_readonly_mmap-fix	2003-01-23 01:55:41.000000000 -0800
+++ 25-akpm/mm/filemap.c	2003-01-23 02:04:05.000000000 -0800
@@ -1308,11 +1308,13 @@ int generic_file_mmap(struct file * file
 	return 0;
 }
 
+/*
+ * This is for filesystems which do not implement ->writepage.
+ */
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
 		return -EINVAL;
-	vma->vm_flags &= ~VM_MAYWRITE;
 	return generic_file_mmap(file, vma);
 }
 #else

_

