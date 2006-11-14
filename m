Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966263AbWKNS3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966263AbWKNS3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966261AbWKNS3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:29:32 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:11679 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S966260AbWKNS3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:29:31 -0500
Message-ID: <455A0B03.1080907@us.ibm.com>
Date: Tue, 14 Nov 2006 10:29:23 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] sas_ata: don't copy aic94xx's sactive to ata_port
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the aic94xx sequencer assigns its own NCQ tags to ATA commands, it
no longer makes any sense to copy the sactive field in the STP response
to ata_port->sactive, as that will confuse libata.  Also, libata seems
to be capable of managing sactive on its own.

The attached patch gets rid of one of the causes of the BUG messages in
ata_qc_new, and should apply against jejb's aic94xx-sas git tree.

--

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index ca49d3e..9580d81 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -108,7 +108,6 @@ static void sas_ata_task_done(struct sas
 		dev->sata_dev.sstatus = resp->sstatus;
 		dev->sata_dev.serror = resp->serror;
 		dev->sata_dev.scontrol = resp->scontrol;
-		dev->sata_dev.ap->sactive = resp->sactive;
 	} else if (stat->stat != SAM_STAT_GOOD) {
 		ac = sas_to_ata_err(stat);
 		if (ac) {
