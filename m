Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293161AbSCGGLu>; Thu, 7 Mar 2002 01:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293482AbSCGGLl>; Thu, 7 Mar 2002 01:11:41 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:64980 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293161AbSCGGLZ>; Thu, 7 Mar 2002 01:11:25 -0500
Date: Thu, 7 Mar 2002 07:57:05 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Subject: Re: [PANIC] 2.5.5-pre1 elevator.c
In-Reply-To: <Pine.LNX.4.44.0203060901440.2839-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0203070753290.19993-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did a bit of investigation last night and this is what i came up with.

1. The last request is repeated, and is therefore already started when it 
hits  elevator_linus_add_request. This happens because 
cdrom_queue_request_sense adds a request to the queue but sets the 
ide_preempt flag and therefore finds the same request already sitting in 
the queue being processed.

2. the cdrom starts reporting errors at the end and thats when the extra 
request_sense commands start being sent, quite soon after each other too.

These are the repetitive errors i get if i disable the BUG check.
Jan  1 02:07:40 mondecino kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
Jan  1 02:07:40 mondecino kernel: hdc: command error: error=0x54
Jan  1 02:07:40 mondecino kernel: end_request: I/O error, dev 16:00, sector 1303168

Here is the debugging code i put in.
elevator_linus_add_request:
if (list_entry_rq(insert_here->next)->flags & REQ_STARTED) {
	printk(KERN_CRIT "rq:%#x prev:%#x cur:%#x next:%#x\n", rq,
		list_entry_rq(insert_here->prev),
		list_entry_rq(insert_here),
		list_entry_rq(insert_here->next));
	
	BUG();
}

cdrom_queue_request_sense:
printk(KERN_CRIT __FUNCTION__" req:%#x packet_command:%#x\n", rq, failed_command);
(void) ide_do_drive_cmd(drive, rq, ide_preempt);

So here are the events right before the oops.
[root@mondecino root]# dd if=/dev/hdc of=/dev/null 
cdrom_queue_request_sense req:0xcfdd6c50 packet_command:0xccc9fcfc
cdrom_queue_request_sense req:0xcfdd6c50 packet_command:0x0
rq:0xcfdd6c50 prev:0xcfdd3a78 cur:0xc0375568 next:0xcfdd3a78
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01ebb7c>]    Not tainted
EFLAGS: 00010086
eax: 0000001e   ebx: cfdd6c50   ecx: fffffec4   edx: 000017e5
esi: c0375568   edi: c0375568   ebp: c159ca64   esp: c02fdc68
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, threadinfo=c02fc000 task=c02e4160)
Stack: c02bca25 0000010a 00000000 c0375568 c0375568 00000002 00000002 
c01fd4b9 
       c0375568 cfdd6c50 c0375568 c15ab37c 00000000 00000000 c02fdcb0 
c02fdcb0 
       00000000 00000000 c02fdcb0 c02fdcb0 00000000 cfdd3a78 c0375568 
00000001 
Call Trace: [<c01fd4b9>] [<c02070fc>] [<c0207481>] [<c0121075>] 
[<c0121075>] 
   [<c010d54b>] [<c020734d>] [<c010a1ea>] [<c01f8dce>] [<c0207410>] 
[<c020734d>] 
   [<c0207410>] [<c0207130>] [<c0207933>] [<c01f8dce>] [<c0207410>] 
[<c020734d>] 
   [<c0207410>] [<c0207130>] [<c0207933>] [<c0207410>] [<c0200fbf>] 
[<c02072c6>] 
   [<c0207b72>] [<c0207880>] [<c0208352>] [<c02360cb>] [<c01fd2d6>] 
[<c0207410>] 
   [<c010a1ea>] [<c010a3e1>] [<c0106d50>] [<c0106d50>] [<c0106d50>] 
[<c0106d74>] 
   [<c0106df2>] [<c0105000>] 

Code: 0f 0b 58 5a 8b 43 1c a9 04 00 00 00 75 0a 83 e0 01 8b 44 85 
 <0>Kernel panic: Aiee, killing interrupt handler!

So second cdrom_request_sense in cdrom_decode_status preempts itself.

	Zwane


