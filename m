Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313583AbSDHIHQ>; Mon, 8 Apr 2002 04:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313584AbSDHIHP>; Mon, 8 Apr 2002 04:07:15 -0400
Received: from stingr.net ([212.193.32.15]:39560 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313583AbSDHIHF>;
	Mon, 8 Apr 2002 04:07:05 -0400
Date: Mon, 8 Apr 2002 12:06:52 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 9
Message-ID: <20020408080652.GP839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	William Lee Irwin III <wli@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2Marcelo: the whole cleanup tree derived from yours available at
linux-stingr.bkbits.net/taskstate

2others: people says that it is nice patch, howewer it is completely
untested. But I dunno what can be broken such way so ...

This is task->state cleanup. Big part seems to be eaten my Matti Aarnio so
splitted goes below.

If you want to blame me for incorrect using of set instead of __set - feel
free to mail me and point where I should to change. Or mail me a patch.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.318   -> 1.319  
#	drivers/s390/net/ctctty.c	1.3     -> 1.4    
#	drivers/s390/char/tubfs.c	1.3     -> 1.4    
#	drivers/s390/char/con3215.c	1.5     -> 1.6    
#	drivers/sbus/char/aurora.c	1.13    -> 1.14   
#	drivers/sbus/char/envctrl.c	1.7     -> 1.8    
#	drivers/sbus/char/su.c	1.12    -> 1.13   
#	drivers/sbus/char/bbc_i2c.c	1.1     -> 1.2    
#	 drivers/pcmcia/cs.c	1.10    -> 1.11   
#	   drivers/pci/pci.c	1.27    -> 1.28   
#	drivers/sbus/char/sab82532.c	1.10    -> 1.11   
#	drivers/sbus/char/bbc_envctrl.c	1.1     -> 1.2    
#	drivers/s390/char/tubttysiz.c	1.2     -> 1.3    
#	drivers/sbus/char/sunmouse.c	1.2     -> 1.3    
#	drivers/sbus/char/pcikbd.c	1.10    -> 1.11   
#	drivers/sbus/char/sunkbd.c	1.4     -> 1.5    
#	 drivers/pcmcia/ds.c	1.7     -> 1.8    
#	drivers/s390/char/tubtty.c	1.4     -> 1.5    
#	drivers/sbus/char/zs.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.319
# task->state cleanup part 9
# --------------------------------------------
#
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/pci/pci.c	Mon Apr  8 01:23:55 2002
@@ -1919,13 +1919,13 @@
 		if (mem_flags == SLAB_KERNEL) {
 			DECLARE_WAITQUEUE (wait, current);
 
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			add_wait_queue (&pool->waitq, &wait);
 			spin_unlock_irqrestore (&pool->lock, flags);
 
 			schedule_timeout (POOL_TIMEOUT_JIFFIES);
 
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			remove_wait_queue (&pool->waitq, &wait);
 			goto restart;
 		}
diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/pcmcia/cs.c	Mon Apr  8 01:23:55 2002
@@ -450,7 +450,7 @@
  */
 static void cs_sleep(unsigned int n_cs)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout( (n_cs * HZ + 99) / 100);
 }
 
diff -Nru a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
--- a/drivers/pcmcia/ds.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/pcmcia/ds.c	Mon Apr  8 01:23:55 2002
@@ -896,7 +896,7 @@
      * Ugly. But we want to wait for the socket threads to have started up.
      * We really should let the drivers themselves drive some of this..
      */
-    current->state = TASK_INTERRUPTIBLE;
+    set_current_state(TASK_INTERRUPTIBLE);
     schedule_timeout(HZ/10);
 
     pcmcia_get_card_services_info(&serv);
