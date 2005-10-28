Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVJ1XTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVJ1XTa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVJ1XTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:19:30 -0400
Received: from pat.qlogic.com ([198.70.193.2]:27258 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S1750729AbVJ1XT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:19:29 -0400
Date: Fri, 28 Oct 2005 16:19:24 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Badness in as_del_arq_rb at drivers/block/as-iosched.c:402
Message-ID: <20051028231924.GJ15018@plap.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 28 Oct 2005 23:19:24.0563 (UTC) FILETIME=[08D70E30:01C5DC16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be some problems with the latest linux-2.6.git tree
where running some basic I/O with DT against some FC storage, yields
numerous badness warnings, null pointer dereferencing and subsequent
hangs.

I'm trying to track it down now, but it seems to be related to the
recent merge:

	Merge branch 'generic-dispatch' of git://brick.kernel.dk/data/git/linux-2.6-block
	28d721e24c88496ff8e9c4a0959bdc1415c0658e


Here's the log captured via serial

------------------------- 8< ----------------------------

Badness in as_del_arq_rb at drivers/block/as-iosched.c:402

Call Trace:<ffffffff802651ac>{as_merged_request+172} <ffffffff8025b226>{elv_merged_request+38}
       <ffffffff8025fe14>{__make_request+804} <ffffffff8025e2ce>{generic_make_request+382}
       <ffffffff8025e3b8>{submit_bio+216} <ffffffff8018efcb>{dio_bio_submit+107}
       <ffffffff8018ff29>{__blockdev_direct_IO+2601} <ffffffff80328979>{_read_unlock_irq+9}
       <ffffffff8016f9f5>{blkdev_direct_IO+69} <ffffffff8016f860>{blkdev_get_blocks+0}
       <ffffffff80146b7c>{generic_file_direct_IO+188} <ffffffff80148fa4>{__generic_file_aio_read+228}
       <ffffffff8014922b>{generic_file_read+187} <ffffffff80328a9e>{_spin_lock_irqsave+14}
       <ffffffff80329659>{do_page_fault+1113} <ffffffff8015b115>{vma_link+133}
       <ffffffff8013ba70>{autoremove_wake_function+0} <ffffffff80168255>{vfs_read+197}
       <ffffffff80168403>{sys_read+83} <ffffffff8010dbfe>{system_call+126}
       
Badness in as_activate_request at drivers/block/as-iosched.c:1413

Call Trace:<ffffffff80263d01>{as_activate_request+49} <ffffffff8025bac8>{elv_next_request+56}
       <ffffffff8029d238>{scsi_request_fn+136} <ffffffff802639c0>{as_work_handler+0}
       <ffffffff802639f5>{as_work_handler+53} <ffffffff8013706c>{worker_thread+476}
       <ffffffff801209e0>{default_wake_function+0} <ffffffff801209e0>{default_wake_function+0}
       <ffffffff8013b7a0>{keventd_create_kthread+0} <ffffffff80136e90>{worker_thread+0}
       <ffffffff8013b7a0>{keventd_create_kthread+0} <ffffffff8013b8f9>{kthread+217}
       <ffffffff8010eca6>{child_rip+8} <ffffffff8013b7a0>{keventd_create_kthread+0}
       <ffffffff8013b820>{kthread+0} <ffffffff8010ec9e>{child_rip+0}
       
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Badness in as_move_to_dispatch at drivers/block/as-iosched.c:1134

Call Trace: <IRQ> <ffffffff80264c2d>{as_move_to_dispatch+349} <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 
Unable to handle kernel NULL pointer dereference at 0000000000000030 RIP: 
<ffffffff80264beb>{as_move_to_dispatch+283}
PGD 37b14067 PUD 37dfb067 PMD 0 
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: qla2xxx scsi_transport_fc
Pid: 10944, comm: dt Not tainted 2.6.14 #13
RIP: 0010:[<ffffffff80264beb>] <ffffffff80264beb>{as_move_to_dispatch+283}
RSP: 0018:ffffffff80453268  EFLAGS: 00010002
RAX: ffff81003684ea90 RBX: 0000000000000000 RCX: ffff81002d45ce60
RDX: ffff81003fe93050 RSI: 0000000000000092 RDI: ffffffff803e8d10
RBP: ffff81002e63e720 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81002c1f60f0
R13: ffff81003fbfe6c0 R14: 0000000000000001 R15: ffff81002e5e7778
FS:  00002aaaab2890a0(0000) GS:ffffffff8048e800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000030 CR3: 0000000028470000 CR4: 00000000000006e0
Process dt (pid: 10944, threadinfo ffff810035940000, task ffff810032898ae0)
Stack: ffff81002e63e720 0000000000000001 0000000000000000 ffff81003fbfe6c0 
       ffff81003dce2638 ffffffff802650d6 0000000000000292 0000000000000000 
       0000000000000000 ffff81003fe93050 
Call Trace: <IRQ> <ffffffff802650d6>{as_dispatch_request+1046}
       <ffffffff8025bbc3>{elv_next_request+307} <ffffffff8029d238>{scsi_request_fn+136}
       <ffffffff8025f58d>{blk_run_queue+61} <ffffffff8029d60f>{scsi_end_request+207}
       <ffffffff8029d899>{scsi_io_completion+617} <ffffffff802b3d71>{sd_rw_intr+737}
       <ffffffff80296da6>{scsi_finish_command+198} <ffffffff802977ac>{scsi_softirq+380}
       <ffffffff8012b0fb>{__do_softirq+107} <ffffffff8010f137>{call_softirq+31}
       <ffffffff801105c1>{do_softirq+49} <ffffffff8010e954>{apic_timer_interrupt+132}
        <EOI> <ffffffff803289ce>{_spin_unlock_irq+14} <ffffffff8025fff0>{__make_request+1280}
       <ffffffff8025e2ce>{generic_make_request+382} <ffffffff8025e3b8>{submit_bio+216}
       <ffffffff8018efcb>{dio_bio_submit+107} <ffffffff8018ff29>{__blockdev_direct_IO+2601}
       <ffffffff80328979>{_read_unlock_irq+9} <ffffffff8016f9f5>{blkdev_direct_IO+69}
       <ffffffff8016f860>{blkdev_get_blocks+0} <ffffffff80146b7c>{generic_file_direct_IO+188}
       <ffffffff80148fa4>{__generic_file_aio_read+228} <ffffffff8014922b>{generic_file_read+187}
       <ffffffff80328a9e>{_spin_lock_irqsave+14} <ffffffff80329659>{do_page_fault+1113}
       <ffffffff8015b115>{vma_link+133} <ffffffff8013ba70>{autoremove_wake_function+0}
       <ffffffff80168255>{vfs_read+197} <ffffffff80168403>{sys_read+83}
       <ffffffff8010dbfe>{system_call+126} 

Code: 48 8b 43 30 48 85 c0 74 0d 48 8b 40 28 48 85 c0 74 04 f0 ff 
RIP <ffffffff80264beb>{as_move_to_dispatch+283} RSP <ffffffff80453268>
CR2: 0000000000000030
 <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():1

Call Trace: <IRQ> <ffffffff8011f527>{__might_sleep+199} <ffffffff80126e79>{profile_task_exit+41}
       <ffffffff80128d62>{do_exit+34} <ffffffff80245b75>{do_unblank_screen+53}
       <ffffffff80329926>{do_page_fault+1830} <ffffffff80125f7d>{printk+141}
       <ffffffff80120645>{activate_task+149} <ffffffff8010eaf1>{error_exit+0}
       <ffffffff80264beb>{as_move_to_dispatch+283} <ffffffff80264c2d>{as_move_to_dispatch+349}
       <ffffffff802650d6>{as_dispatch_request+1046} <ffffffff8025bbc3>{elv_next_request+307}
       <ffffffff8029d238>{scsi_request_fn+136} <ffffffff8025f58d>{blk_run_queue+61}
       <ffffffff8029d60f>{scsi_end_request+207} <ffffffff8029d899>{scsi_io_completion+617}
       <ffffffff802b3d71>{sd_rw_intr+737} <ffffffff80296da6>{scsi_finish_command+198}
       <ffffffff802977ac>{scsi_softirq+380} <ffffffff8012b0fb>{__do_softirq+107}
       <ffffffff8010f137>{call_softirq+31} <ffffffff801105c1>{do_softirq+49}
       <ffffffff8010e954>{apic_timer_interrupt+132}  <EOI> <ffffffff803289ce>{_spin_unlock_irq+14}
       <ffffffff8025fff0>{__make_request+1280} <ffffffff8025e2ce>{generic_make_request+382}
       <ffffffff8025e3b8>{submit_bio+216} <ffffffff8018efcb>{dio_bio_submit+107}
       <ffffffff8018ff29>{__blockdev_direct_IO+2601} <ffffffff80328979>{_read_unlock_irq+9}
       <ffffffff8016f9f5>{blkdev_direct_IO+69} <ffffffff8016f860>{blkdev_get_blocks+0}
       <ffffffff80146b7c>{generic_file_direct_IO+188} <ffffffff80148fa4>{__generic_file_aio_read+228}
       <ffffffff8014922b>{generic_file_read+187} <ffffffff80328a9e>{_spin_lock_irqsave+14}
       <ffffffff80329659>{do_page_fault+1113} <ffffffff8015b115>{vma_link+133}
       <ffffffff8013ba70>{autoremove_wake_function+0} <ffffffff80168255>{vfs_read+197}
       <ffffffff80168403>{sys_read+83} <ffffffff8010dbfe>{system_call+126}
       
Kernel panic - not syncing: Aiee, killing interrupt handler!
 BUG: spinlock lockup on CPU#1, kblockd/1/124, ffff81003fe93260

Call Trace:<ffffffff8020698b>{_raw_spin_lock+235} <ffffffff8029d4a2>{scsi_request_fn+754}
       <ffffffff802639c0>{as_work_handler+0} <ffffffff802639f5>{as_work_handler+53}
       <ffffffff8013706c>{worker_thread+476} <ffffffff801209e0>{default_wake_function+0}
       <ffffffff801209e0>{default_wake_function+0} <ffffffff8013b7a0>{keventd_create_kthread+0}
       <ffffffff80136e90>{worker_thread+0} <ffffffff8013b7a0>{keventd_create_kthread+0}
       <ffffffff8013b8f9>{kthread+217} <ffffffff8010eca6>{child_rip+8}
       <ffffffff8013b7a0>{keventd_create_kthread+0} <ffffffff8013b820>{kthread+0}
       <ffffffff8010ec9e>{child_rip+0} 
