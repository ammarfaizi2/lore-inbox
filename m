Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVHWWBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVHWWBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 18:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVHWWBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 18:01:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30663 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932434AbVHWWBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 18:01:23 -0400
Date: Tue, 23 Aug 2005 17:01:00 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] external interrupts: abstraction layer
In-Reply-To: <20050820094632.GC21698@infradead.org>
Message-ID: <20050823153254.B5569@chenjesu.americas.sgi.com>
References: <20050819161054.I87000@chenjesu.americas.sgi.com>
 <20050820094632.GC21698@infradead.org>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2005, Christoph Hellwig wrote:

> > +static struct page *extint_counter_vma_nopage(struct vm_area_struct *vma,
> > +					      unsigned long address, int *type)
> > +{
> > +	struct extint_device *ed = vma->vm_private_data;
> > +	struct page *page;
> > +
> > +	/* Only a single page is ever mapped */
> > +	if (address >= vma->vm_start + PAGE_SIZE)
> > +		return NOPAGE_SIGBUS;
> > +
> > +	/* virt_to_page can be expensive, but this is executed
> > +	 * only once each time the counter page is mapped.
> > +	 */
> > +	page = virt_to_page(ed->counter_page);
> 
> I think you should store both the struct page pointer and the virtual
> address in struct extint_device.  This avoids doing the virt_to_page
> at every pagefauls.  It's also cleaner as you an juse use alloc_page()
> and the page_address() to get the kernel virtual address.

Done.  I'm now storing both in extint_device.  Unfortunately, though,
it isn't any cleaner as we still need the error-handling in case
alloc_page() returns NULL (in extint_device_create()).  The only
thing this really changes is the relative order of getting a virtual
address and the struct page*.

> > +static int extint_counter_open(struct inode *inode, struct file *filp)
> > +{
> > +	struct extint_device *ed = file_to_extint_device(filp);
> 
> you don't need the file but just the inode (strictly speaking the cdev),
> and doing this based on the file is rather confusing to the reader because
> the struct file passed to ->open has just been allocated.

Perhaps I'm not following something here.

This behavior enables using poll/select to detect or wait for the
external interrupt counter (which is per-device) to change.  The
"has changed" status must be on a per-open basis, not a per-device
basis, as seperate processes may read the counter at different times.

Neither does it suffice to wake all waiters in extint_interrupt()
without checking a per-open snapshotted counter, as there could be
a race between the thread performing poll/select and the interrupt
which increments the counter.  i.e., the following sequence:

	Thread			Interrupted CPU
	------			-----------------
				Receive interrupt
				Bump counter
	Read counter
	Poll
				Wake polling threads
	Continue execution

To avoid this race (the thread should have returned to poll_wait()),
we snapshot the value of the counter when it was last read, and
check that the counter value has indeed changed before continuing
execution (by returning 0 from extint_counter_poll).

Storing the snapshot in a per-open structure (i.e. struct file) looks
to be the right thing to avoid this race and take care of independent
processes reading the counter.

Or did I miss your point?

> > +	/* Snapshot initial value, for later use by poll */
> > +	filp->private_data = (void *)*ed->counter_page;
> 
> What about storing the whole extint_device pointer in file->private_data?
> That's get rid of a lot of casting and would make possible future additions
> easier.

It seems kind of messy to manage another pointer, but I agreee this
makes things more clear in most cases.  Considering my comments above
(about needing per-open counter snapshots), filp->private data now
points at one of these:

	struct extint_file {
		struct extint_device	*ed;
		unsigned long		snapshot;
	};

The resulting code changes, along with the ramifications of the next
comment, also meant that we can remove file_to_extint_device().

> > +/* Obtain extint_device structure from an open file */
> > +struct extint_device *file_to_extint_device(const struct file *filp)
> > +{
> > +	/* Validate that this really is an extint device file */
> > +	if (filp->f_dentry->d_inode->i_cdev->dev < firstdev ||
> > +	    filp->f_dentry->d_inode->i_cdev->dev > (firstdev + EXTINT_NUMDEVS))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	return container_of(filp->f_dentry->d_inode->i_cdev,
> > +			    struct extint_device, counter_cdev);
> > +}
> > +
> > +EXPORT_SYMBOL(file_to_extint_device);
> 
> Why is this exported?  Also normally having helpers ontop of the file
> so you've already read them when looking at their users helps understanding
> a little.

It was exported in order to enable the callout registration mechanism to
locate the correct device to register against.  However, with that
mechanism removed (see below) and the changes from the previous comment,
the whole function went away.

> > +/* Register a callout function to invoke when an interrupt is ingested */
> > +int extint_callout_register(struct extint_device *ed, struct extint_callout *ec)

> I've not seen any users of the in-kernel extint consumer interface in
> your previous posting or this one.  Do you plan to submit a patch to
> use them soon?  Else please keep the interface out for now, we can easily
> add it when it's nessecary.

There are currently no users of this functionality, though I think I
could contrive one that supports a reference atomic clock for NTP
master clock synchronization.  Apparently these things can operate in
a mode of providing periodic pulses to a computer system, something
external interrupts would be perfectly suited for.

Anyway, it's now omitted from the patch.  Though, honestly, not having
it makes the patch far less useful, to the point where I may not continue
to push for its inclusion.

> Also callout isn't really a name we use a lot in linux, unlike other
> unix variants.

Not that it matters anymore, but any ideas for better terminology?

> > +static inline void* extint_get_devdata(const struct extint_device *ed) {
> > +	return ed->devdata;
> > +}
> 
> minimal style nipick, please put the opening brace on a line of it's own.

Just a goof on my part.  Thanks for catching this.

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
