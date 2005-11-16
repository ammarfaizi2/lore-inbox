Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbVKPWXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbVKPWXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030532AbVKPWXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:23:33 -0500
Received: from pat.uio.no ([129.240.130.16]:21953 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030539AbVKPWXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:23:33 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051116141052.7994ab7d.akpm@osdl.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	 <1132163057.8811.15.camel@lade.trondhjem.org>
	 <20051116100053.44d81ae2.akpm@osdl.org>
	 <1132166062.8811.30.camel@lade.trondhjem.org>
	 <20051116110938.1bf54339.akpm@osdl.org>
	 <1132171500.8811.37.camel@lade.trondhjem.org>
	 <20051116133130.625cd19b.akpm@osdl.org>
	 <1132177785.8811.57.camel@lade.trondhjem.org>
	 <20051116141052.7994ab7d.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 17:23:16 -0500
Message-Id: <1132179796.8811.70.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.959, required 12,
	autolearn=disabled, AWL 1.04, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 14:10 -0800, Andrew Morton wrote:

> > How is the filesystem supposed to distinguish between the cases
> > "VM->writepage()", and "VM->writepages->mpage_writepages->writepage()"?
> > 
> 
> Via the writeback_control, hopefully.
> 
> For write_one_page(), sync_mode==WB_SYNC_ALL, so NFS should start the I/O
> immediately (it appears to not do so).

Sorry, but so does filemap_fdatawrite(). WB_SYNC_ALL clearly does not
discriminate between a writepages() and a single writepage() situation,
whatever the original intention was.

> For vmscan->writepage, wbc->for_reclaim is set, so we know that the IO
> should be pushed immediately.  nfs_writepage() seems to dtrt here.
> 
> With the proposed changes, we don't need that iput() in nfs_writepage(). 
> That worries me because I recall from a couple of years back that there are
> really subtle races with doing iput() on the vmscan->writepage() path. 
> Cannot remember what they were though...

Possibly to do with block filesystems that may trigger ->writepage()
while inside iput_final()? NFS can't do that.

Cheers,
  Trond

