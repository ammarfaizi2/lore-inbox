Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWCOBgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWCOBgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWCOBgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:36:39 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:12812 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S932573AbWCOBgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:36:38 -0500
Message-ID: <44176F5D.1070204@snapgear.com>
Date: Wed, 15 Mar 2006 11:35:25 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: gerg@uclinux.org, Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Subject: Re: [patch][rfc] nommu: reverse mappings for nommu to solve get_user_pages
 problem
References: <20060311032606.GK26501@wotan.suse.de>
In-Reply-To: <20060311032606.GK26501@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Nick Piggin wrote:
> Just wondering what people think of the following patch?
> Testing, comments, etc would be welcome.

I like the idea.


> It compiles here, but is untested as of yet because I have
> nothing to boot a kernel with.

I tried this against 2.6.16-rc6 and it didn't go so well:


uClinux/COLDFIRE(m520x)
COLDFIRE port done by Greg Ungerer, gerg@snapgear.com
Flat model support (C) 1998,1999 Kenneth Albanowski, D. Jeff Dionne
Built 1 zonelists
Kernel command line:
PID hash table entries: 4096 (order: 12, 65536 bytes)
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Badness in page_count at mm/nommu.c:249
Stack from 400f9f3c:<0>
        <0> 400f9f4c<0> 400f9ff8<0> 4004258e<0> 400dc934<0> 400d998e<0> 
400de0de<0> 000000f9<0> 40a65440<0>
        <0> 4003d314<0> 40a65440<0> 40a65440<0> 00000000<0> fffffffc<0> 
00000004<0> 40a65440<0> 00042000<0>
        <0> 40100320<0> 40a65440<0> 00000000<0> 40a65440<0> 00040c22<0> 
4010e33c<0> 00002704<0> 00000000<0>
        <0> 4010004c<0> 40a65440<0> 00000000<0> 00000000<0> 00000000<0> 
00000000<0> 02000000<0> 00000000<0>
        <0> 00000000<0> 4002799c<0> 00000000<0> 00000000<0> 00000000<0> 
401001ba<0> 400f0f08<0> 40023344<0>
        <0> 00000000<0> 00000000<0> 00000000<0> 00000000<0> 400fa466<0> 
40105000<0> 40105ae8<0> 00000000<0>
Call Trace:<0>
        <0> [<400200ac>]<0>

I'll dig into a little to see what it is doing...

Regards
Greg





