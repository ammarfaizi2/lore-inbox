Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUFJPQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUFJPQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 11:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUFJPQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 11:16:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39566 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261606AbUFJPQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 11:16:02 -0400
Date: Thu, 10 Jun 2004 17:15:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, edt@aei.ca,
       linux-kernel@vger.kernel.org
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040610151540.GO13836@suse.de>
References: <1085689455.7831.8.camel@localhost> <200406092352.18470.bzolnier@elka.pw.edu.pl> <20040609150658.5e5e6653.akpm@osdl.org> <200406100138.18028.bzolnier@elka.pw.edu.pl> <20040609165007.78dd8420.akpm@osdl.org> <1086827287.10973.305.camel@watt.suse.com> <20040609173856.4463e36f.akpm@osdl.org> <1086880447.10973.333.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086880447.10973.333.camel@watt.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10 2004, Chris Mason wrote:
> On Wed, 2004-06-09 at 20:38, Andrew Morton wrote:
> > Chris Mason <mason@suse.com> wrote:
> > >
> > > On Wed, 2004-06-09 at 19:50, Andrew Morton wrote:
> > > > Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > > > >
> > > > > Does journal has checksum or some other protection against failure during
> > > > > writing journal to a disk?  If not than it still can be screwed even with
> > > > > ordered writes if we are unfortunate enough.  ;-)
> > > > 
> > > > A transaction is written to disk as two synchronous operations: write all
> > > > the data, wait on it, write the single commit block, wait on that.
> > > > 
> > > > If the commit block were to hit disk before the data then we have a window
> > > > in which poweroff+recovery would replay garbage into the filesystem.
> > > > 
> > > > So I think we have a bug in the current ext3 barrier implementation - we
> > > > need a blk_issue_flush() before submitting the buffer_ordered commit block.
> > > 
> > > The IDE barriers are both a pre and post flush.  If the commit block is
> > > ordered, before the commit block hits the disk we know all the blocks
> > > previously submitted are also on disk.
> > > 
> > 
> > Oh, OK.  Will the same apply to (for example) scsi?
> 
> For scsi the general expectation is that write cache will be off unless
> it is battery backed.  blkdev_issue_flush does go down to scsi, but I'm
> not sure about the regular WRITE_BARRIER stuff.  Jens?

That's right, blkdev_issue_flush() works but barriers don't yet. The
usual error handling story.

-- 
Jens Axboe

