Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbSJ0GzJ>; Sun, 27 Oct 2002 01:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSJ0GzJ>; Sun, 27 Oct 2002 01:55:09 -0500
Received: from ns.suse.de ([213.95.15.193]:17419 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262295AbSJ0GzI>;
	Sun, 27 Oct 2002 01:55:08 -0500
Date: Sun, 27 Oct 2002 08:01:25 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Pimlott <andrew@pimlott.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20021027080125.A14145@wotan.suse.de>
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <p7365vptz49.fsf@oldwotan.suse.de> <20021026190906.GA20571@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021026190906.GA20571@pimlott.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc'ed back to linux-kernel in case other people are interested in
the rationale again]

On Sat, Oct 26, 2002 at 03:09:06PM -0400, Andrew Pimlott wrote:
> On Sat, Oct 26, 2002 at 09:53:26AM +0200, Andi Kleen wrote:
> > I have some patches to offer better than second resolution for stat.
> > That is needed for parallel make on MP systems, because otherwise it
> > cannot detect changes that need less than a second to execute.
> 
> Would you mind spelling out the problem case?  It's ususally not a
> big deal, because when a target and dependency have the same
> timestamp, make considers the target to be newer.  Is there a
> subtlety with parallel make that I am not seeing?  (And does it
> really depend on MP?)

I assume you mean 'older', not 'newer'?

Any default action is wrong in some case when an rule can take less
than a second, there is no replacement for an accurate time stamp.
Either the rule gets rebuilt too often (=annoying for the user because
it's slow) or not often enough (= broken result).

Parallel make makes it worse because parallel make processes need 
the timestamp to comunicate - make cannot know from internal data
if it has already run a rule or not. On MP systems the parallelism
is higher, making the problem show more often.


> > There are some minor compatbility issues with fs that only support 
> > second timestamps like ext2/ext3, see nsec.notes in the ftp directory
> > or past threads on that on the list.
> 
> I really feel strongly that you should not export resolution finer
> that what the filesystem can store.  There is too much risk of
> breakage (especially given the late date of submission), and if (as
> you said) all common filesystems will be able to store sub-second
> timestamps soon, this shouldn't be a significant drawback.  If this
> requires a new hook into the filesystem, so be it.

You have to export in some unit and it is convenient to use the most
finegrained available (ns). This matches what other Unixes like
Solaris do too. The program can always chose to ignore the ns 
(which will most do at least initially) part or even round more.

What happens currently in my patch is that the inode in memory stores jiffies
resolution. As long as you don't run out of inode cache and need to
flush/reload an inode you always have the best resolution.

When an inode is flushed on an old fs with only second resolution the 
subsecond part is truncated. This has the drawback that an inode
timestamp can jump backwards on reload as seen by user space.
Another way would be to round on flush, but that also has some problems :-
for example you can get timestamps which are ahead of the current
wall clock. Neither of them is ideal. Rounding properly requires
hooks.

In my current patchkit I just chose to truncate because that was the 
easiest and the other more complicated solutions didn't offer any 
compeling advantage. One can hope that nanosecond aware applications
know how to deal with these problems. One possibility would be to
do the same as Solaris here so that ns aware apps stay portable,
but I don't have access to a Solaris 8 system and cannot test what
they do. It's a kind of arbitary choice. Also I don't see it as a big
problem.

Long term of course all the file systems should support fine grained properly
so that these issues do not occur anymore.  I hope no new file systems will 
make the same mistake as to limiting the timestamp to a second resolution.

-Andi

