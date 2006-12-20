Return-Path: <linux-kernel-owner+w=401wt.eu-S1161040AbWLTX4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWLTX4R (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWLTX4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:56:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50015 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161047AbWLTX4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:56:15 -0500
Date: Wed, 20 Dec 2006 15:55:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <20061220153207.b2a0a27f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612201548410.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
 <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org>
 <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
 <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <20061220153207.b2a0a27f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Andrew Morton wrote:
> 
> > +void cancel_dirty_page(struct page *page, unsigned int account_size)
> > +{
> > +	/* If we're cancelling the page, it had better not be mapped any more */
> > +	if (page_mapped(page)) {
> > +		static unsigned int warncount;
> > +
> > +		WARN_ON(++warncount < 5);
> > +	}
> > +		
> > +	if (TestClearPageDirty(page) && account_size)
> > +		task_io_account_cancelled_write(account_size);
> > +}
> 
> This doesn't clear the radix-tree dirty tags.  I'm not sure what effect
> that would have on a truncated mapping.  Perhaps just a bit of extra work
> in radix-tree lookup during writeback.

This should _only_ be a valid thing to do when we're removing the page 
from a mapping anyway, so I'd most definitely hope that the code 
immediately after (or before) will have done a "remove_from_page_cache()"

In which case the tags should not matter.

There is _no_ excuse for cancelling a page and leaving it in the page 
cache that I can see. Because your page contents will be _indeterminate_.

> > @@ -386,12 +399,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
> 
> invalidate_complete_page2() is pretty gruesome.  We're handling the case
> where someone went and redirtied the page (and hence its buffers) after the
> invalidate_inode_pages2() caller (generic_file_direct_IO) synced it to
> disk.
> 
> I'd prefer to just fail the direct-io if someone did that, but then
> people's tests fail and they whine.

So with my change, afaik, we will just return EIO to the invalidate, and 
do the write. Which should be ok. In fact, it appears to be the only 
possibly valid thing to do.

It really boils down to that same thing: if you remove the dirty bit, 
there is NO CONCEIVABLE GOOD THING YOU CAN DO EXCEPT FOR:
 - do the damn IO already ("clear_page_dirty_for_io()")
 - truncate the page (unmap and destroy it both from page cache AND from 
   any user-visible filesystem cases)

Anything else is simpyl a bug. Always has been. My patch just makes that 
very clear.

> With your change I think what'll happen is that we'll correctly handle the
> case where the page and its buffers are dirty (it gets left in place), but
> we'll needlessy fail in the case where the page is dirty but the buffers
> are clean.  How important that will be in practice I do not know.  People
> will get -EIOs where they used not to.

People will now get -EIO where they used to get an inconsistent system 
image. I really think it sounds like an improvement.

		Linus
