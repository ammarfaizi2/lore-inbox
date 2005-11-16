Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbVKPWLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbVKPWLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbVKPWLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:11:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030523AbVKPWLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:11:18 -0500
Date: Wed, 16 Nov 2005 14:10:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Message-Id: <20051116141052.7994ab7d.akpm@osdl.org>
In-Reply-To: <1132177785.8811.57.camel@lade.trondhjem.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	<1132163057.8811.15.camel@lade.trondhjem.org>
	<20051116100053.44d81ae2.akpm@osdl.org>
	<1132166062.8811.30.camel@lade.trondhjem.org>
	<20051116110938.1bf54339.akpm@osdl.org>
	<1132171500.8811.37.camel@lade.trondhjem.org>
	<20051116133130.625cd19b.akpm@osdl.org>
	<1132177785.8811.57.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Wed, 2005-11-16 at 13:31 -0800, Andrew Morton wrote:
> > But block-backed filesytems have the same concern: we don't want to do a
> > whole bunch of 4k I/Os.  Hence the writepages() interface, which is the
> > appropriate place to be building up these large I/Os.
> > 
> > NFS does nfw_writepages->mpage_writepages->nfs_writepage and to build the
> > large I/Os it leaves the I/O pending on return from nfs_writepage().  It
> > appears to flush any pending pages on the exit path from nfs_writepages().
> > 
> > If that's a correct reading then there doesn't appear to be any way in
> > which there's dangling I/O left to do after nfs_writepages() completes.
> 
> Agreed. AFAICS, nfs_writepages should be quite OK, however writepage()
> on its own _is_ problematic.
> 
> Look at the usage in write_one_page(), which calls directly down to
> ->writepage(), and then immediately does a wait_on_page_writeback().
> 
> How is the filesystem supposed to distinguish between the cases
> "VM->writepage()", and "VM->writepages->mpage_writepages->writepage()"?
> 

Via the writeback_control, hopefully.

For write_one_page(), sync_mode==WB_SYNC_ALL, so NFS should start the I/O
immediately (it appears to not do so).

For vmscan->writepage, wbc->for_reclaim is set, so we know that the IO
should be pushed immediately.  nfs_writepage() seems to dtrt here.

With the proposed changes, we don't need that iput() in nfs_writepage(). 
That worries me because I recall from a couple of years back that there are
really subtle races with doing iput() on the vmscan->writepage() path. 
Cannot remember what they were though...
