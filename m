Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266448AbUA3D0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 22:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266440AbUA3D0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 22:26:35 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:29128 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S266420AbUA3D02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 22:26:28 -0500
Date: Fri, 30 Jan 2004 14:30:41 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Davin McCall <davmac@ozonline.com.au>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] various IDE patches/cleanups
Message-Id: <20040130143041.1eb70817.davmac@ozonline.com.au>
In-Reply-To: <20040130142725.1a408f9e.davmac@ozonline.com.au>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401051516.03364.bzolnier@elka.pw.edu.pl>
	<20040106135155.66535c13.davmac@ozonline.com.au>
	<200401061213.39843.bzolnier@elka.pw.edu.pl>
	<20040130142725.1a408f9e.davmac@ozonline.com.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2nd patch notes
---------------

The function "ide_stall_queue" is used to "give back excess bandwidth" for
a drive. What this means is that some request comes in a drive, and it is
unable to process the request immediately (because the hardware is still
seeking or powering up or somesuch) then, instead of just waiting for the
hardware, we can stall the queue. See drivers/ide/ide-cdrom.c for example.

The intention would seem to be to stall the drive - there doesn't seem to
be any necessity to stall other drives in the same hwgroup (or even on the
same interface). But this is exactly what the current code does.

This patch changes the behaviour to stall only the drive, not the whole
hwgroup.

- (ide-io.c)
  - ide_do_request()
    - Set hwgroup->busy false when sleeping, so that requests on other drives
      can still come in.
    - if no requests can be served (choose_drive returns NULL) and we are
      already sleeping, break out early (after setting ->busy false)
    - if a request is chosen (choose_drive) and ->sleeping is currently set,
      remove the expiry timer and clear ->sleeping.
  - ide_timer_expiry()
    - no need to clear ->busy when the sleep timer expires, as we now sleep
      with ->busy clear.



diff -urN linux-2.6.0-patch1/drivers/ide/ide-io.c linux-2.6.0/drivers/ide/ide-io.c
--- linux-2.6.0-patch1/drivers/ide/ide-io.c	Thu Nov 27 07:45:21 2003
+++ linux-2.6.0/drivers/ide/ide-io.c	Wed Jan 28 22:55:00 2004
@@ -843,6 +843,8 @@
 		drive = choose_drive(hwgroup);
 		if (drive == NULL) {
 			unsigned long sleep = 0;
+			hwgroup->busy = ata_pending_commands(hwgroup->drive);
+			if (hwgroup->sleeping) break;
 			hwgroup->rq = NULL;
 			drive = hwgroup->drive;
 			do {
@@ -865,8 +867,6 @@
 				/* so that ide_timer_expiry knows what to do */
 				hwgroup->sleeping = 1;
 				mod_timer(&hwgroup->timer, sleep);
-				/* we purposely leave hwgroup->busy==1
-				 * while sleeping */
 			} else {
 				/* Ugly, but how can we sleep for the lock
 				 * otherwise? perhaps from tq_disk?
@@ -874,12 +874,20 @@
 
 				/* for atari only */
 				ide_release_lock();
-				hwgroup->busy = 0;
 			}
 
 			/* no more work for this hwgroup (for now) */
 			return;
 		}
+		
+		if (hwgroup->sleeping) {
+			if (!del_timer(&hwgroup->timer)) {
+				hwgroup->busy = 0;
+				break;  /* let the timer handler finish; it will call us again */
+			}
+			hwgroup->sleeping = 0;
+		}
+		
 		hwif = HWIF(drive);
 		if (hwgroup->hwif->sharing_irq &&
 		    hwif != hwgroup->hwif &&
@@ -1060,7 +1068,6 @@
 		 */
 		if (hwgroup->sleeping) {
 			hwgroup->sleeping = 0;
-			hwgroup->busy = 0;
 		}
 	} else {
 		ide_drive_t *drive = hwgroup->drive;
