Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTJSTzN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTJSTzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:55:13 -0400
Received: from smtp5.hy.skanova.net ([195.67.199.134]:507 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262190AbTJSTzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:55:01 -0400
To: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test8, DEBUG_SLAB, oops in as_latter_request()
From: Peter Osterlund <petero2@telia.com>
Date: 19 Oct 2003 21:54:38 +0200
Message-ID: <m2ismlovep.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running 2.6.0-test8 compiled with CONFIG_DEBUG_SLAB=y. When
testing the CDRW packet writing driver, I got an oops in
as_latter_request. (Full oops at the end of this message.) It is
repeatable and happens because arq->rb_node.rb_right is uninitialized.

Although I have only seen this when using the packet writing driver, I
don't think that driver is causing the problem. It isn't doing
anything fancy with the cdrom request queue. It is only submitting a
bunch of read/write requests using submit_bio() when the oops happens.

This patch appears to fix the problem, but I haven't tried to
understand the AS code, so I don't know if this is the correct
solution.

--- linux/drivers/block/as-iosched.c~	2003-10-09 18:54:36.000000000 +0200
+++ linux/drivers/block/as-iosched.c	2003-10-19 20:33:45.000000000 +0200
@@ -1718,6 +1718,7 @@
 	struct as_rq *arq = mempool_alloc(ad->arq_pool, gfp_mask);
 
 	if (arq) {
+		memset(&arq->rb_node, 0, sizeof(struct rb_node));
 		RB_CLEAR(&arq->rb_node);
 		arq->request = rq;
 		arq->state = AS_RQ_NEW;

Here is the oops:

Unable to handle kernel paging request at virtual address 5a5a5a66
 printing eip:
c02213ef
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02213ef>]    Not tainted
EFLAGS: 00010006
EIP is at rb_next+0xf/0x60
eax: 5a5a5a5a   ebx: c5ec0510   ecx: c373597c   edx: 5a5a5a5a
esi: c373597c   edi: 00000292   ebp: c3375d98   esp: c3375d98
ds: 007b   es: 007b   ss: 0068
Process ld (pid: 1290, threadinfo=c3374000 task=c3656fc0)
Stack: c3375da4 c0266df4 c5e8277c c3375db4 c025d37e c5ec0510 c373597c c3375de4 
       c02609df c5ec0510 c373597c c373597c c3375de4 c027da4c 00000000 c5e59d2c 
       c373597c c041280c c5e59d2c c3375e04 c027dab2 c5ec0510 c373597c 00000000 
Call Trace:
 [<c0266df4>] as_latter_request+0x14/0x30
 [<c025d37e>] elv_latter_request+0x2e/0x30
 [<c02609df>] blk_attempt_remerge+0x8f/0x1a0
 [<c027da4c>] restore_request+0xcc/0xe0
 [<c027dab2>] cdrom_start_read+0x52/0xb0
 [<c027eab4>] ide_do_rw_cdrom+0x74/0x190
 [<c026b141>] start_request+0x181/0x290
 [<c026b4c3>] ide_do_request+0x243/0x4c0
 [<c026c1ab>] ide_intr+0x36b/0x5d0
 [<c027d220>] cdrom_read_intr+0x0/0x3f0
 [<c010c1bb>] handle_IRQ_event+0x3b/0x70
 [<c010c7d1>] do_IRQ+0x141/0x3b0
 [<c010a6f8>] common_interrupt+0x18/0x20
 [<c0127d1d>] do_softirq+0x4d/0xb0
 [<c010c8e5>] do_IRQ+0x255/0x3b0
 [<c015d9aa>] sys_brk+0xfa/0x130
 [<c010a6f8>] common_interrupt+0x18/0x20

Code: 8b 40 0c 85 c0 74 13 8d 76 00 8d bc 27 00 00 00 00 89 c2 8b 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
