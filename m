Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbUC3QHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUC3QHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:07:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17862 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263734AbUC3QGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:06:38 -0500
Subject: Re: [PATCH] barrier patch set
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Chris Mason <mason@suse.com>, Jens Axboe <axboe@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200403201805.26211.bzolnier@elka.pw.edu.pl>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Organization: 
Message-Id: <1080662685.1978.25.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Mar 2004 17:04:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2004-03-20 at 17:05, Bartlomiej Zolnierkiewicz wrote:

> Jens, can you explain how this translates to the block layer?
> If "log blocks" is a separate request from "commit block",
> we can just do: log blocks, flush, commit block, flush cycle.

It's not so simple.  There are two different operations here as far as
the fs is concerned --- ordering ("barrier"), and waiting ("flush"). 
For most journaling purposes, a filesystem really doesn't have to know
when data has hit disk --- it only needs to be assured that certain
ordering constraints will be obeyed.  So in SCSI terms we can submit the
log blocks, then set an ORDERED queue tag on the commit block, and leave
it at that.  We don't have to wait until that ORDERED tag actually
becomes persistent on disk --- we don't care, in most cases.  This is
the "barrier", and in journaling, we basically need a barrier before and
after the commit block.

The tricky bit is that _sometimes_ we find, later on, that we need to
know when data has hit disk.  If an application requests synchronised IO
(such as fsync, O_SYNC or O_DIRECT) then we cannot legally return until
the disk has told us that the data is persistent for certain.  _That_ is
a full flush, and it's distinct from the simple ordering constraint that
we normally have for journal commit blocks.

The distinction becomes important if flushing and barriers have
significantly different performance characteristics.  In the SCSI tagged
command case, we can insert an ORDERED queue tag into the pipeline
without having to wait for anything.  But if we implement the barrier
and the flush by the same mechanism, then the fs ends up waiting; we get

	write log blocks
	wait for IO queue to empty
	write commit block
	wait for IO queue to empty

instead of

	write log blocks
	write commit block with ORDERED tag set

so the commits are miles slower.

Jens' patch happens to implement barriers via flushes on IDE, but at the
block layer blkdev_issue_flush() and set_buffer_ordered() are quite
distinct APIs.

--Stephen


