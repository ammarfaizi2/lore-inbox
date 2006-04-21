Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWDUUqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWDUUqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWDUUqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:46:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932433AbWDUUqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:46:02 -0400
Date: Fri, 21 Apr 2006 13:45:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] sys_vmsplice
In-Reply-To: <20060421080239.GC4717@suse.de>
Message-ID: <Pine.LNX.4.64.0604211341350.3701@g5.osdl.org>
References: <20060421080239.GC4717@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Apr 2006, Jens Axboe wrote:
> 
> Here's the first implementation of sys_vmsplice(). I'm attaching a
> little test app as well for playing with it, it's also committed to the
> splice tools repo at:

Btw, I think we'll have to think a bit more about the buffer size issues:

> @@ -345,6 +346,13 @@ static long do_fcntl(int fd, unsigned in
>  	case F_NOTIFY:
>  		err = fcntl_dirnotify(fd, filp, arg);
>  		break;
> +	case F_SETPSZ:
> +		err = -EINVAL;
> +		break;
> +	case F_GETPSZ:
> +		/* this assumes user space can reliably tell PAGE_CACHE_SIZE */
> +		err = PIPE_BUFFERS;
> +		break;

The above obviously isn't incorrect, but it really isn't enough to handle 
the case I was talking about - for somebody to be able to re-use a 
vmsplice'd page, it's not enough that his buffer is bigger than the pipe 
buffer, it needs to be bigger than the end-to-end buffer. Or rather, 
bigger than the "end-to-copy" buffer.

Ie there may be more buffering after the local pipe buffer - other pipes, 
network buffers, etc etc.

It may even be that my idea to try to limit the buffer size just isn't 
workable, and that we need to do it in a page-per-page basis (ie instead 
of depending on the buffer sizes, actually inspect the page and wait for 
it to be flushed all the way).

So while thinking about that, it might be best to forget about the pipe 
buffer size issue until the final solution is clearer. The pipe buffer may 
well be a _part_ of it, though.

		Linus
