Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266058AbUFJAfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUFJAfY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUFJAfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:35:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:27809 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266058AbUFJAfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:35:00 -0400
Date: Wed, 9 Jun 2004 17:37:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: axboe@suse.de, edt@aei.ca, linux-kernel@vger.kernel.org
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-Id: <20040609173733.1aac8e0d.akpm@osdl.org>
In-Reply-To: <200406100220.28076.bzolnier@elka.pw.edu.pl>
References: <1085689455.7831.8.camel@localhost>
	<200406100138.18028.bzolnier@elka.pw.edu.pl>
	<20040609165007.78dd8420.akpm@osdl.org>
	<200406100220.28076.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> On Thursday 10 of June 2004 01:50, Andrew Morton wrote:
> > Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > > Does journal has checksum or some other protection against failure during
> > > writing journal to a disk?  If not than it still can be screwed even with
> > > ordered writes if we are unfortunate enough.  ;-)
> >
> > A transaction is written to disk as two synchronous operations: write all
> > the data, wait on it, write the single commit block, wait on that.
> 
> That is how it looks from fs side, from disk side it may look like this:
> 
> write some data sectors (rest stays in cache)
> write rest of data sectors (from cache)
> write some commit sectors (rest stays in cache)
> write rest of commit sectors (from cache)
> 
> fs atomic operations != disk atomic operations

JBD is careful about that.  There is a single commit block (1, 2 or 4k) and
the first eight bytes of that block contain a magic number and a sequence
number.  If they're not both valid then replay considers the entire
transaction (data blocks + commit block) to be invalid.

So all we care about is the atomicity of the first eight bytes of a single
512-byte sector.  I see no problem with internal-to-commit-block write
reordering.

The problem is that the commit block may hit disk prior to the preceding
data blocks, which is why we need a full flush prior to submitting the
commit block.

> > If the commit block were to hit disk before the data then we have a window
> > in which poweroff+recovery would replay garbage into the filesystem.
> 
> Yes.
> 
> The quoted part of my mail is about situation when poweroff happens between
> 'write some commit sectors' and 'write rest of commit sectors (from cache)'
> or during transferring commit sectors to a disk.

There is just a single commit sector.

> Sure.  What's your opinion about doing blk_issue_flush() and ordinary commit
> (pros+cons given in my previous mail)?

I think we need:

	submit_data_sectors();
	blkdev_issue_flush();
	wait_on_data_sectors();

	/*
	 * All of the transaction's data sectors are now on disk.  Submit the
	 * commit sector
	 */
	mark_buffer_ordered(commit_bh);
	submit_bh(commit_bh);
	wait_on_buffer(commit_bh);

Or something like that.  Haven't really looked at the blkdev_issue_flush()
design yet.  It has this mysterious comment: "Caller must run
wait_for_completion() on its own.".   Wait for what completion??
