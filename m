Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293182AbSCTALG>; Tue, 19 Mar 2002 19:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293186AbSCTAK7>; Tue, 19 Mar 2002 19:10:59 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:20125 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S293182AbSCTAKp>;
	Tue, 19 Mar 2002 19:10:45 -0500
Date: Tue, 19 Mar 2002 19:10:18 -0500
From: Theodore Tso <tytso@mit.edu>
To: Peter Hartley <pdh@utter.chaos.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
Message-ID: <20020319191018.A23000@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Peter Hartley <pdh@utter.chaos.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <006701c1cf6d$d9701230$2701230a@electronic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 05:45:24PM -0000, Peter Hartley wrote:
> 
> But no new syscall was invented for setrlimit; both old and new
> programs come to the same function (in kernel/sys.c). This was,
> according to the glibc source, at about 2.3.25 time.

Yes.  This resulted in a very nasty ABI change, since in effect
RLIM_INFINITY changed on us.  It's rather embarassing, actually, since
this is the sort of thing that I generally complain about happening
with various user-land libraries (such as glibc, ncurses, libgal,
etc.) and I used to say that kernel programmers were generally a lot
more careful about such things.  Well, I can't say that any more....

> 
>  * e2fsck calls setrlimit(RLIMIT_FSIZE, RLIM_INFINITY) in
>    an attempt to unset the limit. RLIM_INFINITY here is
>    0xFFFFFFFF. This is IMO the Right Thing.

I did this because I was tired of bug reports from users who were
losing due to other programs that were attempting to set the limit of
RLIMIT_FSIZE, and screwing up because they were compiled with 2.2
headers.  (Or rather, were compiled with a glibc which was compiled
against 2.2 headers.)n

>  * glibc knows nothing about the new unsigned limits, because
>    it's compiled against 2.2 headers. So it clips the limit
>    value to 0x7FFFFFFF to "correct" it before calling the
>    setrlimit syscall. This is IMO still the Right Thing,
>    because it's trying to call the old syscall as if to run
>    a new program on a 2.2 kernel.

Unfortunately, all of my testing was done under systems where the
glibc was already compiled under 2.4 headers, so I didn't realize that
glibc would try to be "helpful" and correct the limit used by rlimit.
(In other words, the e2fsprogs workaround was only worked in the case
where other programs were losing because they were using the 2.2
kernel ABI, but the libc was using the 2.4 kernel ABI.  Sigh.)

So obviously, the way I need to fix e2fsprogs is to fork a child
process, check to see whether or not I can safely call setrlimit, and
if not, exit without trying to set it.  :-( This is a really dirty
hack, but I don't see any other way fixing user-land programs that are
trying to work around this ABI mess.  (And since distributions are
already shipping 2.4 kernels, this is a mess that userspace programs
are going to have to deal with for a non-trivial amount of time.)

> Surely the only Right Things to do in the kernel are (a) invent a new
> setrlimit call that corrects the RLIM_INFINITY value, or (b) have the
> current setrlimit call correct the RLIM_INFINITY value unconditionally.
> 
> Answer (b) breaks programs that deliberately set a limit of 0x7FFFFFFF, but
> it's less intrusive than answer (a). The patch for (b) is fairly trivial and
> I'll rustle one up if people agree it's the Right Thing.

I think we should do (b) as soon as possible, but it'll still be a
program since most distributions are either shipping CD-ROM's with 2.4
kernels on them already (sigh).

The other fix is that the filesize limit *really* shouldn't apply to
block devices.  We should probably do both fixes.

							- Ted
