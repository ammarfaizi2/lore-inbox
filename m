Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWIUMSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWIUMSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 08:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWIUMSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 08:18:13 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:50334 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1750834AbWIUMSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 08:18:12 -0400
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/5] dio: clean up completion phase of direct_io_worker()
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OF5FAEE6AE.0EB0D2B9-ON652571F0.003E252C-652571F0.004391B5@in.ibm.com>
From: Veerendra Chandrappa <veerendra.chandrappa@in.ibm.com>
Date: Thu, 21 Sep 2006 17:54:36 +0530
X-MIMETrack: Serialize by Router on d23m0174/23/M/IBM(Release 6.5.5HF262 | April 5, 2006) at
 21/09/2006 17:54:43,
	Serialize complete at 21/09/2006 17:54:43
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,

        I applied the DIO patches and built the kernel 2.6.18-rc6 
(kernel.org).
And executed  Aio-DioStressTest of LTP testsuite( ltp-full-20060822 ) 
on EXT2, EXT3 and XFS filesystems. For the EXT2 and EXT3 filesystems the 
tests went okay. But I got stack trace on XFS filesystem and the machine 
went down.

kernel BUG at kernel/workqueue.c:113!
invalid opcode: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    2
EIP:    0060:[<c012df03>]    Not tainted VLI
EFLAGS: 00010202   (2.6.18-rc6-dio #1)
EIP is at queue_work+0x86/0x90
eax: f7900780   ebx: f790077c   ecx: f7900754   edx: 00000002
esi: c5f4f8e0   edi: 00000000   ebp: c5d63ca8   esp: c5d63c94
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, ti=c5d62000 task=c5d2b030 task.ti=c5d62000)
Stack: f268f180 c5d63cb4 3e39c000 00000000 00010000 c5d63cb0 c02b43a2 
c5d63cc8
       c02b5e2f f7900754 00000000 3e39c000 f4e90000 c5d63d04 c018e77a 
f3235780
       3e39c000 00000000 00010000 f2604b20 f268f180 c5d63d04 00010000 
3e39c000
Call Trace:
 [<c0103cea>] show_stack_log_lvl+0xcc/0xdc
 [<c0103f0f>] show_registers+0x1b7/0x22b
 [<c0104143>] die+0x139/0x235
 [<c01042bd>] do_trap+0x7e/0xb4
 [<c01045f3>] do_invalid_op+0xb5/0xbf
 [<c0103945>] error_code+0x39/0x40
 [<c02b43a2>] xfs_finish_ioend+0x20/0x22
 [<c02b5e2f>] xfs_end_io_direct+0x3c/0x68
 [<c018e77a>] dio_complete+0xe3/0xfe
 [<c018e82d>] dio_bio_end_aio+0x98/0xb1
 [<c016e889>] bio_endio+0x4e/0x78
 [<c02cdc89>] __end_that_request_first+0xcd/0x416
 [<c02ce015>] end_that_request_chunk+0x1f/0x21
 [<c0380442>] scsi_end_request+0x2d/0xe8
 [<c0380715>] scsi_io_completion+0x10c/0x409
 [<c03a986b>] sd_rw_intr+0x188/0x2c6
 [<c037b832>] scsi_finish_command+0x4e/0x96
 [<c0380f44>] scsi_softirq_done+0xaa/0x10b
 [<c02ce073>] blk_done_softirq+0x5c/0x6a
 [<c01227a4>] __do_softirq+0x6d/0xe3
 [<c0122858>] do_softirq+0x3e/0x40
 [<c01228a1>] irq_exit+0x47/0x49
 [<c01054ef>] do_IRQ+0x2f/0x5d
 [<c0103826>] common_interrupt+0x1a/0x20
 [<c0100d84>] cpu_idle+0x9a/0xb0
 [<c010e077>] start_secondary+0xeb/0x32c
 [<00000000>] 0x0
 [<c5d63fb4>] 0xc5d63fb4
Code: ff ff b8 01 00 00 00 e8 87 9a fe ff 89 e0 25 00 e0 ff ff 8b 40 08 
a8 08 75 0a 83 c4 08 89 f8 5b 5e 5f 5d c3 e8 2f 0f 3
EIP: [<c012df03>] queue_work+0x86/0x90 SS:ESP 0068:c5d63c94
 <0>Kernel panic - not syncing: Fatal exception in interrupt

Also I executed some of the tests from the 
http: // developer.osdl. org/daniel/AIO/TESTS/ and it went fine.
For further testing, I am planning to put stress workload on DB2 by 
enabling AIO-DIO features of DB2. And for error path testing, I am 
contemplating to use kprobe to inject the IO errors.

   Will let you know the progress as it happens.

Regards
Veerendra C
LTC-ISL, IBM.
