Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSFULbX>; Fri, 21 Jun 2002 07:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316572AbSFULbW>; Fri, 21 Jun 2002 07:31:22 -0400
Received: from zwanebloem.xs4all.nl ([213.84.22.107]:8884 "EHLO
	thuis.zwanebloem.nl") by vger.kernel.org with ESMTP
	id <S316571AbSFULbT>; Fri, 21 Jun 2002 07:31:19 -0400
Date: Fri, 21 Jun 2002 13:52:16 +0200
From: faasen@xs4all.nl
To: Andre Bonin <kernel@bonin.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Makes NVidia's driver work with kernel 2.5.24
Message-ID: <20020621115216.GA4687@router.zwanebloem.xs4all.nl>
References: <3D1300D1.8020903@bonin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D1300D1.8020903@bonin.ca>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 05:32:49AM -0500, Andre Bonin wrote:
> Hi!
> 
> I found a patch that makes the NVidia's driver (NVIDIA_kernel-1.0-2960) 
> work with the 2.5 series kernels.  Unfortunatly it breaks because of the 
> deprecation of suser in 2.5.24.  I have created a patch for this (from 
> the 'stable' NVIDIA_kernel-1.0-2960 driver).
> 
> Most of the patch is not my doing but an unamed person somewhere on the 
> net. If you are that person, you can reply to this mail and take your 
> valid credit.
> 
> This is my first module change and my first patch so if there is 
> anything 'wierd' or 'wrong' please tell me, there's only one way to learn.
> 
> Thanks!
>
Great work, except I made the same patch some days ago since suser broke in 2.5.21 ;)
Look here 
http://marc.theaimsgroup.com/?l=linux-kernel&m=102424991602260&w=2
and here
http://thuis.zwanebloem.nl/nvidia

Guess it's better to have 2 patches then no patch :)

Tommy
 
> ---
> ***********************************
> Andre Bonin
> Computer Engineering Technologist
> Student in Software Engineering
> Ottawa, Ontario
> Canada
> ***********************************

