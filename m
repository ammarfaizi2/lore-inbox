Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129048AbRBAVrY>; Thu, 1 Feb 2001 16:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRBAVrO>; Thu, 1 Feb 2001 16:47:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:30401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129048AbRBAVrF>;
	Thu, 1 Feb 2001 16:47:05 -0500
Date: Thu, 1 Feb 2001 21:44:47 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@caldera.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201214447.J11607@redhat.com>
In-Reply-To: <20010201174946.B11607@redhat.com> <200102012033.VAA15590@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200102012033.VAA15590@ns.caldera.de>; from hch@caldera.de on Thu, Feb 01, 2001 at 09:33:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 09:33:27PM +0100, Christoph Hellwig wrote:
> 
> > On Thu, Feb 01, 2001 at 05:34:49PM +0000, Alan Cox wrote:
> > In the disk IO case, you basically don't get that (the only thing
> > which comes close is raid5 parity blocks).  The data which the user
> > started with is the data sent out on the wire.  You do get some
> > interesting cases such as soft raid and LVM, or even in the scsi stack
> > if you run out of mailbox space, where you need to send only a
> > sub-chunk of the input buffer. 
> 
> Though your describption is right, I don't think the case is very common:
> Sometimes in LVM on a pv boundary and maybe sometimes in the scsi code.

On raid0 stripes, it's common to have stripes of between 16k and 64k,
so it's rather more common there than you'd like.  In any case, you
need the code to handle it, and I don't want to make the code paths
any more complex than necessary.

> In raid1 you need some kind of clone iobuf, which should work with both
> cases.  In raid0 you need a complete new pagelist anyway

No you don't.  You take the existing one, specify which region of it
is going to the current stripe, and send it off.  Nothing more.

> > In that case, having offset/len as the kiobuf limit markers is ideal:
> > you can clone a kiobuf header using the same page vector as the
> > parent, narrow down the start/end points, and continue down the stack
> > without having to copy any part of the page list.  If you had the
> > offset/len data encoded implicitly into each entry in the sglist, you
> > would not be able to do that.
> 
> Sure you could: you embedd that information in a higher-level structure.

What's the point in a common data container structure if you need
higher-level information to make any sense out of it?

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
