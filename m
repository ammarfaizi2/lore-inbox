Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVAPOFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVAPOFd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVAPOEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:04:33 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:14290 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262514AbVAPNxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:53:35 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135331.30109.34015.41638@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 10/13] pcxx: remove cli()/sti() in drivers/char/pcxx.c
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:53:31 -0600
Date: Sun, 16 Jan 2005 07:53:32 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/pcxx.c linux-2.6.11-rc1-mm1/drivers/char/pcxx.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/pcxx.c	2004-12-24 16:35:00.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/pcxx.c	2005-01-16 07:32:19.508528433 -0500
@@ -209,8 +209,7 @@
 
 	printk(KERN_NOTICE "Unloading PC/Xx version %s\n", VERSION);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	del_timer_sync(&pcxx_timer);
 
 	if ((e1 = tty_unregister_driver(pcxe_driver)))
@@ -219,7 +218,7 @@
 	put_tty_driver(pcxe_driver);
 	cleanup_board_resources();
 	kfree(digi_channels);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static inline struct channel *chan(register struct tty_struct *tty)
@@ -323,12 +322,12 @@
 	info->blocked_open++;
 
 	for (;;) {
-		cli();
+		local_irq_disable();
 		globalwinon(info);
 		info->omodem |= DTR|RTS;
 		fepcmd(info, SETMODEM, DTR|RTS, 0, 10, 1);
 		memoff(info);
-		sti();
+		local_irq_enable();
 		set_current_state(TASK_INTERRUPTIBLE);
 		if(tty_hung_up_p(filp) || (info->asyncflags & ASYNC_INITIALIZED) == 0) {
 			if(info->asyncflags & ASYNC_HUP_NOTIFY)
@@ -404,8 +403,7 @@
 			return -ERESTARTSYS;
 	}
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	ch->count++;
 	tty->driver_data = ch;
 	ch->tty = tty;
@@ -428,7 +426,7 @@
 		memoff(ch);
 		ch->asyncflags |= ASYNC_INITIALIZED;
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if(ch->asyncflags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&ch->close_wait);
@@ -463,8 +461,7 @@
 	if (!(info->asyncflags & ASYNC_INITIALIZED)) 
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(info);
 
 	bc = info->brdchan;
@@ -483,7 +480,7 @@
 
 	memoff(info);
 	info->asyncflags &= ~ASYNC_INITIALIZED;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -493,14 +490,12 @@
 
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 
-		if(tty_hung_up_p(filp)) {
+		if(tty_hung_up_p(filp))
 			/* flag that somebody is done with this module */
-			restore_flags(flags);
-			return;
-		}
+			goto out;
+
 		/* this check is in serial.c, it won't hurt to do it here too */
 		if ((tty->count == 1) && (info->count != 1)) {
 			/*
@@ -513,10 +508,9 @@
 			printk("pcxe_close: bad serial port count; tty->count is 1, info->count is %d\n", info->count);
 			info->count = 1;
 		}
-		if (info->count-- > 1) {
-			restore_flags(flags);
-			return;
-		}
+		if (info->count-- > 1)
+			goto out;
+
 		if (info->count < 0) {
 			info->count = 0;
 		}
@@ -544,7 +538,7 @@
 		}
 		info->asyncflags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 		wake_up_interruptible(&info->close_wait);
-		restore_flags(flags);
+out:		local_irq_restore(flags);
 	}
 }
 
@@ -556,15 +550,14 @@
 	if ((ch=chan(tty))!=NULL) {
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		shutdown(ch);
 		ch->event = 0;
 		ch->count = 0;
 		ch->tty = NULL;
 		ch->asyncflags &= ~ASYNC_NORMAL_ACTIVE;
 		wake_up_interruptible(&ch->open_wait);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 }
 
@@ -590,8 +583,7 @@
 	 */
 
 	total = 0;
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 	head = bc->tin & (size - 1);
 	tail = bc->tout;
@@ -629,7 +621,7 @@
 		bc->ilow = 1;
 	}
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	
 	return(total);
 }
@@ -653,8 +645,7 @@
 		unsigned int head, tail;
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		globalwinon(ch);
 
 		bc = ch->brdchan;
@@ -672,7 +663,7 @@
 			bc->ilow = 1;
 		}
 		memoff(ch);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
 	return remain;
@@ -691,8 +682,7 @@
 	if ((ch=chan(tty))==NULL)
 		return(0);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 
 	bc = ch->brdchan;
@@ -718,7 +708,7 @@
 	}
 
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(chars);
 }
@@ -734,8 +724,7 @@
 	if ((ch=chan(tty))==NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	globalwinon(ch);
 	bc = ch->brdchan;
@@ -743,7 +732,7 @@
 	fepcmd(ch, STOUT, (unsigned) tail, 0, 0, 0);
 
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	tty_wakeup(tty);
 }
@@ -755,11 +744,10 @@
 	if ((ch=chan(tty))!=NULL) {
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		if ((ch->statusflags & TXBUSY) && !(ch->statusflags & EMPTYWAIT))
 			setup_empty_event(tty,ch);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 }
 
@@ -1512,8 +1500,7 @@
 	struct channel *ch;
 	struct board_info *bd;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	for(crd=0; crd < numcards; crd++) {
 		bd = &boards[crd];
@@ -1536,7 +1523,7 @@
 	}
 
 	mod_timer(&pcxx_timer, jiffies + HZ/25);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void doevent(int crd)
