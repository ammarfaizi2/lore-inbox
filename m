Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265271AbUFAWlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUFAWlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUFAWkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:40:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265271AbUFAWac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:32 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [1/10]
Date: Wed, 2 Jun 2004 00:16:39 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406020016.39400.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: don't put disks in standby mode on halt on Alpha

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/ide-disk.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff -puN drivers/ide/ide-disk.c~ide_alpha_halt_fix drivers/ide/ide-disk.c
--- linux-2.6.7-rc2-bk2/drivers/ide/ide-disk.c~ide_alpha_halt_fix	2004-06-01 19:02:13.749812168 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/ide-disk.c	2004-06-01 19:02:13.753811560 +0200
@@ -1713,7 +1713,22 @@ static void ide_device_shutdown(struct d
 {
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
 
+#ifdef	CONFIG_ALPHA
+	/* On Alpha, halt(8) doesn't actually turn the machine off,
+	   it puts you into the sort of firmware monitor. Typically,
+	   it's used to boot another kernel image, so it's not much
+	   different from reboot(8). Therefore, we don't need to
+	   spin down the disk in this case, especially since Alpha
+	   firmware doesn't handle disks in standby mode properly.
+	   On the other hand, it's reasonably safe to turn the power
+	   off when the shutdown process reaches the firmware prompt,
+	   as the firmware initialization takes rather long time -
+	   at least 10 seconds, which should be sufficient for
+	   the disk to expire its write cache. */
+	if (system_state != SYSTEM_POWER_OFF) {
+#else
 	if (system_state == SYSTEM_RESTART) {
+#endif
 		ide_cacheflush_p(drive);
 		return;
 	}

_

