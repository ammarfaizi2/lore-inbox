Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbRATDmu>; Fri, 19 Jan 2001 22:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbRATDmk>; Fri, 19 Jan 2001 22:42:40 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:55048 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129911AbRATDme>; Fri, 19 Jan 2001 22:42:34 -0500
Date: Fri, 19 Jan 2001 23:52:36 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, Rajagopal Ananthanarayanan <ananth@sgi.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [RFC] generic IO write clustering 
In-Reply-To: <Pine.LNX.4.31.0101201355560.1071-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0101192311090.6167-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Jan 2001, Rik van Riel wrote:

> Is there ever a reason NOT to do the best possible IO
> clustering at write time ?
> 
> Remember that disk writes do not cost memory and have
> no influence on the resident set ... completely unlike
> read clustering, which does need to be limited.

You dont want to have too many ongoing writes at the same time to avoid
complete starvation of the system. We already do this, and have to, in a
quite a few places.

> >   - By doing the write clustering at a higher level, we avoid a ton of
> >     filesystems duplicating the code.
> >
> > So what I suggest is to add a "cluster" operation to struct address_space
> > which can be used by the VM code to know the optimal IO transfer unit in
> > the storage device. Something like this (maybe we need an async flag but
> > thats a minor detail now):
> >
> >         int (*cluster)(struct page *, unsigned long *boffset,
> > 		unsigned long *poffset);
> 
> Makes sense, except that I don't see how (or why) the _VM_
> should "know the optimal IO transfer unit". This sounds more
> like a job for the IO subsystem and/or the filesystem, IMHO.

The a_ops->cluster() operation will make the VM aware of the contiguous
pages which can be clustered.

The VM does not know about _any_ fs lowlevel details (which are hidden
behind ->cluster()), including buffer_head's.

> 
> > "page" is from where the filesystem code should start its search
> > for contiguous pages. boffset and poffset are passed by the VM
> > code to know the logical "backwards offset" (number of
> > contiguous pages going backwards from "page") and "forward
> > offset" (cont pages going forward from "page") in the inode.
> 
> Yes, this makes a LOT of sense. I really like a pagecache
> helper function so the filesystems can build their writeout
> clusters easier.

The address space owners (filesystems _and_ swap for this case) do not
need to implement the writeout clustering at all because we're doing it at
the VM _without_ having to know about low-level details.

Take a look at this somewhat pseudo-code:

int cluster_write (struct page *page)
{
        struct address_space *mapping = page->mapping;
	unsigned long boffset, poffset;
        int nr_pages;

	...
	/* How much pages can we write for free? */
        nr_pages = mapping->a_ops->cluster(page, &boffset, &poffset);
	...	

	page_cluster_flush(page, csize); 
}

/*
 * @page: dirty page from where to start the search
 * @csize: maximum size of the cluster
 */
int page_cluster_flush(struct page *page, int csize)
{
        struct *cpages[csize];
        struct address_space *mapping = page->mapping;
        struct inode *inode = mapping->host;
        unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
        unsigned long index = page->index;
        unsigned long curr_index = page->index;

	cpages[csize] = page;
	count = 1;

	/* Search for clusterable dirty pages behind */
	....
	/* Search for clusterable dirty pages ahead */
	...
	/* Write all of them */
	for(i=0; i<count; i++) {
		ClearPageDirty(cpages[i]);
		writepage(cpages[i]);  
	...
}

This way we have _one_ clean implementation of write clustering without
any lowlevel crap involved. Try to imagine the amount of code people will
manage to write in their own fs's to implement write clustering.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
