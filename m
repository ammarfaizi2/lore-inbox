Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129471AbRBFVmp>; Tue, 6 Feb 2001 16:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbRBFVmf>; Tue, 6 Feb 2001 16:42:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8972 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129286AbRBFVmY>; Tue, 6 Feb 2001 16:42:24 -0500
Date: Tue, 6 Feb 2001 13:42:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jens Axboe <axboe@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <3A806BFA.A178BC7A@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10102061336520.1753-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Manfred Spraul wrote:
> Jens Axboe wrote:
> > 
> > > Several kernel functions need a "dontblock" parameter (or a callback, or
> > > a waitqueue address, or a tq_struct pointer).
> > 
> > We don't even need that, non-blocking is implicitly applied with READA.
> >
> READA just returns - I doubt that the aio functions should poll until
> there are free entries in the request queue.

The aio functions should NOT use READA/WRITEA. They should just use the
normal operations, waiting for requests. The things that makes them
asycnhronous is not waiting for the requests to _complete_. Which you can
already do, trivially enough.

The case for using READA/WRITEA is not that you want to do asynchronous
IO (all Linux IO is asynchronous unless you do extra work), but because
you have a case where you _might_ want to start IO, but if you don't have
a free request slot (ie there's already tons of pending IO happening), you
want the option of doing something else. This is not about aio - with aio
you _need_ to start the IO, you're just not willing to wait for it. 

An example of READA/WRITEA is if you want to do opportunistic dirty page
cleaning - you might not _have_ to clean it up, but you say

 "Hmm.. if you can do this simply without having to wait for other
  requests, start doing the writeout in the background. If notm I'll come
  back to you later after I've done more real work.."

And the Linux block device layer supports both of these kinds of "delayed
IO" already. It's all there. Today.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
