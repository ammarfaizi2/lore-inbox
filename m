Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWCCRQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWCCRQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWCCRQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:16:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:36269 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030250AbWCCRQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:16:34 -0500
Subject: Re: [PATCH 2/4] pass b_size to ->get_block()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060301175218.6360cf7f.akpm@osdl.org>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	 <1141075413.10542.23.camel@dyn9047017100.beaverton.ibm.com>
	 <20060301175218.6360cf7f.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 09:17:55 -0800
Message-Id: <1141406280.10542.77.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 17:52 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Pass amount of disk needs to be mapped to get_block().
> > This way one can modify the fs ->get_block() functions 
> > to map multiple blocks at the same time.
> 
> I can't say I terribly like this patch.  Initialising b_size all over the
> place seems fragile.

I went through all the in-kernel places where we call ->getblock()
and initialized b_size correctly.

> 
> We're _already_ setting bh.b_size to the right thing in
> alloc_page_buffers(), and for a bh which is attached to
> pagecache_page->private, there's no reason why b_size would ever change.

Good point.

> So what I think I'll do is to convert those places where you're needlessly
> assigning to b_size into temporary WARN_ON(b_size != blocksize).

Yep. 


> The only place where we need to initialise b_size is where we've got a
> non-pagecache bh allocated on the stack.
> 
> We need to be sure that no ->get_block() implementations write garbage into
> bh->b_size if something goes wrong.  b_size on a pagecache-based
> buffer_head must remain inviolate.

Good news is, filesystems that allocate a single block currently don't
care about b_size anyway.

I guess to be paranoid, we should add WARN_ON() or BUG_ON() in jfs, xfs,
ext3 (in -mm) ->getblock() to check for a valid b_size, before using it
(not being negitive, multiple of blocksize, not-a-huge-number type
checks ?).

Thanks,
Badari

