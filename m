Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbTHaRbw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTHaRbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:31:51 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:35244 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262472AbTHaRbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:31:03 -0400
Message-ID: <3F5230CD.5030908@colorfullife.com>
Date: Sun, 31 Aug 2003 19:30:53 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
CC: linux-kernel@vger.kernel.org, rnp@netlink.co.nz
Subject: Re: [PATCH] Fix SMP support on 3c527 net driver
References: <3F51B1A3.4080307@colorfullife.com> <3F522756.9000105@terra.com.br>
In-Reply-To: <3F522756.9000105@terra.com.br>
Content-Type: multipart/mixed;
 boundary="------------060008050204020302010009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008050204020302010009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Felipe W Damasio wrote:

>     Hi Manfred,
>
> Manfred Spraul wrote:
>
>> Additionally, you must replace the sleep_on calls with wait_event, or 
>> an open-coded wait queue: sleep_on is racy, it only works with cli().
>
>
>     Oh, I didn't no that..
>
>> IMHO the right way to fix cli() is
>> - add a single spinlock to the driver or the device structure. Do not 
>> forget the spin_lock_init().
>> - replace cli/sti with spin_lock_irqsave/spin_unlock_irqsave.
>
>
>     Yes.
>
>> - Additionally acquire the spinlock in every interrupt handler (cli() 
>> stops all interrupts, spinlocks only stop interrupt on the current cpu).
>> - check if there were recursive cli() calls. Fix them.
>> - replace all sleep_on calls with wait queue calls.
>> - check if there are any kmalloc or schedule calls in the area now 
>> under the spinlock, and reorganize the code.
>
>
>     But doesn't wait_queue call schedule()?

Yes, it does. You need a larger change to fix that. Something like the 
attached patch.

--
    Manfred

--------------060008050204020302010009
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

--------------060008050204020302010009--

