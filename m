Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUFJPNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUFJPNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 11:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUFJPNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 11:13:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:53464 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261582AbUFJPNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 11:13:36 -0400
Subject: Re: ide errors in 7-rc1-mm1 and later
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, axboe@suse.de, edt@aei.ca,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040609173856.4463e36f.akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost>
	 <200406092352.18470.bzolnier@elka.pw.edu.pl>
	 <20040609150658.5e5e6653.akpm@osdl.org>
	 <200406100138.18028.bzolnier@elka.pw.edu.pl>
	 <20040609165007.78dd8420.akpm@osdl.org>
	 <1086827287.10973.305.camel@watt.suse.com>
	 <20040609173856.4463e36f.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086880447.10973.333.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Jun 2004 11:14:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 20:38, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > On Wed, 2004-06-09 at 19:50, Andrew Morton wrote:
> > > Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > > >
> > > > Does journal has checksum or some other protection against failure during
> > > > writing journal to a disk?  If not than it still can be screwed even with
> > > > ordered writes if we are unfortunate enough.  ;-)
> > > 
> > > A transaction is written to disk as two synchronous operations: write all
> > > the data, wait on it, write the single commit block, wait on that.
> > > 
> > > If the commit block were to hit disk before the data then we have a window
> > > in which poweroff+recovery would replay garbage into the filesystem.
> > > 
> > > So I think we have a bug in the current ext3 barrier implementation - we
> > > need a blk_issue_flush() before submitting the buffer_ordered commit block.
> > 
> > The IDE barriers are both a pre and post flush.  If the commit block is
> > ordered, before the commit block hits the disk we know all the blocks
> > previously submitted are also on disk.
> > 
> 
> Oh, OK.  Will the same apply to (for example) scsi?

For scsi the general expectation is that write cache will be off unless
it is battery backed.  blkdev_issue_flush does go down to scsi, but I'm
not sure about the regular WRITE_BARRIER stuff.  Jens?

It's true that we need an extra step for external journals in both ext3
and reiser.  We need extra flushes for O_SYNC and O_DIRECT as well, I
wanted to get the core basics working and API fixed before we sprinkling
flushes all over the kernel for complete coverage.

I just did some benchmarking of the two BH_Eopnotsupp patches I sent,
and for synctest -t 20 -f -n 1 dir, there's not enough difference
between barriers on and off for ext3. (1-2% at most).  It doesn't look
like ext3_sync_file is triggering commits all the time, I think we need
extra flushes there too.

Andrew, both O_SYNC and ext3 fsync rely on inode->i_state & I_DIRTY to
decide when to call write_inode(wait = 1).  What happens when a
background writeout clears I_DIRTY without triggering the commit?  Looks
like we won't wait on the transaction to complete in this case.

-chris


