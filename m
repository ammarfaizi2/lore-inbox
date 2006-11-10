Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945992AbWKJG41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945992AbWKJG41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945996AbWKJG41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:56:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945992AbWKJG40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:56:26 -0500
Date: Thu, 9 Nov 2006 22:56:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <chris.mason@oracle.com>
Cc: linux-kernel@vger.kernel.org, dgc@sgi.com
Subject: Re: [PATCH] avoid too many boundaries in DIO
Message-Id: <20061109225618.1bdc634f.akpm@osdl.org>
In-Reply-To: <20061110014854.GS10889@think.oraclecorp.com>
References: <20061110014854.GS10889@think.oraclecorp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 20:48:54 -0500
Chris Mason <chris.mason@oracle.com> wrote:

> Dave Chinner found a 10% performance regression with ext3 when using DIO
> to fill holes instead of buffered IO.  On large IOs, the ext3 get_block
> routine will send more than a page worth of blocks back to DIO via a
> single buffer_head with a large b_size value.
> 
> The DIO code iterates through this massive block and tests for a
> boundary buffer over and over again.  For every block size unit spanned
> by the big map_bh, the boundary bit is tested and a bio may be forced
> down to the block layer.
> 
> There are two potential fixes, one is to ignore the boundary bit on
> large regions returned by the FS.  DIO can't tell which part of the big
> region was a boundary, and so it may not be a good idea to trust the
> hint.
> 
> This patch just clears the boundary bit after using it once.  It is 10%
> faster for a streaming DIO write w/blocksize of 512k on my sata drive.
> 

Thanks.

But that's two large performance regressions (so far) from the multi-block
get_block() feature.  And that was allegedly a performance optimisation! 
Who's testing this stuff?

> 
> diff -r 38d08cbe880b fs/direct-io.c
> --- a/fs/direct-io.c	Thu Nov 09 20:02:08 2006 -0500
> +++ b/fs/direct-io.c	Thu Nov 09 20:31:12 2006 -0500
> @@ -959,6 +959,17 @@ do_holes:
>  			BUG_ON(this_chunk_bytes == 0);
>  
>  			dio->boundary = buffer_boundary(map_bh);
> +
> +			/*
> +			 * get_block may return more than one page worth
> +			 * of blocks.  Only make the first one a boundary.
> +			 * This is still sub-optimal, it probably only
> +			 * makes sense to play with boundaries when
> +			 * get_block returns a single FS block sized
> +			 * unit.
> +			 */
> +			clear_buffer_boundary(map_bh);
> +
>  			ret = submit_page_section(dio, page, offset_in_page,
>  				this_chunk_bytes, dio->next_block_for_io);
>  			if (ret) {


Is that actually correct?  If ->get_block() returned a buffer_boundary()
buffer then what we want to do is to push down all the thus-far-queued BIOs
once we've submitted _all_ of the BIOs represented by map_bh.  I think that
if we require more than one BIO to cover map_bh.b_size then we'll do the
submission after the first BIO has been sent instead of after the final one
has been sent?

