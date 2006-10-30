Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWJ3Saa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWJ3Saa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWJ3Saa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:30:30 -0500
Received: from rtr.ca ([64.26.128.89]:40712 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964940AbWJ3Sa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:30:29 -0500
Message-ID: <454644C1.4080702@rtr.ca>
Date: Mon, 30 Oct 2006 13:30:25 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca> <45464064.2090108@rtr.ca> <20061030181645.GF14055@kernel.dk>
In-Reply-To: <20061030181645.GF14055@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Can you do:
> 
> $ gdb vmlinux
>   l *cfq_set_request+0x351
> 
> assuming you built with DEBUG_INFO enabled.

Here it is again, from kernel with FRAME_POINTERS and DEBUG_INFO enabled:

=================================
[ INFO: inconsistent lock state ]
2.6.19-rc3-git7-ml #6
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
startproc/3964 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&q->__queue_lock){-+..}, at: [<c021780e>] cfq_set_request+0x33e/0x3a0
{in-softirq-W} state was registered at:
  [<c0137439>] mark_lock+0x79/0x600
  [<c013880d>] __lock_acquire+0x64d/0xc20
  [<c013914d>] lock_acquire+0x5d/0x80
  [<c035ea8b>] _spin_lock+0x2b/0x40
  [<c029ee87>] scsi_device_unbusy+0x67/0xa0
  [<c029992c>] scsi_finish_command+0x1c/0xa0
  [<c029f04f>] scsi_softirq_done+0xcf/0xf0
  [<c020fc8b>] blk_done_softirq+0x6b/0x80
  [<c0122732>] __do_softirq+0x92/0x110
  [<c0122815>] do_softirq+0x65/0x70
  [<c0122c85>] ksoftirqd+0x85/0xd0
  [<c0130d48>] kthread+0xe8/0xf0
  [<c0103c4b>] kernel_thread_helper+0x7/0x1c
  [<ffffffff>] 0xffffffff
irq event stamp: 1927
hardirqs last  enabled at (1927): [<c0162a15>] kmem_cache_alloc+0x75/0xb0
hardirqs last disabled at (1926): [<c01629c2>] kmem_cache_alloc+0x22/0xb0
softirqs last  enabled at (0): [<c011b653>] copy_process+0x353/0x1290
softirqs last disabled at (0): [<00000000>] 0x0

other info that might help us debug this:
no locks held by startproc/3964.

stack backtrace:
 [<c0104088>] dump_trace+0x1c8/0x200
 [<c01040da>] show_trace_log_lvl+0x1a/0x30
 [<c0104832>] show_trace+0x12/0x20
 [<c0104999>] dump_stack+0x19/0x20
 [<c0137053>] print_usage_bug+0x243/0x250
 [<c0137962>] mark_lock+0x5a2/0x600
 [<c0138832>] __lock_acquire+0x672/0xc20
 [<c013914d>] lock_acquire+0x5d/0x80
 [<c035ea8b>] _spin_lock+0x2b/0x40
 [<c021780e>] cfq_set_request+0x33e/0x3a0
 [<c020af3f>] elv_set_request+0x1f/0x50
 [<c020e40d>] get_request+0x21d/0x250
 [<c020ec4c>] get_request_wait+0x1c/0x100
 [<c020eebd>] __make_request+0x5d/0x330
 [<c020db44>] generic_make_request+0x174/0x230
 [<c020fed0>] submit_bio+0x60/0x110
 [<c018dcfc>] mpage_bio_submit+0x1c/0x30
 [<c018f363>] mpage_readpages+0x103/0x140
 [<c01aab49>] reiserfs_readpages+0x19/0x20
 [<c014d511>] __do_page_cache_readahead+0x161/0x220
 [<c014d632>] blockable_page_cache_readahead+0x62/0xc0
 [<c014d86f>] page_cache_readahead+0x11f/0x1d0
 [<c0147511>] do_generic_mapping_read+0x501/0x540
 [<c01495a3>] generic_file_aio_read+0xf3/0x240
 [<c0166020>] do_sync_read+0xd0/0x110
 [<c01668e4>] vfs_read+0x94/0x160
 [<c0166e2d>] sys_read+0x3d/0x70
 [<c0102f4d>] sysenter_past_esp+0x56/0x8d
 [<b7f84410>] 0xb7f84410
 =======================

(gdb) l *cfq_set_request+0x33e
0xc021780e is in cfq_set_request (block/cfq-iosched.c:1224).
1219            if (unlikely(!cfqd))
1220                    return;
1221
1222            spin_lock(cfqd->queue->queue_lock);
1223
1224            cfqq = cic->cfqq[ASYNC];
1225            if (cfqq) {
1226                    struct cfq_queue *new_cfqq;
1227                    new_cfqq = cfq_get_queue(cfqd, CFQ_KEY_ASYNC, cic->ioc->task,
1228                                             GFP_ATOMIC);


