Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVF1TXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVF1TXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVF1TXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:23:54 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29630 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261355AbVF1TXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:23:40 -0400
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
From: Robert Love <rml@novell.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050628185300.GB30079@hexapodia.org>
References: <20050628134316.GS5044@implementation.labri.fr>
	 <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy>
	 <20050628185300.GB30079@hexapodia.org>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 15:23:43 -0400
Message-Id: <1119986623.6745.10.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 11:53 -0700, Andy Isaacson wrote:

> I contest your interpretation of the manpage; while it could be read
> the way you suggest, I claim that because Linux mmap is inherently
> coherent (as opposed to, for example, AIX 4.1 mmap) then the "underlying
> file" already contains the updated contents, and ergo msync is not
> required for correct MAP_SHARED semantics on Linux, and the manpage as
> it stands is (misleading, but) both accurate to the 2.6.11
> implementation and compliant with the POSIX description posted earlier.

Well, there is nothing guaranteeing (either in the Linux implementation
or the code) that the in-memory changes are synced back to disk.  You
have to call msyc().

> > if the file is mapped writable and not mysnc'ed
> 
> This is the case that my posted example code exercises, and I did not
> see any problems.  Is there some additional circumstance that is
> necessary to cause it to break?  (I tested on 2.6.11-rc5 or something
> close to that.)

Yah, I am not--at all--talking about actual behavior.  Just that the
wording definitely says, its kind of been a common belief, that
MADV_DONTNEED literally ditches your data.  If you need it, don't call
MADV_DONTNEED.

> > or if the memory mapping is anonymous.
> >
> > In the latter case, the data is dropped and the pages are
> > zero-filled on access.
> 
> Yes, MAP_ANONYMOUS is a more interesting case.  Somebody else will have
> to write the testcase for that...

It would have to discard the pages, losing the data, unless it caused
swapout (let's hope not).

> I think the correct docs fix is to simply delete the misleading parts of
> madvise.2 so that it reads
> 
>         MADV_DONTNEED
>  	      Do not expect access in the near future.  (For the time
>  	      being, the application is finished with the given range,
>  	      so the kernel can free resources associated with it.)
> 
> and remove the erroneous parenthetical in the first paragraph.
> 
> .. unless, of course, someone can actually demonstrate a case where
> madvise results in differing semantics...

Nod.

I think we need to resolve the differences between the man pages,
comments, expected user behavior, kernel implementation, POSIX standard,
and what other OS's do.  Figure out what to do, then unify everything.

	Robert Love


