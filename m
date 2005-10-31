Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVJaMuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVJaMuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVJaMuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:50:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55826 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932439AbVJaMuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:50:14 -0500
Date: Mon, 31 Oct 2005 13:51:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Paul Collins <paul@briny.ondioline.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: Oops on suspend after on-the-fly switch to anticipatory i/o scheduler - PowerBook5,4
Message-ID: <20051031125109.GV19267@suse.de>
References: <87mzkscjz3.fsf@briny.internal.ondioline.org> <4364372E.2010904@gmail.com> <4364CE0D.2050600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4364CE0D.2050600@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30 2005, Tejun Heo wrote:
> Tejun Heo wrote:
> >Hello, Paul.
> >
> >Paul Collins wrote:
> >
> >>I boot with elevator=cfq (wanted to try the ionice stuff, never got
> >>around to it).  Having decided to go back to the anticipatory
> >>scheduler, I did the following:
> >>
> >># echo anticipatory > /sys/block/hda/queue/scheduler
> >># echo anticipatory > /sys/block/hdc/queue/scheduler
> >>
> >>A while later I did 'sudo snooze', which produced the Oops below.
> >>
> >>Booting with elevator=as and then changing to cfq, sleep works fine.
> >>But if I resume and change back to anticipatory I get a similar Oops
> >>on the next 'sudo snooze'.
> >>
> >>
> >>  Oops: kernel access of bad area, sig: 11 [#1]
> >>  NIP: C01E1948 LR: C01D6A60 SP: EFBC5C20 REGS: efbc5b70 TRAP: 0300    
> >>Not tainted
> >>  MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> >>  DAR: 00000020, DSISR: 40000000
> >>  TASK = efb012c0[1213] 'pmud' THREAD: efbc4000
> >>  Last syscall: 54   GPR00: 00080000 EFBC5C20 EFB012C0 EFE9E044 
> >>EFBC5CE8 00000002 00000000 C03B0000   GPR08: C046E5D8 00000000 
> >>C03B47C8 E6A58360 22042422 1001E4DC 10010000 10000000   GPR16: 
> >>10000000 10000000 10000000 7FE4EB40 10000000 10000000 10010000 
> >>C0400000   GPR24: C0380000 00000002 00000002 C046E0C0 00000000 
> >>00000002 00000000 EFBC5CE8   NIP [c01e1948] as_insert_request+0xa8/0x6b0
> >>  LR [c01d6a60] __elv_add_request+0xa0/0x100
> >>  Call trace:
> >>   [c01d6a60] __elv_add_request+0xa0/0x100
> >>   [c01ffb84] ide_do_drive_cmd+0xb4/0x190
> >>   [c01fc1c0] generic_ide_suspend+0x80/0xa0
> >>   [c01d4574] suspend_device+0x104/0x160
> >>   [c01d47c0] device_suspend+0x120/0x330
> >>   [c03f3b50] pmac_suspend_devices+0x50/0x1b0
> >>   [c03f4294] pmu_ioctl+0x344/0x9b0
> >>   [c0082aa4] do_ioctl+0x84/0x90
> >>   [c0082b3c] vfs_ioctl+0x8c/0x460
> >>   [c0082f50] sys_ioctl+0x40/0x80
> >>   [c0004850] ret_from_syscall+0x0/0x4c
> >>
> >
> >Can you please post assembly of as_insert_request?  You can get this by 
> >doing 'objdump -d drivers/block/as-iosched.o | less' and copy & pasting 
> >as_insert_request part.
> >
> >I'm also trying to reproduce the oops but haven't succeeded yet.  Does 
> >the oops occur only if the disk is loaded while switching scheduler / 
> >snoozing or does it happen regardless of disk load?
> >
> >And one more thing.  Can you please try the following program and see if 
> >it causes the oops?  The program simply writes 3, sleeps one second and 
> >then writes 0.  When redirected to the disk's power/state sysfs node, it 
> >will make the disk sleep for 1 second and then wake it up.
> >
> >#include <stdio.h>
> >#include <stdlib.h>
> >
> >int main(int argc, char **argv)
> >{
> >    int level = 3;
> >    if (argc > 1)
> >        level = atoi(argv[1]);
> >    setvbuf(stdout, NULL, _IONBF, 0);
> >    printf("%d", level);
> >    sleep(1);
> >    printf("0");
> >    return 0;
> >}
> >
> >After compiling, do the following.
> >
> >./a.out > /sys/block/hd?/device/power/state
> >
> >Thanks. :-)
> >
> 
>  Oh.. Never mind.  Jens seems to know how to fix it.  :-)

This should fix it.

-------

Don't clear ->elevator_data on exit, if we are switching queues we are
overwriting the data of the new io scheduler.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/drivers/block/cfq-iosched.c b/drivers/block/cfq-iosched.c
index cd056e7..23df2d2 100644
--- a/drivers/block/cfq-iosched.c
+++ b/drivers/block/cfq-iosched.c
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
Jens Axboe

