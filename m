Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTJSJxE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 05:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTJSJxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 05:53:04 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:43222 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261267AbTJSJw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 05:52:58 -0400
Message-ID: <3F925EF7.2070500@colorfullife.com>
Date: Sun, 19 Oct 2003 11:52:55 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH, CFT] remove cli from 3c527
Content-Type: multipart/mixed;
 boundary="------------020002070802070804040606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020002070802070804040606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

attached is a cleanup for the 3c527 driver: cli is gone, the driver must 
be converted to use a spinlock. I wrote it some time ago, but didn't 
send to Linus due to lack of hardware to test.

Anyone around who has the hardware and could make a quick test run? 
Preferable without CONFIG_SMP and with CONFIG_DEBUG_SPINLOCK.

--
    Manfred


--------------020002070802070804040606
Content-Type: text/plain;
 name="patch-3c527"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-3c527"

--- 2.6/drivers/net/3c527.c	2003-06-17 06:20:03.000000000 +0200
+++ build-2.6/drivers/net/3c527.c	2003-08-31 19:26:37.000000000 +0200
@@ -100,6 +100,7 @@
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/ethtool.h>
+#include <linux/spinlock.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -179,6 +180,7 @@
 	u16 tx_ring_head;       /* index to tx en-queue end */
 
 	u16 rx_ring_tail;       /* index to rx de-queue end */ 
+	spinlock_t lock;
 };
 
 /* The station (ethernet) address prefix, used for a sanity check. */
@@ -579,6 +581,27 @@
 	return 0;
 }
 
+/**
+ *	wait_exec_pending - sleep until exec_pending reaches a certain value
+ *	@lp: m32_local structure describing the target card
+ *	@value: value to wait for
+ *
+ *	The caller must acquire lp->lock before calling this function, it
+ *	temporarily drops the lock when it sleeps.
+ */
+
+static void wait_exec_pending(struct mc32_local *lp, int value)
+{
+	while (lp->exec_pending != value) {
+	        DEFINE_WAIT(wait);
+
+	        prepare_to_wait(&lp->event, &wait, TASK_UNINTERRUPTIBLE);
+		spin_unlock_irq(&lp->lock);
+	        schedule();
+	        finish_wait(&lp->event, &wait);
+		spin_lock_irq(&lp->lock);
+	}
+}
 
 /**
  *	mc32_command	-	send a command and sleep until completion
@@ -619,14 +642,11 @@
 	int ret = 0;
 	
 	/*
-	 *	Wait for a command
+	 *	Wait until there are no more pending commands
 	 */
 	 
-	save_flags(flags);
-	cli();
-	 
-	while(lp->exec_pending)
-		sleep_on(&lp->event);
+	spin_lock_irqsave(&lp->lock, flags);
+	wait_exec_pending(lp, 0);
 		
 	/*
 	 *	Issue mine
@@ -634,7 +654,7 @@
 
 	lp->exec_pending=1;
 	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	
 	lp->exec_box->mbox=0;
 	lp->exec_box->mbox=cmd;
@@ -645,13 +665,10 @@
 	while(!(inb(ioaddr+HOST_STATUS)&HOST_STATUS_CRR));
 	outb(1<<6, ioaddr+HOST_CMD);	
 
-	save_flags(flags);
-	cli();
-
-	while(lp->exec_pending!=2)
-		sleep_on(&lp->event);
+	spin_lock_irqsave(&lp->lock, flags);
+	wait_exec_pending(lp, 2);
 	lp->exec_pending=0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	
 	if(lp->exec_box->mbox&(1<<13))
 		ret = -1;

--------------020002070802070804040606--

