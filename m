Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWASRyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWASRyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWASRyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:54:12 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:58507 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751394AbWASRyL (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Thu, 19 Jan 2006 12:54:11 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17359.53508.481749.294382@gargle.gargle.HOWL>
Date: Thu, 19 Jan 2006 20:48:52 +0300
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       David Miller <davem@davemloft.net>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 2/4] mm: PageLRU no testset
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.mm
In-Reply-To: <20060118024128.10241.82524.sendpatchset@linux.site>
References: <20060118024106.10241.69438.sendpatchset@linux.site>
	<20060118024128.10241.82524.sendpatchset@linux.site>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:
 > PG_lru is protected by zone->lru_lock. It does not need TestSet/TestClear
 > operations.
 > 
 > Signed-off-by: Nick Piggin <npiggin@suse.de>
 > 
 > Index: linux-2.6/mm/vmscan.c
 > ===================================================================
 > --- linux-2.6.orig/mm/vmscan.c
 > +++ linux-2.6/mm/vmscan.c
 > @@ -775,9 +775,10 @@ int isolate_lru_page(struct page *page)
 >  	if (PageLRU(page)) {
 >  		struct zone *zone = page_zone(page);
 >  		spin_lock_irq(&zone->lru_lock);
 > -		if (TestClearPageLRU(page)) {
 > +		if (PageLRU(page)) {
 >  			ret = 1;
 >  			get_page(page);
 > +			ClearPageLRU(page);

Why is that better? ClearPageLRU() is also "atomic" operation (in the
sense of using LOCK_PREFIX on x86), so it seems this change strictly
adds cycles to the hot-path when page is on LRU.

Nikita.
