Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265345AbUABHbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 02:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUABHbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 02:31:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:2027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265345AbUABHbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 02:31:07 -0500
Date: Thu, 1 Jan 2004 23:31:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-Id: <20040101233148.54fa1cc4.akpm@osdl.org>
In-Reply-To: <20040102055020.GA3410@in.ibm.com>
References: <20031231091828.GA4012@in.ibm.com>
	<20031231013521.79920efd.akpm@osdl.org>
	<20031231095503.GA4069@in.ibm.com>
	<20031231015913.34fc0176.akpm@osdl.org>
	<20031231100949.GA4099@in.ibm.com>
	<20031231021042.5975de04.akpm@osdl.org>
	<20031231104801.GB4099@in.ibm.com>
	<20031231025309.6bc8ca20.akpm@osdl.org>
	<20031231025410.699a3317.akpm@osdl.org>
	<20031231031736.0416808f.akpm@osdl.org>
	<20040102055020.GA3410@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> On Wed, Dec 31, 2003 at 03:17:36AM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Let me actually think about this a bit.
> > 
> > Nasty.  The same race is present in 2.4.x...
> > 
> > How's about we start new I/O in filemap_fdatawait() if the page is dirty?
> > 
> 
> Makes sense to me.
> There's a chance that this could explain why Daniel saw exposures even 
> with his fix. 
> 
> Would be interesting to see his results with your patch.
> 
> Though we might as well plug this anyway ?

Yes, we should.  I'm not dreadfully keen on starting I/O from within
filemap_fdatawait() though - it seems "wrong" somehow.

> > 
> > diff -puN mm/filemap.c~a mm/filemap.c
> > --- 25/mm/filemap.c~a	2003-12-31 03:10:29.000000000 -0800
> > +++ 25-akpm/mm/filemap.c	2003-12-31 03:17:05.000000000 -0800
> > @@ -206,7 +206,13 @@ restart:
> >  		page_cache_get(page);
> >  		spin_unlock(&mapping->page_lock);
> >  
> > -		wait_on_page_writeback(page);
> > +		lock_page(page);
> > +		if (PageDirty(page) && mapping->a_ops->writepage) {
> > +			write_one_page(page, 1);
> > +		} else {
> > +			wait_on_page_writeback(page);
> > +			unlock_page(page);
> 
> Would we lose anything if we unlock_page() before wait_on_page_writeback() ?

No, that should be OK.


