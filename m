Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266535AbUG0UC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUG0UC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUG0UC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:02:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25516 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266535AbUG0UAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:00:20 -0400
Date: Tue, 27 Jul 2004 15:59:39 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Initial bits to help pull jiffies out of drivers
Message-ID: <20040727195939.GA20712@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is really for comment, the basic idea is to add some relative
timer functionality. This gives us timeout objects as well as pulling
jiffies use into one place in the timer code. The need for the old
interfaces never goes away however because some code uses a previous
event base to construct timeouts to avoid sliding due to the latency
between service and re-addition.

(please cc me on comments)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/amiserial.c linux-2.6.8-rc2/drivers/char/amiserial.c
--- linux.vanilla-2.6.8-rc2/drivers/char/amiserial.c	2004-07-27 19:21:10.210292240 +0100
+++ linux-2.6.8-rc2/drivers/char/amiserial.c	2004-07-27 13:36:28.000000000 +0100
@@ -1587,8 +1587,9 @@
 static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 	struct async_struct * info = (struct async_struct *)tty->driver_data;
-	unsigned long orig_jiffies, char_time;
+	unsigned long char_time;
 	int lsr;
+	struct timer_list t;
 
 	if (serial_paranoia_check(info, tty->name, "rs_wait_until_sent"))
 		return;
@@ -1596,7 +1597,6 @@
 	if (info->xmit_fifo_size == 0)
 		return; /* Just in case.... */
 
-	orig_jiffies = jiffies;
 	/*
 	 * Set the check interval to be 1/5 of the estimated time to
 	 * send a single character, and make it at least 1.  The check
@@ -1622,24 +1622,30 @@
 	 */
 	if (!timeout || timeout > 2*info->timeout)
 		timeout = 2*info->timeout;
+	init_timer(&t);
+	t.expires = timeout;
+	t.function = timer_noop;
+	
+	add_timeout(&t);
+
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 	printk("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
-	printk("jiff=%lu...", jiffies);
 #endif
 	while(!((lsr = custom.serdatr) & SDR_TSRE)) {
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
-		printk("serdatr = %d (jiff=%lu)...", lsr, jiffies);
+		printk("serdatr = %d ...", lsr);
 #endif
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
-		if (timeout && time_after(jiffies, orig_jiffies + timeout))
+		if (timeout && !timer_pending(&t))
 			break;
 	}
+	del_timeout(&t);
 	current->state = TASK_RUNNING;
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
-	printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
+	printk("lsr = %d ...done\n", lsr);
 #endif
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/cyclades.c linux-2.6.8-rc2/drivers/char/cyclades.c
--- linux.vanilla-2.6.8-rc2/drivers/char/cyclades.c	2004-07-27 19:22:42.715229352 +0100
+++ linux-2.6.8-rc2/drivers/char/cyclades.c	2004-07-27 12:40:46.000000000 +0100
@@ -959,10 +959,10 @@
 #ifdef CONFIG_CYZ_INTR
     if (test_and_clear_bit(Cy_EVENT_Z_RX_FULL, &info->event)) {
 	if (cyz_rx_full_timer[info->line].function == NULL) {
-	    cyz_rx_full_timer[info->line].expires = jiffies + 1;
+	    cyz_rx_full_timer[info->line].expires = 1;
 	    cyz_rx_full_timer[info->line].function = cyz_rx_restart;
 	    cyz_rx_full_timer[info->line].data = (unsigned long)info;
-	    add_timer(&cyz_rx_full_timer[info->line]);
+	    add_timeout(&cyz_rx_full_timer[info->line]);
 	}
     }
 #endif
@@ -1908,17 +1908,17 @@
 static void
 cyz_poll(unsigned long arg)
 {
-  struct cyclades_card *cinfo;
-  struct cyclades_port *info;
-  struct tty_struct *tty;
-  static volatile struct FIRM_ID *firm_id;
-  static volatile struct ZFW_CTRL *zfw_ctrl;
-  static volatile struct BOARD_CTRL *board_ctrl;
-  static volatile struct CH_CTRL *ch_ctrl;
-  static volatile struct BUF_CTRL *buf_ctrl;
-  int card, port;
+	struct cyclades_card *cinfo;
+	struct cyclades_port *info;
+	struct tty_struct *tty;
+	static volatile struct FIRM_ID *firm_id;
+	static volatile struct ZFW_CTRL *zfw_ctrl;
+	static volatile struct BOARD_CTRL *board_ctrl;
+	static volatile struct CH_CTRL *ch_ctrl;
+	static volatile struct BUF_CTRL *buf_ctrl;
+	int card, port;
 
-    cyz_timerlist.expires = jiffies + (HZ);
+    cyz_timerlist.expires = HZ;
     for (card = 0 ; card < NR_CARDS ; card++){
 	cinfo = &cy_card[card];
 
@@ -1951,9 +1951,9 @@
 	    cyz_handle_tx(info, ch_ctrl, buf_ctrl);
 	}
 	/* poll every 'cyz_polling_cycle' period */
-	cyz_timerlist.expires = jiffies + cyz_polling_cycle;
+	cyz_timerlist.expires = cyz_polling_cycle;
     }
-    add_timer(&cyz_timerlist);
+    add_timeout(&cyz_timerlist);
 
     return;
 } /* cyz_poll */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/ds1286.c linux-2.6.8-rc2/drivers/char/ds1286.c
--- linux.vanilla-2.6.8-rc2/drivers/char/ds1286.c	2004-07-27 19:22:42.737226008 +0100
+++ linux-2.6.8-rc2/drivers/char/ds1286.c	2004-07-27 13:41:38.000000000 +0100
@@ -434,8 +434,7 @@
 static void ds1286_get_time(struct rtc_time *rtc_tm)
 {
 	unsigned char save_control;
-	unsigned int flags;
-	unsigned long uip_watchdog = jiffies;
+	unsigned long flags;
 
 	/*
 	 * read RTC once any update in progress is done. The update
@@ -448,8 +447,7 @@
 	 */
 
 	if (ds1286_is_updating() != 0)
-		while (jiffies - uip_watchdog < 2*HZ/100)
-			barrier();
+		mdelay(20);
 
 	/*
 	 * Only the values that we read from the RTC are set. We leave
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/dtlk.c linux-2.6.8-rc2/drivers/char/dtlk.c
--- linux.vanilla-2.6.8-rc2/drivers/char/dtlk.c	2004-07-27 19:22:42.738225856 +0100
+++ linux-2.6.8-rc2/drivers/char/dtlk.c	2004-07-27 13:39:33.000000000 +0100
@@ -241,12 +241,6 @@
 	unsigned long expires;
 
 	TRACE_TEXT(" dtlk_poll");
-	/*
-	   static long int j;
-	   printk(".");
-	   printk("<%ld>", jiffies-j);
-	   j=jiffies;
-	 */
 	poll_wait(file, &dtlk_process_list, wait);
 
 	if (dtlk_has_indexing && dtlk_readable()) {
@@ -260,8 +254,8 @@
 	/* there are no exception conditions */
 
 	/* There won't be any interrupts, so we set a timer instead. */
-	expires = jiffies + 3*HZ / 100;
-	mod_timer(&dtlk_timer, expires);
+	expires = 3*HZ / 100;
+	mod_timeout(&dtlk_timer, expires);
 
 	return mask;
 }
@@ -385,7 +379,7 @@
 static int dtlk_readable(void)
 {
 #ifdef TRACING
-	printk(" dtlk_readable=%u@%u", inb_p(dtlk_port_lpc) != 0x7f, jiffies);
+	printk(" dtlk_readable=%u", inb_p(dtlk_port_lpc) != 0x7f);
 #endif
 	return inb_p(dtlk_port_lpc) != 0x7f;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/epca.c linux-2.6.8-rc2/drivers/char/epca.c
--- linux.vanilla-2.6.8-rc2/drivers/char/epca.c	2004-07-27 19:21:10.262284336 +0100
+++ linux-2.6.8-rc2/drivers/char/epca.c	2004-07-27 13:37:00.000000000 +0100
@@ -1806,7 +1806,7 @@
 
 	init_timer(&epca_timer);
 	epca_timer.function = epcapoll;
-	mod_timer(&epca_timer, jiffies + HZ/25);
+	mod_timeout(&epca_timer, HZ/25);
 
 	restore_flags(flags);
 
@@ -2155,7 +2155,7 @@
 
 	} /* End for each card */
 
-	mod_timer(&epca_timer, jiffies + (HZ / 25));
+	mod_timeout(&epca_timer, (HZ / 25));
 
 	restore_flags(flags);
 } /* End epcapoll */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/isicom.c linux-2.6.8-rc2/drivers/char/isicom.c
