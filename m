Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWEaRwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWEaRwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 13:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWEaRwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 13:52:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49700 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751759AbWEaRwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 13:52:17 -0400
Date: Wed, 31 May 2006 19:51:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
Message-ID: <20060531175115.GX29535@suse.de>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <20060529201444.cd89e0d8.akpm@osdl.org> <20060530090549.GF4199@suse.de> <447D9D9C.1030602@yahoo.com.au> <Pine.LNX.4.64.0605311602020.26969@blonde.wat.veritas.com> <447DB4AB.9090008@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447DB4AB.9090008@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01 2006, Nick Piggin wrote:
> Hugh Dickins wrote:
> >On Wed, 31 May 2006, Nick Piggin wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>Maybe I'm being dense, but I don't see a problem there. You _should_
> >>>call the new mapping sync page if it has been migrated.
> >>
> >>But can some other thread calling lock_page first find the old mapping,
> >>and then run its ->sync_page which finds the new mapping? While it may
> >>not matter for anyone in-tree, it does break the API so it would be
> >>better to either fix it or rip it out than be silently buggy.
> >
> >
> >Splicing a page from one mapping to another is rather worrying/exciting,
> >but it does look safely done to me.  remove_mapping checks page_count
> >while page lock and old mapping->tree_lock are held, and gives up if
> >anyone else has an interest in the page.  And we already know it's
> >unsafe to lock_page without holding a reference to the page, don't we?
> 
> Oh, that's true. I had thought that splice allows stealing pages with
> an elevated refcount, which Jens was thinking about at one stage. But
> I see that code isn't in mainline. AFAIKS it would allow other
> ->pin()ers to attempt to lock the page while it was being stolen.

It got me in trouble, and we were already way too late into 2.6.17 to
take on more risky stuff (splice already had a few!). So right now the
page is definitely pruned and single while being stolen.

-- 
Jens Axboe

