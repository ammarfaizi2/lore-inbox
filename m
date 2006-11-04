Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753606AbWKDSjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbWKDSjp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbWKDSjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:39:45 -0500
Received: from rtr.ca ([64.26.128.89]:1551 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751850AbWKDSjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:39:44 -0500
Message-ID: <454CDE6E.5000507@rtr.ca>
Date: Sat, 04 Nov 2006 13:39:42 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Alberto Alonso <alberto@ggsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qstor driver -> irq 193: nobody cared
References: <1162576973.3967.10.camel@w100>
In-Reply-To: <1162576973.3967.10.camel@w100>
Content-Type: multipart/mixed;
 boundary="------------040700020100000805000103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040700020100000805000103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alberto Alonso wrote:
> I have a Pacific Digital qstor card on irq 193. I am using kernel
> 2.6.17.13 SMP
> 
> The error happens every now and then. I have not been able to
> figure out any triggers and I can not reproduce it on demand. Today
> it happened 3 times within a 40 minutes period. 
> 
> All disks connected to the card are disabled and I can't do anything
> other than a reboot to get them back.
> 
> It is reported as follows:
> 
> irq 193: nobody cared (try booting with the "irqpoll" option)
>  <c013e19a> __report_bad_irq+0x2a/0xa0  <c013d970> handle_IRQ_event
> +0x30/0x70
>  <c013e2b0> note_interrupt+0x80/0xf0  <c013da8c> __do_IRQ+0xdc/0xf0
>  <c0105799> do_IRQ+0x19/0x30  <c010391a> common_interrupt+0x1a/0x20
>  <c0100d91> default_idle+0x41/0x70  <c0100e60> cpu_idle+0x80/0x90
>  <c046699d> start_kernel+0x18d/0x1d0  <c0466330> unknown_bootoption
> +0x0/0x1d0
> handlers:
> [<c0301300>] (qs_intr+0x0/0x220)
> Disabling IRQ #193

What other devices are routed to that same interrupt line?

The sata_qstor driver is very rigorous in acknowledging *only* it's own
interrupts, to prevent other devices sharing the same IRQ from losing theirs.

Mmm.. We could apply a bit of fuzzy tolerance for the odd glitch.
Try this patch (attached) and report back.

Thanks.



--------------040700020100000805000103
Content-Type: text/x-patch;
 name="qstor_spurious.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qstor_spurious.patch"

--- linux/drivers/scsi/sata_qstor.c.orig	2006-09-19 23:42:06.000000000 -0400
+++ linux/drivers/scsi/sata_qstor.c	2006-11-04 13:35:45.000000000 -0500
@@ -459,6 +459,7 @@
 {
 	struct ata_host_set *host_set = dev_instance;
 	unsigned int handled = 0;
+	static int spurious = 0;
 
 	VPRINTK("ENTER\n");
 
@@ -466,6 +467,19 @@
 	handled  = qs_intr_pkt(host_set) | qs_intr_mmio(host_set);
 	spin_unlock(&host_set->lock);
 
+	/* There are reports of at least one system with glitchy interrupts,
+	 * and if we return !handled here for those then the kernel may totally
+	 * disable our own IRQ line (duh!).
+	 * So, try and be tolerant, but not *too* tolerant.
+	 */
+	if (!handled) {
+		if (spurious < 10) {
+			++spurious;
+			handled = 1;
+		}
+	} else if (spurious)
+		--spurious;
+
 	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);

--------------040700020100000805000103--
