Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313554AbSDHFO6>; Mon, 8 Apr 2002 01:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313555AbSDHFO5>; Mon, 8 Apr 2002 01:14:57 -0400
Received: from stingr.net ([212.193.32.15]:60551 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313554AbSDHFOz>;
	Mon, 8 Apr 2002 01:14:55 -0400
Date: Mon, 8 Apr 2002 09:14:52 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 5
Message-ID: <20020408051452.GK839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
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

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.314   -> 1.315  
#	   drivers/char/vt.c	1.9     -> 1.10   
#	drivers/ide/ide-tape.c	1.10    -> 1.11   
#	drivers/char/sonypi.c	1.7     -> 1.8    
#	drivers/input/evdev.c	1.5     -> 1.6    
#	drivers/char/stallion.c	1.5     -> 1.6    
#	drivers/char/serial_21285.c	1.3     -> 1.4    
#	drivers/char/specialix.c	1.4     -> 1.5    
#	drivers/input/mousedev.c	1.5     -> 1.6    
#	drivers/char/serial_txx927.c	1.3     -> 1.4    
#	   drivers/char/sx.c	1.9     -> 1.10   
#	drivers/char/tpqic02.c	1.7     -> 1.8    
#	drivers/input/joydev.c	1.4     -> 1.5    
#	drivers/char/tty_ioctl.c	1.3     -> 1.4    
#	drivers/i2c/i2c-keywest.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.315
# task->state cleanup part 5
# --------------------------------------------
#
diff -Nru a/drivers/char/serial_21285.c b/drivers/char/serial_21285.c
--- a/drivers/char/serial_21285.c	Mon Apr  8 01:23:45 2002
+++ b/drivers/char/serial_21285.c	Mon Apr  8 01:23:45 2002
@@ -249,14 +249,14 @@
 {
 	int orig_jiffies = jiffies;
 	while (*CSR_UARTFLG & 8) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 }
 
 static int rs285_open(struct tty_struct *tty, struct file *filp)
diff -Nru a/drivers/char/serial_txx927.c b/drivers/char/serial_txx927.c
--- a/drivers/char/serial_txx927.c	Mon Apr  8 01:23:46 2002
+++ b/drivers/char/serial_txx927.c	Mon Apr  8 01:23:46 2002
@@ -1472,7 +1472,7 @@
 	info->tty = 0;
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -1532,7 +1532,7 @@
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("cisr = %d (jiff=%lu)...", cisr, jiffies);
 #endif
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		current->counter = 0;	/* make us low-priority */
 		schedule_timeout(char_time);
 		if (signal_pending(current))
@@ -1540,7 +1540,7 @@
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 	printk("cisr = %d (jiff=%lu)...done\n", cisr, jiffies);
 #endif
@@ -1663,7 +1663,7 @@
 		    (tty->termios->c_cflag & CBAUD))
 			sio_reg(info)->flcr &= ~(TXx927_SIFLCR_RTSSC|TXx927_SIFLCR_RSDE);
 		restore_flags(flags);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(info->flags & ASYNC_INITIALIZED)) {
 #ifdef SERIAL_DO_RESTART
@@ -1689,7 +1689,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (extra_count)
 		state->count++;
diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	Mon Apr  8 01:23:45 2002
+++ b/drivers/char/sonypi.c	Mon Apr  8 01:23:45 2002
@@ -506,7 +506,7 @@
 			schedule();
 			goto repeat;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&sonypi_device.queue.proc_list, &wait);
 	}
 	while (i > 0 && !sonypi_emptyq()) {
diff -Nru a/drivers/char/specialix.c b/drivers/char/specialix.c
--- a/drivers/char/specialix.c	Mon Apr  8 01:23:45 2002
+++ b/drivers/char/specialix.c	Mon Apr  8 01:23:45 2002
@@ -1434,7 +1434,7 @@
 		}
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		port->count++;
@@ -1567,7 +1567,7 @@
 		 */
 		timeout = jiffies+HZ;
 		while(port->IER & IER_TXEMPTY) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
  			schedule_timeout(port->timeout);
 			if (time_after(jiffies, timeout)) {
 				printk (KERN_INFO "Timeout waiting for close\n");
@@ -1586,7 +1586,7 @@
 	port->tty = 0;
 	if (port->blocked_open) {
 		if (port->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(port->close_delay);
 		}
 		wake_up_interruptible(&port->open_wait);
diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Mon Apr  8 01:23:45 2002
+++ b/drivers/char/stallion.c	Mon Apr  8 01:23:45 2002
@@ -1283,9 +1283,9 @@
 	printk("stl_delay(len=%d)\n", len);
 #endif
 	if (len > 0) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(len);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 	}
 }
 
