Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263277AbTDCFho>; Thu, 3 Apr 2003 00:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263278AbTDCFho>; Thu, 3 Apr 2003 00:37:44 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:63104 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263277AbTDCFhm>;
	Thu, 3 Apr 2003 00:37:42 -0500
Message-ID: <3E8BCB3A.8080806@colorfullife.com>
Date: Thu, 03 Apr 2003 07:48:42 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
CC: Narayan Desai <desai@mcs.anl.gov>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-bk5 spinlock warnings/errors - Specifically ide-io:109
 spinlock notice
Content-Type: multipart/mixed;
 boundary="------------080701030604020204010409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701030604020204010409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Shawn wrote:

>>List:     linux-kernel
>>Subject:  2.5.66-bk5 spinlock warnings/errors
>From:     Narayan Desai <desai () mcs ! anl ! gov>
>>Date:     2003-04-02 4:01:02
>
>>hda: dma_timer_expiry: dma status == 0x24
>>drivers/ide/ide-io.c:109: spin_lock(drivers/ide/ide.c:c037abe8) already 
>>locked by drivers/ide/ide-io.c/948 drivers/ide/ide-io.c:990: 
>>spin_unlock(drivers/ide/ide.c:c037abe8) not locked
>>hda: lost interrupt
>>hda: dma_intr: bad DMA status (dma_stat=30)
>>hda: dma_intr: status=0x50 { DriveReady SeekComplete }
>
>I had this problem last night while making a huge debian package (tar.bz2 
>stage). It occured once.
>  
>
The attached patch should fix the problem:
the dma_timer_expiry handler calls HWGROUP(drive)->handler in the wrong 
context. Instead of calling ->handler directly, the ->expiry handler 
must inform the caller that ->handler must be called, and then the 
caller must do some setup before calling ->handler.

--
    Manfred

--------------080701030604020204010409
Content-Type: text/plain;
 name="patch-ide-expiry"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ide-expiry"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 66
//  EXTRAVERSION =
--- 2.5/include/linux/ide.h	2003-03-25 17:49:52.000000000 +0100
+++ build-2.5/include/linux/ide.h	2003-03-30 10:04:08.000000000 +0200
@@ -1043,6 +1043,8 @@
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
 typedef ide_startstop_t (ide_post_handler_t)(ide_drive_t *);
 typedef int (ide_expiry_t)(ide_drive_t *);
+#define EXPIRY_ABORT		(0)
+#define EXPIRY_CALLHANDLER	(-1)
 
 typedef struct hwgroup_s {
 		/* irq handler, if active */
--- 2.5/drivers/ide/ide-io.c	2003-03-25 17:49:40.000000000 +0100
+++ build-2.5/drivers/ide/ide-io.c	2003-03-30 10:05:28.000000000 +0200
@@ -973,7 +973,7 @@
 			}
 			if ((expiry = hwgroup->expiry) != NULL) {
 				/* continue */
-				if ((wait = expiry(drive)) != 0) {
+				if ((wait = expiry(drive)) > 0) {
 					/* reset timer */
 					hwgroup->timer.expires  = jiffies + wait;
 					add_timer(&hwgroup->timer);
@@ -998,7 +998,7 @@
 			/* local CPU only,
 			 * as if we were handling an interrupt */
 			local_irq_disable();
-			if (hwgroup->poll_timeout != 0) {
+			if (hwgroup->poll_timeout != 0 || wait == EXPIRY_CALLHANDLER) {
 				startstop = handler(drive);
 			} else if (drive_is_ready(drive)) {
 				if (drive->waiting_for_dma)
--- 2.5/drivers/ide/ide-dma.c	2003-03-25 17:49:40.000000000 +0100
+++ build-2.5/drivers/ide/ide-dma.c	2003-03-30 10:05:54.000000000 +0200
@@ -483,9 +483,9 @@
 		return WAIT_CMD;
 
 	if (dma_stat & 4)	/* Got an Interrupt */
-		HWGROUP(drive)->handler(drive);
+		return EXPIRY_CALLHANDLER;
 
-	return 0;
+	return EXPIRY_ABORT;
 }
 
 /**

--------------080701030604020204010409--

