Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVIIVmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVIIVmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVIIVmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:42:08 -0400
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:23893 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1030377AbVIIVmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:42:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.13] ide: fix null request pointer for taskfile ioctl
Date: Fri, 9 Sep 2005 14:41:49 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BDC7@WDSCEXBECL03.sc.wdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13] ide: ide-dma.c should always check hwif->cds before hwif->cds->foo
Thread-Index: AcW0jtEYVdaUgX+BSCeeU5HhWAALeAA3EfWA
From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       "IDE Mailing List" <linux-ide@vger.kernel.org>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Sep 2005 21:42:06.0507 (UTC) FILETIME=[52D8A7B0:01C5B587]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When doing ioctl HDIO_DRIVE_TASKFILE, the ide_task_t's
request pointer is never set, but flagged_taskfile and
do_rw_taskfile pass it as a parameter to the prehandler.
The kernel will oops taskfile pio-out commands because of this
(taskfile pio-in doesn't use a prehandler).  This fix sets the
request pointer at the time the request is created to stop this
oops.

Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>

--- linux-2.6.13.orig/drivers/ide/ide-taskfile.c	2005-08-28
16:41:01.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide-taskfile.c	2005-09-09
13:47:41.000000000 -0700
@@ -500,6 +500,7 @@ static int ide_diag_taskfile(ide_drive_t
 	}
 
 	rq.special = args;
+	args->rq = &rq;
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
