Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbUKBKKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUKBKKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 05:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbUKBJxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:53:42 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:50694 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261260AbUKBJnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:43:47 -0500
Date: Tue, 2 Nov 2004 09:43:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 9/14] FRV: CONFIG_MMU fixes
Message-ID: <20041102094336.GC5841@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
	davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JULvA023219@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011930.iA1JULvA023219@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a real ifdef mess, let's sort this out better (aka on file
boundaries)

> 
> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/kcore.c linux-2.6.10-rc1-bk10-frv/fs/proc/kcore.c
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/kcore.c	2004-09-16 12:06:14.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/fs/proc/kcore.c	2004-11-01 11:47:04.872656796 +0000
> @@ -344,6 +344,7 @@
>  		if (m == NULL) {
>  			if (clear_user(buffer, tsz))
>  				return -EFAULT;
> +#ifdef CONFIG_MMU
>  		} else if ((start >= VMALLOC_START) && (start < VMALLOC_END)) {
>  			char * elf_buf;
>  			struct vm_struct *m;
> @@ -389,6 +390,7 @@
>  				return -EFAULT;
>  			}
>  			kfree(elf_buf);
> +#endif

move this into a helper function that can be compiled away for the !MMU case

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/proc_misc.c	2004-11-01 11:45:28.000000000 +0000
> +++ linux-2.6.10-rc1-bk10-frv/fs/proc/proc_misc.c	2004-11-01 11:47:04.873656713 +0000
> @@ -100,6 +100,7 @@
>  	unsigned long largest_chunk;
>  };
>  
> +#ifdef CONFIG_MMU
>  static struct vmalloc_info get_vmalloc_info(void)
>  {
>  	unsigned long prev_end = VMALLOC_START;
> @@ -129,6 +130,7 @@
>  	read_unlock(&vmlist_lock);
>  	return vmi;
>  }
> +#endif

move the whole function to a CONFIG_MMU-only file

>  static int uptime_read_proc(char *page, char **start, off_t off,
>  				 int count, int *eof, void *data)
> @@ -176,10 +178,16 @@
>  	allowed = ((totalram_pages - hugetlb_total_pages())
>  		* sysctl_overcommit_ratio / 100) + total_swap_pages;
>  
> +#ifdef CONFIG_MMU
>  	vmtot = (VMALLOC_END-VMALLOC_START)>>10;
>  	vmi = get_vmalloc_info();
>  	vmi.used >>= 10;
>  	vmi.largest_chunk >>= 10;
> +#else
> +	vmtot = 0;
> +	vmi.used = 0;
> +	vmi.largest_chunk = 0;
> +#endif

add a small helper for this.  In fact it's the only caller of get_vmalloc_info,
so that could be merged into the helper, ala:


void get_vmalloc_info(struct vmalloc_info vmi *vmi)
{
	/* contents of old get_vmalloc_info here */
	vmi->used = 0;
	vmi->largest_chunk = 0;
	}
}

and define both VMALLOC_START and VMALLOC_END to 0 for !MMU

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/mm.h	2004-11-01 11:45:33.371274107 +0000
> +++ linux-2.6.10-rc1-bk10-frv/include/linux/mm.h	2004-11-01 14:16:26.408497251 +0000
> @@ -58,6 +58,7 @@
>   * space that has a special rule for the page-fault handlers (ie a shared
>   * library, the executable area etc).
>   */
> +#ifdef CONFIG_MMU
>  struct vm_area_struct {
>  	struct mm_struct * vm_mm;	/* The address space we belong to. */
>  	unsigned long vm_start;		/* Our start address within vm_mm. */
> @@ -658,12 +688,14 @@

you're missing an endif.

>  	for (prio_tree_iter_init(iter, root, begin, end), vma = NULL;	\
>  		(vma = vma_prio_tree_next(vma, iter)); )
>  
> +#ifdef CONFIG_MMU
>  static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
>  					struct list_head *list)
>  {
>  	vma->shared.vm_set.parent = NULL;
>  	list_add_tail(&vma->shared.vm_set.list, list);
>  }
> +#endif

I's day just move this out of line into a MMU-only file.

>  /* mmap.c */
>  extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
> @@ -780,6 +812,7 @@
>  }
>  #endif /* CONFIG_PROC_FS */
>  
> +#ifdef CONFIG_MMU
>  static inline void vm_stat_account(struct vm_area_struct *vma)
>  {
>  	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
> @@ -791,6 +824,7 @@
>  	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
>  							-vma_pages(vma));
>  }
> +#endif

or at least keep a single MMU ifdef block per file

> +#ifdef CONFIG_MMU
>  	pgtable_cache_init();
>  	prio_tree_init();
> +#endif

provide stubs please.  pgtable_cache_init is a per-arch things anyway.

> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/sysctl.c linux-2.6.10-rc1-bk10-frv/kernel/sysctl.c
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/sysctl.c	2004-11-01 11:45:34.879148578 +0000
> +++ linux-2.6.10-rc1-bk10-frv/kernel/sysctl.c	2004-11-01 11:47:05.181631075 +0000
> @@ -755,6 +755,7 @@
>  		.strategy	= &sysctl_intvec,
>  		.extra1		= &zero,
>  	},
> +#ifdef CONFIG_MMU
>  	{
>  		.ctl_name	= VM_MAX_MAP_COUNT,
>  		.procname	= "max_map_count",
> @@ -763,6 +764,7 @@
>  		.mode		= 0644,
>  		.proc_handler	= &proc_dointvec
>  	},
> +#endif

just move the whole systctl registration into a MMU-only file

also please split this patch up into individual, small ones