--- linux.vanilla-2.6.8-rc2/drivers/char/isicom.c	2004-07-27 19:21:11.907034296 +0100
+++ linux-2.6.8-rc2/drivers/char/isicom.c	2004-07-27 13:38:51.000000000 +0100
@@ -153,12 +153,13 @@
 								
 			inw(base+0x8);
 			
-			for(t=jiffies+HZ/100;time_before(jiffies, t););
+			msleep(10);
 				
 			outw(0,base+0x8); /* Reset */
 			
 			for(j=1;j<=3;j++) {
-				for(t=jiffies+HZ;time_before(jiffies, t););
+			{
+				msleep(1000);
 				printk(".");
 			}	
 			signature=(inw(base+0x4)) & 0xff;	
@@ -465,10 +466,10 @@
 	if (!re_schedule)	
 		return;
 	init_timer(&tx);
-	tx.expires = jiffies + HZ/100;
+	tx.expires = HZ/100;
 	tx.data = 0;
 	tx.function = isicom_tx;
-	add_timer(&tx);
+	add_timeout(&tx);
 	
 	return;	
 }		
@@ -1894,11 +1895,11 @@
 	}
 	
 	init_timer(&tx);
-	tx.expires = jiffies + 1;
+	tx.expires = 1;
 	tx.data = 0;
 	tx.function = isicom_tx;
 	re_schedule = 1;
-	add_timer(&tx);
+	add_timeout(&tx);
 	
 	return 0;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/moxa.c linux-2.6.8-rc2/drivers/char/moxa.c
--- linux.vanilla-2.6.8-rc2/drivers/char/moxa.c	2004-07-27 19:21:12.611927136 +0100
+++ linux-2.6.8-rc2/drivers/char/moxa.c	2004-07-27 13:34:10.000000000 +0100
@@ -363,9 +363,9 @@
 
 	init_timer(&moxaTimer);
 	moxaTimer.function = moxa_poll;
-	moxaTimer.expires = jiffies + (HZ / 50);
+	moxaTimer.expires = (HZ / 50);
 	moxaTimer_on = 1;
-	add_timer(&moxaTimer);
+	add_timeout(&moxaTimer);
 
 	/* Find the boards defined in source code */
 	numBoards = 0;
@@ -927,9 +927,9 @@
 
 	if (MoxaDriverPoll() < 0) {
 		moxaTimer.function = moxa_poll;
-		moxaTimer.expires = jiffies + (HZ / 50);
+		moxaTimer.expires = HZ / 50;
 		moxaTimer_on = 1;
-		add_timer(&moxaTimer);
+		add_timeout(&moxaTimer);
 		return;
 	}
 	for (card = 0; card < MAX_BOARDS; card++) {
@@ -973,9 +973,9 @@
 	}
 
 	moxaTimer.function = moxa_poll;
-	moxaTimer.expires = jiffies + (HZ / 50);
+	moxaTimer.expires = HZ / 50;
 	moxaTimer_on = 1;
-	add_timer(&moxaTimer);
+	add_timeout(&moxaTimer);
 }
 
 /******************************************************************************/
@@ -1101,9 +1101,9 @@
 	ch->statusflags |= EMPTYWAIT;
 	moxaEmptyTimer_on[ch->port] = 0;
 	del_timer(&moxaEmptyTimer[ch->port]);
-	moxaEmptyTimer[ch->port].expires = jiffies + HZ;
+	moxaEmptyTimer[ch->port].expires = HZ;
 	moxaEmptyTimer_on[ch->port] = 1;
-	add_timer(&moxaEmptyTimer[ch->port]);
+	add_timeout(&moxaEmptyTimer[ch->port]);
 	restore_flags(flags);
 }
 
@@ -1123,9 +1123,9 @@
 			wake_up_interruptible(&ch->tty->write_wait);
 			return;
 		}
-		moxaEmptyTimer[ch->port].expires = jiffies + HZ;
+		moxaEmptyTimer[ch->port].expires = HZ;
 		moxaEmptyTimer_on[ch->port] = 1;
-		add_timer(&moxaEmptyTimer[ch->port]);
+		add_timeout(&moxaEmptyTimer[ch->port]);
 	} else
 		ch->statusflags &= ~EMPTYWAIT;
 }
@@ -2668,10 +2668,10 @@
 	ofsAddr = moxaTableAddr[port];
 	if (ms100) {
 		moxafunc(ofsAddr, FC_SendBreak, Magic_code);
-		moxadelay(ms100 * (HZ / 10));
+		msleep(ms100 * 100);
 	} else {
 		moxafunc(ofsAddr, FC_SendBreak, Magic_code);
-		moxadelay(HZ / 4);	/* 250 ms */
+		msleep(250);
 	}
 	moxafunc(ofsAddr, FC_StopBreak, Magic_code);
 }
@@ -2742,17 +2742,6 @@
 /*****************************************************************************
  *	Static local functions: 					     *
  *****************************************************************************/
