Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTJPQvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTJPQvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:51:25 -0400
Received: from mcomail04.maxtor.com ([134.6.76.13]:1810 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S263060AbTJPQvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:51:24 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB2C5@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Jens Axboe'" <axboe@suse.de>, Greg Stark <gsstark@mit.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ide write barrier support
Date: Thu, 16 Oct 2003 10:51:23 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Oct 14 2003, Greg Stark wrote:
> Jens Axboe <axboe@suse.de> writes:
> > There's also the case of files opened with O_SYNC. Would inserting a
> > write barrier after every write to such a file destroy performance?
> 
> If it's mainly sequential io, then no it won't destroy performance. It
> will be lower than without the cache flush of course.

If you flush a cache after every command in a sequential write, yes, you'll
destroy performance.  How much you destroy it is a function of command size
relative to track size, and the RPM of the drive.

It takes us multiple servo wedges to know that we think our write to the
media went in the right place, therefore by definition if we didn't already
have the next command's data, we've already missed our target location and
have to wait a full revolution to put the new data on the media.  Since we
can't report good status for the flush until after we're sure the data is
down properly, we'll always blow a rev.

If you're issuing 32 MiB writes to a very fast drive , you'll only have
wasted time every 1/3 of a second (with a ~100MB interface)... which is near
trivial.  However, if you're doing 1MB or smaller writes, I think you'll see
a huge performance penalty.

Then again, if you're only working with datasets of a few megabytes, you'd
probably never notice.  It is the person flushing a huge stream of data to
disk who gets penalized the most. 

--eric