@@ -1940,12 +1927,11 @@
 		return(-EINVAL);
 	}
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 	mstat = bc->mstat;
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if(mstat & DTR)
 		mflag |= TIOCM_DTR;
@@ -1978,8 +1964,7 @@
 		return(-EINVAL);
 	}
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	/*
 	 * I think this modemfake stuff is broken.  It doesn't
 	 * correctly reflect the behaviour desired by the TIOCM*
@@ -2005,7 +1990,7 @@
 	globalwinon(ch);
 	pcxxparam(tty,ch);
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -2028,8 +2013,6 @@
 		return(-EINVAL);
 	}
 
-	save_flags(flags);
-
 	switch(cmd) {
 		case TCSBRK:	/* SVID version: non-zero arg --> no break */
 			retval = tty_check_change(tty);
@@ -2074,21 +2057,21 @@
 			return pcxe_tiocmset(tty, file, mstat, ~mstat);
 
 		case TIOCSDTR:
-			cli();
+			local_irq_save(flags);
 			ch->omodem |= DTR;
 			globalwinon(ch);
 			fepcmd(ch, SETMODEM, DTR, 0, 10, 1);
 			memoff(ch);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			break;
 
 		case TIOCCDTR:
 			ch->omodem &= ~DTR;
-			cli();
+			local_irq_save(flags);
 			globalwinon(ch);
 			fepcmd(ch, SETMODEM, 0, DTR, 10, 1);
 			memoff(ch);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			break;
 
 		case DIGI_GETA:
@@ -2123,16 +2106,16 @@
 				ch->dsr = DSR;
 			}
 		
-			cli();
+			local_irq_save(flags);
 			globalwinon(ch);
 			pcxxparam(tty,ch);
 			memoff(ch);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			break;
 
 		case DIGI_GETFLOW:
 		case DIGI_GETAFLOW:
-			cli();	
+			local_irq_save(flags);	
 			globalwinon(ch);
 			if(cmd == DIGI_GETFLOW) {
 				dflow.startc = bc->startc;
@@ -2142,7 +2125,7 @@
 				dflow.stopc = bc->stopca;
 			}
 			memoff(ch);
-			restore_flags(flags);
+			local_irq_restore(flags);
 
 			if (copy_to_user((char*)arg, &dflow, sizeof(dflow)))
 				return -EFAULT;
@@ -2162,7 +2145,7 @@
 				return -EFAULT;
 
 			if(dflow.startc != startc || dflow.stopc != stopc) {
-				cli();
+				local_irq_save(flags);
 				globalwinon(ch);
 
 				if(cmd == DIGI_SETFLOW) {
@@ -2179,7 +2162,7 @@
 					pcxe_start(tty);
 
 				memoff(ch);
-				restore_flags(flags);
+				local_irq_restore(flags);
 			}
 			break;
 
@@ -2196,8 +2179,7 @@
 
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		globalwinon(info);
 		pcxxparam(tty,info);
 		memoff(info);
@@ -2208,7 +2190,7 @@
 		if(!(old_termios->c_cflag & CLOCAL) &&
 			(tty->termios->c_cflag & CLOCAL))
 			wake_up_interruptible(&info->open_wait);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 }
 
@@ -2237,15 +2219,14 @@
 
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
-		save_flags(flags); 
-		cli();
+		local_irq_save(flags); 
 		if ((info->statusflags & TXSTOPPED) == 0) {
 			globalwinon(info);
 			fepcmd(info, PAUSETX, 0, 0, 0, 0);
 			info->statusflags |= TXSTOPPED;
 			memoff(info);
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 }
 
@@ -2255,15 +2236,14 @@
 
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		if ((info->statusflags & RXSTOPPED) == 0) {
 			globalwinon(info);
 			fepcmd(info, PAUSERX, 0, 0, 0, 0);
 			info->statusflags |= RXSTOPPED;
 			memoff(info);
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 }
 
@@ -2275,8 +2255,7 @@
 		unsigned long flags;
 
 		/* Just in case output was resumed because of a change in Digi-flow */
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		if(info->statusflags & RXSTOPPED) {
 			volatile struct board_chan *bc;
 			globalwinon(info);
@@ -2285,7 +2264,7 @@
 			info->statusflags &= ~RXSTOPPED;
 			memoff(info);
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 }
 
@@ -2297,8 +2276,7 @@
 	if ((info=chan(tty))!=NULL) {
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		/* Just in case output was resumed because of a change in Digi-flow */
 		if(info->statusflags & TXSTOPPED) {
 			volatile struct board_chan *bc;
@@ -2310,7 +2288,7 @@
 			info->statusflags &= ~TXSTOPPED;
 			memoff(info);
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 }
 
@@ -2319,8 +2297,7 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 
 	/* 
@@ -2334,7 +2311,7 @@
 	fepcmd(ch, SENDBREAK, msec, 0, 10, 0);
 	memoff(ch);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void setup_empty_event(struct tty_struct *tty, struct channel *ch)
@@ -2342,12 +2319,11 @@
 	volatile struct board_chan *bc;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 	ch->statusflags |= EMPTYWAIT;
 	bc = ch->brdchan;
 	bc->iempty = 1;
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
