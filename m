Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266870AbRGTJav>; Fri, 20 Jul 2001 05:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266882AbRGTJal>; Fri, 20 Jul 2001 05:30:41 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:54521 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266870AbRGTJa2>;
	Fri, 20 Jul 2001 05:30:28 -0400
Date: Fri, 20 Jul 2001 11:30:22 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200107200930.LAA25428@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] ide-tape & ksyms fixes for 2.4.7-pre9
Cc: gadio@netvision.net.il, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

The patch below fixes two problems in 2.4.7-pre9:
1. Updates drivers/ide/ide-tape.c for the sem->completion changes.
   (It doesn't compile in -pre9 due to the changes in "struct request".)
2. Updates kernel/ksyms.c to export the new completion object functions.
   Needed for modular drivers.

/Mikael

--- linux-2.4.7-pre9/drivers/ide/ide-tape.c.~1~	Fri Jul 20 09:33:25 2001
+++ linux-2.4.7-pre9/drivers/ide/ide-tape.c	Fri Jul 20 10:15:34 2001
@@ -419,6 +419,7 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 #include <linux/smp_lock.h>
+#include <linux/completion.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -978,7 +979,7 @@
 	int logical_blk_num;			/* logical block number */
 	__u16 wrt_pass_cntr;			/* write pass counter */
 	__u32 update_frame_cntr;		/* update frame counter */
-	struct semaphore *sem;
+	struct completion *waiting;
 	int onstream_write_error;		/* write error recovery active */
 	int header_ok;				/* header frame verified ok */
 	int linux_media;			/* reading linux-specifc media */
@@ -1886,8 +1887,8 @@
 						printk("ide-tape: %s: skipping over config parition..\n", tape->name);
 #endif
 					tape->onstream_write_error = OS_PART_ERROR;
-					if (tape->sem)
-						up(tape->sem);
+					if (tape->waiting)
+						complete(tape->waiting);
 				}
 			}
 			remove_stage = 1;
@@ -1903,8 +1904,8 @@
 					tape->nr_pending_stages++;
 					tape->next_stage = tape->first_stage;
 					rq->current_nr_sectors = rq->nr_sectors;
-					if (tape->sem)
-						up(tape->sem);
+					if (tape->waiting)
+						complete(tape->waiting);
 				}
 			}
 		} else if (rq->cmd == IDETAPE_READ_RQ) {
@@ -3064,15 +3065,15 @@
 }
 
 /*
- *	idetape_wait_for_request installs a semaphore in a pending request
+ *	idetape_wait_for_request installs a completion in a pending request
  *	and sleeps until it is serviced.
  *
  *	The caller should ensure that the request will not be serviced
- *	before we install the semaphore (usually by disabling interrupts).
+ *	before we install the completion (usually by disabling interrupts).
  */
 static void idetape_wait_for_request (ide_drive_t *drive, struct request *rq)
 {
-	DECLARE_MUTEX_LOCKED(sem);
+	DECLARE_COMPLETION(wait);
 	idetape_tape_t *tape = drive->driver_data;
 
 #if IDETAPE_DEBUG_BUGS
@@ -3081,12 +3082,12 @@
 		return;
 	}
 #endif /* IDETAPE_DEBUG_BUGS */
-	rq->sem = &sem;
-	tape->sem = &sem;
+	rq->waiting = &wait;
+	tape->waiting = &wait;
 	spin_unlock(&tape->spinlock);
-	down(&sem);
-	rq->sem = NULL;
-	tape->sem = NULL;
+	wait_for_completion(&wait);
+	rq->waiting = NULL;
+	tape->waiting = NULL;
 	spin_lock_irq(&tape->spinlock);
 }
 
--- linux-2.4.7-pre9/kernel/ksyms.c.~1~	Fri Jul 20 09:33:29 2001
+++ linux-2.4.7-pre9/kernel/ksyms.c	Fri Jul 20 10:54:06 2001
@@ -45,6 +45,7 @@
 #include <linux/fs.h>
 #include <linux/tty.h>
 #include <linux/in6.h>
+#include <linux/completion.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -361,6 +362,10 @@
 EXPORT_SYMBOL(add_wait_queue);
 EXPORT_SYMBOL(add_wait_queue_exclusive);
 EXPORT_SYMBOL(remove_wait_queue);
+
+/* completion handling */
+EXPORT_SYMBOL(wait_for_completion);
+EXPORT_SYMBOL(complete);
 
 /* The notion of irq probe/assignment is foreign to S/390 */
 
