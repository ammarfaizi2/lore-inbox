Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWHYKXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWHYKXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWHYKXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:23:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7297 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751289AbWHYKXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:23:50 -0400
Date: Fri, 25 Aug 2006 12:16:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [patch] lockdep: annotate idescsi_pc_intr()
Message-ID: <20060825101640.GA26188@elte.hu>
References: <20060820013121.GA18401@fieldses.org> <44E97353.76E4.0078.0@novell.com> <20060821094718.79c9a31a.rdunlap@xenotime.net> <20060821212043.332fdd0f.akpm@osdl.org> <20060822175211.GC16145@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822175211.GC16145@fieldses.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* J. Bruce Fields <bfields@fieldses.org> wrote:

> ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> BUG: warning at kernel/lockdep.c:1803/trace_hardirqs_on()
>  [<c0103df6>] show_trace+0x16/0x20
>  [<c0103ecb>] dump_stack+0x1b/0x20
>  [<c012e997>] trace_hardirqs_on+0xf7/0x130
>  [<c0445e63>] idescsi_pc_intr+0x63/0x450
>  [<c042fe5c>] ide_intr+0x7c/0x1d0
>  [<c013a727>] handle_IRQ_event+0x27/0x60
>  [<c013a7f4>] __do_IRQ+0x94/0x110
>  [<c0104cba>] do_IRQ+0xaa/0xf0
>  [<c0103105>] common_interrupt+0x25/0x30
>  [<c010d6c9>] apm_cpu_idle+0x1e9/0x270
>  [<c010163c>] cpu_idle+0x2c/0x80
>  [<c0100507>] rest_init+0x37/0x40
>  [<c0823756>] start_kernel+0x266/0x2b0
>  [<c0100199>] 0xc0100199
>   Vendor: PIONEER   Model: DVD-ROM DVD-116   Rev: 1.22
>   Type:   CD-ROM                             ANSI SCSI revision: 00

the patch below should get rid of the warning above.

	Ingo

-------->
Subject: lockdep: annotate idescsi_pc_intr()
From: Ingo Molnar <mingo@elte.hu>

idescsi_pc_intr() uses local_irq_enable() in IRQ context: annotate it.

(this has no effect on kernels with lockdep disabled. On kernels with
lockdep enabled this means that we wont actually disable interrupts,
and the warning message will go away as well.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/scsi/ide-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/scsi/ide-scsi.c
===================================================================
--- linux.orig/drivers/scsi/ide-scsi.c
+++ linux/drivers/scsi/ide-scsi.c
@@ -517,7 +517,7 @@ static ide_startstop_t idescsi_pc_intr (
 		/* No more interrupts */
 		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
 			printk (KERN_INFO "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
-		local_irq_enable();
+		local_irq_enable_in_hardirq();
 		if (status.b.check)
 			rq->errors++;
 		idescsi_end_request (drive, 1, 0);
