Return-Path: <linux-kernel-owner+w=401wt.eu-S964982AbWLMQMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWLMQMG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWLMQMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:12:05 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:45435 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964972AbWLMQME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:12:04 -0500
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Douglas Gilbert <dougg@torque.net>
In-Reply-To: <457F2C1C.1030503@us.ibm.com>
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org>
	 <4574B004.6030606@us.ibm.com>  <457D8637.5070707@garzik.org>
	 <1165855489.2791.7.camel@mulgrave.il.steeleye.com>
	 <457F2C1C.1030503@us.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 10:10:40 -0600
Message-Id: <1166026240.2790.27.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 14:24 -0800, Darrick J. Wong wrote:
> I tried out the patch below, but with it applied, SCSI still issues
> REPORT LUNS to the device.  It seems that sdev->type = -1 and bflags = 0

Yes, the inquiry scanning is being called too early ... largely so
BLIST_ROM can work, I suppose.

> when scsi_get_device_flags is called because the type code is not set up
> until scsi_add_lun, which is called later.  In any case, the check
> doesn't work for me because the SATAPI GoVault reports itself as a
> Direct Access device, not a CD-ROM.

Er, if it's really a CD-ROM, doesn't it need a blacklist entry with
BLIST_ROM then?  Regardless, MMC is the only standard that seems to be
inconsistent in this regard.  Anything claiming to conform to SBC will
need to be explicitly blacklisted if it claims SCSI-3 or higher and
doesn't support REPORT LUNS.

Does the attached patch fare better?

James

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 14e635a..92fb26b 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -752,8 +752,15 @@ static int scsi_add_lun(struct scsi_devi
 	case TYPE_RBC:
 		sdev->writeable = 1;
 		break;
-	case TYPE_WORM:
 	case TYPE_ROM:
+		/* MMC devices can return SCSI-3 compliance and yet
+		 * still not support REPORT LUNS, so make them act as
+		 * BLIST_NOREPORTLUN unless BLIST_REPORTLUN2 is
+		 * specifically set */
+		if ((*bflags & BLIST_REPORTLUN2) == 0)
+			*bflags |= BLIST_NOREPORTLUN;
+		/* fall through */
+	case TYPE_WORM:
 		sdev->writeable = 0;
 		break;
 	default:


