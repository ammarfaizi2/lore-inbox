Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVAPNyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVAPNyc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVAPNyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:54:31 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:57731 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262504AbVAPNwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:52:35 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135230.30109.7624.88651@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 1/13] epca: remove cli()/sti() in drivers/char/epca.c
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:52:30 -0600
Date: Sun, 16 Jan 2005 07:52:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/epca.c linux-2.6.11-rc1-mm1/drivers/char/epca.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/epca.c	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/epca.c	2005-01-16 07:32:19.278559215 -0500
@@ -501,13 +501,11 @@
 	if ((ch = verifyChannel(tty)) != NULL) 
 	{ /* Begin if ch != NULL */
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 
 		if (tty_hung_up_p(filp)) 
 		{
-			restore_flags(flags);
-			return;
+			goto out;
 		}
 
 		/* Check to see if the channel is open more than once */
@@ -519,8 +517,7 @@
 				the channel.
 			---------------------------------------------------------------- */
 
-			restore_flags(flags);
-			return;
+			goto out;
 		} /* End channel is open more than once */
 
 		/* Port open only once go ahead with shutdown & reset */
@@ -572,8 +569,8 @@
 		                      ASYNC_CLOSING);
 		wake_up_interruptible(&ch->close_wait);
 
-
-		restore_flags(flags);
+out:
+		local_irq_restore(flags);
 
 	} /* End if ch != NULL */
 
@@ -591,8 +588,7 @@
 	if (!(ch->asyncflags & ASYNC_INITIALIZED)) 
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 
 	bc = ch->brdchan;
@@ -628,7 +624,7 @@
 	/* Prevent future Digi programmed interrupts from coming active */
 
 	ch->asyncflags &= ~ASYNC_INITIALIZED;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 } /* End shutdown */
 
@@ -649,8 +645,7 @@
 
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		if (tty->driver->flush_buffer)
 			tty->driver->flush_buffer(tty);
 		tty_ldisc_flush(tty);
@@ -659,7 +654,7 @@
 		ch->tty   = NULL;
 		ch->event = 0;
 		ch->count = 0;
-		restore_flags(flags);
+		local_irq_restore(flags);
 		ch->asyncflags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_INITIALIZED);
 		wake_up_interruptible(&ch->open_wait);
 
@@ -708,8 +703,7 @@
 	size = ch->txbufsize;
 
 	amountCopied = 0;
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	globalwinon(ch);
 
@@ -785,7 +779,7 @@
 		bc->ilow = 1;
 	}
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(amountCopied);
 
@@ -822,8 +816,7 @@
 
 	if ((ch = verifyChannel(tty)) != NULL) 
 	{
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		globalwinon(ch);
 
 		bc   = ch->brdchan;
@@ -844,7 +837,7 @@
 			bc->ilow = 1;
 		}
 		memoff(ch);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
 	/* Return how much room is left on card */
@@ -873,8 +866,7 @@
 	if ((ch = verifyChannel(tty)) == NULL)
 		return(0);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 
 	bc = ch->brdchan;
@@ -915,7 +907,7 @@
 	} /* End if some space on the card has been used */
 
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	/* Return number of characters residing on card. */
 	return(chars);
