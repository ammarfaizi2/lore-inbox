Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbQLOL0N>; Fri, 15 Dec 2000 06:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLOL0D>; Fri, 15 Dec 2000 06:26:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:18698 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130159AbQLOLZx>;
	Fri, 15 Dec 2000 06:25:53 -0500
Date: Fri, 15 Dec 2000 10:51:48 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
Message-ID: <20001215105148.E11931@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10012142208420.1308-100000@penguin.transmeta.com> <Pine.GSO.4.21.0012150150570.11106-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0012150150570.11106-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Dec 15, 2000 at 02:00:19AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 15, 2000 at 02:00:19AM -0500, Alexander Viro wrote:
> On Thu, 14 Dec 2000, Linus Torvalds wrote:
> 
> Just one: any fs that really cares about completion callback is very likely
> to be picky about the requests ordering. So sync_buffers() is very unlikely
> to be useful anyway.
> 
> In that sense we really don't have anonymous buffers here. I seriously
> suspect that "unrealistic" assumption is not unrealistic at all. I'm
> not sufficiently familiar with XFS code to say for sure, but...

Right.  ext3 and reiserfs just want to submit their own IOs when it
comes to the journal.  (At least in ext3, already-journaled buffers
can be written back by the VM freely.)  It's a matter of telling the
fs when that should start.

> What we really need is a way for VFS/VM to pass the pressure on filesystem.
> That's it. If fs wants unusual completions for requests - let it have its
> own queueing mechanism and submit these requests when it finds that convenient.

There is a very clean way of doing this with address spaces.  It's
something I would like to see done properly for 2.5: eliminate all
knowledge of buffer_heads from the VM layer.  It would be pretty
simple to remove page->buffers completely and replace it with a
page->private pointer, owned by whatever address_space controlled the
page.  Instead of trying to unmap and flush buffers on the page
directly, these operations would become address_space operations.

We could still provide the standard try_to_free_buffers() and
unmap_underlying_metadata() functions to operate on the per-page
buffer_head lists, and existing filesystems would only have to point
their address_space "private metadata" operations at the generic
functions.  However, a filesystem which had additional ordering
constraints could then intercept the flush or writeback calls from the
VM and decide on its own how best to honour the VM pressure.

This even works both for hashed and unhashed anonymous buffers, *if*
you allow the filesystem to attach all of its hashed buffers buffers
to an address_space of its own rather than having the buffer cache
pool all such buffers together.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
