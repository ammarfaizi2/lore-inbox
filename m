Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269918AbRHGAvt>; Mon, 6 Aug 2001 20:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270020AbRHGAvj>; Mon, 6 Aug 2001 20:51:39 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:31620 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269836AbRHGAv2>; Mon, 6 Aug 2001 20:51:28 -0400
Date: Mon, 6 Aug 2001 18:51:45 -0600
Message-Id: <200108070051.f770pji27036@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108062033190.16817-100000@weyl.math.psu.edu>
In-Reply-To: <200108062350.f76NokT26152@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0108062033190.16817-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> On Mon, 6 Aug 2001, Richard Gooch wrote:
> 
> > This patch has the following ugly construct:
> > 
> > > +	/*  Ensure table size is enough  */
> > > +	while (fs_info.num_inodes >= fs_info.table_size) {
> > 
> > Putting the allocation inside a while loop is horrible, and isn't a
> 
> Why, exactly? I can show you quite a few places where we do exactly
> that (allocate and if somebody else had done it before us - free and
> repeat).  Pretty common for situations when we want low-contention
> spinlocks to protect actual reassignment of buffer (in this case BKL
> acts as such).

Even if it were only a situation of allocating, I don't like the loop,
because it means you can end up allocating twice for no reason.

More importantly, the loop you used doesn't protect insertions into
the table. So it's not safe on SMP.

Anyway, I've already fixed the allocation race you're concerned about,
plus the insertion race, in my tree (using a semaphore).

> > perfect solution anyway. I'm fixing this (and other races) with proper
> > locking. If you went to the trouble to start patching, why at least
> > didn't you do it cleanly with a lock?
> 
> Because it means adding a per-superblock lock for no good reason.

Well, it's just a single lock (only one devfs superblock possible).
And this is generally a low-contention case (new devfs entries are not
created that often). Using the lock also keeps the code simpler.

> PS: ObYourPropertyManager: karmic retribution?

Um, retribution for putting in an awful lot of time developing devfs
(despite extreme hostility), at considerable personal sacrifice, and
being patient and civilised to those who flamed against it? My, how
I've been such a horrible person.

I find your comment on karmic retribution repugnant.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
