Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVKAI7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVKAI7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVKAI7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:59:50 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:42118 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965003AbVKAI7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:59:49 -0500
Subject: Re: [PATCH 3/5] Swap Migration V5: migrate_pages() function
From: Dave Hansen <haveblue@us.ibm.com>
To: Rob Landley <rob@landley.net>
Cc: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200511010206.24800.rob@landley.net>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
	 <20051101031254.12488.18612.sendpatchset@schroedinger.engr.sgi.com>
	 <200511010206.24800.rob@landley.net>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 09:59:35 +0100
Message-Id: <1130835575.14475.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 02:06 -0600, Rob Landley wrote:
> On Monday 31 October 2005 21:12, Christoph Lameter wrote:
> > Page migration support in vmscan.c
> 
> This has no #ifdef SWAP:
> 
> > + if (PageSwapCache(page)) {
> > +  swp_entry_t swap = { .val = page_private(page) };
> > +  add_to_swapped_list(swap.val);
> > +  __delete_from_swap_cache(page);
> > +  write_unlock_irq(&mapping->tree_lock);
> > +  swap_free(swap);
> > +  __put_page(page); /* The pagecache ref */
> > +  return 1;
> > + }
> 
> But what you removed did:
> 
> > -#ifdef CONFIG_SWAP
> > -  if (PageSwapCache(page)) {
> > -   swp_entry_t swap = { .val = page_private(page) };
> > -   add_to_swapped_list(swap.val);
> > -   __delete_from_swap_cache(page);
> > -   write_unlock_irq(&mapping->tree_lock);
> > -   swap_free(swap);
> > -   __put_page(page); /* The pagecache ref */
> > -   goto free_it;
> > -  }
> > -#endif /* CONFIG_SWAP */
> 
> What happens if you build without swap?

You don't need an explicit #ifdef.

PageSwapCache() has an #ifdef for its declaration which gets it down to
'0'.  That should get gcc to completely kill the if(){} block, with no
explicit #ifdef.  

-- Dave

