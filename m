Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVDUMgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVDUMgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 08:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVDUMgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 08:36:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9907 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261332AbVDUMgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 08:36:44 -0400
Message-ID: <42679E5B.4030809@suse.de>
Date: Thu, 21 Apr 2005 14:36:43 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] scan all enabled ports on ata_piix
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040005050908070601050106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040005050908070601050106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi all,

on this ACER travelmate (ICH6 chipset) the BIOS somehow sets the
PIIX_PORT_ENABLED bit, but not the PIIX_PORT_PRESENT bit.
Appearently the BIOS did not do any device scan / initialisation, and
then, the ICH6 spec does not actually require it.
As the current code scans for PIIX_PORT_PRESENT | PIIX_PORT_ENABLED it
fails to detect any devices.
And as the spec is somewhat unclear at this point I'd vote for relaxing
the check to PIIX_PORT_ENABLED only.
It doesn't do any harm as any non-existing devices will be discarded
later on anyway.

Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------040005050908070601050106
Content-Type: text/plain;
 name="ata_piix-scan-all-enabled-ports"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ata_piix-scan-all-enabled-ports"

Subject: ata_piix does not find any devices on ACER laptop
From: Hannes Reinecke <hare@suse.de>
References: 78564

ICH6 spec defines the PORT_ bits as:
PORT_ENABLED (R/W): 
0 = Disabled. The port is in the  off  state and cannot detect any
devices.
1 = Enabled. The port can transition between the on,
partial, and slumber states and can detect devices.

PORT_PRESENT  (R/O) The status of this bit may change at any time. This
bit is cleared when the port is disabled via PORT_ENABLED. This bit is not
cleared upon surprise removal of a device.

So from a textual view it is not necessary that PORT_PRESENT _must_ be
set, especially if a device detection has to be done anyway. And, in
fact, this is the view that ACER has been taken with its new Laptops
(e.g. Travelmate 4150).

And the definition of PORT_ENABLED / PORT_PRESENT is mixed up, btw.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>

--- linux-2.6.11/drivers/scsi/ata_piix.c.orig	2005-04-20 15:09:20.000000000 +0200
+++ linux-2.6.11/drivers/scsi/ata_piix.c	2005-04-21 14:13:49.000000000 +0200
@@ -50,8 +50,8 @@ enum {
 	PIIX_COMB_PATA_P0	= (1 << 1),
 	PIIX_COMB		= (1 << 2), /* combined mode enabled? */
 
-	PIIX_PORT_PRESENT	= (1 << 0),
-	PIIX_PORT_ENABLED	= (1 << 4),
+	PIIX_PORT_ENABLED	= (1 << 0),
+	PIIX_PORT_PRESENT	= (1 << 4),
 
 	PIIX_80C_PRI		= (1 << 5) | (1 << 4),
 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
@@ -342,7 +342,9 @@ static void piix_pata_phy_reset(struct a
  *	None (inherited from caller).
  *
  *	RETURNS:
- *	Non-zero if device detected, zero otherwise.
+ *	Non-zero if port is enabled, it may or may not have a device
+ *	attached in that case (PRESENT bit would only be set if BIOS probe
+ *	was done). Zero is returned if port is disabled.
  */
 static int piix_sata_probe (struct ata_port *ap)
 {
@@ -366,7 +368,7 @@ static int piix_sata_probe (struct ata_p
 	 */
 
 	for (i = 0; i < 4; i++) {
-		mask = (PIIX_PORT_PRESENT << i) | (PIIX_PORT_ENABLED << i);
+		mask = (PIIX_PORT_ENABLED << i);
 
 		if ((orig_mask & mask) == mask)
 			if (combined || (i == ap->hard_port_no))

--------------040005050908070601050106--
