Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUCLPFw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUCLPFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:05:52 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:51589 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262169AbUCLPFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:05:34 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16465.53692.106520.847235@laputa.namesys.com>
Date: Fri, 12 Mar 2004 18:05:32 +0300
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
In-Reply-To: <4051C5F1.2050605@cyberone.com.au>
References: <404FACF4.3030601@cyberone.com.au>
	<200403111825.22674@WOLK>
	<40517E47.3010909@cyberone.com.au>
	<20040312012703.69f2bb9b.akpm@osdl.org>
	<pan.2004.03.12.11.08.02.700169@smurf.noris.de>
	<4051B0C6.2070302@cyberone.com.au>
	<4051C5F1.2050605@cyberone.com.au>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:
 > 

[...]

 > 
 > By the way, I would be interested to know the rationale behind
 > mark_page_accessed as it is without this patch, also what is it doing in
 > rmap.c (I know hardly anything actually uses page_test_and_clear_young, but
 > still). It seems to me like it only serves to make VM behaviour harder to
 > understand, but I'm probably missing something. Andrew?

With your patch, once a page got into inactive list, its PG_referenced
bit will only be checked by VM scanner when page wanders to the tail of
list. In particular, if is impossible to tell pages that were accessed
only once while on inactive list from ones that were accessed multiple
times. Original mark_page_accessed() moves page to the active list on
the second access, thus making it less eligible for the reclaim.

I actually tried quite an opposite modification:
(ftp://ftp.namesys.com/pub/misc-patches/unsupported/extra/2004.03.10-2.6.4-rc3/a_1[5678]*)

/* roughly, modulo locking, etc. */
void fastcall mark_page_accessed(struct page *page)
{
		if (!PageReferenced(page))
			SetPageReferenced(page);
		else if (!PageLRU(page))
			continue;
		else if (!PageActive(page)) {
			/* page is on inactive list */
			del_page_from_inactive_list(zone, page);
			SetPageActive(page);
			add_page_to_active_list(zone, page);
			inc_page_state(pgactivate);
			ClearPageReferenced(page);
		} else {
			/* page is on active list, move it to head */
			list_move(&page->lru, &zone->active_list);
			ClearPageReferenced(page);
		}
}

That is, referenced and active page is moved to head of the active
list. While somewhat improving file system performance it badly affects
anonymous memory, because (it seems) file system pages tend to push
mapped ones out of active list. Probably it should have better effect
with your split active lists.

 > 

Nikita.
