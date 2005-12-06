Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVLFTKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVLFTKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVLFTKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:10:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2495 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030188AbVLFTKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:10:14 -0500
Date: Tue, 6 Dec 2005 19:10:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nick Holloway <Nick.Holloway@pyrites.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2.6.15-rc4 1/1] cpia: use vm_insert_page() instead of remap_pfn_range()
Message-ID: <20051206191012.GA27116@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Holloway <Nick.Holloway@pyrites.org.uk>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20051205152758.GA29108@pyrites.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205152758.GA29108@pyrites.org.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	pos = (unsigned long)(cam->frame_buf);
>  	while (size > 0) {
> -		page = vmalloc_to_pfn((void *)pos);
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> +		page = vmalloc_to_page((void *)pos);
> +		if (vm_insert_page(vma, start, page)) {

it would be nicer to do the arithmetis on pos as pointers rather than unsigned
long.  Also you might want to use alloc_pages + vmap instead of vmalloc so that
you already have a page array.  Or we should provide a helper that walks over
a vmalloc'ed region and calls vmalloc_to_page + vm_insert_page.  Either way
this type of code is duplicated far too much and we'd really need some better
interface for it.

