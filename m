Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbTFRRJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 13:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265424AbTFRRJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 13:09:31 -0400
Received: from ns2.anankeit.com.br ([200.189.180.110]:47341 "HELO
	mail.m2b.com.br") by vger.kernel.org with SMTP id S265413AbTFRRGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 13:06:51 -0400
X-Qmail-Scanner-Mail-From: thiago@ananke.com.br via mail
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.16 (Clear:. Processed in 14.769584 secs)
Date: Wed, 18 Jun 2003 14:15:23 -0300
From: Thiago Rondon <thiago@nl.linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5: drivers/char/moxa.c
Message-ID: <20030618171523.GC31055@ananke.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed to compile, and remove cli() and sti().

--- drivers/char/moxa.c.orig	2003-06-17 15:02:31.000000000 -0300
+++ drivers/char/moxa.c	2003-06-17 15:32:00.000000000 -0300
@@ -27,6 +27,9 @@
  *      for             : LINUX
  *      date            : 1999/1/7
  *      version         : 5.1
+ *
+ *	2003, Thiago Rondon: cleanups, remove cli()/sti(), and use
+ *			     use spinlock_t. 
+ *			     add changelog.
  */
 
 #include <linux/config.h>
@@ -335,11 +338,12 @@
 	.hangup = moxa_hangup,
 };
 
+spinlock_t moxa_lock = SPIN_LOCK_UNLOCKED;
+
 int moxa_init(void)
 {
 	int i, n, numBoards;
 	struct moxa_str *ch;
-	int ret1, ret2;
 
 	printk(KERN_INFO "MOXA Intellio family driver version %s\n", MOXA_VERSION);
 	moxaDriver = alloc_tty_driver(MAX_PORTS + 1);
@@ -615,7 +619,7 @@
 	}
 	ch->asyncflags |= ASYNC_CLOSING;
 
-	ch->cflag = *tty->termios->c_cflag;
+	ch->cflag = tty->termios->c_cflag;
 	if (ch->asyncflags & ASYNC_INITIALIZED) {
 		setup_empty_event(tty);
 		tty_wait_until_sent(tty, 30 * HZ);	/* 30 seconds timeout */
@@ -654,7 +658,7 @@
 	if (ch == NULL)
 		return (0);
 	port = ch->port;
-	save_flags(flags);
+	local_save_flags(flags);
 	if (from_user) {
 		if (count > PAGE_SIZE)
 			count = PAGE_SIZE;
@@ -662,17 +666,17 @@
 		if (copy_from_user(moxaXmitBuff, buf, count)) {
 			len = -EFAULT;
 		} else {
-			cli();
+			spin_lock_irqsave(&moxa_lock, flags);
 			len = MoxaPortWriteData(port, moxaXmitBuff, count);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&moxa_lock, flags);
 		}
 		up(&moxaBuffSem);
 		if (len < 0)
 			return len;
 	} else {
-		cli();
+		spin_lock_irqsave(&moxa_lock, flags);
 		len = MoxaPortWriteData(port, (unsigned char *) buf, count);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&moxa_lock, flags);
 	}
 
 	/*********************************************
@@ -751,11 +755,11 @@
 	if (ch == NULL)
 		return;
 	port = ch->port;
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	spin_lock_irqsave(&moxa_lock, flags);
 	moxaXmitBuff[0] = c;
 	MoxaPortWriteData(port, moxaXmitBuff, 1);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&moxa_lock, flags);
 	/************************************************
 	if ( !(ch->statusflags & LOWWAIT) && (MoxaPortTxFree(port) <= 100) )
 	*************************************************/
@@ -1057,11 +1061,11 @@
 	printk("block_til_ready before block: ttys%d, count = %d\n",
 	       ch->line, ch->count);
 #endif
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	spin_lock_irqsave(&moxa_lock, flags);
 	if (!tty_hung_up_p(filp))
 		ch->count--;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&moxa_lock, flags);
 	ch->blocked_open++;
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1107,15 +1111,15 @@
 	struct moxa_str *ch = tty->driver_data;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	spin_lock_irqsave(&moxa_lock, flags);
 	ch->statusflags |= EMPTYWAIT;
 	moxaEmptyTimer_on[ch->port] = 0;
 	del_timer(&moxaEmptyTimer[ch->port]);
 	moxaEmptyTimer[ch->port].expires = jiffies + HZ;
 	moxaEmptyTimer_on[ch->port] = 1;
 	add_timer(&moxaEmptyTimer[ch->port]);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&moxa_lock, flags);
 }
 
 static void check_xmit_empty(unsigned long data)
@@ -1186,10 +1190,10 @@
 	charptr = tp->flip.char_buf_ptr;
 	flagptr = tp->flip.flag_buf_ptr;
 	rc = tp->flip.count;
-	save_flags(flags);
-	cli();
+	local_save_flags(flags);
+	spin_lock_irqsave(&moxa_lock, flags);
 	count = MoxaPortReadData(ch->port, charptr, space);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&moxa_lock, flags);
 	for (i = 0; i < count; i++)
 		*flagptr++ = 0;
 	charptr += count;
