Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284580AbRLPJUl>; Sun, 16 Dec 2001 04:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284573AbRLPJUc>; Sun, 16 Dec 2001 04:20:32 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:12163 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S284570AbRLPJU2>;
	Sun, 16 Dec 2001 04:20:28 -0500
Date: Sun, 16 Dec 2001 04:20:22 -0500 (EST)
From: Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: GOTO Masanori <gotom@debian.org>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: O_DIRECT wierd behavior..
In-Reply-To: <3C1C5F65.A060B285@zip.com.au>
Message-ID: <Pine.GSO.4.02A.10112160417330.26029-100000@aramis.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Dec 2001, Andrew Morton wrote:
> GOTO Masanori wrote:
> > At Sat, 15 Dec 2001 21:59:06 -0800,
> > Andrew Morton wrote:
> > ...
> > > --- linux-2.4.17-rc1/mm/filemap.c     Thu Dec 13 14:07:55 2001
> > > +++ linux-akpm/mm/filemap.c   Sat Dec 15 21:52:06 2001
> > > @@ -3038,8 +3038,11 @@ unlock:
> > >       /* For now, when the user asks for O_SYNC, we'll actually
> > >        * provide O_DSYNC. */
> > >       if (status >= 0) {
> > > -             if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
> > > +             if ((file->f_flags & O_SYNC) || IS_SYNC(inode)) {
> > >                       status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
> > > +                     if (status < 0)
> > > +                             written = 0;    /* Return the right thing */
> > > +             }
> > >       }
> > 
> > Right. If generic_osync_inode returns error, it must be needed.
> > This patch seems ok than my patch...
> 
> Actually, I preferred your approach :)
> 
> Also, note how if ->commit_write() or ->prepare_write() return an
> error, and we have already written some data, the function returns the
> number of bytes written and no indication that there was an error.
> According to the write(2) manpage, that's wrong.
> 
> Probably it is sufficient to make `written' a signed quantity and to
> do:
> 
> out_status:
> -       err = written ? written : status;
> +       err = status ? status : written;
> 
> I think that fixes the five or six bugs we've found so far in this
> function.  err..  make that six or seven.  What is it trying do if
> ->prepare_write() returns a non-zero, positive value?
> 
> It needs a big spring-clean.  I'm afraid I don't have time to do that
> for several days.

Thanks for the patches. There seems to be one more fix required: the test
program below works in 2.4.16 only if the write size is a multiple of 4K.
(Why) are all writes expected to be page size, in addition to being page
aligned? (It works fine on 2.4.2 for all sizes). Any quick fixes? :)

--suresh

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define O_DIRECT         040000 /* direct disk access hint */

int main()
{
        char *buf;
        int fd;

        buf = valloc(16384);
        fd = open("/tmp/blah", O_CREAT | O_RDWR | O_DIRECT, 0755 );

        printf("write returns %i\n", write(fd, buf, 4096));

        return 0;
}


