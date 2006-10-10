Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWJJMKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWJJMKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWJJMKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:10:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11176 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965132AbWJJMKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:10:18 -0400
Date: Tue, 10 Oct 2006 13:10:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Message-ID: <20061010121003.GA19322@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Piggin <npiggin@suse.de>,
	Linux Memory Management <linux-mm@kvack.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061007105758.14024.70048.sendpatchset@linux.site> <20061007105853.14024.95383.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007105853.14024.95383.sendpatchset@linux.site>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 03:06:32PM +0200, Nick Piggin wrote:
> +/*
> + * fault_data is filled in the the pagefault handler and passed to the
> + * vma's ->fault function. That function is responsible for filling in
> + * 'type', which is the type of fault if a page is returned, or the type
> + * of error if NULL is returned.
> + */
> +struct fault_data {
> +	struct vm_area_struct *vma;
> +	unsigned long address;
> +	pgoff_t pgoff;
> +	unsigned int flags;
> +
> +	int type;
> +};
>  
>  /*
>   * These are the virtual MM functions - opening of an area, closing and
> @@ -203,6 +221,7 @@ extern pgprot_t protection_map[16];
>  struct vm_operations_struct {
>  	void (*open)(struct vm_area_struct * area);
>  	void (*close)(struct vm_area_struct * area);
> +	struct page * (*fault)(struct fault_data * data);

Please pass the vma as an explicit first argument so that all vm_operations
operate on a vma.  It's also much cleaner to have the separate between the
the object operated on (the vma) and all the fault details (struct fault_data).

