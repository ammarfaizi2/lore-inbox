Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWECKfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWECKfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 06:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWECKfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 06:35:20 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:58578 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965144AbWECKfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 06:35:19 -0400
Date: Wed, 3 May 2006 18:35:15 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice(SPLICE_F_MOVE) problems
Message-ID: <20060503143515.GA94@oleg>
References: <20060501065953.GA289@oleg> <20060501065412.GP23137@suse.de> <20060501190625.GA174@oleg> <20060501174153.GH3814@suse.de> <20060502001118.GA88@oleg> <20060502052850.GP3814@suse.de> <20060503041455.GA158@oleg> <20060503065644.GJ9712@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060503065644.GJ9712@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03, Jens Axboe wrote:
>
> On Wed, May 03 2006, Oleg Nesterov wrote:
> 
> > However, user_page_pipe_buf_steal() returns unlocked page in
> > PIPE_BUF_FLAG_GIFT case. So, if add_to_page_cache() fails,
> > unlock_page() will trigger BUG().
> 
> It does, it calls generic_pipe_buf_steal() which locks it.

What I have in splice.c:

	static int user_page_pipe_buf_steal(struct pipe_inode_info *pipe,
					    struct pipe_buffer *buf)
	{
		if (!(buf->flags & PIPE_BUF_FLAG_GIFT))
			return 1;

		return 0;
	}

(I don't use git, reading Linus's tree via http).

> > 		ret = mapping->a_ops->prepare_write(file, page, offset, offset+this_len);
> > 		if (ret == AOP_TRUNCATED_PAGE) {
> > 			page_cache_release(page);
> > 			goto find_page;
> > 
> > We also need to unlock(page) if it was stealed.
> 
> Are you sure that's the right test? Don't you mean if ret !=
> AOP_TRUNCATED_PAGE && ret?
> 
> How about the attached?

Ah, yes, you are right. Sorry for confusion.

Oleg.

