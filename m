Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267307AbUBSO62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUBSO6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:58:17 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58340 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267307AbUBSOzz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:55:55 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.3 (4/9)
Date: Thu, 19 Feb 2004 15:57:46 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191557.46764.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] kill default_shutdown() and ide_drive_t->shutdown

 linux-2.6.3-root/drivers/ide/ide.c   |   20 ++------------------
 linux-2.6.3-root/include/linux/ide.h |    1 -
 2 files changed, 2 insertions(+), 19 deletions(-)

diff -puN drivers/ide/ide.c~ide_default_shutdown drivers/ide/ide.c
--- linux-2.6.3/drivers/ide/ide.c~ide_default_shutdown	2004-02-19 02:09:36.564019952 +0100
+++ linux-2.6.3-root/drivers/ide/ide.c	2004-02-19 02:09:36.574018432 +0100
@@ -642,10 +642,9 @@ void ide_unregister (unsigned int index)
 		drive = &hwif->drives[unit];
 		if (!drive->present)
 			continue;
-		if (drive->usage)
-			goto abort;
-		if (DRIVER(drive)->shutdown(drive))
+		if (drive->usage || DRIVER(drive)->busy)
 			goto abort;
+		drive->dead = 1;
 	}
 	hwif->present = 0;
 	
@@ -2170,20 +2169,6 @@ static int default_cleanup (ide_drive_t 
 }
 
 /*
- *	Check if we can unregister the subdriver. Called with the
- *	request lock held.
- */
- 
-static int default_shutdown(ide_drive_t *drive)
-{
-	if (drive->usage || DRIVER(drive)->busy) {
-		return 1;
-	}
-	drive->dead = 1;
-	return 0;
-}
-
-/*
  *	Default function to use for the cache flush operation. This
  *	must be replaced for disk devices (see ATA specification
  *	documents on cache flush and drive suspend rules)
@@ -2259,7 +2244,6 @@ static ide_startstop_t default_start_pow
 static void setup_driver_defaults (ide_driver_t *d)
 {
 	if (d->cleanup == NULL)		d->cleanup = default_cleanup;
-	if (d->shutdown == NULL)	d->shutdown = default_shutdown;
 	if (d->flushcache == NULL)	d->flushcache = default_flushcache;
 	if (d->do_request == NULL)	d->do_request = default_do_request;
 	if (d->end_request == NULL)	d->end_request = default_end_request;
diff -puN include/linux/ide.h~ide_default_shutdown include/linux/ide.h
--- linux-2.6.3/include/linux/ide.h~ide_default_shutdown	2004-02-19 02:09:36.568019344 +0100
+++ linux-2.6.3-root/include/linux/ide.h	2004-02-19 02:09:36.576018128 +0100
@@ -1160,7 +1160,6 @@ typedef struct ide_driver_s {
 	unsigned busy			: 1;
 	unsigned supports_dsc_overlap	: 1;
 	int		(*cleanup)(ide_drive_t *);
-	int		(*shutdown)(ide_drive_t *);
 	int		(*flushcache)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, sector_t);
 	int		(*end_request)(ide_drive_t *, int, int);

_