-/*
- * moxadelay - delays a specified number ticks
- */
-static void moxadelay(int tick)
-{
-	unsigned long st, et;
-
-	st = jiffies;
-	et = st + tick;
-	while (time_before(jiffies, et));
-}
 
 static void moxafunc(unsigned long ofsAddr, int cmd, ushort arg)
 {
@@ -2764,15 +2753,19 @@
 
 static void wait_finish(unsigned long ofsAddr)
 {
-	unsigned long i, j;
+	struct timer_list t;
+	init_timer(&t);
+	t.expires = moxaFuncTout;
+	t.function = timer_noop;
+	add_timeout(&t);	
 
-	i = jiffies;
 	while (readw(ofsAddr + FuncCode) != 0) {
 		j = jiffies;
-		if ((j - i) > moxaFuncTout) {
+		if (!timer_pending(&t)) {
 			return;
 		}
 	}
+	del_timeout(&t);
 }
 
 static void low_water_check(unsigned long ofsAddr)
@@ -2799,7 +2792,7 @@
 		return -EFAULT;
 	baseAddr = moxaBaseAddr[cardno];
 	writeb(HW_reset, baseAddr + Control_reg);	/* reset */
-	moxadelay(1);		/* delay 10 ms */
+	msleep(10);
 	for (i = 0; i < 4096; i++)
 		writeb(0, baseAddr + i);	/* clear fix page */
 	for (i = 0; i < len; i++)
@@ -2970,7 +2963,7 @@
 			for (i = 0; i < 100; i++) {
 				if (readw(baseAddr + C218_key) == keycode)
 					break;
-				moxadelay(1);	/* delay 10 ms */
+				msleep(10);	/* delay 10 ms */
 			}
 			if (readw(baseAddr + C218_key) != keycode) {
 				return (-1);
@@ -2982,7 +2975,7 @@
 		for (i = 0; i < 100; i++) {
 			if (readw(baseAddr + C218_key) == keycode)
 				break;
-			moxadelay(1);	/* delay 10 ms */
+			msleep(10);	/* delay 10 ms */
 		}
 		retry++;
 	} while ((readb(baseAddr + C218chksum_ok) != 1) && (retry < 3));
@@ -2993,7 +2986,7 @@
 	for (i = 0; i < 100; i++) {
 		if (readw(baseAddr + Magic_no) == Magic_code)
 			break;
-		moxadelay(1);	/* delay 10 ms */
+		msleep(10);	/* delay 10 ms */
 	}
 	if (readw(baseAddr + Magic_no) != Magic_code) {
 		return (-1);
@@ -3003,7 +2996,7 @@
 	for (i = 0; i < 100; i++) {
 		if (readw(baseAddr + Magic_no) == Magic_code)
 			break;
-		moxadelay(1);	/* delay 10 ms */
+		msleep(10);	/* delay 10 ms */
 	}
 	if (readw(baseAddr + Magic_no) != Magic_code) {
 		return (-1);
@@ -3045,7 +3038,7 @@
 			for (i = 0; i < 10; i++) {
 				if (readw(baseAddr + C320_key) == C320_KeyCode)
 					break;
-				moxadelay(1);
+				msleep(10);
 			}
 			if (readw(baseAddr + C320_key) != C320_KeyCode)
 				return (-1);
@@ -3056,7 +3049,7 @@
 		for (i = 0; i < 10; i++) {
 			if (readw(baseAddr + C320_key) == C320_KeyCode)
 				break;
-			moxadelay(1);
+			msleep(10);
 		}
 		retry++;
 	} while ((readb(baseAddr + C320chksum_ok) != 1) && (retry < 3));
@@ -3066,7 +3059,7 @@
 	for (i = 0; i < 600; i++) {
 		if (readw(baseAddr + Magic_no) == Magic_code)
 			break;
-		moxadelay(1);
+		msleep(10);
 	}
 	if (readw(baseAddr + Magic_no) != Magic_code)
 		return (-100);
@@ -3085,7 +3078,7 @@
 	for (i = 0; i < 500; i++) {
 		if (readw(baseAddr + Magic_no) == Magic_code)
 			break;
-		moxadelay(1);
+		msleep(10);
 	}
 	if (readw(baseAddr + Magic_no) != Magic_code)
 		return (-102);
@@ -3099,7 +3092,7 @@
 	for (i = 0; i < 600; i++) {
 		if (readw(baseAddr + Magic_no) == Magic_code)
 			break;
-		moxadelay(1);
+		msleep(10);
 	}
 	if (readw(baseAddr + Magic_no) != Magic_code)
 		return (-102);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/n_r3964.c linux-2.6.8-rc2/drivers/char/n_r3964.c
--- linux.vanilla-2.6.8-rc2/drivers/char/n_r3964.c	2004-07-27 19:22:42.762222208 +0100
+++ linux-2.6.8-rc2/drivers/char/n_r3964.c	2004-07-27 12:39:33.000000000 +0100
@@ -446,7 +446,7 @@
       pInfo->state = R3964_TX_REQUEST;
       pInfo->nRetry=0;
       pInfo->flags &= ~R3964_ERROR;
-      mod_timer(&pInfo->tmr, jiffies + R3964_TO_QVZ);
+      mod_timeout(&pInfo->tmr, R3964_TO_QVZ);
 
       spin_unlock_irqrestore(&pInfo->lock, flags);
 
@@ -474,7 +474,7 @@
       flush(pInfo);
       pInfo->state = R3964_TX_REQUEST;
       pInfo->nRetry++;
-      mod_timer(&pInfo->tmr, jiffies + R3964_TO_QVZ);
+      mod_timeout(&pInfo->tmr, R3964_TO_QVZ);
    }
    else
    {
@@ -533,7 +533,7 @@
          put_char(pInfo, pInfo->bcc);
       }
       pInfo->state = R3964_WAIT_FOR_TX_ACK;
-      mod_timer(&pInfo->tmr, jiffies + R3964_TO_QVZ);
+      mod_timeout(&pInfo->tmr, R3964_TO_QVZ);
    }
    flush(pInfo);
 }
@@ -569,7 +569,7 @@
       {
          pInfo->state=R3964_WAIT_FOR_RX_REPEAT;
          pInfo->nRetry++;
-	 mod_timer(&pInfo->tmr, jiffies + R3964_TO_RX_PANIC);
+	 mod_timeout(&pInfo->tmr, R3964_TO_RX_PANIC);
       }
       else
       {
@@ -668,7 +668,7 @@
             TRACE_PE("TRANSMITTING - got invalid char");
  
             pInfo->state = R3964_WAIT_ZVZ_BEFORE_TX_RETRY;
-	    mod_timer(&pInfo->tmr, jiffies + R3964_TO_ZVZ);
+	    mod_timeout(&pInfo->tmr, R3964_TO_ZVZ);
          }
          break;
       case R3964_WAIT_FOR_TX_ACK:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/nwbutton.c linux-2.6.8-rc2/drivers/char/nwbutton.c
--- linux.vanilla-2.6.8-rc2/drivers/char/nwbutton.c	2004-07-27 19:21:12.979871200 +0100
+++ linux-2.6.8-rc2/drivers/char/nwbutton.c	2004-07-27 12:38:43.000000000 +0100
@@ -154,8 +154,8 @@
 	button_press_count++;
 	init_timer (&button_timer);
 	button_timer.function = button_sequence_finished;
-	button_timer.expires = (jiffies + bdelay);
-	add_timer (&button_timer);
+	button_timer.expires = bdelay;
+	add_timeout(&button_timer);
 
 	return IRQ_HANDLED;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/nwflash.c linux-2.6.8-rc2/drivers/char/nwflash.c
