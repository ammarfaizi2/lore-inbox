Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbTFXEzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 00:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbTFXEzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 00:55:00 -0400
Received: from srv1.mail.cv.net ([167.206.112.40]:38593 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id S265676AbTFXEyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 00:54:54 -0400
Date: Tue, 24 Jun 2003 01:08:59 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: Re: Linux 2.5.73 - panic (freed memory) on CD-Recorder errors
In-reply-to: <20030623080912.GA7383@suse.de>
X-X-Sender: proski@localhost.localdomain
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.44.0306240035250.1441-200000@localhost.localdomain>
Content-id: <Pine.LNX.4.44.0306240106420.1647@localhost.localdomain>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_Y4bKP1dfgpKBBXrlHEoGPA)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_Y4bKP1dfgpKBBXrlHEoGPA)
Content-id: <Pine.LNX.4.44.0306240106421.1647@localhost.localdomain>
Content-type: TEXT/PLAIN; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT

On Mon, 23 Jun 2003, Jens Axboe wrote:

> > Note 6b6b6b6b in the eax and esi registers and on the stack.  That must be
> > freed memory. __end_that_request_first() is a static function in
> > drivers/block/ll_rw_blk.c
> 
> That doesn't look good. I'll try and reproduce + fix here, thanks for
> the report.

What happens is cdrom_newpc_intr() calls cdrom_decode_status() which frees 
rq, and then is calls end_that_request_chunk() that tries to use rq->bio.

I tried the patch below, and it seems to delay the panic, but it happens
seconds later anyways in a different place but still on 6b6b6b6b address.
The new stack trace is attached.

Patch (possibly wrong or incomplete):
===================================
--- linux.orig/drivers/ide/ide-cd.c
+++ linux/drivers/ide/ide-cd.c
@@ -1664,7 +1664,7 @@ static ide_startstop_t cdrom_newpc_intr(
 	}
 
 	if (cdrom_decode_status(drive, 0, &stat)) {
-		end_that_request_chunk(rq, 1, rq->data_len);
+		printk("ide-cd: newpc_intr decode_status bad\n");
 		return ide_stopped;
 	}
 
===================================

-- 
Regards,
Pavel Roskin

--Boundary_(ID_Y4bKP1dfgpKBBXrlHEoGPA)
Content-id: <Pine.LNX.4.44.0306240056530.1574@localhost.localdomain>
Content-type: TEXT/PLAIN; NAME=new_panic; CHARSET=US-ASCII
Content-description: 
Content-disposition: ATTACHMENT; FILENAME=new_panic
Content-transfer-encoding: 7BIT

ide-cd: newpc_intr decode_status bad
ide-cd: newpc_intr decode_status bad
ide-cd: newpc_intr decode_status bad
ide-cd: newpc_intr decode_status bad
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
6b6b6b6b
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<6b6b6b6b>]    Not tainted
EFLAGS: 00010002
EIP is at 0x6b6b6b6b
eax: 6b6b6b6b   ebx: f7fdad3c   ecx: f7fdad3c   edx: 6b6b6b6b
esi: 00000000   edi: c04cb2f0   ebp: c0471ce4   esp: c0471cc8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0470000 task=c03f2dc0)
Stack: c0153d9e f7fdad3c 6b6b6b6b 00000000 00000000 f7fdabe8 fffffffb c0471d10
       c013e25e f7fdad3c 6b6b6b6b 00000000 f7fdad3c c1af6de4 f7fdabe8 f7fdabe8
       fffffffb c04cb2f0 c0471d20 c013e298 f7fdabe8 c1af6de4 c0471d40 c0153d9e
Call Trace:
 [<c0153d9e>] bio_endio+0x4e/0x80
 [<c013e25e>] bounce_end_io+0x8e/0xa0
 [<c013e298>] bounce_end_io_write+0x28/0x30
 [<c0153d9e>] bio_endio+0x4e/0x80
 [<c02aedd4>] __end_that_request_first+0x1e4/0x200
 [<c02c2822>] ide_end_request+0x62/0x140
 [<c02d190c>] cdrom_end_request+0x9c/0xb0
 [<c02d1a14>] cdrom_decode_status+0xf4/0x320
 [<c02d7793>] __ide_dma_end+0x73/0xa0
 [<c02d2dc8>] cdrom_newpc_intr+0x48/0x4e0
 [<c02d77e1>] __ide_dma_test_irq+0x21/0x60
 [<c02c408b>] ide_intr+0xfb/0x190
 [<c02d365d>] cdrom_do_newpc_cont+0x3d/0x40
 [<c02d2d80>] cdrom_newpc_intr+0x0/0x4e0
 [<c010ac4b>] handle_IRQ_event+0x3b/0x70
 [<c010afc1>] do_IRQ+0xb1/0x170
 [<c0109458>] common_interrupt+0x18/0x20
 [<c02a49e6>] serial_in+0x26/0x60
 [<c012238d>] update_wall_time+0xd/0x40
 [<c02a5dc7>] serial8250_interrupt+0x37/0x110
 [<c010ac4b>] handle_IRQ_event+0x3b/0x70
 [<c010afc1>] do_IRQ+0xb1/0x170
 [<c0109458>] common_interrupt+0x18/0x20
 [<c02673d3>] acpi_processor_idle+0x15a/0x1ef
 [<c0107040>] default_idle+0x0/0x30
 [<c0267279>] acpi_processor_idle+0x0/0x1ef
 [<c0107040>] default_idle+0x0/0x30
 [<c01070e1>] cpu_idle+0x31/0x40
 [<c0105000>] _stext+0x0/0x60
 [<c0472729>] start_kernel+0x149/0x150
 [<c04724a0>] unknown_bootoption+0x0/0x100

Code:  Bad EIP value.
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

--Boundary_(ID_Y4bKP1dfgpKBBXrlHEoGPA)--
