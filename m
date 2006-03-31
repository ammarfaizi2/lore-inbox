Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWCaHIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWCaHIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCaHII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:08:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27694 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751158AbWCaHII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:08:08 -0500
Date: Fri, 31 Mar 2006 09:08:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] splice: add support for SPLICE_F_MOVE flag
Message-ID: <20060331070814.GR13476@suse.de>
References: <200603302109.k2UL9ET0012970@hera.kernel.org> <20060330163544.72e50aab.akpm@osdl.org> <20060330185956.54961b7b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330185956.54961b7b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> >   static void page_cache_pipe_buf_unmap(struct pipe_inode_info *info,
> >  >  				      struct pipe_buffer *buf)
> >  >  {
> >  > -	unlock_page(buf->page);
> >  > +	if (!buf->stolen)
> >  > +		unlock_page(buf->page);
> >  >  	kunmap(buf->page);
> >  >  }
> > 
> >  There go our chances of ever getting rid of kmap().  Is it not feasible to
> >  use atomic kmaps throughout this code?
> 
> What are the kmaps for, anyway?  afaict they're doing the
> kmap-the-page-while-we-run-some-a_ops thing which ceased being a
> requirement 3-4 years ago.

Not quite so, it's because the ->map serve as both a pin and address map
helper. The splice stuff doesn't actually need the kmap(), only for the
case where we have to copy the page. And it would be just as easy to
map that ourselves in that case.

There's a comment about that in the splice file.

> The general approach we should take is that the code which actually
> modifies a page's contents is the code which is responsible for kmapping
> that page.  Use an atomic kmap, memcpy-or-memset, atomic kunmap.  Just four
> or five lines.
> 
> If we can do that, pipe_buf_operations.map/unmap can be removed.

The page cache stuff still needs to sanity check the page, before
allowing the caller to map it, so it cannot go. But it can be optimized.

-- 
Jens Axboe

