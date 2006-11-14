Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755442AbWKNHCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbWKNHCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755447AbWKNHCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:02:03 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:53141 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1755442AbWKNHCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:02:01 -0500
Message-ID: <455969F2.80401@drzeus.cx>
Date: Tue, 14 Nov 2006 08:02:10 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: How to cleanly shut down a block device
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

I've been trying to sort out some bugs in the MMC layer's block driver,
but my knowledge about the block layer is severely lacking. So I was
hoping you could educate me a bit. :)

Upon creation, the following happens:

alloc_disk()
spin_lock_init()
blk_init_queue()
blk_queue_*() (Set up limits)
disk->* = * (assign members)
blk_queue_hardsect_size()
set_capacity()
add_disk()

And on a clean removal, where there are no users of a card when it is
removed:

del_gendisk()
put_disk()
blk_cleanup_queue()

So far everything seems nice and peachy. The question is what to do when
a card is removed when the device is open.

In that case, del_gendisk() will be called, which seems to be documented
as blocking any new requests to be added to the queue. But there will be
a lot of outstanding requests in the queue.

Is it up to each block device to iterate and fail these or can I tell
the kernel "I'm broken, go away!"?

When the queue eventually drains (without too many oopses) and the user
calls close(), then put_disk() and blk_cleanup_queue() will be called.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
