Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbVKQAiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbVKQAiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbVKQAiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:38:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161048AbVKQAiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:38:51 -0500
Date: Wed, 16 Nov 2005 16:38:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Message-Id: <20051116163826.3cbbb3bb.akpm@osdl.org>
In-Reply-To: <1132187281.11869.1.camel@lade.trondhjem.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	<1132163057.8811.15.camel@lade.trondhjem.org>
	<20051116100053.44d81ae2.akpm@osdl.org>
	<1132166062.8811.30.camel@lade.trondhjem.org>
	<20051116110938.1bf54339.akpm@osdl.org>
	<1132171500.8811.37.camel@lade.trondhjem.org>
	<20051116133130.625cd19b.akpm@osdl.org>
	<1132177785.8811.57.camel@lade.trondhjem.org>
	<20051116141052.7994ab7d.akpm@osdl.org>
	<1132179796.8811.70.camel@lade.trondhjem.org>
	<20051116144450.47436560.akpm@osdl.org>
	<1132185969.8811.106.camel@lade.trondhjem.org>
	<20051116162516.61cb1e6b.akpm@osdl.org>
	<1132187281.11869.1.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Wed, 2005-11-16 at 16:25 -0800, Andrew Morton wrote:
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > >
> > > The accompanying NFS patch makes use of this in order to figure out when
> > >  to flush the data correctly.
> > 
> > OK.  So with that patch, nfs_writepages() may still leave I/O pending,
> > uninitiated, yes?

This?

I don't know if it'll be a problem.  One factor is that when the VFS is
doing an fsync() or whatever, it will fail to notice these left-over pages
are "dirty", so it won't launch writepage() against them.

But if they are marked PageWriteback(), sync will notice them on the second
pass and will wait upon them, which apparently could mean a stall until
pdflush kicks off the I/O?

If they're not marked PageDirty() or PageWriteback(), the VFS will miss
them altogether during the sync.  But perhaps NFS's own page tracking will
flush them and wait upon the result?

> > I don't understand why NFS hasn't been BUGging as it stands at present.  It
> > has several end_page_writeback() calls but no set_page_writeback()s. 
> > end_page_writeback() or rotate_reclaimable_page() will go BUG if the page
> > wasn't PageWriteback().
> 
> It does have SetPageWriteback() calls in the asynchronous writeback
> path. As you can see from the patch I just sent, I only needed to
> replace them with set_page_writebacks().

Ah, OK.   Things are improved.
