Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315115AbSENClo>; Mon, 13 May 2002 22:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSENCln>; Mon, 13 May 2002 22:41:43 -0400
Received: from [210.175.4.211] ([210.175.4.211]:56581 "EHLO nagi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S315115AbSENCln>;
	Mon, 13 May 2002 22:41:43 -0400
Message-ID: <3CE0795B.62C956F0@cinet.co.jp>
Date: Tue, 14 May 2002 11:41:31 +0900
From: tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.79C-ja  [ja/Vine] (X11; U; Linux 2.5.15-pc98 i586)
X-Accept-Language: ja
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-venures.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE PIO write Fix #2
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
This patch solves problem (for me)
"kernel stops without message at heavy usage of IDE HDD".
But, "hda: lost interrupt" message appears, instead. 
My BOX has both IDE and SCSI HDD.
This message appears at accessing SCSI HDD by another
task, during IDE heavy accsess.
I guess, IDE driver has "critical section" needing "cli"
(and so on).
Any suggestions ?

--- linux-2.5.15/drivers/ide/ide-taskfile.c.orig	Fri May 10 11:49:35 2002
+++ linux-2.5.15/drivers/ide/ide-taskfile.c	Tue May 14 10:40:43 2002
@@ -606,7 +606,7 @@
 		if (!ide_end_request(drive, rq, 1))
 			return ide_stopped;
 
-	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
+	if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
 		pBuf = ide_map_rq(rq, &flags);
 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
