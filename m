Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317971AbSGLBf7>; Thu, 11 Jul 2002 21:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317972AbSGLBf6>; Thu, 11 Jul 2002 21:35:58 -0400
Received: from [195.223.140.120] ([195.223.140.120]:28274 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317971AbSGLBf4>; Thu, 11 Jul 2002 21:35:56 -0400
Date: Fri, 12 Jul 2002 00:57:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       "Carter K. George" <carter@polyserve.com>,
       Don Norton <djn@polyserve.com>, "James S. Tybur" <jtybur@polyserve.com>
Subject: Re: fsync fixes for 2.4
Message-ID: <20020711225748.GN1342@dualathlon.random>
References: <20020710202036.GA1342@dualathlon.random> <Pine.LNX.4.44.0207111710470.21365-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207111710470.21365-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 05:21:24PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Wed, 10 Jul 2002, Andrea Arcangeli wrote:
> 
> > At polyserve they found a severe problem with fsync in 2.4.
> >
> > In short the write_buffer (ll_rw_block of mainline) is a noop if old I/O
> > is in flight. You know the buffer can be made dirty while I/O is in
> > flight, and in such case fsync would return without flushing the dirty
> > buffers at all. Their proposed fix is strightforward, just a
> > wait_on_buffer before the ll_rw_block will guarantee somebody marked the
> > bh locked _after_ we wrote to it.
> 
> >From what I can see the problem goes like:
> 
> 
> thread1				thread2
> 				writepage(page) (marks the buffers clean, page is
> 				locked for IO)
> 
> mark_buffer_dirty()
> 
> fsync()
> 
> fsync_buffers_list() finds
> the dirtied buffer, but since
> its locked ll_rw_block() returns
> without queueing the data.
> 
> fsync_buffers_list() waits on the writepage()'s
> write to return but not on latest data write.
> 
> 
> Is that what you mean or I'm misunderstanding something?

yes, that's it.

Andrea
