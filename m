Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbVKPWvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbVKPWvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbVKPWvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:51:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030552AbVKPWvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:51:16 -0500
Date: Wed, 16 Nov 2005 14:50:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Message-Id: <20051116145053.42c0ec5a.akpm@osdl.org>
In-Reply-To: <1132180688.8811.78.camel@lade.trondhjem.org>
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
	<1132180688.8811.78.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Wed, 2005-11-16 at 17:23 -0500, Trond Myklebust wrote:
> > On Wed, 2005-11-16 at 14:10 -0800, Andrew Morton wrote:
> > 
> > > > How is the filesystem supposed to distinguish between the cases
> > > > "VM->writepage()", and "VM->writepages->mpage_writepages->writepage()"?
> > > > 
> > > 
> > > Via the writeback_control, hopefully.
> > > 
> > > For write_one_page(), sync_mode==WB_SYNC_ALL, so NFS should start the I/O
> > > immediately (it appears to not do so).
> > 
> > Sorry, but so does filemap_fdatawrite(). WB_SYNC_ALL clearly does not
> > discriminate between a writepages() and a single writepage() situation,
> > whatever the original intention was.
> 
> IMHO, the correct way to distinguish between the two would be to use the
> wbc->nr_to_write field. If all the instances of writepage() were to set
> that field to '1', then the filesystems could do the right thing.

yes, except ->writepages is supposed to decrement nr_to_write as it proceeds,
so it'll end up at `1' by accident on the last go around the loop.

I think a separate boolean is better - it's just a single bit.

> As it is, you have shrink_list() that sets it to the value
> "SWAP_CLUSTER_MAX" for no apparent reason...

How weird.  That's presumably wrong, but I'd need to check the changelogs
to doublecheck.  ugh, 264 of them.
