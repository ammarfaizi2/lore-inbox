Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131351AbRBARxO>; Thu, 1 Feb 2001 12:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131350AbRBARxE>; Thu, 1 Feb 2001 12:53:04 -0500
Received: from zeus.kernel.org ([209.10.41.242]:15316 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131349AbRBARwt>;
	Thu, 1 Feb 2001 12:52:49 -0500
Date: Thu, 1 Feb 2001 17:49:46 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@caldera.de>, "Stephen C. Tweedie" <sct@redhat.com>,
        Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201174946.B11607@redhat.com>
In-Reply-To: <20010201180237.A28007@caldera.de> <E14ONdD-0004gz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14ONdD-0004gz-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 01, 2001 at 05:34:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 05:34:49PM +0000, Alan Cox wrote:
> > 
> > I don't see any real advantage for disk IO.  The real advantage is that
> > we can have a generic structure that is also usefull in e.g. networking
> > and can lead to a unified IO buffering scheme (a little like IO-Lite).
> 
> Networking wants something lighter rather than heavier. Adding tons of
> base/limit pairs to kiobufs makes it worse not better

Networking has fundamentally different requirements.  In a network
stack, you want the ability to add fragments to unaligned chunks of
data to represent headers at any point in the stack.

In the disk IO case, you basically don't get that (the only thing
which comes close is raid5 parity blocks).  The data which the user
started with is the data sent out on the wire.  You do get some
interesting cases such as soft raid and LVM, or even in the scsi stack
if you run out of mailbox space, where you need to send only a
sub-chunk of the input buffer.  

In that case, having offset/len as the kiobuf limit markers is ideal:
you can clone a kiobuf header using the same page vector as the
parent, narrow down the start/end points, and continue down the stack
without having to copy any part of the page list.  If you had the
offset/len data encoded implicitly into each entry in the sglist, you
would not be able to do that.

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
