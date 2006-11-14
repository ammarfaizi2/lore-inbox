Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966244AbWKNSXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966244AbWKNSXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966252AbWKNSXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:23:36 -0500
Received: from rtr.ca ([64.26.128.89]:2565 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S966244AbWKNSXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:23:35 -0500
Message-ID: <455A09A5.2020200@rtr.ca>
Date: Tue, 14 Nov 2006 13:23:33 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Alberto Alonso <alberto@ggsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qstor driver -> irq 193: nobody cared
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca>	 <1163363479.3423.8.camel@w100>  <45588132.9090200@rtr.ca>	 <1163479852.3340.9.camel@w100>  <4559F2EE.7080309@rtr.ca> <1163528258.3340.23.camel@w100>
In-Reply-To: <1163528258.3340.23.camel@w100>
Content-Type: multipart/mixed;
 boundary="------------030608050906020003020805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030608050906020003020805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alberto Alonso wrote:
> Sounds good, let me know if you need me to do any
> testing or help on the programming. 

Okay, try this (untested) and see if it cleans things up.
I'm also including the old "printk" patch, so that we can
tell whether the "fix" is actually working or not.

Thanks

--------------030608050906020003020805
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

--------------030608050906020003020805
Content-Type: text/x-patch;
 name="qstor_nien_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qstor_nien_fix.patch"

--- old/drivers/scsi/sata_qstor.c	2006-11-14 11:30:37.000000000 -0500
+++ linux/drivers/scsi/sata_qstor.c	2006-11-14 13:22:05.000000000 -0500
@@ -299,6 +299,19 @@
 	return nelem;
 }
 
+static void qs_set_nien (struct ata_port *ap, int new_nien)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	if ((ap->ctl & ATA_NIEN) != new_nien) {
+		ap->ctl = (ap->ctl & ~ATA_NIEN) | new_nien;
+		ap->last_ctl = ap->ctl;
+		writeb(ap->ctl, (void __iomem *)ioaddr->ctl_addr);
+		wmb();
+		ata_check_status(ap);
+	}
+}
+
 static void qs_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct qs_port_priv *pp = qc->ap->private_data;
@@ -357,6 +370,8 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+		/* packet mode requires that the NIEN bit be turned on */
+		qs_set_nien(qc->ap, ATA_NIEN);
 
 		pp->state = qs_state_pkt;
 		qs_packet_start(qc);
@@ -370,6 +385,7 @@
 		break;
 	}
 
+	qs_set_nien(qc->ap, 0); // FIXME: is this necessary here?
 	pp->state = qs_state_mmio;
 	return ata_qc_issue_prot(qc);
 }

--------------030608050906020003020805--
