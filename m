Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSJ0P3G>; Sun, 27 Oct 2002 10:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSJ0P3G>; Sun, 27 Oct 2002 10:29:06 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:2695 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S262430AbSJ0P3E>; Sun, 27 Oct 2002 10:29:04 -0500
Date: Sun, 27 Oct 2002 10:20:38 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20021027152038.GA26297@pimlott.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <p7365vptz49.fsf@oldwotan.suse.de> <20021026190906.GA20571@pimlott.net> <20021027080125.A14145@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021027080125.A14145@wotan.suse.de>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 08:01:25AM +0100, Andi Kleen wrote:
> On Sat, Oct 26, 2002 at 03:09:06PM -0400, Andrew Pimlott wrote:
> > Would you mind spelling out the problem case?  It's ususally not a
> > big deal, because when a target and dependency have the same
> > timestamp, make considers the target to be newer.
> 
> I assume you mean 'older', not 'newer'?

No (but maybe I phrased it badly):

    % cat Makefile 
    foo: bar
            echo did it
    % touch foo bar
    % ls --full-time foo bar
    -rw-r--r--    1 pimlott  pimlott         0 Sun Oct 27 09:36:26 2002 bar
    -rw-r--r--    1 pimlott  pimlott         0 Sun Oct 27 09:36:26 2002 foo
    % make
    make: `foo' is up to date.

Ie, foo is considered newer.

> Any default action is wrong in some case when an rule can take less
> than a second,

I'm sure there is a case where this is true, but my imagination and
googling failed to provide one.  Even the messages to the GNU make
mailing list when Paul Eggert implemented nanosecond support didn't
include a specific rationale.

> there is no replacement for an accurate time stamp.

While I agree, I thought that a concrete example might help persuade
others.  (I think I've even run into instances where second
resolution was a real problem, I just can't recall them.)

> > I really feel strongly that you should not export resolution finer
> > that what the filesystem can store.  There is too much risk of
> > breakage (especially given the late date of submission), and if (as
> > you said) all common filesystems will be able to store sub-second
> > timestamps soon, this shouldn't be a significant drawback.  If this
> > requires a new hook into the filesystem, so be it.
> 
> You have to export in some unit and it is convenient to use the most
> finegrained available (ns). This matches what other Unixes like
> Solaris do too. The program can always chose to ignore the ns 
> (which will most do at least initially) part or even round more.
> 
> What happens currently in my patch is that the inode in memory stores jiffies
> resolution. As long as you don't run out of inode cache and need to
> flush/reload an inode you always have the best resolution.
> 
> When an inode is flushed on an old fs with only second resolution the 
> subsecond part is truncated. This has the drawback that an inode
> timestamp can jump backwards on reload as seen by user space.

Example problem case (assuming a fs that stores only seconds, and a
make that uses nanoseconds):

- I run the "save and build" command while editing foo.c at T = 0.1.
- foo.o is built at T = 0.2.
- I do some read-only operations on foo.c (eg, checkin), such that
  foo.o gets flushed but foo.c stays in memory.
- I build again.  foo.o is reloaded and has timestamp T = 0, and so
  gets spuriously rebuilt.

> Another way would be to round on flush, but that also has some problems :-
> for example you can get timestamps which are ahead of the current
> wall clock.

Only if the flush is less than a second after the write, right?
How likely is that in Linux?

I tend to prefer the proposal to set the nanosecond field to 10^9-1.
At least my scenario above doesn't happen.

Andrew
