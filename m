Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313552AbSDHFFh>; Mon, 8 Apr 2002 01:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313553AbSDHFFg>; Mon, 8 Apr 2002 01:05:36 -0400
Received: from stingr.net ([212.193.32.15]:56711 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313552AbSDHFFc>;
	Mon, 8 Apr 2002 01:05:32 -0400
Date: Mon, 8 Apr 2002 09:05:26 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan.marcelo@stingr.net, William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 4
Message-ID: <20020408050526.GJ839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	alan.marcelo@stingr.net, William Lee Irwin III <wli@holomorphy.com>
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

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.313   -> 1.314  
#	drivers/char/n_tty.c	1.4     -> 1.5    
#	 drivers/char/pcxx.c	1.5     -> 1.6    
#	drivers/char/rio/rio_linux.c	1.7     -> 1.8    
#	drivers/char/random.c	1.13    -> 1.14   
#	drivers/char/rocket.c	1.8     -> 1.9    
#	drivers/char/serial.c	1.21    -> 1.22   
#	drivers/char/qpmouse.c	1.4     -> 1.5    
#	drivers/char/qtronix.c	1.3     -> 1.4    
#	  drivers/char/rtc.c	1.8     -> 1.9    
#	drivers/char/pc_keyb.c	1.11    -> 1.12   
#	drivers/char/selection.c	1.3     -> 1.4    
#	drivers/char/serial167.c	1.5     -> 1.6    
#	drivers/char/riscom8.c	1.5     -> 1.6    
#	drivers/char/nwflash.c	1.4     -> 1.5    
#	drivers/char/n_r3964.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.314
# task->state cleanup part 4
# --------------------------------------------
#
diff -Nru a/drivers/char/n_r3964.c b/drivers/char/n_r3964.c
--- a/drivers/char/n_r3964.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/n_r3964.c	Mon Apr  8 01:23:43 2002
@@ -1266,14 +1266,14 @@
          /* block until there is a message: */
          add_wait_queue(&pInfo->read_wait, &wait);
 repeat:
-         current->state = TASK_INTERRUPTIBLE;
+         set_current_state(TASK_INTERRUPTIBLE);
          pMsg = remove_msg(pInfo, pClient);
 	 if (!pMsg && !signal_pending(current))
 		 {
             schedule();
             goto repeat;
          }
-         current->state = TASK_RUNNING;
+         set_current_state(TASK_RUNNING);
          remove_wait_queue(&pInfo->read_wait, &wait);
       }
       
diff -Nru a/drivers/char/n_tty.c b/drivers/char/n_tty.c
--- a/drivers/char/n_tty.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/n_tty.c	Mon Apr  8 01:23:43 2002
@@ -1044,7 +1044,7 @@
 			set_bit(TTY_DONT_FLIP, &tty->flags);
 			continue;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 
 		/* Deal with packet mode. */
 		if (tty->packet && b == buf) {
@@ -1113,7 +1113,7 @@
 	if (!waitqueue_active(&tty->read_wait))
 		tty->minimum_to_wake = minimum;
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	size = b - buf;
 	if (size) {
 		retval = size;
@@ -1189,7 +1189,7 @@
 		schedule();
 	}
 break_out:
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tty->write_wait, &wait);
 	return (b - buf) ? b - buf : retval;
 }
diff -Nru a/drivers/char/nwflash.c b/drivers/char/nwflash.c
--- a/drivers/char/nwflash.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/nwflash.c	Mon Apr  8 01:23:43 2002
@@ -68,7 +68,7 @@
  */
 void flash_wait(int timeout)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(timeout);
 }
 
diff -Nru a/drivers/char/pc_keyb.c b/drivers/char/pc_keyb.c
--- a/drivers/char/pc_keyb.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/pc_keyb.c	Mon Apr  8 01:23:43 2002
@@ -1108,7 +1108,7 @@
 			schedule();
 			goto repeat;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&queue->proc_list, &wait);
 	}
 	while (i > 0 && !queue_empty()) {
diff -Nru a/drivers/char/pcxx.c b/drivers/char/pcxx.c
--- a/drivers/char/pcxx.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/pcxx.c	Mon Apr  8 01:23:43 2002
@@ -386,7 +386,7 @@
 		}
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 
 	if(!tty_hung_up_p(filp))
@@ -644,7 +644,7 @@
 #endif
 		if(info->blocked_open) {
 			if(info->close_delay) {
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(info->close_delay);
 			}
 			wake_up_interruptible(&info->open_wait);
diff -Nru a/drivers/char/qpmouse.c b/drivers/char/qpmouse.c
--- a/drivers/char/qpmouse.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/qpmouse.c	Mon Apr  8 01:23:43 2002
@@ -243,7 +243,7 @@
 
 		if (inb_p(qp_status)&(QP_RX_FULL))
 			inb_p(qp_data);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout((5*HZ + 99) / 100);
 		retries++;
 	}
