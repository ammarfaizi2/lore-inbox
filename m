Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUC3TTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbUC3TTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:19:20 -0500
Received: from ns.suse.de ([195.135.220.2]:7303 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263889AbUC3TSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:18:06 -0500
Subject: Re: [PATCH] barrier patch set
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1080662685.1978.25.camel@sisko.scot.redhat.com>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
	 <1080662685.1978.25.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Message-Id: <1080674384.3548.36.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 14:19:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 11:04, Stephen C. Tweedie wrote:

[ barriers vs ordered writes ]

> The distinction becomes important if flushing and barriers have
> significantly different performance characteristics.  In the SCSI tagged
> command case, we can insert an ORDERED queue tag into the pipeline
> without having to wait for anything.  But if we implement the barrier
> and the flush by the same mechanism, then the fs ends up waiting; we get
> 
> 	write log blocks
> 	wait for IO queue to empty
> 	write commit block
> 	wait for IO queue to empty
> 
> instead of
> 
> 	write log blocks
> 	write commit block with ORDERED tag set
> 
> so the commits are miles slower.
> 
I think we're mixing a few concepts together.  submit_bh(WRITE_BARRIER,
bh) gives us an ordered write in whatever form the lower layers can
provide.  It also ensures that if you happen to call wait_on_buffer()
for the barrier buffer, the wait won't return until the data is on
media.

The construct allows for the second type of commit you describe above,
where wait_on_buffer is not called on the log blocks until after the
commit block has been sent down the pipe.  The reiserfs barrier patch
does this now.

The fact that IDE implements the barriers via a flush and that no other
layer has barriers right now is secondary ;)  I do want to revive some
kind of ordering for scsi as well, but since IDE is a safety issue right
now I wanted to concentrate there first.

> Jens' patch happens to implement barriers via flushes on IDE, but at the
> block layer blkdev_issue_flush() and set_buffer_ordered() are quite
> distinct APIs.

Yes, they are completely different.  blkdev_issue_flush is the kernel
recognizing that wait_on_buffer (or page or whatever) isn't always
enough to make sure writes are really done.  It has no ordering
semantics at all, it just means "really write what you've already told
me is written, unless you promise via battery backed cache that it will
get to disk eventually"

(roughly)

-chris


