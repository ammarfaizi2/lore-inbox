Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTDDSmC (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTDDSmB (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:42:01 -0500
Received: from [12.47.58.55] ([12.47.58.55]:52230 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263883AbTDDSl7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:41:59 -0500
Date: Fri, 4 Apr 2003 10:54:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030404105417.3a8c22cc.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 18:53:22.0850 (UTC) FILETIME=[77717020:01C2FADB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Truncating a sys_remap_file_pages file?  You're the first to
> begin to consider such an absurd possibility: vmtruncate_list
> still believes vm_pgoff tells it what needs to be done.

Well I knew mincore() was bust for nonlinear mappings.  Never thought about
truncate.

> I propose that we don't change vmtruncate_list, zap_page_range, ...
> at all for this: let it unmap inappropriate pages, even from a
> VM_LOCKED vma, that's just a price userspace pays for the
> privilege of truncating a sys_remap_file_pages file.
> 
> But truncate_inode_pages should check page_mapped, and if so
> try_to_unmap with a force flag to attack even VM_LOCKED vmas.
> Sadly, if page_table_lock is held, it won't be able to unmap:
> leave those for shrink_list?  But that won't find them once
> page->mapping gone: page_convert_anon from here too?
> What about invalidate_inode_pages2?
> 
> This will also cover some of the racy pages, which another cpu
> found in the cache before vmtruncate started, but inserted into
> page table after vmtruncate_list passed that way; but it won't
> cover those racy pages which were found before, but are not yet
> put into the page table (e.g. those where your page_convert_anon
> bailed because page->mapping is now NULL).  Worth adding checks
> for? but I don't think we have absolute locking against this.

How about we just don't do the SIGBUS thing at all for nonlinear mappings? 
Any pages outside i_size which are mapped into a nonlinear mapping become
anonymous.

We'd need vm_flags:VM_NONLINEAR.

> Various places in rmap.c where !page->mapping is considered a
> BUG(), but you've now drawn attention to the fact it may get
> vmtruncated at any moment.  Easy to remove those BUG()s.

Well not really.  page_referenced_obj() is racy wrt truncate and will deref
null.  We're back to locking the pages in refill_inactive_zone().  There is
no other way of stabilising ->mapping.

Probably a trylock in page_referenced_obj() would suit.

btw,
        if (PageSwapCache(page))
                BUG();

is that safe against your weird tmpfs address_space swizzling?

