Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUJJIOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUJJIOz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 04:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUJJIOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 04:14:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47852 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268189AbUJJIOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 04:14:53 -0400
Date: Sun, 10 Oct 2004 10:14:16 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, dm-crypt@saout.de
Subject: Re: [PATCH?] make __bio_add_page check q->max_hw_sectors
Message-ID: <20041010081412.GA14636@suse.de>
References: <20041010115004.A5282@freya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041010115004.A5282@freya>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10 2004, Adam J. Richter wrote:
> 	On an dm-crypt partiton on an IDE disk, 2.6.9-rc3 and
> 2.6.9-rc3-bk9 repeatedly generate the following error, which
> does not occur in 2.6.9-rc1:
> 
> 	bio too big for device dm-0 (256 > 255)
> 
> 	The stack trace looked something like this:
> 
> submit_bio
> mpage_bio_submit
> mpage_readpages
> readpages
> do_page_cache_readahead
> filemap_nopage
> do_no_page
> handle_mm_fault
> 
> 	Around 2.6.9-rc3, a new field q->max_hw_sectors was
> added to struct request_queue.  I was able to make this
> problem disappear by the following patch, which adds a
> check of this new field to __bio_add_page.  (I've edited
> this patch to hide other differences in my fs/bio.c, so
> it may be necessary to apply it by hand if patch fails.)
> 
> 	I do not understand the intended difference between
> the new max_hw_sectors field and max_sectors, so it is unclear
> to me if it is a bug that my dm-crypt request_queue has
> q->max_hw_sectors < q->max_sectors.  If q->max_hw_sectors
> is supposed to be guaranteed to be greater than or equal
> to q->max_sectors, then the real bug is elsewhere and my
> patch is unnecessary.

That's exactly correct, ->max_sectors must never be bigger than
max_hw_sectors, that is the real bug.

-- 
Jens Axboe

