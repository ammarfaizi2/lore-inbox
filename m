Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281459AbRKFFFb>; Tue, 6 Nov 2001 00:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281460AbRKFFFL>; Tue, 6 Nov 2001 00:05:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55818 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281459AbRKFFFB>; Tue, 6 Nov 2001 00:05:01 -0500
Date: Mon, 5 Nov 2001 21:01:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.GSO.4.21.0111052306150.27713-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111052037240.1061-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Nov 2001, Alexander Viro wrote:
>
> Oh, come on. (a) is obvious, but obviously not enough ;-)

I agree, but I think it's a fairly good starting point to build up some
heuristics.

Also note that traditonal UNIX implementations will have a hard time doing
anything more fine-grained than "is the parent the root directory or not".
Information about grandparents etc has been lost long before we get to
"ialloc()", so I bet you'll find experimental data only on that one-level
thing.

But it is probably not a binary decision in real life.

In real life, you're ok switching cylinder groups for /home vs /usr, but
you're also ok switching groups for /home/torvalds vs /home/viro. And it's
still reasonably likely that it makes sense to switch groups in
/home/torvalds between 'src' and 'public_html'.

But the deeper down in the directory hierarchy you get, the less likely it
is that it makes sense.

And yes, it's just a heuristic. But it's one that where thanks to the
dcache we could reasonably easily do more than just a black-and-white
"root vs non-root" thing.

> Yes, but block reservation also makes sense (otherwise we can end up
> putting a directory into parent's CG only to have all children
> going there _and_ getting far from their data).  Which might be the
> problem with original code, BTW.

Yes, agreed. Disk space allocations should definitely be part of the
heuristics, and that's obviously both inode and blocks.

I do believe that there are probably more "high-level" heuristics that can
be useful, though. Looking at man common big trees, the ownership issue is
one obvious clue. Sadly the trees obviously end up being _created_ without
owner information, and the chown/chgrp happens later, but it might still
be useable for some clues.

		Linus

