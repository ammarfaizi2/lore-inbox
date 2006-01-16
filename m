Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWAPIJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWAPIJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWAPIJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:09:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29411 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932260AbWAPIJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:09:35 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15 __disk_stat_add() called without preempt disabled
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Jan 2006 19:09:29 +1100
Message-ID: <13179.1137398969@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15 on ia64, gcc 3.3.3, CONFIG_PREEMPT_DEBUG=y.

scsi(0): Resetting Cmnd=0xe00000b479ea7810, Handle=0x0000000000000001, action=0x0
scsi(0): Resetting Cmnd=0xe00000b479ea79e8, Handle=0x0000000000000002, action=0x0
scsi(0): Resetting Cmnd=0xe00000b479ea63c8, Handle=0x0000000000000003, action=0x0
scsi(0): Resetting Cmnd=0xe00000b479ea7810, Handle=0x0000000000000202, action=0x2
scsi(0:0:2:0): Queueing device reset command.
qla2300 0000:03:01.0: Mailbox command timeout occured. Issuing ISP abort.
qla2300 0000:03:01.0: Performing ISP error recovery - ha= e0000034790b4518.
scsi(0): mailbox timed out, mailbox0 4000, ictrl 0006, istatus 6006
qla2300 0000:03:01.0: LIP reset occured (f7f7).
qla2300 0000:03:01.0: LOOP UP detected (2 Gbps).
qla2300 0000:03:01.0: scsi(2:2:1): Abort command issued -- 2ea 2003.
sd 2:0:2:1: scsi: Device offlined - not ready after error recovery
sd 2:0:2:1: scsi: Device offlined - not ready after error recovery
BUG: using smp_processor_id() in preemptible [00000001] code: scsi_eh_2/4665
caller is __end_that_request_first+0x1b0/0x8e0

Call Trace:
 [<a000000100013280>] show_stack+0x40/0xa0
                                sp=e00000b007dbfc00 bsp=e00000b007db90e8
 [<a000000100013b10>] dump_stack+0x30/0x60
                                sp=e00000b007dbfdd0 bsp=e00000b007db90d0
 [<a0000001003d7880>] debug_smp_processor_id+0x160/0x1a0
                                sp=e00000b007dbfdd0 bsp=e00000b007db90b0
 [<a000000100399c90>] __end_that_request_first+0x1b0/0x8e0
                                sp=e00000b007dbfdd0 bsp=e00000b007db9028
 [<a00000010039a3f0>] end_that_request_chunk+0x30/0x60
                                sp=e00000b007dbfdd0 bsp=e00000b007db8ff0
 [<a00000010052f6f0>] scsi_end_request+0x50/0x1e0
                                sp=e00000b007dbfdd0 bsp=e00000b007db8fb0
 [<a00000010052fc60>] scsi_io_completion+0x3e0/0x840
 [<a00000010055dfe0>] sd_rw_intr+0x460/0x480
                                sp=e00000b007dbfde0 bsp=e00000b007db8ec8
 [<a000000100522750>] scsi_finish_command+0x150/0x180
                                sp=e00000b007dbfe00 bsp=e00000b007db8e98
 [<a00000010052c0d0>] scsi_error_handler+0x1230/0x15e0
                                sp=e00000b007dbfe00 bsp=e00000b007db8e28
 [<a0000001000c68a0>] kthread+0x1a0/0x220
                                sp=e00000b007dbfe20 bsp=e00000b007db8de8
 [<a000000100011860>] kernel_thread_helper+0xe0/0x100
                                sp=e00000b007dbfe30 bsp=e00000b007db8dc0
 [<a000000100009120>] start_kernel_thread+0x20/0x40
                                sp=e00000b007dbfe30 bsp=e00000b007db8dc0

__end_that_request_first() calls __disk_stat_add() [inlined] without
disabling preemption.