> diff -ruN stable/NVIDIA_kernel-1.0-2960/Makefile NVIDIA_kernel-1.0-2960/Makefile
> --- stable/NVIDIA_kernel-1.0-2960/Makefile	Tue May 14 10:26:15 2002
> +++ NVIDIA_kernel-1.0-2960/Makefile	Fri Jun 21 04:16:51 2002
> @@ -9,6 +9,7 @@
>  HEADERS=os-interface.h nv-linux.h nv.h  nvrm.h nvtypes.h $(VERSION_HDR)
>  
>  CFLAGS=-Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts -Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD $(DEFINES) $(INCLUDES) -Wno-cast-qual
> +                        
>  
>  RESMAN_KERNEL_MODULE=Module-nvkernel
>  
> diff -ruN stable/NVIDIA_kernel-1.0-2960/nv-linux.h NVIDIA_kernel-1.0-2960/nv-linux.h
> --- stable/NVIDIA_kernel-1.0-2960/nv-linux.h	Tue May 14 10:26:16 2002
> +++ NVIDIA_kernel-1.0-2960/nv-linux.h	Fri May 31 12:35:41 2002
> @@ -38,7 +38,7 @@
>  #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>  #  define KERNEL_2_4
>  #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
> -#  error This driver does not support 2.5.x development kernels!
> +//#  error This driver does not support 2.5.x development kernels!
>  #  define KERNEL_2_5
>  #else
>  #  error This driver does not support 2.6.x or newer kernels!
> diff -ruN stable/NVIDIA_kernel-1.0-2960/nv.c NVIDIA_kernel-1.0-2960/nv.c
> --- stable/NVIDIA_kernel-1.0-2960/nv.c	Tue May 14 10:26:16 2002
> +++ NVIDIA_kernel-1.0-2960/nv.c	Fri May 31 12:35:41 2002
> @@ -50,6 +50,12 @@
>  #include <linux/devfs_fs_kernel.h>
>  #endif
>  
> +/* Since 2.5.x this is needed for the coorect lookup of the page table entry */
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 0)
> +#include <asm/kmap_types.h>
> +#include <linux/highmem.h>
> +#endif
> +
>  #include <asm/page.h>
>  #include <asm/pgtable.h>  		// pte bit definitions
>  #include <asm/system.h>                 // cli(), *_flags
> @@ -1155,11 +1161,22 @@
>  
>      /* for control device, just jump to its open routine */
>      /* after setting up the private data */
> +
> +    /* I don't really know the correct kernel version since when it changed */ 
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0) 
>      if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
>          return nv_kern_ctl_open(inode, file);
> -
> +#else
> +    if (NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
> +        return nv_kern_ctl_open(inode, file);
> +#endif
>      /* what device are we talking about? */
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>      devnum = NV_DEVICE_NUMBER(inode->i_rdev);
> +#else
> +    devnum = NV_DEVICE_NUMBER(kdev_val(inode->i_rdev));
> +#endif
>      if (devnum >= NV_MAX_DEVICES)
>      {
>          rc = -ENODEV;
> @@ -1265,9 +1282,14 @@
>  
>      /* for control device, just jump to its open routine */
>      /* after setting up the private data */
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>      if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
> +       return nv_kern_ctl_close(inode, file);
> +#else
> +    if(NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
>          return nv_kern_ctl_close(inode, file);
> -
> +#endif
>      NV_DMSG(nv, "close");
>  
>      nv_unix_free_all_unused_clients(nv, current->pid, (void *) file);
> @@ -1386,11 +1408,21 @@
>  #if defined(IA64)
>          vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  #endif
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>          if (remap_page_range(vma->vm_start,
>                               (u32)(nv->regs.address) + LINUX_VMA_OFFS(vma) - NV_MMAP_REG_OFFSET,
>                               vma->vm_end - vma->vm_start,
>                               vma->vm_page_prot))
>              return -EAGAIN;
> +#else
> +        if (remap_page_range(vma,
> +                            vma->vm_start,
> +                             (u32) (nv->regs.address) + LINUX_VMA_OFFS(vma) - NV_MMAP_REG_OFFSET,
> +                             vma->vm_end - vma->vm_start,
> +                             vma->vm_page_prot))
> +            return -EAGAIN;
> +#endif
>  
>          /* mark it as IO so that we don't dump it on core dump */
>          vma->vm_flags |= VM_IO;
> @@ -1403,11 +1435,20 @@
>  #if defined(IA64)
>          vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  #endif
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>          if (remap_page_range(vma->vm_start,
>                               (u32)(nv->fb.address) + LINUX_VMA_OFFS(vma) - NV_MMAP_FB_OFFSET,
>                               vma->vm_end - vma->vm_start,
>                               vma->vm_page_prot))
>              return -EAGAIN;
> +#else
> +        if (remap_page_range(vma,
> +                            vma->vm_start,
> +                             (u32) (nv->fb.address) + LINUX_VMA_OFFS(vma) - NV_MMAP_FB_OFFSET,
> +                             vma->vm_end - vma->vm_start,
> +                             vma->vm_page_prot))
> +            return -EAGAIN;
> +#endif
>  
>          // mark it as IO so that we don't dump it on core dump
>          vma->vm_flags |= VM_IO;
> @@ -1437,8 +1478,13 @@
>          while (pages--)
>          {
>              page = (unsigned long) at->page_table[i++];
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>              if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
>                	return -EAGAIN;
> +#else
> +            if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> +                 return -EAGAIN;
> +#endif
>              start += PAGE_SIZE;
>              pos += PAGE_SIZE;
>         	}
> @@ -2273,7 +2319,11 @@
>      pte_kunmap(pte__);
>  #else
>      pte__ = NULL;
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>      pte = *pte_offset(pg_mid_dir, address);
> +#else
> +    pte = *pte_offset_map(pg_mid_dir, address);
> +#endif
>  #endif
>  
>      if (!pte_present(pte)) 
> diff -ruN stable/NVIDIA_kernel-1.0-2960/os-interface.c NVIDIA_kernel-1.0-2960/os-interface.c
> --- stable/NVIDIA_kernel-1.0-2960/os-interface.c	Tue May 14 10:26:16 2002
> +++ NVIDIA_kernel-1.0-2960/os-interface.c	Fri Jun 21 04:54:35 2002
> @@ -41,6 +41,7 @@
>  #include <linux/stddef.h>
>  #include <linux/kernel.h>       // printk()
>  #include <linux/errno.h>        // error codes
> +#include <linux/sched.h>        // capable(int)
>  #include <linux/types.h>        // size_t
>  #include <linux/interrupt.h>    // in_interrupt()
>  #include <linux/delay.h>        // udelay()
> @@ -114,13 +115,13 @@
>  #endif // DEBUG
>  
>  // return TRUE if the caller is the super-user
> -BOOL osIsAdministrator(
> -    PHWINFO pDev
> -)
> -{
> -    return suser();
> +
> +BOOL osIsAdministrator( PHWINFO pDev ) {
> +    return capable( CAP_SYS_ADMIN );
>  }
>  
> +
> +
>  //
>  // Some quick and dirty library functions.
>  // This is an OS function because some operating systems supply their
> @@ -1458,9 +1459,14 @@
>      uaddr = *priv;
>  
>      /* finally, let's do it! */
> -    err = remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes, 
> +    
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
> +    err = remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes,
> +                           PAGE_SHARED);
> +#else
> +    err = remap_page_range( kaddr, (size_t) uaddr, (size_t) paddr, size_bytes,
>                              PAGE_SHARED);
> -
> +#endif
>      if (err != 0)
>      {
>          return (void *) NULL;
> @@ -1485,10 +1491,14 @@
>  
>      uaddr = *priv;
>  
> -    /* finally, let's do it! */
> -    err = remap_page_range( (size_t) uaddr, (size_t) start, size_bytes, 
> +    /* finally, let's do it! */ 
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
> +    err = remap_page_rage( (size_t) uaddr, (size_t) start, size_bytes,
> +                          PAGE_SHARED);    
> +#else
> +    err = remap_page_range( *priv, (size_t) uaddr, (size_t) start, size_bytes, 
>                              PAGE_SHARED);
> -
> +#endif
>      if (err != 0)
>      {
>          return (void *) NULL;
> @@ -2032,15 +2042,25 @@
>          return RM_ERROR;
>  
>      agp_addr = agpinfo.aper_base + (agp_data->offset << PAGE_SHIFT);
> -
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>      err = remap_page_range(vma->vm_start, (size_t) agp_addr, 
>                             agp_data->num_pages << PAGE_SHIFT,
>  #if defined(IA64)
>                             vma->vm_page_prot);
>  #else
>                             PAGE_SHARED);
> -#endif
> -        
> +#endif /* IA64 */
> +
> +#else
> +    err = remap_page_range(vma,
> +                          vma->vm_start, (size_t) agp_addr, 
> +                           agp_data->num_pages << PAGE_SHIFT,
> +#if defined(IA64)
> +                           vma->vm_page_prot);
> +#else
> +                           PAGE_SHARED);
> +#endif /* IA64 */
> +#endif /* LINUX_VERSION_CODE */
>      if (err) {
>          printk(KERN_ERR "NVRM: AGPGART: unable to remap %lu pages\n",
>                 (unsigned long)agp_data->num_pages);

