Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261951AbTCLV6a>; Wed, 12 Mar 2003 16:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbTCLV63>; Wed, 12 Mar 2003 16:58:29 -0500
Received: from zzlzl.varnainter.net ([212.50.18.233]:13828 "EHLO
	zzlzl.varnainter.net") by vger.kernel.org with ESMTP
	id <S261951AbTCLV62>; Wed, 12 Mar 2003 16:58:28 -0500
Date: Wed, 12 Mar 2003 23:30:34 +0200 (EET)
From: Alexander Atanasov <alex@ssi.bg>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] don't ignore chipset specific sector size (Was Re: bio too
 big device)
In-Reply-To: <3E6F7A49.50709@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0303122246500.11644-100000@mars.zaxl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

On Wed, 12 Mar 2003, Manfred Spraul wrote:

> linux/drivers/ide/ide-probe.c:
> 
> >#ifdef CONFIG_BLK_DEV_PDC4030
> >	max_sectors = 127;
> >#else
> >	max_sectors = 255;
> >#endif
> >	blk_queue_max_sectors(q, max_sectors);
> >
> >  
> >
> IDE uses 127 sector requests if support for PDC4030 is compiled it, 
> otherwise 255. It seems someone started with a blacklist, but never 
> completed it.

	There is something wrong with this.

2.4.20-pre5-ac1 for example does:
*max_sect++ = ((hwif->rqsize) ? hwif->rqsize : 128);
(hmm why 128?)

PDC4030 (127 sectors) and siimage (128 or 16) are setting own sector size,
so this may be related to 
http://bugzilla.kernel.org/show_bug.cgi?id=123.

Not tested patch (sorry, no hardware) agains 2.5.64-ac3 (applies to 2.5.64
too).

-- 
have fun,
alex

===== drivers/ide/ide-probe.c 1.33 vs edited =====
--- 1.33/drivers/ide/ide-probe.c	Sat Mar  8 01:45:31 2003
+++ edited/drivers/ide/ide-probe.c	Wed Mar 12 23:12:35 2003
@@ -995,18 +995,15 @@
 static void ide_init_queue(ide_drive_t *drive)
 {
 	request_queue_t *q = &drive->queue;
-	int max_sectors;
+	int max_sectors = 255;
 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request, &ide_lock);
 	drive->queue_setup = 1;
 	blk_queue_segment_boundary(q, 0xffff);
 
-#ifdef CONFIG_BLK_DEV_PDC4030
-	max_sectors = 127;
-#else
-	max_sectors = 255;
-#endif
+	if (HWIF(drive)->rqsize)
+		max_sectors = HWIF(drive)->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
 
 	/* IDE DMA can do PRD_ENTRIES number of segments. */

