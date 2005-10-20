Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVJTUjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVJTUjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 16:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVJTUjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 16:39:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56766 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932528AbVJTUjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 16:39:45 -0400
Date: Thu, 20 Oct 2005 16:39:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
cc: Jens Axboe <axboe@suse.de>
Subject: BUG in the block layer (partial reads not reported)
Message-ID: <Pine.LNX.4.44L0.0510201435400.4453-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The block layer does not report partial reads correctly back to userspace.

Here's an example which I can replicate at will.  This is using the SCSI 
cdrom driver and a disc with 326535 hardware sectors, each containing 2048 
bytes.  The last two sectors are unreadable.

Now consider what should happen when you run

	dd if=/dev/scd0 bs=2048 count=1 skip=326532

One would expect to get back the contents of the last readable hardware 
sector.

Instead, what happens is this:

     1. The block layer issues a read for sectors 326532-3 (i.e., a 
	page's worth, including the sector we want and the following
	unreadable sector).

     2. The read partially succeeds, and the driver calls 
		end_that_request_chunk(req, 1, 2048);
	It then requeues the request, more or less by coincidence.

     3. This time the request fails since it's trying to read the
	second-to-last sector, and the driver calls
		end_that_request_chunk(req, 1, 0);
	I'm not sure why.

     4. Then the driver does what it should have done before, and calls
		end_that_request_chunk(req, 0, 2048);
	This causes an I/O error message to appear in the system log.

     5. The driver calls end_that_request_last(req).

     6. Apparently the block layer issues its own retry at this point.
	The driver gets another read request for sector 326533.

     7. Steps 3 - 5 repeat.

The end result is that dd receives no data, only an error.  This is in 
spite of the fact that the kernel was able to read successfully all the 
data that had been requested!

Now I have only the vaguest notion of how the block layer works, and I 
don't know where to begin solving this problem.  Any help would be 
appreciated.

Alan Stern

