Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVJUGGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVJUGGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 02:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVJUGGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 02:06:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:56783 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964880AbVJUGGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 02:06:41 -0400
Subject: Re: [PATCH 1/4] Swap migration V3: LRU operations
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Mike Kravetz <kravetz@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20051020225940.19761.93396.sendpatchset@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	 <20051020225940.19761.93396.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 08:06:02 +0200
Message-Id: <1129874762.26533.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-20 at 15:59 -0700, Christoph Lameter wrote:

> +/*
> + * Isolate one page from the LRU lists.
> + *
> + * - zone->lru_lock must be held
> + *
> + * Result:
> + *  0 = page not on LRU list
> + *  1 = page removed from LRU list
> + * -1 = page is being freed elsewhere.
> + */

Can these return values please get some real names?  I just hate when
things have more than just fail and success as return codes.

It makes much more sense to have something like:

        if (ret == ISOLATION_IMPOSSIBLE) {
        	 list_del(&page->lru);
         	 list_add(&page->lru, src);
        }

than

+               if (rc == -1) {  /* Not possible to isolate */
+                       list_del(&page->lru);
+                       list_add(&page->lru, src);
+                } if 

The comment just makes the code harder to read.

> +static inline int
> +__isolate_lru_page(struct zone *zone, struct page *page)
> +{
> +	if (TestClearPageLRU(page)) {
> +		if (get_page_testone(page)) {
> +			/*
> +			 * It is being freed elsewhere
> +			 */
> +			__put_page(page);
> +			SetPageLRU(page);
> +			return -1;
> +		} else {
> +			if (PageActive(page))
> +				del_page_from_active_list(zone, page);
> +			else
> +				del_page_from_inactive_list(zone, page);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}

How about 

+static inline int 
> +__isolate_lru_page(struct zone *zone, struct page *page)
> +{
	int ret = 0;

	if (!TestClearPageLRU(page))
		return ret;


Then, the rest of the thing doesn't need to be indented.

> +static inline void
> +__putback_lru_page(struct zone *zone, struct page *page)
> +{

__put_back_lru_page?

BTW, it would probably be nice to say where these patches came from
before Magnus. :)

-- Dave

