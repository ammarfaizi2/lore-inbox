Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbTDCRF7 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261404AbTDCRF6 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:05:58 -0500
Received: from trained-monkey.org ([209.217.122.11]:5388 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id S261387AbTDCRFO 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:05:14 -0500
From: Jes Sorensen <jes@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16012.27749.781757.8312@trained-monkey.org>
Date: Thu, 3 Apr 2003 12:16:21 -0500
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [patch 2.4] make tty->count atomic_t
X-Mailer: VM 7.13 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I believe the 2.4 tty code is racey in the way it handles tty->count.
release_dev() does the tty->count-- thing without protecting against
parallel execution, hence tty->count can end up a random state as
tty->count-- isn't guaranteed to be atomic (load-store architectures and
architectures with weak memory ordering etc).

The easy way to solve the problem is to change tty->count to an
atomic_t.

Patch against 2.4.21-pre5-ac3, but also applies cleanly to 2.4.21-pre6.
I have tried to fix places referencing the counter, my apologies if I
missed any.

Comments, thoughts?

Cheers,
Jes


diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/arch/alpha/kernel/srmcons.c linux-2.4.21-pre5-ac3/arch/alpha/kernel/srmcons.c
--- linux-2.4.21-pre5-ac3-vanilla/arch/alpha/kernel/srmcons.c	Mon Mar 17 15:27:05 2003
+++ linux-2.4.21-pre5-ac3/arch/alpha/kernel/srmcons.c	Tue Mar 18 12:35:48 2003
@@ -260,7 +260,7 @@
 
 	spin_lock_irqsave(&srmconsp->lock, flags);
 
-	if (tty->count == 1) {
+	if (atomic_read(&tty->count) == 1) {
 		srmconsp->tty = NULL;
 		del_timer(&srmconsp->timer);
 	}
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/arch/cris/drivers/serial.c linux-2.4.21-pre5-ac3/arch/cris/drivers/serial.c
--- linux-2.4.21-pre5-ac3-vanilla/arch/cris/drivers/serial.c	Mon Mar 17 15:27:05 2003
+++ linux-2.4.21-pre5-ac3/arch/cris/drivers/serial.c	Tue Mar 18 12:37:31 2003
@@ -3293,7 +3293,7 @@
 	printk("[%d] rs_close ttyS%d, count = %d\n", current->pid, 
 	       info->line, info->count);
 #endif
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/arch/mips/au1000/common/serial.c linux-2.4.21-pre5-ac3/arch/mips/au1000/common/serial.c
--- linux-2.4.21-pre5-ac3-vanilla/arch/mips/au1000/common/serial.c	Thu Nov 28 18:53:09 2002
+++ linux-2.4.21-pre5-ac3/arch/mips/au1000/common/serial.c	Tue Mar 18 12:36:57 2003
@@ -195,7 +195,7 @@
 
 #if defined(MODULE) && defined(SERIAL_DEBUG_MCOUNT)
 #define DBG_CNT(s) printk("(%s): [%x] refc=%d, serc=%d, ttyc=%d -> %s\n", \
- kdevname(tty->device), (info->flags), serial_refcount,info->count,tty->count,s)
+ kdevname(tty->device), (info->flags), serial_refcount,info->count,atomic_read(&tty->count),s)
 #else
 #define DBG_CNT(s)
 #endif
@@ -1909,7 +1909,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_close ttys%d, count = %d\n", info->line, state->count);
 #endif