--- linux.vanilla-2.6.8-rc2/drivers/char/nwflash.c	2004-07-27 19:21:12.049012712 +0100
+++ linux-2.6.8-rc2/drivers/char/nwflash.c	2004-07-27 13:14:49.000000000 +0100
@@ -354,8 +354,8 @@
 {
 	volatile unsigned int c1;
 	volatile unsigned char *pWritePtr;
-	unsigned long timeout;
 	int temp, temp1;
+	struct timer_list t;
 
 	/*
 	 * orange LED == erase
@@ -404,12 +404,16 @@
 	 */
 	flash_wait(HZ / 100);
 
+	init_timer(&t);
+	t.function = timer_noop;
+	t.expires = 10 * HZ;
+	add_timeout(&t);
+
 	/*
 	 * wait while erasing in process (up to 10 sec)
 	 */
-	timeout = jiffies + 10 * HZ;
 	c1 = 0;
-	while (!(c1 & 0x80) && time_before(jiffies, timeout)) {
+	while (!(c1 & 0x80) && timer_pending(&t)) {
 		flash_wait(HZ / 100);
 		/*
 		 * read any address
@@ -417,7 +421,8 @@
 		c1 = *(volatile unsigned char *) (pWritePtr);
 		//              printk("Flash_erase: status=%X.\n",c1);
 	}
-
+	del_timeout(&t);
+	
 	/*
 	 * set flash for normal read access
 	 */
@@ -469,6 +474,7 @@
 	unsigned int offset;
 	unsigned long timeout;
 	unsigned long timeout1;
+	struct timer_list t, t2;
 
 	/*
 	 * red LED == write
@@ -489,13 +495,22 @@
 	/*
 	 * wait up to 30 sec for this block
 	 */
-	timeout = jiffies + 30 * HZ;
+	 
+	init_timer(&t);
+	t.function = timer_noop;
+	init_timer(&t2);
+	t2.function = timer_noop;
+	t.expires = 30 * HZ;
+	add_timeout(&t);
 
 	for (offset = 0; offset < count; offset++, pWritePtr++) {
 		uAddress = (unsigned int) pWritePtr;
 		uAddress &= 0xFFFFFFFC;
 		if (__get_user(c2, buf + offset))
+		{
+			del_timeout(&t);
 			return -EFAULT;
+		}
 
 	  WriteRetry:
 	  	/*
@@ -533,26 +548,30 @@
 		/*
 		 * wait up to 1 sec for this byte
 		 */
-		timeout1 = jiffies + 1 * HZ;
+		t2.expires = 1 * HZ;
+		add_timeout(&t2);
 
 		/*
 		 * while not ready...
 		 */
-		while (!(c1 & 0x80) && time_before(jiffies, timeout1))
+		while (!(c1 & 0x80) && timer_pending(&t2))
 			c1 = *(volatile unsigned char *) (FLASH_BASE + 0x8000);
 
 		/*
 		 * if timeout getting status
 		 */
-		if (time_after_eq(jiffies, timeout1)) {
+		if (!timer_pending(&t2)) {
 			kick_open();
 			/*
 			 * reset err
 			 */
 			*(volatile unsigned char *) (FLASH_BASE + 0x8000) = 0x50;
 
+			/* t2 is already expired.. */
 			goto WriteRetry;
 		}
+		del_timeout(&t2);
+		
 		/*
 		 * switch on read access, as a default flash operation mode
 		 */
@@ -576,7 +595,7 @@
 			/*
 			 * before timeout?
 			 */
-			if (time_before(jiffies, timeout)) {
+			if (timer_pending(&t)) {
 				if (flashdebug)
 					printk(KERN_DEBUG "write_block: Retrying write at 0x%X)n",
 					       pWritePtr - FLASH_BASE);
@@ -601,12 +620,15 @@
 				/*
 				 * return error -2
 				 */
+				del_timeout(&t);
 				return -2;
 
 			}
 		}
 	}
 
+	del_timeout(&t);
+	
 	/*
 	 * green LED == read/verify
 	 */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/pcxx.c linux-2.6.8-rc2/drivers/char/pcxx.c
--- linux.vanilla-2.6.8-rc2/drivers/char/pcxx.c	2004-07-27 19:21:12.736908136 +0100
+++ linux-2.6.8-rc2/drivers/char/pcxx.c	2004-07-27 13:29:21.000000000 +0100
@@ -1548,7 +1548,7 @@
 	/*
 	 * Start up the poller to check for events on all enabled boards
 	 */
-	mod_timer(&pcxx_timer, HZ/25);
+	mod_timeout(&pcxx_timer, HZ/25);
 
 	if (verbose)
 		printk(KERN_NOTICE "PC/Xx: Driver with %d card(s) ready.\n", enabled_cards);
@@ -1593,7 +1593,7 @@
 		memoff(ch);
 	}
 
-	mod_timer(&pcxx_timer, jiffies + HZ/25);
+	mod_timeout(&pcxx_timer, HZ/25);
 	restore_flags(flags);
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/rocket.c linux-2.6.8-rc2/drivers/char/rocket.c
--- linux.vanilla-2.6.8-rc2/drivers/char/rocket.c	2004-07-27 19:22:42.768221296 +0100
+++ linux-2.6.8-rc2/drivers/char/rocket.c	2004-07-27 13:28:04.000000000 +0100
@@ -553,7 +553,7 @@
 	 * Reset the timer so we get called at the next clock tick (10ms).
 	 */
 	if (atomic_read(&rp_num_ports_open))
-		mod_timer(&rocket_timer, jiffies + POLL_PERIOD);
+		mod_timeout(&rocket_timer, POLL_PERIOD);
 }
 
 /*
@@ -1001,7 +1001,7 @@
 		}
 	}
 	/*  Starts (or resets) the maint polling loop */
-	mod_timer(&rocket_timer, jiffies + POLL_PERIOD);
+	mod_timeout(&rocket_timer, POLL_PERIOD);
 
 	retval = block_til_ready(tty, filp, info);
 	if (retval) {
@@ -1502,19 +1502,22 @@
 {
 	struct r_port *info = (struct r_port *) tty->driver_data;
 	CHANNEL_t *cp;
-	unsigned long orig_jiffies;
 	int check_time, exit_time;
 	int txcnt;
+	struct timer_list t;
 
 	if (rocket_paranoia_check(info, "rp_wait_until_sent"))
 		return;
 
 	cp = &info->channel;
 
-	orig_jiffies = jiffies;
+	init_timer(&t);
+	t.function = timer_noop;
+	t.expires = timeout;
+	add_timeout(&t);
+
 #ifdef ROCKET_DEBUG_WAIT_UNTIL_SENT
-	printk(KERN_INFO "In RP_wait_until_sent(%d) (jiff=%lu)...", timeout,
-	       jiffies);
+	printk(KERN_INFO "In RP_wait_until_sent(%d)...", timeout);
 	printk(KERN_INFO "cps=%d...", info->cps);
 #endif
 	while (1) {
@@ -1527,11 +1530,14 @@
 			check_time = HZ * txcnt / info->cps;
 		}
 		if (timeout) {
-			exit_time = orig_jiffies + timeout - jiffies;
-			if (exit_time <= 0)
+			if (!timer_pending(&t))
 				break;
+/* FIXME: Does this check actually matter anyway ? Do we need an
+   upstream "time_remaining(&t)) */
+#if 0
 			if (exit_time < check_time)
 				check_time = exit_time;
+#endif				
 		}
 		if (check_time == 0)
 			check_time = 1;
@@ -1543,9 +1549,10 @@
 		if (signal_pending(current))
 			break;
 	}
+	del_timeout(&t);
 	current->state = TASK_RUNNING;
 #ifdef ROCKET_DEBUG_WAIT_UNTIL_SENT
-	printk(KERN_INFO "txcnt = %d (jiff=%lu)...done\n", txcnt, jiffies);
+	printk(KERN_INFO "txcnt = %d ...done\n", txcnt);
 #endif
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/rtc.c linux-2.6.8-rc2/drivers/char/rtc.c
--- linux.vanilla-2.6.8-rc2/drivers/char/rtc.c	2004-07-27 19:22:42.769221144 +0100
+++ linux-2.6.8-rc2/drivers/char/rtc.c	2004-07-27 12:37:54.000000000 +0100
@@ -239,7 +239,7 @@
 	}
 
 	if (rtc_status & RTC_TIMER_ON)
-		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
+		mod_timeout(&rtc_irq_timer, HZ/rtc_freq + 2*HZ/100);
 
 	spin_unlock (&rtc_lock);
 
@@ -422,8 +422,8 @@
 
 		if (!(rtc_status & RTC_TIMER_ON)) {
 			spin_lock_irq (&rtc_lock);
-			rtc_irq_timer.expires = jiffies + HZ/rtc_freq + 2*HZ/100;
-			add_timer(&rtc_irq_timer);
+			rtc_irq_timer.expires = HZ/rtc_freq + 2*HZ/100;
+			add_timeout(&rtc_irq_timer);
 			rtc_status |= RTC_TIMER_ON;
 			spin_unlock_irq (&rtc_lock);
 		}
@@ -1096,7 +1096,7 @@
 
 	/* Just in case someone disabled the timer from behind our back... */
 	if (rtc_status & RTC_TIMER_ON)
-		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
+		mod_timeout(&rtc_irq_timer,HZ/rtc_freq + 2*HZ/100);
 
 	rtc_irq_data += ((rtc_freq/HZ)<<8);
 	rtc_irq_data &= ~0xff;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/scan_keyb.c linux-2.6.8-rc2/drivers/char/scan_keyb.c
--- linux.vanilla-2.6.8-rc2/drivers/char/scan_keyb.c	2004-07-27 19:21:12.734908440 +0100
+++ linux-2.6.8-rc2/drivers/char/scan_keyb.c	2004-07-27 12:33:23.000000000 +0100
@@ -30,8 +30,8 @@
 	int length;
 };
 
-static int scan_jiffies=0;
-static struct scan_keyboard *keyboards=NULL;
+static int scan_jiffies = 0;
+static struct scan_keyboard *keyboards = NULL;
 struct timer_list scan_timer;
 
 static void check_kbd(const unsigned char *table,
@@ -89,10 +89,10 @@
 	}
 
 	init_timer(&scan_timer);
-	scan_timer.expires = jiffies + SCANHZ;
+	scan_timer.expires = SCANHZ;
 	scan_timer.data = 0;
 	scan_timer.function = scan_kbd;
-	add_timer(&scan_timer);
+	add_timeout(&scan_timer);
 }
 
 
