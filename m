Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSIEQ6Z>; Thu, 5 Sep 2002 12:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSIEQ6Y>; Thu, 5 Sep 2002 12:58:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50186 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317931AbSIEQ6X>; Thu, 5 Sep 2002 12:58:23 -0400
Date: Thu, 5 Sep 2002 10:05:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <3D7785B4.A35C9BC8@zip.com.au>
Message-ID: <Pine.LNX.4.33.0209051003210.1383-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Andrew Morton wrote:
> Linus Torvalds wrote:
> > 
> > ...
> > I would suggest:
> > 
> >  - add a "nr of sectors completed" argument to the "bi_end_io()" function,
> >    so that it looks like
> > 
> >         void xxx_bio_end_io(struct bio *bio, unsigned long completed)
> >         {
> >                 /*
> >                  * Old completion handlers that don't understand it
> >                  * should just return immediately for partial bio
> >                  * completion notifiers
> >                  */
> >                 if (bio->b_size)
> >                         return;
> >                 ...
> >         }
> > 
> >    which would allow things like mpage_end_io_read() to unlock pages as
> >    they complete, instead of unlocking them all in one go.
> 
> It's a feature!  We don't want to have to soak up 20,000 context
> switches a second just reading a file from an 80MB/sec disk.

You didn't think it through.

The current behaviour is a BUG.

A fast disk driver will _never ever_ do a partial request completion. A 
high-performance subsystem will put in the scatter-gather list and say 
"go" to the controller, and the controller will send exactly one interrupt 
back when it is all done.

So for such a system, you'd never see partial completions anyway.

Partial completions are a feature of slow hardware. And slow hardware is 
exactly when we want to know about it.

So my approach has no downsides, only upsides.

		Linus

