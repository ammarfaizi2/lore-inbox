Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132642AbRARJtf>; Thu, 18 Jan 2001 04:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132877AbRARJtZ>; Thu, 18 Jan 2001 04:49:25 -0500
Received: from fungus.teststation.com ([212.32.186.211]:10947 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S132642AbRARJtQ>; Thu, 18 Jan 2001 04:49:16 -0500
Date: Thu, 18 Jan 2001 10:49:06 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>, <kernel@hollins.edu>
Subject: Re: oops in 2.4.1-pre8
In-Reply-To: <12E9172B5107@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0101181013260.21353-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Petr Vandrovec wrote:

> > Rainer Mager reported the same thing yesterday ("Oops with 4GB memory
> > setting in 2.4.0 stable" if you want to read the thread).
>
> I think that I found source of problem. I have no simple solution :-(
>

I think the source of the problem is that this code was changed without
anyone being capable of actively maintaining it (time, knowledge,
motivation, ...). And later maintainers (me) haven't known or seen
anything wrong with it.


> But I'm not 100% sure, as this would mean that you do not
> kunmap/UnlockPage/page_cache_release any >1GB page at all in
> smb_free_cache_blocks(), as page pointer obtained by page_cache_entry()
> points to some random page (to couple just below 1GB boundary) instead
> of to correct one, so smbfs should die as soon as it finds first highmem
> page... Is it possible?

It sounds possible from the reports, where it has died as soon as it is
touched on a highmem mmachine.


> So your system has couple of chances to deadlock - either on out of
> kmaps, or on locked directory cache root (cachep), or on some of locked
> directory cache pages (blocks)...

Thanks for looking. I haven't begun to verify any of your previous
suggestions.

Copying the ncpfs cache code seems so much better. It's possibly a bigger
change (currently 20k diff -u) than to fix the cache.c code to do whatever
is right but the end result should be a lot better (I hope). Fixed size
cache entries makes lookups simpler, creating dentry/inode from the info
returned by the findfirst/findnext smb calls avoids extra calls on some
common(?) usage patterns.

Assuming your code is correct, and I'm sure it is, this should be a faster
way to do it than for me to figure out how the existing smbfs cahce can be
made to work. The differences are not that great between ncpfs and smbfs,
both are networked dos-ish filesystems. :)

My new code oopsed on me last night (and then I realized what time it
was). But so far the ncpfs code is fitting quite nicely.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
