Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270490AbTHGTxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270497AbTHGTxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:53:45 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:58604 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270490AbTHGTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:53:42 -0400
Date: Thu, 07 Aug 2003 12:53:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: slpratt@us.ibm.com
Subject: [Bug 1057] New: oops performing AIO write with O_DIRECT to block device 
Message-ID: <43060000.1060285999@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1057

           Summary: oops performing AIO write with O_DIRECT to block device
    Kernel Version: 2.6.0-test2-mm2
            Status: NEW
          Severity: blocking
             Owner: akpm@digeo.com
         Submitter: slpratt@us.ibm.com


Distribution:SLES8

Hardware Environment:
8way PIII 700Mhz, 4xServRAID with 80 9GB disks (20 RAID0 arrays)

Software Environment:
Problem Description:
Doing multithreaded AIO to multiple drives produces the following oops

08/04/03-18:26:32 processing command: run seqaiowrite-O_DIR rawio -m 20 -p 160
-d 6 -n 102400 -x -z -t 13 -s 1024
new log requested
08/04/03-18:26:32 Running command rawio -m 20 -p 160 -d 6 -n 102400 -x -z -t 13
-s 1024
Oops: 0000 [#1]
SMP
CPU:    2
EIP:    0060:[<c0307a9e>]    Not tainted VLI
EFLAGS: 00010086
EIP is at as_move_to_dispatch+0xe/0x130
eax: 00000000   ebx: f7a8b0a0   ecx: 00000000   edx: fffffff9
esi: 00000000   edi: 00000000   ebp: 00000001   esp: f5bf1c78
ds: 007b   es: 007b   ss: 0068
Process rawread (pid: 24164, threadinfo=f5bf0000 task=f5e90690)
Stack: 00000001 f59e2e40 f7a4ec00 00000000 f7a8b0a0 00000000 00000000 c0307cf5
       f7a8b0a0 00000000 c036727d f7a8b0a0 00000000 f79e1a00 f7a4ec00 c0307e68
       f7a8b0a0 f657d200 f79e1a00 c02ff626 f79e1a00 f657d200 f79e0800 f657d200
Call Trace:
 [<c0307cf5>] as_dispatch_request+0x135/0x270
 [<c036727d>] ips_queue+0xdd/0x170
 [<c0307e68>] as_next_request+0x38/0x50
 [<c02ff626>] elv_next_request+0x16/0x100
 [<c03432e8>] scsi_request_fn+0x38/0x2c0
 [<c0301467>] generic_unplug_device+0x67/0x70
 [<c03015c6>] blk_run_queues+0x86/0xa0
 [<c017c73d>] direct_io_worker+0x28d/0x3f0
 [<c033e9b5>] scsi_finish_command+0x75/0xb0
 [<c017c9f2>] blockdev_direct_IO+0x152/0x162
 [<c0160470>] blkdev_get_blocks+0x0/0x80
 [<c0160556>] blkdev_direct_IO+0x66/0x70
 [<c0160470>] blkdev_get_blocks+0x0/0x80
 [<c013d06d>] generic_file_direct_IO+0x9d/0xc0
 [<c013c8d6>] generic_file_aio_write_nolock+0x886/0xb30
 [<c010ba3e>] apic_timer_interrupt+0x1a/0x20
 [<c011d3ec>] schedule+0x2dc/0x5f0
 [<c0161606>] blkdev_file_aio_write+0x36/0x40
 [<c017e370>] aio_pwrite+0x40/0xc0
 [<c017e330>] aio_pwrite+0x0/0xc0
 [<c017d84a>] aio_run_iocb+0x8a/0x180
 [<c017e79d>] io_submit_one+0x1bd/0x220
 [<c017e8bc>] sys_io_submit+0xbc/0x140
 [<c010b04f>] syscall_call+0x7/0xb

Code: 01 00 00 00 a1 00 8c 48 c0 83 ea 28 39 42 30 0f 49 fe eb b0 90 90 8d b4 26
00 00 00 00 57 56 53 83 ec 10 8b 74 24 24 8b 5c 24 20 <8b> 7e 34 83 7e 04 02 0f
84 04 01 00 00 89 1c 24 e8 bd f5 ff ff


Steps to reproduce:
Benchmark can be obtained from:
http://www-124.ibm.com/developerworks/opensource/linuxperf/rawread/rawread.html

rawread -m 20 -p 160 -d 6 -n 102400 -x -z -t 13 -s 1024

This invocation runs on 20 logical disks starting at /dev/sdf.  This test does
not fail when run against only 1 disk.  Have not tried binary search to see how
many disks it takes to cause the failure.


