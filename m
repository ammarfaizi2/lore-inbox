Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269997AbUJVHdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269997AbUJVHdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269800AbUJVHdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:33:21 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:6562
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269832AbUJSQrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:47:41 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041019162611.GA13232@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019144642.GA6512@elte.hu> <1098200916.12223.929.camel@thomas>
	 <20041019162611.GA13232@elte.hu>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098203978.12223.985.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 18:39:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 18:26, Ingo Molnar wrote:
> thanks, i've applied your patch to my tree. Find below an untested
> implementation of wait_for_completion_timeout().

Will give it a try.

Found another exterm ugly one. In scsi_error_handler a mutex is
initialized locked and then it is acquired again with
down_interruptible()

I have no fix yet. Somebody else ?

tglx


PCI: Found IRQ 10 for device 0000:00:02.0
sym0: <875> rev 0x4 at pci 0000:00:02.0 irq 10
BUG: semaphore recursion deadlock detected!
.. current task scsi_eh_0/730 is already holding cfed3ed8.
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 c025a590 00000000 c0104115 cfed7800 00000000 00000000
Call Trace:
 [<c025a590>] scsi_error_handler+0x0/0x100
 [<c0104115>] kernel_thread_helper+0x5/0x10
------------[ cut here ]------------
kernel BUG at lib/rwsem-generic.c:472!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c0307bb5>]    Not tainted VLI
EFLAGS: 00010046   (2.6.9-rc4-mm1-RT-U6)
EIP is at __down_write_interruptible+0xd5/0x296
eax: 00000001   ebx: 00000000   ecx: c036222c   edx: 00000001
esi: cfed3ed8   edi: cfd04070   ebp: 00000001   esp: cfed3e8c
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process scsi_eh_0 (pid: 730, threadinfo=cfed2000 task=cfd04070)
Stack: cfed3ed8 00000000 00000000 cfed3edc cfed3edc cfd04070 00000002
cfed2000
       cfed3ed8 cfed3ed8 00000000 c01c6ae4 cfed3ed8 cfd04070 cfed7800
00000000
       c025a617 c032a106 00000000 ffffffff cfed3e98 cfed3e98 00000001
cfd04070
Call Trace:
 [<c01c6ae4>] down_write_interruptible+0x44/0x70
 [<c025a617>] scsi_error_handler+0x87/0x100
 [<c025a590>] scsi_error_handler+0x0/0x100
 [<c0104115>] kernel_thread_helper+0x5/0x10
Code: 08 89 44 24 10 89 34 24 e8 29 e7 eb ff 89 34 24 e8 d1 e7 eb ff 85
c0 74 1a 8b 2d 20 b6 36 c0 85 ed 74 10 31 db 89 1d 2
 <6>note: scsi_eh_0[730] exited with preempt_count 2


