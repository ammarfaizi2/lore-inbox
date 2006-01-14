Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWANSTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWANSTv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWANSTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:19:51 -0500
Received: from cantor2.suse.de ([195.135.220.15]:27836 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750747AbWANSTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:19:51 -0500
Date: Sat, 14 Jan 2006 19:19:49 +0100
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
Message-ID: <20060114181949.GA27382@wotan.suse.de>
References: <20060114155517.GA30543@wotan.suse.de> <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 10:01:43AM -0800, Christoph Lameter wrote:
> On Sat, 14 Jan 2006, Nick Piggin wrote:
> 
> > I'm fairly sure there is a race in the page migration code
> > due to your not taking a reference on the page. Taking the
> > reference also can make things less convoluted.
> 
> We take that reference count on the page:
> 

Yes, after you have dropped all your claims to pin this page
(ie. pte lock). You really can't take a refcount on a page that
you haven't somehow pinned (only I can ;)). This get_page_testone
code used by reclaim is a tricky special case where the page is
pinned by lru_lock even if it is "free" (ie. zero refcount).

It is not something that you can use without being very careful.
And I don't understand why you would want to even if it did work,
after you take a look at the simplicity of my patch.

> /*
>  * Isolate one page from the LRU lists.
>  *
>  * - zone->lru_lock must be held
>  */
> static inline int __isolate_lru_page(struct page *page)
> {
>         if (unlikely(!TestClearPageLRU(page)))
>                 return 0;
> 
> >>>>        if (get_page_testone(page)) {
>                 /*
>                  * It is being freed elsewhere
>                  */
>                 __put_page(page);
>                 SetPageLRU(page);
>                 return -ENOENT;
>         }
> 
>         return 1;
> }
> 

By this stage the page may have been freed, and reused by an
unrelated pagecache on the LRU. I'm not sure if there are any
worse races than this (ie. random page being moved), but I
wouldn't like to risk it.

>  
> > Also, an unsuccessful isolation attempt does not mean something is
> > wrong. I removed the WARN_ON, but you should probably be retrying
> > on this level if you are really interested in migrating all pages.
> 
> It depends what you mean by unsuccessful isolate attempt. One reason for 
> not being successful is that the page has been freed. Thats okay.
> 
> The other is that the page is not on the LRU, and is not being moved
> back to the LRU by draining the lru caches. In that case we need to
> have a WARN_ON at least for now. There may be other reasons that a page
> is not on the LRU but I would like to be careful about that at first.
> 
> Its not an error but something that is of concern thus WARN_ON.

kswapd picks them off the lru as normal part of scanning. A
WARN_ON is simply spam.

Nick

