Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSH0JSD>; Tue, 27 Aug 2002 05:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSH0JSC>; Tue, 27 Aug 2002 05:18:02 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:13311 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S315445AbSH0JSC>; Tue, 27 Aug 2002 05:18:02 -0400
Message-ID: <20020827092219.27495.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Tue, 27 Aug 2002 11:22:19 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@arcor.de>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <E17jKlX-0001i0-00@starship> <20020826152950.9929.qmail@thales.mathematik.uni-ulm.de> <E17jO6g-0002XU-00@starship> <3D6A8082.3775C5AB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6A8082.3775C5AB@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 12:24:50PM -0700, Andrew Morton wrote:
> The flaw is in doing the put_page_testzero() outside of any locking
> which would prevent other CPUs from finding and "rescuing" the zero-recount
> page.
> 
> CPUA:
> 	if (put_page_testzero()) {
> 		/* Here's the window */
> 		spin_lock(lru_lock);
> 		list_del(page->lru);
> 
> CPUB:
> 
> 	spin_lock(lru_lock);
> 	page = list_entry(lru);
> 	page_cache_get(page);	/* If this goes from 0->1, we die */
> 	...
> 	page_cache_release(page);	/* double free */

So what we want CPUB do instead is

	spin_lock(lru_lock);
	page = list_entry(lru)

	START ATOMIC 
		page_cache_get(page);
		res = (page_count (page) == 1)
	END ATOMIC

	if (res) {
		atomic_dec (&page->count);
		continue;  /* with next page */
	}
	...
	page_cache_release (page);

I.e. we want to detect _atomically_ that we just raised the page count
from zero to one. My patch actually has a solution that implements the
needed atomic operation above by means of the atomic functions that we
currently have on all archs (it's called get_page_testzero and
should probably called get_page_testone).
The more I think about this the more I think this is the way to go.

      regards   Christian

-- 
THAT'S ALL FOLKS!
