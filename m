Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265965AbUFJA6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbUFJA6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUFJA6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:58:42 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44230 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265965AbUFJA6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:58:35 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Thu, 10 Jun 2004 03:02:36 +0200
User-Agent: KMail/1.5.3
Cc: axboe@suse.de, edt@aei.ca, linux-kernel@vger.kernel.org
References: <1085689455.7831.8.camel@localhost> <200406100220.28076.bzolnier@elka.pw.edu.pl> <20040609173733.1aac8e0d.akpm@osdl.org>
In-Reply-To: <20040609173733.1aac8e0d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406100302.36208.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 of June 2004 02:37, Andrew Morton wrote:
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > On Thursday 10 of June 2004 01:50, Andrew Morton wrote:
> > > Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > > > Does journal has checksum or some other protection against failure
> > > > during writing journal to a disk?  If not than it still can be
> > > > screwed even with ordered writes if we are unfortunate enough.  ;-)
> > >
> > > A transaction is written to disk as two synchronous operations: write
> > > all the data, wait on it, write the single commit block, wait on that.
> >
> > That is how it looks from fs side, from disk side it may look like this:
> >
> > write some data sectors (rest stays in cache)
> > write rest of data sectors (from cache)
> > write some commit sectors (rest stays in cache)
> > write rest of commit sectors (from cache)
> >
> > fs atomic operations != disk atomic operations
>
> JBD is careful about that.  There is a single commit block (1, 2 or 4k) and
> the first eight bytes of that block contain a magic number and a sequence
> number.  If they're not both valid then replay considers the entire
> transaction (data blocks + commit block) to be invalid.
>
> So all we care about is the atomicity of the first eight bytes of a single
> 512-byte sector.  I see no problem with internal-to-commit-block write
> reordering.

OK, thanks for explaining this.

> The problem is that the commit block may hit disk prior to the preceding
> data blocks, which is why we need a full flush prior to submitting the
> commit block.

Yes, yes, this is really obvious for me.
I was also worried about write cache vs commit block write.

> > > If the commit block were to hit disk before the data then we have a
> > > window in which poweroff+recovery would replay garbage into the
> > > filesystem.
> >
> > Yes.
> >
> > The quoted part of my mail is about situation when poweroff happens
> > between 'write some commit sectors' and 'write rest of commit sectors
> > (from cache)' or during transferring commit sectors to a disk.
>
> There is just a single commit sector.

Only one 512-bytes sector?  Good!

> > Sure.  What's your opinion about doing blk_issue_flush() and ordinary
> > commit (pros+cons given in my previous mail)?
>
> I think we need:
>
> 	submit_data_sectors();
> 	blkdev_issue_flush();
> 	wait_on_data_sectors();
>
> 	/*
> 	 * All of the transaction's data sectors are now on disk.  Submit the
> 	 * commit sector
> 	 */
> 	mark_buffer_ordered(commit_bh);

Ordered write is not really needed because the next
'data cycle' will provide us with needed ordering.

submit_data_sectors();
blkdev_issue_flush();

^^^
flushes previous commit before the new one is submitted

wait_on_data_sectors();

> 	submit_bh(commit_bh);
> 	wait_on_buffer(commit_bh);
>
> Or something like that.  Haven't really looked at the blkdev_issue_flush()
> design yet.  It has this mysterious comment: "Caller must run
> wait_for_completion() on its own.".   Wait for what completion??

