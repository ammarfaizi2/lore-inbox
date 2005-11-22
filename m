Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVKVA2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVKVA2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVKVA2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:28:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964796AbVKVA2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:28:51 -0500
Date: Mon, 21 Nov 2005 16:28:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
Message-Id: <20051121162837.1a952543.akpm@osdl.org>
In-Reply-To: <1132618731.8011.46.camel@lade.trondhjem.org>
References: <20051121213913.61220.qmail@web34115.mail.mud.yahoo.com>
	<1132612974.8011.12.camel@lade.trondhjem.org>
	<20051121153454.1907d92a.akpm@osdl.org>
	<1132617503.8011.35.camel@lade.trondhjem.org>
	<20051121160913.6d59c9fa.akpm@osdl.org>
	<1132618731.8011.46.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Mon, 2005-11-21 at 16:09 -0800, Andrew Morton wrote:
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > >
> > > The only difference I can see between the two paths is the call to
> > >  unmap_mapping_range(). What effect would that have?
> > 
> > It shoots down any mapped pagecache over the affected file region.  Because
> > the direct-io write is about to make that pagecache out-of-date.  If the
> > application tries to use that data again it'll get a major fault and will
> > re-read the file contents.
> 
> I assume then, that this couldn't be the cause of the
> invalidate_inode_pages() failing to complete?

It sounds unlikely.  This hang is associated with crossing the 2G boundary
isn't it?

I don't think we've seen a sysrq-T trace from the hang?

> Unless there is some
> method to prevent applications from faulting in the page while we're
> inside generic_file_direct_IO(), then the same race would be able to
> occur there.

Yes, there are still windows.

Another thing the unmap_mapping_range() does is to push pte-dirty bits into
the software-dirty flags, so the modified data does get written.  If we
didn't do this, a page which was dirtied via mmap before the direct-io
write would get written back _after_ the direct-io write, arguably causing
corruption.
