Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967818AbWLDXcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967818AbWLDXcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967817AbWLDXcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:32:25 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:41001 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967814AbWLDXcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:32:23 -0500
Message-ID: <4574B004.6030606@us.ibm.com>
Date: Mon, 04 Dec 2006 15:32:20 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org>
In-Reply-To: <4574AB78.40102@garzik.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Quantum GoVault SATAPI removable disk device returns ATA_ERR in
response to a REPORT LUNS packet.  If this happens to an ATAPI device
that is attached to a SAS controller (this is the case with sas_ata),
the device does not load because SCSI won't touch a "SCSI device"
that won't report its LUNs.  Since most ATAPI devices don't support
multiple LUNs anyway, we might as well fake a response like we do for
ATA devices.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/ata/libata-scsi.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 47ea111..5ecf260 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2833,8 +2833,13 @@ static inline int __ata_scsi_queuecmd(st
 			rc = ata_scsi_translate(dev, cmd, done, xlat_func);
 		else
 			ata_scsi_simulate(dev, cmd, done);
-	} else
-		rc = ata_scsi_translate(dev, cmd, done, atapi_xlat);
+	} else {
+		/* Simulate REPORT LUNS for ATAPI devices */
+		if (cmd->cmnd[0] == REPORT_LUNS)
+			ata_scsi_simulate(dev, cmd, done);
+		else
+			rc = ata_scsi_translate(dev, cmd, done, atapi_xlat);
+	}
 
 	return rc;
 }

