Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265626AbSKFEHB>; Tue, 5 Nov 2002 23:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265627AbSKFEHB>; Tue, 5 Nov 2002 23:07:01 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:37358 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265626AbSKFEHA>;
	Tue, 5 Nov 2002 23:07:00 -0500
Date: Tue, 5 Nov 2002 23:13:30 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106041330.GA9489@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I felt like making some coasters tonight so I figured it was a good time
to give ide-cd a chance with cdrecord. For the most part, it worked
great! I was stunned, in fact, by how smoothly it went after I upgraded
my cdtools. I was running SMP + preempt and it wrote smoothly at 12x
with < 2% CPU usage the whole time. Buffer capacity never dropped below
98%.

I was almost disappointed at not making any coasters so I decided to
stress it a bit. I tried running 'make -j10 bzImage' on the 2.5.46
kernel tree while it was writing and that also worked! Buffer never
dropped below 96%. (This machine is 2x Xeon 450, 256 MB RAM, BTW.)

Still without coaster I tried one more thing...
'dd if=/dev/zero of=foo bs=1M' in parallel with another burn. That one
did it in. ;) I'm running ext3 and the writeout load totally killed
burn, which isn't surprising. I was asking for it, I know. What happened
when the cdrecord buffer underran was surprising, though: oops below.
Very repeatable. Can supply copious hw details if it helps.

--Adam

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02464ad
*pde = 00000000
Oops: 0000
eepro100 mii  
CPU:    0
EIP:    0060:[<c02464ad>]    Not tainted
EFLAGS: 00010006
EIP is at ide_outsw+0xd/0x20
eax: 00007c00   ebx: 0000f801   ecx: 00007c00   edx: 00000170
esi: 00000000   edi: c0557d74   ebp: 00000000   esp: c04bfeb0
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=c04be000 task=c0491900)
Stack: c0557e20 c02469aa 00000170 00000000 00007c00 0000f801 c0557e20 c0557d74 
       00000000 c0246a7c c0557e20 00000000 00003e00 0000f800 c13820e0 00000000 
       c0557e20 c025571c c0557e20 00000000 0000f800 c13ad3a0 c0246a40 0000f800 
Call Trace:
 [<c02469aa>] ata_output_data+0xba/0xc0
 [<c0246a7c>] atapi_output_bytes+0x3c/0x90
 [<c025571c>] cdrom_newpc_intr+0x2ac/0x4e0
 [<c0246a40>] atapi_output_bytes+0x0/0x90
 [<c024cee4>] ide_intr+0x124/0x1e0
 [<c0255470>] cdrom_newpc_intr+0x0/0x4e0
 [<c010b595>] handle_IRQ_event+0x45/0x70
 [<c010b834>] do_IRQ+0xb4/0x150
 [<c0107070>] default_idle+0x0/0x50
 [<c0107070>] default_idle+0x0/0x50
 [<c0109e88>] common_interrupt+0x18/0x20
 [<c0107070>] default_idle+0x0/0x50
 [<c0107070>] default_idle+0x0/0x50
 [<c010709a>] default_idle+0x2a/0x50
 [<c010713a>] cpu_idle+0x3a/0x50
 [<c0105000>] stext+0x0/0x30

Code: f3 66 6f 5e c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 8b 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 

