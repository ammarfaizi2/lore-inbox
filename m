Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWJIMIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWJIMIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWJIMIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:08:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:59327 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750978AbWJIMIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:08:14 -0400
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061009115836.GC26824@wotan.suse.de>
References: <20061007134407.6aa4dd26.akpm@osdl.org>
	 <1160351174.14601.3.camel@localhost.localdomain>
	 <20061009102635.GC3487@wotan.suse.de>
	 <1160391014.10229.16.camel@localhost.localdomain>
	 <20061009110007.GA3592@wotan.suse.de>
	 <1160392214.10229.19.camel@localhost.localdomain>
	 <20061009111906.GA26824@wotan.suse.de>
	 <1160393579.10229.24.camel@localhost.localdomain>
	 <20061009114527.GB26824@wotan.suse.de>
	 <1160394571.10229.27.camel@localhost.localdomain>
	 <20061009115836.GC26824@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 22:07:50 +1000
Message-Id: <1160395671.10229.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 13:58 +0200, Nick Piggin wrote:
> On Mon, Oct 09, 2006 at 09:49:31PM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2006-10-09 at 13:45 +0200, Nick Piggin wrote:
> > > On Mon, Oct 09, 2006 at 09:32:59PM +1000, Benjamin Herrenschmidt wrote:
> > > > > 
> > > > > You'll want to clear VM_PFNMAP after unmapping all pages from it, before
> > > > > switching to struct page backing.
> > > > 
> > > > Which means having a list of all vma's ... I suppose I can look at the
> > > > truncate code to do that race free but I was hoping I could avoid it
> > > > (that's the whole point of using unmap_mapping_range() in fact).
> > > 
> > > Yeah I don't think there is any other way to do it.
> > 
> > What is the problem if I always keep VM_PFNMAP set ?
> 
> The VM won't see that you have struct pages backing the ptes, and won't
> do the right refcounting or rmap stuff... But for file backed mappings,
> all the critical rmap stuff should be set up at mmap time, so you might
> have another option to simply always do the nopfn thing, as far as the
> VM is concerned (ie. even when you do have a struct page)

Any reason why it wouldn't work to flip that bit on the first no_page()
after a migration ? A migration always involves destroying all PTEs and
is done with a per-object mutex held that no_page() takes too, so we can
be pretty sure that the first nopage can set that bit before any PTE is
actually inserted in the mapping after all the previous ones have been
invalidated... That would avoid having to walk the vma's.

Ben.


