Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUEHWpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUEHWpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUEHWpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:45:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5895 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264213AbUEHWpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:45:34 -0400
Date: Sat, 8 May 2004 23:45:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 24 pte_young first
Message-ID: <20040508234529.B20560@flint.arm.linux.org.uk>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040508232239.B12293@infradead.org> <Pine.LNX.4.44.0405082332590.26651-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0405082332590.26651-100000@localhost.localdomain>; from hugh@veritas.com on Sat, May 08, 2004 at 11:39:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 11:39:32PM +0100, Hugh Dickins wrote:
> rmap 25 of course
> 
> On Sat, 8 May 2004, Christoph Hellwig wrote:
> > On Sat, May 08, 2004 at 10:56:26PM +0100, Hugh Dickins wrote:
> > >  
> > > -	if (ptep_test_and_clear_young(pte))
> > > +	if (pte_young(*pte) && ptep_test_and_clear_young(pte))
> > 
> > stupid question - shouldn't the pte_young check simply move to
> > the beginning of ptep_test_and_clear_young?
> 
> I don't think that would be a good idea.  We're used to those
> test_and_clear operations being atomic, putting an initial non-atomic
> test inside would make it fundamentally non-atomic.  We know here that
> it's not the end of the world if we miss a racing transition of the
> young bit, but it wouldn't be good to hide and force that on others.

EAGAIN.

include/asm-generic/pgtable.h:

#ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
static inline int ptep_test_and_clear_young(pte_t *ptep)
{
        pte_t pte = *ptep;
        if (!pte_young(pte))
                return 0;
        set_pte(ptep, pte_mkold(pte));
        return 1;
}
#endif


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
