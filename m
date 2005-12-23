Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbVLWW2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbVLWW2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVLWW2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:28:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:34504 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161075AbVLWW2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:28:38 -0500
Date: Fri, 23 Dec 2005 14:27:28 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, axboe@suse.de
Subject: [patch 03/11] Oops on suspend after on-the-fly switch to anticipatory i/o scheduler - PowerBook5, 4
Message-ID: <20051223222727.GD18252@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cfq-io-sched-fix.patch"
In-Reply-To: <20051223222652.GA18252@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@suse.de>

Paul Collins wrote:
>I boot with elevator=cfq (wanted to try the ionice stuff, never got
>around to it).  Having decided to go back to the anticipatory
>scheduler, I did the following:
>
># echo anticipatory > /sys/block/hda/queue/scheduler
># echo anticipatory > /sys/block/hdc/queue/scheduler
>
>A while later I did 'sudo snooze', which produced the Oops below.
>
>Booting with elevator=as and then changing to cfq, sleep works fine.
>But if I resume and change back to anticipatory I get a similar Oops
>on the next 'sudo snooze'.
>
>
>  Oops: kernel access of bad area, sig: 11 [#1]
>  NIP: C01E1948 LR: C01D6A60 SP: EFBC5C20 REGS: efbc5b70 TRAP: 0300    
>Not tainted
>  MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>  DAR: 00000020, DSISR: 40000000
>  TASK = efb012c0[1213] 'pmud' THREAD: efbc4000
>  Last syscall: 54   GPR00: 00080000 EFBC5C20 EFB012C0 EFE9E044 
>EFBC5CE8 00000002 00000000 C03B0000   GPR08: C046E5D8 00000000 
>C03B47C8 E6A58360 22042422 1001E4DC 10010000 10000000   GPR16: 
>10000000 10000000 10000000 7FE4EB40 10000000 10000000 10010000 
>C0400000   GPR24: C0380000 00000002 00000002 C046E0C0 00000000 
>00000002 00000000 EFBC5CE8   NIP [c01e1948] as_insert_request+0xa8/0x6b0
>  LR [c01d6a60] __elv_add_request+0xa0/0x100
>  Call trace:
>   [c01d6a60] __elv_add_request+0xa0/0x100
>   [c01ffb84] ide_do_drive_cmd+0xb4/0x190
>   [c01fc1c0] generic_ide_suspend+0x80/0xa0
>   [c01d4574] suspend_device+0x104/0x160
>   [c01d47c0] device_suspend+0x120/0x330
>   [c03f3b50] pmac_suspend_devices+0x50/0x1b0
>   [c03f4294] pmu_ioctl+0x344/0x9b0
>   [c0082aa4] do_ioctl+0x84/0x90
>   [c0082b3c] vfs_ioctl+0x8c/0x460
>   [c0082f50] sys_ioctl+0x40/0x80
>   [c0004850] ret_from_syscall+0x0/0x4c

Don't clear ->elevator_data on exit, if we are switching queues we are
overwriting the data of the new io scheduler.

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/cfq-iosched.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.14.1.orig/drivers/block/cfq-iosched.c
+++ linux-2.6.14.1/drivers/block/cfq-iosched.c
@@ -2260,10 +2260,8 @@ static void cfq_put_cfqd(struct cfq_data
 	if (!atomic_dec_and_test(&cfqd->ref))
 		return;
 
-	blk_put_queue(q);
-
 	cfq_shutdown_timer_wq(cfqd);
-	q->elevator->elevator_data = NULL;
+	blk_put_queue(q);
 
 	mempool_destroy(cfqd->crq_pool);
 	kfree(cfqd->crq_hash);

--
