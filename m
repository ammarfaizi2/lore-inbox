Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWDTJvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWDTJvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWDTJvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:51:01 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34452 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750792AbWDTJvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:51:00 -0400
From: Neil Brown <neilb@suse.de>
To: Jens Axboe <axboe@suse.de>
Date: Thu, 20 Apr 2006 19:50:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17479.22902.770558.600574@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sgunderson@bigfoot.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
In-Reply-To: message from Jens Axboe on Thursday April 20
References: <20060420160549.7637.patches@notabene>
	<1060420062955.7727@suse.de>
	<20060420003839.1a41c36f.akpm@osdl.org>
	<17479.21320.361708.237802@cse.unsw.edu.au>
	<20060420093056.GA614@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday April 20, axboe@suse.de wrote:
> > > 
> > > We're not supposed to look at page->index of an unlocked page.
> > 
> > We're not?  Does Jens know that?
> > __generic_file_splice_read seems to violate this principle!
> 
> Hmmm, where?
> 
2.6.17-rc1-mm1
fs/splice.c

static int __generic_file_splice_read(struct file *in, struct inode *pipe,
				      size_t len, unsigned int flags)
{
...snip....
	do_page_cache_readahead(mapping, in, index, nr_pages);

	/*
	 * Get as many pages from the page cache as possible..
	 * Start IO on the page cache entries we create (we
	 * can assume that any pre-existing ones we find have
	 * already had IO started on them).
	 */
	i = find_get_pages(mapping, index, nr_pages, pages);

	/*
	 * common case - we found all pages and they are contiguous,
	 * kick them off
	 */
	if (i && (pages[i - 1]->index == index + i - 1))
                  ^^^^^^^^^^^^^^^^^^^^
***There and
		goto splice_them;

	/*
	 * fill shadow[] with pages at the right locations, so we only
	 * have to fill holes
	 */
	memset(shadow, 0, nr_pages * sizeof(struct page *));
	for (j = 0; j < i; j++)
		shadow[pages[j]->index - index] = pages[j];
                      ^^^^^^^^^^^^^^^^

***There

NeilBrown
