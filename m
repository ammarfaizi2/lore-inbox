Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUC3Vwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUC3Vwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:52:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59857 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261416AbUC3Vv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:51:59 -0500
Subject: Re: [PATCH] barrier patch set
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Mason <mason@suse.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1080674384.3548.36.camel@watt.suse.com>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
	 <1080662685.1978.25.camel@sisko.scot.redhat.com>
	 <1080674384.3548.36.camel@watt.suse.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1080683417.1978.53.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Mar 2004 22:50:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2004-03-30 at 20:19, Chris Mason wrote:


> I think we're mixing a few concepts together.  submit_bh(WRITE_BARRIER,
> bh) gives us an ordered write in whatever form the lower layers can
> provide.  It also ensures that if you happen to call wait_on_buffer()
> for the barrier buffer, the wait won't return until the data is on
> media.

Right, but that's just how it works right now --- one doesn't _have_ to
imply the other.  You could easily imagine an implementation that
implements barriers and flushing separately, and which does not do
automatic flushing on completion of WRITE_BARRIER IOs.  SCSI with
writeback caching enabled might be one example of that.  NBD/DRBD would
be another likely candidate --- if you've got network latencies in the
way, then a flushing sync may be far more expensive than a barrier
propagation.

Unfortunately, a lot of the cases we care about really have to do the
barrier via flushing, so the benefit of keeping them separate is
limited.  For LVM/raid0, for example, we've got no way of preserving
ordering between IOs on different drives, so a flush is necessary there
unless we start journaling the low-level IOs to preserve order.

> The fact that IDE implements the barriers via a flush and that no other
> layer has barriers right now is secondary ;)  I do want to revive some
> kind of ordering for scsi as well, but since IDE is a safety issue right
> now I wanted to concentrate there first.

Right.

> Yes, they are completely different.  blkdev_issue_flush is the kernel
> recognizing that wait_on_buffer (or page or whatever) isn't always
> enough to make sure writes are really done.

Yep.  It scares me to think what performance characteristics we'll start
seeing once that gets used everywhere it's needed, though.  If every raw
or O_DIRECT write needs a flush after it, databases are going to become
very sensitive to flush performance.  I guess disabling the flushing and
using disks which tell the truth about data hitting the platter is the
sane answer there.

--Stephen

