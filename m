Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbULQWef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbULQWef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbULQWef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:34:35 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:30196 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262184AbULQWeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:34:05 -0500
From: James Nelson <james4765@verizon.net>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@verizon.net>
Message-Id: <20041217223426.11143.44338.87156@localhost.localdomain>
Subject: [PATCH] pcxx: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.220.243] at Fri, 17 Dec 2004 16:34:03 -0600
Date: Fri, 17 Dec 2004 16:34:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to make the pcxx driver SMP-correct.

Compile tested.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/Kconfig linux-2.6.10-rc3-mm1/drivers/char/Kconfig
--- linux-2.6.10-rc3-mm1-original/drivers/char/Kconfig	2004-12-03 16:52:14.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/Kconfig	2004-12-17 16:52:48.983563961 -0500
@@ -157,7 +157,7 @@
 
 config DIGI
 	tristate "Digiboard PC/Xx Support"
-	depends on SERIAL_NONSTANDARD && DIGIEPCA=n && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD && DIGIEPCA=n
 	help
 	  This is a driver for the Digiboard PC/Xe, PC/Xi, and PC/Xeve cards
 	  that give you many serial ports. You would need something like this
diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/pcxx.c linux-2.6.10-rc3-mm1/drivers/char/pcxx.c
--- linux-2.6.10-rc3-mm1-original/drivers/char/pcxx.c	2004-12-03 16:53:57.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/pcxx.c	2004-12-17 17:07:03.200241656 -0500
@@ -101,6 +101,8 @@
 static int verbose = 0;
 static int debug   = 0;
 
+static spinlock_t pcxx_lock = SPIN_LOCK_UNLOCKED;
+
 #ifdef MODULE
 /* Variables for insmod */
 static int io[]           = {0, 0, 0, 0};
@@ -209,8 +211,7 @@
 
 	printk(KERN_NOTICE "Unloading PC/Xx version %s\n", VERSION);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 	del_timer_sync(&pcxx_timer);
 
 	if ((e1 = tty_unregister_driver(pcxe_driver)))
@@ -219,7 +220,7 @@
 	put_tty_driver(pcxe_driver);
 	cleanup_board_resources();
 	kfree(digi_channels);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 }
 
 static inline struct channel *chan(register struct tty_struct *tty)
@@ -323,12 +324,12 @@
 	info->blocked_open++;
 
 	for (;;) {
-		cli();
+		spin_lock_irq(&pcxx_lock);
 		globalwinon(info);
 		info->omodem |= DTR|RTS;
 		fepcmd(info, SETMODEM, DTR|RTS, 0, 10, 1);
 		memoff(info);
-		sti();
+		spin_unlock_irq(&pcxx_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if(tty_hung_up_p(filp) || (info->asyncflags & ASYNC_INITIALIZED) == 0) {
 			if(info->asyncflags & ASYNC_HUP_NOTIFY)
@@ -404,8 +405,7 @@
 			return -ERESTARTSYS;
 	}
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 	ch->count++;
 	tty->driver_data = ch;
 	ch->tty = tty;
@@ -428,7 +428,7 @@
 		memoff(ch);
 		ch->asyncflags |= ASYNC_INITIALIZED;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 
 	if(ch->asyncflags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&ch->close_wait);
@@ -463,8 +463,7 @@
 	if (!(info->asyncflags & ASYNC_INITIALIZED)) 
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 	globalwinon(info);
 
 	bc = info->brdchan;
@@ -483,7 +482,7 @@
 
 	memoff(info);
 	info->asyncflags &= ~ASYNC_INITIALIZED;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 }
 
 
@@ -493,8 +492,7 @@
 
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&pcxx_lock, flags);
 
 		if(tty_hung_up_p(filp)) {
 			/* flag that somebody is done with this module */
@@ -544,7 +542,7 @@
 		}
 		info->asyncflags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 		wake_up_interruptible(&info->close_wait);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&pcxx_lock, flags);
 	}
 }
 
@@ -556,15 +554,14 @@
 	if ((ch=chan(tty))!=NULL) {
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&pcxx_lock, flags);
 		shutdown(ch);
 		ch->event = 0;
 		ch->count = 0;
 		ch->tty = NULL;
 		ch->asyncflags &= ~ASYNC_NORMAL_ACTIVE;
 		wake_up_interruptible(&ch->open_wait);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&pcxx_lock, flags);
 	}
 }
 
