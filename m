Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbSKYMZD>; Mon, 25 Nov 2002 07:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSKYMZD>; Mon, 25 Nov 2002 07:25:03 -0500
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:8833
	"EHLO www.piet.net") by vger.kernel.org with ESMTP
	id <S263026AbSKYMZC>; Mon, 25 Nov 2002 07:25:02 -0500
Date: Mon, 25 Nov 2002 04:32:19 -0800
From: Piet/Pete Delaney <piet@www.piet.net>
To: linux-kernel@vger.kernel.org
Cc: Piet Delaney <piet@www.piet.net>, Andrew Morton <akpm@digeo.com>
Subject: aic7xxx driver potentially sleeping with spin lock held in linux-2.5.48 (mm1 patch)
Message-ID: <20021125123219.GA3103@www.piet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a scsi problem in the  aic7xxx driver sleeping while the preempt_count() != 0. 
Looks like we are holding a spinlock where the slab allocator could go to sleep. 

======================================================================================================================================================================================== 
                                                            linux-2.5.48 with mm1 patch without SMP Enabled
======================================================================================================================================================================================== 
(gdb) where 
#0  printk (fmt=0xc3fb1d48 " 
#1  0xc0108f9b in dump_stack () at arch/i386/kernel/traps.c:232 
#2  0xc0115be8 in __might_sleep (file=0xc035a28e "mm/slab.c", line=1304) at kernel/sched.c:2254 
#3  0xc012ecef in kmem_flagcheck (cachep=0xc3fff440, flags=496) at mm/slab.c:1304 
#4  0xc012f584 in kmalloc (size=104, flags=496) at mm/slab.c:1636 
#5  0xc029104d in aic7xxx_alloc_aic_dev (p=0xc3f7d56c, SDptr=0xc3ed3c00) at drivers/scsi/aic7xxx_old.c:6636 
#6  0xc029717d in aic7xxx_queue (cmd=0xc3efca00, fn=0xc0280f04 <scsi_done>) at drivers/scsi/aic7xxx_old.c:10341 
#7  0xc0280a26 in scsi_dispatch_cmd (SCpnt=0xc3efca00) at drivers/scsi/scsi.c:852                                <--- spin lock grabed at Line 851 just prior to call to queuecommand() 
#8  0xc0285ed2 in scsi_request_fn (q=0xc3ed3c28) at drivers/scsi/scsi_lib.c:1061 
#9  0xc0253715 in blk_insert_request (q=0xc3ed3c28, rq=0xc3efc88c, at_head=0, data=0xc3efc800) at drivers/block/ll_rw_blk.c:1456 
#10 0xc02852b7 in scsi_insert_special_req (SRpnt=0xc3efc800, at_head=0) at drivers/scsi/scsi_lib.c:112 
#11 0xc0280c35 in scsi_do_req (SRpnt=0xc3efc800, cmnd=0xc3fb1ee8, buffer=0xc0549ed4, bufflen=36, done=0xc02802ec <scsi_wait_done>, timeout=6000, retries=3) at drivers/scsi/scsi.c:1022 
#12 0xc0280b6d in scsi_wait_req (SRpnt=0xc3efc800, cmnd=0xc3fb1ee8, buffer=0xc0549ed4, bufflen=36, timeout=6000, retries=3) at drivers/scsi/scsi.c:912 
#13 0xc0286c63 in scsi_probe_lun (sreq=0xc3efc800, inq_result=0xc0549ed4 "", bflags=0xc3fb1f1c) at drivers/scsi/scsi_scan.c:1142 
#14 0xc0287165 in scsi_probe_and_add_lun (sdevscan=0xc3ed3c00, sdevnew=0x0, bflagsp=0xc3fb1f3c) at drivers/scsi/scsi_scan.c:1485 
#15 0xc0287679 in scsi_scan_target (sdevscan=0xc3ed3c00, shost=0xc3f7d400, channel=0, id=0) at drivers/scsi/scsi_scan.c:1906 
#16 0xc028779e in scan_scsis (shost=0xc3f7d400, hardcoded=0, hchannel=0, hid=0, hlun=0) at drivers/scsi/scsi_scan.c:2031 
#17 0xc02824fd in scsi_add_host (shost=0xc3f7d400) at drivers/scsi/hosts.c:311 
#18 0xc028298b in scsi_register_host (shost_tp=0xc04422a0) at drivers/scsi/hosts.c:552 
#19 0xc04f2f59 in init_this_scsi_driver () at drivers/scsi/scsi_module.c:38 
#20 0xc04e26e4 in do_initcalls () at init/main.c:467 
#21 0xc04e2713 in do_basic_setup () at init/main.c:492 
#22 0xc0105096 in init (unused=0x0) at init/main.c:529 
(gdb) 
========================================================================================================================================================================================= 

The scsi adapter is likely disabled (I'm not using it). The same configuration is 
working fine with the Redhat 8.0 linux-2.4.18-14 kernel NON-SMP kernel.  The 2.4.18-14 
SMP kernel however isn't booting. 

-- 
piet@www.piet.net

