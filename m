Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263231AbTCNDRX>; Thu, 13 Mar 2003 22:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbTCNDRX>; Thu, 13 Mar 2003 22:17:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:46825 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263231AbTCNDRV>;
	Thu, 13 Mar 2003 22:17:21 -0500
Date: Thu, 13 Mar 2003 19:28:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: jeremy@goop.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030313192809.17301709.akpm@digeo.com>
In-Reply-To: <1047611104.14782.5410.camel@spc1.mesatop.com>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<1047572586.1281.1.camel@ixodes.goop.org>
	<20030313113448.595c6119.akpm@digeo.com>
	<1047611104.14782.5410.camel@spc1.mesatop.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 03:28:02.0755 (UTC) FILETIME=[B8368130:01C2E9D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> On Thu, 2003-03-13 at 12:34, Andrew Morton wrote:
> > Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> > >
> > > On Thu, 2003-03-13 at 03:26, Andrew Morton wrote:
> > > >   This means that when an executable is first mapped in, the kernel will
> > > >   slurp the whole thing off disk in one hit.  Some IO changes were made to
> > > >   speed this up.
> > > 
> > > Does this just pull in text and data, or will it pull any debug sections
> > > too?  That could fill memory with a lot of useless junk.
> > > 
> > 
> > Just text, I expect.  Unless glibc is mapping debug info with PROT_EXEC ;)
> > 
> > It's just a fun hack.  Should be done in glibc.
> 
> Well, fun hack or glibc to-do list candidate, I hope it doesn't get
> forgotten.

I have to pull the odd party trick to get people to test -mm kernels.

> I am happy to confirm that it did speed up the initial
> launch time of Open Office from 20 seconds (2.5-bk) to 11 seconds (-mm6)
> and Mozilla from 10 seconds (2.5-bk) to 6 seconds (-mm6).

OK, thanks for confirming that.  Both these apps are *very* compute-intensive
at startup.  Try starting them when everything is in cache...  The
proportional benefits for saner apps wil be larger.

As for glibc, yup, the two-liner which I mentioned is a good start.  Finer
tuning would involve looking at the data segments, dlopen(), etc.  A fun
project.

One subtlety: the linker (ld) lays files out very poorly.  So the prefaulting
trick will not help much when run against an executable which was written by
ld.  But if you've copied it into /bin (make install) then it will work well.
That's something to watch out for.


Doing it in madvise may work better actually.  madvise will pull the pages
into pagecache and leave them on the inactive list.  A subsequent minor fault
will activate the pages.  So the unneeded pages get thrown away quickly. 
Which is exactly what we want.

However -mm6 actually maps all the pages into the process's pagetables at
mmap() time.  That saves the cost of thousands of minor pagefaults, but it
means that the pages which we didn't really want will take longer to be
reclaimed.

