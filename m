Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUKBKDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUKBKDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 05:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUKBJ57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:57:59 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:53254 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261424AbUKBJy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:54:26 -0500
Date: Tue, 2 Nov 2004 09:54:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 14/14] FRV: Better mmap support in uClinux
Message-ID: <20041102095418.GE5841@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
	davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <20040401020550.GG3150@beast> <200411011930.iA1JUMQe023259@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011930.iA1JUMQe023259@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/base.c linux-2.6.10-rc1-bk10-frv/fs/proc/base.c
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/base.c	2004-10-27 17:32:31.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/fs/proc/base.c	2004-11-01 11:47:04.870656963 +0000
> @@ -220,6 +220,9 @@
>  
>  static int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
>  {
> +#ifndef CONFIG_MMU
> +	struct mm_tblock_struct *tblock;
> +#endif
>  	struct vm_area_struct * vma;
>  	int result = -ENOENT;
>  	struct task_struct *task = proc_task(inode);
> @@ -228,17 +231,32 @@
>  	if (!mm)
>  		goto out;
>  	down_read(&mm->mmap_sem);
> +
> +#ifdef CONFIG_MMU
>  	vma = mm->mmap;
>  	while (vma) {
> -		if ((vma->vm_flags & VM_EXECUTABLE) && 
> -		    vma->vm_file) {
> -			*mnt = mntget(vma->vm_file->f_vfsmnt);
> -			*dentry = dget(vma->vm_file->f_dentry);
> -			result = 0;
> +		if ((vma->vm_flags & VM_EXECUTABLE) && vma->vm_file)
>  			break;
> -		}
>  		vma = vma->vm_next;
>  	}
> +#else
> +	tblock = mm->context.tblock;
> +	vma = NULL;
> +	while (tblock) {
> +		if ((tblock->vma->vm_flags & VM_EXECUTABLE) && tblock->vma->vm_file) {
> +			vma = tblock->vma;
> +			break;
> +		}
> +		tblock = tblock->next;
> +	}
> +#endif
> +
> +	if (vma) {
> +		*mnt = mntget(vma->vm_file->f_vfsmnt);
> +		*dentry = dget(vma->vm_file->f_dentry);
> +		result = 0;
> +	}
> +
>  	up_read(&mm->mmap_sem);
>  	mmput(mm);

please split this up into a mmu and a no-mmu function, in a mmu and nommu
file respectively.

>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/ptrace.h>
>  #include <linux/blkdev.h>
>  #include <linux/backing-dev.h>
>  #include <linux/syscalls.h>
> @@ -38,6 +40,10 @@
>  EXPORT_SYMBOL(sysctl_max_map_count);
>  EXPORT_SYMBOL(mem_map);
>  
> +/* list of shareable VMAs */
> +LIST_HEAD(shareable_vma_list);
> +DECLARE_RWSEM(shareable_vma_sem);

the should both be static

> +	if (flags & MAP_FIXED || addr) {
> +//		printk("can't do fixed-address/overlay mmap of RAM\n");

please avoid C++-style comments in core kernel code.

> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/mm/tiny-shmem.c linux-2.6.10-rc1-bk10-frv/mm/tiny-shmem.c
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/mm/tiny-shmem.c	2004-10-27 17:32:38.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/mm/tiny-shmem.c	2004-11-01 14:24:49.419177784 +0000
> @@ -112,7 +112,9 @@
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	vma->vm_file = file;
> +#ifdef CONFIG_MMU
>  	vma->vm_ops = &generic_file_vm_ops;
> +#endif

please find a nice way to abstract this out without the ifdefs here.