@@ -140,10 +140,10 @@
 void __init scan_kbd_init(void)
 {
 	init_timer(&scan_timer);
-	scan_timer.expires = jiffies + SCANHZ;
+	scan_timer.expires = SCANHZ;
 	scan_timer.data = 0;
 	scan_timer.function = scan_kbd;
-	add_timer(&scan_timer);
+	add_timeout(&scan_timer);
 
 	printk(KERN_INFO "Generic scan keyboard driver initialized\n");
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/specialix.c linux-2.6.8-rc2/drivers/char/specialix.c
--- linux.vanilla-2.6.8-rc2/drivers/char/specialix.c	2004-07-27 19:21:12.146997816 +0100
+++ linux-2.6.8-rc2/drivers/char/specialix.c	2004-07-27 13:23:20.000000000 +0100
@@ -306,18 +306,6 @@
 }
 
 	
-/* Must be called with enabled interrupts */
-/* Ugly. Very ugly. Don't use this for anything else than initialization 
-   code */
-static inline void sx_long_delay(unsigned long delay)
-{
-	unsigned long i;
-	
-	for (i = jiffies + delay; time_after(i, jiffies); ) ;
-}
-
-
-
 /* Set the IRQ using the RTS lines that run to the PAL on the board.... */
 int sx_set_irq ( struct specialix_board *bp)
 {
@@ -356,7 +344,7 @@
 	sx_wait_CCR_off(bp);			   /* Wait for CCR ready        */
 	sx_out_off(bp, CD186x_CCR, CCR_HARDRESET);      /* Reset CD186x chip          */
 	sti();
-	sx_long_delay(HZ/20);                      /* Delay 0.05 sec            */
+	msleep(HZ/20); 		                     /* Delay 0.05 sec            */
 	cli();
 	sx_out_off(bp, CD186x_GIVR, SX_ID);             /* Set ID for this chip      */
 	sx_out_off(bp, CD186x_GICR, 0);                 /* Clear all bits            */
@@ -408,8 +396,8 @@
 		sx_interrupt (((struct specialix_board *)data)->irq, 
 		              NULL, NULL);
 	}
-	missed_irq_timer.expires = jiffies + HZ;
-	add_timer (&missed_irq_timer);
+	missed_irq_timer.expires = HZ;
+	add_timeout(&missed_irq_timer);
 }
 #endif
 
@@ -474,7 +462,7 @@
 		sx_wait_CCR(bp);
 		sx_out(bp, CD186x_CCR, CCR_TXEN);        /* Enable transmitter     */
 		sx_out(bp, CD186x_IER, IER_TXRDY);       /* Enable tx empty intr   */
-		sx_long_delay(HZ/20);	       		
+		msleep(HZ/20);	       		
 		irqs = probe_irq_off(irqs);
 
 #if SPECIALIX_DEBUG > 2
@@ -540,8 +528,8 @@
 	init_timer (&missed_irq_timer);
 	missed_irq_timer.function = missed_irq;
 	missed_irq_timer.data = (unsigned long) bp;
