Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317975AbSGLBm5>; Thu, 11 Jul 2002 21:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317977AbSGLBm4>; Thu, 11 Jul 2002 21:42:56 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:65295 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317975AbSGLBmy>; Thu, 11 Jul 2002 21:42:54 -0400
Date: Thu, 11 Jul 2002 21:51:29 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       "Carter K. George" <carter@polyserve.com>,
       Don Norton <djn@polyserve.com>, "James S. Tybur" <jtybur@polyserve.com>
Subject: Re: fsync fixes for 2.4
In-Reply-To: <20020711225748.GN1342@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0207112149260.21511-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jul 2002, Andrea Arcangeli wrote:

> On Thu, Jul 11, 2002 at 05:21:24PM -0300, Marcelo Tosatti wrote:
> >
> >
> > On Wed, 10 Jul 2002, Andrea Arcangeli wrote:
> >
> > > At polyserve they found a severe problem with fsync in 2.4.
> > >
> > > In short the write_buffer (ll_rw_block of mainline) is a noop if old I/O
> > > is in flight. You know the buffer can be made dirty while I/O is in
> > > flight, and in such case fsync would return without flushing the dirty
> > > buffers at all. Their proposed fix is strightforward, just a
> > > wait_on_buffer before the ll_rw_block will guarantee somebody marked the
> > > bh locked _after_ we wrote to it.
> >
> > >From what I can see the problem goes like:
> >
> >
> > thread1				thread2
> > 				writepage(page) (marks the buffers clean, page is
> > 				locked for IO)
> >
> > mark_buffer_dirty()
> >
> > fsync()
> >
> > fsync_buffers_list() finds
> > the dirtied buffer, but since
> > its locked ll_rw_block() returns
> > without queueing the data.
> >
> > fsync_buffers_list() waits on the writepage()'s
> > write to return but not on latest data write.
> >
> >
> > Is that what you mean or I'm misunderstanding something?
>
> yes, that's it.

So I'm just going to add wait_on_page() on fsync_buffers_list() before the
ll_rw_block().

Nothing else, since all of the other stuff on your patch seems to be
improvements rather than bug fixes. ACK?



