Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131819AbRCXVXx>; Sat, 24 Mar 2001 16:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131823AbRCXVXo>; Sat, 24 Mar 2001 16:23:44 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:48649 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131820AbRCXVXg>; Sat, 24 Mar 2001 16:23:36 -0500
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>
	<vbaelvp3bos.fsf@mozart.stat.wisc.edu>
	<20010322193549.D6690@unthought.net>
	<vbawv9hyuj0.fsf@mozart.stat.wisc.edu>
	<200103240502.VAA02673@penguin.transmeta.com>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Linus Torvalds's message of "Fri, 23 Mar 2001 21:02:31 -0800"
Date: 24 Mar 2001 15:22:53 -0600
Message-ID: <vba7l1ex3o2.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> >
[ under kernel 2.4.2 ]
> >
> >    CVS gcc 3.0:          Debian gcc 2.95.3:   RedHat gcc 2.96:
> >                      
> >    real    16m8.423s     real    8m2.417s     real    12m24.939s
> >    user    15m23.710s    user    7m22.200s    user    10m14.420s
> >    sys     0m48.730s     sys     0m41.040s    sys     2m13.910s 
> >maps:    <250 lines           <250 lines          >3000 lines
> >
> >Obviously, the *real* problem is RedHat GCC 2.96.  If Linus bothers to
> >write this patch (he probably already has),
> 
> Check out 2.4.3-pre7, I'd be interested to hear what the system time is
> for that one.

Okay.  One note about the above results: as Zach pointed out, my
2.95.3 number for "maps" was wrong.  I must have forgotten to collect
the data but thought I had.  In fact, there are ~10 lines in "maps"
for the 2.95.3 "cc1plus" process.  The other "maps" numbers for 3.0
and 2.96 are correct, at least within an order of magnitude.

Under 2.4.3-pre7, I get the following disappointing numbers:

    CVS gcc 3.0:          Debian gcc 2.95.3:   RedHat gcc 2.96:

    real    16m10.660s    real    7m58.874s    real    10m36.368s
    user    15m27.900s    user    7m23.090s    user    10m0.290s 
    sys     0m48.400s     sys     0m40.350s    sys     0m40.790s 
maps:   <20 lines             ~10 lines            ~10 lines

A huge win for 2.96 and absolutely no benefit whatsoever for 3.0, even
though it obviously had a 10-fold effect on maps counts.  On the
positive side, there was no performance *hit* either.

As a blind "have not looked at relevant kernel source" guess, this
looks like a hash scaling problem to me: the hash size works great for
~300 maps and falls apart in a major way at ~3000 maps, presumably
when we get multiple hits per hash bin and start walking 10-member
lists.

How this translates into a course of action---some combination of
keeping your patch, enlarging the hash, and performance tweaking the
list-walking---I'm not sure.

Kevin <buhr@stat.wisc.edu>
