Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUJCENW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUJCENW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 00:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUJCENW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 00:13:22 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:42952 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267730AbUJCENR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 00:13:17 -0400
Date: Sun, 03 Oct 2004 13:13:38 +0900 (JST)
Message-Id: <20041003.131338.41636688.taka@valinux.co.jp>
To: marcelo.tosatti@cyclades.com
Cc: iwamoto@valinux.co.jp, haveblue@us.ibm.com, akpm@osdl.org,
       linux-mm@kvack.org, piggin@cyberone.com.au, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20041002183349.GA7986@logos.cnet>
References: <20041001234200.GA4635@logos.cnet>
	<20041002.183015.41630389.taka@valinux.co.jp>
	<20041002183349.GA7986@logos.cnet>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > Cool. I'll take a closer look at the relevant parts of memory hotplug patches 
> > > this weekend, hopefully. See if I can help with testing of these patches too.
> > 
> > Any comments are very welcome.
> 
> 
> I have a few comments about the code:
> 
> 1) 
> I'm pretty sure you should transfer the radix tree tag at radix_tree_replace().
> If for example you transfer a dirty tagged page to another zone, an mpage_writepages()
> will miss it (because it uses pagevec_lookup_tag(PAGECACHE_DIRTY_TAG)). 
> 
> Should be quite trivial to do (save tags before deleting and set to new entry, 
> all in radix_tree_replace).
> 
> My implementation also contained the same bug.

Yes, it's one of the issues to do. The tag should be transferred in
radix_tree_replace() as you pointed out. The current implementation
sets the tag in set_page_dirty(newpage).

> 2) 
> At migrate_onepage you add anonymous pages which aren't swap allocated
> to the swap cache
> +       /*
> +        * Put the page in a radix tree if it isn't in the tree yet.
> +        */
> +#ifdef CONFIG_SWAP
> +       if (PageAnon(page) && !PageSwapCache(page))
> +               if (!add_to_swap(page, GFP_KERNEL)) {
> +                       unlock_page(page);
> +                       return ERR_PTR(-ENOSPC);
> +               }
> +#endif /* CONFIG_SWAP */
> 
> Why's that? You can copy anonymous pages without adding them to swap (thats
> what the patch I posted does).

The reason is to guarantee that any anonymous page can be migrated anytime.
I want to block newly occurred accesses to the page during the migration
because it can't be migrated if there remain some references on it by
system calls, direct I/O and page faults.

Your approach will work fine on most of anonymous pages, which aren't
heavily accessed. I think it will be enough for memory defragmentation.

> 3) At migrate_page_common you assume additional page references 
> (page_migratable returning -EAGAIN) means the code should try to writeout 
> the page.
> 
> Is that assumption always valid?

-EAGAIN means that the page may require to be written back or
just to wait for a while since the page is just referred by system call 
or pagefault handler.

> In theory there is no need to writeout pages when migrating them to 
> other zones - they will be copied and the dirty information retained (either
> in the PageDirty bit or radix tree tag). 
> 
> I just noticed you do that on further patches (migrate_page_buffer), but AFAICS 
> the writeout remains. Why arent you using migrate_page_buffer yet?

I've designed migrate_page_buffer() for this purpose.
At this moment ext2 only uses this yet.

> I think the final aim should be to remove the need for "pageout()" 
> completly.

Yes!

> 4) 
> About implementing a nonblocking version of it. The easier way, it
> seems to me, is to pass a "block" argument to generic_migrate_page() and
> use that.

Yes.

> Questions: are there any documents on the memory hotplug userspace tools? 
> Where can I find them?

IBM guys and Fujitsu guys are designing user interface independently.
IBM team is implementing memory section hotplug while Fujitsu team
try to implement NUMA node hotplug. But both of the designs use
regular hot-plug mechanism, which kicks /sbin/hotplug script to control
devices via sysfs.

Dave, would you explain about it?

> Are Iwamoto's test programs available?

Ok, I'll notice him to post them.

> In general the code looks nice to me! I'll jump in and help with 
> testing.

I appreciate your offer. I'm very happy with that.

Thank you,
Hirokazu Takahasih.



