Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUJBUCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUJBUCU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 16:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUJBUCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 16:02:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44229 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267528AbUJBUBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 16:01:41 -0400
Date: Sat, 2 Oct 2004 15:33:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: haveblue@us.ibm.com, akpm@osdl.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-ID: <20041002183349.GA7986@logos.cnet>
References: <20041001190430.GA4372@logos.cnet> <1096667823.3684.1299.camel@localhost> <20041001234200.GA4635@logos.cnet> <20041002.183015.41630389.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002.183015.41630389.taka@valinux.co.jp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 06:30:15PM +0900, Hirokazu Takahashi wrote:
> Hello, Marcelo.
> 
> Generic memory defragmentation will be very nice for me to implement
> hugetlbpage migration, as allocating a new hugetlbpage is a hard job.
> 
> > For the "defragmentation" operation we want to do an "easy" try - ie if we
> > can't remap giveup.
> > 
> > I feel we should try to "untie" the code which checks for remapping availability / 
> > does the remapping from the page migration - so to be able to share the most 
> > code between it and other users of the same functionality. 
> 
> I think it's possible to introduce non-wait mode to the migration code,
> as you may expect. Shall I implement it?
> 
> > Curiosity: How did you guys test the migration operation? Several threads on 
> > several processors operating on the memory, etc? 
> 
> I always test it with the zone hotplug emulation patch, which Mr.Iwamoto
> has made. I usually run following jobs concurrently while zones are added
> and removed repeatedly on a SMP machine.
>       - making linux kernel
>       - copying file trees.
>       - overwriting file trees.
>       - removing file trees
>       - some pages are swapped out automatically:)
> 
> And Mr.Iwamoto has some small programs to check any kind of page
> can be migrated. The programs repeat one of following actions:
>     - read/write files .
>     - use MAP_SHARED and MAP_PRIVATE mmap()'s and read/write there.
>     - use Direct I/O.
>     - use AIO.
>     - fork to have COW pages.
>     - use shmem.
>     - use sendfile.
> 
> > Cool. I'll take a closer look at the relevant parts of memory hotplug patches 
> > this weekend, hopefully. See if I can help with testing of these patches too.
> 
> Any comments are very welcome.


I have a few comments about the code:

1) 
I'm pretty sure you should transfer the radix tree tag at radix_tree_replace().
If for example you transfer a dirty tagged page to another zone, an mpage_writepages()
will miss it (because it uses pagevec_lookup_tag(PAGECACHE_DIRTY_TAG)). 

Should be quite trivial to do (save tags before deleting and set to new entry, 
all in radix_tree_replace).

My implementation also contained the same bug.

2) 
At migrate_onepage you add anonymous pages which aren't swap allocated
to the swap cache
+       /*
+        * Put the page in a radix tree if it isn't in the tree yet.
+        */
+#ifdef CONFIG_SWAP
+       if (PageAnon(page) && !PageSwapCache(page))
+               if (!add_to_swap(page, GFP_KERNEL)) {
+                       unlock_page(page);
+                       return ERR_PTR(-ENOSPC);
+               }
+#endif /* CONFIG_SWAP */

Why's that? You can copy anonymous pages without adding them to swap (thats
what the patch I posted does).

3) At migrate_page_common you assume additional page references 
(page_migratable returning -EAGAIN) means the code should try to writeout 
the page.

Is that assumption always valid?

In theory there is no need to writeout pages when migrating them to 
other zones - they will be copied and the dirty information retained (either
in the PageDirty bit or radix tree tag). 

I just noticed you do that on further patches (migrate_page_buffer), but AFAICS 
the writeout remains. Why arent you using migrate_page_buffer yet?

I think the final aim should be to remove the need for "pageout()" 
completly.

4) 
About implementing a nonblocking version of it. The easier way, it
seems to me, is to pass a "block" argument to generic_migrate_page() and
use that.

Questions: are there any documents on the memory hotplug userspace tools? 
Where can I find them?

Are Iwamoto's test programs available?

In general the code looks nice to me! I'll jump in and help with 
testing.

