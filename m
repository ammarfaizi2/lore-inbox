Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbQLQSad>; Sun, 17 Dec 2000 13:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129939AbQLQSaX>; Sun, 17 Dec 2000 13:30:23 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:11427 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129868AbQLQSaO>; Sun, 17 Dec 2000 13:30:14 -0500
Date: Sun, 17 Dec 2000 13:03:40 -0500 (EST)
From: Scott Murray <scott@spiteful.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] making hdx=scsi work with modular SCSI support
Message-ID: <Pine.LNX.4.30.0012171254050.18713-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

While trying to get my CD-R drive working under test11, I discovered that
the hdx=scsi kernel parameter is disabled unless both IDE-SCSI support and
SCSI are compiled in statically.  That definitely wasn't the case in my
configuration and I think it unlikely to be common.  The attached patch
adds in the _MODULE definition checks and it should apply cleanly even in
test13-pre2.  It's not overly pretty, though, so maybe you can come up
with something better.

Scott


--- linux-2.4.0-test11/drivers/ide/ide.c	Mon Oct 16 15:58:51 2000
+++ linux-2.4.0-test11-dev/drivers/ide/ide.c	Wed Dec 13 23:59:37 2000
@@ -2973,13 +2973,13 @@
 				drive->remap_0_to_1 = 2;
 				goto done;
 			case -14: /* "scsi" */
-#if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
+#if (defined(CONFIG_BLK_DEV_IDESCSI) || defined(CONFIG_BLK_DEV_IDESCSI_MODULE)) && (defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE))
 				drive->scsi = 1;
 				goto done;
 #else
 				drive->scsi = 0;
 				goto bad_option;
-#endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
+#endif /* (CONFIG_BLK_DEV_IDESCSI || CONFIG_BLK_DEV_IDESCSI_MODULE) && (CONFIG_SCSI || CONFIG_SCSI_MODULE) */
 			case 3: /* cyl,head,sect */
 				drive->media	= ide_disk;
 				drive->cyl	= drive->bios_cyl  = vals[0];


-- 
=============================================================================
Scott Murray                                        email: scott@spiteful.org
http://www.interlog.com/~scottm                       ICQ: 10602428
-----------------------------------------------------------------------------
     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
