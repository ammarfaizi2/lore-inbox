Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVCMQkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVCMQkL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 11:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVCMQkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 11:40:11 -0500
Received: from coderock.org ([193.77.147.115]:33494 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261358AbVCMQeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 11:34:19 -0500
From: Domen Puncer <domen@coderock.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, emoenke@gwdg.de, linux@rainbow-software.org,
       domen@coderock.org
In-Reply-To: <20050313163330.171476@nd47.coderock.org>
X-Mailer: Domen's patchbomb
Subject: Re: [patch 3/3] cdrom/cdu31a update
Message-Id: <20050313163348.190F91E3E1@trashy.coderock.org>
Date: Sun, 13 Mar 2005 17:33:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use wait_event instead of sleep_on.
Also, remove two unused variables.


Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Ondrej Zary <linux@rainbow-software.org>

--- ./drivers/cdrom/cdu31a.c.orig3	2005-03-06 22:04:42.000000000 +0100
+++ ./drivers/cdrom/cdu31a.c	2005-03-12 14:40:14.000000000 +0100
@@ -264,15 +264,8 @@ static int sony_toc_read = 0;	/* Has the
 static struct s_sony_subcode last_sony_subcode;	/* Points to the last
 						   subcode address read */
 
-static volatile int sony_inuse = 0;	/* Is the drive in use?  Only one operation
-					   at a time allowed */
-
 static DECLARE_MUTEX(sony_sem);		/* Semaphore for drive hardware access */
 
-static struct task_struct *has_cd_task = NULL;	/* The task that is currently
-						   using the CDROM drive, or
-						   NULL if none. */
-
 static int is_double_speed = 0;	/* does the drive support double speed ? */
 
 static int is_auto_eject = 1;	/* Door has been locked? 1=No/0=Yes */
@@ -300,6 +293,7 @@ module_param(cdu31a_irq, int, 0);
 /* The interrupt handler will wake this queue up when it gets an
    interrupts. */
 DECLARE_WAIT_QUEUE_HEAD(cdu31a_irq_wait);
+static int irq_flag = 0;
 
 static int curr_control_reg = 0;	/* Current value of the control register */
 
@@ -376,17 +370,31 @@ static inline void disable_interrupts(vo
  */
 static inline void sony_sleep(void)
 {
-	unsigned long flags;
-
 	if (cdu31a_irq <= 0) {
 		yield();
 	} else {		/* Interrupt driven */
+		DEFINE_WAIT(w);
+		int first = 1;
+
+		while (1) {
+			prepare_to_wait(&cdu31a_irq_wait, &w,
+					TASK_INTERRUPTIBLE);
+			if (first) {
+				enable_interrupts();
+				first = 0;
+			}
 
-		save_flags(flags);
-		cli();
-		enable_interrupts();
-		interruptible_sleep_on(&cdu31a_irq_wait);
-		restore_flags(flags);
+			if (irq_flag != 0)
+				break;
+			if (!signal_pending(current)) {
+				schedule();
+				continue;
+			} else
+				disable_interrupts();
+			break;
+		}
+		finish_wait(&cdu31a_irq_wait, &w);
+		irq_flag = 0;
 	}
 }
 
@@ -530,11 +538,13 @@ static irqreturn_t cdu31a_interrupt(int 
 		/* If something was waiting, wake it up now. */
 		if (waitqueue_active(&cdu31a_irq_wait)) {
 			disable_interrupts();
-			wake_up(&cdu31a_irq_wait);
+			irq_flag = 1;
+			wake_up_interruptible(&cdu31a_irq_wait);
 		}
 	} else if (waitqueue_active(&cdu31a_irq_wait)) {
 		disable_interrupts();
-		wake_up(&cdu31a_irq_wait);
+		irq_flag = 1;
+		wake_up_interruptible(&cdu31a_irq_wait);
 	} else {
 		disable_interrupts();
 		printk(KERN_NOTICE PFX
