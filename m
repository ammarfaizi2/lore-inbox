Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281221AbRLQRT4>; Mon, 17 Dec 2001 12:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281663AbRLQRTq>; Mon, 17 Dec 2001 12:19:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30786 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281221AbRLQRTd>; Mon, 17 Dec 2001 12:19:33 -0500
Date: Mon, 17 Dec 2001 18:18:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: GOTO Masanori <gotom@debian.org>
Cc: Andrew Morton <akpm@zip.com.au>,
        Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT wierd behavior..
Message-ID: <20011217181840.G2431@athlon.random>
In-Reply-To: <Pine.GSO.4.02A.10112151947010.14453-100000@aramis.rutgers.edu> <3C1C382A.946EA61B@zip.com.au> <wtwwuzn4m02.wl@fe.dis.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <wtwwuzn4m02.wl@fe.dis.titech.ac.jp>; from gotom@debian.org on Sun, Dec 16, 2001 at 05:17:33PM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 05:17:33PM +0900, GOTO Masanori wrote:
> At Sat, 15 Dec 2001 21:59:06 -0800,
> Andrew Morton wrote:
> > Then the kernel screws up the error handling, and ends up
> > setting the file size to -EINVAL (ie: rather large).
> > 
> > 1: We're testing `written >= 0', but it is unsigned (!).  In two
> >    places.
> > 
> >    This one, IMO is a gcc shortcoming.  The compiler is capable of warning
> >    about expressions which always evaluate to true or false in `if' statements,
> >    but turning this on also enables lots of things you don't want it to warn about.
> >    gcc needs to provide finer control of its warning capabilities.  I patched
> >    gcc-2.7.2.3 to do this ages back and it was very useful.
> >
> > 2: If generic_osync_inode() returns an error, we fail to report it.  In
> >    two places.
> >
> > Here's a quick fix.  It needs a review.
> > 
> > --- linux-2.4.17-rc1/mm/filemap.c	Thu Dec 13 14:07:55 2001
> > +++ linux-akpm/mm/filemap.c	Sat Dec 15 21:52:06 2001
> > @@ -3038,8 +3038,11 @@ unlock:
> >  	/* For now, when the user asks for O_SYNC, we'll actually
> >  	 * provide O_DSYNC. */
> >  	if (status >= 0) {
> > -		if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
> > +		if ((file->f_flags & O_SYNC) || IS_SYNC(inode)) {
> >  			status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
> > +			if (status < 0)
> > +				written = 0;	/* Return the right thing */
> > +		}
> >  	}
> 
> Right. If generic_osync_inode returns error, it must be needed. 
> This patch seems ok than my patch...

The above have nothing with the O_DIRECT changes, the above was present
in 2.4.9 too.

my worry is that failing with -EIO or whatever if we written something can
screwup the app, the app will think the pos is still at the start of our
writes. the "ingore" of the osync failure (that can be generated only by
an I/O error) was on the lines of the ignore of a failure in
prepare_write/commit_write if we just written something. So to me it
looked quite intentional, not just a thinko. In those cases if we wrote
something we report "written" with a short-write (infact a short write
from kernel just indicates something is not strightforward) otherwise
only if nothing was written yet, we report -EIO. So the app, will know
something is been written and the "pos" of the fd is been updated, then
it will try again to write the remaining part and it will get the -EIO
next time.

But I see with common sense that a failing O_SYNC should be somehow
reported even if we just written something, or it could be silenty
ignored, the app at the very least should try again or to notify a
failure rather than losing the data journaling due the I/O errors in the
data/metadata flushing. At least this osync failure is something that
shouldn't happen in production. If an osync fails it means there's a bad
sector or at the very least some other unrelated software bug.

I'm unsure (it's basically a matter of API, not something a kernel
developer can choose liberally), and the SuSv2 is not saying anything about
O_SYNC failures in the write(2) manapge, but I guess it would be at
least saner to put the "pos" backwards if we fail osync but we just
written something (so if we previously advanced pos).

Comments? Andrew?

Andrea
