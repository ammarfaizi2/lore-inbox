Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUJDTCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUJDTCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUJDTCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:02:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1484 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268411AbUJDS7K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:59:10 -0400
Date: Mon, 4 Oct 2004 14:24:27 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: iwamoto@valinux.co.jp, haveblue@us.ibm.com, akpm@osdl.org,
       linux-mm@kvack.org, piggin@cyberone.com.au, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-ID: <20041004172427.GL16374@logos.cnet>
References: <20041002183349.GA7986@logos.cnet> <20041003.131338.41636688.taka@valinux.co.jp> <20041003140723.GD4635@logos.cnet> <20041004.033559.71092746.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004.033559.71092746.taka@valinux.co.jp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 03:35:59AM +0900, Hirokazu Takahashi wrote:
> Hi, Marcelo
> 
> > > > 2) 
> > > > At migrate_onepage you add anonymous pages which aren't swap allocated
> > > > to the swap cache
> > > > +       /*
> > > > +        * Put the page in a radix tree if it isn't in the tree yet.
> > > > +        */
> > > > +#ifdef CONFIG_SWAP
> > > > +       if (PageAnon(page) && !PageSwapCache(page))
> > > > +               if (!add_to_swap(page, GFP_KERNEL)) {
> > > > +                       unlock_page(page);
> > > > +                       return ERR_PTR(-ENOSPC);
> > > > +               }
> > > > +#endif /* CONFIG_SWAP */
> > > > 
> > > > Why's that? You can copy anonymous pages without adding them to swap (thats
> > > > what the patch I posted does).
> > > 
> > > The reason is to guarantee that any anonymous page can be migrated anytime.
> > > I want to block newly occurred accesses to the page during the migration
> > > because it can't be migrated if there remain some references on it by
> > > system calls, direct I/O and page faults.
> > 
> > It would be nice if we could block pte faults in a way such to not need
> > adding each anonymous page to swap. It can be too costly if you have a lot memory
> > and it makes the whole operation dependable on swap size (if you dont have enough
> > swap, you're dead).
> > 
> > Maybe hold mm->page_table_lock (might be too costly in terms of CPU time, but since
> > migration is not a common operation anyway), or create a semaphore? 
> 
> I think the problem of the holding mm->page_table_lock approach is
> that it doesn't allow the migration code blocked. the semaphore
> approach would be better.

OK, I think the problem is that can be more than one thread with different address 
spaces (ie different "current->mm", after fork) accessing the page.

Adding a waitqueue to "anon_vma" structure (to be slept at do_swap_page time, 
and awake after copy-page-and-flags/unlock), can be do the job I think.

> I have another idea that each anonymous page can detach its swap entry
> after its migration. 

Yes thats a nice idea.

> It can be done by remove_exclusive_swap_page()
> if the page is remapped to the same spaces forcibly by
> touch_unmapped_address() I made.

touch_unmapped_address() ?

> > > Your approach will work fine on most of anonymous pages, which aren't
> > > heavily accessed. I think it will be enough for memory defragmentation.
> > 
> > Yes...
> > 
> > > > 3) At migrate_page_common you assume additional page references 
> > > > (page_migratable returning -EAGAIN) means the code should try to writeout 
> > > > the page.
> > > > 
> > > > Is that assumption always valid?
> > > 
> > > -EAGAIN means that the page may require to be written back 
> > 
> > But why is it needed to writeout pages? We shouldnt need to. At least
> > from what I can understand.
> 
> The migration code allows each filesystem to implement its own
> migration code or just use migrate_page_buffer() or
> migrate_page_common(). 
> 
> migrate_page_common() is a default function if filesystem doesn't
> implement anything. The function is the most generic and it tries
> to writeback pages only if they are dirty and have buffers.

The thing is: What is the point of writing out pages?

We're just trying to migrate pages to another zone. 

If its under writeout, wait, if its dirty, just move it to the other
zone.

Can you enlight me?

> > > or
> > > just to wait for a while since the page is just referred by system call 
> > > or pagefault handler.
> > 
> > I'm not sure if making that assumption is always valid.
> > 
> > Kernel code can have an additional count on the page meaning "this page is pinned, 
> > dont move it". At least that should be valid.
> 
> Yes, I know. I have checked all of the code.
> 
> AIO event buffers are pinned, therefore the memory-hotplug team plans
> to make pages for the event buffers assigned to non-hotpluggable
> memory regions.
> 
> And pages in sendfile() might be pinned for a while in case of network
> problems. I think there may be some workarounds. The easiest way
> is just waiting its timeout, and another way is changing the mode
> of sendfile() to copy pages in advance. 
> 
> Pages for NFS also might be pinned with network problems.
> One of the ideas is to restrict NFS to allocate pages from
> specific memory region, sot that all memory except the region
> can be hot-removed. And it's possible to implementing whole
> migrate_page method, which may handled stuck pages.
> 
> If the migration code is used for memory defragmentation, pinned pages
> must be avoided. I think it can be done with the non-blocking mode.

Right.

> > Any piece of code which holds a reference on a page for a long 
> > time is going to be a pain for the algorithm right?
> > 
> 
> > > > 4) 
> > > > About implementing a nonblocking version of it. The easier way, it
> > > > seems to me, is to pass a "block" argument to generic_migrate_page() and
> > > > use that.
> > > 
> > > Yes.
> > 
> > OK. I'll try to implement it this week (plus the radix_tree_replace 
> > tag thingie).
> 
> Thank you for that.

Any news about Iwamoto's test programs? :)
