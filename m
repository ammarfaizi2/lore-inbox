Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269788AbRHDDug>; Fri, 3 Aug 2001 23:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269787AbRHDDu1>; Fri, 3 Aug 2001 23:50:27 -0400
Received: from egghead.curl.com ([216.230.83.4]:21010 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S269786AbRHDDuN>;
	Fri, 3 Aug 2001 23:50:13 -0400
From: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080317471707.01827@starship>
	<20010803121638.A28194@cs.cmu.edu> <0108031854120A.01827@starship>
	<Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva>
	<s5gvgkacqlm.fsf@egghead.curl.com>
	<200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu>
	<20010803132457.A30127@cs.cmu.edu> <s5g3d78261g.fsf@egghead.curl.com>
	<20010804051320.B16516@emma1.emma.line.org>
Date: 03 Aug 2001 23:50:23 -0400
In-Reply-To: <20010804051320.B16516@emma1.emma.line.org>
Message-ID: <s5gr8usmqkg.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> On Fri, 03 Aug 2001, Patrick J. LoPresti wrote:
> 
> > To fill in more of the table, Qmail does:
> > 
> >   fd = open(tmp)
> >   write(fd)
> >   fsync(fd)
> >   link(tmp,final)
> >   close(fd)
> 
> http://cr.yp.to/qmail/faq/reliability.html

...which is consistent.  Qmail is assuming that the link() is
synchronous, as it was back in the "Good Old Days" of stock FFS.

> > ...and Postfix does:
> > 
> >   fd = open(final)
> >   write(fd)
> >   (should be an "fsync(fd)" here, but I cannot find it)
> >   fchmod(fd,+execute)
> >   fsync(fd)
> >   close(fd)
> 
> > Postfix apparently uses the execute bit to indicate that delivery is
> > complete.  I am probably misreading the source (version 20010228
> > Patchlevel 3), but I do not see any fsync() between the write and the
> > fchmod.  Surely it is there or this delivery scheme is not reliable on
> > any system, since without an intervening fsync() the writes to the
> > data and the permissions can happen out of order.
> 
> Not really. The error code if fsync() or close failed are propagated
> back to the caller who then decides what to do. smtpd.c nukes the
> file.

That is not the problem.  The problem is that the system could start
flushing blocks to disk after the call to fchmod and before the call
to fsync.  If so, the system could write the mode bits first and then
crash before writing the data, leaving the execute bit set on the file
but without valid data within.  This could result in a corrupted mail
message.

To avoid this, Postfix *must* do fsync() or fdatasync() after the
write() and before the fchmod()+fsync(); that will insure that the
execute bit implies valid ("committed") data in the file.  I was
unable to find any such call to fsync() or fdatasync(), but as I
mentioned, I am probably simply misreading the code.

> > Anyway, it is certainly true that it is largely useless to have
> > fsync() commit only one path to a file; many applications expect to be
> > able to force a simple link(x,y) to be committed to disk.
> 
> BSD FFS + softupdates sync all file names, traversing from the mount
> point down to the actual directory entries that need to be synched.

...and the Linux developers continue to insist that this is "stupid".
Ah, the joys of gaps in standards.

> It looks so to me. After the MTA behaviour has been dug up, the
> dirsync option could be even weaker if fsync() behaved like FFS +
> softupdates: sync the directory entries, including those of link and
> rename, as well.

Ideally, this would be an option you could set per-application (as
opposed to per-directory or per-mountpoint), because we are really
talking about allowing Linux to support applications written for BSD
file system semantics.  It is not obvious to me what the best
implementation for that would be, though.  Maybe just a compile-time
option to choose the appropriate open/link/rename/etc. operations.

 - Pat
