Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVEROeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVEROeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVEROdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:33:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58341 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262207AbVERO1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:27:10 -0400
Date: Wed, 18 May 2005 15:27:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: cotte@freenet.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: execute in place (V2)
Message-ID: <20050518142707.GA23162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, cotte@freenet.de,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	schwidefsky@de.ibm.com, akpm@osdl.org
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424413.2202.17.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116424413.2202.17.camel@cotte.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  static inline void do_generic_file_read(struct file * filp, loff_t *ppos,
>  					read_descriptor_t * desc,
>  					read_actor_t actor)
>  {
> -	do_generic_mapping_read(filp->f_mapping,
> -				&filp->f_ra,
> -				filp,
> -				ppos,
> -				desc,
> -				actor);
> +	if (file_is_xip(filp))
> +		do_xip_mapping_read(filp->f_mapping,
> +					&filp->f_ra,
> +					filp,
> +					ppos,
> +					desc,
> +					actor);
> +	else
> +		do_generic_mapping_read(filp->f_mapping,
> +					&filp->f_ra,
> +					filp,
> +					ppos,
> +					desc,
> +					actor);
>  }

>  	size_t count;
> +	int xip = file_is_xip(filp) ? 1 : 0;
>  
>  	count = 0;
>  	for (seg = 0; seg < nr_segs; seg++) {
> @@ -990,7 +992,9 @@
>  	}
>  
>  	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
> -	if (filp->f_flags & O_DIRECT) {
> +	/* do not use generic_file_direct_IO on xip files, xip IO is
> +	   implicitly direct as well */
> +	if (filp->f_flags & O_DIRECT && !xip) {
>  		loff_t pos = *ppos, size;
>  		struct address_space *mapping;
>  		struct inode *inode;

I don't like this read split at all.  Please just define a completely
separate entry point for read, xip_file_read except for verifying the
iovecs you don't share any code.

> @@ -1538,10 +1545,13 @@
>  {
>  	struct address_space *mapping = file->f_mapping;
>  
> -	if (!mapping->a_ops->readpage)
> +	if ((!mapping->a_ops->readpage) && (!mapping_is_xip(mapping)))
>  		return -ENOEXEC;
>  	file_accessed(file);
> -	vma->vm_ops = &generic_file_vm_ops;
> +	if (mapping_is_xip(mapping))
> +		vma->vm_ops = &xip_file_vm_ops;
> +	else
> +		vma->vm_ops = &generic_file_vm_ops;
>  	return 0;
>  }

Similar please add a separate xip_file_mmap.

> @@ -2123,6 +2062,13 @@
>  
>  	inode_update_time(inode, 1);
>  
> +	if (file_is_xip(file)) {
> +		/* use execute in place to copy directly to disk */
> +		written = generic_file_xip_write (iocb, iov,
> +			        nr_segs, pos, ppos, count);
> +		goto out;
> +	}
> +

Dito with xip_file_write.

> diff -ruN linux-git/mm/filemap.h linux-git-xip/mm/filemap.h
> --- linux-git/mm/filemap.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-git-xip/mm/filemap.h	2005-05-17 18:33:57.792451512 +0200
> @@ -0,0 +1,141 @@
> +/*
> + *	linux/mm/filemap.h
> + *
> + * Copyright (C) 2005 IBM Corporation

I think just adding an IBM copyright isn't fair.  Just copy it from
filemap.c

> +		/*
> +		 * We need the page_table_lock to protect us from page faults,
> +		 * munmap, fork, etc...
> +		 */
> +		spin_lock(&mm->page_table_lock);
> +		pgd = pgd_offset(mm, address);
> +		if (!pgd_present(*pgd))
> +			goto next_unlock;
> +		pud = pud_offset(pgd, address);
> +		if (!pud_present(*pud))
> +			goto next_unlock;
> +		pmd = pmd_offset(pud, address);
> +		if (!pmd_present(*pmd))
> +			goto next_unlock;
> +		
> +		pte = pte_offset_map(pmd, address);
> +		if (!pte_present(*pte))
> +			goto next_unmap;
> +		if ((page_to_pfn(virt_to_page(empty_zero_page)))
> +			!= pte_pfn(*pte))
> +			/* pte does already reference new xip block here */

You should probably use page_check_address().  Currently it's static in rmap.c,
but that could be changed.