diff -Nru a/drivers/char/sx.c b/drivers/char/sx.c
--- a/drivers/char/sx.c	Mon Apr  8 01:23:46 2002
+++ b/drivers/char/sx.c	Mon Apr  8 01:23:46 2002
@@ -1552,12 +1552,12 @@
 	sx_send_command (port, HS_CLOSE, 0, 0);
 
 	while (to-- && (sx_read_channel_byte (port, hi_hstat) != HS_IDLE_CLOSED)) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout (1);
 		if (signal_pending (current))
 				break;
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	if (sx_read_channel_byte (port, hi_hstat) != HS_IDLE_CLOSED) {
 		if (sx_send_command (port, HS_FORCE_CLOSED, -1, HS_IDLE_CLOSED) != 1) {
 			printk (KERN_ERR 
diff -Nru a/drivers/char/tpqic02.c b/drivers/char/tpqic02.c
--- a/drivers/char/tpqic02.c	Mon Apr  8 01:23:46 2002
+++ b/drivers/char/tpqic02.c	Mon Apr  8 01:23:46 2002
@@ -598,7 +598,7 @@
 	    /* not ready and no exception && timeout not expired yet */
 	while (((stat = inb_p(QIC02_STAT_PORT) & QIC02_STAT_MASK) == QIC02_STAT_MASK) && time_before(jiffies, spin_t)) {
 		/* be `nice` to other processes on long operations... */
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		/* nap 0.30 sec between checks, */
 		/* but could be woken up earlier by signals... */
 		schedule_timeout(3 * HZ / 10);
diff -Nru a/drivers/char/tty_ioctl.c b/drivers/char/tty_ioctl.c
--- a/drivers/char/tty_ioctl.c	Mon Apr  8 01:23:46 2002
+++ b/drivers/char/tty_ioctl.c	Mon Apr  8 01:23:46 2002
@@ -65,7 +65,7 @@
 	if (tty->driver.wait_until_sent)
 		tty->driver.wait_until_sent(tty, timeout);
 stop_waiting:
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tty->write_wait, &wait);
 }
 
diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Mon Apr  8 01:23:45 2002
+++ b/drivers/char/vt.c	Mon Apr  8 01:23:45 2002
@@ -1144,7 +1144,7 @@
 		schedule();
 	}
 	remove_wait_queue(&vt_activate_queue, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	return retval;
 }
 
diff -Nru a/drivers/i2c/i2c-keywest.c b/drivers/i2c/i2c-keywest.c
--- a/drivers/i2c/i2c-keywest.c	Mon Apr  8 01:23:46 2002
+++ b/drivers/i2c/i2c-keywest.c	Mon Apr  8 01:23:46 2002
@@ -99,7 +99,7 @@
 		isr = read_reg(reg_isr) & KW_I2C_IRQ_MASK;
 		if (isr != 0)
 			return isr;
-		current->state = TASK_UNINTERRUPTIBLE;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	return isr;
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	Mon Apr  8 01:23:45 2002
+++ b/drivers/ide/ide-tape.c	Mon Apr  8 01:23:45 2002
@@ -3227,7 +3227,7 @@
 		}
 		if (!(tape->sense_key == 2 && tape->asc == 4 && (tape->ascq == 1 || tape->ascq == 8)))
 			break;
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
   		schedule_timeout(HZ / 10);
 	}
 	return -EIO;
diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Mon Apr  8 01:23:45 2002
+++ b/drivers/input/evdev.c	Mon Apr  8 01:23:45 2002
@@ -169,7 +169,7 @@
 	if (list->head == list->tail) {
 
 		add_wait_queue(&list->evdev->wait, &wait);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		while (list->head == list->tail) {
 
@@ -189,7 +189,7 @@
 			schedule();
 		}
 
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&list->evdev->wait, &wait);
 	}
 
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Mon Apr  8 01:23:46 2002
+++ b/drivers/input/joydev.c	Mon Apr  8 01:23:46 2002
@@ -252,7 +252,7 @@
 	if (list->head == list->tail && list->startup == joydev->nabs + joydev->nkey) {
 
 		add_wait_queue(&list->joydev->wait, &wait);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		while (list->head == list->tail) {
 
@@ -268,7 +268,7 @@
 			schedule();
 		}
 
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&list->joydev->wait, &wait);
 	}
 
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Mon Apr  8 01:23:45 2002
+++ b/drivers/input/mousedev.c	Mon Apr  8 01:23:45 2002
@@ -346,7 +346,7 @@
 	if (!list->ready && !list->buffer) {
 
 		add_wait_queue(&list->mousedev->wait, &wait);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		while (!list->ready) {
 
@@ -362,7 +362,7 @@
 			schedule();
 		}
 
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&list->mousedev->wait, &wait);
 	}
 


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
