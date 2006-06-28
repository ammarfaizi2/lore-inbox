Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWF1TWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWF1TWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWF1TWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:22:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30443 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751051AbWF1TWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:22:46 -0400
Date: Wed, 28 Jun 2006 12:22:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]: ufs: truncate should allocate block for last byte
Message-Id: <20060628122238.65f6296b.akpm@osdl.org>
In-Reply-To: <20060628152450.GA16996@rain.homenetwork>
References: <20060628093851.GA1719@rain.homenetwork>
	<20060628045029.bc10d333.akpm@osdl.org>
	<20060628152450.GA16996@rain.homenetwork>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 19:24:50 +0400
Evgeniy Dushistov <dushistov@mail.ru> wrote:

> On Wed, Jun 28, 2006 at 04:50:29AM -0700, Andrew Morton wrote:
> > On Wed, 28 Jun 2006 13:38:51 +0400
> > > +	if (unlikely(!page->mapping || !page_has_buffers(page))) {
> > > +		unlock_page(page);
> > > +		page_cache_release(page);
> > > +		goto try_again;/*we really need these buffers*/
> > > +	}
> > > +out:
> > > +	return page;
> > > +}
> > 
> > I think there's a (preexisting) problem here.  When one thread is executing
> > ufs_get_locked_page() while a second thread is running truncate().
> > 
> > If truncate got to the page first, truncate_complete_page() will mark the
> > page !uptodate and will later unlock it.  Now this function gets the page
> > lock and emits a printk (bad) and assumes -EIO (worse).
> > 
> > That scenario might not be possible because of i_mutex coverage, dunno.
> > 
> I suppose this is possible because of 
> a)page may be mapped to hole
> b)sys_msync doesn't use i_mutex
> c)in case of block allocation we can call ufs_get_locked_page

OK.

> > But if it _is_ possible, it can be simply fixed by doing
> > 
> But you added such check "!page->mapping" into ufs_get_locked_page,
> is it not enough?

That is what I was proposing, here:

> > 	lock_page(page);
> > +	if (page->mapping == NULL) {
> > +		/* truncate() got there first */
> > +		page_cache_release(page);
> > +		goto try_again;
> > +	}

