Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVLUW2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVLUW2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVLUW2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:28:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:57046 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964840AbVLUW2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:28:31 -0500
Date: Wed, 21 Dec 2005 14:28:06 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paul@booyaka.com,
       mdharm-usb@one-eyed-alien.net, linux-usb-devel@lists.sourceforge.net
Subject: [patch 1/2] USB Storage: Force starget->scsi_level in usb-storage scsiglue.c
Message-ID: <20051221222806.GA9518@kroah.com>
References: <20051216185442.633779000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221222743.GA9501@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Walmsley <paul@booyaka.com>

When the usb-storage module forces sdev->scsi_level to SCSI_2, it should
also force starget->scsi_level to the same value.  Otherwise, the SCSI
layer may attempt to issue SCSI-3 commands to the device, such as REPORT
LUNS, which it cannot handle.  This can prevent the device from working
with Linux.

The AMS Venus DS3 DS2316SU2S SATA-to-SATA+USB enclosure, based on the
Oxford Semiconductor OXU921S chip, requires this patch to function
correctly on Linux.  The enclosure reports a SCSI-3 SPC-2 command set
level, but does not correctly handle the REPORT LUNS SCSI command -
probably due to a bug in its firmware.

It seems likely that other USB storage enclosures with similar bugs will
also benefit from this patch.

Tony Lindgren <tony@atomide.com> collaborated in the development of this
patch.

Signed-off-by: Paul Walmsley <paul@booyaka.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/storage/scsiglue.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/usb/storage/scsiglue.c
+++ gregkh-2.6/drivers/usb/storage/scsiglue.c
@@ -109,7 +109,7 @@ static int slave_configure(struct scsi_d
 	 * data comes from.
 	 */
 	if (sdev->scsi_level < SCSI_2)
-		sdev->scsi_level = SCSI_2;
+		sdev->scsi_level = sdev->sdev_target->scsi_level = SCSI_2;
 
 	/* According to the technical support people at Genesys Logic,
 	 * devices using their chips have problems transferring more than
@@ -162,7 +162,7 @@ static int slave_configure(struct scsi_d
 		 * a Get-Max-LUN request, we won't lose much by setting the
 		 * revision level down to 2.  The only devices that would be
 		 * affected are those with sparse LUNs. */
-		sdev->scsi_level = SCSI_2;
+		sdev->scsi_level = sdev->sdev_target->scsi_level = SCSI_2;
 
 		/* USB-IDE bridges tend to report SK = 0x04 (Non-recoverable
 		 * Hardware Error) when any low-level error occurs,
