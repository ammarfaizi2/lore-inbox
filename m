Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbTEJQWH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbTEJQWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:22:07 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:48845 "EHLO
	mail-2.tiscali.it") by vger.kernel.org with ESMTP id S264439AbTEJQWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:22:03 -0400
Date: Sat, 10 May 2003 18:33:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Fix for vma merging refcounting bug
Message-ID: <20030510163336.GB15010@dualathlon.random>
References: <1052483661.3642.16.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052483661.3642.16.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 01:34:21PM +0100, Stephen C. Tweedie wrote:
> When a new vma can be merged simultaneously with its two immediate
> neighbours in both directions, vma_merge() extends the predecessor vma
> and deletes the successor.  However, if the vma maps a file, it fails to
> fput() when doing the delete, leaving the file's refcount inconsistent.
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.1083  -> 1.1084 
> #	           mm/mmap.c	1.79    -> 1.80   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/05/09	sct@sisko.scot.redhat.com	1.1084
> # Fix vma merging problem leading to file refcount getting out of sync.
> # --------------------------------------------
> #
> diff -Nru a/mm/mmap.c b/mm/mmap.c
> --- a/mm/mmap.c	Fri May  9 13:26:53 2003
> +++ b/mm/mmap.c	Fri May  9 13:26:53 2003
> @@ -471,6 +471,8 @@
>  			spin_unlock(lock);
>  			if (need_up)
>  				up(&inode->i_mapping->i_shared_sem);
> +			if (file)
> +				fput(file);
>  
>  			mm->map_count--;
>  			kmem_cache_free(vm_area_cachep, next);
> 

great catch! nobody could notice it in practice but it's definitely
needed, especially after long uptimes it could be noticeable ;), thanks!

I'm attaching for review what I'm applying to my -aa tree, to fix the
above and the other issue with the non-ram vma merging fixed in 2.5.

Please review, thanks again!

--- CGL/include/linux/mm.h.~1~	2003-05-07 23:39:00.000000000 +0200
+++ CGL/include/linux/mm.h	2003-05-10 18:25:04.000000000 +0200
@@ -587,11 +587,15 @@ static inline void __vma_unlink(struct m
 		mm->mmap_cache = prev;
 }
 
+#define VM_SPECIAL (VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_RESERVED)
+
 #define can_vma_merge(vma, vm_flags) __can_vma_merge(vma, vm_flags, NULL, 0, 0)
 static inline int __can_vma_merge(struct vm_area_struct * vma, unsigned long vm_flags,
 				  struct file * file, unsigned long vm_pgoff, unsigned long offset)
 {
-	if (vma->vm_file == file && vma->vm_flags == vm_flags) {
+	if (vma->vm_file == file && vma->vm_flags == vm_flags &&
+	    likely((!vma->vm_ops || !vma->vm_ops->close) && !vma->vm_private_data &&
+		   !(vm_flags & VM_SPECIAL))) {
 		if (file) {
 			if (vma->vm_pgoff == vm_pgoff + offset) {
 				if ((long) offset > 0 && vm_pgoff + offset < vm_pgoff)
--- CGL/mm/mmap.c.~1~	2003-05-07 23:39:42.000000000 +0200
+++ CGL/mm/mmap.c	2003-05-10 18:25:23.000000000 +0200
@@ -377,6 +377,8 @@ static int vma_merge(struct mm_struct * 
 			spin_unlock(lock);
 			if (need_unlock)
 				unlock_vma_mappings(next);
+			if (file)
+				fput(file);
 
 			mm->map_count--;
 			kmem_cache_free(vm_area_cachep, next);

Andrea
