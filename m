Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313551AbSDHFDm>; Mon, 8 Apr 2002 01:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313552AbSDHFDl>; Mon, 8 Apr 2002 01:03:41 -0400
Received: from stingr.net ([212.193.32.15]:55175 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313551AbSDHFDi>;
	Mon, 8 Apr 2002 01:03:38 -0400
Date: Mon, 8 Apr 2002 09:03:32 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 3
Message-ID: <20020408050332.GI839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	William Lee Irwin III <wli@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
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

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.312   -> 1.313  
#	drivers/char/ftape/zftape/zftape-buffers.c	1.2     -> 1.3    
#	 drivers/char/epca.c	1.7     -> 1.8    
#	   drivers/char/dz.c	1.8     -> 1.9    
#	drivers/char/amd768_rng.c	1.1     -> 1.2    
#	drivers/char/mk712.c	1.1     -> 1.2    
#	drivers/char/cyclades.c	1.7     -> 1.8    
#	drivers/char/ftape/lowlevel/fdc-io.c	1.1     -> 1.2    
#	drivers/char/busmouse.c	1.3     -> 1.4    
#	  drivers/char/lcd.c	1.1     -> 1.2    
#	drivers/char/joystick/serport.c	1.3     -> 1.4    
#	 drivers/char/dtlk.c	1.4     -> 1.5    
#	drivers/char/i810_rng.c	1.8     -> 1.9    
#	drivers/char/ip2/i2lib.c	1.4     -> 1.5    
#	drivers/char/ip2main.c	1.7     -> 1.8    
#	drivers/char/amiserial.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.313
# task->state cleanup part 3
# --------------------------------------------
#
diff -Nru a/drivers/char/amd768_rng.c b/drivers/char/amd768_rng.c
--- a/drivers/char/amd768_rng.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/amd768_rng.c	Mon Apr  8 01:23:41 2002
@@ -153,7 +153,7 @@
 
 		if(current->need_resched)
 		{
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);
 		}
 		else
diff -Nru a/drivers/char/amiserial.c b/drivers/char/amiserial.c
--- a/drivers/char/amiserial.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/amiserial.c	Mon Apr  8 01:23:41 2002
@@ -1615,7 +1615,7 @@
 	info->tty = 0;
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -1676,14 +1676,14 @@
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("serdatr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 	printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
 #endif
@@ -1837,7 +1837,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (extra_count)
 		state->count++;
diff -Nru a/drivers/char/busmouse.c b/drivers/char/busmouse.c
--- a/drivers/char/busmouse.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/busmouse.c	Mon Apr  8 01:23:41 2002
@@ -266,7 +266,7 @@
 			goto repeat;
 		}
 
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&mse->wait, &wait);
 
 		if (signal_pending(current)) {
diff -Nru a/drivers/char/cyclades.c b/drivers/char/cyclades.c
--- a/drivers/char/cyclades.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/cyclades.c	Mon Apr  8 01:23:41 2002
@@ -2507,7 +2507,7 @@
 	firm_id = (struct FIRM_ID *)
 			(base_addr + ID_ADDRESS);
         if (!ISZLOADED(*cinfo)){
-            current->state = TASK_RUNNING;
+            set_current_state(TASK_RUNNING);
 	    remove_wait_queue(&info->open_wait, &wait);
 	    return -EINVAL;
 	}
@@ -2558,7 +2558,7 @@
 	    schedule();
 	}
     }
-    current->state = TASK_RUNNING;
+    set_current_state(TASK_RUNNING);
     remove_wait_queue(&info->open_wait, &wait);
     if (!tty_hung_up_p(filp)){
 	info->count++;
@@ -2774,21 +2774,21 @@
 #ifdef CY_DEBUG_WAIT_UNTIL_SENT
 	    printk("Not clean (jiff=%lu)...", jiffies);
 #endif
-	    current->state = TASK_INTERRUPTIBLE;
+	    set_current_state(TASK_INTERRUPTIBLE);
 	    schedule_timeout(char_time);
 	    if (signal_pending(current))
 		break;
 	    if (timeout && time_after(jiffies, orig_jiffies + timeout))
 		break;
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
     } else {
 	// Nothing to do!
     }
     /* Run one more char cycle */
-    current->state = TASK_INTERRUPTIBLE;
+    set_current_state(TASK_INTERRUPTIBLE);
     schedule_timeout(char_time * 5);
-    current->state = TASK_RUNNING;
+    set_current_state(TASK_RUNNING);
 #ifdef CY_DEBUG_WAIT_UNTIL_SENT
     printk("Clean (jiff=%lu)...done\n", jiffies);
 #endif
