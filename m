Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUJCPgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUJCPgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 11:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUJCPgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 11:36:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19889 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267554AbUJCPg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 11:36:27 -0400
Date: Sun, 3 Oct 2004 11:07:23 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: iwamoto@valinux.co.jp, haveblue@us.ibm.com, akpm@osdl.org,
       linux-mm@kvack.org, piggin@cyberone.com.au, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-ID: <20041003140723.GD4635@logos.cnet>
References: <20041001234200.GA4635@logos.cnet> <20041002.183015.41630389.taka@valinux.co.jp> <20041002183349.GA7986@logos.cnet> <20041003.131338.41636688.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041003.131338.41636688.taka@valinux.co.jp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2004 at 01:13:38PM +0900, Hirokazu Takahashi wrote:
> Hi,
> 
> > > > Cool. I'll take a closer look at the relevant parts of memory hotplug patches 
> > > > this weekend, hopefully. See if I can help with testing of these patches too.
> > > 
> > > Any comments are very welcome.
> > 
> > 
> > I have a few comments about the code:
> > 
> > 1) 
> > I'm pretty sure you should transfer the radix tree tag at radix_tree_replace().
> > If for example you transfer a dirty tagged page to another zone, an mpage_writepages()
> > will miss it (because it uses pagevec_lookup_tag(PAGECACHE_DIRTY_TAG)). 
> > 
> > Should be quite trivial to do (save tags before deleting and set to new entry, 
> > all in radix_tree_replace).
> > 
> > My implementation also contained the same bug.
> 
> Yes, it's one of the issues to do. The tag should be transferred in
> radix_tree_replace() as you pointed out. The current implementation
> sets the tag in set_page_dirty(newpage).

Oh I missed that, right.

But yes, anyway, the tag should be transferred at radix_tree_replace (earlier)
or pagevec_lookup_tag() can miss those pages.

> > 2) 
> > At migrate_onepage you add anonymous pages which aren't swap allocated
> > to the swap cache
> > +       /*
> > +        * Put the page in a radix tree if it isn't in the tree yet.
> > +        */
> > +#ifdef CONFIG_SWAP
> > +       if (PageAnon(page) && !PageSwapCache(page))
> > +               if (!add_to_swap(page, GFP_KERNEL)) {
> > +                       unlock_page(page);
> > +                       return ERR_PTR(-ENOSPC);
> > +               }
> > +#endif /* CONFIG_SWAP */
> > 
> > Why's that? You can copy anonymous pages without adding them to swap (thats
> > what the patch I posted does).
> 
> The reason is to guarantee that any anonymous page can be migrated anytime.
> I want to block newly occurred accesses to the page during the migration
> because it can't be migrated if there remain some references on it by
> system calls, direct I/O and page faults.

It would be nice if we could block pte faults in a way such to not need
adding each anonymous page to swap. It can be too costly if you have a lot memory
and it makes the whole operation dependable on swap size (if you dont have enough
swap, you're dead).

Maybe hold mm->page_table_lock (might be too costly in terms of CPU time, but since
migration is not a common operation anyway), or create a semaphore? 

> Your approach will work fine on most of anonymous pages, which aren't
> heavily accessed. I think it will be enough for memory defragmentation.

Yes...

> > 3) At migrate_page_common you assume additional page references 
> > (page_migratable returning -EAGAIN) means the code should try to writeout 
> > the page.
> > 
> > Is that assumption always valid?
> 
> -EAGAIN means that the page may require to be written back 

But why is it needed to writeout pages? We shouldnt need to. At least
from what I can understand.


> or
> just to wait for a while since the page is just referred by system call 
> or pagefault handler.

I'm not sure if making that assumption is always valid.

Kernel code can have an additional count on the page meaning "this page is pinned, 
dont move it". At least that should be valid.

Any piece of code which holds a reference on a page for a long 
time is going to be a pain for the algorithm right?

> > In theory there is no need to writeout pages when migrating them to 
> > other zones - they will be copied and the dirty information retained (either
> > in the PageDirty bit or radix tree tag). 
> > 
> > I just noticed you do that on further patches (migrate_page_buffer), but AFAICS 
> > the writeout remains. Why arent you using migrate_page_buffer yet?
> 
> I've designed migrate_page_buffer() for this purpose.
> At this moment ext2 only uses this yet.

Ah ok I haven't looked at those patches.

> > I think the final aim should be to remove the need for "pageout()" 
> > completly.
> 
> Yes!
> 
> > 4) 
> > About implementing a nonblocking version of it. The easier way, it
> > seems to me, is to pass a "block" argument to generic_migrate_page() and
> > use that.
> 
> Yes.

OK. I'll try to implement it this week (plus the radix_tree_replace 
tag thingie).

> > Questions: are there any documents on the memory hotplug userspace tools? 
> > Where can I find them?
> 
> IBM guys and Fujitsu guys are designing user interface independently.
> IBM team is implementing memory section hotplug while Fujitsu team
> try to implement NUMA node hotplug. But both of the designs use
> regular hot-plug mechanism, which kicks /sbin/hotplug script to control
> devices via sysfs.
> 
> Dave, would you explain about it?

Please :)

> > Are Iwamoto's test programs available?
> 
> Ok, I'll notice him to post them.
> 
> > In general the code looks nice to me! I'll jump in and help with 
> > testing.
> 
> I appreciate your offer. I'm very happy with that.

Me too! :)
