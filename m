Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSEaU6O>; Fri, 31 May 2002 16:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316846AbSEaU6N>; Fri, 31 May 2002 16:58:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6514 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316831AbSEaU6L>; Fri, 31 May 2002 16:58:11 -0400
Date: Fri, 31 May 2002 22:58:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/18] mark swapout pages PageWriteback()
Message-ID: <20020531205809.GV1172@dualathlon.random>
In-Reply-To: <3CF197A8.A5DB850B@zip.com.au> <Pine.LNX.4.44.0205262035200.1746-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 08:38:26PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 26 May 2002, Andrew Morton wrote:
> >
> > But I recall you saying that there was advantage in keeping swapout pages
> > locked so that aggressive memory users would throttle against their
> > own swapout.  What's the story there?
> 
> The advantage is not the lock itself, as much as having people who page in
> swap pages be delayed on them - which ends up slowing down processes that
> swap a lot.
> 
> BUT: that could equally well be done by doing a "wait_on_writeback()" or
> similar, and it could also be a tunable thing (ie wait on writeback only
> when we actually need to slow them down). In particular, _not_ slowing
> them down does improve throughput, it just makes it really really nasty
> from an interactive standpoint under some loads.
> 
> I don't know. I have this feeling that it would be good to try to share
> all the semantics between swap pages and shared file mappings, but at the

that is definitely a good idea, that's why I resurrected in my current vm
patches your optimizations that allows a minor fault to be resolved even
if the swapcache is under async writeout.

The fact is that there is no difference at all between MAP_SHARED and
MAP_ANONYMOUS in terms of memory pressure, the only difference is that
with MAP_SHARED we are guaranteed that we won't run out of "swap" space.
No other differnece.

In short the same way MAP_ANON must pageout correctly, also MAP_SHARED
must swapout correctly with very vm intensive conditions.

I suggest not making differences in the algorithm (besides having to use
two different code paths, but in terms of mem pressure and minor faults
the actions should be the same, if not then one of the two is either
buggy or inferior).


> same time I also have to admit to believing that swap _is_ special in some
> ways, so if we don't ever really unify them I won't be shedding any huge
> tears.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