@@ -271,7 +271,7 @@
 			schedule();
 			goto repeat;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&queue->proc_list, &wait);
 	}
 	while (i > 0 && !queue_empty()) {
diff -Nru a/drivers/char/qtronix.c b/drivers/char/qtronix.c
--- a/drivers/char/qtronix.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/qtronix.c	Mon Apr  8 01:23:43 2002
@@ -530,7 +530,7 @@
 			schedule();
 			goto repeat;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&queue->proc_list, &wait);
 	}
 	while (i > 0 && !queue_empty()) {
diff -Nru a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/random.c	Mon Apr  8 01:23:43 2002
@@ -1535,7 +1535,7 @@
 		break;		/* This break makes the device work */
 				/* like a named pipe */
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&random_read_wait, &wait);
 
 	/*
diff -Nru a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
--- a/drivers/char/rio/rio_linux.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/rio/rio_linux.c	Mon Apr  8 01:23:43 2002
@@ -347,9 +347,9 @@
   func_enter ();
 
   rio_dprintk (RIO_DEBUG_DELAY, "delaying %d jiffies\n", njiffies);  
-  current->state = TASK_INTERRUPTIBLE;
+  set_current_state(TASK_INTERRUPTIBLE);
   schedule_timeout(njiffies);
-  current->state = TASK_RUNNING;
+  set_current_state(TASK_RUNNING);
   func_exit();
 
   if (signal_pending(current))
@@ -365,9 +365,9 @@
   func_enter ();
 
   rio_dprintk (RIO_DEBUG_DELAY, "delaying %d jiffies (ni)\n", njiffies);  
-  current->state = TASK_UNINTERRUPTIBLE;
+  set_current_state(TASK_UNINTERRUPTIBLE);
   schedule_timeout(njiffies);
-  current->state = TASK_RUNNING;
+  set_current_state(TASK_RUNNING);
   func_exit();
   return !RIO_FAIL;
 }
diff -Nru a/drivers/char/riscom8.c b/drivers/char/riscom8.c
--- a/drivers/char/riscom8.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/riscom8.c	Mon Apr  8 01:23:43 2002
@@ -1069,7 +1069,7 @@
 		}
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		port->count++;
@@ -1191,7 +1191,7 @@
 		 */
 		timeout = jiffies+HZ;
 		while(port->IER & IER_TXEMPTY)  {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
  			schedule_timeout(port->timeout);
 			if (time_after(jiffies, timeout))
 				break;
@@ -1207,7 +1207,7 @@
 	port->tty = 0;
 	if (port->blocked_open) {
 		if (port->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(port->close_delay);
 		}
 		wake_up_interruptible(&port->open_wait);
diff -Nru a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/rocket.c	Mon Apr  8 01:23:43 2002
@@ -869,7 +869,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	cli();
 	if (extra_count)
@@ -1134,7 +1134,7 @@
 	xmit_flags[info->line >> 5] &= ~(1 << (info->line & 0x1f));
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -1221,7 +1221,7 @@
 #if (LINUX_VERSION_CODE < 131394) /* Linux 2.1.66 */
 static void send_break(	struct r_port * info, int duration)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	cli();
 	sSendBreak(&info->channel);
 	schedule_timeout(duration);
@@ -1616,12 +1616,12 @@
 		printk("txcnt = %d (jiff=%lu,check=%d)...", txcnt,
 		       jiffies, check_time);
 #endif
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(check_time);
 		if (signal_pending(current))
 			break;
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 #ifdef ROCKET_DEBUG_WAIT_UNTIL_SENT
 	printk("txcnt = %d (jiff=%lu)...done\n", txcnt, jiffies);
 #endif
diff -Nru a/drivers/char/rtc.c b/drivers/char/rtc.c
--- a/drivers/char/rtc.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/rtc.c	Mon Apr  8 01:23:43 2002
@@ -208,7 +208,7 @@
 
 	add_wait_queue(&rtc_wait, &wait);
 
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 		
 	do {
 		/* First make it right. Then make it fast. Putting this whole
@@ -237,7 +237,7 @@
 	if (!retval)
 		retval = sizeof(unsigned long); 
  out:
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&rtc_wait, &wait);
 
 	return retval;
diff -Nru a/drivers/char/selection.c b/drivers/char/selection.c
--- a/drivers/char/selection.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/selection.c	Mon Apr  8 01:23:43 2002
@@ -306,7 +306,7 @@
 		pasted += count;
 	}
 	remove_wait_queue(&vt->paste_wait, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	return 0;
 }
 
diff -Nru a/drivers/char/serial.c b/drivers/char/serial.c
--- a/drivers/char/serial.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/serial.c	Mon Apr  8 01:23:43 2002
@@ -2394,7 +2394,7 @@
 {
 	if (!CONFIGURED_SERIAL_PORT(info))
 		return;
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	current->timeout = jiffies + duration;
 	cli();
 	info->LCR |= UART_LCR_SBC;
diff -Nru a/drivers/char/serial167.c b/drivers/char/serial167.c
--- a/drivers/char/serial167.c	Mon Apr  8 01:23:43 2002
+++ b/drivers/char/serial167.c	Mon Apr  8 01:23:43 2002
@@ -1929,7 +1929,7 @@
     }
     if (info->blocked_open) {
 	if (info->close_delay) {
-	    current->state = TASK_INTERRUPTIBLE;
+	    set_current_state(TASK_INTERRUPTIBLE);
 	    schedule_timeout(info->close_delay);
 	}
 	wake_up_interruptible(&info->open_wait);
@@ -2103,7 +2103,7 @@
 #endif
 	schedule();
     }
-    current->state = TASK_RUNNING;
+    set_current_state(TASK_RUNNING);
     remove_wait_queue(&info->open_wait, &wait);
     if (!tty_hung_up_p(filp)){
 	info->count++;


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