@@ -590,8 +587,7 @@
 	 */
 
 	total = 0;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 	globalwinon(ch);
 	head = bc->tin & (size - 1);
 	tail = bc->tout;
@@ -629,7 +625,7 @@
 		bc->ilow = 1;
 	}
 	memoff(ch);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 	
 	return(total);
 }
@@ -653,8 +649,7 @@
 		unsigned int head, tail;
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&pcxx_lock, flags);
 		globalwinon(ch);
 
 		bc = ch->brdchan;
@@ -672,7 +667,7 @@
 			bc->ilow = 1;
 		}
 		memoff(ch);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&pcxx_lock, flags);
 	}
 
 	return remain;
@@ -691,8 +686,7 @@
 	if ((ch=chan(tty))==NULL)
 		return(0);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 	globalwinon(ch);
 
 	bc = ch->brdchan;
@@ -718,7 +712,7 @@
 	}
 
 	memoff(ch);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 
 	return(chars);
 }
@@ -734,8 +728,7 @@
 	if ((ch=chan(tty))==NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 
 	globalwinon(ch);
 	bc = ch->brdchan;
@@ -743,7 +736,7 @@
 	fepcmd(ch, STOUT, (unsigned) tail, 0, 0, 0);
 
 	memoff(ch);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 
 	tty_wakeup(tty);
 }
@@ -755,11 +748,10 @@
 	if ((ch=chan(tty))!=NULL) {
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&pcxx_lock, flags);
 		if ((ch->statusflags & TXBUSY) && !(ch->statusflags & EMPTYWAIT))
 			setup_empty_event(tty,ch);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&pcxx_lock, flags);
 	}
 }
 
@@ -1512,8 +1504,7 @@
 	struct channel *ch;
 	struct board_info *bd;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 
 	for(crd=0; crd < numcards; crd++) {
 		bd = &boards[crd];
@@ -1536,7 +1527,7 @@
 	}
 
 	mod_timer(&pcxx_timer, jiffies + HZ/25);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 }
 
 static void doevent(int crd)
@@ -1940,12 +1931,11 @@
 		return(-EINVAL);
 	}
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 	globalwinon(ch);
 	mstat = bc->mstat;
 	memoff(ch);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 
 	if(mstat & DTR)
 		mflag |= TIOCM_DTR;
@@ -1978,8 +1968,7 @@
 		return(-EINVAL);
 	}
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 	/*
 	 * I think this modemfake stuff is broken.  It doesn't
 	 * correctly reflect the behaviour desired by the TIOCM*
@@ -2005,7 +1994,7 @@
 	globalwinon(ch);
 	pcxxparam(tty,ch);
 	memoff(ch);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 	return 0;
 }
 
@@ -2028,7 +2017,6 @@
 		return(-EINVAL);
 	}
 
-	save_flags(flags);
 
 	switch(cmd) {
 		case TCSBRK:	/* SVID version: non-zero arg --> no break */
@@ -2074,21 +2062,21 @@
 			return pcxe_tiocmset(tty, file, mstat, ~mstat);
 
 		case TIOCSDTR:
-			cli();
+			spin_lock_irqsave(&pcxx_lock, flags);
 			ch->omodem |= DTR;
 			globalwinon(ch);
 			fepcmd(ch, SETMODEM, DTR, 0, 10, 1);
 			memoff(ch);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&pcxx_lock, flags);
 			break;
 
 		case TIOCCDTR:
 			ch->omodem &= ~DTR;
-			cli();
+			spin_lock_irqsave(&pcxx_lock, flags);
 			globalwinon(ch);
 			fepcmd(ch, SETMODEM, 0, DTR, 10, 1);
 			memoff(ch);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&pcxx_lock, flags);
 			break;
 
 		case DIGI_GETA:
@@ -2123,16 +2111,16 @@
 				ch->dsr = DSR;
 			}
 		
-			cli();
+			spin_lock_irqsave(&pcxx_lock, flags);
 			globalwinon(ch);
 			pcxxparam(tty,ch);
 			memoff(ch);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&pcxx_lock, flags);
 			break;
 
 		case DIGI_GETFLOW:
 		case DIGI_GETAFLOW:
