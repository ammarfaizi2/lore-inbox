Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTLZJeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 04:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbTLZJeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 04:34:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45574 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265144AbTLZJeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 04:34:01 -0500
Date: Fri, 26 Dec 2003 09:33:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: Page aging broken in 2.6
Message-ID: <20031226093356.A8980@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, riel@surriel.com
References: <1072423739.15458.62.camel@gaston> <20031225234023.20396cbc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031225234023.20396cbc.akpm@osdl.org>; from akpm@osdl.org on Thu, Dec 25, 2003 at 11:40:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 11:40:23PM -0800, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > And we never flush the TLB entry. 
> > 
> > I don't know if x86 (or other archs really using page tables) will
> > actually set the referenced bit again in the PTE if it's already set
> > in the TLB, if not, then x86 needs a flush too.
> 
> x86 needs a flush_tlb_page(), yes.
> 
> > ppc and ppc64 need a flush to evict the entry from the hash table or
> > we'll never set the _PAGE_ACCESSED bit anymore.

ARM would strictly need the flush as well.  I seem to vaguely remember,
however, that when this code went in there was some discussion about
this very topic, and it was decided that the flush was not critical.

Indeed, 2.4 seems to have the same logic concerning not flushing the
PTE:

        /* Don't look at this pte if it's been accessed recently. */
        if ((vma->vm_flags & VM_LOCKED) || ptep_test_and_clear_young(page_table)) {
                mark_page_accessed(page);
                return 0;
        }


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
