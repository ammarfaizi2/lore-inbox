Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424053AbWKPNxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424053AbWKPNxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 08:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933502AbWKPNxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 08:53:15 -0500
Received: from rtr.ca ([64.26.128.89]:4100 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S933501AbWKPNxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 08:53:14 -0500
Message-ID: <455C6D48.8040501@rtr.ca>
Date: Thu, 16 Nov 2006 08:53:12 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Alberto Alonso <alberto@ggsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qstor driver -> irq 193: nobody cared
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca>	 <1163363479.3423.8.camel@w100>  <45588132.9090200@rtr.ca>	 <1163479852.3340.9.camel@w100>  <4559F2EE.7080309@rtr.ca>	 <1163528258.3340.23.camel@w100>  <455A09A5.2020200@rtr.ca> <1163658952.3416.13.camel@w100>
In-Reply-To: <1163658952.3416.13.camel@w100>
Content-Type: multipart/mixed;
 boundary="------------060201070804060309050006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201070804060309050006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alberto Alonso wrote:
> Sorry for the long delay, I've been called on too
> many issues at work this week.
> 
> Anyway, the patch basically made the drives not usable.

Mmm.. Okay, thanks for helping track this down.

It appears that this got broken when the ATA_TFLAG_POLLING
got introduced into libata, replacing previous checks of ATA_NIEN.
Or maybe even before that.  Not many of us have qstor cards!

Speaking of which, I'll dig my own qstor card out of mothballs soon,
and work out a proper fix for it soon-ish.

In the meanwhile, could you take a clean kernel, and apply the first
attached patch (qstor_spurious_1.patch), and see if it fixes things.

If not, then you can instead apply the second patch (qstor_spurious_kludge.patch)
and your problems should disappear.  But I cannot actually push that rubbish
upstream, so a "proper" fix will have to come later.

Cheers

--------------060201070804060309050006
Content-Type: text/x-patch;
 name="qstor_spurious_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qstor_spurious_1.patch"

--- linux/drivers/scsi/sata_qstor.c.orig	2006-09-19 23:42:06.000000000 -0400
+++ linux/drivers/scsi/sata_qstor.c	2006-11-16 08:46:43.000000000 -0500
@@ -399,6 +399,7 @@
 			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 				struct ata_queued_cmd *qc;
 				struct qs_port_priv *pp = ap->private_data;
+				ata_check_status(ap); /* kill spurious ints */
 				if (!pp || pp->state != qs_state_pkt)
 					continue;
 				qc = ata_qc_from_tag(ap, ap->active_tag);

--------------060201070804060309050006
Content-Type: text/x-patch;
 name="qstor_spurious_kludge.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qstor_spurious_kludge.patch"

--- linux/drivers/scsi/sata_qstor.c.orig	2006-09-19 23:42:06.000000000 -0400
+++ linux/drivers/scsi/sata_qstor.c	2006-11-16 08:49:57.000000000 -0500
@@ -423,7 +423,7 @@
 
 static inline unsigned int qs_intr_mmio(struct ata_host_set *host_set)
 {
-	unsigned int handled = 0, port_no;
+	unsigned int handled = 1, port_no;
 
 	for (port_no = 0; port_no < host_set->n_ports; ++port_no) {
 		struct ata_port *ap;
@@ -432,13 +432,13 @@
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 			struct qs_port_priv *pp = ap->private_data;
+			u8 status = ata_check_status(ap);
 			if (!pp || pp->state != qs_state_mmio)
 				continue;
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
-				u8 status = ata_check_status(ap);
 				if ((status & ATA_BUSY))
 					continue;
 				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",

--------------060201070804060309050006--
