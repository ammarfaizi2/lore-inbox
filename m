Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWFAVyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWFAVyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFAVyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:54:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750703AbWFAVyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:54:55 -0400
Date: Thu, 1 Jun 2006 14:57:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-Id: <20060601145747.274df976.akpm@osdl.org>
In-Reply-To: <20060601214158.GA438@suse.de>
References: <20060529214011.GA417@suse.de>
	<20060530182453.GA8701@suse.de>
	<20060601184938.GA31376@suse.de>
	<20060601121200.457c0335.akpm@osdl.org>
	<20060601201050.GA32221@suse.de>
	<20060601142400.1352f903.akpm@osdl.org>
	<20060601214158.GA438@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
>  On Thu, Jun 01, Andrew Morton wrote:
> 
> > Olaf Hering <olh@suse.de> wrote:
> > >
> > > 
> > >  
> > > +/* return a page in PageUptodate state, BLKFLSBUF may have flushed the page */
> > > +static struct page *cramfs_read_cache_page(struct address_space *m, unsigned int n)
> > > +{
> > > +	struct page *page;
> > > +	int readagain = 5;
> > > +retry:
> > > +	page = read_cache_page(m, n, (filler_t *)m->a_ops->readpage, NULL);
> > > +	if (IS_ERR(page))
> > > +		return NULL;
> > > +	lock_page(page);
> > > +	if (PageUptodate(page))
> > > +		return page;
> > > +	unlock_page(page);
> > > +	page_cache_release(page);
> > > +	if (readagain--)
> > > +		goto retry;
> > > +	return NULL;
> > > +}
> > 
> > Better, but it's still awful, isn't it?  The things you were discussing
> > with Chris look more promising.  PG_Dirty would be a bit of a hack, but at
> > least it'd be a 100% reliable hack, whereas the above is a
> > whatever-the-previous-failure-rate-was-to-the-fifth hack.
> 
> Do you want it like that?
> 
> lock_page(page);
> if (PageUptodate(page)) {
>         SetPageDirty(page);
>         mb();
>         return page;
> }

Not really ;)  It's hacky.  It'd be better to take a lock.

I expect it'd work though, as long as...

> and perhaps a ClearPageDirty() after memcpy.

I assume this is a read-only filesystem?  I mean, if someone had really
tried to dirty the page in the meanwhile via, say, munmap or msync which
don't lock the page, we just lost their data.

