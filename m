Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbRGXN5F>; Tue, 24 Jul 2001 09:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbRGXN4y>; Tue, 24 Jul 2001 09:56:54 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:14865 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267536AbRGXN4q>; Tue, 24 Jul 2001 09:56:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        phillips@bonn-fries.net (Daniel Phillips)
Subject: Re: [PATCH] 64 bit scsi read/write
Date: Tue, 24 Jul 2001 13:45:53 +0200
X-Mailer: KMail [version 1.2]
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), tuxx@aon.at (Alexander Griesser),
        phillips@bonn-fries.net (Daniel Phillips), cw@f00f.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <200107240429.f6O4Tdt274181@saturn.cs.uml.edu>
In-Reply-To: <200107240429.f6O4Tdt274181@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <01072413455306.00301@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 06:29, Albert D. Cahalan wrote:
> Daniel Phillips writes:
> > On Sunday 22 July 2001 05:52, Albert D. Cahalan wrote:
> >> [...]
> >>> On Sun, Jul 15, 2001 at 09:08:41PM -0400, you wrote:
> >>>> In a tree-structured filesystem, checksums on everything would
> >>>> only cost you space similar to the number of pointers you have.
> >>>> Whenever a non-leaf node points to a child, it can hold a
> >>>> checksum for that child as well.  This gives a very reliable way
> >>>> to spot filesystem errors, including corrupt data blocks.
> ...
> >> To have a child is to have a checksum+pointer pair.
> ...
> > I agree that your suggestion will work and that doubling the size
> > of the metadata isn't an enormous cost, especially if you'd already
> > compressed it using extents.  On the other hand, sometimes I just
> > feel like trusting the hardware a little.  Both atomic-commit and
> > journalling strategies take care of normal failure modes, and the
> > disk hardware is supposed to flag other failures by ecc'ing each
> > sector on disk.
>
> Maybe you should discuss power-loss behavior with Theodore T'so.
> For whatever reason, it seems that many drives and/or controllers
> like to scribble on random unrelated sectors as power is lost.

Last time we discussed this on lkml - I don't think Ted was involved
that time - the concensus was that only the last sector written is
in danger of being scribbled on.  (Sometimes because of reordering
we don't know which the last sector is, that's another story.)  If
you have experience with any disk that scribbled on a sector other
than the last written, I'd really appreciate knowing the model and
manufacturer - so that I can stay far away from such a POS.

As for silently feeding you corrupted sectors - that's clearly a
firmware bug, or outright omission.  Again, the term POS applies.

> For the atomic-commit case, an additional defense against this
> sort of problem might be to keep a few extra trees on disk,
> using a generation counter to pick the latest one. This does
> bring us back to scanning the whole filesystem at boot though,
> in order to disregard snapshots that have been damaged.

Unfortunately, most of the blocks are shared between trees so this
doesn't provide any extra protection.  RAID, or some RAID-like
thing (a little birdie told me that something may be in the works)
is probably the way to go, for dealing with substandard hardware
that you can't avoid using or weren't warned about.

--
Daniel
