Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131401AbRBAUM6>; Thu, 1 Feb 2001 15:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131334AbRBAUMt>; Thu, 1 Feb 2001 15:12:49 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:59195 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130855AbRBAUMj>;
	Thu, 1 Feb 2001 15:12:39 -0500
Date: Thu, 1 Feb 2001 12:09:08 -0500 (EST)
From: Chaitanya Tumuluri <chait@getafix.engr.sgi.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@caldera.de>,
        Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <20010201174946.B11607@redhat.com>
Message-ID: <Pine.LNX.4.21.0102011202250.11759-100000@getafix.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, Feb 01, 2001 at 05:34:49PM +0000, Alan Cox wrote:
> > > 
> > > I don't see any real advantage for disk IO.  The real advantage is that
> > > we can have a generic structure that is also usefull in e.g. networking
> > > and can lead to a unified IO buffering scheme (a little like IO-Lite).
> > 
> > Networking wants something lighter rather than heavier. Adding tons of
> > base/limit pairs to kiobufs makes it worse not better
> 
> Networking has fundamentally different requirements.  In a network
> stack, you want the ability to add fragments to unaligned chunks of
> data to represent headers at any point in the stack.
> 
> In the disk IO case, you basically don't get that (the only thing
> which comes close is raid5 parity blocks).  The data which the user
> started with is the data sent out on the wire.  You do get some
> interesting cases such as soft raid and LVM, or even in the scsi stack
> if you run out of mailbox space, where you need to send only a
> sub-chunk of the input buffer.  

Or the case of BSD-style UIO implementing the readv() and writev() calls.
This may/may-not align perfectly so, address-length lists per page could
be helpful.

I did try an implementation of this for rawio and found that I had to
restrict the a-len lists coming in via the user iovecs to be aligned.

> In that case, having offset/len as the kiobuf limit markers is ideal:
> you can clone a kiobuf header using the same page vector as the
> parent, narrow down the start/end points, and continue down the stack
> without having to copy any part of the page list.  If you had the
> offset/len data encoded implicitly into each entry in the sglist, you
> would not be able to do that.

This would solve the issue with UIO, yes. Also, I think Martin Peterson
(mkp) had taken a stab at doing "clone-kiobufs" for LVM at some point.

Martin?

Cheers,
-Chait.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
