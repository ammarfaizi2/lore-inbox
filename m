Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbULHKpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbULHKpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 05:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbULHKpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 05:45:10 -0500
Received: from [213.146.154.40] ([213.146.154.40]:21652 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261182AbULHKon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 05:44:43 -0500
Date: Wed, 8 Dec 2004 10:44:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
Subject: Re: [4/6] Xen VMM #4: HAS_ARCH_DEV_MEM
Message-ID: <20041208104442.GB29779@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
	Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
	Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
References: <E1CbwFE-0006PZ-00@mta1.cl.cam.ac.uk> <E1CbwHQ-0006Zf-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CbwHQ-0006Zf-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 07:30:31AM +0000, Ian Pratt wrote:
> 
> This patch adds ARCH_HAS_DEV_MEM, enabling per-architecture
> implementations of /dev/mem and thus avoids a number of messy
> #ifdef's. Although the mmap case can be solved easily be simply using
> io_remap_page_range instead of remap_pfn_range on all architecutres,
> we need to support read/write of /dev/mem in order for dmidecode etc
> to work. These changes are more messy, and we believe warrant making
> /dev/mem arch specific, which also cleans up uncached_access too.
> 
> Signed-off-by: ian.pratt@cl.cam.ac.uk
> 
> ---
> 
> 
> diff -Nurp pristine-linux-2.6.10-rc3/drivers/char/mem.c tmp-linux-2.6.10-rc3-xen.patch/drivers/char/mem.c
> --- pristine-linux-2.6.10-rc3/drivers/char/mem.c	2004-12-03 21:53:47.000000000 +0000
> +++ tmp-linux-2.6.10-rc3-xen.patch/drivers/char/mem.c	2004-12-08 00:52:40.000000000 +0000
> @@ -143,7 +143,7 @@ static ssize_t do_write_mem(void *p, uns
>  	return written;
>  }
>  
> -
> +#ifndef ARCH_HAS_DEV_MEM
>  /*
>   * This funcion reads the *physical* memory. The f_pos points directly to the 
>   * memory location. 
> @@ -189,8 +189,9 @@ static ssize_t write_mem(struct file * f
>  		return -EFAULT;
>  	return do_write_mem(__va(p), p, buf, count, ppos);
>  }
> +#endif
>  
> -static int mmap_mem(struct file * file, struct vm_area_struct * vma)
> +static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
>  {
>  #ifdef pgprot_noncached
>  	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
> @@ -567,7 +568,7 @@ static int open_port(struct inode * inod
>  	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
>  }
>  
> -#define mmap_kmem	mmap_mem
> +#define mmap_mem	mmap_kmem
>  #define zero_lseek	null_lseek
>  #define full_lseek      null_lseek
>  #define write_zero	write_null
> @@ -575,6 +576,7 @@ static int open_port(struct inode * inod
>  #define open_mem	open_port
>  #define open_kmem	open_mem
>  
> +#ifndef ARCH_HAS_DEV_MEM
>  static struct file_operations mem_fops = {
>  	.llseek		= memory_lseek,
>  	.read		= read_mem,
> @@ -582,6 +584,9 @@ static struct file_operations mem_fops =
>  	.mmap		= mmap_mem,
>  	.open		= open_mem,
>  };
> +#else
> +extern struct file_operations mem_fops;
> +#endif

Any chance you could put the /dev/mem implementation into a separate
file, ala drivers/char/devmem.c and avoid the ifdefs?  ARCH_HAS_DEV_MEM
would have to become a CONFIG option then