diff -Nru a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
--- a/drivers/s390/char/con3215.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/s390/char/con3215.c	Mon Apr  8 01:23:55 2002
@@ -730,12 +730,12 @@
 	    raw->queued_read != NULL) {
 		raw->flags |= RAW3215_CLOSING;
 		add_wait_queue(&raw->empty_wait, &wait);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
                 s390irq_spin_unlock_irqrestore(raw->irq, flags);
 		schedule();
 		s390irq_spin_lock_irqsave(raw->irq, flags);
 		remove_wait_queue(&raw->empty_wait, &wait);
-                current->state = TASK_RUNNING;
+                set_current_state(TASK_RUNNING);
 		raw->flags &= ~(RAW3215_ACTIVE | RAW3215_CLOSING);
 	}
 	free_irq(raw->irq, NULL);
diff -Nru a/drivers/s390/char/tubfs.c b/drivers/s390/char/tubfs.c
--- a/drivers/s390/char/tubfs.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/s390/char/tubfs.c	Mon Apr  8 01:23:55 2002
@@ -208,10 +208,10 @@
 	while (!signal_pending(current) &&
 	    ((tubp->mode != TBM_FS) ||
 	     (tubp->flags & (TUB_WORKING | TUB_RDPENDING)) != 0)) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		TUBUNLOCK(tubp->irq, *flags);
 		schedule();
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		TUBLOCK(tubp->irq, *flags);
 	}
 	remove_wait_queue(&tubp->waitq, &wait);
diff -Nru a/drivers/s390/char/tubtty.c b/drivers/s390/char/tubtty.c
--- a/drivers/s390/char/tubtty.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/s390/char/tubtty.c	Mon Apr  8 01:23:55 2002
@@ -691,10 +691,10 @@
 	add_wait_queue(&tubp->waitq, &wait);
 	while (!signal_pending(current) &&
 	    (tubp->flags & TUB_WORKING) != 0) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		TUBUNLOCK(tubp->irq, *flags);
 		schedule();
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		TUBLOCK(tubp->irq, *flags);
 	}
 	remove_wait_queue(&tubp->waitq, &wait);
diff -Nru a/drivers/s390/char/tubttysiz.c b/drivers/s390/char/tubttysiz.c
--- a/drivers/s390/char/tubttysiz.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/s390/char/tubttysiz.c	Mon Apr  8 01:23:55 2002
@@ -293,10 +293,10 @@
 	while (!signal_pending(current) &&
 	    (stat? (tubp->dstat & stat) == 0:
 	     (tubp->flags & TUB_WORKING) != 0)) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		TUBUNLOCK(tubp->irq, *flags);
 		schedule();
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		TUBLOCK(tubp->irq, *flags);
 	}
 	remove_wait_queue(&tubp->waitq, &wait);
diff -Nru a/drivers/s390/net/ctctty.c b/drivers/s390/net/ctctty.c
--- a/drivers/s390/net/ctctty.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/s390/net/ctctty.c	Mon Apr  8 01:23:55 2002
@@ -974,7 +974,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;
diff -Nru a/drivers/sbus/char/aurora.c b/drivers/sbus/char/aurora.c
--- a/drivers/sbus/char/aurora.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/aurora.c	Mon Apr  8 01:23:55 2002
@@ -1401,7 +1401,7 @@
 		}
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		port->count++;
@@ -1561,7 +1561,7 @@
 		 */
 		timeout = jiffies+HZ;
 		while(port->SRER & SRER_TXEMPTY)  {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(port->timeout);
 			if (time_after(jiffies, timeout))
 				break;
@@ -1580,7 +1580,7 @@
 	port->tty = 0;
 	if (port->blocked_open) {
 		if (port->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(port->close_delay);
 		}
 		wake_up_interruptible(&port->open_wait);
diff -Nru a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctrl.c
--- a/drivers/sbus/char/bbc_envctrl.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/bbc_envctrl.c	Mon Apr  8 01:23:55 2002
@@ -467,9 +467,9 @@
 		struct bbc_cpu_temperature *tp;
 		struct bbc_fan_control *fp;
 
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(POLL_INTERVAL);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		if (signal_pending(current))
 			break;
 
@@ -621,9 +621,9 @@
 			read_unlock(&tasklist_lock);
 			if (!found)
 				break;
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 		}
 		kenvctrld_task = NULL;
 	}
