Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269281AbRHGSak>; Tue, 7 Aug 2001 14:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269274AbRHGSab>; Tue, 7 Aug 2001 14:30:31 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:55569 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269280AbRHGSaZ>; Tue, 7 Aug 2001 14:30:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ed Tomlinson <tomlins@cam.org>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [RFC] using writepage to start io
Date: Tue, 7 Aug 2001 20:36:20 +0200
X-Mailer: KMail [version 1.2]
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <755760000.997128720@tiny> <20010807120234.D4036@redhat.com> <20010807113944.D229E7B53@oscar.casa.dyndns.org>
In-Reply-To: <20010807113944.D229E7B53@oscar.casa.dyndns.org>
MIME-Version: 1.0
Message-Id: <0108072036200D.02365@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 13:39, Ed Tomlinson wrote:
> On August 7, 2001 07:02 am, Stephen C. Tweedie wrote:
> > On Mon, Aug 06, 2001 at 11:18:26PM +0200, Daniel Phillips wrote:
> > > > On Monday, August 06, 2001 09:45:12 PM +0200 Daniel Phillips
> > > >
> > > > Grin, we're talking in circles.  My point is that by having two
> > > > threads, bdflush is allowed to skip over older buffers in favor
> > > > of younger ones because somebody else is responsible for writing
> > > > the older ones out.
> > >
> > > Yes, and you can't imagine an algorithm that could do that with
> > > *one* thread?
> >
> > FWIW, we've seen big performance degradations in the past when
> > testing different ext3 checkpointing modes.  You can't reuse a disk
> > block in the journal without making sure that the data in it has
> > been flushed to disk, so ext3 does regular checkpointing to flush
> > journaled blocks out.  That can interact very badly with normal VM
> > writeback if you're not careful: having two threads doing the same
> > thing at the same time can just thrash the disk.
> >
> > Parallel sync() calls from multiple processes has shown up the same
> > behaviour on ext2 in the past.  I'd definitely like to see at most
> > one thread of writeback per disk to avoid that.
>
> Be carefull here.  I have a system (solaris) at the office that has 96
> drives on it.  Do we really want 96 writeback threads?  With 96
> drives, suspect the bus bandwidth would be the limiting factor.

Surely these are grouped into some kind of raid?  You'd have one queue
per raid.  Since the buffer submission is nonblocking[1] it's a matter
of taste whether that translates into multiple threads or not.

[1] So long as you don't run into the low level request limits which
should never happen if you pay attention to how much IO is in flight.

--
Daniel
