Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTIBXCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 19:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTIBXCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 19:02:19 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:15787 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S261300AbTIBXCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 19:02:16 -0400
Message-ID: <3F550E0E.7020502@terra.com.br>
Date: Tue, 02 Sep 2003 18:39:26 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix SMP support on cdu535 cdrom driver
Content-Type: multipart/mixed;
 boundary="------------020400010906020401010505"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020400010906020401010505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	Patch against 2.6-test4.

	I'm not sure this is the right fix, since my knowledge on cdrom 
drivers tends to /dev/zero...but, here we go:

	Replace cli/sti on sony_sleep with wait_queue, using a device 
spinlock to lock 'enable_interrupts' and the queueing stuff.

	Compile fine, but I don't have the hardware.

	Feedback is welcome, since I'm pretty sure I did something wrong.. :)

	Thanks,

Felipe

--------------020400010906020401010505
Content-Type: text/plain;
 name="cdu535-cli_sti_removal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdu535-cli_sti_removal.patch"

--- linux-2.6.0-test4/drivers/cdrom/sonycd535.c	Fri Aug 22 20:54:17 2003
+++ linux-2.6.0-test4-fwd/drivers/cdrom/sonycd535.c	Tue Sep  2 18:24:10 2003
@@ -36,6 +36,10 @@
  *	            module_init & module_exit.
  *                  Torben Mathiasen <tmm@image.dk>
  *
+ * September 2003 - Fix SMP support by removing cli/sti calls.
+ *                  Using spinlocks with a wait_queue instead
+ *                  Felipe Damasio <felipewd@terra.com.br>
+ *
  * Things to do:
  *  - handle errors and status better, put everything into a single word
  *  - use interrupts (code mostly there, but a big hole still missing)
@@ -219,6 +223,9 @@
 static unsigned short data_reg;
 
 static spinlock_t sonycd535_lock = SPIN_LOCK_UNLOCKED; /* queue lock */
+
+static spinlock_t cdu535_lock = SPIN_LOCK_UNLOCKED;  /* Device lock */
+
 static struct request_queue *sonycd535_queue;
 
 static int initialized;			/* Has the drive been initialized? */
@@ -340,10 +347,16 @@
 	if (sony535_irq_used <= 0) {	/* poll */
 		yield();
 	} else {	/* Interrupt driven */
-		cli();
+		DEFINE_WAIT(wait);
+		
+		spin_lock_irq(&cdu535_lock);
 		enable_interrupts();
-		interruptible_sleep_on(&cdu535_irq_wait);
-		sti();
+		prepare_to_wait(&cdu535_irq_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&cdu535_lock);
+		schedule();
+		spin_lock_irq(&cdu535_lock);
+		finish_wait(&cdu535_irq_wait, &wait);
+		spin_unlock_irq(&cdu535_lock);
 	}
 }
 

--------------020400010906020401010505--

