Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTFDVuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbTFDVuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:50:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28342 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264158AbTFDVuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:50:17 -0400
Date: Wed, 4 Jun 2003 15:04:15 -0700
From: Dave Olien <dmo@osdl.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: DAC960 crash dequeueing request
Message-ID: <20030604220415.GA15621@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In linux 2.5.70, with no patches applied, we've had one BUG of the form:

kernel BUG at include/linux/blkdev.h:407!

This is running a database workload, on an 8-way x86 machine with 4gig
of memory.  we've seen this only once, after 6 hours of run time.
Ironically, the BUG occurs during a part of the test that is not
particularly disk I/O intensive. The disk I/O that IS going on at this
time is predominantly sequential writes to a logging device.

no file systems are involved.

------------[ cut here ]------------
kernel BUG at include/linux/blkdev.h:407!
invalid operand: 0000 [#1]
CPU:    4
EIP:    0060:[<c01f3565>]    Not tainted
EFLAGS: 00010046
EIP is at DAC960_ProcessRequest+0xb5/0x170
eax: 00000080   ebx: f78f3360   ecx: f59eeb98   edx: f59eeb98
esi: f7fa8174   edi: f05fbc58   ebp: f7fa8000   esp: f05fbc0c
ds: 007b   es: 007b   ss: 0068
Process kernel (pid: 8281, threadinfo=f05fa000 task=f0737940)
Stack: 01000082 00000001 f7fa8174 f05fbc58 00000002 c01f36d6 f7fa8000
00000001 
       f7fa8174 c032c8a0 c01e10c2 f7fa8174 00000040 00000000 00209008
f7656e00 
       f05fbc58 c01e1252 f7fa8174 f05fbc58 f05fbc58 f7656e00 f05fa000
00000000 
Call Trace:
 [<c01f36d6>] DAC960_RequestFunction+0x26/0x30
 [<c01e10c2>] generic_unplug_device+0x52/0x70
 [<c01e1252>] blk_run_queues+0x72/0xa0
 [<c016a676>] dio_await_one+0x56/0xa0
 [<c016a7ad>] dio_await_completion+0x1d/0x40
 [<c016b2ee>] direct_io_worker+0x2ce/0x340
 [<c016b499>] blockdev_direct_IO+0x139/0x14c
 [<c0152a90>] blkdev_get_blocks+0x0/0x90
 [<c0152b61>] blkdev_direct_IO+0x41/0x50
 [<c0152a90>] blkdev_get_blocks+0x0/0x90
 [<c013575c>] generic_file_direct_IO+0x5c/0x80
 [<c0134f04>] generic_file_aio_write_nolock+0x3f4/0x9a0
 [<c01a9f24>] sys_semtimedop+0x564/0x5b0
 [<c0152b61>] blkdev_direct_IO+0x41/0x50
 [<c0152a90>] blkdev_get_blocks+0x0/0x90
 [<c013575c>] generic_file_direct_IO+0x5c/0x80
 [<c01631cd>] update_atime+0x6d/0xc0
 [<c0133e71>] __generic_file_aio_read+0x111/0x1e0
 [<c013551f>] generic_file_write_nolock+0x6f/0x90
 [<c0121edb>] do_softirq+0x6b/0xd0
 [<c01169e9>] smp_apic_timer_interrupt+0x149/0x160
 [<c011181d>] restore_i387_fxsave+0x5d/0x70
 [<c01cdf47>] raw_file_write+0x27/0x30
 [<c014c07a>] vfs_write+0xaa/0xe0
 [<c014bb50>] default_llseek+0x0/0xd0
 [<c014bd65>] sys_llseek+0xb5/0xe0
 [<c014c12f>] sys_write+0x2f/0x50
 [<c010a953>] syscall_call+0x7/0xb

Code: 0f 0b 97 01 04 93 2a c0 8b 41 04 89 42 04 89 10 89 09 89 49 

--------------------------------------------------------------------
 
The BUG is occuring in DAC960_ProcessRequest, which essentially does:

The DAC960_ProcessRequest 
{
	elv_next_request

	blkdev_dequeue_request
}

It looks as though there was a request on the request queue
when elv_next_request was called, but it was removed before
blkdev_dequeue_request is called.  The only scenarios I can
imagine this happening would be if there were some flaw in the
locking code around accesses to the request queue, or if there were
some other kind of memory corruption going on.

Regarding locking,

Called from DAC960_RequestFunction, which is entered and exited
with queue_lock held.

Called from DAC960_BA_InterruptHandler(), with queue_lock held.

I'm looking for some hints on how to track down what's happening, so that
when it happens again, we can get more information.

I'm thinking of starting by stashing a copy of the request structure found
on the request queue, and dumping it out at BUG() time, to see if
examining the data there gives any hint what happened to it.