-	missed_irq_timer.expires = jiffies + HZ;
-	add_timer (&missed_irq_timer);
+	missed_irq_timer.expires = HZ;
+	add_timeout(&missed_irq_timer);
 #endif
 
 	printk(KERN_INFO"sx%d: specialix IO8+ board detected at 0x%03x, IRQ %d, CD%d Rev. %c.\n",
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/stallion.c linux-2.6.8-rc2/drivers/char/stallion.c
--- linux.vanilla-2.6.8-rc2/drivers/char/stallion.c	2004-07-27 19:22:42.774220384 +0100
+++ linux-2.6.8-rc2/drivers/char/stallion.c	2004-07-27 12:36:48.000000000 +0100
@@ -1848,7 +1848,9 @@
 static void stl_waituntilsent(struct tty_struct *tty, int timeout)
 {
 	stlport_t	*portp;
-	unsigned long	tend;
+	struct timer     t;
+	
+	timer_init(&t);
 
 #if DEBUG
 	printk("stl_waituntilsent(tty=%x,timeout=%d)\n", (int) tty, timeout);
@@ -1862,15 +1864,19 @@
 
 	if (timeout == 0)
 		timeout = HZ;
-	tend = jiffies + timeout;
+
+	t.expires = timeout;
+	t.function = timer_noop;
+	add_timeout(&t);
 
 	while (stl_datastate(portp)) {
 		if (signal_pending(current))
 			break;
 		stl_delay(2);
-		if (time_after_eq(jiffies, tend))
+		if (!timeout_pending(&t))
 			break;
 	}
+	del_timeout(&t);
 }
 
 /*****************************************************************************/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/sx.c linux-2.6.8-rc2/drivers/char/sx.c
--- linux.vanilla-2.6.8-rc2/drivers/char/sx.c	2004-07-27 19:21:12.799898560 +0100
+++ linux-2.6.8-rc2/drivers/char/sx.c	2004-07-27 12:34:32.000000000 +0100
@@ -1295,8 +1295,8 @@
 
 	init_timer(&board->timer);
 
-	board->timer.expires = jiffies + sx_poll;
-	add_timer (&board->timer);
+	board->timer.expires = sx_poll;
+	add_timeout (&board->timer);
 	func_exit ();
 }
 
@@ -1514,7 +1514,7 @@
 			sx_dprintk (SX_DEBUG_CLOSE, "sent the force_close command.\n");
 	}
 
-	sx_dprintk (SX_DEBUG_CLOSE, "waited %d jiffies for close. count=%d\n", 
+	sx_dprintk (SX_DEBUG_CLOSE, "waited %d jiffies for close. count=%d\n",
 	            5 * HZ - to - 1, port->gs.count);
 
 	if(port->gs.count) {
@@ -2013,8 +2013,8 @@
 		if (board->poll) {
 			board->timer.data = (unsigned long) board;
 			board->timer.function = sx_pollfunc;
-			board->timer.expires = jiffies + board->poll;
-			add_timer (&board->timer);
+			board->timer.expires = board->poll;
+			add_timeout(&board->timer);
 		}
 	} else {
 		board->irq = 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/synclink.c linux-2.6.8-rc2/drivers/char/synclink.c
--- linux.vanilla-2.6.8-rc2/drivers/char/synclink.c	2004-07-27 19:21:12.192990824 +0100
+++ linux-2.6.8-rc2/drivers/char/synclink.c	2004-07-27 13:21:17.000000000 +0100
@@ -3296,6 +3296,7 @@
 {
 	struct mgsl_struct * info = (struct mgsl_struct *)tty->driver_data;
 	unsigned long orig_jiffies, char_time;
+	struct timer_list t;
 
 	if (!info )
 		return;
@@ -3324,9 +3325,16 @@
 			char_time++;
 	} else
 		char_time = 1;
+	
+	init_timer(&t);
+	t.expires = timeout;
+	t.function = timer_noop;
 		
 	if (timeout)
+	{
 		char_time = MIN(char_time, timeout);
+		add_timeout(&t);
+	}
 		
 	if ( info->params.mode == MGSL_MODE_HDLC ||
 		info->params.mode == MGSL_MODE_RAW ) {
@@ -3335,7 +3343,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && time_after(jiffies, orig_jiffies + timeout))
+			if (timeout && !timer_pending(&t))
 				break;
 		}
 	} else {
@@ -3345,10 +3353,11 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && time_after(jiffies, orig_jiffies + timeout))
+			if (timeout && !timer_pending(&t))
 				break;
 		}
 	}
+	del_timeout(&t);
       
 exit:
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -4187,7 +4196,7 @@
 				info->get_tx_holding_index=0;
 
 			/* restart transmit timer */
-			mod_timer(&info->tx_timer, jiffies + jiffies_from_ms(5000));
+			mod_timeout(&info->tx_timer, jiffies_from_ms(5000));
 
 			ret = 1;
 		}
@@ -5819,8 +5828,8 @@
 			
 			usc_TCmd( info, TCmd_SendFrame );
 			
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
-			add_timer(&info->tx_timer);	
+			info->tx_timer.expires = jiffies_from_ms(5000);
+			add_timeout(&info->tx_timer);	
 		}
 		info->tx_active = 1;
 	}
@@ -7246,9 +7255,9 @@
 	char *TmpPtr;
 	BOOLEAN rc = TRUE;
 	unsigned short status=0;
-	unsigned long EndTime;
 	unsigned long flags;
 	MGSL_PARAMS tmp_params;
+	struct timer_list t;
 
 	/* save current port options */
 	memcpy(&tmp_params,&info->params,sizeof(MGSL_PARAMS));
@@ -7353,10 +7362,13 @@
 	/*************************************************************/
 
 	/* Wait 100ms for interrupt. */
-	EndTime = jiffies + jiffies_from_ms(100);
+	init_timer(&t);
+	t.expires = jiffies_from_ms(100);
+	t.function = timer_noop;
+	add_timeout(&t);
 
 	for(;;) {
-		if (time_after(jiffies, EndTime)) {
+		if (!timer_pending(&t)) {
 			rc = FALSE;
 			break;
 		}
@@ -7369,6 +7381,7 @@
 			/* INITG (BIT 4) is inactive (no entry read in progress) AND */
 			/* BUSY  (BIT 5) is active (channel still active). */
 			/* This means the buffer entry read has completed. */
+			del_timer(&t);
 			break;
 		}
 	}
@@ -7409,10 +7422,11 @@
 	/**********************************/
 	
 	/* Wait 100ms */
-	EndTime = jiffies + jiffies_from_ms(100);
+	t.expires = jiffies_from_ms(100);
+	add_timeout(&t);
 
 	for(;;) {
-		if (time_after(jiffies, EndTime)) {
+		if (!timer_pending(&t)) {
 			rc = FALSE;
 			break;
 		}
@@ -7431,6 +7445,7 @@
 					break;
 			}
 	}
+	del_timeout(&t);
 
 
 	if ( rc == TRUE )
@@ -7451,7 +7466,8 @@
 		/******************************/
 
 		/* Wait 100ms */
-		EndTime = jiffies + jiffies_from_ms(100);
+		t.expires = jiffies_from_ms(100);
+		add_timeout(&t);
 
 		/* While timer not expired wait for transmit complete */
 
@@ -7460,7 +7476,7 @@
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
 		while ( !(status & (BIT6+BIT5+BIT4+BIT2+BIT1)) ) {
-			if (time_after(jiffies, EndTime)) {
+			if (!timer_pending(&t)) {
 				rc = FALSE;
 				break;
 			}
@@ -7470,6 +7486,7 @@
 			spin_unlock_irqrestore(&info->irq_spinlock,flags);
 		}
 	}
