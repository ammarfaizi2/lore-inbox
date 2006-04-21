Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWDUVBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWDUVBB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWDUVBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:01:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43306 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932475AbWDUVBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:01:00 -0400
Date: Fri, 21 Apr 2006 23:01:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] sys_vmsplice
Message-ID: <20060421210131.GF7772@suse.de>
References: <20060421080239.GC4717@suse.de> <Pine.LNX.4.64.0604211341350.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604211341350.3701@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21 2006, Linus Torvalds wrote:
> 
> 
> On Fri, 21 Apr 2006, Jens Axboe wrote:
> > 
> > Here's the first implementation of sys_vmsplice(). I'm attaching a
> > little test app as well for playing with it, it's also committed to the
> > splice tools repo at:
> 
> Btw, I think we'll have to think a bit more about the buffer size issues:
> 
> > @@ -345,6 +346,13 @@ static long do_fcntl(int fd, unsigned in
> >  	case F_NOTIFY:
> >  		err = fcntl_dirnotify(fd, filp, arg);
> >  		break;
> > +	case F_SETPSZ:
> > +		err = -EINVAL;
> > +		break;
> > +	case F_GETPSZ:
> > +		/* this assumes user space can reliably tell PAGE_CACHE_SIZE */
> > +		err = PIPE_BUFFERS;
> > +		break;
> 
> The above obviously isn't incorrect, but it really isn't enough to handle 
> the case I was talking about - for somebody to be able to re-use a 
> vmsplice'd page, it's not enough that his buffer is bigger than the pipe 
> buffer, it needs to be bigger than the end-to-end buffer. Or rather, 
> bigger than the "end-to-copy" buffer.
> 
> Ie there may be more buffering after the local pipe buffer - other pipes, 
> network buffers, etc etc.
> 
> It may even be that my idea to try to limit the buffer size just isn't 
> workable, and that we need to do it in a page-per-page basis (ie instead 
> of depending on the buffer sizes, actually inspect the page and wait for 
> it to be flushed all the way).
> 
> So while thinking about that, it might be best to forget about the pipe 
> buffer size issue until the final solution is clearer. The pipe buffer may 
> well be a _part_ of it, though.

Obviously the posted patch doesn't handle the reuse case yet. If you
play with the splice tools and do:

# vmsplice | ktee-net bla port | cat > file

with the vmsplice modified to memset the first half of the buffer after
the second half has been vmspliced, you'll see bad data going out over
the network.

One way that works fine but is hackish is just to monitor the page
count. So don't rely solely on reusing the page once ->release has been
called, but also check buf->page on reuse if the ->release function
hasn't cleared ->page (the page cache ops would, the user_page would
not) so move_to_pipe() can break out appropriately just like if
pipe->nr_buffers was too large. Works, is easily doable, but isn't a
very nice design - it basically works around the problem that
->release() is called too early.

The better way is imho to forget ->sendpage() and do a proper hook that
actually accepts the pipe buffer. Then you don't have to work around
premature release. And hey, it'd be more efficient too. With tee and
friends, you'd want to keep them referenced as well.

This all provided that the method of choice for signalling safe reuse is
still either blocking on vmsplice or using poll() intelligently to do
that.

-- 
Jens Axboe

