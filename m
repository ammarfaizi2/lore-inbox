Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265994AbUFJAQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUFJAQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUFJAQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:16:35 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14274 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265994AbUFJAQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:16:33 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Thu, 10 Jun 2004 02:20:28 +0200
User-Agent: KMail/1.5.3
Cc: axboe@suse.de, edt@aei.ca, linux-kernel@vger.kernel.org
References: <1085689455.7831.8.camel@localhost> <200406100138.18028.bzolnier@elka.pw.edu.pl> <20040609165007.78dd8420.akpm@osdl.org>
In-Reply-To: <20040609165007.78dd8420.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406100220.28076.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 of June 2004 01:50, Andrew Morton wrote:
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > Does journal has checksum or some other protection against failure during
> > writing journal to a disk?  If not than it still can be screwed even with
> > ordered writes if we are unfortunate enough.  ;-)
>
> A transaction is written to disk as two synchronous operations: write all
> the data, wait on it, write the single commit block, wait on that.

That is how it looks from fs side, from disk side it may look like this:

write some data sectors (rest stays in cache)
write rest of data sectors (from cache)
write some commit sectors (rest stays in cache)
write rest of commit sectors (from cache)

fs atomic operations != disk atomic operations

> If the commit block were to hit disk before the data then we have a window
> in which poweroff+recovery would replay garbage into the filesystem.

Yes.

The quoted part of my mail is about situation when poweroff happens between
'write some commit sectors' and 'write rest of commit sectors (from cache)'
or during transferring commit sectors to a disk.

In both situations we end up with corrupted journal.

> So I think we have a bug in the current ext3 barrier implementation - we
> need a blk_issue_flush() before submitting the buffer_ordered commit block.

Sure.  What's your opinion about doing blk_issue_flush() and ordinary commit
(pros+cons given in my previous mail)?

> > > > - if you more than > 1 filesystem on the disk (quite likely scenario)
> > > > it can happen that barrier (flush) will fail for sector for file from
> > > > the other fs and later barrier for this other fs will succeed
> > >
> > > I don't understand this one.
> >
> > Flush command can fail for sector which came into disk's write cache
> > from some write request for some other fs on the same disk i.e.
>
> Oh, you're referring to actual I/O errors?  I tend to think all bets are
> off if that happens - make sure we report it to the application, avoid
> crashing the kernel and hope that fsck can get the data back...

Yes but things get more complicated with write caching on a disk side,
i.e. it is too late to report to application when you discover I/O error.

