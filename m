Return-Path: <linux-kernel-owner+w=401wt.eu-S932641AbWLMKWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWLMKWO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 05:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWLMKWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 05:22:14 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:7807 "EHLO
	amsfep18-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932641AbWLMKWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 05:22:13 -0500
X-Greylist: delayed 1015 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 05:22:12 EST
Subject: Re: [patch 03/13] io-accounting: write accounting
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Suleiman Souhlal <ssouhlal@FreeBSD.org>, linux-kernel@vger.kernel.org,
       balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
In-Reply-To: <20061213005954.e2d32446.akpm@osdl.org>
References: <200612081152.kB8BqQvb019756@shell0.pdx.osdl.net>
	 <457FBDBE.10102@FreeBSD.org>  <20061213005954.e2d32446.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 11:04:54 +0100
Message-Id: <1166004294.32332.93.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 00:59 -0800, Andrew Morton wrote:
> On Wed, 13 Dec 2006 00:45:50 -0800
> Suleiman Souhlal <ssouhlal@FreeBSD.org> wrote:
> 
> > akpm@osdl.org wrote:
> > > From: Andrew Morton <akpm@osdl.org>
> > > 
> > > Accounting writes is fairly simple: whenever a process flips a
> page from clean
> > > to dirty, we accuse it of having caused a write to underlying
> storage of
> > > PAGE_CACHE_SIZE bytes.
> > 
> > On architectures where dirtying a page doesn't cause a page fault
> (like i386), couldn't you end up billing the wrong process (in fact, I
> think that even on other archituctures set_page_dirty() doesn't get
> called immediately in the page fault handler)? 
> 
> Yes, that would be a problem in 2.6.18 and earlier.
> 
> In 2.6.19 and later, we do take a fault when transitioning a page from
> pte-clean to pte-dirty.  That was done to get the dirty-page
> accounting
> right - to avoid the
> all-of-memory-is-dirty-but-the-kernel-doesn't-know-it
> problem.
> 
> 
> > AFAICS, set_page_dirty() is mostly called when trying to unmap a
> page when trying to shrink LRU lists, and there is no guarantee that
> this happens under the process that dirtied it (in fact, the
> set_page_dirty() is often done by kswapd).

we're talking:

  shrink_page_list()
    TestSetPageLock()
    try_to_unmap()
      try_to_unmap_file()
        try_to_unmap_one()
          set_page_dirty()

Which, because its run under the page lock, should always be false,
right? perhaps a WARN_ON might do.

> hm, that code is still there in zap_pte_range().  If all is well, that
> set_page_dirty() call should never return true.  


exit_mmap(), do_unmap()
  unmap_vmas()
    unmap_page_range()
      zap_{pud,pmd,pte}_range()

vmtruncate()
  unmap_mapping_range()
    unmap_mapping_range_*()
      unmap_mapping_range_vma(), madvise_dontneed()
        zap_page_range()
          unmap_vmas()
            unmap_page_range()
              zap_{pud,pmd,pte}_range()

Which is all ran without the page lock, so might be open for a race;
however, I don't see that hurting because the whole page is un-accounted
pretty soon afterwards.

> Peter did, you ever test for that?

Nope

> (Well, it might return true in rare races, because zap_pte_range()
> doesn't lock the pages)



