Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263756AbUD0FIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUD0FIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUD0FIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:08:36 -0400
Received: from ozlabs.org ([203.10.76.45]:5094 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263756AbUD0FIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:08:34 -0400
Date: Tue, 27 Apr 2004 15:05:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: apw@shadowen.org, agl@us.ibm.com, mbligh@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-ID: <20040427050503.GH514@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, apw@shadowen.org, agl@us.ibm.com,
	mbligh@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
References: <20040423081856.GJ9243@zax> <20040423013437.1f2b8fc6.akpm@osdl.org> <20040427043652.GF514@zax> <20040426214757.2c7d8ed5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426214757.2c7d8ed5.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 09:47:57PM -0700, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > +		if (put_page_testzero(page))
> >  +			free_huge_page(page);
> 
> Well yes, but this is assuming that compound pages are always hugetlb pages.
> 
> It's true at present, but it doesn't have to always be true.  The cost of
> the destructor is zilch, so why not?

True enough, I guess I was just following the "don't build it till you
need it" philosophy.

> Please review the changes which went into 2.6.6-rc2-mm2.

Sorry, should have done that earlier.  Looks reasonable with two small
exceptions: 1) put_page() can still theoretically call
__page_cache_release() which is wrong (and makes the code misleading)
- patch below replaces this with a BUG() if there is no destructor. 2)
what about wli's concern that mapping may be accessed without first
checking for a PageCompound?

Index: working-2.6/mm/swap.c
===================================================================
--- working-2.6.orig/mm/swap.c	2004-04-14 12:22:49.000000000 +1000
+++ working-2.6/mm/swap.c	2004-04-27 15:02:30.046342392 +1000
@@ -41,11 +41,9 @@
 	if (unlikely(PageCompound(page))) {
 		page = (struct page *)page->private;
 		if (put_page_testzero(page)) {
-			if (page[1].mapping) {	/* destructor? */
-				(*(void (*)(struct page *))page[1].mapping)(page);
-			} else {
-				__page_cache_release(page);
-			}
+			BUG_ON(! page[1].mapping);
+
+			(*(void (*)(struct page *))page[1].mapping)(page);
 		}
 		return;
 	}


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
