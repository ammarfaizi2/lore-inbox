Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRBEMWD>; Mon, 5 Feb 2001 07:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131941AbRBEMVx>; Mon, 5 Feb 2001 07:21:53 -0500
Received: from zeus.kernel.org ([209.10.41.242]:32727 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129116AbRBEMVm>;
	Mon, 5 Feb 2001 07:21:42 -0500
Date: Mon, 5 Feb 2001 12:19:21 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205121921.C1167@redhat.com>
In-Reply-To: <20010201174946.B11607@redhat.com> <200102012033.VAA15590@ns.caldera.de> <20010201220744.K11607@redhat.com> <20010202130228.B12245@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010202130228.B12245@caldera.de>; from hch@caldera.de on Fri, Feb 02, 2001 at 01:02:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 02, 2001 at 01:02:28PM +0100, Christoph Hellwig wrote:
> 
> > I may still be persuaded that we need the full scatter-gather list
> > fields throughout, but for now I tend to think that, at least in the
> > disk layers, we may get cleaner results by allow linked lists of
> > page-aligned kiobufs instead.  That allows for merging of kiobufs
> > without having to copy all of the vector information each time.
> 
> But it will have the same problems as the array soloution: there will
> be one complete kio structure for each kiobuf, with it's own end_io
> callback, etc.

And what's the problem with that?

You *need* this.  You have to have that multiple-completion concept in
the disk layers.  Think about chains of buffer_heads being sent to
disk as a single IO --- you need to know which buffers make it to disk
successfully and which had IO errors.

And no, the IO success is *not* necessarily sequential from the start
of the IO: if you are doing IO to raid0, for example, and the IO gets
striped across two disks, you might find that the first disk gets an
error so the start of the IO fails but the rest completes.  It's the
completion code which notifies the caller of what worked and what did
not.

And for readahead, you want to notify the caller as early as posssible
about completion for the first part of the IO, even if the device
driver is still processing the rest.

Multiple completions are a necessary feature of the current block
device interface.  Removing that would be a step backwards.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
