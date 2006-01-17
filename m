Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWAQLQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWAQLQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 06:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWAQLQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 06:16:17 -0500
Received: from mx1.suse.de ([195.135.220.2]:47306 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932396AbWAQLQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 06:16:16 -0500
Date: Tue, 17 Jan 2006 12:16:10 +0100
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Nick Piggin <npiggin@suse.de>, Andi Kleen <ak@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
Message-ID: <20060117111609.GA24083@wotan.suse.de>
References: <20060114155517.GA30543@wotan.suse.de> <Pine.LNX.4.62.0601160807580.19672@schroedinger.engr.sgi.com> <Pine.LNX.4.61.0601161620060.9395@goblin.wat.veritas.com> <200601161751.26991.ak@suse.de> <20060116165618.GB21064@wotan.suse.de> <Pine.LNX.4.62.0601162104550.21654@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601162104550.21654@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 09:06:29PM -0800, Christoph Lameter wrote:
> On Mon, 16 Jan 2006, Nick Piggin wrote:
> 
> > On Mon, Jan 16, 2006 at 05:51:26PM +0100, Andi Kleen wrote:
> > > 
> > > I agree with Christoph that the zero page should be ignored - old behaviour
> > > was really a bug.
> > > 
> > 
> > Fair enough. It would be nice to have a comment there has Hugh said;
> > it is not always clear what PageReserved is intended to test for.
> 
> Something like this? Are there still other uses of PageReserved than the 
> zero page?
> 

Yes something like that would be good.
There are other users of PageReserved, drivers, memory holes,
kernel text, bootmem allocated memory (I think), ZERO_PAGE.


> 
> Explain the use of PageReserved in check_pte_range.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.15/mm/mempolicy.c
> ===================================================================
> --- linux-2.6.15.orig/mm/mempolicy.c	2006-01-14 10:56:31.000000000 -0800
> +++ linux-2.6.15/mm/mempolicy.c	2006-01-16 21:03:03.000000000 -0800
> @@ -211,6 +211,17 @@ static int check_pte_range(struct vm_are
>  		page = vm_normal_page(vma, addr, *pte);
>  		if (!page)
>  			continue;
> +		/*
> +		 * The check for PageReserved here is important to avoid
> +		 * handling zero pages and other pages that may have been
> +		 * marked special by the system.
> +		 *
> +		 * If the PageReserved would not be checked here then f.e.
> +		 * the location of the zero page could have an influence
> +		 * on MPOL_MF_STRICT, zero pages would be counted for
> +		 * the per node stats, and there would be useless attempts
> +		 * to put zero pages on the migration list.
> +		 */
>  		if (PageReserved(page))
>  			continue;
>  		nid = page_to_nid(page);
