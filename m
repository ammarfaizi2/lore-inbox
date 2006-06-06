Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750810AbWFFDeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWFFDeV (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 23:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWFFDeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 23:34:21 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40436 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750810AbWFFDeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 23:34:20 -0400
Subject: [PATCH -mm] misroute-irq: Don't call desc->chip->end because of
	edge interrupts
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060604214448.GA6602@elte.hu>
References: <1149112582.3114.91.camel@laptopd505.fenrus.org>
	 <1149345421.13993.81.camel@localhost.localdomain>
	 <20060603215323.GA13077@devserv.devel.redhat.com>
	 <1149374090.14408.4.camel@localhost.localdomain>
	 <1149413649.3109.92.camel@laptopd505.fenrus.org>
	 <1149426961.27696.7.camel@localhost.localdomain>
	 <1149437412.23209.3.camel@localhost.localdomain>
	 <1149438131.29652.5.camel@localhost.localdomain>
	 <1149456375.23209.13.camel@localhost.localdomain>
	 <1149456532.29652.29.camel@localhost.localdomain>
	 <20060604214448.GA6602@elte.hu>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 23:33:50 -0400
Message-Id: <1149564830.16247.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hit the following BUG with irqpoll.  The below patch fixes it.

hda: WDC WD2000BB-00GUA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14<1>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010002   (2.6.17-rc5-mm3 #23)
EIP is at 0x0
eax: c03f2540   ebx: c277dcc0   ecx: c03ea9c4   edx: 00000001
esi: 0000000e   edi: c03ea9e4   ebp: c03f5f08   esp: c03f5ed8
ds: 007b   es: 007b   ss: 0068
Process idle (pid: 0, threadinfo=c03f4000 task=c036d540)
Stack: c01488c5 0000000e c03f5f60 c277dcc0 00000000 00000001 c03ea9c4 c03ea9d0
       c03ea9d4 c03ea2c0 00000000 c03ea2e4 c03f5f38 c014904d 00000000 c03ea2c0
       00000001 c03f5f60 c03f5f60 00000000 c0370c00 c0148f30 00000000 c03f5f60
Call Trace:
 [<c0103db7>] show_stack_log_lvl+0xa7/0xf0
 [<c0103fc0>] show_registers+0x1c0/0x260
 [<c0104535>] die+0x135/0x2d0
 [<c0114be2>] do_page_fault+0x6b2/0x79c
 [<c01035f5>] error_code+0x39/0x40
 [<c014904d>] handle_edge_irq+0x11d/0x150
 [<c01055de>] do_IRQ+0x5e/0xb0
 [<c010348d>] common_interrupt+0x25/0x2c
 [<c010162d>] cpu_idle+0x4d/0xb0
 [<c01002e5>] rest_init+0x45/0x50
 [<c03fa81a>] start_kernel+0x32a/0x460
 [<c0100210>] 0xc0100210
Code:  Bad EIP value.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


Index: linux-2.6.17-rc5-mm3/kernel/irq/spurious.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/kernel/irq/spurious.c	2006-06-05 17:26:15.000000000 -0400
+++ linux-2.6.17-rc5-mm3/kernel/irq/spurious.c	2006-06-05 19:47:58.000000000 -0400
@@ -77,7 +77,7 @@ static int misrouted_irq(int irq, struct
 		 * If we did actual work for the real IRQ line we must let the
 		 * IRQ controller clean up too
 		 */
-		if (work)
+		if (work && disc->chip && desc->chip->end)
 			desc->chip->end(i);
 		spin_unlock(&desc->lock);
 	}


