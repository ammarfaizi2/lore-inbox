Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVLFVHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVLFVHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVLFVHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:07:17 -0500
Received: from alfie.demon.co.uk ([80.177.172.67]:63244 "EHLO
	alfie.demon.co.uk") by vger.kernel.org with ESMTP id S965035AbVLFVHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:07:16 -0500
Date: Tue, 6 Dec 2005 21:04:45 +0000
From: Nick Holloway <Nick.Holloway@pyrites.org.uk>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc4 1/1] cpia: use vm_insert_page() instead of remap_pfn_range()
Message-ID: <20051206210445.GB7591@pyrites.org.uk>
References: <20051205152758.GA29108@pyrites.org.uk> <20051206191012.GA27116@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206191012.GA27116@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 07:10:12PM +0000, Christoph Hellwig wrote:
> >     pos = (unsigned long)(cam->frame_buf);
> >     while (size > 0) {
> > -           page = vmalloc_to_pfn((void *)pos);
> > -           if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > +           page = vmalloc_to_page((void *)pos);
> > +           if (vm_insert_page(vma, start, page)) {
>
> it would be nicer to do the arithmetis on pos as pointers rather than unsigned
> long.  Also you might want to use alloc_pages + vmap instead of vmalloc so that
> you already have a page array.  Or we should provide a helper that walks over
> a vmalloc'ed region and calls vmalloc_to_page + vm_insert_page.  Either way
> this type of code is duplicated far too much and we'd really need some better
> interface for it.

As I said in my previous mail, the patch was just switching to use
vm_insert_page, and not any other cleanups.

I agree that a helper is a good idea, as the vmalloc, SetPageReserved,
remap_pfn_range (was remap_page_range in 2.4) pattern has been copied
and pasted across many video4linux drivers.

The cpia driver could do with other cleanups.

        - It doesn't have a sysfs release callback (so says warning printk).
	- The colourspace conversion has been disabled, but should be
	  ripped out.
	- Needs to support V4L2 API

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
