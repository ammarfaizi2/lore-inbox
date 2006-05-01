Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWEAC76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWEAC76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 22:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWEAC76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 22:59:58 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:54208 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750753AbWEAC76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 22:59:58 -0400
Date: Mon, 1 May 2006 10:59:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: splice(SPLICE_F_MOVE) problems
Message-ID: <20060501065953.GA289@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed sys_splice() and friends were added. Cool!
But I can't understand how SPLICE_F_MOVE is supposed to
work.

	pipe_to_file:

		if (sd->flags & SPLICE_F_MOVE) {

			if (buf->ops->steal(info, buf))
				goto find_page;

Let's suppose that buf->ops == page_cache_pipe_buf_ops.
page_cache_pipe_buf_steal() returns PG_locked page, why?


			page = buf->page;
			if (add_to_page_cache(page, mapping, index, gfp_mask))

This adds entire page to page cache. What about partial pages?
This can corrupt sd->file if offset != 0 || this_len != PAGE_SIZE.

				goto find_page;

Ok, add_to_page_cache() failed. 'page' is still locked.
It will be released later, this should trigger bad_page().

Also, we don't clear PIPE_BUF_FLAG_STOLEN, so we will miss
the data copying and page_cache_release(page) below:

		if (!(buf->flags & PIPE_BUF_FLAG_STOLEN)) {
			char *dst = kmap_atomic(page, KM_USER0);

			memcpy(dst + offset, src + buf->offset, this_len);
			flush_dcache_page(page);
			kunmap_atomic(dst, KM_USER0);
		}

I can't understand why do we need PIPE_BUF_FLAG_STOLEN at all.
It seems to me we need a local boolean in pipe_to_file.


I downloaded splice-git-20060430152503.tar.gz, but was unable
to demonstrate these problems until I found that this definition

	static inline int splice(int fdin, loff_t *off_in, int fdout, loff_t *off_out,
				 size_t len, unsigned long flags)
	{
		return syscall(__NR_splice, fdin, off_in, fdout, off_out, len, flags);
	}

is not correct. At least on i386 you need _syscall6() here.

Oleg.

