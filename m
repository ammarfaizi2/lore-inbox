Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbUDBO1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbUDBO1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:27:32 -0500
Received: from [129.183.4.3] ([129.183.4.3]:12223 "EHLO ecbull20.frec.bull.fr")
	by vger.kernel.org with ESMTP id S264053AbUDBO13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:27:29 -0500
Message-ID: <406D7573.FF5F0B5F@nospam.org>
Date: Fri, 02 Apr 2004 16:15:15 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: To kunmap_atomic or not to kunmap_atomic ?
References: <Pine.LNX.4.44.0404011740190.30126-100000@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Thu, 1 Apr 2004, Zoltan Menyhart wrote:
> > I can see a couple of functions, like
> >
> > static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
> > {
> >       struct page * page = kmap_atomic_to_page(ptep);
> >       return (struct mm_struct *) page->mapping;
> > }
> >
> > in "rmap.?" without invoking "kunmap_atomic()".
> > Is it intentional?
> > What if for an architecture "kunmap_atomic()" is not a no-op ?
> 
> Amusing misunderstanding.  Take a look at kmap_atomic_to_page
> in arch/i386/mm/highmem.c: it doesn't _do_ a kmap_atomic, it
> translates the virtual address already supplied by kmap_atomic
> to the address of the struct page of the physical page backing
> that virtual address.  So, in the case of try_to_unmap_one, it
> operates on the virtual address supplied by rmap_ptep_map
> (which does do a kmap_atomic), and at the end there's an
> rmap_ptep_unmap (which does the rmap_ptep_unmap).
> 
> Hugh

As you have *map* - *unmap* macros / functions, they give a _hint_
that the original intention of the author was to allow some
architectures - which do need some resources to map things -
manage these resources. See:

static inline void *kmap(struct page *page)
#define kunmap(page)

#define kmap_atomic(page, idx)
#define kunmap_atomic(addr, idx)
#define kmap_atomic_to_page(ptr)

I think we cannot guarantee that we will never ever need to
unmap things. As it is required to use kmap - kunmap in pair,
it is quite logic to use kmap_atomic* in pair with kunmap_atomic.

I think it is a bad programming style to abuse the fact that
some macros are no-ops for the most popular architectures.

I think we should have some global counters in DEBUG mode which
are incremented on each call to *map* and decremented on each
*unpap* call, and we can detect, ooops, it leaks...

Regards,

Zoltán Menyhárt
