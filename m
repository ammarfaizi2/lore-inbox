Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277097AbRJQUVp>; Wed, 17 Oct 2001 16:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277144AbRJQUVg>; Wed, 17 Oct 2001 16:21:36 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14442 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277097AbRJQUV2>; Wed, 17 Oct 2001 16:21:28 -0400
Date: Wed, 17 Oct 2001 22:21:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Gortmaker <p_gortmaker@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster
Message-ID: <20011017222108.C12055@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0110171442580.11099-100000@freak.distro.conectiva> <Pine.LNX.4.33.0110171112010.961-300000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0110171112010.961-300000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Oct 17, 2001 at 11:21:03AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 11:21:03AM -0700, Linus Torvalds wrote:
> 
> On Wed, 17 Oct 2001, Marcelo Tosatti wrote:
> > >
> > > And I've for a long time thought about adding a "readahead()" system call.
> > > There are just too many uses for it, it has come up in many different
> > > areas..
> >
> > There is a paper on USENIX 2001 which does implement directory readahead
> > and it shows huge improvements for some workload.
> 
> Hmm.. The implementation is trivial, it's really just a simple 3-line
> while-loop, with the rest of the code just doing argument checking etc.
> 
> Attached is the kernel diff ("ra-diff") along with a stupid program
> ("preread.c"), cribbed mostly from Pauls first patch to use it to pre-read
> a while tree.
> 
> It took much longer to compile the kernel and reboot, and write the
> test-program than it did to write the patch itself ;)
> 
> It walks the whole kernel tree in 0.2 seconds of CPU-time on my machine
> (of course, if it actually needs to start IO, the 0.2 seconds becomes 0.3
> seconds of CPU time and almost a minute and a half of wall-clock.
> Anyway, it clearly isn't a CPU-hog like doing a real "read" would have
> been).

I think with directory readahead Marcelo meant a transparent kernel
heuristic in the readdir path. ext2_get_page is completly synchronous
and it's reading one page at time, that's bad but it can be improved
transparently to userspace, just like we do with the files, and also
like the old code was doing before the directory in pagecache IIRC.

I don't see a real benefit in the sys_readahead code compared to just
reading the files, except it doesn't mark the pagecache referenced, but
I think activating the cache of the tree is ok in those special cases.
Also I believe in those cases we want to trim the active cache, not only
the inactive cache, in order to run diff faster, and we probably want
the tree in active cache too ASAP in case we need to run some more diff.

Andrea
