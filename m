Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVINAD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVINAD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 20:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVINAD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 20:03:27 -0400
Received: from wdscexfe01.sc.wdc.com ([129.253.170.53]:4787 "EHLO
	wdscexfe01.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1751182AbVINAD0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 20:03:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH 2.6.14-rc1] scsi: sd, sr, st, and scsi_lib all fail to copy cmd_len to new cmd
Date: Tue, 13 Sep 2005 17:03:27 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BDE2@WDSCEXBECL03.sc.wdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.14-rc1] scsi: sd, sr, st, and scsi_lib all fail to copy cmd_len to new cmd
Thread-Index: AcW4v7oRdreQAaYMTVCvuZCzLZPHIw==
From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 14 Sep 2005 00:03:22.0357 (UTC) FILETIME=[B87FBA50:01C5B8BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an issue in scsi command initialization from a request
where sd, sr, st, and scsi_lib all fail to copy the request's
cmd_len to the scsi command's cmd_len field.

Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>

diff -pu linux-2.6.14-rc1.orig/drivers/scsi/scsi_lib.c
linux-2.6.14-rc1/drivers/scsi/scsi_lib.c
--- linux-2.6.14-rc1.orig/drivers/scsi/scsi_lib.c	2005-09-12
20:12:09.000000000 -0700
+++ linux-2.6.14-rc1/drivers/scsi/scsi_lib.c	2005-09-13
16:28:58.000000000 -0700
@@ -1268,6 +1268,7 @@ static int scsi_prep_fn(struct request_q
 			}
 		} else {
 			memcpy(cmd->cmnd, req->cmd, sizeof(cmd->cmnd));
+			cmd->cmd_len = req->cmd_len;
 			if (rq_data_dir(req) == WRITE)
 				cmd->sc_data_direction = DMA_TO_DEVICE;
 			else if (req->data_len)
diff -pu linux-2.6.14-rc1.orig/drivers/scsi/sd.c
linux-2.6.14-rc1/drivers/scsi/sd.c
--- linux-2.6.14-rc1.orig/drivers/scsi/sd.c	2005-09-12
20:12:09.000000000 -0700
+++ linux-2.6.14-rc1/drivers/scsi/sd.c	2005-09-13 16:03:20.000000000 -0700
@@ -235,6 +235,7 @@ static int sd_init_command(struct scsi_c
 			return 0;
 
 		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
+		SCpnt->cmd_len = rq->cmd_len;
 		if (rq_data_dir(rq) == WRITE)
 			SCpnt->sc_data_direction = DMA_TO_DEVICE;
 		else if (rq->data_len)
diff -pu linux-2.6.14-rc1.orig/drivers/scsi/sr.c
linux-2.6.14-rc1/drivers/scsi/sr.c
--- linux-2.6.14-rc1.orig/drivers/scsi/sr.c	2005-09-12
20:12:09.000000000 -0700
+++ linux-2.6.14-rc1/drivers/scsi/sr.c	2005-09-13 16:05:47.000000000 -0700
@@ -326,6 +326,7 @@ static int sr_init_command(struct scsi_c
 			return 0;
 
 		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
+		SCpnt->cmd_len = rq->cmd_len;
 		if (!rq->data_len)
 			SCpnt->sc_data_direction = DMA_NONE;
 		else if (rq_data_dir(rq) == WRITE)
diff -pu linux-2.6.14-rc1.orig/drivers/scsi/st.c
linux-2.6.14-rc1/drivers/scsi/st.c
--- linux-2.6.14-rc1.orig/drivers/scsi/st.c	2005-09-12
20:12:09.000000000 -0700
+++ linux-2.6.14-rc1/drivers/scsi/st.c	2005-09-13 16:04:10.000000000 -0700
@@ -4206,6 +4206,7 @@ static int st_init_command(struct scsi_c
 		return 0;
 
 	memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
+	SCpnt->cmd_len = rq->cmd_len;
 
 	if (rq_data_dir(rq) == WRITE)
 		SCpnt->sc_data_direction = DMA_TO_DEVICE;
