Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFDEbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFDEbY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 00:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVFDEbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 00:31:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:23233 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261229AbVFDEbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 00:31:04 -0400
Message-ID: <42A12E80.8090203@pobox.com>
Date: Sat, 04 Jun 2005 00:30:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] libata: shelved ioctl-get-identity patch
Content-Type: multipart/mixed;
 boundary="------------000006050000020502060705"
X-Spam-Score: 0.5 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  I am removing the attached patch from libata-dev.git,
	as it does not justify the maintenance burden at the present time. The
	reasons it sat in libata-dev rather than go upstream are discussed at
	the top of the patch. [...] 
	Content analysis details:   (0.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006050000020502060705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


I am removing the attached patch from libata-dev.git, as it does not 
justify the maintenance burden at the present time.  The reasons it sat 
in libata-dev rather than go upstream are discussed at the top of the patch.

If anyone feels strongly about this ioctl, take it upon yourself to 
research the patch fully, address the concerns, and present an updated 
solution.

The patch will be archived forever at
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/archive/2.6.12-rc5-git8-ioctl-get-identity.patch.bz2



--------------000006050000020502060705
Content-Type: text/x-patch;
 name="2.6.12-rc5-git8-ioctl-get-identity.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.12-rc5-git8-ioctl-get-identity.patch"


For inclusion,

a) should determine if need for ioctl justifies maintenance

b) should address Bart Z's concerns:
* it is not complete HDIO_GET_IDENTIFY implementation
  (applications may assume otherwise)
* you may need to add byte-swapping of the fields in the future
  (currently it is fine)
* same info is available via pass-thru inteface




 drivers/scsi/libata-scsi.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)


commit fcf604172829176bc618663e8387c8943ff88b66
tree b10326c351daf26f34ce43b6a37369b30bb434c2
parent 89fb1c9e5e5345ea5531d6378912a5896923e914
parent 8be3de3fd8469154a2b3e18a4712032dac5b4a53
author <jgarzik@pretzel.yyz.us> Sat, 04 Jun 2005 08:02:29 -0400
committer Jeff Garzik <jgarzik@pobox.com> Sat, 04 Jun 2005 08:02:29 -0400

Automatic merge of /spare/repo/linux-2.6/.git branch HEAD

--------------------------
commit 89fb1c9e5e5345ea5531d6378912a5896923e914
tree 48fd7c6d1f9bba8936fc3e1208465c854c77834c
parent 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
author Tobias Lorenz <tobias.lorenz@gmx.net> Thu, 12 May 2005 23:10:33 -0400
committer Jeff Garzik <jgarzik@pobox.com> Thu, 12 May 2005 23:10:33 -0400

[PATCH] libata-scsi: get-identity ioctl support

This patch adds support for transfering drive informations via the
hd_driveid structure to the hdparm utility. At the moment, only
cylinders, sectors, heads, model and firmware version are transfered.

Signed-off-by: Tobias Lorenz <tobias.lorenz@gmx.net>
Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

--------------------------



diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -72,6 +72,17 @@ int ata_scsi_ioctl(struct scsi_device *s
 	struct ata_port *ap;
 	struct ata_device *dev;
 	int val = -EINVAL, rc = -EINVAL;
+	struct hd_driveid drv_id = {
+		.cyls		= 0,
+		.sectors	= 0,
+		.heads		= 0,
+		.fw_rev		= "",
+		.model		= "",
+		.cur_cyls	= 0,
+		.cur_heads	= 0,
+		.cur_sectors	= 0,
+	};
+	int geom[3];
 
 	ap = (struct ata_port *) &scsidev->host->hostdata[0];
 	if (!ap)
@@ -96,6 +107,17 @@ int ata_scsi_ioctl(struct scsi_device *s
 			return -EINVAL;
 		return 0;
 
+	case HDIO_GET_IDENTITY:
+		ata_std_bios_param(scsidev, NULL, dev->n_sectors, geom);
+		drv_id.cur_heads	= drv_id.heads		= geom[0];
+		drv_id.cur_sectors	= drv_id.sectors	= geom[1];
+		drv_id.cur_cyls		= drv_id.cyls		= geom[2];
+		strncpy((char *) &drv_id.model, scsidev->model, sizeof(drv_id.model));
+		strncpy((char *) &drv_id.fw_rev, scsidev->rev, sizeof(drv_id.fw_rev));
+		if(copy_to_user((char *) arg, (char *) &drv_id, sizeof(drv_id)))
+			return(-EFAULT);
+		return 0;
+
 	default:
 		rc = -ENOTTY;
 		break;

--------------000006050000020502060705--
