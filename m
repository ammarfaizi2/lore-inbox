Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUABEfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 23:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbUABEfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 23:35:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:9859 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264359AbUABEff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 23:35:35 -0500
Date: Thu, 1 Jan 2004 20:36:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] filemap_fdatawait.patch
Message-Id: <20040101203612.15debff2.akpm@osdl.org>
In-Reply-To: <20040102042036.GA3311@in.ibm.com>
References: <20031231095503.GA4069@in.ibm.com>
	<20031231015913.34fc0176.akpm@osdl.org>
	<20031231100949.GA4099@in.ibm.com>
	<20031231021042.5975de04.akpm@osdl.org>
	<20031231104801.GB4099@in.ibm.com>
	<20031231025309.6bc8ca20.akpm@osdl.org>
	<20031231025410.699a3317.akpm@osdl.org>
	<20031231031736.0416808f.akpm@osdl.org>
	<1072910061.712.67.camel@ibm-c.pdx.osdl.net>
	<20031231154239.7c4d140e.akpm@osdl.org>
	<20040102042036.GA3311@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> On Wed, Dec 31, 2003 at 03:42:39PM -0800, Andrew Morton wrote:
> > Daniel McNeil <daniel@osdl.org> wrote:
> > >
> > > The other potential race in filemap_fdatawait() was that it
> > > removed the page from the locked list while waiting for a writeback
> > > and if there was a 2nd filemap_fdatawait() running on another cpu,
> > > it would not wait for the page being written since it would never see
> > > it on the list.
> > 
> > That would only happen if one thread or the other was not running under
> > i_sem.   The only path I see doing that is in generic_file_direct_IO()?
> 
> Yes, and we should simply fix generic_file_direct_IO to avoid doing so.
> We anyway issue filemap_fdatawait later with i_sem held.
> 
> The race that we need to worry about is between background writeouts
> (which don't take i_sem) and filemap_fdatawrite/filemap_fdatawait - i.e
> the first one discussed.

Well Daniel has raised a second race here, betwen filemap_fdatawait() and
filemap_fdatwait().  The background writeback code does not execute
filemap_datawait() anyway, so no prob.

Yes, extending i_sem coverage in the case O_DIRECT reads should suit.  In
the (vastly) common case mapping->nrpages is zero anyway, so we shouldn't
even enter that code.

> > > +		/*
> > > +		 * If the page is locked, it might be in process of being 
> > > +		 * setup for writeback but without PG_writeback set 
> > > +		 * and with PG_dirty cleared.
> > > +		 * (PG_dirty is cleared BEFORE PG_writeback is set)
> > > +		 * So, wait for the PG_locked to clear, then start over.
> > > +		 */
> > > +		if (PageLocked(page)) {
> > > +			page_cache_get(page);
> > > +			spin_unlock(&mapping->page_lock);
> > > +			wait_on_page_locked(page);
> > > +			page_cache_release(page);
> > > +			goto restart;
> > > +		}
> > 
> > Why is this a problem which needs addressing here?  If some other thread is
> > in the process of starting I/O against this page then the page must have
> > been clean when this thread ran filemap_fdatawrite()?
> 
> This is the same race that we have been discussing (background writer
> pulled this page off io_pages, put it on locked pages but hasn't set 
> PG_writeback as yet). To me it seemed that Daniel's solution was just an 
> alternative to what you proposed - i.e. adding lock_page() to filemap_fdatawait.
> I have to think a little about the fix -- AFAICS but we are all talking
> about the same (real) problem here.

Yup.  Realish, anyway.  Unless we can demonstrate that this is the cause of
the O_DIRECT data-exposure problems, this race isn't really very
interesting.  It should be plugged though I guess.

