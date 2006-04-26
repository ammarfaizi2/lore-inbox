Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWDZSWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWDZSWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWDZSWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:22:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47155 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964794AbWDZSWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:22:45 -0400
Date: Wed, 26 Apr 2006 20:23:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060426182323.GI5002@suse.de>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426111054.2b4f1736.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Wed, Apr 26 2006, Andrew Morton wrote:
> > > Jens Axboe <axboe@suse.de> wrote:
> > > >
> > > > Running a splice benchmark on a 4-way IPF box, I decided to give the
> > > >  lockless page cache patches from Nick a spin. I've attached the results
> > > >  as a png, it pretty much speaks for itself.
> > > 
> > > It does.
> > > 
> > > What does the test do?
> > >
> > > In particular, does it cause the kernel to take tree_lock once per
> > > page, or once per batch-of-pages?
> > 
> > Once per page, it's basically exercising the generic_file_splice_read()
> > path. Basically X number of "clients" open the same file, and fill those
> > pages into a pipe using splice. The output end of the pipe is then
> > spliced to /dev/null to toss it away again.
> 
> OK.  That doesn't sound like something which a real application is likely
> to do ;)

I don't think it's totally unlikely. Could be streaming a large media
file to many clients, for instance. Of course you are not going to push
gigabytes of data per seconds like this test, but it's still the same
type of workload.

> > The top of the 4-client
> > vanilla run profile looks like this:
> > 
> > samples  %        symbol name
> > 65328    47.8972  find_get_page
> > 
> > Basically the machine is fully pegged, about 7% idle time.
> 
> Most of the time an acquisition of tree_lock is associated with a disk
> read, or a page-size memset, or a page-size memcpy.  And often an
> acquisition of tree_lock is associated with multiple pages, not just a
> single page.

Yeah with mostly io then I'd be hard pressed to show a difference.

> So although the graph looks good, I wouldn't view this as a super-strong
> argument in favour of lockless pagecache.

I didn't claim it was, just trying to show some data on at least one
case where the lockless patches perform well and the stock kernel does
not :-)

Are there cases where the lockless page cache performs worse than the
current one?

> > But boy I wish find_get_pages_contig() was there
> > for that. I think I'd prefer adding that instead of coding that logic in
> > splice, it can get a little tricky.
> 
> I guess it'd make sense - we haven't had a need for such a thing before.
> 
> umm, something like...
> 
> unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
> 			    unsigned int nr_pages, struct page **pages)
> {
> 	unsigned int i;
> 	unsigned int ret;
> 	pgoff_t index = start;
> 
> 	read_lock_irq(&mapping->tree_lock);
> 	ret = radix_tree_gang_lookup(&mapping->page_tree,
> 				(void **)pages, start, nr_pages);
> 	for (i = 0; i < ret; i++) {
> 		if (pages[i]->mapping == NULL || pages[i]->index != index)
> 			break;
> 		page_cache_get(pages[i]);
> 		index++;
> 	}
> 	read_unlock_irq(&mapping->tree_lock);
> 	return i;
> }

Ah clever, I didn't think of stopping on the first hole. Works well
since you need to manually get a reference on the page anyways.

Let me redo the numbers with this splice updated.

-- 
Jens Axboe

