Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVF2Q4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVF2Q4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVF2Q4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:56:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:27589 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262606AbVF2QxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:53:08 -0400
Date: Wed, 29 Jun 2005 18:53:07 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Robert Love <rml@novell.com>
Cc: adi@hexapodia.org, samuel.thibault@ens-lyon.org,
       linux-kernel@vger.kernel.org, mtk-lists@gmx.net,
       jamie Lokier <jamie@shareable.org>
MIME-Version: 1.0
References: <1119986623.6745.10.camel@betsy>
Subject: =?ISO-8859-1?Q?Re:_wrong_madvise(MADV_DONTNEED)_semantic?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <8493.1120063987@www35.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I contest your interpretation of the manpage; while it could be read
> > the way you suggest, I claim that because Linux mmap is inherently
> > coherent (as opposed to, for example, AIX 4.1 mmap) then the 
> > "underlying
> > file" already contains the updated contents, and ergo msync is not
> > required for correct MAP_SHARED semantics on Linux, and the manpage as
> > it stands is (misleading, but) both accurate to the 2.6.11
> > implementation and compliant with the POSIX description posted earlier.
> 
> Well, there is nothing guaranteeing (either in the Linux implementation
> or the code) that the in-memory changes are synced back to disk.  You
> have to call msyc().
> 
> > > if the file is mapped writable and not mysnc'ed
> > 
> > This is the case that my posted example code exercises, and I did not
> > see any problems.  Is there some additional circumstance that is
> > necessary to cause it to break?  (I tested on 2.6.11-rc5 or something
> > close to that.)
> 
> Yah, I am not--at all--talking about actual behavior.  Just that the
> wording definitely says, its kind of been a common belief, that
> MADV_DONTNEED literally ditches your data.  If you need it, don't call
> MADV_DONTNEED.
> 
> > > or if the memory mapping is anonymous.
> > >
> > > In the latter case, the data is dropped and the pages are
> > > zero-filled on access.
> > 
> > Yes, MAP_ANONYMOUS is a more interesting case.  Somebody else will have
> > to write the testcase for that...
> 
> It would have to discard the pages, losing the data, unless it caused
> swapout (let's hope not).
> 
> > I think the correct docs fix is to simply delete the misleading parts 
> > of
> > madvise.2 so that it reads
> > 
> >         MADV_DONTNEED
> >  	      Do not expect access in the near future.  (For the time
> >  	      being, the application is finished with the given range,
> >  	      so the kernel can free resources associated with it.)
> > 
> > and remove the erroneous parenthetical in the first paragraph.
> > 
> > .. unless, of course, someone can actually demonstrate a case where
> > madvise results in differing semantics...
> 
> Nod.

Well, as far as I last knew Linux MADV_DONTNEED is indeed 
destructive, and not POSIX.1-2001 conformant.

> I think we need to resolve the differences between the man pages,
> comments, expected user behavior, kernel implementation, POSIX standard,
> and what other OS's do.  Figure out what to do, then unify everything.

First of all, I'm always happy to receive man page patches 
at mtk-manpages@gmx.net.

My understanding of Linux MADV_DONTNEED is that it differs 
from POSIX and from *some* other Unix implementations. 

For Linux: 

For a MAP_PRIVATE region, the mapped pages are explicitly 
discarded, so that modifications to the pages are lost.  The 
next access results in a page fault re-initializing either 
with the contents of the underlying mapped file, or, in the 
case of an anonymous mapping, with 0.  (A while ago, I
verified this behaviour using a test program.)
 
For a MAP_SHARED region, the kernel may discard modified 
pages, depending on the architecture.  (I seem to recall 
getting this information about architecture variation from 
an email conversation with Jamie Lokier; I haven't 
verified it.  On x86 at least, I haven't seen an pages
discarded for MADV_DONTNEED on a MAP_SHARED region.)  

On some some other Unix implementations, MADV_DONTNEED 
simply informs the kernel that the specified pages can be 
swapped out if necessary.  (i.e., MADV_DONTNEED on those 
implementations is non-destructive.)

I realise that the current Linux madvise(2) manual page 
doesn't go into quite the above level of detail.  If 
someone wants to confirm or improve the above, I'm happy 
to update the man page.

Cheers,

Michael

-- 
Weitersagen: GMX DSL-Flatrates mit Tempo-Garantie!
Ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl
