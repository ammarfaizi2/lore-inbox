Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262068AbRENCj5>; Sun, 13 May 2001 22:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262110AbRENCjg>; Sun, 13 May 2001 22:39:36 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:60823 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262068AbRENCj0>; Sun, 13 May 2001 22:39:26 -0400
Date: Sun, 13 May 2001 20:39:23 -0600
Message-Id: <200105140239.f4E2dNd08399@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <20010513184509.P2103@work.bitmover.com>
In-Reply-To: <200105140117.f4E1HqN07362@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.21.0105131824090.20981-100000@penguin.transmeta.com>
	<20010513184509.P2103@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:
> On Sun, May 13, 2001 at 06:32:02PM -0700, Linus Torvalds wrote:
> > >   Hi, Linus. I've been thinking more about trying to warm the page
> > > cache with blocks needed by the bootup process. What is currently
> > > missing is (AFAIK) a mechanism to find out what inodes and blocks have
> > > been accessed. Sure, you can use bmap() to convert from file block to
> > > device block, but first you need to figure out the file blocks
> > > accessed. I'd like to find out what kind of patch you'd accept to
> > > provide the missing functionality.
> > 
> > Why would you use bmap() anyway? You CANNOT warm up the page cache with
> > the physical map nr as discussed. So there's no real point in using
> > bmap() at any time.
> 
> Ha.  For once you're both wrong but not where you are thinking.  One
> of the few places that I actually hacked Linux was for exactly this
> - it was in the 0.99 days I think.  I saved the list of I/O's in a
> file and filled the buffer cache with them at next boot.  It
> actually didn't help at all.

Maybe you did something wrong :-) Seriously, maybe you're right, and
maybe not. I'd like to find out, and having the infrastructure to get
FS access events will help in that (as well as your preferred
approach: see below). If I am digging into a rathole, I'll do it with
my eyese open ;-)

> I don't remember why, maybe it was back so long ago that I didn't
> have the memory, but I think it was more subtle than that.  It's
> basically a queuing problem and my instincts were wrong, I thought
> if I could get all the data in there then things would go faster.
> If you think through all the stuff going on during a boot it doesn't
> really work that way.

Well, on my machines anyway, the discs rattle an awful lot during
bootup. Not just little adjacent seeks, but big, partition crossing
seeks.

> Anyway, a _much_ better thing to do would be to have all this data
> laid out contig, then slurp in all the blocks in on I/O and then let
> them get turned into files.  This has been true for the last 30
> years and people still don't do it.  We're actually moving in this
> direction with BitKeeper, in the future, large numbers of small
> files will be stored in one big file and extracted on demand.  Then
> we do one I/O to get all the related stuff.

Yeah, we need a decent unfragmenter. We can do that now with bmap().
But to speed up boots, for example, we need to lay all the inodes that
are accessed during boot in one contiguous chunk on the disc. Again,
we need to know which files are being accessed to know that.
/proc/fsaccess would tell us that.

The down side of just relying on contiguous files is that some files
(especially bloated C libraries) are not fully used. I would not be at
all surprised if more than 75% of glibc is not (or rarely) used.
There's a lot of stuff in there that isn't used very often.

However, a *refragmenter* might be interesting. Find out which blocks
in which files are actually used during boot, and lay just those out
in a contiguous section. *That* would smoke!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
