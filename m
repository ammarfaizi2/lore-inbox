Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132260AbQLVWQx>; Fri, 22 Dec 2000 17:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132305AbQLVWQo>; Fri, 22 Dec 2000 17:16:44 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:65037 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132260AbQLVWQg>; Fri, 22 Dec 2000 17:16:36 -0500
Date: Fri, 22 Dec 2000 17:52:28 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <26240000.977497666@coffee>
Message-ID: <Pine.LNX.4.21.0012221730270.3382-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Dec 2000, Chris Mason wrote:

> 
> 
> On Thursday, December 21, 2000 22:38:04 -0200 Marcelo Tosatti
> <marcelo@conectiva.com.br> wrote:
> 
> >> Marcelo Tosatti writes:
> >> > It seems your code has a problem with bh flush time.
> >> > 
> >> > In flush_dirty_buffers(), a buffer may (if being called from kupdate)
> >> > only be written in case its old enough. (bh->b_flushtime)
> >> > 
> >> > If the flush happens for an anonymous buffer, you'll end up writing all
> >> > buffers which are sitting on the same page (with
> >> > block_write_anon_page), but these other buffers are not necessarily
> >> > old enough to be flushed.
> >> 
> 
> A quick benchmark shows there's room for improvement here.  I'll play
> around with a version of block_write_anon_page that tries to be more
> selective when flushing things out.

There is one more nasty issue to deal with. 

You only want to take into account the buffer flushtime if
"check_flushtime" parameter is passed as true to flush_dirty_buffers
(which is done by kupdate).

Thinking a bit more about the issue, I dont see any reason why we want to
write all buffers of an anonymous page at
sync_buffers/flush_dirty_buffers.

I think we could simply write the buffer with ll_rw_block() if the page
which this buffer is sitting on does not have mapping->a_ops->writepage
operation defined.

Chris? 






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
