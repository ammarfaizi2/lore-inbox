Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbSJ1GHK>; Mon, 28 Oct 2002 01:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbSJ1GHK>; Mon, 28 Oct 2002 01:07:10 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:18401 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S262886AbSJ1GHJ>; Mon, 28 Oct 2002 01:07:09 -0500
Date: Mon, 28 Oct 2002 01:03:09 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20021028060309.GR1557@pimlott.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <p7365vptz49.fsf@oldwotan.suse.de> <20021026190906.GA20571@pimlott.net> <20021027080125.A14145@wotan.suse.de> <20021027152038.GA26297@pimlott.net> <20021028053004.C2558@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028053004.C2558@wotan.suse.de>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 05:30:04AM +0100, Andi Kleen wrote:
> On Sun, Oct 27, 2002 at 10:20:38AM -0500, Andrew Pimlott wrote:
> > 
> > I'm sure there is a case where this is true, but my imagination and
> > googling failed to provide one.  Even the messages to the GNU make
> 
> foo: bar
> 	action1 <something that takes less than a second> 
> 
> frob: foo
> 	action2 <something that takes a long time>
> 
> 
> action1 is executed. foo and bar have the same time stamp. action2 
> is executed.

Try it:

    % cat Makefile 
    foo: bar
            touch foo
    frob: foo
            sleep 10
            touch frob
    % rm foo bar frob
    % touch bar
    % make frob      
    touch foo
    sleep 10
    touch frob
    % make frob
    make: `frob' is up to date.

No problem with this case.

> make runs again. Default rule sees foo.mtime == bar.mtime and starts
> action1 and action2 again.

make is not that broken.  (Well, according to one post I googled, it
was in 1970, but it was noticed and fixed, and the fixed behavior
has long been standardized.)

> > Example problem case (assuming a fs that stores only seconds, and a
> > make that uses nanoseconds):
> > 
> > - I run the "save and build" command while editing foo.c at T = 0.1.
> > - foo.o is built at T = 0.2.
> > - I do some read-only operations on foo.c (eg, checkin), such that
> >   foo.o gets flushed but foo.c stays in memory.
> > - I build again.  foo.o is reloaded and has timestamp T = 0, and so
> >   gets spuriously rebuilt.
> 
> Yes, when you file system has only second resolution then you can get
> spurious rebuilds if your inodes get flushed. There is no way my patch
> can fix that.

I grant that second-resolution timestamps are broken.  But you seem
to misunderstand how make works--the current problem is not that
severe.  Whereas your change introduces a different problem that (in
my estimation) is more likely to appear, and will cause mare pain.

I'm saying you're replacing a problem (bad graularity) that

    - is well known
    - is intuitive
    - doesn't cause severe problems in practice (or at least, nobody
      has provided an example)

with one (timestamps jumping at unpredictable times) that

    - is obscure
    - requires knowledge of kernel internals to understand
    - will bite people (I claim, and have provided a concrete
      example)
    - will be wickedly hard to reproduce and diagnose

> The point of my patchkit is to allow the file systems
> who support better resolution to handle it properly.

If that is the point, why not leave the behavior unchanged for other
filesystems?  (Other than that it would be a bit more work.)
Doesn't it make sense, on general principles, to be conservative?

> It's a fairly obscure case because the inode has to be flushed
> and reloaded in less than a second (so not likely to trigger
> often in practice) 

If that were true, I would agree that it's probably not an issue in
practice.  But unless I misunderstand, in the example I gave, the
flush and reload of foo.o can happen any time between the first and
second builds, which could be arbitrarily far apart.  So I believe
it's a fairly plausible scenario.

Anyway, this isn't the biggest deal in the world.  Maybe I'm wrong
and nobody will ever notice.  But it doesn't seem like a good risk
to take.

Andrew
