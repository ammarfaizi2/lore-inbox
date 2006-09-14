Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWINI4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWINI4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWINI4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:56:43 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:14732 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751480AbWINI4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:56:42 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <45084C2E.4060203@vmware.com>
References: <20060901110948.GD15684@skybase>  <45084C2E.4060203@vmware.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 14 Sep 2006 10:56:39 +0200
Message-Id: <1158224199.18478.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 11:21 -0700, Zachary Amsden wrote:
> Martin Schwidefsky wrote:
> > The code added by this patch uses the volatile state for all page cache
> > pages, even for pages which are referenced by writable ptes. The host
> > needs to be able to check the dirty state of the pages. Since the host
> > doesn't know where the page table entries of the guest are located,
> > the volatile state as introduced by this patch is only usable on
> > architectures with per-page dirty bits (s390 only). For per-pte dirty
> > bit architectures some additional code is needed.
> >   
> 
> What do you mean by per-page dirty bits.  Do you mean per-page dirty 
> bits in hardware (s390), in software (Linux), or maintained by the 
> hypervisor?

s390 has something called a storage key. There is one for each page. In
a virtualized system there is one for each virtual page. The dirty and
referenced bit for each page is kept in the storage key and not in the
pte. On s390 the pte has nothing to do with dirty/referenced.
If your hardware allows you to have dirty bits per page instead of per
pte then you can query the dirty bit from the host without needing
access to all the ptes.

> > The interesting question is where to put the state transitions between
> > the volatile and the stable state. The simple solution is the make a
> > page stable whenever a lookup is done or a page reference is derived
> > from a page table entry. Attempts to make pages volatile are added at
> > strategic points. Now what are the conditions that prevent a page from
> > being made volatile? There are 10 conditions:
> > 1) The page is reserved. Some sort of special page.
> > 2) The page is marked dirty in the struct page. The page content is
> >    more recent than the data on the backing device. The host cannot
> >    access the linux internal dirty bit so the page needs to be stable.
> > 3) The page is in writeback. The page content is needed for i/o.
> > 4) The page is locked. Someone has exclusive access to the page.
> >   
> 
> I'll tend to agree from a heuristical performance point of view, but I 
> don't see any reason that a locked page can't be made volatile from a 
> correctness perspective.

Interesting. Usually there is an additional page reference for a locked
page so it probably won't make a difference. I'm not sure if all "users"
of locked pages can deal with volatile pages, I'll have to check.

> > 5) The page is anonymous. Swap cache support needs additional code.
> > 6) The page has no mapping. No backing, the page cannot be recreated.
> > 7) The page is not uptodate.
> > 8) The page has private information. try_to_release_page can fail,
> >    e.g. in case the private information is journaling data. The discard
> >    fault need to be able to remove the page.
> > 9) The page is already discarded.
> > 10) The page map count is not equal to the page reference count - 1.
> >    The discard fault handler can remove the page cache reference and
> >    all mappers of a page. It cannot remove the page reference for any
> >    other user of the page.
> >   
> 
> Does s390 use per physical page permission bits separate from the PTEs?  

Yes.

> Because I don't see how you can generate a discard fault otherwise 
> unless you know where the page table entries of the guest are located, 
> which you already said you don't.  Or perhaps I'm misunderstanding the 
> meaning of discard fault - I'm taking it to mean a fault which happens 
> on access to a volatile page that was discarded by the hypervisor - thus 
> requiring a refresh of all mapping PTEs?

The discard fault happens on access to a volatile that has been
discarded. An important property of the s390 architecture comes into
play here: there are two page tables, a guest page table and a host page
table. What the guest perceives as its "physical" memory is in virtual
storage for the host. An address resolution has to walk two pages
tables, if a pte is invalid in either table you get a fault. A guest
fault if the invalid pte is in the guest table and a host fault if it is
in the host table. That gives s390 a simple method to implement
discarded pages: the hypervisor just unmaps the page from the host table
and changes the state of the guest page. I can see that you will have a
much harder time to implement this on i386.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


