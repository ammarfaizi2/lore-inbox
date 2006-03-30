Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWC3HAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWC3HAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWC3HAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:00:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2918 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751197AbWC3HAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:00:01 -0500
Date: Thu, 30 Mar 2006 09:00:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330070009.GG13476@suse.de>
References: <20060329122841.GC8186@suse.de> <442B4447.9050700@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442B4447.9050700@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Nick Piggin wrote:
> Hi Jens,
> 
> Looks nice!
> 
> Jens Axboe wrote:
> 
> >Hi,
> >
> >Since my initial posting back in December, I've had some private queries
> >about the state of splice support. The state was pretty much that it was
> >a little broken, if one attempted to do file | file splicing. The
> >original patch migrated pages from one file to another in this case,
> >which got vm ugly really quickly. And it wasn't always the right thing
> >to do, since it would mean that splicing file1 to file2 would move
> >file1's page cache to file2. Sometimes this is what you want, sometimes
> >it is 
> >
> 
> Page migration now generalised vmscan.c and introduced remove_mapping
> function, which should help keep things clean.

Excellent.

> Moving a page onto and off the LRU is an interesting problem, though.
> But possibly you could just leave it on the LRU and transfer the pagecache
> reference over to the pipe. vmscan would find extra pages on the LRU at
> times, but they would go away when pipe releases the page.
> 
> Moving a page from a pipe to a filesystem might be harder, because you
> don't know if it came from a filesystem (still on LRU) or not (in which
> case you need to add it to LRU). If only you can keep track of this

Well that, to me, is _the_ hard problem to solve for this. But you
sort-of do know, my plan is/was to add a ->steal() hook to the pipe
buffers that would 'unhook' the page so it was in a clean state to be
added to the LRU/page cache again. If stealing failed, just fall back to
copying (or hard error, let the flags decide).

> information as the page gets passed around... hmm the PG_private will be
> free to use because a filesystem must always drop its buffers before
> remove_mapping can run. One would also need to take care of replacing
> an existing page I guess.
> 
> Hmm... I think it can work, falling back to copies if we get stuck
> anywhere.
> 
> Unless someone beats me to it, I'll try coding something up when I get
> a bit more free time.

You are more than welcome, I hope to give it a little shot today and see
how it goes.

-- 
Jens Axboe

