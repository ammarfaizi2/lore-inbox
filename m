Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWHASG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWHASG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWHASG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:06:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41374 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750980AbWHASG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:06:59 -0400
Date: Tue, 1 Aug 2006 14:06:43 -0400
From: Dave Jones <davej@redhat.com>
To: arjan@infradead.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: deprecate and convert some sleep_on variants.
Message-ID: <20060801180643.GD22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, arjan@infradead.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been carrying this for a dogs age in Fedora. It'd be good to get
this in -mm, so that it stands some chance of getting upstreamed at some point.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Dave Jones <davej@redhat.com>

diff -urNp --exclude-from=/home/davej/.exclude linux-1060/drivers/block/DAC960.c linux-1070/drivers/block/DAC960.c
--- linux-1060/drivers/block/DAC960.c
+++ linux-1070/drivers/block/DAC960.c
@@ -6132,6 +6132,9 @@ static boolean DAC960_V2_ExecuteUserComm
   unsigned long flags;
   unsigned char Channel, TargetID, LogicalDriveNumber;
   unsigned short LogicalDeviceNumber;
+  wait_queue_t __wait;
+  
+  init_waitqueue_entry(&__wait, current);
 
   spin_lock_irqsave(&Controller->queue_lock, flags);
   while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
@@ -6314,11 +6317,18 @@ static boolean DAC960_V2_ExecuteUserComm
 					.SegmentByteCount =
 	    CommandMailbox->ControllerInfo.DataTransferSize;
 	  DAC960_ExecuteCommand(Command);
+	  add_wait_queue(&Controller->CommandWaitQueue, &__wait);
+	  set_current_state(TASK_UNINTERRUPTIBLE);
+	  
 	  while (Controller->V2.NewControllerInformation->PhysicalScanActive)
 	    {
 	      DAC960_ExecuteCommand(Command);
-	      sleep_on_timeout(&Controller->CommandWaitQueue, HZ);
+	      schedule_timeout(HZ);
+	      set_current_state(TASK_UNINTERRUPTIBLE);
 	    }
+	  current->state = TASK_RUNNING;
+	  remove_wait_queue(&Controller->CommandWaitQueue, &__wait);
+	   
 	  DAC960_UserCritical("Discovery Completed\n", Controller);
  	}
     }
diff -urNp --exclude-from=/home/davej/.exclude linux-1060/drivers/net/tokenring/ibmtr.c linux-1070/drivers/net/tokenring/ibmtr.c
--- linux-1060/drivers/net/tokenring/ibmtr.c
+++ linux-1070/drivers/net/tokenring/ibmtr.c
@@ -850,6 +850,8 @@ static int tok_init_card(struct net_devi
 	struct tok_info *ti;
 	short PIOaddr;
 	unsigned long i;
+	wait_queue_t __wait;
+	init_waitqueue_entry(&__wait, current);
 
 	PIOaddr = dev->base_addr;
 	ti = (struct tok_info *) dev->priv;
@@ -862,13 +864,18 @@ static int tok_init_card(struct net_devi
 	current->state=TASK_UNINTERRUPTIBLE;
 	schedule_timeout(TR_RST_TIME); /* wait 50ms */
 
+	add_wait_queue(&ti->wait_for_reset, &__wait);
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	outb(0, PIOaddr + ADAPTRESETREL);
 #ifdef ENABLE_PAGING
 	if (ti->page_mask)
 		writeb(SRPR_ENABLE_PAGING,ti->mmio+ACA_OFFSET+ACA_RW+SRPR_EVEN);
 #endif
 	writeb(INT_ENABLE, ti->mmio + ACA_OFFSET + ACA_SET + ISRP_EVEN);
-	i = sleep_on_timeout(&ti->wait_for_reset, 4 * HZ);
+	#warning pci posting bug
+	i = schedule_timeout(4 * HZ);
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&ti->wait_for_reset, &__wait);
 	return i? 0 : -EAGAIN;
 }
 
diff -urNp --exclude-from=/home/davej/.exclude linux-1060/include/linux/wait.h linux-1070/include/linux/wait.h
--- linux-1060/include/linux/wait.h
+++ linux-1070/include/linux/wait.h
@@ -364,10 +364,10 @@ static inline void remove_wait_queue_loc
  * They are racy.  DO NOT use them, use the wait_event* interfaces above.  
  * We plan to remove these interfaces during 2.7.
  */
-extern void FASTCALL(sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
+extern void __deprecated FASTCALL(sleep_on(wait_queue_head_t *q));
+extern long __deprecated FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
-extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
+extern void __deprecated FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
 						    signed long timeout));
 
diff -urNp --exclude-from=/home/davej/.exclude linux-1060/kernel/sched.c linux-1070/kernel/sched.c
--- linux-1060/kernel/sched.c
+++ linux-1070/kernel/sched.c
@@ -3118,10 +3118,21 @@ EXPORT_SYMBOL(wait_for_completion_interr
 	__remove_wait_queue(q, &wait);			\
 	spin_unlock_irqrestore(&q->lock, flags);
 
+#define SLEEP_ON_BKLCHECK				\
+	if (unlikely(!kernel_locked()) &&		\
+	    sleep_on_bkl_warnings < 10) {		\
+		sleep_on_bkl_warnings++;		\
+		WARN_ON(1);				\
+	}
+
+static int sleep_on_bkl_warnings;
+
 void fastcall __sched interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
+	SLEEP_ON_BKLCHECK
+
 	current->state = TASK_INTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
@@ -3135,6 +3146,8 @@ long fastcall __sched interruptible_slee
 {
 	SLEEP_ON_VAR
 
+	SLEEP_ON_BKLCHECK
+
 	current->state = TASK_INTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
@@ -3759,22 +3759,12 @@ interruptible_sleep_on_timeout(wait_queu
 }
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 
-void fastcall __sched sleep_on(wait_queue_head_t *q)
-{
-	SLEEP_ON_VAR
-
-	current->state = TASK_UNINTERRUPTIBLE;
-
-	SLEEP_ON_HEAD
-	schedule();
-	SLEEP_ON_TAIL
-}
-EXPORT_SYMBOL(sleep_on);
-
 long fastcall __sched sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
+	SLEEP_ON_BKLCHECK
+
 	current->state = TASK_UNINTERRUPTIBLE;
 
 	SLEEP_ON_HEAD

-- 
http://www.codemonkey.org.uk
