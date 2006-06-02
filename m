Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWFBTly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWFBTly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWFBTly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:41:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751457AbWFBTlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:41:53 -0400
Date: Fri, 2 Jun 2006 12:41:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-Id: <20060602124143.0898384f.akpm@osdl.org>
In-Reply-To: <20060602191430.GA9357@suse.de>
References: <20060529214011.GA417@suse.de>
	<20060530182453.GA8701@suse.de>
	<20060601184938.GA31376@suse.de>
	<20060601121200.457c0335.akpm@osdl.org>
	<20060601201050.GA32221@suse.de>
	<20060601142400.1352f903.akpm@osdl.org>
	<20060601214158.GA438@suse.de>
	<20060601145747.274df976.akpm@osdl.org>
	<20060602084327.GA3964@suse.de>
	<20060602021115.e42ad5dd.akpm@osdl.org>
	<20060602191430.GA9357@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 21:14:30 +0200
Olaf Hering <olh@suse.de> wrote:

>  On Fri, Jun 02, Andrew Morton wrote:
> 
> > I'd suggest you run SetPagePrivate() and SetPageChecked() on the locked
> > page and implement a_ops.releasepage(), which will fail if PageChecked(),
> > and will succeed otherwise:
> > 
> > /*
> >  * cramfs_releasepage() will fail if cramfs_read() set PG_checked.  This
> >  * is so that invalidate_inode_pages() cannot zap the page while
> >  * cramfs_read() is trying to get at its contents.
> >  */
> > cramfs_releasepage(...)
> > {
> > 	if (PageChecked(page))
> > 		return 0;
> > 	return 1;
> > }
> 
> This function is not triggered in my testing.
> 
> > cramfs_read(...)
> > {
> > 	lock_page(page);
> > 	SetPagePrivate(page);
> > 	SetPageChecked(page);
> > 	read_mapping_page(...);
> > 	lock_page(page);
> > 	if (page->mapping == NULL) {
> > 		/* truncate got there first */
> > 		unlock_page(page);
> > 		bale();
> > 	}
> > 	memcpy();
> > 	ClearPageChecked(page);
> > 	ClearPagePrivate(page);
> > 	unlock_page(page);
> > }
> 
> recursive recursion? Where is page supposed to come from? Did you mean
> to call all this with a page returned from read_mapping_page(), and
> call read_mapping_page() twice?

That was all very-pseudo code.

> My version seems to leak memory somehow, Inactive and slab buffer_head
> keeps growing. I guess something is missing in the picture.
> 
> Doesnt read_cache_page lock the page already?
> read_cache_page
>   __read_cache_page
>     add_to_page_cache_lru
>       add_to_page_cache
>         SetPageLocked

read_cache_page() returns with the page locked if there's IO in flight
against it.

>  
> +static void cramfs_read_putpage(struct page *page)
> +{
> +	ClearPageChecked(page);
> +	ClearPagePrivate(page);
> +	unlock_page(page);
> +	page_cache_release(page);
> +}
> +
> +/* return a page in PageUptodate state, BLKFLSBUF may have flushed the page */
> +static struct page *cramfs_read_getpage(struct address_space *m, unsigned int n)
> +{
> +	struct page *page;
> +	int readagain = 5;
> +retry:
> +	page = read_cache_page(m, n, (filler_t *)m->a_ops->readpage, NULL);
> +	if (IS_ERR(page))
> +		return NULL;
> +	lock_page(page);
> +	SetPagePrivate(page);
> +	SetPageChecked(page);
> +	if (PageUptodate(page))
> +		return page;
> +	cramfs_read_putpage(page);
> +	printk("cramfs_read_getpage %d %p\n", 5 - readagain + 1, page);
> +	if (readagain--)
> +		goto retry;
> +	return NULL;
> +}

Oh, OK, we cannot use read_cache_page().  Because the above is still racy
(and still needs the retry loop).  We need to set PG_checked before
launching the read.  Something like:

/*
 * Return a locked, uptodate, !PagePrivate, !PageChecked page which needs a
 * single put_page by the caller.
 */
cramfs_read_getpage()
{
	page = find_lock_page()
	if (PageUptodate(page))
		return page;
	SetPagePrivate()
	SetPageChecked()
	err = m->a_ops->readpage(page);
	if (err) {
		ClearPageChecked(page);
		ClearPagePrivate(page);
		put_page(page);
		return NULL;
	}
	lock_page(page);
	ClearPageChecked(page);
	ClearPagePrivate(page);
	if (page->mapping == NULL) {
		/* truncate got there first */
		unlock_page(page);
		put_page(page);
		return NULL;
	}
	if (PageError(page)) {
		/* IO error */
		unlock_page(page);
		put_page(page);
		return NULL;
	}
	return page;			/* It's locked */
	

You'll see that the timing window here for invalidate_inode_pages() is very
small - invalidate has to come in at the exact right time after the page has
come unlocked so that its trylock wins the race against this function.

So I'd suggest that to get the cramfs_releasepage() code path tested you'd
need to do:

	wait_on_page_locked();
	msleep(1);
	lock_page()

above, to give invalidate a wider window to hit.

> +		if (blocknr + i < devsize) {
> +			page = cramfs_read_getpage(mapping, blocknr + i);
> +			if (page) {
> +				memcpy(data, kmap_atomic(page, KM_USER0), PAGE_CACHE_SIZE);
> +				kunmap_atomic(page, KM_USER0);

kunmap_atomic() takes the virtual address, not a page*

	void *kaddr = kmap_atomic(...);
	memcpy(..., kaddr, ...);
	kunmap_atomic(kaddr);

As to why it's leaking: dunno, sorry.  It looks OK.