> --
> Add a reverse mapping system for nommu for anonymous pages to be able
> to find the vma in which they are allocated.
> 
> This allows a proper implementation of get_user_pages without breaking
> callers: it is now possible to go from the page to the vma and then
> increment or decrement its refcount.
> 
> Previously, get_user_pages would only refcount the struct page of anon
> pages, however they are allocated via the slab, so an elevated refcount
> on the page does not prevent the slab from being freed and reused.
> 
> Anonymous slab allocations of less than PAGE_SIZE are not supported,
> because a single struct page may correspond to several vmas, and currently
> free slabs which may be used for vmas in future.
> 
> 
> Index: linux-2.6/mm/internal.h
> ===================================================================
> --- linux-2.6.orig/mm/internal.h
> +++ linux-2.6/mm/internal.h
> @@ -11,19 +11,7 @@
>  
>  static inline void set_page_refs(struct page *page, int order)
>  {
> -#ifdef CONFIG_MMU
>  	set_page_count(page, 1);
> -#else
> -	int i;
> -
> -	/*
> -	 * We need to reference all the pages for this order, otherwise if
> -	 * anyone accesses one of the pages with (get/put) it will be freed.
> -	 * - eg: access_process_vm()
> -	 */
> -	for (i = 0; i < (1 << order); i++)
> -		set_page_count(page + i, 1);
> -#endif /* CONFIG_MMU */
>  }
>  
>  extern void fastcall __init __free_pages_bootmem(struct page *page,
> Index: linux-2.6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -423,11 +423,6 @@ static void __free_pages_ok(struct page 
>  		mutex_debug_check_no_locks_freed(page_address(page),
>  						 PAGE_SIZE<<order);
>  
> -#ifndef CONFIG_MMU
> -	for (i = 1 ; i < (1 << order) ; ++i)
> -		__put_page(page + i);
> -#endif
> -
>  	for (i = 0 ; i < (1 << order) ; ++i)
>  		reserved += free_pages_check(page + i);
>  	if (reserved)
> Index: linux-2.6/include/linux/mm.h
> ===================================================================
> --- linux-2.6.orig/include/linux/mm.h
> +++ linux-2.6/include/linux/mm.h
> @@ -316,8 +316,7 @@ struct page {
>  #define set_page_count(p,v) 	atomic_set(&(p)->_count, (v) - 1)
>  #define __put_page(p)		atomic_dec(&(p)->_count)
>  
> -extern void FASTCALL(__page_cache_release(struct page *));
> -
> +#ifdef CONFIG_MMU
>  static inline int page_count(struct page *page)
>  {
>  	if (PageCompound(page))
> @@ -332,6 +331,14 @@ static inline void get_page(struct page 
>  	atomic_inc(&page->_count);
>  }
>  
> +#else /* CONFIG_MMU */
> +
> +int page_count(struct page *page);
> +void get_page(struct page *page);
> +#endif
> +
> +extern void FASTCALL(__page_cache_release(struct page *));
> +
>  void put_page(struct page *page);
>  
>  /*
> Index: linux-2.6/mm/nommu.c
> ===================================================================
> --- linux-2.6.orig/mm/nommu.c
> +++ linux-2.6/mm/nommu.c
> @@ -122,27 +122,217 @@ unsigned int kobjsize(const void *objp)
>  	return (PAGE_SIZE << page->index);
>  }
>  
> +static struct vm_area_struct *page_vma(struct page *page)
> +{
> +	BUG_ON(!PageAnon(page));
> +	return (struct vm_area_struct *)page->mapping - PAGE_MAPPING_ANON;
> +}
> +
> +static void set_page_vma(struct page *page, struct vm_area_struct *vma)
> +{
> +	BUG_ON(PageAnon(page));
> +	page->mapping = (struct address_space *)vma + PAGE_MAPPING_ANON;
> +}
> +
> +static void clear_page_vma(struct page *page)
> +{
> +	BUG_ON(!PageAnon(page));
> +	page->mapping = NULL;
> +}
> +
> +static void set_aligned_area_anon_vma(unsigned long start, unsigned long end,
> +					struct vm_area_struct *vma)
> +{
> +	start = (start + PAGE_SIZE-1) & (PAGE_SIZE-1);
> +	end = end & (PAGE_SIZE-1);
> +
> +	while (start < end) {
> +		struct page *page;
> +		page = virt_to_page(start);
> +		BUG_ON(!page);
> +		BUG_ON(PageAnon(page));
> +		set_page_vma(page, vma);
> +	}
> +}
> +
> +static void clear_aligned_area_anon_vma(unsigned long start, unsigned long end)
> +{
> +	start = (start + PAGE_SIZE-1) & (PAGE_SIZE-1);
> +	end = end & (PAGE_SIZE-1);
> +
> +	while (start < end) {
> +		struct page *page;
> +		page = virt_to_page(start);
> +		BUG_ON(!page);
> +		BUG_ON(!PageAnon(page));
> +		clear_page_vma(page);
> +	}
> +}
> +
> +static void put_compound_page(struct page *page)
> +{
> +	page = (struct page *)page_private(page);
> +	if (put_page_testzero(page)) {
> +		void (*dtor)(struct page *page);
> +
> +		dtor = (void (*)(struct page *))page[1].mapping;
> +		(*dtor)(page);
> +	}
> +}
> +
> +static void delete_nommu_vma(struct vm_area_struct *vma)
> +{
> +	struct address_space *mapping;
> +
> +	/* remove the VMA from the mapping */
> +	if (vma->vm_file) {
> +		mapping = vma->vm_file->f_mapping;
> +
> +		flush_dcache_mmap_lock(mapping);
> +		vma_prio_tree_remove(vma, &mapping->i_mmap);
> +		flush_dcache_mmap_unlock(mapping);
> +	}
> +
> +	/* remove from the master list */
> +	rb_erase(&vma->vm_rb, &nommu_vma_tree);
> +}
> +
>  /*
> - * The nommu dodgy version :-)
> + * handle mapping disposal for uClinux
>   */
> +static void put_vma(struct vm_area_struct *vma)
> +{
> +	if (vma) {
> +		down_write(&nommu_vma_sem);
> +
> +		if (atomic_dec_and_test(&vma->vm_usage)) {
> +			delete_nommu_vma(vma);
> +
> +			if (vma->vm_ops && vma->vm_ops->close)
> +				vma->vm_ops->close(vma);
> +
> +			/* IO memory and memory shared directly out of the pagecache from
> +			 * ramfs/tmpfs mustn't be released here */
> +			if (vma->vm_flags & VM_MAPPED_COPY) {
> +				realalloc -= kobjsize((void *) vma->vm_start);
> +				askedalloc -= vma->vm_end - vma->vm_start;
> +				clear_aligned_area_anon_vma(vma->vm_start,
> +								vma->vm_end);
> +				kfree((void *) vma->vm_start);
> +			}
> +
> +			realalloc -= kobjsize(vma);
> +			askedalloc -= sizeof(*vma);
> +
> +			if (vma->vm_file)
> +				fput(vma->vm_file);
> +			kfree(vma);
> +		}
> +
> +		up_write(&nommu_vma_sem);
> +	}
> +}
> +
> +int page_count(struct page *page)
> +{
> +	/*
> +	 * slab doesn't internally try to do interesting things with
> +	 * page count between the time PageSlab is set and cleared,
> +	 * so it shouldn't reach in here.
> +	 */
> +	if (PageAnon(page)) {
> +		struct vm_area_struct *vma;
> +		vma = page_vma(page);
> +		return atomic_read(&vma->vm_usage);
> +	}
> +	/* anonymous page that couldn't be aligned */
> +	if (!page->mapping)
> +		WARN_ON(1);
> +
> +	if (PageCompound(page))
> +		page = (struct page *)page_private(page);
> +	return atomic_read(&page->_count) + 1;
> +}
> +
> +void get_page(struct page *page)
> +{
> +	if (PageAnon(page)) {
> +		struct vm_area_struct *vma;
> +		vma = page_vma(page);
> +		atomic_inc(&vma->vm_usage);
> +		return;
> +	}
> +	if (!page->mapping)
> +		WARN_ON(1);
> +
> +	if (unlikely(PageCompound(page)))
> +		page = (struct page *)page_private(page);
> +	atomic_inc(&page->_count);
> +}
> +
> +void put_page(struct page *page)
> +{
> +	if (PageAnon(page)) {
> +		struct vm_area_struct *vma;
> +		vma = page_vma(page);
> +		put_vma(vma);
> +	}
> +	if (!page->mapping)
> +		WARN_ON(1);
> +
> +	if (unlikely(PageCompound(page)))
> +		put_compound_page(page);
> +	else if (put_page_testzero(page))
> +		__page_cache_release(page);
> +}
> +
>  int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  	unsigned long start, int len, int write, int force,
>  	struct page **pages, struct vm_area_struct **vmas)
>  {
>  	int i;
> -	static struct vm_area_struct dummy_vma;
> +	struct page *__page;
> +	static struct vm_area_struct *__vma;
> +	unsigned long addr = start;
>  
>  	for (i = 0; i < len; i++) {
> +		__vma = find_vma(mm, addr);
> +		if (!__vma)
> +			goto out_failed;
> +
> +		__page = virt_to_page(addr);
> +		if (!__page)
> +			goto out_failed;
> +
> +		BUG_ON(page_vma(__page) != __vma);
> +
>  		if (pages) {
> -			pages[i] = virt_to_page(start);
> -			if (pages[i])
> -				page_cache_get(pages[i]);
> +			if (!__page->mapping) {
> +				printk(KERN_INFO "get_user_pages on unaligned"
> +						"anonymous page unsupported\n");				dump_stack();
> +				goto out_failed;
> +			}
> +
> +			page_cache_get(__page);
> +			pages[i] = __page;
>  		}
> +
>  		if (vmas)
> -			vmas[i] = &dummy_vma;
> -		start += PAGE_SIZE;
> +			vmas[i] = __vma;
> +
> +		addr += PAGE_SIZE;
>  	}
> -	return(i);
> +
> +	return i;
> +
> +out_failed:
> +	if (pages) {
> +		while (i) {
> +			put_page(pages[i]);
> +			i--;
> +		}
> +	}
> +	return -EFAULT;
>  }
>  
>  EXPORT_SYMBOL(get_user_pages);
> @@ -345,23 +535,6 @@ static void add_nommu_vma(struct vm_area
>  	rb_insert_color(&vma->vm_rb, &nommu_vma_tree);
>  }
>  
> -static void delete_nommu_vma(struct vm_area_struct *vma)
> -{
> -	struct address_space *mapping;
> -
> -	/* remove the VMA from the mapping */
> -	if (vma->vm_file) {
> -		mapping = vma->vm_file->f_mapping;
> -
> -		flush_dcache_mmap_lock(mapping);
> -		vma_prio_tree_remove(vma, &mapping->i_mmap);
> -		flush_dcache_mmap_unlock(mapping);
> -	}
> -
> -	/* remove from the master list */
> -	rb_erase(&vma->vm_rb, &nommu_vma_tree);
> -}
> -
>  /*
>   * determine whether a mapping should be permitted and, if so, what sort of
>   * mapping we're capable of supporting
> @@ -656,6 +829,8 @@ static int do_mmap_private(struct vm_are
>  		memset(base, 0, len);
>  	}
>  
> +	set_aligned_area_anon_vma(vma->vm_start, vma->vm_start, vma);
> +
>  	return 0;
>  
>  error_free:
> @@ -685,7 +860,7 @@ unsigned long do_mmap_pgoff(struct file 
>  	struct rb_node *rb;
>  	unsigned long capabilities, vm_flags;
>  	void *result;
> -	int ret;
> +	unsigned long ret;
>  
>  	/* decide whether we should attempt the mapping, and if so what sort of
>  	 * mapping */
> @@ -868,40 +1043,6 @@ unsigned long do_mmap_pgoff(struct file 
>  	return -ENOMEM;
>  }
>  
> -/*
> - * handle mapping disposal for uClinux
> - */
> -static void put_vma(struct vm_area_struct *vma)
> -{
> -	if (vma) {
> -		down_write(&nommu_vma_sem);
> -
> -		if (atomic_dec_and_test(&vma->vm_usage)) {
> -			delete_nommu_vma(vma);
> -
> -			if (vma->vm_ops && vma->vm_ops->close)
> -				vma->vm_ops->close(vma);
> -
> -			/* IO memory and memory shared directly out of the pagecache from
> -			 * ramfs/tmpfs mustn't be released here */
> -			if (vma->vm_flags & VM_MAPPED_COPY) {
> -				realalloc -= kobjsize((void *) vma->vm_start);
> -				askedalloc -= vma->vm_end - vma->vm_start;
> -				kfree((void *) vma->vm_start);
> -			}
> -
> -			realalloc -= kobjsize(vma);
> -			askedalloc -= sizeof(*vma);
> -
> -			if (vma->vm_file)
> -				fput(vma->vm_file);
> -			kfree(vma);
> -		}
> -
> -		up_write(&nommu_vma_sem);
> -	}
> -}
> -
>  int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
>  {
>  	struct vm_list_struct *vml, **parent;
> Index: linux-2.6/mm/swap.c
> ===================================================================
> --- linux-2.6.orig/mm/swap.c
> +++ linux-2.6/mm/swap.c
> @@ -45,6 +45,7 @@ static void put_compound_page(struct pag
>  	}
>  }
>  
> +#ifdef CONFIG_MMU
>  void put_page(struct page *page)
>  {
>  	if (unlikely(PageCompound(page)))
> @@ -53,6 +54,7 @@ void put_page(struct page *page)
>  		__page_cache_release(page);
>  }
>  EXPORT_SYMBOL(put_page);
> +#endif
>  
>  /*
>   * Writeback is about to end against a page which has been marked for immediate
> Index: linux-2.6/fs/binfmt_flat.c
> ===================================================================
> --- linux-2.6.orig/fs/binfmt_flat.c
> +++ linux-2.6/fs/binfmt_flat.c
> @@ -457,7 +457,7 @@ static int load_flat_file(struct linux_b
>  		printk("BINFMT_FLAT: Loading file: %s\n", bprm->filename);
>  
>  	if (rev != FLAT_VERSION && rev != OLD_FLAT_VERSION) {
> -		printk("BINFMT_FLAT: bad flat file version 0x%x (supported 0x%x and 0x%x)\n", rev, FLAT_VERSION, OLD_FLAT_VERSION);
> +		printk("BINFMT_FLAT: bad flat file version 0x%x (supported 0x%lx and 0x%lx)\n", rev, FLAT_VERSION, OLD_FLAT_VERSION);
>  		return -ENOEXEC;
>  	}
>  	
> Index: linux-2.6/include/linux/flat.h
> ===================================================================
> --- linux-2.6.orig/include/linux/flat.h
> +++ linux-2.6/include/linux/flat.h
> @@ -14,7 +14,7 @@
>  #include <asm/flat.h>
>  #endif
>  
> -#define	FLAT_VERSION			0x00000004L
> +#define	FLAT_VERSION			0x00000004UL
>  
>  #ifdef CONFIG_BINFMT_SHARED_FLAT
>  #define	MAX_SHARED_LIBS			(4)
> @@ -69,7 +69,7 @@ struct flat_hdr {
>  
>  #include <asm/byteorder.h>
>  
> -#define	OLD_FLAT_VERSION			0x00000002L
> +#define	OLD_FLAT_VERSION			0x00000002UL
>  #define OLD_FLAT_RELOC_TYPE_TEXT	0
>  #define OLD_FLAT_RELOC_TYPE_DATA	1
>  #define OLD_FLAT_RELOC_TYPE_BSS		2
> 
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a Secure Computing Company      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