-	if ((tty->count == 1) && (state->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (state->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  state->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/arch/mips/baget/vacserial.c linux-2.4.21-pre5-ac3/arch/mips/baget/vacserial.c
--- linux-2.4.21-pre5-ac3-vanilla/arch/mips/baget/vacserial.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.21-pre5-ac3/arch/mips/baget/vacserial.c	Tue Mar 18 12:36:32 2003
@@ -29,7 +29,7 @@
   
 #if defined(MODULE) && defined(SERIAL_DEBUG_MCOUNT)
 #define DBG_CNT(s) baget_printk("(%s):[%x] refc=%d, serc=%d, ttyc=%d-> %s\n", \
-  kdevname(tty->device),(info->flags),serial_refcount,info->count,tty->count,s)
+  kdevname(tty->device),(info->flags),serial_refcount,info->count,atomic_read(&tty->count),s)
 #else
 #define DBG_CNT(s)
 #endif
@@ -1658,7 +1658,7 @@
 	baget_printk("rs_close ttys%d, count = %d\n", 
 		     info->line, state->count);
 #endif
-	if ((tty->count == 1) && (state->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (state->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  state->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/arch/ppc/8xx_io/uart.c linux-2.4.21-pre5-ac3/arch/ppc/8xx_io/uart.c
--- linux-2.4.21-pre5-ac3-vanilla/arch/ppc/8xx_io/uart.c	Mon Mar 17 15:27:07 2003
+++ linux-2.4.21-pre5-ac3/arch/ppc/8xx_io/uart.c	Tue Mar 18 12:37:16 2003
@@ -1678,7 +1678,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_close ttys%d, count = %d\n", info->line, state->count);
 #endif
-	if ((tty->count == 1) && (state->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (state->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  state->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/amiserial.c linux-2.4.21-pre5-ac3/drivers/char/amiserial.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/amiserial.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/amiserial.c	Tue Mar 18 12:25:02 2003
@@ -1544,7 +1544,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_close ttys%d, count = %d\n", info->line, state->count);
 #endif
-	if ((tty->count == 1) && (state->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (state->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  state->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/console.c linux-2.4.21-pre5-ac3/drivers/char/console.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/console.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/console.c	Tue Mar 18 12:10:49 2003
@@ -2393,7 +2393,7 @@
 		tty->winsize.ws_row = video_num_lines;
 		tty->winsize.ws_col = video_num_columns;
 	}
-	if (tty->count == 1)
+	if (atomic_read(&tty->count) == 1)
 		vcs_make_devfs (currcons, 0);
 	return 0;
 }
@@ -2402,7 +2402,7 @@
 {
 	if (!tty)
 		return;
-	if (tty->count != 1) return;
+	if (atomic_read(&tty->count) != 1) return;
 	vcs_make_devfs (MINOR (tty->device) - tty->driver.minor_start, 1);
 	tty->driver_data = 0;
 }
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/cyclades.c linux-2.4.21-pre5-ac3/drivers/char/cyclades.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/cyclades.c	Mon Mar 17 15:27:09 2003
+++ linux-2.4.21-pre5-ac3/drivers/char/cyclades.c	Tue Mar 18 12:25:33 2003
@@ -2822,7 +2822,7 @@
 #ifdef CY_DEBUG_OPEN
     printk("cyc:cy_close ttyC%d, count = %d\n", info->line, info->count);
 #endif
-    if ((tty->count == 1) && (info->count != 1)) {
+    if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
         /*
          * Uh, oh.  tty->count is 1, which means that the tty
          * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/dz.c linux-2.4.21-pre5-ac3/drivers/char/dz.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/dz.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/dz.c	Tue Mar 18 12:25:20 2003
@@ -1054,7 +1054,7 @@
 		restore_flags(flags);
 		return;
 	}
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/esp.c linux-2.4.21-pre5-ac3/drivers/char/esp.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/esp.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/esp.c	Tue Mar 18 12:25:53 2003
@@ -136,7 +136,7 @@
   
 #if defined(MODULE) && defined(SERIAL_DEBUG_MCOUNT)
 #define DBG_CNT(s) printk("(%s): [%x] refc=%d, serc=%d, ttyc=%d -> %s\n", \
- kdevname(tty->device), (info->flags), serial_refcount,info->count,tty->count,s)
+ kdevname(tty->device), (info->flags), serial_refcount,info->count,atomic_read(&tty->count),s)
 #else
 #define DBG_CNT(s)
 #endif
@@ -2051,7 +2051,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_close ttys%d, count = %d\n", info->line, info->count);
 #endif
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/generic_serial.c linux-2.4.21-pre5-ac3/drivers/char/generic_serial.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/generic_serial.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/generic_serial.c	Tue Mar 18 12:24:47 2003
@@ -753,7 +753,7 @@
 		return;
 	}
 
-	if ((tty->count == 1) && (port->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (port->count != 1)) {
 		printk(KERN_ERR "gs: gs_close: bad port count;"
 		       " tty->count is 1, port count is %d\n", port->count);
 		port->count = 1;
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/ip2main.c linux-2.4.21-pre5-ac3/drivers/char/ip2main.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/ip2main.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/ip2main.c	Tue Mar 18 12:26:32 2003
@@ -372,7 +372,7 @@
 #if defined(MODULE) && defined(IP2DEBUG_OPEN)
 #define DBG_CNT(s) printk(KERN_DEBUG "(%s): [%x] refc=%d, ttyc=%d, modc=%x -> %s\n", \
 		    kdevname(tty->device),(pCh->flags),ref_count, \
-		    tty->count,/*GET_USE_COUNT(module)*/0,s)
+		    atomic_read(&tty->count),/*GET_USE_COUNT(module)*/0,s)
 #else
 #define DBG_CNT(s)
 #endif
@@ -1740,7 +1740,7 @@
 noblock:
 
 	/* first open - Assign termios structure to port */
-	if ( tty->count == 1 ) {
+	if ( atomic_read(&tty->count) == 1 ) {
 		i2QueueCommands(PTYPE_INLINE, pCh, 0, 2, CMD_CTSFL_DSAB, CMD_RTSFL_DSAB);
 		if ( pCh->flags & ASYNC_SPLIT_TERMIOS ) {
 			if ( tty->driver.subtype == SERIAL_TYPE_NORMAL ) {
@@ -1805,7 +1805,7 @@
 
 		return;
 	}
-	if ( tty->count > 1 ) { /* not the last close */
+	if ( atomic_read(&tty->count) > 1 ) { /* not the last close */
 		MOD_DEC_USE_COUNT;
 
 		ip2trace (CHANN, ITRC_CLOSE, 2, 1, 3 );
@@ -3364,7 +3364,7 @@
 		pCh = DevTable[i];
 		if (pCh) {
 			tty = pCh->pTTY;
-			if (tty && tty->count) {
+			if (tty && atomic_read(&tty->count)) {
 				len += sprintf(buf+len,FMTLINE,i,(int)tty->flags,pCh->flags,
 									tty->termios->c_cflag,tty->termios->c_iflag);
 
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/isicom.c linux-2.4.21-pre5-ac3/drivers/char/isicom.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/isicom.c	Mon Mar 17 15:27:09 2003
+++ linux-2.4.21-pre5-ac3/drivers/char/isicom.c	Tue Mar 18 12:26:45 2003
@@ -1160,7 +1160,7 @@
 		return;
 	}
 	
-	if ((tty->count == 1) && (port->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (port->count != 1)) {
 		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port count"
 			"tty->count = 1	port count = %d.\n",
 			card->base, port->count);
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/istallion.c linux-2.4.21-pre5-ac3/drivers/char/istallion.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/istallion.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/istallion.c	Tue Mar 18 12:26:57 2003
@@ -1173,7 +1173,7 @@
 		restore_flags(flags);
 		return;
 	}
-	if ((tty->count == 1) && (portp->refcount != 1))
+	if ((atomic_read(&tty->count) == 1) && (portp->refcount != 1))
 		portp->refcount = 1;
 	if (portp->refcount-- > 1) {
 		MOD_DEC_USE_COUNT;
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/moxa.c linux-2.4.21-pre5-ac3/drivers/char/moxa.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/moxa.c	Thu Oct 25 16:53:47 2001
+++ linux-2.4.21-pre5-ac3/drivers/char/moxa.c	Tue Mar 18 12:27:10 2003
@@ -642,7 +642,7 @@
 	}
 	ch = (struct moxa_str *) tty->driver_data;
 
-	if ((tty->count == 1) && (ch->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (ch->count != 1)) {
 		printk("moxa_close: bad serial port count; tty->count is 1, "
 		       "ch->count is %d\n", ch->count);
 		ch->count = 1;
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/mxser.c linux-2.4.21-pre5-ac3/drivers/char/mxser.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/mxser.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/mxser.c	Tue Mar 18 12:27:22 2003
@@ -824,7 +824,7 @@
 		MOD_DEC_USE_COUNT;
 		return;
 	}
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.        tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/n_tty.c linux-2.4.21-pre5-ac3/drivers/char/n_tty.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/n_tty.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/n_tty.c	Tue Mar 18 12:14:51 2003
@@ -119,7 +119,7 @@
  */
 static void check_unthrottle(struct tty_struct * tty)
 {
-	if (tty->count &&
+	if (atomic_read(&tty->count) &&
 	    test_and_clear_bit(TTY_THROTTLED, &tty->flags) && 
 	    tty->driver.unthrottle)
 		tty->driver.unthrottle(tty);
@@ -1170,7 +1170,8 @@
 			retval = -ERESTARTSYS;
 			break;
 		}
-		if (tty_hung_up_p(file) || (tty->link && !tty->link->count)) {
+		if (tty_hung_up_p(file) ||
+		    (tty->link && !atomic_read(&tty->link->count))) {
 			retval = -EIO;
 			break;
 		}
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/pcxx.c linux-2.4.21-pre5-ac3/drivers/char/pcxx.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/pcxx.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/pcxx.c	Tue Mar 18 12:27:39 2003
@@ -581,7 +581,7 @@
 			return;
 		}
 		/* this check is in serial.c, it won't hurt to do it here too */
-		if ((tty->count == 1) && (info->count != 1)) {
+		if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 			/*
 			 * Uh, oh.  tty->count is 1, which means that the tty
 			 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/pty.c linux-2.4.21-pre5-ac3/drivers/char/pty.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/pty.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/pty.c	Tue Mar 18 13:35:58 2003
@@ -70,13 +70,18 @@
 
 static void pty_close(struct tty_struct * tty, struct file * filp)
 {
+	int count;
+
 	if (!tty)
 		return;
+
+	count = atomic_read(&tty->count);
 	if (tty->driver.subtype == PTY_TYPE_MASTER) {
-		if (tty->count > 1)
-			printk("master pty_close: count = %d!!\n", tty->count);
+		if (count > 1)
+			printk("master pty_close: count = %d!!\n",
+			       atomic_read(&tty->count));
 	} else {
-		if (tty->count > 2)
+		if (count > 2)
 			return;
 	}
 	wake_up_interruptible(&tty->read_wait);
@@ -329,7 +334,7 @@
 		goto out;
 	if (test_bit(TTY_PTY_LOCK, &tty->link->flags))
 		goto out;
-	if (tty->link->count != 1)
+	if (atomic_read(&tty->link->count) != 1)
 		goto out;
 
 	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/riscom8.c linux-2.4.21-pre5-ac3/drivers/char/riscom8.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/riscom8.c	Thu Sep 13 18:21:32 2001
+++ linux-2.4.21-pre5-ac3/drivers/char/riscom8.c	Tue Mar 18 12:27:53 2003
@@ -1142,7 +1142,7 @@
 		goto out;
 	
 	bp = port_Board(port);
-	if ((tty->count == 1) && (port->count != 1))  {
+	if ((atomic_read(&tty->count) == 1) && (port->count != 1))  {
 		printk(KERN_INFO "rc%d: rc_close: bad port count;"
 		       " tty->count is 1, port count is %d\n",
 		       board_No(bp), port->count);
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/rocket.c linux-2.4.21-pre5-ac3/drivers/char/rocket.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/rocket.c	Fri Sep 21 13:55:22 2001
+++ linux-2.4.21-pre5-ac3/drivers/char/rocket.c	Tue Mar 18 12:28:04 2003
@@ -1052,7 +1052,7 @@
 		restore_flags(flags);
 		return;
 	}
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/serial.c linux-2.4.21-pre5-ac3/drivers/char/serial.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/serial.c	Mon Mar 17 15:32:23 2003
+++ linux-2.4.21-pre5-ac3/drivers/char/serial.c	Tue Mar 18 12:23:06 2003
@@ -375,7 +375,7 @@
 
 #if defined(MODULE) && defined(SERIAL_DEBUG_MCOUNT)
 #define DBG_CNT(s) printk("(%s): [%x] refc=%d, serc=%d, ttyc=%d -> %s\n", \
- kdevname(tty->device), (info->flags), serial_refcount,info->count,tty->count,s)
+ kdevname(tty->device), (info->flags), serial_refcount,info->count,atomic_read(&tty->count),s)
 #else
 #define DBG_CNT(s)
 #endif
@@ -2797,7 +2797,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_close ttys%d, count = %d\n", info->line, state->count);
 #endif
-	if ((tty->count == 1) && (state->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (state->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  state->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/serial167.c linux-2.4.21-pre5-ac3/drivers/char/serial167.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/serial167.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/serial167.c	Tue Mar 18 12:28:13 2003
@@ -1877,7 +1877,7 @@
     printk("cy_close ttyS%d, count = %d\n", info->line, info->count);
 #endif
 
-    if ((tty->count == 1) && (info->count != 1)) {
+    if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 	/*
 	 * Uh, oh.  tty->count is 1, which means that the tty
 	 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/serial_amba.c linux-2.4.21-pre5-ac3/drivers/char/serial_amba.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/serial_amba.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/serial_amba.c	Tue Mar 18 12:28:28 2003
@@ -1404,7 +1404,7 @@
 		return;
 	}
 
-	if ((tty->count == 1) && (state->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (state->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  state->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/serial_txx927.c linux-2.4.21-pre5-ac3/drivers/char/serial_txx927.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/serial_txx927.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/serial_txx927.c	Tue Mar 18 12:29:07 2003
@@ -155,7 +155,7 @@
 
 #if defined(MODULE) && defined(SERIAL_DEBUG_MCOUNT)
 #define DBG_CNT(s) printk("(%s): [%x] refc=%d, serc=%d, ttyc=%d -> %s\n", \
- kdevname(tty->device), (info->flags), serial_refcount,info->count,tty->count,s)
+ kdevname(tty->device), (info->flags), serial_refcount,info->count,atomic_read(&tty->count),s)
 #else
 #define DBG_CNT(s)
 #endif                                     
@@ -1407,7 +1407,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_close ttys%d, count = %d\n", info->line, state->count);
 #endif
-	if ((tty->count == 1) && (state->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (state->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  state->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/specialix.c linux-2.4.21-pre5-ac3/drivers/char/specialix.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/specialix.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/specialix.c	Tue Mar 18 12:29:20 2003
@@ -1517,7 +1517,7 @@
 	}
 	
 	bp = port_Board(port);
-	if ((tty->count == 1) && (port->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (port->count != 1)) {
 		printk(KERN_ERR "sx%d: sx_close: bad port count;"
 		       " tty->count is 1, port count is %d\n",
 		       board_No(bp), port->count);
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/stallion.c linux-2.4.21-pre5-ac3/drivers/char/stallion.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/stallion.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/stallion.c	Tue Mar 18 12:29:31 2003
@@ -1197,7 +1197,7 @@
 		restore_flags(flags);
 		return;
 	}
-	if ((tty->count == 1) && (portp->refcount != 1))
+	if ((atomic_read(&tty->count) == 1) && (portp->refcount != 1))
 		portp->refcount = 1;
 	if (portp->refcount-- > 1) {
 		MOD_DEC_USE_COUNT;
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/synclink.c linux-2.4.21-pre5-ac3/drivers/char/synclink.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/synclink.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/synclink.c	Tue Mar 18 12:29:42 2003
@@ -3261,7 +3261,7 @@
 	if (!info->count || tty_hung_up_p(filp))
 		goto cleanup;
 			
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * tty->count is 1 and the tty structure will be freed.
 		 * info->count should be one in this case.
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/synclinkmp.c linux-2.4.21-pre5-ac3/drivers/char/synclinkmp.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/synclinkmp.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/synclinkmp.c	Tue Mar 18 12:30:00 2003
@@ -851,7 +851,7 @@
 	if (!info->count || tty_hung_up_p(filp))
 		goto cleanup;
 
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * tty->count is 1 and the tty structure will be freed.
 		 * info->count should be one in this case.
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/tty_io.c linux-2.4.21-pre5-ac3/drivers/char/tty_io.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/tty_io.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/tty_io.c	Tue Mar 18 13:23:31 2003
@@ -247,14 +247,15 @@
 	file_list_unlock();
 	if (tty->driver.type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver.subtype == PTY_TYPE_SLAVE &&
-	    tty->link && tty->link->count)
+	    tty->link && atomic_read(&tty->link->count))
 		count++;
-	if (tty->count != count) {
+	if (atomic_read(&tty->count) != count) {
 		printk(KERN_WARNING "Warning: dev (%s) tty->count(%d) "
 				    "!= #fd's(%d) in %s\n",
-		       kdevname(tty->device), tty->count, count, routine);
+		       kdevname(tty->device), atomic_read(&tty->count),
+		       count, routine);
 		return count;
-       }	
+	}
 #endif
 	return 0;
 }
@@ -904,7 +905,7 @@
 		o_tty->termios_locked = *o_ltp_loc;
 		(*driver->other->refcount)++;
 		if (driver->subtype == PTY_TYPE_MASTER)
-			o_tty->count++;
+			atomic_inc(&o_tty->count);
 
 		/* Establish the links in both directions */
 		tty->link   = o_tty;
@@ -925,7 +926,7 @@
 	tty->termios = *tp_loc;
 	tty->termios_locked = *ltp_loc;
 	(*driver->refcount)++;
-	tty->count++;
+	atomic_inc(&tty->count);
 
 	/* 
 	 * Structures all installed ... call the ldisc open routines.
@@ -964,13 +965,13 @@
 		 * special case for PTY masters: only one open permitted, 
 		 * and the slave side open count is incremented as well.
 		 */
-		if (tty->count) {
+		if (atomic_read(&tty->count)) {
 			retval = -EIO;
 			goto end_init;
 		}
-		tty->link->count++;
+		atomic_inc(&tty->link->count);
 	}
-	tty->count++;
+	atomic_inc(&tty->count);
 	tty->driver = *driver; /* N.B. why do this every time?? */
 
 success:
@@ -1094,7 +1095,7 @@
 
 #ifdef TTY_DEBUG_HANGUP
 	printk(KERN_DEBUG "release_dev of %s (tty count=%d)...",
-	       tty_name(tty, buf), tty->count);
+	       tty_name(tty, buf), atomic_read(&tty->count));
 #endif
 
 #ifdef TTY_PARANOIA_CHECK
@@ -1146,9 +1147,9 @@
 	 * each iteration we avoid any problems.
 	 */
 	while (1) {
-		tty_closing = tty->count <= 1;
+		tty_closing = atomic_read(&tty->count) <= 1;
 		o_tty_closing = o_tty &&
-			(o_tty->count <= (pty_master ? 1 : 0));
+			(atomic_read(&o_tty->count) <= (pty_master ? 1 : 0));
 		do_sleep = 0;
 
 		if (tty_closing) {
@@ -1185,17 +1186,20 @@
 	 * block, so it's safe to proceed with closing.
 	 */
 	if (pty_master) {
-		if (--o_tty->count < 0) {
+		atomic_dec(&o_tty->count);
+		if (atomic_read(&o_tty->count) < 0) {
 			printk(KERN_WARNING "release_dev: bad pty slave count "
 					    "(%d) for %s\n",
-			       o_tty->count, tty_name(o_tty, buf));
-			o_tty->count = 0;
+			       atomic_read(&o_tty->count),
+			       tty_name(o_tty, buf));
+			atomic_set(&o_tty->count, 0);
 		}
 	}
-	if (--tty->count < 0) {
+	atomic_dec(&tty->count);
+	if (atomic_read(&tty->count) < 0) {
 		printk(KERN_WARNING "release_dev: bad tty->count (%d) for %s\n",
-		       tty->count, tty_name(tty, buf));
-		tty->count = 0;
+		       atomic_read(&tty->count), tty_name(tty, buf));
+		atomic_set(&tty->count, 0);
 	}
 
 	/*
@@ -1414,7 +1418,7 @@
 	}
 	if ((tty->driver.type == TTY_DRIVER_TYPE_SERIAL) &&
 	    (tty->driver.subtype == SERIAL_TYPE_CALLOUT) &&
-	    (tty->count == 1)) {
+	    (atomic_read(&tty->count) == 1)) {
 		static int nr_warns;
 		if (nr_warns < 5) {
 			printk(KERN_WARNING "tty_io.c: "
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/char/vt.c linux-2.4.21-pre5-ac3/drivers/char/vt.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/char/vt.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.21-pre5-ac3/drivers/char/vt.c	Tue Mar 18 12:19:53 2003
@@ -40,7 +40,8 @@
 char vt_dont_switch;
 extern struct tty_driver console_driver;
 
-#define VT_IS_IN_USE(i)	(console_driver.table[i] && console_driver.table[i]->count)
+#define VT_IS_IN_USE(i)	(console_driver.table[i] && \
+			 atomic_read(&console_driver.table[i]->count))
 #define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || i == sel_cons)
 
 /*
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/isdn/isdn_tty.c linux-2.4.21-pre5-ac3/drivers/isdn/isdn_tty.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/isdn/isdn_tty.c	Fri Dec 21 12:41:54 2001
+++ linux-2.4.21-pre5-ac3/drivers/isdn/isdn_tty.c	Tue Mar 18 12:32:31 2003
@@ -1807,7 +1807,7 @@
 #endif
 		return;
 	}
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/macintosh/macserial.c linux-2.4.21-pre5-ac3/drivers/macintosh/macserial.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/macintosh/macserial.c	Fri Aug  2 20:39:44 2002
+++ linux-2.4.21-pre5-ac3/drivers/macintosh/macserial.c	Tue Mar 18 12:31:51 2003
@@ -1957,7 +1957,7 @@
 	}
 
 	OPNDBG("rs_close ttyS%d, count = %d\n", info->line, info->count);
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/net/wan/8253x/8253xsyn.c linux-2.4.21-pre5-ac3/drivers/net/wan/8253x/8253xsyn.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/net/wan/8253x/8253xsyn.c	Fri Aug  2 20:39:44 2002
+++ linux-2.4.21-pre5-ac3/drivers/net/wan/8253x/8253xsyn.c	Tue Mar 18 12:42:54 2003
@@ -1030,7 +1030,7 @@
 	}
 	
 #if 0
-	if ((tty->count == 1) && (port->count != 0)) 
+	if ((atomic_read(&tty->count) == 1) && (port->count != 0)) 
 	{
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/s390/char/con3215.c linux-2.4.21-pre5-ac3/drivers/s390/char/con3215.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/s390/char/con3215.c	Fri Aug  2 20:39:44 2002
+++ linux-2.4.21-pre5-ac3/drivers/s390/char/con3215.c	Tue Mar 18 12:32:54 2003
@@ -897,7 +897,7 @@
 	raw3215_info *raw;
 
 	raw = (raw3215_info *) tty->driver_data;
-	if (raw == NULL || tty->count > 1)
+	if (raw == NULL || atomic_read(&tty->count) > 1)
 		return;
 	tty->closing = 1;
 	/* Shutdown the terminal */
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/s390/char/hwc_tty.c linux-2.4.21-pre5-ac3/drivers/s390/char/hwc_tty.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/s390/char/hwc_tty.c	Wed Jul 25 17:12:02 2001
+++ linux-2.4.21-pre5-ac3/drivers/s390/char/hwc_tty.c	Tue Mar 18 12:33:06 2003
@@ -83,7 +83,7 @@
 			"do not close hwc tty because of wrong device number");
 		return;
 	}
-	if (tty->count > 1)
+	if (atomic_read(&tty->count) > 1)
 		return;
 
 	hwc_tty_data.tty = NULL;
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/s390/net/ctctty.c linux-2.4.21-pre5-ac3/drivers/s390/net/ctctty.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/s390/net/ctctty.c	Fri Aug  2 20:39:44 2002
+++ linux-2.4.21-pre5-ac3/drivers/s390/net/ctctty.c	Tue Mar 18 12:51:40 2003
@@ -1066,7 +1066,7 @@
 #endif
 		return;
 	}
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/sbus/char/aurora.c linux-2.4.21-pre5-ac3/drivers/sbus/char/aurora.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/sbus/char/aurora.c	Thu Nov 28 18:53:14 2002
+++ linux-2.4.21-pre5-ac3/drivers/sbus/char/aurora.c	Tue Mar 18 12:33:21 2003
@@ -1504,7 +1504,7 @@
 	}
 	
 	bp = port_Board(port);
-	if ((tty->count == 1) && (port->count != 1))  {
+	if ((atomic_read(&tty->count) == 1) && (port->count != 1))  {
 		printk(KERN_DEBUG "aurora%d: aurora_close: bad port count; "
 		       "tty->count is 1, port count is %d\n",
 		       board_No(bp), port->count);
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/sbus/char/sab82532.c linux-2.4.21-pre5-ac3/drivers/sbus/char/sab82532.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/sbus/char/sab82532.c	Fri Aug  2 20:39:44 2002
+++ linux-2.4.21-pre5-ac3/drivers/sbus/char/sab82532.c	Tue Mar 18 12:33:30 2003
@@ -1610,7 +1610,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("sab82532_close ttys%d, count = %d\n", info->line, info->count);
 #endif
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/sbus/char/su.c linux-2.4.21-pre5-ac3/drivers/sbus/char/su.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/sbus/char/su.c	Fri Aug  2 20:39:44 2002
+++ linux-2.4.21-pre5-ac3/drivers/sbus/char/su.c	Tue Mar 18 12:34:03 2003
@@ -39,7 +39,7 @@
 do {									\
 	printk("(%s): [%x] refc=%d, serc=%d, ttyc=%d -> %s\n",		\
 	       kdevname(tty->device), (info->flags), serial_refcount,	\
-	       info->count,tty->count,s);				\
+	       info->count,atomic_read(&tty->count),s);			\
 } while (0)
 #else
 #define DBG_CNT(s)
@@ -1756,7 +1756,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("su_close ttys%d, count = %d\n", info->line, info->count);
 #endif
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/sbus/char/zs.c linux-2.4.21-pre5-ac3/drivers/sbus/char/zs.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/sbus/char/zs.c	Fri Aug  2 20:39:44 2002
+++ linux-2.4.21-pre5-ac3/drivers/sbus/char/zs.c	Tue Mar 18 12:34:14 2003
@@ -1547,7 +1547,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("zs_close tty-%d, count = %d\n", info->line, info->count);
 #endif
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/sgi/char/sgiserial.c linux-2.4.21-pre5-ac3/drivers/sgi/char/sgiserial.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/sgi/char/sgiserial.c	Thu Nov 28 18:53:14 2002
+++ linux-2.4.21-pre5-ac3/drivers/sgi/char/sgiserial.c	Tue Mar 18 12:34:30 2003
@@ -1489,7 +1489,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_close ttys%d, count = %d\n", info->line, info->count);
 #endif
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/drivers/tc/zs.c linux-2.4.21-pre5-ac3/drivers/tc/zs.c
--- linux-2.4.21-pre5-ac3-vanilla/drivers/tc/zs.c	Thu Nov 28 18:53:14 2002
+++ linux-2.4.21-pre5-ac3/drivers/tc/zs.c	Tue Mar 18 12:32:14 2003
@@ -1374,7 +1374,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_close ttyS%02d, count = %d\n", info->line, info->count);
 #endif
-	if ((tty->count == 1) && (info->count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/include/linux/tty.h linux-2.4.21-pre5-ac3/include/linux/tty.h
--- linux-2.4.21-pre5-ac3-vanilla/include/linux/tty.h	Mon Mar 17 15:44:26 2003
+++ linux-2.4.21-pre5-ac3/include/linux/tty.h	Tue Mar 18 12:20:14 2003
@@ -265,7 +265,7 @@
 	int session;
 	kdev_t	device;
 	unsigned long flags;
-	int count;
+	atomic_t count;
 	struct winsize winsize;
 	unsigned char stopped:1, hw_stopped:1, flow_stopped:1, packet:1;
 	unsigned char low_latency:1, warned:1;
diff -urN -X /home/jes/exclude-linux linux-2.4.21-pre5-ac3-vanilla/net/irda/ircomm/ircomm_tty.c linux-2.4.21-pre5-ac3/net/irda/ircomm/ircomm_tty.c
--- linux-2.4.21-pre5-ac3-vanilla/net/irda/ircomm/ircomm_tty.c	Mon Mar 17 15:27:23 2003
+++ linux-2.4.21-pre5-ac3/net/irda/ircomm/ircomm_tty.c	Tue Mar 18 12:42:30 2003
@@ -526,7 +526,7 @@
 		return;
 	}
 
-	if ((tty->count == 1) && (self->open_count != 1)) {
+	if ((atomic_read(&tty->count) == 1) && (self->open_count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  state->count should always
