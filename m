Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbTANW0z>; Tue, 14 Jan 2003 17:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTANW0z>; Tue, 14 Jan 2003 17:26:55 -0500
Received: from ns.temetra.com ([64.239.6.61]:56812 "EHLO temetra.com")
	by vger.kernel.org with ESMTP id <S264969AbTANW0y>;
	Tue, 14 Jan 2003 17:26:54 -0500
Date: Tue, 14 Jan 2003 17:35:45 -0500
Message-Id: <200301142235.RAA23806@temetra.com>
From: Brian Kelly <bkelly@sulaco.com>
To: linux-kernel@vger.kernel.org
Subject: How to setup a buffer_head in a driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm writing a device driver that among other things needs to write data,
manufactured by the driver itself, to a block device.

I have this data in block sized kmalloc()'d chunks. So what I'm doing is
allocating a struct buffer_head, initialising it, fill out it's various
fields and send it to generic_make_request(). Something like the following
[inspired by looking at various drivers like loop and ram]:

	do {
		if((bh = kmem_cache_alloc(bh_cachep, SLAB_NOIO)) != NULL){
			break;
		}
		run_task_queue(&tq_disk);
		schedule_timeout(HZ);
	} while (1);

	memset(bh, 0, sizeof(*bh));

	bh->b_size = size;
	bh->b_dev = dev;
	bh->b_rdev = dev;
	bh->b_data = data;
	init_waitqueue_head(&bh->b_wait);
	bh->b_rsector = sect;
	bh->b_end_io = write_done;
	bh->b_private = NULL;
	generic_make_request(WRITE, bh);


Now this causes a panic in ll_rw_blk.c because the b_state isn't set
correctly. I experimented with this a little but decided I needed some
proper direction on this whole endeavour.

Soooo, what do I really need to do? What's the correct way to do what I want
to do or could someone point me at an existing driver that does this
sort of thing.

Thanks,

Brian
-- 
bkelly@sulaco.com
