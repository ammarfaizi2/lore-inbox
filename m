Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbVKQArp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbVKQArp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbVKQArp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:47:45 -0500
Received: from pat.uio.no ([129.240.130.16]:14532 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161056AbVKQArp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:47:45 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051116163826.3cbbb3bb.akpm@osdl.org>
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
	 <20051116163826.3cbbb3bb.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 19:47:26 -0500
Message-Id: <1132188446.11869.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.651, required 12,
	autolearn=disabled, AWL 1.35, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 16:38 -0800, Andrew Morton wrote:

> I don't know if it'll be a problem.  One factor is that when the VFS is
> doing an fsync() or whatever, it will fail to notice these left-over pages
> are "dirty", so it won't launch writepage() against them.

That doesn't matter. They are being tracked by the NFS client. We don't
want anyone to call writepage() against them again because that will
cause them to be written out twice.

> But if they are marked PageWriteback(), sync will notice them on the second
> pass and will wait upon them, which apparently could mean a stall until
> pdflush kicks off the I/O?
> 
> If they're not marked PageDirty() or PageWriteback(), the VFS will miss
> them altogether during the sync.  But perhaps NFS's own page tracking will
> flush them and wait upon the result?

Yes. There is no chance of data loss (unless someone physically pulls
the plug on the client - there's no protecting against that).

Note that writepages() will normally end up calling nfs_flush_inode().

It will only fail to do so if

  - generic_writepages() returns an error
or
  - there is write congestion, and wbc->nonblocking is set.

Cheers,
  Trond

