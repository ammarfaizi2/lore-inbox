Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292986AbSB1Q60>; Thu, 28 Feb 2002 11:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293500AbSB1Q5y>; Thu, 28 Feb 2002 11:57:54 -0500
Received: from ns1.cypress.com ([157.95.67.4]:38035 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S293483AbSB1Q4Q>;
	Thu, 28 Feb 2002 11:56:16 -0500
Message-ID: <3C7E608C.3020506@cypress.com>
Date: Thu, 28 Feb 2002 10:53:32 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, 
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: patch to NVIDIA_kernel & kernel 2.5.5
In-Reply-To: <XFMail.020228094914.pirx@minet.uni-jena.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner: Scanned but not guaranteed against viruses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it make more sens to us a compatibility marco
in one of NVIDIA's header files instead of
having the #if LINUX_VERSION_CODE scattered
everywhere? Or create a new header (kern_2.5_compat.h)?

Then if/when the kernel changes again just one file needs changed?

Martin Huenniger wrote:
> 
> diff -ur NVIDIA_kernel-1.0-2314.old/nv.c NVIDIA_kernel-1.0-2314/nv.c
> --- NVIDIA_kernel-1.0-2314.old/nv.c     Sat Dec  1 05:11:06 2001
> +++ NVIDIA_kernel-1.0-2314/nv.c Sun Feb 24 12:37:35 2002
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0) 
>      if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
> +       return nv_kern_ctl_open(inode, file);
> +#else    
> +    if (NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
>          return nv_kern_ctl_open(inode, file);


Here change NV_DEVICE_IS_CONTROL_DEVICE to add the kdev_val()
around arg 1.

> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)    

And 2 more times.

> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>          if (remap_page_range(vma->vm_start,
> +#else
> +        if (remap_page_range(vma, vma->vm_start
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0) 

make a macro for remap_page_range to always take
the new arg, but ignore it on older kernels.
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>      pg_table = pte_offset(pg_mid_dir, address);
> +#else
> +    pg_table = pte_offset_map(pg_mid_dir, address);

Macro that becomes pte_offset() or pte_offset_map()

> diff -ur NVIDIA_kernel-1.0-2314.old/os-interface.c
> NVIDIA_kernel-1.0-2314/os-interface.c
> --- NVIDIA_kernel-1.0-2314.old/os-interface.c   Sat Dec  1 05:11:06 2001
> +++ NVIDIA_kernel-1.0-2314/os-interface.c       Wed Feb 20 18:19:01 2002
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
> +    err = remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes,
> +#else
> +    err = remap_page_range( kaddr, (size_t) uaddr, (size_t) paddr, size_bytes, 
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)

use the new macro for remap_page_range 3 more times.


	-Thomas

