Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUENEiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUENEiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 00:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264159AbUENEiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 00:38:24 -0400
Received: from thunk.org ([140.239.227.29]:26813 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264101AbUENEiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 00:38:23 -0400
Date: Fri, 14 May 2004 00:37:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC/RFT] [PATCH] EXT3: Retry allocation after journal commit
Message-ID: <20040514043743.GA22593@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E1BOQmf-0005cP-4Q@thunk.org> <20040513195310.5725fa43.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513195310.5725fa43.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 07:53:10PM -0700, Andrew Morton wrote:
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> >
> > It is possible for block allocation to fail, even if there is space in
> >  the filesystem, because all of the free blocks were recently deleted and
> >  so could not be allocated until after the currently running transaction
> >  is committed.   This can result in a very strange and surprising result
> >  where a system call such as a mkdir() will fail even though there is
> >  plenty of disk space apparently available.
> 
> I merged a little patch for this into post-2.6.6, but that only addresses
> prepare_write().

Oh, sorry, I didn't see that patch.  The specific bug I was trying to
fix was actually in mkdir though (the regression test suite did the
equivalent of rm -rf /mntpt/*, followed by mkdir's which failed).

I can respin the patch versus BK-latest.

> I wonder if there's much value in having ext3_has_free_blocks()?  We could
> just retry three times even if the fs is really full?

We could; it's an error path, after all.  On the other hand, the cost
of ext3_has_free_blocks() is pretty small, and if we know that there's
no point doing the retry, why not skip the work.

> I'd be inclined to pass a pointer to the `retry' counter into
> ext3_should_retry_alloc() and implement the counting in there.  It'll tidy
> things up a bit and consolidates that piece of policy in a single place.

Yes, good point.

						- Ted
