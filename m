Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284526AbRLPIrq>; Sun, 16 Dec 2001 03:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284529AbRLPIrg>; Sun, 16 Dec 2001 03:47:36 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:40210 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284526AbRLPIr3>; Sun, 16 Dec 2001 03:47:29 -0500
Message-ID: <3C1C5F65.A060B285@zip.com.au>
Date: Sun, 16 Dec 2001 00:46:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: GOTO Masanori <gotom@debian.org>
CC: Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: O_DIRECT wierd behavior..
In-Reply-To: <3C1C382A.946EA61B@zip.com.au>,
		<Pine.GSO.4.02A.10112151947010.14453-100000@aramis.rutgers.edu>
		<3C1C382A.946EA61B@zip.com.au> <wtwwuzn4m02.wl@fe.dis.titech.ac.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GOTO Masanori wrote:
> 
> At Sat, 15 Dec 2001 21:59:06 -0800,
> Andrew Morton wrote:
> ...
> > --- linux-2.4.17-rc1/mm/filemap.c     Thu Dec 13 14:07:55 2001
> > +++ linux-akpm/mm/filemap.c   Sat Dec 15 21:52:06 2001
> > @@ -3038,8 +3038,11 @@ unlock:
> >       /* For now, when the user asks for O_SYNC, we'll actually
> >        * provide O_DSYNC. */
> >       if (status >= 0) {
> > -             if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
> > +             if ((file->f_flags & O_SYNC) || IS_SYNC(inode)) {
> >                       status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
> > +                     if (status < 0)
> > +                             written = 0;    /* Return the right thing */
> > +             }
> >       }
> 
> Right. If generic_osync_inode returns error, it must be needed.
> This patch seems ok than my patch...

Actually, I preferred your approach :)

Also, note how if ->commit_write() or ->prepare_write() return an
error, and we have already written some data, the function returns
the number of bytes written and no indication that there was an error.
According to the write(2) manpage, that's wrong.

Probably it is sufficient to make `written' a signed quantity
and to do:

out_status:
-       err = written ? written : status;
+       err = status ? status : written;

I think that fixes the five or six bugs we've found so far in
this function.  err..  make that six or seven.  What is it trying
do if ->prepare_write() returns a non-zero, positive value?

It needs a big spring-clean.   I'm afraid I don't have time to
do that for several days.

-
