Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWEAGxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWEAGxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 02:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWEAGxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 02:53:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17503 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751288AbWEAGxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 02:53:34 -0400
Date: Mon, 1 May 2006 08:54:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice(SPLICE_F_MOVE) problems
Message-ID: <20060501065412.GP23137@suse.de>
References: <20060501065953.GA289@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501065953.GA289@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01 2006, Oleg Nesterov wrote:
> I noticed sys_splice() and friends were added. Cool!
> But I can't understand how SPLICE_F_MOVE is supposed to
> work.
> 
> 	pipe_to_file:
> 
> 		if (sd->flags & SPLICE_F_MOVE) {
> 
> 			if (buf->ops->steal(info, buf))
> 				goto find_page;
> 
> Let's suppose that buf->ops == page_cache_pipe_buf_ops.
> page_cache_pipe_buf_steal() returns PG_locked page, why?

Seems silly to unlock the page, when add_to_page_cache() will set it
locked the instant after again.

> 
> 			page = buf->page;
> 			if (add_to_page_cache(page, mapping, index, gfp_mask))
> 
> This adds entire page to page cache. What about partial pages?
> This can corrupt sd->file if offset != 0 || this_len != PAGE_SIZE.

Yeah that's silly, I'll add a check for sd->len == PAGE_CACHE_SIZE!

> 				goto find_page;
> 
> Ok, add_to_page_cache() failed. 'page' is still locked.
> It will be released later, this should trigger bad_page().

Indeed, that was fixed and pushed to the splice repo yesterday actually
along with a fix for a missing lock in the pipe variant.

> Also, we don't clear PIPE_BUF_FLAG_STOLEN, so we will miss
> the data copying and page_cache_release(page) below:
> 
> 		if (!(buf->flags & PIPE_BUF_FLAG_STOLEN)) {
> 			char *dst = kmap_atomic(page, KM_USER0);
> 
> 			memcpy(dst + offset, src + buf->offset, this_len);
> 			flush_dcache_page(page);
> 			kunmap_atomic(dst, KM_USER0);
> 		}
> 
> I can't understand why do we need PIPE_BUF_FLAG_STOLEN at all.
> It seems to me we need a local boolean in pipe_to_file.

PIPE_BUF_FLAG_STOLEN used to be used in the release function as well,
hence the flag. It could be removed now, yes. I'll make sure to clear
the flag as well on add_to_page_cache() failure.

> I downloaded splice-git-20060430152503.tar.gz, but was unable
> to demonstrate these problems until I found that this definition
> 
> 	static inline int splice(int fdin, loff_t *off_in, int fdout, loff_t *off_out,
> 				 size_t len, unsigned long flags)
> 	{
> 		return syscall(__NR_splice, fdin, off_in, fdout, off_out, len, flags);
> 	}
> 
> is not correct. At least on i386 you need _syscall6() here.

I guess I might as well use the right syscallX, but so far things have
worked fine for me on ia64/x86/x86_64. I'll update it.

-- 
Jens Axboe

