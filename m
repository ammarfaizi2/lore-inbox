Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753023AbWKFOv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbWKFOv7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbWKFOv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:51:59 -0500
Received: from rtr.ca ([64.26.128.89]:35336 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1753023AbWKFOv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:51:58 -0500
Message-ID: <454F4C0C.8030505@rtr.ca>
Date: Mon, 06 Nov 2006 09:51:56 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Alberto Alonso <alberto@ggsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qstor driver -> irq 193: nobody cared
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca> <1162785871.5520.20.camel@w100>
In-Reply-To: <1162785871.5520.20.camel@w100>
Content-Type: multipart/mixed;
 boundary="------------070909000701060003090607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070909000701060003090607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alberto Alonso wrote:
> I have patched the system. I'll let you know if I get the
> same problem. Since I can't reproduce it on demand I may not see
> the problem for months. I don't know what happened the other day
> when it just started to happen repeatedly, I haven't had the issue
> since.

Ahh. Well, in that case please add a printk() line so that we'll know
if it *ever* does anything!  Updated patch attached.

Cheers


--------------070909000701060003090607
Content-Type: text/x-patch;
 name="qstor_spurious2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qstor_spurious2.patch"

--- old/drivers/scsi/sata_qstor.c	2006-09-19 23:42:06.000000000 -0400
+++ linux/drivers/scsi/sata_qstor.c	2006-11-06 09:50:02.000000000 -0500
@@ -459,6 +459,7 @@
 {
 	struct ata_host_set *host_set = dev_instance;
 	unsigned int handled = 0;
+	static int spurious = 0;
 
 	VPRINTK("ENTER\n");
 
@@ -466,6 +467,20 @@
 	handled  = qs_intr_pkt(host_set) | qs_intr_mmio(host_set);
 	spin_unlock(&host_set->lock);
 
+	/* There are reports of at least one system with glitchy interrupts,
+	 * and if we return !handled here for those then the kernel may totally
+	 * disable our own IRQ line (duh!).
+	 * So, try and be tolerant, but not *too* tolerant.
+	 */
+	if (!handled) {
+		if (spurious < 10) {
+			printk("sata_qstor: spurious=%d\n", spurious);
+			++spurious;
+			handled = 1;
+		}
+	} else if (spurious)
+		--spurious;
+
 	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);

--------------070909000701060003090607--
