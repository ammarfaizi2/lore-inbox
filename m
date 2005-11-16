Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbVKPVb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbVKPVb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVKPVb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:31:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030510AbVKPVb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:31:57 -0500
Date: Wed, 16 Nov 2005 13:31:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Message-Id: <20051116133130.625cd19b.akpm@osdl.org>
In-Reply-To: <1132171500.8811.37.camel@lade.trondhjem.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	<1132163057.8811.15.camel@lade.trondhjem.org>
	<20051116100053.44d81ae2.akpm@osdl.org>
	<1132166062.8811.30.camel@lade.trondhjem.org>
	<20051116110938.1bf54339.akpm@osdl.org>
	<1132171500.8811.37.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Wed, 2005-11-16 at 11:09 -0800, Andrew Morton wrote:
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > >
> > > On Wed, 2005-11-16 at 10:00 -0800, Andrew Morton wrote:
> > > 
> > > > That will fix it, but the PageWriteback accounting is still wrong.
> > > > 
> > > > Is it not possible to use set_page_writeback()/end_page_writeback()?
> > > 
> > > Not really. The pages aren't flushed at this time. We the point is to
> > > gather several pages and coalesce them into one over-the-wire RPC call.
> > > That means we cannot really do it from inside ->writepage().
> > > 
> > 
> > I still don't get it.
> > 
> > Once nfs_writepage() has been called, the page is conceptually "under
> > writeback", yes?  In that, at some point in the future, it will be written
> > to backing store.
> > 
> > Hence it's perfectly appropriate to run set_page_writepage() within
> > nfs_writepage().  It's a matter of finding the right place for the
> > end_page_writeback().
> 
> The point is that the process of flushing has not been started at that
> time, so anybody that calls wait_on_page_writeback() immediately after
> calling writepage() may end up waiting for a very long time indeed
> (probably until the next pdflush).

But block-backed filesytems have the same concern: we don't want to do a
whole bunch of 4k I/Os.  Hence the writepages() interface, which is the
appropriate place to be building up these large I/Os.

NFS does nfw_writepages->mpage_writepages->nfs_writepage and to build the
large I/Os it leaves the I/O pending on return from nfs_writepage().  It
appears to flush any pending pages on the exit path from nfs_writepages().

If that's a correct reading then there doesn't appear to be any way in
which there's dangling I/O left to do after nfs_writepages() completes.

If there _is_ dandling I/O left over then that's problematic, and probably
doesn't buy us much in the way of performance benefit.
