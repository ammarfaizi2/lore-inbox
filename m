Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVLAF1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVLAF1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 00:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVLAF1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 00:27:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:65038 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932082AbVLAF1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 00:27:16 -0500
Date: Thu, 1 Dec 2005 06:26:42 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Adam Litke <agl@us.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: Re: Fix handling of ELF segments with zero filesize
Message-ID: <20051201052642.GW11266@alpha.home.local>
References: <20051201002049.GB14247@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201002049.GB14247@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 11:20:49AM +1100, David Gibson wrote:
> Andrew, please apply
> 
> mmap() returns -EINVAL if given a zero length, and thus elf_map() in
> binfmt_elf.c does likewise if it attempts to map a (page-aligned) ELF
> segment with zero filesize.  Such a situation never arises with the
> default linker scripts, but there's nothing inherently wrong with
> zero-filesize (but non-zero memsize) ELF segments.  Custom linker
> scripts can generate them, and the kernel should be able to map them;
> this patch makes it so.

David, 2.4 has exactly the same code, do you see anything wrong with
applying this patch to 2.4 too ?

Thanks in advance,
Willy

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Index: working-2.6/fs/binfmt_elf.c
> ===================================================================
> --- working-2.6.orig/fs/binfmt_elf.c	2005-11-23 15:56:30.000000000 +1100
> +++ working-2.6/fs/binfmt_elf.c	2005-12-01 11:11:01.000000000 +1100
> @@ -288,11 +288,17 @@ static unsigned long elf_map(struct file
>  			struct elf_phdr *eppnt, int prot, int type)
>  {
>  	unsigned long map_addr;
> +	unsigned long pageoffset = ELF_PAGEOFFSET(eppnt->p_vaddr);
>  
>  	down_write(&current->mm->mmap_sem);
> -	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
> -			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
> -			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
> +	/* mmap() will return -EINVAL if given a zero size, but a
> +	 * segment with zero filesize is perfectly valid */
> +	if (eppnt->p_filesz + pageoffset)
> +		map_addr = do_mmap(filep, ELF_PAGESTART(addr),
> +				   eppnt->p_filesz + pageoffset, prot, type,
> +				   eppnt->p_offset - pageoffset);
> +	else
> +		map_addr = ELF_PAGESTART(addr);
>  	up_write(&current->mm->mmap_sem);
>  	return(map_addr);
>  }
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
