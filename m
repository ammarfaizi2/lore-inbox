Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316861AbSFKGp0>; Tue, 11 Jun 2002 02:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316863AbSFKGpZ>; Tue, 11 Jun 2002 02:45:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52232 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316861AbSFKGpY>;
	Tue, 11 Jun 2002 02:45:24 -0400
Message-ID: <3D059D5E.C9F9F659@zip.com.au>
Date: Mon, 10 Jun 2002 23:49:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: Your message of "Mon, 10 Jun 2002 23:17:27 MST."
	             <3D0595F7.A21AE62B@zip.com.au> <11043.1023776994@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 10 Jun 2002 23:17:27 -0700,
> Andrew Morton <akpm@zip.com.au> wrote:
> >Keith Owens wrote:
> >>
> >> fd = open("foo", O_RDWR);
> >> map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> >> ... modify the mapped pages ...
> >> munmap(map, size);
> >> close(fd);
> >>
> >> The timestamp on foo is not updated, even though the contents have
> >> changed.  Adding msync(map, size, MS_[A]SYNC) before munmap makes no
> >> difference.  2.4.19-pre10 has no obvious fixes for this problem.
> 
> >What do the standards say?
> >
> >http://www.opengroup.org/onlinepubs/007904975/functions/mmap.html
> >
> >     The st_ctime and st_mtime fields of a file that is mapped with MAP_SHARED
> >     and PROT_WRITE shall be marked for update at some point in the interval
> >     between a write reference to the mapped region and the next call to msync() with
> >     MS_ASYNC or MS_SYNC for that portion of the file by any process. If there is
> >     no such call and if the underlying file is modified as a result of a write reference,
> >     then these fields shall be marked for update at some time after the write reference.
> 
> That says nothing about a file where the only updates are via mmap.  My
> file had grown to its final size so there were no more writes, only
> pages being dirtied via mmap.

It is specifically referring to updates via mmap!  "a write reference
to the mapped region".  This is the mmap documentation.

What you want is what the standard says we should do.  And we aren't
doing it.  Your application should perform msync(MS_ASYNC) and the
mtime should be updated.

-
