Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264242AbUEHW7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbUEHW7P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUEHW7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:59:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:24808 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264242AbUEHW7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:59:13 -0400
Date: Sat, 8 May 2004 23:59:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 24 pte_young first
In-Reply-To: <20040508234529.B20560@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0405082350420.26698-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2004, Russell King wrote:
> On Sat, May 08, 2004 at 11:39:32PM +0100, Hugh Dickins wrote:
> > On Sat, 8 May 2004, Christoph Hellwig wrote:
> > > 
> > > stupid question - shouldn't the pte_young check simply move to
> > > the beginning of ptep_test_and_clear_young?
> > 
> > I don't think that would be a good idea.  We're used to those
> > test_and_clear operations being atomic, putting an initial non-atomic
> > test inside would make it fundamentally non-atomic.  We know here that
> > it's not the end of the world if we miss a racing transition of the
> > young bit, but it wouldn't be good to hide and force that on others.
> 
> EAGAIN.
> 
> include/asm-generic/pgtable.h:
> 
> #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> static inline int ptep_test_and_clear_young(pte_t *ptep)
> {
>         pte_t pte = *ptep;
>         if (!pte_young(pte))
>                 return 0;
>         set_pte(ptep, pte_mkold(pte));
>         return 1;
> }
> #endif

Hah!  Delightful refutation of my little lecture.  Thanks a lot for
turning that up.  Hmm.  Well, I guess I need to research that one
further: a first guess would be that the generic variety is silly
to be doing an optimization which the specialist versions don't do:
but perhaps when I look I'll find some of them do.  Can scrub that
patch for now if you prefer, Andrew: world won't stop turning either way.

Hugh

