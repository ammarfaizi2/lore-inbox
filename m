Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVIMRj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVIMRj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVIMRj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:39:58 -0400
Received: from wdscexfe01.sc.wdc.com ([129.253.170.53]:60088 "EHLO
	wdscexfe01.sc.wdc.com") by vger.kernel.org with ESMTP
	id S964932AbVIMRj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:39:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.13] scsi: sd fails to copy cmd_len on SG_IO
Date: Tue, 13 Sep 2005 10:39:54 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BDD8@WDSCEXBECL03.sc.wdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [GIT PATCH] scsi merge for 2.6.13
Thread-Index: AcW4DaecPf5ZG9pfRXSlYAuuFi6NLQAeEq3A
From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 13 Sep 2005 17:39:52.0139 (UTC) FILETIME=[255719B0:01C5B88A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an issue when doing SG_IO on an sd device: the
sd driver fails to copy the request's cmd_len to the scsi
command's cmd_len when initializing the command.

Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>

--- linux-2.6.13.orig/drivers/scsi/sd.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/drivers/scsi/sd.c	2005-09-13 09:39:06.000000000 -0700
@@ -236,6 +236,7 @@ static int sd_init_command(struct scsi_c
 			return 0;
 
 		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
+		SCpnt->cmd_len = rq->cmd_len;
 		if (rq_data_dir(rq) == WRITE)
 			SCpnt->sc_data_direction = DMA_TO_DEVICE;
 		else if (rq->data_len)
