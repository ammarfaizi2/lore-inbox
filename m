Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129794AbRBELH3>; Mon, 5 Feb 2001 06:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130050AbRBELHU>; Mon, 5 Feb 2001 06:07:20 -0500
Received: from zeus.kernel.org ([209.10.41.242]:39115 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129794AbRBELHF>;
	Mon, 5 Feb 2001 06:07:05 -0500
Date: Mon, 5 Feb 2001 11:03:36 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205110336.A1167@redhat.com>
In-Reply-To: <20010201220744.K11607@redhat.com> <Pine.LNX.4.10.10102031224210.8867-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10102031224210.8867-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Feb 03, 2001 at 12:28:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Feb 03, 2001 at 12:28:47PM -0800, Linus Torvalds wrote:
> 
> On Thu, 1 Feb 2001, Stephen C. Tweedie wrote:
> > 
> Neither the read nor the write are page-aligned. I don't know where you
> got that idea. It's obviously not true even in the common case: it depends
> _entirely_ on what the file offsets are, and expecting the offset to be
> zero is just being stupid. It's often _not_ zero. With networking it is in
> fact seldom zero, because the network packets are seldom aligned either in
> size or in location.

The underlying buffer is.  The VFS (and the current kiobuf code) is
already happy about IO happening at odd offsets within a page.
However, the more general case --- doing zero-copy IO on arbitrary
unaligned buffers --- simply won't work if you expect to be able to
push those buffers to disk without a copy.  

The splice case you talked about is fine because it's doing the normal
prepare/commit logic where the underlying buffer is page aligned, even
if the splice IO is not to a page aligned location.  That's _exactly_
what kiobufs were intended to support.  The prepare_read/prepare_write/
pull/push cycle lets the caller tell the pull() function where to
store its data, becausse there are alignment constraints which just
can't be ignored: you simply cannot do physical disk IO on
non-sector-aligned memory or in chunks which aren't a multiple of
sector size.  (The buffer address alignment can sometimes be relaxed
--- obviously if you're doing PIO then it doesn't matter --- but the
length granularity is rigidly enforced.)
 
Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
