Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318117AbSILWZi>; Thu, 12 Sep 2002 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSILWZi>; Thu, 12 Sep 2002 18:25:38 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:14574 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318117AbSILWZh>; Thu, 12 Sep 2002 18:25:37 -0400
Date: Thu, 12 Sep 2002 19:30:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Daniel Phillips <phillips@arcor.de>, <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D811363.70ABB50C@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209121926310.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Andrew Morton wrote:

> Well the lazy invalidation would be OK - defer that to the next
> userspace access,

I think I have an idea on how to do that, here's some pseudocode:

invalidate_page(struct page * page) {
	SetPageInvalidated(page);
	rmap_lock(page);
	for_each_pte(pte, page) {
		make pte PROT_NONE;
		flush TLBs for this virtual address;
	}
	rmap_unlock(page);
}

And in the page fault path:

if (pte_protection(pte) == PROT_NONE && PageInvalidated(pte_page_pte)) {
	clear_pte(ptep);
	page_cache_release(page);
	mm->rss--;
}

What do you think, is this simple enough that it would work ? ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

