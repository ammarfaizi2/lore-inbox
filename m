Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWAQSqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWAQSqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWAQSqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:46:34 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:57517 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932352AbWAQSqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:46:33 -0500
Subject: Re: Race in new page migration code?
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Reply-To: lee.schermerhorn@hp.com
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.62.0601170926440.24552@schroedinger.engr.sgi.com>
References: <20060114155517.GA30543@wotan.suse.de>
	 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
	 <20060114181949.GA27382@wotan.suse.de>
	 <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com>
	 <Pine.LNX.4.62.0601152251080.17034@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.61.0601161143190.7123@goblin.wat.veritas.com>
	 <Pine.LNX.4.62.0601170926440.24552@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: LOSL, Nashua
Date: Tue, 17 Jan 2006 13:46:11 -0500
Message-Id: <1137523571.5245.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 09:29 -0800, Christoph Lameter wrote:
> On Mon, 16 Jan 2006, Hugh Dickins wrote:
> 
> > Hmm, that battery of unusual tests at the start of migrate_page_add
> > is odd: the tests don't quite match the comment, and it isn't clear
> > what reasoning lies behind the comment anyway.
> 
> Here is patch to clarify the test. I'd be glad if someone could make
> the tests more accurate. This ultimately comes down to a concept of
> ownership of page by a process / mm_struct that we have to approximate.
> 
> ===
> 
> Explain the complicated check in migrate_page_add by putting the logic
> into a separate function migration_check. This way any enhancements can
> be easily added.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.15/mm/mempolicy.c
> ===================================================================
> --- linux-2.6.15.orig/mm/mempolicy.c	2006-01-14 10:56:28.000000000 -0800
> +++ linux-2.6.15/mm/mempolicy.c	2006-01-17 09:24:20.000000000 -0800
> @@ -551,6 +551,37 @@ out:
>  	return rc;
>  }
>  
> +static inline int migration_check(struct mm_struct *mm, struct page *page)
> +{
> +	/*
> +	 * If the page has no mapping then we do not track reverse mappings.
> +	 * Thus the page is not mapped by other mms, so its safe to move.
> +	 */
> +	if (page->mapping)
should this be "if (!page->mapping)" ???
> +		return 1;
> +

<snip>
> -	if ((flags & MPOL_MF_MOVE_ALL) || !page->mapping || PageAnon(page) ||
like here ......................................^^^^^^^^^^^^^^
> -	    mapping_writably_mapped(page->mapping) ||
> -	    single_mm_mapping(vma->vm_mm, page->mapping))
> +	if ((flags & MPOL_MF_MOVE_ALL) || migration_check(vma->vm_mm, page))
>  		if (isolate_lru_page(page) == 1)
>  			list_add(&page->lru, pagelist);
>  }

Lee

