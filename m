Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWAQFGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWAQFGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 00:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWAQFGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 00:06:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26566 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750719AbWAQFGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 00:06:51 -0500
Date: Mon, 16 Jan 2006 21:06:29 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <20060116165618.GB21064@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0601162104550.21654@schroedinger.engr.sgi.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601160807580.19672@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601161620060.9395@goblin.wat.veritas.com> <200601161751.26991.ak@suse.de>
 <20060116165618.GB21064@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Nick Piggin wrote:

> On Mon, Jan 16, 2006 at 05:51:26PM +0100, Andi Kleen wrote:
> > 
> > I agree with Christoph that the zero page should be ignored - old behaviour
> > was really a bug.
> > 
> 
> Fair enough. It would be nice to have a comment there has Hugh said;
> it is not always clear what PageReserved is intended to test for.

Something like this? Are there still other uses of PageReserved than the 
zero page?


Explain the use of PageReserved in check_pte_range.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15/mm/mempolicy.c
===================================================================
--- linux-2.6.15.orig/mm/mempolicy.c	2006-01-14 10:56:31.000000000 -0800
+++ linux-2.6.15/mm/mempolicy.c	2006-01-16 21:03:03.000000000 -0800
@@ -211,6 +211,17 @@ static int check_pte_range(struct vm_are
 		page = vm_normal_page(vma, addr, *pte);
 		if (!page)
 			continue;
+		/*
+		 * The check for PageReserved here is important to avoid
+		 * handling zero pages and other pages that may have been
+		 * marked special by the system.
+		 *
+		 * If the PageReserved would not be checked here then f.e.
+		 * the location of the zero page could have an influence
+		 * on MPOL_MF_STRICT, zero pages would be counted for
+		 * the per node stats, and there would be useless attempts
+		 * to put zero pages on the migration list.
+		 */
 		if (PageReserved(page))
 			continue;
 		nid = page_to_nid(page);

