Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUC3WOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUC3WOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:14:05 -0500
Received: from ns.suse.de ([195.135.220.2]:25240 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261429AbUC3WOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:14:00 -0500
Subject: Re: [PATCH] barrier patch set
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1080683417.1978.53.camel@sisko.scot.redhat.com>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
	 <1080662685.1978.25.camel@sisko.scot.redhat.com>
	 <1080674384.3548.36.camel@watt.suse.com>
	 <1080683417.1978.53.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Message-Id: <1080684797.3546.85.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 17:13:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 16:50, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2004-03-30 at 20:19, Chris Mason wrote:
> 
> 
> > I think we're mixing a few concepts together.  submit_bh(WRITE_BARRIER,
> > bh) gives us an ordered write in whatever form the lower layers can
> > provide.  It also ensures that if you happen to call wait_on_buffer()
> > for the barrier buffer, the wait won't return until the data is on
> > media.
> 
> Right, but that's just how it works right now --- one doesn't _have_ to
> imply the other.  You could easily imagine an implementation that
> implements barriers and flushing separately, and which does not do
> automatic flushing on completion of WRITE_BARRIER IOs.  SCSI with
> writeback caching enabled might be one example of that.  NBD/DRBD would
> be another likely candidate --- if you've got network latencies in the
> way, then a flushing sync may be far more expensive than a barrier
> propagation.
> 
Yes, that's true, although the barriers don't really imply a flush, it
just implies that if you do use wait_on_* for flushing, it will report
things accurately.

> Unfortunately, a lot of the cases we care about really have to do the
> barrier via flushing, so the benefit of keeping them separate is
> limited.  For LVM/raid0, for example, we've got no way of preserving
> ordering between IOs on different drives, so a flush is necessary there
> unless we start journaling the low-level IOs to preserve order.
> 
Right.

> Yep.  It scares me to think what performance characteristics we'll start
> seeing once that gets used everywhere it's needed, though.  If every raw
> or O_DIRECT write needs a flush after it, databases are going to become
> very sensitive to flush performance.  I guess disabling the flushing and
> using disks which tell the truth about data hitting the platter is the
> sane answer there.

Most database benchmarks are done on scsi, and the blkdev_flush should
be a noop there.  For IDE based database and mail server benchmarks, the
results won't be pretty.  

The reiserfs fsync code tries hard to only flush once, so if a commit is
done then blkdev_flush isn't called.  We might have to do a few other
tricks to queue up multiple synchronous ios and only flush once.

-chris




