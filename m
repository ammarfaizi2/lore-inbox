Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752022AbWJJDDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbWJJDDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbWJJDDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:03:50 -0400
Received: from ns.suse.de ([195.135.220.2]:47294 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752022AbWJJDDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:03:49 -0400
Date: Tue, 10 Oct 2006 05:03:44 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: ptrace and pfn mappings
Message-ID: <20061010030344.GF15822@wotan.suse.de>
References: <20061009140354.13840.71273.sendpatchset@linux.site> <20061009140447.13840.20975.sendpatchset@linux.site> <1160427785.7752.19.camel@localhost.localdomain> <452AEC8B.2070008@yahoo.com.au> <1160442987.32237.34.camel@localhost.localdomain> <20061010022310.GC15822@wotan.suse.de> <1160448466.32237.59.camel@localhost.localdomain> <1160448968.32237.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160448968.32237.68.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 12:56:08PM +1000, Benjamin Herrenschmidt wrote:
> 
> > > What if you hold your per-object lock over the operation? (I guess
> > > it would have to nest *inside* mmap_sem, but that should be OK).
> > 
> > Over the ptrace operation ? how so ?
> > 
> 
> Or do you mean the migration ? Well, we have so far managed to avoid
> walking the VMAs and thus avoid the mmap_sem during that migration, so
> yes, we do take the object lock but not the mmap_sem.
> 
> The problem is that a get_user_pfn() (or get_user_pages if we are on the
> memory backstore, besides, how do you decide from access_process_vm
> which one to call ?) will peek PTEs and just use that if they are
> populated. Thus, if the migration races with it, we are stuffed.

Hold your per-object lock? I'm not talking about using mmap_sem for
migration, but the per-object lock in access_process_vm. I thought
this prevented migration?

> 
> Even if we took the mmap_sem for writing during the migration on all
> affected VMAs (which I'm trying very hard to avoid, it's a very risky
> thing to do taking it on multiple VMAs, think about lock ordering
> issues, and it's just plain horrid), we would still at one point return
> an array of struct pages or pfn's that may be out of date unless we
> -also- do all the copies / accesses with that semaphore held. Now if
> that is the case, you gotta hope that the ptracing process doesn't also
> have one of those things mmap'ed (and in the case of SPUfs/gdb, it will
> to get to the spu program text afaik) or the copy_to_user to return the
> data read will be deadly.

OK, just do one pfn at a time. For ptrace that is fine. access_process_vm
already copies from source into kernel buffer, then kernel buffer into
target.

> So all I see is more cans of worms... the only think that would "just
> work" would be to switch the mm and just do the accesses, letting normal
> faults do their job. This needs a temporary page in kernel memory to
> copy to/form but that's fine. The SPU might get context switched in the
> meantime, but that's not a problem, the data will be right.
> 
> So yes, there might be other issues with switching the active_mm like
> that, and I yet have to find them (if some comes on top of your mind,
> please share) but it doesn't at this point seem worse than the
> get_user_page/pfn situation.
> 
> (We could also make sure the whole switch/copy/switchback is done while
> holding the mmap sem of both current and target mm's for writing to
> avoid more complications I suppose, if we always take the ptracer first,
> the target being sigstopped, we should avoid AB/BA type deadlock
> scenarios unless I've missed something subtle).
