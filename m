Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbUAEUKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUAEUKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:10:53 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40654 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265905AbUAEUKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:10:51 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Frederik Deweerdt <frederik.deweerdt@laposte.net>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Mon, 5 Jan 2004 21:13:35 +0100
User-Agent: KMail/1.5.4
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401051712.41695.bzolnier@elka.pw.edu.pl> <1073331448.3761.12.camel@silenus.home>
In-Reply-To: <1073331448.3761.12.camel@silenus.home>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401052113.35828.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of January 2004 20:37, Frederik Deweerdt wrote:
> On Mon, 2004-01-05 at 17:12, Bartlomiej Zolnierkiewicz wrote:
> > - hangs during reading /proc/ide/<cdrom>/identify on some drives
> >   (workaround is now known thanks to debugging done by Andi+BenH+Andre)
>
> could you explain about this workaround? i've searched the archives
> without finding anything.

Because it was discovered recently and it is not the proper fix. :-)

 drivers/ide/ide-taskfile.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide-tf-identify-fix drivers/ide/ide-taskfile.c
--- linux-2.6.1-rc1/drivers/ide/ide-taskfile.c~ide-tf-identify-fix	2004-01-04 16:35:53.094766576 +0100
+++ linux-2.6.1-rc1-root/drivers/ide/ide-taskfile.c	2004-01-04 16:45:03.240131768 +0100
@@ -797,9 +797,12 @@ check_status:
 	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
-		/* BUSY_STAT: No data yet, so wait for another IRQ. */
-		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
-		return ide_started;
+		/* Workaround for some ATAPI drives which set only BSY bit. */
+		if (drive->media != ide_cdrom) {
+			/* BUSY_STAT: No data yet, so wait for another IRQ. */
+			ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
+			return ide_started;
+		}
 	}
 
 	/*

_

