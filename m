Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUFIXuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUFIXuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUFIXup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:50:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:1667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266198AbUFIXra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:47:30 -0400
Date: Wed, 9 Jun 2004 16:50:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: axboe@suse.de, edt@aei.ca, linux-kernel@vger.kernel.org
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-Id: <20040609165007.78dd8420.akpm@osdl.org>
In-Reply-To: <200406100138.18028.bzolnier@elka.pw.edu.pl>
References: <1085689455.7831.8.camel@localhost>
	<200406092352.18470.bzolnier@elka.pw.edu.pl>
	<20040609150658.5e5e6653.akpm@osdl.org>
	<200406100138.18028.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> Does journal has checksum or some other protection against failure during
> writing journal to a disk?  If not than it still can be screwed even with
> ordered writes if we are unfortunate enough.  ;-)

A transaction is written to disk as two synchronous operations: write all
the data, wait on it, write the single commit block, wait on that.

If the commit block were to hit disk before the data then we have a window
in which poweroff+recovery would replay garbage into the filesystem.

So I think we have a bug in the current ext3 barrier implementation - we
need a blk_issue_flush() before submitting the buffer_ordered commit block.


> > > - if you more than > 1 filesystem on the disk (quite likely scenario) it
> > >   can happen that barrier (flush) will fail for sector for file from the
> > >   other fs and later barrier for this other fs will succeed
> >
> > I don't understand this one.
> 
> Flush command can fail for sector which came into disk's write cache
> from some write request for some other fs on the same disk i.e.

Oh, you're referring to actual I/O errors?  I tend to think all bets are
off if that happens - make sure we report it to the application, avoid
crashing the kernel and hope that fsck can get the data back...
