Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272058AbRIJWTx>; Mon, 10 Sep 2001 18:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272061AbRIJWTn>; Mon, 10 Sep 2001 18:19:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3087 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272058AbRIJWTd>; Mon, 10 Sep 2001 18:19:33 -0400
Date: Mon, 10 Sep 2001 15:15:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010910211135Z16537-26183+875@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109101439261.1034-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Sep 2001, Daniel Phillips wrote:
>
> Here's some anectdotal evidence to the contrary.
>
> This machine requires about 1.5 seconds to diff two kernel trees if both
> trees are in cache.  If neither tree is in cache it takes 90 seconds.  It's a
> total of about 300M of source - reading that into memory should take about 10
> seconds at 30M/sec, taking one pass across the disk and assuming no extensive
> fragmentation.
>
> We lost 78.5 seconds somewhere.  From the sound of the disk drives, I'd say
> we lost it to seeking, which physical readahead with a large cache would be
> able to largely eliminate in this case.

Yes, we could have a huge physical read-ahead, and hope that the logical
layout is such that consecutive files in the directory are also
consecutive on disk (which is quite often true).

And yes, doing a cold "diff" is about the worst case - we can't take
advantage of logical read-ahead within the files themselves (they tend to
be too small for read-ahead to matter on that level), and the IO is
bouncing back and forth between two different trees - and thus most likely
two very different places on the disk.

And even when the drive does physical read-ahead, a drive IO window of
64kB-256kB (and let's assume about 50% of that is actually _ahead_ of the
read) is not going to avoid the constant back-and-forth seeking when the
combined size of the two kernel trees is in the 50MB region.

[ There are also drives that just aren't very good at handling their
  internal caches. You'll see drives that have a 2MB on-board buffer, but
  the way the buffer is managed it might be used in fixed chunks. Some of
  the really worst ones only have a single buffer - so seeking back and
  forth just trashes the drive buffer completely. That's rather unusual,
  though. ]

However, physical read-ahead really isn't the answer here. I bet you could
cut your time down with it, agreed. But you'd hurt a lot of other loads,
and it really depends on nice layout on disk. Plus you wouldn't even know
where to put the data you read-ahead: you only have the physical address,
not the logical address, and the page-cache is purely logically indexed..

The answer to this kind of thing is to try to make the "diff" itself be
nicer on the cache. I bet you could speed up diff a lot by having it read
in multiple files in one go if you really wanted to. It probably isn't
worth most peoples time.

(Ugly secret: because I tend to have tons of memory, I sometimes do

	find tree1 tree2 -type f | xargs cat > /dev/null

just after I have rebooted, just so that I always have my kernel trees in
the cache - after that they tend to stay there.. Having a gig of ram
makes you do stupid things).

			Linus

