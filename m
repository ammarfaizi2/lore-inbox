Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135844AbRAJPY2>; Wed, 10 Jan 2001 10:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135859AbRAJPYS>; Wed, 10 Jan 2001 10:24:18 -0500
Received: from zeus.kernel.org ([209.10.41.242]:38346 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135844AbRAJPYG>;
	Wed, 10 Jan 2001 10:24:06 -0500
Date: Wed, 10 Jan 2001 15:21:58 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010110152158.F10633@redhat.com>
In-Reply-To: <20010109141806.F4284@redhat.com> <Pine.LNX.4.30.0101091532150.4368-100000@e2> <20010109151725.D9321@redhat.com> <93g357$2jf$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <93g357$2jf$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 09, 2001 at 02:25:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 02:25:43PM -0800, Linus Torvalds wrote:
> In article <20010109151725.D9321@redhat.com>,
> Stephen C. Tweedie <sct@redhat.com> wrote:
> >
> >Jes has also got hard numbers for the performance advantages of
> >jumbograms on some of the networks he's been using, and you ain't
> >going to get udp jumbograms through a page-by-page API, ever.
> 
> The only thing you need is a nagle-type thing that coalesces requests.

Is this robust enough to build a useful user-level API on top of?

What happens if we have a threaded application in which more than one
process may be sending udp sendmsg()s to the file descriptor?  If we
end up decomposing each datagram into multiple page-sized chunks, then
you can imagine them arriving at the fd stream in interleaved order.

You can fix that by adding extra locking, but that just indicates that
the original API wasn't sufficient to communicate the precise intent
of the application in the first place.

Things look worse from the point of view of ll_rw_block, which lacks
any concept of (a) a file descriptor, or (b) a non-reorderable stream
of atomic requests.  ll_rw_block coalesces in any order it chooses, so
its coalescing function is a _lot_ more complex than hooking the next
page onto a linked list.  

Once the queue size grows non-trivial, adding a new request can become
quite expensive (even with only one item on the request queue at once,
make_request is still by far the biggest cost on a kernel profile
running raw IO).  If you've got a 32-page IO to send, sending it in
chunks means either merging 32 times into that queue when you could
have just done it once, or holding off all merging until you're told
to unplug: but with multiple clients, you just encounter the lack of
caller context again, and each client can unplug the other before its
time.

I realise these are apples and oranges to some extent, because
ll_rw_block doesn't accept a file descriptor: the place where we _do_
use file descriptors, block_write(), could be doing some of this if
the requests were coming from an application.

However, that doesn't address the fact that we have got raw devices
and filesystems such as XFS already generating large multi-page block
IO requests and having to cram them down the thin pipe which is
ll_rw_block, and the MSG_MORE flag doesn't seem capable of extending
to ll_rw_block sufficiently well.

I guess it comes down to this: what problem are we trying to fix?  If
it's strictly limited to sendfile/writev and related calls, then
you've convinced me that page-by-page MSG_MORE can work if you add a
bit of locking, but that locking is by itself nasty.  

Think about O_DIRECT to a database file.  We get a write() call,
locate the physical pages through unspecified magic, and fire off a
series of page or partial-page writes to the O_DIRECT fd.  If we are
coalescing these via MSG_MORE, then we have to keep the fd locked for
write until we've processed the whole IO (including any page faults
that result).  The filesystem --- which is what understands the
concept of a file descriptor --- can merge these together into another
request, but we'd just have to split that request into chunks again to
send them to ll_rw_block.

We may also have things like software raid layers in the write path.
That's the motivation for having an object capable of describing
multi-page IOs --- it lets us pass the desired IO chunks down through
the filesystem, virtual block devices and physical block devices,
without any context being required and without having to
decompose/merge at each layer.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