+	del_timeout(&t);
 
 
 	if ( rc == TRUE ){
@@ -7482,17 +7499,19 @@
 		/* WAIT FOR RECEIVE COMPLETE */
 
 		/* Wait 100ms */
-		EndTime = jiffies + jiffies_from_ms(100);
+		t.expires = jiffies_from_ms(100);
+		add_timeout(&t);
 
 		/* Wait for 16C32 to write receive status to buffer entry. */
 		status=info->rx_buffer_list[0].status;
 		while ( status == 0 ) {
-			if (time_after(jiffies, EndTime)) {
+			if (!timer_pending(&t)) {
 				rc = FALSE;
 				break;
 			}
 			status=info->rx_buffer_list[0].status;
 		}
+		del_timeout(&t);
 	}
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/synclinkmp.c linux-2.6.8-rc2/drivers/char/synclinkmp.c
--- linux.vanilla-2.6.8-rc2/drivers/char/synclinkmp.c	2004-07-27 19:22:42.777219928 +0100
+++ linux-2.6.8-rc2/drivers/char/synclinkmp.c	2004-07-27 13:15:19.000000000 +0100
@@ -1127,7 +1127,8 @@
 {
 	SLMP_INFO * info = (SLMP_INFO *)tty->driver_data;
 	unsigned long orig_jiffies, char_time;
-
+	struct timer_list t;
+	
 	if (!info )
 		return;
 
@@ -1141,7 +1142,9 @@
 	if (!(info->flags & ASYNC_INITIALIZED))
 		goto exit;
 
-	orig_jiffies = jiffies;
+	init_timer(&t);
+	t.function = timer_noop;
+	t.expires = timeout;
 
 	/* Set check interval to 1/5 of estimated time to
 	 * send a character, and make it at least 1. The check
@@ -1157,15 +1160,18 @@
 		char_time = 1;
 
 	if (timeout)
+	{
 		char_time = MIN(char_time, timeout);
-
+		add_timeout(t);
+	}
+	
 	if ( info->params.mode == MGSL_MODE_HDLC ) {
 		while (info->tx_active) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && time_after(jiffies, orig_jiffies + timeout))
+			if (timeout && !timer_pending(&t)))
 				break;
 		}
 	} else {
@@ -1176,10 +1182,11 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && time_after(jiffies, orig_jiffies + timeout))
+			if (timeout && !timer_pending(&t)))
 				break;
 		}
 	}
+	del_timeout(t);
 
 exit:
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -2573,8 +2580,8 @@
 
 	change_params(info);
 
-	info->status_timer.expires = jiffies + jiffies_from_ms(10);
-	add_timer(&info->status_timer);
+	info->status_timer.expires = jiffies_from_ms(10);
+	add_timeout(&info->status_timer);
 
 	if (info->tty)
 		clear_bit(TTY_IO_ERROR, &info->tty->flags);
@@ -4129,8 +4136,8 @@
 			write_reg(info, TXDMA + DIR, 0x40);		/* enable Tx DMA interrupts (EOM) */
 			write_reg(info, TXDMA + DSR, 0xf2);		/* clear Tx DMA IRQs, enable Tx DMA */
 	
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
-			add_timer(&info->tx_timer);
+			info->tx_timer.expires = jiffies_from_ms(5000);
+			add_timeout(&info->tx_timer);
 		}
 		else {
 			tx_load_fifo(info);
@@ -5424,8 +5431,8 @@
 
 	info->status_timer.data = (unsigned long)info;
 	info->status_timer.function = status_timeout;
-	info->status_timer.expires = jiffies + jiffies_from_ms(10);
-	add_timer(&info->status_timer);
+	info->status_timer.expires = jiffies_from_ms(10);
+	add_timeout(&info->status_timer);
 }
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/tpqic02.c linux-2.6.8-rc2/drivers/char/tpqic02.c
--- linux.vanilla-2.6.8-rc2/drivers/char/tpqic02.c	2004-07-27 19:21:12.650921208 +0100
+++ linux-2.6.8-rc2/drivers/char/tpqic02.c	2004-07-27 13:15:05.000000000 +0100
@@ -511,9 +511,10 @@
 /* Wait for a command to complete, with timeout */
 static int wait_for_ready(time_t timeout)
 {
+	struct timer_list t;
 	int stat;
 	unsigned long spin_t;
-
+	
 	/* Wait for ready or exception, without driving the loadavg up too much.
 	 * In most cases, the tape drive already has READY asserted,
 	 * so optimize for that case.
@@ -527,18 +528,23 @@
 		return TE_OK;	/* covers 99.99% of all calls */
 
 	/* Then use schedule() a few times */
-	spin_t = 3;		/* max 0.03 sec busy waiting */
-	if (spin_t > timeout)
-		spin_t = timeout;
-	timeout -= spin_t;
-	spin_t += jiffies;
+	
+	timer_init(&t);
+	t.function = timer_noop;
+	
+	t.expires = (3 * HZ) / 100;		/* max 0.03 sec busy waiting */
+	if (t.expires > timeout)
+		t.expires = timeout;
+	timeout -= t.expires;
+	
+	add_timeout(&t);
 
-	/* FIXME...*/
-	while (((stat = inb_p(QIC02_STAT_PORT) & QIC02_STAT_MASK) == QIC02_STAT_MASK)  && time_before(jiffies, spin_t))
+	while (((stat = inb_p(QIC02_STAT_PORT) & QIC02_STAT_MASK) == QIC02_STAT_MASK)  && timeout_pending(&t))
 	{
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);	/* don't waste all the CPU time */
 	}
+	del_timeout(&t);
 	if ((stat & QIC02_STAT_READY) == 0)
 		return TE_OK;
 
@@ -548,17 +554,21 @@
 	 * A interval of less than 0.10 sec will not be noticed by the user,
 	 * more than 0.40 sec may give noticeable delays.
 	 */
-	spin_t += timeout;
+
+	t.expires = timeout;
+	add_timeout(&t);
+	
 	TPQDEB({printk("wait_for_ready: additional timeout: %d\n", spin_t);})
 
 	    /* not ready and no exception && timeout not expired yet */
-	while (((stat = inb_p(QIC02_STAT_PORT) & QIC02_STAT_MASK) == QIC02_STAT_MASK) && time_before(jiffies, spin_t)) {
+	while (((stat = inb_p(QIC02_STAT_PORT) & QIC02_STAT_MASK) == QIC02_STAT_MASK) && timer_pending(&t)) {
 		/* be `nice` to other processes on long operations... */
 		current->state = TASK_INTERRUPTIBLE;
 		/* nap 0.30 sec between checks, */
 		/* but could be woken up earlier by signals... */
 		schedule_timeout(3 * HZ / 10);
 	}
+	del_timeout(&t);
 
 	/* don't use jiffies for this test because it may have changed by now */
 	if ((stat & QIC02_STAT_MASK) == QIC02_STAT_MASK) {
@@ -1254,16 +1264,12 @@
 			tpqputs(TPQD_ALWAYS, "Cartridge is write-protected.");
 			return -EACCES;
 		} else {
-			time_t t = jiffies;
-
 			/* Plain GNU mt(1) 2.2 erases a tape in O_RDONLY. :-( */
 			if (mode_access == READ)
 				return -EACCES;
 
-			/* FIXME */
 			/* give user a few seconds to pull out tape */
-			while (jiffies - t < 4 * HZ)
-				schedule();
+			msleep(4000);
 		}
 
 		/* don't bother writing filemark first */
@@ -1685,7 +1691,7 @@
 			wake_up(&qic02_tape_transfer);
 		} else {
 			/* start next transfer, account for track-switching time */
-			mod_timer(&tp_timer, jiffies + 6 * HZ);
+			mod_timeout(&tp_timer, 6 * HZ);
 			dma_transfer();
 		}
 	} else {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/char/vt.c linux-2.6.8-rc2/drivers/char/vt.c
--- linux.vanilla-2.6.8-rc2/drivers/char/vt.c	2004-07-27 19:22:42.782219168 +0100
+++ linux-2.6.8-rc2/drivers/char/vt.c	2004-07-27 12:22:49.000000000 +0100
@@ -2562,7 +2562,7 @@
 	console_timer.function = blank_screen_t;
 	if (blankinterval) {
 		blank_state = blank_normal_wait;
-		mod_timer(&console_timer, jiffies + blankinterval);
+		mod_timeout(&console_timer, blankinterval);
 	}
 
 	/*
@@ -2842,7 +2842,7 @@
 
 	if (vesa_off_interval) {
 		blank_state = blank_vesa_wait,
-		mod_timer(&console_timer, jiffies + vesa_off_interval);
+		mod_timeout(&console_timer, vesa_off_interval);
 	}
 
     	if (vesa_blank_mode)
@@ -2872,7 +2872,7 @@
 		return; /* but leave console_blanked != 0 */
 
 	if (blankinterval) {
-		mod_timer(&console_timer, jiffies + blankinterval);
+		mod_timeout(&console_timer, blankinterval);
 		blank_state = blank_normal_wait;
 	}
 
@@ -2923,7 +2923,7 @@
 	if (console_blanked)
 		unblank_screen();
 	else if (blankinterval) {
-		mod_timer(&console_timer, jiffies + blankinterval);
+		mod_timeout(&console_timer, blankinterval);
 		blank_state = blank_normal_wait;
 	}
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/include/linux/timer.h linux-2.6.8-rc2/include/linux/timer.h
--- linux.vanilla-2.6.8-rc2/include/linux/timer.h	2004-07-27 19:20:56.000000000 +0100
+++ linux-2.6.8-rc2/include/linux/timer.h	2004-07-27 18:50:27.000000000 +0100
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
+#include <linux/jiffies.h>
 
 struct tvec_t_base_s;
 
@@ -65,7 +66,8 @@
 extern int del_timer(struct timer_list * timer);
 extern int __mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
-
+extern int mod_timeout(struct timer_list *timer, unsigned long expires);
+extern void timer_noop(unsigned long unused);
 extern unsigned long next_timer_interrupt(void);
 
 /***
@@ -87,6 +89,30 @@
 	__mod_timer(timer, timer->expires);
 }
 
+/***
+ * add_timeout - start a timeout
+ * @timer: the timer to be added
+ *
+ * The kernel will do a ->function(->data) callback from the
+ * timer interrupt at the ->expired point in the future. The
+ * current time is added to the offset before the timer is
+ * inserted.
+ *
+ * The timer's ->expired, ->function (and if the handler uses it, ->data)
+ * fields must be set prior calling this function. If the timeout ->function
+ * is NULL the timeout will expire and no action will be taken.
+ */
+ 
+static inline void add_timeout(struct timer_list * timer)
+{
+	if(timer->function == NULL)
+		timer->function = timer_noop;
+	/* This will shift when we go tickless, for now the goal
+	   is to get jiffies in one place only */
+	timer->expires += jiffies;
+	__mod_timer(timer, timer->expires);
+}
+
 #ifdef CONFIG_SMP
   extern int del_timer_sync(struct timer_list *timer);
   extern int del_singleshot_timer_sync(struct timer_list *timer);
@@ -95,6 +121,10 @@
 # define del_singleshot_timer_sync(t) del_timer(t)
 #endif
 
+/* For API neatness only */
+#define del_timeout(t)	del_timer(t)
+#define timeout_pending(t) timer_pending(t)
+
 extern void init_timers(void);
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/kernel/timer.c linux-2.6.8-rc2/kernel/timer.c
--- linux.vanilla-2.6.8-rc2/kernel/timer.c	2004-07-27 19:22:53.046658736 +0100
+++ linux-2.6.8-rc2/kernel/timer.c	2004-07-27 18:51:13.000000000 +0100
@@ -211,7 +211,7 @@
 
 EXPORT_SYMBOL(__mod_timer);
 
-/***
+/**
  * add_timer_on - start a timer on a particular CPU
  * @timer: the timer to be added
  * @cpu: the CPU to start it on
@@ -233,9 +233,10 @@
 	spin_unlock_irqrestore(&base->lock, flags);
 }
 
-/***
+/**
  * mod_timer - modify a timer's timeout
  * @timer: the timer to be modified
+ * @expires: time of expiry
  *
  * mod_timer is a more efficient way to update the expire field of an
  * active timer (if the timer is inactive it will be activated)
@@ -269,7 +270,46 @@
 	return __mod_timer(timer, expires);
 }
 
-EXPORT_SYMBOL(mod_timer);
+/**
+ * mod_timeout - modify a timer's timeout
+ * @timer: the timer to be modified
+ * @expires: time of expiry relative to now
+ *
+ * mod_timer is a more efficient way to update the expire field of an
+ * active timer (if the timer is inactive it will be activated)
+ *
+ * mod_timer(timer, expires) is equivalent to:
+ *
+ *     del_timer(timer); timer->expires = expires; add_timer(timer);
+ *
+ * Note that if there are multiple unserialized concurrent users of the
+ * same timer, then mod_timer() is the only safe way to modify the timeout,
+ * since add_timer() cannot modify an already running timer.
+ *
+ * The function returns whether it has modified a pending timer or not.
+ * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
+ * active timer returns 1.)
+ */
+
+int mod_timeout(struct timer_list *timer, unsigned long expires)
+{
+	BUG_ON(!timer->function);
+
+	check_timer(timer);
+	expires += jiffies;
+
+	/*
+	 * This is a common optimization triggered by the
+	 * networking code - if the timer is re-modified
+	 * to be the same thing then just return:
+	 */
+	if (timer->expires == expires && timer_pending(timer))
+		return 1;
+
+	return __mod_timer(timer, expires);
+}
+
+EXPORT_SYMBOL(mod_timeout);
 
 /***
  * del_timer - deactive a timer.
@@ -411,7 +451,21 @@
 	return index;
 }
 
-/***
+/**
+ * timer_noop 	-	null timer function
+ * @unused: passed by callback
+ *
+ * This function provides a "no-op" for timers whose expiry is tested
+ * elsewhere but take no action when expiring
+ */
+ 
+void timer_noop(unsigned long unused)
+{
+}
+
+EXPORT_SYMBOL(timer_noop);
+
+/**
  * __run_timers - run all expired timers (if any) on this CPU.
  * @base: the timer vector to be processed.
  *
