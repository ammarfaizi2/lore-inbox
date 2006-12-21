Return-Path: <linux-kernel-owner+w=401wt.eu-S1161110AbWLUBV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWLUBV5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWLUBV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:21:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46894 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161110AbWLUBV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:21:56 -0500
Date: Thu, 21 Dec 2006 12:20:39 +1100
From: David Chinner <dgc@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Chinner <dgc@sgi.com>, Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061221012039.GD44411608@melbourne.sgi.com>
References: <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com> <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com> <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org> <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <20061220232401.GB44411608@melbourne.sgi.com> <Pine.LNX.4.64.0612201543540.3576@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612201543540.3576@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 03:55:25PM -0800, Linus Torvalds wrote:
> On Thu, 21 Dec 2006, David Chinner wrote:
> > 
> > XFS appears to call clear_page_dirty to get the mapping tree dirty
> > tag set correctly at the same time the page dirty flag is cleared. I
> > note that this can be done by set_page_writeback() if we clear the
> > dirty flag on the page first when we are writing back the entire page.
> 
> Yes. I think the XFS routine should just use "clear_page_dirty_fir_io()", 
> since that matches what it actually wants to do (surprise surprise, it's 
> going to write it out).

Yup ;)

> HOWEVER. Why is it conditional? Can somebody who understands XFS tell me 
> why "clear_dirty" would ever be 0? I can grep the sources, and I see that 
> it's an unconditional 1 in one call-site, but then in the other one it 
> does
> 
> 	xfs_start_page_writeback(page, wbc, !page_dirty, count);

page dirty starts at the number of dirty buffers on the page, and as
we map each dirty buffer into the I/O we decrement the page dirty count.

Hence if we map all of the buffers into the I/O, we are cleaning
the entire page and hence we can clear the dirty state on the page.

> and that part just blows my mind. Why would you do a 
> xfs_start_page_writeback() and _not_ write the page out? Is this for a 
> partial-page-only case?

Yes, partial-page-only case when doing speculative write clustering. We'll hit
this when an extent boundary is not page aligned (fs block size < page size
case) and we need to issue at least two separate I/Os to clean the page.
Because we leave the page dirty and we are working ahead of the index in
generic_writepages() we'll get the rest of the page flushed when we return
back to generic_writepages() as the page is still dirty in the mapping
tree....

> Anyway, your patch looks fine. It seems to be the right thing to do.

Ok, thanks, Linus.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
