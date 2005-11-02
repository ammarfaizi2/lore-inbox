Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965299AbVKBWD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbVKBWD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbVKBWD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:03:56 -0500
Received: from gold.veritas.com ([143.127.12.110]:1168 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965294AbVKBWDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:03:55 -0500
Date: Wed, 2 Nov 2005 22:02:49 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <1130967936.20136.65.camel@gaston>
Message-ID: <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au> 
 <4368139A.30701@vc.cvut.cz>  <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
  <1130965454.20136.50.camel@gaston>  <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com>
 <1130967936.20136.65.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Nov 2005 22:03:54.0850 (UTC) FILETIME=[50FC7420:01C5DFF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Benjamin Herrenschmidt wrote:
> On Wed, 2005-11-02 at 21:41 +0000, Hugh Dickins wrote:
> 
> > The only extant problem here is if the pages are private, and you
> > fork while this is going on, and the parent user process writes to the
> > area before completion: then COW leaves the child with the page being
> > DMAed into, giving the parent a copied page which may be incomplete.
> 
> Won't happen, and if it does, it's a user error to rely on that working,
> so it doesn't matter.

I wish everyone else would see it that way!  (But some people do
have valid scenarios where it can't just be ruled out completely.)

> > Take a look at Andrew's educational comment on set_page_dirty_lock
> > in mm/page-writeback.c.  You do have the list of pages you need to
> > page_cache_release, don't you?  So it should be easy to dirty them.
> 
> Ok, so just passing 'write' to get_user_pages() is good enough; right ?

Not quite, I think: you need to pass 'write' to get_user_pages()
initially; but at the end, if it was indeed writing into user space,
you need to do the set_page_dirty_lock thing on each of the pages
before page_cache_release, just in case a race cleaned them before
the DMA completed.  I think (I've never used it myself).

Hugh
