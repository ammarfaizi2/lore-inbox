Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUCLP3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUCLP3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:29:25 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:10209 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262176AbUCLP3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:29:12 -0500
Message-ID: <4051D737.1050108@cyberone.com.au>
Date: Sat, 13 Mar 2004 02:28:55 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <404FACF4.3030601@cyberone.com.au>	<200403111825.22674@WOLK>	<40517E47.3010909@cyberone.com.au>	<20040312012703.69f2bb9b.akpm@osdl.org>	<pan.2004.03.12.11.08.02.700169@smurf.noris.de>	<4051B0C6.2070302@cyberone.com.au>	<4051C5F1.2050605@cyberone.com.au> <16465.53692.106520.847235@laputa.namesys.com>
In-Reply-To: <16465.53692.106520.847235@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nikita Danilov wrote:

>Nick Piggin writes:
> > 
>
>[...]
>
> > 
> > By the way, I would be interested to know the rationale behind
> > mark_page_accessed as it is without this patch, also what is it doing in
> > rmap.c (I know hardly anything actually uses page_test_and_clear_young, but
> > still). It seems to me like it only serves to make VM behaviour harder to
> > understand, but I'm probably missing something. Andrew?
>
>With your patch, once a page got into inactive list, its PG_referenced
>bit will only be checked by VM scanner when page wanders to the tail of
>list. In particular, if is impossible to tell pages that were accessed
>only once while on inactive list from ones that were accessed multiple
>times. Original mark_page_accessed() moves page to the active list on
>the second access, thus making it less eligible for the reclaim.
>
>

With my patch though, it gives unmapped pages the same treatment as
mapped pages. Without my patch, pages getting a lot of mark_page_accessed
activity can easily be promoted unfairly past mapped ones which are simply
getting activity through the pte.

I say just set the bit and let the scanner handle it.

>I actually tried quite an opposite modification:
>(ftp://ftp.namesys.com/pub/misc-patches/unsupported/extra/2004.03.10-2.6.4-rc3/a_1[5678]*)
>
>/* roughly, modulo locking, etc. */
>void fastcall mark_page_accessed(struct page *page)
>{
>		if (!PageReferenced(page))
>			SetPageReferenced(page);
>		else if (!PageLRU(page))
>			continue;
>		else if (!PageActive(page)) {
>			/* page is on inactive list */
>			del_page_from_inactive_list(zone, page);
>			SetPageActive(page);
>			add_page_to_active_list(zone, page);
>			inc_page_state(pgactivate);
>			ClearPageReferenced(page);
>		} else {
>			/* page is on active list, move it to head */
>			list_move(&page->lru, &zone->active_list);
>			ClearPageReferenced(page);
>		}
>}
>
>That is, referenced and active page is moved to head of the active
>list. While somewhat improving file system performance it badly affects
>anonymous memory, because (it seems) file system pages tend to push
>mapped ones out of active list. Probably it should have better effect
>with your split active lists.
>

Yeah. Hmm, I think it might be a good idea to do this sorting for
unmapped pages on the active list. It shouldn't do ClearPageReferenced
though, because your !PageReferenced pages now get their referenced
bit set, and next time around the scanner they come in above the
PageReferenced page.

I don't like the inactive->active promotion here though, as I explained.

