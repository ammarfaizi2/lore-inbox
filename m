Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130437AbRBIL2Z>; Fri, 9 Feb 2001 06:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130482AbRBIL2P>; Fri, 9 Feb 2001 06:28:15 -0500
Received: from [195.63.194.11] ([195.63.194.11]:3847 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S130437AbRBIL2F>;
	Fri, 9 Feb 2001 06:28:05 -0500
Message-ID: <3A83DFBF.594250AE@evision-ventures.com>
Date: Fri, 09 Feb 2001 13:17:03 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rik van Riel <riel@conectiva.com.br>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Jens Axboe <axboe@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102081030070.6741-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 8 Feb 2001, Rik van Riel wrote:
> 
> > On Thu, 8 Feb 2001, Mikulas Patocka wrote:
> >
> > > > > You need aio_open.
> > > > Could you explain this?
> > >
> > > If the server is sending many small files, disk spends huge
> > > amount time walking directory tree and seeking to inodes. Maybe
> > > opening the file is even slower than reading it
> >
> > Not if you have a big enough inode_cache and dentry_cache.
> >
> > OTOH ... if you have enough memory the whole async IO argument
> > is moot anyway because all your files will be in memory too.
> 
> Note that this _is_ an important point.
> 
> You should never _ever_ think about pure IO speed as the most important
> thing. Even if you get absolutely perfect IO streaming off the fastest
> disk you can find, I will beat you every single time with a cached setup
> that doesn't need to do IO at all.
> 
> 90% of the VFS layer is all about caching, and trying to avoid IO. Of the
> rest, about 9% is about trying to avoid even calling down to the low-level
> filesystem, because it's faster if we can handle it at a high level
> without any need to even worry about issues like physical disk addresses.
> Even if those addresses are cached.
> 
> The remaining 1% is about actually getting the IO done. At that point we
> end up throwing our hands in the air and saying "ok, this will be slow".
> 
> So if you design your system for disk load, you are missing a big portion
> of the picture.
> 
> There are cases where IO really matter. The most notable one being
> databases, certainly _not_ web or ftp servers. For web- or ftp-servers you
> buy more memory if you want high performance, and you tend to be limited
> by the network speed anyway (if you have multiple gigabit networks and
> network speed isn't an issue, then I can also tell you that buying a few
> gigabyte of RAM isn't an issue, because you are obviously working for
> something like the DoD and have very little regard for the cost of the
> thing ;)
> 
> For databases (and for file servers that you want to be robust over a
> crash), IO throughput is an issue mainly because you need to put the damn
> requests in stable memory somewhere. Which tends to mean that _write_
> speed is what really matters, because the reads you can still try to cache
> as efficiently as humanly possible (and the issue of database design then
> turns into trying to find every single piece of locality you can, so that
> the read caching works as well as possible).
> 
> Short and sweet: "aio_open()" is basically never supposed to be an issue.
> If it is, you've misdesigned something, or you're trying too damn hard to
> single-thread everything (and "hiding" the threading that _does_ happen by
> just calling it "AIO" instead - lying to yourself, in short).

Right - I agree with you that an AIO design is basically hiding an
inherently
multi threaded program flow. This argument is indeed very catchy. And
looking
from some other point one will see that most of the AIO designs are from
times
where multi threading in applications wasn't that common as it is now.
Most prominently coprocesses in a shell come to my mind as a very good
example
about how to handle AIO (sort of)...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
