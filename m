Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbRGTQmh>; Fri, 20 Jul 2001 12:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbRGTQm1>; Fri, 20 Jul 2001 12:42:27 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:8969 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267088AbRGTQmU>; Fri, 20 Jul 2001 12:42:20 -0400
Date: Fri, 20 Jul 2001 09:42:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, <linux-scsi@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
In-Reply-To: <20010720102614.A13354@suse.de>
Message-ID: <Pine.LNX.4.31.0107200937310.1547-100000@p4.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Fri, 20 Jul 2001, Jens Axboe wrote:
>
> > The paging stuff doesn't use any of this. The paging stuff use the page
> > cache lock bit, and always has.
>
> Paging still hits a request, I assumed that's what the (really really)
> old comment meant to say.

No. Tha paging stuff (and _all_ regular IO) uses a regular request, with a
NULL waiter. That's the normal path. That normal path depends on the
buffer heads associated with the requests and their "bh->b_end_io()"
function marking other state up-to-date, and then waits on the page being
locked.

The req->sem (and now req->completion) thing is a very different thing: it
is a "we are waiting for this particular request", and is used when it's
not really IO and doesn't have a bh, but something that has side effects.
Like an ioctl that causes a special command to the disk to change some
parameters, or query the size of the disk or something.

So the comment has just always been wrong, I think. It may be that the
original swapping code was doing raw requests instead of real IO, so maybe
the comment was actually correct back in 1992 or something. My memory
isn't good enough..

		Linus

