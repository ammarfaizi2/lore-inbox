Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUIIWjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUIIWjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUIIWjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:39:25 -0400
Received: from gw.goop.org ([64.81.55.164]:41360 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S266669AbUIIWjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:39:20 -0400
Subject: [PATCH] Fix for spurious interrupts on e100 resume
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       scott.feldman@intel.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 09 Sep 2004 15:36:08 -0700
Message-Id: <1094769368.4298.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having problems with spurious interrupts being raised when the
e100 driver resets the chip during a resume:
irq 11: nobody cared!
 [<c0105937>] dump_stack+0x17/0x20
 [<c0107457>] __report_bad_irq+0x27/0x90
 [<c0107a1b>] note_interrupt+0x6b/0x1f0
 [<c0108132>] do_IRQ+0x272/0x360
 [<c010533c>] common_interrupt+0x18/0x20
 [<c012732b>] do_softirq+0x2b/0x30
 [<c01080d7>] do_IRQ+0x217/0x360
 [<c010533c>] common_interrupt+0x18/0x20
 [<c01f7d4c>] __delay+0xc/0x10
 [<f8b4806b>] e100_hw_reset+0x6b/0x90 [e100]
 [<f8b48d70>] e100_hw_init+0x10/0x1490 [e100]
 [<f8b4cd9f>] e100_up+0x3f/0x2e0 [e100]
 [<f8b4f11f>] e100_resume+0x8f/0xb0 [e100]
 [<c01fca62>] pci_device_resume+0x22/0x30
 [<c023736a>] resume_device+0x1a/0x20
 [<c02373dd>] dpm_resume+0x6d/0x70
 [<c02373fc>] device_resume+0x1c/0x30
 [<c01150d0>] suspend+0x540/0x7c0
 [<c0115e33>] do_ioctl+0x123/0x180
 [<c0185397>] sys_ioctl+0xb7/0x210
 [<c010497d>] sysenter_past_esp+0x52/0x71
handlers:
[<c02782c0>] (yenta_interrupt+0x0/0x30)
[<f89c3310>] (radeon_driver_irq_handler+0x0/0xb0 [radeon])
[<f88c9320>] (usb_hcd_irq+0x0/0x60 [usbcore])
Disabling IRQ #11


The interrupt seems to be generated during the [um]sleep after one of
the writel's in e100_hw_reset.  To fix this, I simply moved the call to
e100_disable_irq() to be first in the function, which seems to work
well.

	J

Patch:

On resume, the e100 chip seems to raise an interrupt during chip reset.
Since there's no IRQ handler registered yet, the kernel complains that
"nobody cared" about the interrupt.  This change moves the call to
e100_disable_irq to be first in e100_hw_reset() so there are no spurious
interrupts.


 drivers/net/e100.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/net/e100.c~e100-restore-irq drivers/net/e100.c
--- local-2.6/drivers/net/e100.c~e100-restore-irq	2004-09-09 12:52:33.000000000 -0700
+++ local-2.6-jeremy/drivers/net/e100.c	2004-09-09 12:53:18.000000000 -0700
@@ -587,6 +587,10 @@ static inline void e100_disable_irq(stru
 
 static void e100_hw_reset(struct nic *nic)
 {
+	/* Mask off our interrupt line - it's unmasked after reset 
+	   Do it early to prevent spurious interrupts. */
+	e100_disable_irq(nic);
+
 	/* Put CU and RU into idle with a selective reset to get
 	 * device off of PCI bus */
 	writel(selective_reset, &nic->csr->port);
@@ -605,9 +609,6 @@ static void e100_hw_reset(struct nic *ni
 		writeb(cuc_load_base, &nic->csr->scb.cmd_lo);
 		mdelay(20);
 	}
-
-	/* Mask off our interrupt line - it's unmasked after reset */
-	e100_disable_irq(nic);
 }
 
 static int e100_self_test(struct nic *nic)

_
Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

