Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVJFAhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVJFAhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 20:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVJFAhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 20:37:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:8387 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750700AbVJFAhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 20:37:52 -0400
Subject: IDE issues with  "choose_drive"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 10:36:59 +1000
Message-Id: <1128559019.22073.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seem to be a certain amount of problems with ide_do_request() and
more specifically choose_drive() to pick which drive to service, when
more than one drive is on a given hwgroup (typically, when you have a
slave drive)

The first one is the one I'm trying to fix, it's basically a hang on
wakeup from sleep. What happens is that both drives are blocked
(suspended, drive->blocked is set). Their IO queues contains some
requests that haven't been serviced yet. We receive the resume()
callback for one of them. We react by inserting a wakeup request at the
head of the queue and waiting for it to complete. However, when we reach
ide_do_request(), choose_drive() may return the other drive (the one
that is still sleeping). In this case, we hit the test for blocked queue
and just break out of the loop. We end up never servicing the other
drive queue which is the one we are trying to wakeup, thus we hang.

In general, that uncovers a serie of problems with that code. That is,
the 2 other cases where we "break" out of the loop may trigger a similar
problem where we do not service the "other" drive, and thus unless
something else happens to "kick" the hwgroup, a request pending on the
other drive will be stuck there and the machine may hang.

In a similar vein, if we hit the codepath that does 
ide_stall_queue() (which is meant as doing some fairness by blocking the
slave for some time) we may end up also "missing" the opportunity to
service at all on the next pass, thus hanging forever.  

Also, I think there may be another problem with choose_drive() itself,
though I'm not 100% sure, with the code that tests blk_queue_flushing()
since we do the test on hwgroup->drive only, and thus we never test that
for the slave drive.

I'm not sure what is the best way to fix those issues except by
completely rewriting that code. I was thinking about turning the "break"
into a "continue" in the PM case to service the "other" drive but
nothing guarantees that I'll make any forward progress since
choose_drive() may just return the same drive over and over (since the
queue is not serviced).

Ben.


