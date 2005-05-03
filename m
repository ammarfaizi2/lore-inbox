Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVECL5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVECL5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 07:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVECL5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 07:57:53 -0400
Received: from [80.71.243.242] ([80.71.243.242]:27778 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261498AbVECL5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 07:57:49 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17015.26421.403622.767581@gargle.gargle.HOWL>
Date: Tue, 3 May 2005 15:57:41 +0400
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] cleanup of use-once
Newsgroups: gmane.linux.kernel.mm,gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.61.0505030037100.27756@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0505030037100.27756@chimarrao.boston.redhat.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
 > The special cases in the use-once code have annoyed me for a while,
 > and I'd like to see if replacing them with something simpler could
 > be worthwhile.
 > 
 > I haven't actually benchmarked (or even tested) this code yet, but
 > the basic idea is that we want to ignore multiple references to the
 > same page if they happen really close to each other, and only keep
 > a page on the active list if it got accessed again on a time scale
 > that matters to the pageout code.  In other words, filtering out
 > correlated references in a simpler way.
 > 
 > Opinions ?

[...]

 > - * active,unreferenced		->	active,referenced
 >   */
 >  void fastcall mark_page_accessed(struct page *page)
 >  {
 > -	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
 > -		activate_page(page);
 > -		ClearPageReferenced(page);
 > -	} else if (!PageReferenced(page)) {
 > +	if (!PageReferenced(page))
 >  		SetPageReferenced(page);
 > -	}
 >  }

So file system pages never get to the active list? Hmm... this doesn't
sound right.

 >  
 >  EXPORT_SYMBOL(mark_page_accessed);
 > @@ -157,6 +149,7 @@ void fastcall lru_cache_add_active(struc
 >  	if (!pagevec_add(pvec, page))

[...]

 >  			goto keep_locked;
 >  
 >  		referenced = page_referenced(page, 1, sc->priority <= 0);
 > -		/* In active use or really unfreeable?  Activate it. */
 > -		if (referenced && page_mapping_inuse(page))
 > +
 > +		if (referenced) {
 > +			/* New page. Let's see if it'll get used again... */
 > +			if (TestClearPageNew(page))
 > +				goto keep_locked;
 >  			goto activate_locked;
 > +		}

This will screw scanning most likely: no referenced page is ever
reclaimed unless lowest scanning priority is reached---this looks like
sure way to oom and has capacity to increase CPU consumption
significantly.

 >  
 >  #ifdef CONFIG_SWAP

Nikita.
