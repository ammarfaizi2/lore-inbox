Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVF1SyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVF1SyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVF1SyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:54:05 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:12213 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S261253AbVF1SxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:53:01 -0400
Date: Tue, 28 Jun 2005 11:53:00 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Robert Love <rml@novell.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628185300.GB30079@hexapodia.org>
References: <20050628134316.GS5044@implementation.labri.fr> <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119983300.6745.1.camel@betsy>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 02:28:20PM -0400, Robert Love wrote:
> On Tue, 2005-06-28 at 11:16 -0700, Andy Isaacson wrote:
> > Besides, if you read the documentation closely, it does not say what you
> > think it says.
> > 
> >        MADV_DONTNEED
> > 	      Do not expect access in the near future.  (For the time
> > 	      being, the application is finished with the given range,
> > 	      so the kernel can free resources associated with it.)
> > 	      Subsequent accesses of pages in this range will succeed,
> > 	      but will result either in reloading of the memory contents
> > 	      from the underlying mapped file (see mmap) or
> > 	      zero-fill-on-demand pages for mappings without an
> > 	      underlying file.
> > 
> > You seem to think that "reloading ... from the underlying mapped file"
> > means that changes are lost, but that's not implied.
> 
> This wording _does_ imply that changes are lost

I contest your interpretation of the manpage; while it could be read
the way you suggest, I claim that because Linux mmap is inherently
coherent (as opposed to, for example, AIX 4.1 mmap) then the "underlying
file" already contains the updated contents, and ergo msync is not
required for correct MAP_SHARED semantics on Linux, and the manpage as
it stands is (misleading, but) both accurate to the 2.6.11
implementation and compliant with the POSIX description posted earlier.

> if the file is mapped writable and not mysnc'ed

This is the case that my posted example code exercises, and I did not
see any problems.  Is there some additional circumstance that is
necessary to cause it to break?  (I tested on 2.6.11-rc5 or something
close to that.)

> or if the memory mapping is anonymous.
>
> In the latter case, the data is dropped and the pages are
> zero-filled on access.

Yes, MAP_ANONYMOUS is a more interesting case.  Somebody else will have
to write the testcase for that...

I think the correct docs fix is to simply delete the misleading parts of
madvise.2 so that it reads

        MADV_DONTNEED
 	      Do not expect access in the near future.  (For the time
 	      being, the application is finished with the given range,
 	      so the kernel can free resources associated with it.)

and remove the erroneous parenthetical in the first paragraph.

... unless, of course, someone can actually demonstrate a case where
madvise results in differing semantics...

-andy
