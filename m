Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBVL2z>; Thu, 22 Feb 2001 06:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbRBVL2p>; Thu, 22 Feb 2001 06:28:45 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1803 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129078AbRBVL2c>; Thu, 22 Feb 2001 06:28:32 -0500
Date: Thu, 22 Feb 2001 07:41:52 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jens Axboe <axboe@suse.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: ll_rw_block/submit_bh and request limits
Message-ID: <Pine.LNX.4.21.0102220707380.1694-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The following piece of code in ll_rw_block() aims to limit the number of
locked buffers by making processes throttle on IO if the number of on
flight requests is bigger than a high watermaker. IO will only start
again if we're under a low watermark.

                if (atomic_read(&queued_sectors) >= high_queued_sectors) {
                        run_task_queue(&tq_disk);
                        wait_event(blk_buffers_wait,
                        	atomic_read(&queued_sectors) < low_queued_sectors);
                }


However, if submit_bh() is used to queue IO (which is used by ->readpage()
for ext2, for example), no throttling happens.

It looks like ll_rw_block() users (writes, metadata reads) can be starved
by submit_bh() (data reads). 

If I'm not missing something, the watermark check should be moved to
submit_bh(). 


