Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287908AbSBDT5w>; Mon, 4 Feb 2002 14:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287895AbSBDT5j>; Mon, 4 Feb 2002 14:57:39 -0500
Received: from air-2.osdl.org ([65.201.151.6]:35968 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S287863AbSBDT5S>;
	Mon, 4 Feb 2002 14:57:18 -0500
Date: Mon, 4 Feb 2002 11:57:16 -0800
From: Bob Miller <rem@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.3 Can't use spin_lock_* with wait_queue_head_t object.
Message-ID: <20020204115716.B12734@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] 2.5.3 Can't use spin_lock_* with wait_queue_head_t object.

There is code in sched.c that uses the spin_lock_* interfaces to acquire and
release the lock in the wait_queue_head_t embedded in the struct completion.

This is wrong and causes the system to OPPs on startup when compiled with
wait.h:USE_RW_WAIT_QUEUE_SPINLOCK set to 1.  The patch below changes the
spin_lock_* calls to wq_write_lock_*.


-- 
Bob Miller					Email: rem@osdl.org
Open Software Development Lab			Phone: 503.626.2455 Ext. 17


diff -ru linux.2.5.3-orig/include/linux/wait.h linux.2.5.3/include/linux/wait.h
--- linux.2.5.3-orig/include/linux/wait.h	Mon Feb  4 11:23:12 2002
+++ linux.2.5.3/include/linux/wait.h	Mon Feb  4 11:00:14 2002
@@ -45,6 +45,7 @@
 # define wq_read_unlock read_unlock
 # define wq_write_lock_irq write_lock_irq
 # define wq_write_lock_irqsave write_lock_irqsave
+# define wq_write_unlock_irq write_unlock_irq
 # define wq_write_unlock_irqrestore write_unlock_irqrestore
 # define wq_write_unlock write_unlock
 #else
@@ -57,6 +58,7 @@
 # define wq_read_unlock_irqrestore spin_unlock_irqrestore
 # define wq_write_lock_irq spin_lock_irq
 # define wq_write_lock_irqsave spin_lock_irqsave
+# define wq_write_unlock_irq spin_unlock_irq
 # define wq_write_unlock_irqrestore spin_unlock_irqrestore
 # define wq_write_unlock spin_unlock
 #endif
Only in linux.2.5.3-orig/include/linux: wait.h.orig
diff -ru linux.2.5.3-orig/kernel/sched.c linux.2.5.3/kernel/sched.c
--- linux.2.5.3-orig/kernel/sched.c	Mon Jan 28 15:12:47 2002
+++ linux.2.5.3/kernel/sched.c	Mon Feb  4 10:42:05 2002
@@ -757,15 +757,15 @@
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	wq_write_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
 	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, 0);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	wq_write_unlock_irqrestore(&x->wait.lock, flags);
 }
 
 void wait_for_completion(struct completion *x)
 {
-	spin_lock_irq(&x->wait.lock);
+	wq_write_lock_irq(&x->wait.lock);
 	if (!x->done) {
 		DECLARE_WAITQUEUE(wait, current);
 
@@ -773,14 +773,14 @@
 		__add_wait_queue_tail(&x->wait, &wait);
 		do {
 			__set_current_state(TASK_UNINTERRUPTIBLE);
-			spin_unlock_irq(&x->wait.lock);
+			wq_write_unlock_irq(&x->wait.lock);
 			schedule();
-			spin_lock_irq(&x->wait.lock);
+			wq_write_lock_irq(&x->wait.lock);
 		} while (!x->done);
 		__remove_wait_queue(&x->wait, &wait);
 	}
 	x->done--;
-	spin_unlock_irq(&x->wait.lock);
+	wq_write_unlock_irq(&x->wait.lock);
 }
 
 #define	SLEEP_ON_VAR				\
