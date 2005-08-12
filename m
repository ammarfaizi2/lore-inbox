Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVHLRfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVHLRfR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVHLRfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:35:17 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:15622 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1750750AbVHLRfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:35:16 -0400
Date: Fri, 12 Aug 2005 13:05:14 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/3] uml: share page bits handling between 2 and 3 level pagetables
Message-ID: <20050812170514.GB7448@ccure.user-mode-linux.org>
References: <20050728185655.9C6ADA3@zion.home.lan> <20050730160218.GB4585@ccure.user-mode-linux.org> <200508102137.28414.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508102137.28414.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 09:37:28PM +0200, Blaisorblade wrote:
> Just noticed: you can drop them (except the first, which is a nice cleanup).
> 
> set_pte handles that, and include/asm-generic/pgtable.h uses coherently 
> set_pte_at. I've checked UML by examining "grep pte", and either mk_pte or 
> set_pte are used.
> 
> Exceptions: fixaddr_user_init (but that should be ok as we shouldn't map it 
> actually), pte_modify() (which handles that only for present pages).
> 
> But pte_modify is used with set_pte, so probably we could as well drop that 
> handling.
> 
> Also look, on the "set_pte" theme, at the attached patch. I realized this when 
> I needed those lines to work - I was getting a segfault loop.

OK, this sounds right.  To recap, we were concerned that when the page
scanner went around clearing dirty (accessed) bits, that
fix_range_common wasn't write (read) protecting the page in order to
emulate the cleared bits.

However, set_pte does set _PAGE_NEWPAGE, which forces the page through
a full update, including dirty/accessed bit emulation.

Correct?

However, I did add some parenthesis to your patch:

	WARN_ON(!pte_young(*pte) || (pte_write(*pte) && !pte_dirty(*pte)));

This seems clearer to me.

So, your pte consolidation patch is still in my tree, the other two
pte patches are dropped.

> After using set_pte(), things worked. I have now an almost perfectly working 
> implementation of remap_file_pages with protection support.
> There will probably be some other things to update, like swapping locations, 
> but I can't get this kernel to fail (it's easier to find bugs in the 
> test-program, it grew quite complex).

Excellent.

> I'm going to clean up the code and write changelogs, to send then the patches 
> for -mm (hoping the page fault scalability patches don't get in the
> way).

Good.

				Jeff