@@ -941,8 +933,7 @@
 	if ((ch = verifyChannel(tty)) == NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	globalwinon(ch);
 
@@ -954,7 +945,7 @@
 	fepcmd(ch, STOUT, (unsigned) tail, 0, 0, 0);
 
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	wake_up_interruptible(&tty->write_wait);
 	tty_wakeup(tty);
@@ -977,8 +968,7 @@
 	{
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 
 		/* ----------------------------------------------------------------
 			If not already set and the transmitter is busy setup an event
@@ -988,7 +978,7 @@
 		if ((ch->statusflags & TXBUSY) && !(ch->statusflags & EMPTYWAIT))
 			setup_empty_event(tty,ch);
 
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
 } /* End pc_flush_chars */
@@ -1047,15 +1037,13 @@
 	
 	retval = 0;
 	add_wait_queue(&ch->open_wait, &wait);
-	save_flags(flags);
-	cli();
-
+	local_irq_save(flags);
 
 	/* We dec count so that pc_close will know when to free things */
 	if (!tty_hung_up_p(filp))
 		ch->count--;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	ch->blocked_open++;
 
@@ -1096,10 +1084,10 @@
 
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&ch->open_wait, &wait);
-	cli();
+	local_irq_save(flags);
 	if (!tty_hung_up_p(filp))
 		ch->count++;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	ch->blocked_open--;
 
@@ -1200,8 +1188,7 @@
 		the tty->termios struct otherwise let pc_close handle it.
 	-------------------------------------------------------------------- */
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	globalwinon(ch);
 	ch->statusflags = 0;
@@ -1228,7 +1215,7 @@
 	ch->asyncflags |= ASYNC_INITIALIZED;
 	memoff(ch);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	retval = block_til_ready(tty, filp, ch);
 	if (retval)
@@ -1242,15 +1229,14 @@
 	--------------------------------------------------------------- */
 	ch->tty = tty;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 
 	/* Enable Digi Data events */
 	bc->idata = 1;
 
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 0;
 
@@ -1262,12 +1248,11 @@
 
 	unsigned long	flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	pc_init();
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(0);
 }
@@ -1292,15 +1277,13 @@
 
 	del_timer_sync(&epca_timer);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	if ((tty_unregister_driver(pc_driver)) ||  
 	    (tty_unregister_driver(pc_info)))
 	{
 		printk(KERN_WARNING "<Error> - DIGI : cleanup_module failed to un-register tty driver\n");
-		restore_flags(flags);
-		return;
+		goto out;
 	}
 	put_tty_driver(pc_driver);
 	put_tty_driver(pc_info);
@@ -1335,7 +1318,7 @@
 	pci_unregister_driver (&epca_driver);
 #endif
 
-	restore_flags(flags);
+out:	local_irq_restore(flags);
 
 }
 module_exit(epca_module_exit);
@@ -1499,8 +1482,7 @@
 	tty_set_operations(pc_info, &info_ops);
 
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	for (crd = 0; crd < num_cards; crd++) 
 	{ /* Begin for each card */
@@ -1635,7 +1617,7 @@
 	epca_timer.function = epcapoll;
 	mod_timer(&epca_timer, jiffies + HZ/25);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 0;
 
@@ -1943,8 +1925,7 @@
 		buffer empty) and acts on those events.
 	----------------------------------------------------------------------- */
 	
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	for (crd = 0; crd < num_cards; crd++) 
 	{ /* Begin for each card */
@@ -1984,7 +1965,7 @@
 
 	mod_timer(&epca_timer, jiffies + (HZ / 25));
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 } /* End epcapoll */
 
 /* --------------------- Begin doevent  ------------------------ */
@@ -2762,12 +2743,11 @@
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
 
 	if (mstat & ch->m_dtr)
 		mflag |= TIOCM_DTR;
@@ -2801,8 +2781,7 @@
 		return(-EINVAL);
 	}
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	/*
 	 * I think this modemfake stuff is broken.  It doesn't
 	 * correctly reflect the behaviour desired by the TIOCM*
@@ -2834,7 +2813,7 @@
 
 	epcaparam(tty,ch);
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -2859,8 +2838,6 @@
 		return(-EINVAL);
 	}
 
-	save_flags(flags);
-
 	/* -------------------------------------------------------------------
 		For POSIX compliance we need to add more ioctls.  See tty_ioctl.c
 		in /usr/src/linux/drivers/char for a good example.  In particular 
@@ -2936,20 +2913,20 @@
 
 		case TIOCSDTR:
 			ch->omodem |= ch->m_dtr;
-			cli();
+			local_irq_save(flags);
 			globalwinon(ch);
 			fepcmd(ch, SETMODEM, ch->m_dtr, 0, 10, 1);
 			memoff(ch);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			break;
 
 		case TIOCCDTR:
 			ch->omodem &= ~ch->m_dtr;
-			cli();
+			local_irq_save(flags);
 			globalwinon(ch);
 			fepcmd(ch, SETMODEM, 0, ch->m_dtr, 10, 1);
 			memoff(ch);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			break;
 
 		case DIGI_GETA:
@@ -2990,7 +2967,7 @@
 				ch->dsr = ch->m_dsr;
 			}
 		
-			cli();
+			local_irq_save(flags);
 			globalwinon(ch);
 
 			/* -----------------------------------------------------------------
@@ -3000,12 +2977,12 @@
 
 			epcaparam(tty,ch);
 			memoff(ch);
-			restore_flags(flags);
+			local_irq_restore(flags);
 			break;
 
 		case DIGI_GETFLOW:
 		case DIGI_GETAFLOW:
-			cli();	
+			local_irq_save(flags);	
 			globalwinon(ch);
 			if ((cmd) == (DIGI_GETFLOW)) 
 			{
@@ -3018,7 +2995,7 @@
 				dflow.stopc = bc->stopca;
 			}
 			memoff(ch);
-			restore_flags(flags);
+			local_irq_restore(flags);
 
 			if (copy_to_user(argp, &dflow, sizeof(dflow)))
 				return -EFAULT;
@@ -3042,7 +3019,7 @@
 
 			if (dflow.startc != startc || dflow.stopc != stopc) 
 			{ /* Begin  if setflow toggled */
