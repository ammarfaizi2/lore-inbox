Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUJCSkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUJCSkk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUJCSkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:40:39 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:45781 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S268060AbUJCSfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:35:42 -0400
Date: Mon, 04 Oct 2004 03:35:59 +0900 (JST)
Message-Id: <20041004.033559.71092746.taka@valinux.co.jp>
To: marcelo.tosatti@cyclades.com
Cc: iwamoto@valinux.co.jp, haveblue@us.ibm.com, akpm@osdl.org,
       linux-mm@kvack.org, piggin@cyberone.com.au, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20041003140723.GD4635@logos.cnet>
References: <20041002183349.GA7986@logos.cnet>
	<20041003.131338.41636688.taka@valinux.co.jp>
	<20041003140723.GD4635@logos.cnet>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcelo

> > > 2) 
> > > At migrate_onepage you add anonymous pages which aren't swap allocated
> > > to the swap cache
> > > +       /*
> > > +        * Put the page in a radix tree if it isn't in the tree yet.
> > > +        */
> > > +#ifdef CONFIG_SWAP
> > > +       if (PageAnon(page) && !PageSwapCache(page))
> > > +               if (!add_to_swap(page, GFP_KERNEL)) {
> > > +                       unlock_page(page);
> > > +                       return ERR_PTR(-ENOSPC);
> > > +               }
> > > +#endif /* CONFIG_SWAP */
> > > 
> > > Why's that? You can copy anonymous pages without adding them to swap (thats
> > > what the patch I posted does).
> > 
> > The reason is to guarantee that any anonymous page can be migrated anytime.
> > I want to block newly occurred accesses to the page during the migration
> > because it can't be migrated if there remain some references on it by
> > system calls, direct I/O and page faults.
> 
> It would be nice if we could block pte faults in a way such to not need
> adding each anonymous page to swap. It can be too costly if you have a lot memory
> and it makes the whole operation dependable on swap size (if you dont have enough
> swap, you're dead).
> 
> Maybe hold mm->page_table_lock (might be too costly in terms of CPU time, but since
> migration is not a common operation anyway), or create a semaphore? 

I think the problem of the holding mm->page_table_lock approach is
that it doesn't allow the migration code blocked. the semaphore
approach would be better.

I have another idea that each anonymous page can detach its swap entry
after its migration. It can be done by remove_exclusive_swap_page()
if the page is remapped to the same spaces forcibly by
touch_unmapped_address() I made.

> > Your approach will work fine on most of anonymous pages, which aren't
> > heavily accessed. I think it will be enough for memory defragmentation.
> 
> Yes...
> 
> > > 3) At migrate_page_common you assume additional page references 
> > > (page_migratable returning -EAGAIN) means the code should try to writeout 
> > > the page.
> > > 
> > > Is that assumption always valid?
> > 
> > -EAGAIN means that the page may require to be written back 
> 
> But why is it needed to writeout pages? We shouldnt need to. At least
> from what I can understand.

The migration code allows each filesystem to implement its own
migration code or just use migrate_page_buffer() or
migrate_page_common(). 

migrate_page_common() is a default function if filesystem doesn't
implement anything. The function is the most generic and it tries
to writeback pages only if they are dirty and have buffers.

> > or
> > just to wait for a while since the page is just referred by system call 
> > or pagefault handler.
> 
> I'm not sure if making that assumption is always valid.
> 
> Kernel code can have an additional count on the page meaning "this page is pinned, 
> dont move it". At least that should be valid.

Yes, I know. I have checked all of the code.

AIO event buffers are pinned, therefore the memory-hotplug team plans
to make pages for the event buffers assigned to non-hotpluggable
memory regions.

And pages in sendfile() might be pinned for a while in case of network
problems. I think there may be some workarounds. The easiest way
is just waiting its timeout, and another way is changing the mode
of sendfile() to copy pages in advance. 

Pages for NFS also might be pinned with network problems.
One of the ideas is to restrict NFS to allocate pages from
specific memory region, sot that all memory except the region
can be hot-removed. And it's possible to implementing whole
migrate_page method, which may handled stuck pages.

If the migration code is used for memory defragmentation, pinned pages
must be avoided. I think it can be done with the non-blocking mode.

> Any piece of code which holds a reference on a page for a long 
> time is going to be a pain for the algorithm right?
> 

> > > 4) 
> > > About implementing a nonblocking version of it. The easier way, it
> > > seems to me, is to pass a "block" argument to generic_migrate_page() and
> > > use that.
> > 
> > Yes.
> 
> OK. I'll try to implement it this week (plus the radix_tree_replace 
> tag thingie).

Thank you for that.

Hirokazu Takahashi.
