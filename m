Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTE0OH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTE0OH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:07:27 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:46852 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263620AbTE0OH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:07:26 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527065436.GX845@suse.de>
References: <20030526205725.GT845@suse.de>
	<Pine.LNX.4.44.0305261429550.13489-100000@home.transmeta.com> 
	<20030527065436.GX845@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 May 2003 10:20:32 -0400
Message-Id: <1054045236.1974.20.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 02:54, Jens Axboe wrote:
> James, speaking of queue localities and tcq... Doug mentioned some time
> ago that aic7xxx dishes out tags numbers from a hba pool which makes it
> impossible to support with out current block layer queueing code. Maybe
> it we associate the blk_queue_tag structure with a bunch of queues
> instead of having a 1:1 mapping it could work.

Yes, A large number of devices (not just the aic7xxx) have a single
issue queue for all outgoing requests (this is the reason for the
can_queue limit in the host template).

If the issue queue is < 256 slots, it makes a lot of sense to use global
tag numbers instead of device local ones, since then you can simply map
the returning tag number to an index in the issue queue and not bother
having to keep a hash table of <pun, lun, tag> to look it up in.

Even drivers which have larger or variable size issue queues (here the
qlogic ones spring immediately to mind) often have a virtual index
number attached to their commands (which, this time is 16 bits) which
they'd like to use as a unique offset into the issue queue.  Obviously,
they face exactly the same challenges as tags and they'd like a similar
solution.

A global structure for a bunch of queues would probably be the most
useful way forwards.

James