-				cli();
+				local_irq_save(flags);
 				globalwinon(ch);
 
 				if ((cmd) == (DIGI_SETFLOW)) 
@@ -3062,7 +3039,7 @@
 					pc_start(tty);
 
 				memoff(ch);
-				restore_flags(flags);
+				local_irq_restore(flags);
 
 			} /* End if setflow toggled */
 			break;
@@ -3092,8 +3069,7 @@
 	if ((ch = verifyChannel(tty)) != NULL) 
 	{ /* Begin if channel valid */
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		globalwinon(ch);
 		epcaparam(tty, ch);
 		memoff(ch);
@@ -3106,7 +3082,7 @@
 			 (tty->termios->c_cflag & CLOCAL))
 			wake_up_interruptible(&ch->open_wait);
 
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 	} /* End if channel valid */
 
@@ -3163,8 +3139,7 @@
 	if ((ch = verifyChannel(tty)) != NULL) 
 	{ /* Begin if valid channel */
 
-		save_flags(flags); 
-		cli();
+		local_irq_save(flags); 
 
 		if ((ch->statusflags & TXSTOPPED) == 0) 
 		{ /* Begin if transmit stop requested */
@@ -3180,7 +3155,7 @@
 
 		} /* End if transmit stop requested */
 
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 	} /* End if valid channel */
 
@@ -3203,8 +3178,7 @@
 
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 
 		/* Just in case output was resumed because of a change in Digi-flow */
 		if (ch->statusflags & TXSTOPPED) 
@@ -3226,7 +3200,7 @@
 
 		} /* End transmit resume requested */
 
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 	} /* End if channel valid */
 
@@ -3257,8 +3231,7 @@
 	{ /* Begin if channel valid */
 
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 
 		if ((ch->statusflags & RXSTOPPED) == 0)
 		{
@@ -3268,7 +3241,7 @@
 			ch->statusflags |= RXSTOPPED;
 			memoff(ch);
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 	} /* End if channel valid */
 
@@ -3294,8 +3267,7 @@
 
 
 		/* Just in case output was resumed because of a change in Digi-flow */
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 
 		if (ch->statusflags & RXSTOPPED) 
 		{
@@ -3307,7 +3279,7 @@
 			ch->statusflags &= ~RXSTOPPED;
 			memoff(ch);
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 	} /* End if channel valid */
 
@@ -3320,8 +3292,7 @@
 
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 
 	/* -------------------------------------------------------------------- 
@@ -3335,7 +3306,7 @@
 	fepcmd(ch, SENDBREAK, msec, 0, 10, 0);
 	memoff(ch);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 } /* End digi_send_break */
 
@@ -3347,8 +3318,7 @@
 	volatile struct board_chan *bc = ch->brdchan;
 	unsigned long int flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	globalwinon(ch);
 	ch->statusflags |= EMPTYWAIT;
 	
@@ -3359,7 +3329,7 @@
 
 	bc->iempty = 1;
 	memoff(ch);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 } /* End setup_empty_event */
 
