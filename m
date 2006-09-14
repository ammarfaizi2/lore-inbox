Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWINI7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWINI7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWINI7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:59:20 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:8828 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751485AbWINI7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:59:19 -0400
Subject: Re: [patch 5/9] Guest page hinting: mlocked pages.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <4508AEB9.4080409@vmware.com>
References: <20060901111022.GF15684@skybase>  <4508AEB9.4080409@vmware.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 14 Sep 2006 10:59:15 +0200
Message-Id: <1158224355.18478.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 18:22 -0700, Zachary Amsden wrote:
> Martin Schwidefsky wrote:
> > diff -urpN linux-2.6/mm/memory.c linux-2.6-patched/mm/memory.c
> > --- linux-2.6/mm/memory.c	2006-09-01 12:50:24.000000000 +0200
> > +++ linux-2.6-patched/mm/memory.c	2006-09-01 12:50:24.000000000 +0200
> > @@ -2523,6 +2523,31 @@ int make_pages_present(unsigned long add
> >  	BUG_ON(addr >= end);
> >  	BUG_ON(end > vma->vm_end);
> >  	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
> > +
> > +	if (page_host_discards() && (vma->vm_flags & VM_LOCKED)) {
> > +		int rlen = len;
> > +		ret = 0;
> > +		while (rlen > 0) {
> > +			struct page *page_refs[32];
> > +			int chunk, cret, i;
> > +
> > +			chunk = rlen < 32 ? rlen : 32;
> > +			cret = get_user_pages(current, current->mm, addr,
> > +					      chunk, write, 0,
> > +					      page_refs, NULL);
> > +			if (cret > 0) {
> > +				for (i = 0; i < cret; i++)
> > +					page_cache_release(page_refs[i]);
> > +				ret += cret;
> > +			}
> > +			if (cret < chunk)
> > +				return ret ? : cret;
> > +			addr += 32*PAGE_SIZE;
> > +			rlen -= 32;
> > +		}
> > +		return ret == len ? 0 : -1;
> > +	}
> > +
> >  	ret = get_user_pages(current, current->mm, addr,
> >  			len, write, 0, NULL, NULL);
> >  	if (ret < 0)
> >   
> 
> This seems like a bit of unneeded complexity.  Since you've already 
> changed get_user_pages, why not add a follow flag to release the page 
> cache, and simply pass it to get_user_pages, instead of trying to fetch 
> the page list back.  In particular, write and force arguments to 
> get_user_pages look very ripe for combining into a flags field.  Sure, 
> get_user_pages now has a bit more work to do, but it is already a 
> monster, and I think it would keep make_page_present much cleaner.

That makes sense. If we combine write and force the additional flag we
need won't hurt. I'll add this to my to-do list.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


