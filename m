Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbRBGUIN>; Wed, 7 Feb 2001 15:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbRBGUID>; Wed, 7 Feb 2001 15:08:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:30953 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129053AbRBGUHx>;
	Wed, 7 Feb 2001 15:07:53 -0500
Date: Wed, 7 Feb 2001 20:03:31 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207200331.I7254@redhat.com>
In-Reply-To: <20010207014928.O1167@redhat.com> <Pine.LNX.4.10.10102061829230.2448-100000@penguin.transmeta.com> <20010207145215.D7254@redhat.com> <200102071912.f17JCiJ21131@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200102071912.f17JCiJ21131@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Wed, Feb 07, 2001 at 12:12:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 07, 2001 at 12:12:44PM -0700, Richard Gooch wrote:
> Stephen C. Tweedie writes:
> > 
> > Sorry?  I'm not sure where communication is breaking down here, but
> > we really don't seem to be talking about the same things.  SGI's
> > kiobuf request patches already let us pass a large IO through the
> > request layer in a single unit without having to split it up to
> > squeeze it through the API.
> 
> Isn't Linus saying that you can use (say) 4 kiB buffer_heads, so you
> don't need kiobufs? IIRC, kiobufs are page containers, so a 4 kiB
> buffer_head is effectively the same thing.

kiobufs let you encode _any_ contiguous region of user VA or of an
inode's page cache contents in one kiobuf, no matter how many pages
there are in it.  A write of a megabyte to a raw device can be encoded
as a single kiobuf if we want to pass the entire 1MB IO down to the
block layers untouched.  That's what the page vector in the kiobuf is
for.

Doing the same thing with buffer_heads would still require a couple of
hundred of them, and you'd have to submit each such buffer_head to the
IO subsystem independently.  And then the IO layer will just have to
reassemble them on the other side (and it may have to scan the
device's entire request queue once for every single buffer_head to do
so).

> But an API extension to allow passing a pre-built chain would be even
> better.

Yep.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