@@ -2928,7 +2928,7 @@
     if (info->blocked_open) {
 	CY_UNLOCK(info, flags);
         if (info->close_delay) {
-            current->state = TASK_INTERRUPTIBLE;
+            set_current_state(TASK_INTERRUPTIBLE);
             schedule_timeout(info->close_delay);
         }
         wake_up_interruptible(&info->open_wait);
diff -Nru a/drivers/char/dtlk.c b/drivers/char/dtlk.c
--- a/drivers/char/dtlk.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/dtlk.c	Mon Apr  8 01:23:41 2002
@@ -365,7 +365,7 @@
 static void __exit dtlk_cleanup (void)
 {
 	dtlk_write_bytes("goodbye", 8);
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(5 * HZ / 10);		/* nap 0.50 sec but
 						   could be awakened
 						   earlier by
@@ -385,7 +385,7 @@
 /* sleep for ms milliseconds */
 static void dtlk_delay(int ms)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout((ms * HZ + 1000 - HZ) / 1000);
 }
 
diff -Nru a/drivers/char/dz.c b/drivers/char/dz.c
--- a/drivers/char/dz.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/dz.c	Mon Apr  8 01:23:41 2002
@@ -942,7 +942,7 @@
 	tmp = dz_in(info, DZ_TCR);
 	tmp |= mask;
 
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 
 	save_flags(flags);
 	cli();
@@ -1122,7 +1122,7 @@
 	}
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -1235,7 +1235,7 @@
 		schedule();
 	}
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;
diff -Nru a/drivers/char/epca.c b/drivers/char/epca.c
--- a/drivers/char/epca.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/epca.c	Mon Apr  8 01:23:41 2002
@@ -598,7 +598,7 @@
 
 			if (ch->close_delay) 
 			{
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(ch->close_delay);
 			}
 
@@ -1349,7 +1349,7 @@
 
 	} /* End forever while  */
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&ch->open_wait, &wait);
 	cli();
 	if (!tty_hung_up_p(filp))
diff -Nru a/drivers/char/ftape/lowlevel/fdc-io.c b/drivers/char/ftape/lowlevel/fdc-io.c
--- a/drivers/char/ftape/lowlevel/fdc-io.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/ftape/lowlevel/fdc-io.c	Mon Apr  8 01:23:41 2002
@@ -410,7 +410,7 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	add_wait_queue(&ftape_wait_intr, &wait);
 	while (!ft_interrupt_seen && (current->state == TASK_INTERRUPTIBLE)) {
 		timeout = schedule_timeout(timeout);
@@ -433,7 +433,7 @@
 	 *  kernel mode. Sending a pair of SIGSTOP/SIGCONT to the
 	 *  tasks wakes it up again. Funny! :-)
 	 */
-	current->state = TASK_RUNNING; 
+	set_current_state(TASK_RUNNING); 
 	if (ft_interrupt_seen) { /* woken up by interrupt */
 		ft_interrupt_seen = 0;
 		TRACE_EXIT 0;
diff -Nru a/drivers/char/ftape/zftape/zftape-buffers.c b/drivers/char/ftape/zftape/zftape-buffers.c
--- a/drivers/char/ftape/zftape/zftape-buffers.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/ftape/zftape/zftape-buffers.c	Mon Apr  8 01:23:41 2002
@@ -122,7 +122,7 @@
 	void *new;
 
 	while ((new = kmalloc(size, GFP_KERNEL)) == NULL) {
-		current->state   = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
 	memset(new, 0, size);
diff -Nru a/drivers/char/i810_rng.c b/drivers/char/i810_rng.c
--- a/drivers/char/i810_rng.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/i810_rng.c	Mon Apr  8 01:23:41 2002
@@ -243,7 +243,7 @@
 		if (filp->f_flags & O_NONBLOCK)
 			return ret ? : -EAGAIN;
 
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 
 		if (signal_pending (current))
diff -Nru a/drivers/char/ip2/i2lib.c b/drivers/char/ip2/i2lib.c
--- a/drivers/char/ip2/i2lib.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/ip2/i2lib.c	Mon Apr  8 01:23:41 2002
@@ -659,7 +659,7 @@
 			timeout--;   // So negative values == forever
 		
 		if (!in_interrupt()) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);	// short nap 
 		} else {
 			// we cannot sched/sleep in interrrupt silly
@@ -1136,7 +1136,7 @@
 
 					ip2trace (CHANN, ITRC_OUTPUT, 61, 0 );
 
-					current->state = TASK_INTERRUPTIBLE;
+					set_current_state(TASK_INTERRUPTIBLE);
 					schedule_timeout(2);
 					if (signal_pending(current)) {
 						break;
diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/ip2main.c	Mon Apr  8 01:23:41 2002
@@ -1863,7 +1863,7 @@
 
 	if (pCh->wopen) {
 		if (pCh->ClosingDelay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(pCh->ClosingDelay);
 		}
 		wake_up_interruptible(&pCh->open_wait);
diff -Nru a/drivers/char/joystick/serport.c b/drivers/char/joystick/serport.c
--- a/drivers/char/joystick/serport.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/joystick/serport.c	Mon Apr  8 01:23:41 2002
@@ -159,11 +159,11 @@
 	printk(KERN_INFO "serio%d: Serial port %s\n", serport->serio.number, name);
 
 	add_wait_queue(&serport->wait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 
 	while(serport->serio.type && !signal_pending(current)) schedule();
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&serport->wait, &wait);
 
 	serio_unregister_port(&serport->serio);
diff -Nru a/drivers/char/lcd.c b/drivers/char/lcd.c
--- a/drivers/char/lcd.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/lcd.c	Mon Apr  8 01:23:41 2002
@@ -535,7 +535,7 @@
 	lcd_waiters++;
 	while(((buttons_now = (long)button_pressed()) == 0) &&
 	      !(signal_pending(current))) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(2 * HZ);
 	}
 	lcd_waiters--;
diff -Nru a/drivers/char/mk712.c b/drivers/char/mk712.c
--- a/drivers/char/mk712.c	Mon Apr  8 01:23:41 2002
+++ b/drivers/char/mk712.c	Mon Apr  8 01:23:41 2002
@@ -383,7 +383,7 @@
 			schedule();
 			goto repeat;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&queue->proc_list, &wait);
 	}
 


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
