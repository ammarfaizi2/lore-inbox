Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVKYFEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVKYFEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 00:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVKYFEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 00:04:16 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:43698 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S1751200AbVKYFEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 00:04:14 -0500
Date: Fri, 25 Nov 2005 06:04:06 +0100
From: Petr Vandrovec <petr@vandrovec.name>
To: gibbs@scsiguy.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH?] aic7xxx crash on data overrun
Message-ID: <20051125050406.GA19258@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Justin,
   I'm not quite sure that this patch is correct thing to do, but
if I do not remove mod_timer() call from ahc_scb_timer_reset then
aic7xxx driver commits suicide on error recovery (at least from
data overrun).  Problem is that  scb->io_ctx->eh_timeout.function 
is NULL at that time and so BUG_ON(!timer->function) in mod_timer 
fires.

   As I was not able to find which function should be invoked in
5 seconds, I just removed this, and it now seems much happier -
it correctly recovers from test.


(scsi5:A:0:0): data overrun detected in Data-in phase.  Tag == 0x3.
(scsi5:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
sd 5:0:0:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0xff 0x0
scsi5: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi5: Dumping Card State in Data-in phase, at SEQADDR 0x16c
...
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
sd 5:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
sd 5:0:0:0: Attempting to queue a TARGET RESET message
CDB: 0x12 0x0 0x0 0x0 0xff 0x0
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes


Without patch kernel got killed after 'Recovery SCB completes'
appeared with BUG at kernel/timer.c:292.

Patch is for 2.6.15-rc2.  Changes in aic7xxx_osm.h are just
cleanup - ahc_timer_reset was not used even before, 
ahc_scb_timer_reset is not used after removing its call from
aic7xxx_core.c
					Thanks,
						Petr Vandrovec


Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

diff -urdN linux/drivers/scsi/aic7xxx/aic7xxx_core.c linux/drivers/scsi/aic7xxx/aic7xxx_core.c
--- linux/drivers/scsi/aic7xxx/aic7xxx_core.c	2005-11-24 07:10:43.000000000 +0100
+++ linux/drivers/scsi/aic7xxx/aic7xxx_core.c	2005-11-24 08:19:46.000000000 +0100
@@ -567,11 +567,6 @@
 			scb->flags |= SCB_SENSE;
 			ahc_qinfifo_requeue_tail(ahc, scb);
 			ahc_outb(ahc, RETURN_1, SEND_SENSE);
-			/*
-			 * Ensure we have enough time to actually
-			 * retrieve the sense.
-			 */
-			ahc_scb_timer_reset(scb, 5 * 1000000);
 			break;
 		}
 		default:
diff -urdN linux/drivers/scsi/aic7xxx/aic7xxx_osm.h linux/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- linux/drivers/scsi/aic7xxx/aic7xxx_osm.h	2005-11-24 07:10:43.000000000 +0100
+++ linux/drivers/scsi/aic7xxx/aic7xxx_osm.h	2005-11-24 08:20:39.000000000 +0100
@@ -234,33 +234,6 @@
 #endif
 #include "aic7xxx.h"
 
-/***************************** Timer Facilities *******************************/
-#define ahc_timer_init init_timer
-#define ahc_timer_stop del_timer_sync
-typedef void ahc_linux_callback_t (u_long);  
-static __inline void ahc_timer_reset(ahc_timer_t *timer, int usec,
-				     ahc_callback_t *func, void *arg);
-static __inline void ahc_scb_timer_reset(struct scb *scb, u_int usec);
-
-static __inline void
-ahc_timer_reset(ahc_timer_t *timer, int usec, ahc_callback_t *func, void *arg)
-{
-	struct ahc_softc *ahc;
-
-	ahc = (struct ahc_softc *)arg;
-	del_timer(timer);
-	timer->data = (u_long)arg;
-	timer->expires = jiffies + (usec * HZ)/1000000;
-	timer->function = (ahc_linux_callback_t*)func;
-	add_timer(timer);
-}
-
-static __inline void
-ahc_scb_timer_reset(struct scb *scb, u_int usec)
-{
-	mod_timer(&scb->io_ctx->eh_timeout, jiffies + (usec * HZ)/1000000);
-}
-
 /***************************** SMP support ************************************/
 #include <linux/spinlock.h>
 
