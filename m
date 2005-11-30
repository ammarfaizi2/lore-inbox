Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVK3CUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVK3CUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVK3CUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:20:39 -0500
Received: from utopia.booyaka.com ([206.168.112.107]:36750 "EHLO
	utopia.booyaka.com") by vger.kernel.org with ESMTP id S1750803AbVK3CUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:20:38 -0500
Date: Tue, 29 Nov 2005 19:20:38 -0700 (MST)
From: Paul Walmsley <paul@booyaka.com>
To: mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Force starget->scsi_level in usb-storage scsiglue.c
Message-ID: <Pine.LNX.4.63.0511291911180.20294@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

It seems likely that other USB storage enclosures with similar bugs
will also benefit from this patch.

Tony Lindgren <tony@atomide.com> collaborated in the development of this
patch.

Signed-off-by: Paul Walmsley <paul@booyaka.com>


- Paul

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 4837524..4ef5527 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
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