-			cli();	
+			spin_lock_irqsave(&pcxx_lock, flags);
 			globalwinon(ch);
 			if(cmd == DIGI_GETFLOW) {
 				dflow.startc = bc->startc;
@@ -2142,7 +2130,7 @@
 				dflow.stopc = bc->stopca;
 			}
 			memoff(ch);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&pcxx_lock, flags);
 
 			if (copy_to_user((char*)arg, &dflow, sizeof(dflow)))
 				return -EFAULT;
@@ -2162,7 +2150,7 @@
 				return -EFAULT;
 
 			if(dflow.startc != startc || dflow.stopc != stopc) {
-				cli();
+				spin_lock_irqsave(&pcxx_lock, flags);
 				globalwinon(ch);
 
 				if(cmd == DIGI_SETFLOW) {
@@ -2179,7 +2167,7 @@
 					pcxe_start(tty);
 
 				memoff(ch);
-				restore_flags(flags);
+				spin_unlock_irqrestore(&pcxx_lock, flags);
 			}
 			break;
 
@@ -2196,8 +2184,7 @@
 
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&pcxx_lock, flags);
 		globalwinon(info);
 		pcxxparam(tty,info);
 		memoff(info);
@@ -2208,7 +2195,7 @@
 		if(!(old_termios->c_cflag & CLOCAL) &&
 			(tty->termios->c_cflag & CLOCAL))
 			wake_up_interruptible(&info->open_wait);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&pcxx_lock, flags);
 	}
 }
 
@@ -2237,15 +2224,14 @@
 
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
-		save_flags(flags); 
-		cli();
+		spin_lock_irqsave(&pcxx_lock, flags);
 		if ((info->statusflags & TXSTOPPED) == 0) {
 			globalwinon(info);
 			fepcmd(info, PAUSETX, 0, 0, 0, 0);
 			info->statusflags |= TXSTOPPED;
 			memoff(info);
 		}
-		restore_flags(flags);
+		spin_unlock_irqrestore(&pcxx_lock, flags);
 	}
 }
 
@@ -2255,15 +2241,14 @@
 
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&pcxx_lock, flags);
 		if ((info->statusflags & RXSTOPPED) == 0) {
 			globalwinon(info);
 			fepcmd(info, PAUSERX, 0, 0, 0, 0);
 			info->statusflags |= RXSTOPPED;
 			memoff(info);
 		}
-		restore_flags(flags);
+		spin_unlock_irqrestore(&pcxx_lock, flags);
 	}
 }
 
@@ -2275,8 +2260,7 @@
 		unsigned long flags;
 
 		/* Just in case output was resumed because of a change in Digi-flow */
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&pcxx_lock, flags);
 		if(info->statusflags & RXSTOPPED) {
 			volatile struct board_chan *bc;
 			globalwinon(info);
@@ -2285,7 +2269,7 @@
 			info->statusflags &= ~RXSTOPPED;
 			memoff(info);
 		}
-		restore_flags(flags);
+		spin_unlock_irqrestore(&pcxx_lock, flags);
 	}
 }
 
@@ -2297,8 +2281,7 @@
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&pcxx_lock, flags);
 		/* Just in case output was resumed because of a change in Digi-flow */
 		if(info->statusflags & TXSTOPPED) {
 			volatile struct board_chan *bc;
@@ -2310,7 +2293,7 @@
 			info->statusflags &= ~TXSTOPPED;
 			memoff(info);
 		}
-		restore_flags(flags);
+		spin_unlock_irqrestore(&pcxx_lock, flags);
 	}
 }
 
@@ -2319,8 +2302,7 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 	globalwinon(ch);
 
 	/* 
@@ -2334,7 +2316,7 @@
 	fepcmd(ch, SENDBREAK, msec, 0, 10, 0);
 	memoff(ch);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 }
 
 static void setup_empty_event(struct tty_struct *tty, struct channel *ch)
@@ -2342,12 +2324,11 @@
 	volatile struct board_chan *bc;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&pcxx_lock, flags);
 	globalwinon(ch);
 	ch->statusflags |= EMPTYWAIT;
 	bc = ch->brdchan;
 	bc->iempty = 1;
 	memoff(ch);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pcxx_lock, flags);
 }
