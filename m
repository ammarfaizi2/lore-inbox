Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161690AbWKOVNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161690AbWKOVNB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161693AbWKOVNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:13:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161690AbWKOVNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:13:00 -0500
Date: Wed, 15 Nov 2006 13:12:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Charles Edward Lever <chucklever@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Yet another borken page_count() check in
 invalidate_inode_pages2()....
Message-Id: <20061115131256.403facca.akpm@osdl.org>
In-Reply-To: <1163624265.5880.31.camel@lade.trondhjem.org>
References: <1163568819.5645.8.camel@lade.trondhjem.org>
	<1163596689.5691.40.camel@lade.trondhjem.org>
	<20061115084641.827494be.akpm@osdl.org>
	<1163613913.5691.215.camel@lade.trondhjem.org>
	<20061115112426.84e5417c.akpm@osdl.org>
	<1163624265.5880.31.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 15:57:45 -0500
Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> On Wed, 2006-11-15 at 11:24 -0800, Andrew Morton wrote:
> 
> > The protocol is
> > 
> > 	lock_page()
> > 	set_page_writeback()
> > 	->writepage()
> 
> We're not using ->writepage().

I think you know what I mean.

> > and there are various places which assume that nobody will start new
> > writeout of a locked page.  But I forget where they are - things have always
> > been this way.
> 
> Huh? There has never been a requirement to lock the page if all you want
> to do is call set_page_writeback().

The protocol is, and always has been

	lock_page()
	set_page_writeback();
	start-io
	unlock_page();

end_io:
	end_page_writeback()


and there are places in the VM which rely upon some or all of that.  I'd
need to go on a big hunt to remember where they are.  One of them is
invalidate_inode_pages2(), as you've just discovered.

> The only reason why we want to do
> that at all is to allow the VM to track that the page is under I/O. All
> other operations involved in scheduling writes are protected by internal
> NFS locks.

Well the VM uses lock_page() for this synchronisation.  If NFS has gone and
decided not to do that then we'll need to either

a) Make NFS follow the protocol or

b) Put stuff in NFS to allow the VM to work correctly (until we change it) or

c) Put very-clearly-commented NFS exception code into the VM.