diff -Nru a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
--- a/drivers/sbus/char/bbc_i2c.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/bbc_i2c.c	Mon Apr  8 01:23:55 2002
@@ -188,7 +188,7 @@
 	while (limit-- > 0) {
 		u8 val;
 
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		*status = val = readb(bp->i2c_control_regs + 0);
 		if ((val & I2C_PCF_PIN) == 0) {
 			ret = 0;
@@ -198,7 +198,7 @@
 	}
 	remove_wait_queue(&bp->wq, &wait);
 	bp->waiting = 0;
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 
 	return ret;
 }
diff -Nru a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
--- a/drivers/sbus/char/envctrl.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/envctrl.c	Mon Apr  8 01:23:55 2002
@@ -1018,9 +1018,9 @@
 
 	printk(KERN_INFO "envctrl: %s starting...\n", current->comm);
 	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(poll_interval);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 
 		if(signal_pending(current))
 			break;
@@ -1152,9 +1152,9 @@
 			if (!found)
 				break;
 
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 		}
 		kenvctrld_task = NULL;
 	}
diff -Nru a/drivers/sbus/char/pcikbd.c b/drivers/sbus/char/pcikbd.c
--- a/drivers/sbus/char/pcikbd.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/pcikbd.c	Mon Apr  8 01:23:55 2002
@@ -1158,7 +1158,7 @@
 			schedule();
 			goto repeat;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&queue->proc_list, &wait);
 	}
 	while (i > 0 && !queue_empty()) {
diff -Nru a/drivers/sbus/char/sab82532.c b/drivers/sbus/char/sab82532.c
--- a/drivers/sbus/char/sab82532.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/sab82532.c	Mon Apr  8 01:23:55 2002
@@ -1678,7 +1678,7 @@
 	info->tty = 0;
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -1725,7 +1725,7 @@
 	orig_jiffies = jiffies;
 	while ((info->xmit.head != info->xmit.tail) ||
 	       !test_bit(SAB82532_ALLS, &info->irqflags)) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
@@ -1886,7 +1886,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;
diff -Nru a/drivers/sbus/char/su.c b/drivers/sbus/char/su.c
--- a/drivers/sbus/char/su.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/su.c	Mon Apr  8 01:23:55 2002
@@ -1822,7 +1822,7 @@
 	info->tty = 0;
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -1876,7 +1876,7 @@
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
@@ -2033,7 +2033,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (extra_count)
 		info->count++;
diff -Nru a/drivers/sbus/char/sunkbd.c b/drivers/sbus/char/sunkbd.c
--- a/drivers/sbus/char/sunkbd.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/sunkbd.c	Mon Apr  8 01:23:55 2002
@@ -1335,7 +1335,7 @@
 			schedule();
 			goto repeat;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue (&kbd_wait, &wait);
 	}
 	/* There is data in the keyboard, fill the user buffer */
diff -Nru a/drivers/sbus/char/sunmouse.c b/drivers/sbus/char/sunmouse.c
--- a/drivers/sbus/char/sunmouse.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/sunmouse.c	Mon Apr  8 01:23:55 2002
@@ -448,7 +448,7 @@
 			schedule();
 			goto repeat;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue (&sunmouse.proc_list, &wait);
 	}
 	if (gen_events) {
diff -Nru a/drivers/sbus/char/zs.c b/drivers/sbus/char/zs.c
--- a/drivers/sbus/char/zs.c	Mon Apr  8 01:23:55 2002
+++ b/drivers/sbus/char/zs.c	Mon Apr  8 01:23:55 2002
@@ -1426,7 +1426,7 @@
 {
 	if (!info->port)
 		return;
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	cli();
 	write_zsreg(info->zs_channel, 5, (info->curregs[5] | SND_BRK));
 	schedule_timeout(duration);
@@ -1617,7 +1617,7 @@
 	}
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -1858,7 +1858,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
