Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbTHURJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbTHURJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:09:24 -0400
Received: from [203.145.184.221] ([203.145.184.221]:7946 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S262828AbTHURG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:06:58 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: torvalds@osdl.org
Subject: [PATCH-2.6.0-test3-bk8] task queue to work queue conversion - drivers/char/pcxx.c
Date: Thu, 21 Aug 2003 22:40:24 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308212240.24449.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

The patch would convert the task queue
in the pcxx.c to work queue.

The code is tested only for compilation (it produces .o).
[Following your call to make drivers into the state of 
"it must compile" - ref: your riscom patch thread :-)]

The patch is against 2.6.0-test3-bk8.
Please consider it for applying.


Regards
KK

======================================
diffstat output:

pcxx.c |   20 +++-----------------
pcxx.h |    2 +-
2 files changed, 4 insertions(+), 18 deletions(-)

========================================
The following is the patch:

--- linux-2.6.0-test3-bk8/drivers/char/pcxx.orig.c	2003-08-21 20:58:42.000000000 +0530
+++ linux-2.6.0-test3-bk8/drivers/char/pcxx.c	2003-08-21 22:24:40.000000000 +0530
@@ -121,7 +121,7 @@
 MODULE_PARM(altpin,      "1-4i");
 MODULE_PARM(numports,    "1-4i");
 
-#endif MODULE
+#endif /* MODULE */
 
 static int numcards = 1;
 static int nbdevs = 0;
@@ -142,8 +142,6 @@
 
 static struct timer_list pcxx_timer;
 
-DECLARE_TASK_QUEUE(tq_pcxx);
-
 static void pcxxpoll(unsigned long dummy);
 static void fepcmd(struct channel *, int, int, int, int, int);
 static void pcxe_put_char(struct tty_struct *, unsigned char);
@@ -161,7 +159,6 @@
 static void pcxxparam(struct tty_struct *, struct channel *ch);
 static void do_softint(void *);
 static inline void pcxe_sched_event(struct channel *, int);
-static void do_pcxe_bh(void);
 static void pcxe_start(struct tty_struct *);
 static void pcxe_stop(struct tty_struct *);
 static void pcxe_throttle(struct tty_struct *);
@@ -220,7 +217,6 @@
 	save_flags(flags);
 	cli();
 	del_timer_sync(&pcxx_timer);
-	remove_bh(DIGI_BH);
 
 	if ((e1 = tty_unregister_driver(pcxe_driver)))
 		printk("SERIAL: failed to unregister serial driver (%d)\n", e1);
@@ -312,8 +308,7 @@
 static inline void pcxe_sched_event(struct channel *info, int event)
 {
 	info->event |= 1 << event;
-	queue_task(&info->tqueue, &tq_pcxx);
-	mark_bh(DIGI_BH);
+	schedule_work(&info->tqueue);
 }
 
 static void pcxx_error(int line, char *msg)
@@ -1150,7 +1145,6 @@
 	}
 	memset(digi_channels, 0, sizeof(struct channel) * nbdevs);
 
-	init_bh(DIGI_BH,do_pcxe_bh);
 
 	init_timer(&pcxx_timer);
 	pcxx_timer.function = pcxxpoll;
@@ -1450,8 +1444,7 @@
 			}
 			ch->brdchan = bc;
 			ch->mailbox = gd;
-			ch->tqueue.routine = do_softint;
-			ch->tqueue.data = ch;
+			INIT_WORK(&(ch->tqueue), do_softint, ch);
 			ch->board = &boards[crd];
 #ifdef DEFAULT_HW_FLOW
 			ch->digiext.digi_flags = RTSPACE|CTSPACE;
@@ -2253,13 +2246,6 @@
 	}
 }
 
-
-static void do_pcxe_bh(void)
-{
-	run_task_queue(&tq_pcxx);
-}
-
-
 static void do_softint(void *private_)
 {
 	struct channel *info = (struct channel *) private_;
--- linux-2.6.0-test3-bk8/drivers/char/pcxx.orig.h	2003-08-09 10:04:52.000000000 +0530
+++ linux-2.6.0-test3-bk8/drivers/char/pcxx.h	2003-08-21 21:17:34.000000000 +0530
@@ -88,7 +88,7 @@
 	int							event;
 	wait_queue_head_t			open_wait;
 	wait_queue_head_t			close_wait;
-	struct tq_struct			tqueue;
+	struct work_struct      		tqueue;
 							/* ------------ Async control data ------------- */
 	unchar						modemfake;      /* Modem values to be forced */
 	unchar						modem;          /* Force values */


