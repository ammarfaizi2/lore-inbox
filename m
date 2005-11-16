Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbVKPUFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbVKPUFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbVKPUFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:05:17 -0500
Received: from pat.uio.no ([129.240.130.16]:38307 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030481AbVKPUFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:05:16 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051116110938.1bf54339.akpm@osdl.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	 <1132163057.8811.15.camel@lade.trondhjem.org>
	 <20051116100053.44d81ae2.akpm@osdl.org>
	 <1132166062.8811.30.camel@lade.trondhjem.org>
	 <20051116110938.1bf54339.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 15:05:00 -0500
Message-Id: <1132171500.8811.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.859, required 12,
	autolearn=disabled, AWL 1.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 11:09 -0800, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > On Wed, 2005-11-16 at 10:00 -0800, Andrew Morton wrote:
> > 
> > > That will fix it, but the PageWriteback accounting is still wrong.
> > > 
> > > Is it not possible to use set_page_writeback()/end_page_writeback()?
> > 
> > Not really. The pages aren't flushed at this time. We the point is to
> > gather several pages and coalesce them into one over-the-wire RPC call.
> > That means we cannot really do it from inside ->writepage().
> > 
> 
> I still don't get it.
> 
> Once nfs_writepage() has been called, the page is conceptually "under
> writeback", yes?  In that, at some point in the future, it will be written
> to backing store.
> 
> Hence it's perfectly appropriate to run set_page_writepage() within
> nfs_writepage().  It's a matter of finding the right place for the
> end_page_writeback().

The point is that the process of flushing has not been started at that
time, so anybody that calls wait_on_page_writeback() immediately after
calling writepage() may end up waiting for a very long time indeed
(probably until the next pdflush).

Cheers,
  Trond

