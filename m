Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbRETD0w>; Sat, 19 May 2001 23:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261402AbRETD0n>; Sat, 19 May 2001 23:26:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13063 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261399AbRETD0g>; Sat, 19 May 2001 23:26:36 -0400
Date: Sat, 19 May 2001 20:26:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <200105200248.f4K2mws02918@mobilix.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0105192017480.28666-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 May 2001, Richard Gooch wrote:
>
> Matthew Wilcox writes:
> > On Sat, May 19, 2001 at 10:22:55PM -0400, Richard Gooch wrote:
> > > The transaction(2) syscall can be just as easily abused as ioctl(2) in
> > > this respect.
> > 
> > But read() and write() cannot.
> 
> Sure they can. I can pass a pointer to a structure to either of them.

You're missing the point.

It's ok to do "read()/write()" on structures. In fact, people do that all
the time (and then they complain about the file not being portable ;)

The problem with ioctl is that not only are people passing ioctl's
pointers to structures, but:
 - they're not telling how big the structure is
 - the structure can have pointers to other places
 - sometimes it modifies the structure passed in

None of which are "network-nice". Basically, ioctl() is historically used
as a "pass any crap into driver xxxx, and the driver - and ONLY the driver
- will know what to do with it".

And when _only_ a driver knows what the arguments mean, upper layers can't
encapsulate them. Upper layers cannot make a packet of the argument and
send it over the network to another machine. Upper layers cannot do
sanity-checking on things like "is this argument a valid pointer". Which
means, for example, that not only can you not send the ioctl arguments
anywhere, but ioctl's have also historically been a hot-bed of bugs.

Example traditional ioctl bugs: use kernel pointers to access the argument
(because it just happens to work on x86, never mind the fact that if the
argument is bad you'll get a kernel oops and/or a serious security error).
Other example: different drivers/f ilesystems implementing the same ioctl,
but disagreeing on what the argument means (is it a pointer to an integer
argument, or the integer itself?).

Now, the advantage of using read()/write() is (a) that it's unambiguous
where the argument comes from and how big it is and (b) because of that
the _psychology_ is different. You don't get into this "pass random crap
around, let the kernel modify user data structures directly" mentality.

And psychology is important.

		Linus

