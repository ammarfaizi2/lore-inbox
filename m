Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTARUSn>; Sat, 18 Jan 2003 15:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTARUSm>; Sat, 18 Jan 2003 15:18:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:23441 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265037AbTARUSR>; Sat, 18 Jan 2003 15:18:17 -0500
Date: Sat, 18 Jan 2003 12:36:07 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: rddunlap@osdl.org, gregkh@us.ibm.com, greg@kroah.com, rmk@us.ibm.com,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
cc: gh@us.ibm.com, Hans Tannenberger <hjt@us.ibm.com>, hannal@us.ibm.com
Subject: review: 2.5.59 patches to fix bug 282
Message-ID: <27150000.1042922167@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1831449384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1831449384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Please review these changes (following what gregkh has already
done in the usb dir). These fix bug number 282 at:
http://bugme.osdl.org and are tty cleanups to fix a module
race condition and utilize the new owner field of the tty_driver
structure.

I have not compiled yet so just a brief review is ok.

Thanks.

Hanna
hannal@us.ibm.com
included is a gzipped tar ball and the text below, they are the same code.

-----
diff -X dontdiff -Nru linux-2.5.59/drivers/char/amiserial.c linux-2.5.59-modfix/drivers/char/amiserial.c
--- linux-2.5.59/drivers/char/amiserial.c	Thu Jan 16 18:22:59 2003
+++ linux-2.5.59-modfix/drivers/char/amiserial.c	Fri Jan 17 13:40:35 2003
@@ -1535,7 +1535,6 @@
 
 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
-		MOD_DEC_USE_COUNT;
 		local_irq_restore(flags);
 		return;
 	}
@@ -1562,7 +1561,6 @@
 	}
 	if (state->count) {
 		DBG_CNT("before DEC-2");
-		MOD_DEC_USE_COUNT;
 		local_irq_restore(flags);
 		return;
 	}
@@ -1622,7 +1620,6 @@
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE|
 			 ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	MOD_DEC_USE_COUNT;
 	local_irq_restore(flags);
 }
 
@@ -1902,15 +1899,12 @@
 	int 			retval, line;
 	unsigned long		page;
 
-	MOD_INC_USE_COUNT;
 	line = minor(tty->device) - tty->driver.minor_start;
 	if ((line < 0) || (line >= NR_PORTS)) {
-		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 	retval = get_async_struct(line, &info);
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		return retval;
 	}
 	tty->driver_data = info;
@@ -2127,6 +2121,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.driver_name = "amiserial";
 	serial_driver.name = "ttyS";
 	serial_driver.major = TTY_MAJOR;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/cyclades.c linux-2.5.59-modfix/drivers/char/cyclades.c
--- linux-2.5.59/drivers/char/cyclades.c	Thu Jan 16 18:21:44 2003
+++ linux-2.5.59-modfix/drivers/char/cyclades.c	Fri Jan 17 14:12:27 2003
@@ -2578,15 +2578,12 @@
   int retval, line;
   unsigned long page;
 
-    MOD_INC_USE_COUNT;
     line = minor(tty->device) - tty->driver.minor_start;
     if ((line < 0) || (NR_PORTS <= line)){
-	MOD_DEC_USE_COUNT;
         return -ENODEV;
     }
     info = &cy_port[line];
     if (info->line < 0){
-	MOD_DEC_USE_COUNT;
         return -ENODEV;
     }
     
@@ -2606,7 +2603,6 @@
 	    } else {
 		printk("cyc:Cyclades-Z firmware not yet loaded\n");
 	    }
-	    MOD_DEC_USE_COUNT;
 	    return -ENODEV;
 	}
 #ifdef CONFIG_CYZ_INTR
@@ -2802,7 +2798,6 @@
     CY_LOCK(info, flags);
     /* If the TTY is being hung up, nothing to do */
     if (tty_hung_up_p(filp)) {
-	MOD_DEC_USE_COUNT;
 	CY_UNLOCK(info, flags);
         return;
     }
@@ -2833,7 +2828,6 @@
         info->count = 0;
     }
     if (info->count) {
-	MOD_DEC_USE_COUNT;
 	CY_UNLOCK(info, flags);
         return;
     }
@@ -2930,7 +2924,6 @@
     printk(" cyc:cy_close done\n");
 #endif
 
-    MOD_DEC_USE_COUNT;
     CY_UNLOCK(info, flags);
     return;
 } /* cy_close */
@@ -5507,6 +5500,7 @@
     
     memset(&cy_serial_driver, 0, sizeof(struct tty_driver));
     cy_serial_driver.magic = TTY_DRIVER_MAGIC;
+    cy_serial_driver.owner = THIS_MODULE;
     cy_serial_driver.driver_name = "cyclades";
     cy_serial_driver.name = "ttyC";
     cy_serial_driver.major = CYCLADES_MAJOR;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/epca.c linux-2.5.59-modfix/drivers/char/epca.c
--- linux-2.5.59/drivers/char/epca.c	Thu Jan 16 18:22:18 2003
+++ linux-2.5.59-modfix/drivers/char/epca.c	Fri Jan 17 14:28:37 2003
@@ -481,9 +481,7 @@
 	-------------------------------------------------------------------------*/
 
 	ch->event |= 1 << event;
-	MOD_INC_USE_COUNT;
-	if (schedule_work(&ch->tqueue) == 0)
-		MOD_DEC_USE_COUNT;
+	schedule_work(&ch->tqueue);
 
 
 } /* End pc_sched_event */
@@ -604,7 +602,6 @@
 		                      ASYNC_CALLOUT_ACTIVE | ASYNC_CLOSING);
 		wake_up_interruptible(&ch->close_wait);
 
-		MOD_DEC_USE_COUNT;
 
 		restore_flags(flags);
 
@@ -692,10 +689,6 @@
 
 		shutdown(ch);
 
-		if (ch->count)
-			MOD_DEC_USE_COUNT;
-		
-
 		ch->tty   = NULL;
 		ch->event = 0;
 		ch->count = 0;
@@ -1389,8 +1382,6 @@
 	}
 
 
-	MOD_INC_USE_COUNT;
-
 	ch = &digi_channels[line];
 	boardnum = ch->boardnum;
 
@@ -1714,6 +1705,7 @@
 	memset(&pc_info, 0, sizeof(struct tty_driver));
 
 	pc_driver.magic = TTY_DRIVER_MAGIC;
+	pc_driver.owner = THIS_MODULE;
 	pc_driver.name = "ttyD"; 
 	pc_driver.major = DIGI_MAJOR; 
 	pc_driver.minor_start = 0;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/esp.c linux-2.5.59-modfix/drivers/char/esp.c
--- linux-2.5.59/drivers/char/esp.c	Thu Jan 16 18:21:34 2003
+++ linux-2.5.59-modfix/drivers/char/esp.c	Fri Jan 17 14:18:04 2003
@@ -643,9 +643,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 			printk("scheduling hangup...");
 #endif
-			MOD_INC_USE_COUNT;
-			if (schedule_task(&info->tqueue_hangup) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_task(&info->tqueue_hangup);
 		}
 	}
 }
@@ -809,7 +807,6 @@
 	tty = info->tty;
 	if (tty)
 		tty_hangup(tty);
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -2130,7 +2127,7 @@
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE|
 			 ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-out:	MOD_DEC_USE_COUNT;
+out:
 	restore_flags(flags);
 }
 
@@ -2374,7 +2371,6 @@
 	printk("esp_open %s%d, count = %d\n", tty->driver.name, info->line,
 	       info->count);
 #endif
-	MOD_INC_USE_COUNT;
 	info->count++;
 	tty->driver_data = info;
 	info->tty = tty;
@@ -2550,6 +2546,7 @@
 	
 	memset(&esp_driver, 0, sizeof(struct tty_driver));
 	esp_driver.magic = TTY_DRIVER_MAGIC;
+	esp_driver.owner = THIS_MODULE;
 	esp_driver.name = "ttyP";
 	esp_driver.major = ESP_IN_MAJOR;
 	esp_driver.minor_start = 0;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/ip2main.c linux-2.5.59-modfix/drivers/char/ip2main.c
--- linux-2.5.59/drivers/char/ip2main.c	Thu Jan 16 18:23:01 2003
+++ linux-2.5.59-modfix/drivers/char/ip2main.c	Fri Jan 17 14:30:31 2003
@@ -793,6 +793,7 @@
 
 	/* Initialise the relevant fields. */
 	ip2_tty_driver.magic                = TTY_DRIVER_MAGIC;
+	ip2_tty_driver.owner		    = THIS_MODULE;
 	ip2_tty_driver.name                 = pcTty;
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,0)
 	ip2_tty_driver.driver_name          = pcDriver_name;
@@ -1574,7 +1575,6 @@
 	/* Setup pointer links in device and tty structures */
 	pCh->pTTY = tty;
 	tty->driver_data = pCh;
-	MOD_INC_USE_COUNT;
 
 #ifdef IP2DEBUG_OPEN
 	printk(KERN_DEBUG \
@@ -1775,14 +1775,12 @@
 #endif
 
 	if ( tty_hung_up_p ( pFile ) ) {
-		MOD_DEC_USE_COUNT;
 
 		ip2trace (CHANN, ITRC_CLOSE, 2, 1, 2 );
 
 		return;
 	}
 	if ( tty->count > 1 ) { /* not the last close */
-		MOD_DEC_USE_COUNT;
 
 		ip2trace (CHANN, ITRC_CLOSE, 2, 1, 3 );
 
@@ -1850,7 +1848,6 @@
 	DBG_CNT("ip2_close: after wakeups--");
 #endif
 
-	MOD_DEC_USE_COUNT;
 
 	ip2trace (CHANN, ITRC_CLOSE, ITRC_RETURN, 1, 1 );
 
diff -X dontdiff -Nru linux-2.5.59/drivers/char/isicom.c linux-2.5.59-modfix/drivers/char/isicom.c
--- linux-2.5.59/drivers/char/isicom.c	Thu Jan 16 18:21:36 2003
+++ linux-2.5.59-modfix/drivers/char/isicom.c	Fri Jan 17 14:37:23 2003
@@ -589,9 +589,7 @@
 							port->status &= ~ISI_DCD;
 							if (!((port->flags & ASYNC_CALLOUT_ACTIVE) &&
 								(port->flags & ASYNC_CALLOUT_NOHUP))) {
-								MOD_INC_USE_COUNT;
-								if (schedule_task(&port->hangup_tq) == 0)
-									MOD_DEC_USE_COUNT;
+								schedule_task(&port->hangup_tq);
 							}
 						}
 					}
@@ -845,7 +843,6 @@
 #endif	
 	
 	bp->status |= BOARD_ACTIVE;
-	MOD_INC_USE_COUNT;
 	return;
 }
  
@@ -1103,7 +1100,6 @@
 	for(channel = 0; channel < bp->port_count; channel++, port++) {
 		drop_dtr_rts(port);
 	}	
-	MOD_DEC_USE_COUNT;
 }
 
 static void isicom_shutdown_port(struct isi_port * port)
@@ -1643,7 +1639,6 @@
 	tty = port->tty;
 	if (tty)
 		tty_hangup(tty);	/* FIXME: module removal race here - AKPM */
-	MOD_DEC_USE_COUNT;
 }
 
 static void isicom_hangup(struct tty_struct * tty)
@@ -1714,6 +1709,7 @@
 	/* tty driver structure initialization */
 	memset(&isicom_normal, 0, sizeof(struct tty_driver));
 	isicom_normal.magic	= TTY_DRIVER_MAGIC;
+	isicom_normal.owner	= THIS_MODULE;
 	isicom_normal.name 	= "ttyM";
 	isicom_normal.major	= ISICOM_NMAJOR;
 	isicom_normal.minor_start	= 0;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/istallion.c linux-2.5.59-modfix/drivers/char/istallion.c
--- linux-2.5.59/drivers/char/istallion.c	Thu Jan 16 18:22:19 2003
+++ linux-2.5.59-modfix/drivers/char/istallion.c	Fri Jan 17 14:46:30 2003
@@ -1054,7 +1054,6 @@
 	if (portp->devnr < 1)
 		return(-ENODEV);
 
-	MOD_INC_USE_COUNT;
 
 /*
  *	Check if this port is in the middle of closing. If so then wait
@@ -1170,14 +1169,12 @@
 	save_flags(flags);
 	cli();
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
 	if ((tty->count == 1) && (portp->refcount != 1))
 		portp->refcount = 1;
 	if (portp->refcount-- > 1) {
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
@@ -1232,7 +1229,6 @@
 	portp->flags &= ~(ASYNC_CALLOUT_ACTIVE | ASYNC_NORMAL_ACTIVE |
 		ASYNC_CLOSING);
 	wake_up_interruptible(&portp->close_wait);
-	MOD_DEC_USE_COUNT;
 	restore_flags(flags);
 }
 
@@ -2369,7 +2365,6 @@
 			tty_hangup(portp->tty);
 		}
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 /*****************************************************************************/
@@ -3004,9 +2999,7 @@
 					if (! ((portp->flags & ASYNC_CALLOUT_ACTIVE) &&
 					    (portp->flags & ASYNC_CALLOUT_NOHUP))) {
 						if (tty != (struct tty_struct *) NULL) {
-							MOD_INC_USE_COUNT;
-							if (schedule_task(&portp->tqhangup) == 0)
-								MOD_DEC_USE_COUNT;
+							schedule_task(&portp->tqhangup);
 						}
 					}
 				}
@@ -5350,6 +5343,7 @@
  */
 	memset(&stli_serial, 0, sizeof(struct tty_driver));
 	stli_serial.magic = TTY_DRIVER_MAGIC;
+	stli_serial.owner = THIS_MODULE;
 	stli_serial.driver_name = stli_drvname;
 	stli_serial.name = stli_serialname;
 	stli_serial.major = STL_SERIALMAJOR;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/moxa.c linux-2.5.59-modfix/drivers/char/moxa.c
--- linux-2.5.59/drivers/char/moxa.c	Thu Jan 16 18:22:44 2003
+++ linux-2.5.59-modfix/drivers/char/moxa.c	Fri Jan 17 14:47:53 2003
@@ -341,6 +341,7 @@
 	memset(&moxaDriver, 0, sizeof(struct tty_driver));
 	memset(&moxaCallout, 0, sizeof(struct tty_driver));
 	moxaDriver.magic = TTY_DRIVER_MAGIC;
+	moxaDriver.owner = THIS_MODULE;
 	moxaDriver.name = "ttya";
 	moxaDriver.major = ttymajor;
 	moxaDriver.minor_start = 0;
@@ -544,7 +545,6 @@
 			ch->asyncflags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CALLOUT_ACTIVE);
 		}
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 static int moxa_open(struct tty_struct *tty, struct file *filp)
@@ -556,7 +556,6 @@
 
 	port = PORTNO(tty);
 	if (port == MAX_PORTS) {
-		MOD_INC_USE_COUNT;
 		return (0);
 	}
 	if (!MoxaPortIsValid(port)) {
@@ -579,7 +578,6 @@
 	}
 	up(&moxaBuffSem);
 
-	MOD_INC_USE_COUNT;
 	ch = &moxaChannels[port];
 	ch->count++;
 	tty->driver_data = ch;
@@ -619,7 +617,6 @@
 
 	port = PORTNO(tty);
 	if (port == MAX_PORTS) {
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	if (!MoxaPortIsValid(port)) {
@@ -633,7 +630,6 @@
 		return;
 	}
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	ch = (struct moxa_str *) tty->driver_data;
@@ -649,7 +645,6 @@
 		ch->count = 0;
 	}
 	if (ch->count) {
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	ch->asyncflags |= ASYNC_CLOSING;
@@ -688,7 +683,6 @@
 	ch->asyncflags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CALLOUT_ACTIVE |
 			    ASYNC_CLOSING);
 	wake_up_interruptible(&ch->close_wait);
-	MOD_DEC_USE_COUNT;
 }
 
 static int moxa_write(struct tty_struct *tty, int from_user,
@@ -1024,9 +1018,7 @@
 						wake_up_interruptible(&ch->open_wait);
 					else {
 						set_bit(MOXA_EVENT_HANGUP, &ch->event);
-						MOD_DEC_USE_COUNT;
-						if (schedule_work(&ch->tqueue) == 0)
-							MOD_INC_USE_COUNT;
+						schedule_work(&ch->tqueue);
 					}
 				}
 			}
diff -X dontdiff -Nru linux-2.5.59/drivers/char/mxser.c linux-2.5.59-modfix/drivers/char/mxser.c
--- linux-2.5.59/drivers/char/mxser.c	Thu Jan 16 18:22:23 2003
+++ linux-2.5.59-modfix/drivers/char/mxser.c	Fri Jan 17 14:51:04 2003
@@ -501,6 +501,7 @@
 
 	memset(&mxvar_sdriver, 0, sizeof(struct tty_driver));
 	mxvar_sdriver.magic = TTY_DRIVER_MAGIC;
+	mxvar_sdriver.owner = THIS_MODULE;
 	mxvar_sdriver.name = "ttyM";
 	mxvar_sdriver.major = ttymajor;
 	mxvar_sdriver.minor_start = 0;
@@ -708,7 +709,6 @@
 			tty_hangup(tty);	/* FIXME: module removal race here - AKPM */
 		}
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -767,8 +767,6 @@
 	info->session = current->session;
 	info->pgrp = current->pgrp;
 
-	MOD_INC_USE_COUNT;
-
 	return (0);
 }
 
@@ -795,7 +793,6 @@
 
 	if (tty_hung_up_p(filp)) {
 		restore_flags(flags);
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	if ((tty->count == 1) && (info->count != 1)) {
@@ -817,7 +814,6 @@
 	}
 	if (info->count) {
 		restore_flags(flags);
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	info->flags |= ASYNC_CLOSING;
@@ -881,7 +877,6 @@
 	wake_up_interruptible(&info->close_wait);
 	restore_flags(flags);
 
-	MOD_DEC_USE_COUNT;
 }
 
 static int mxser_write(struct tty_struct *tty, int from_user,
@@ -1489,9 +1484,7 @@
 
 	if (info->xmit_cnt < WAKEUP_CHARS) {
 		set_bit(MXSER_EVENT_TXLOW, &info->event);
-		MOD_INC_USE_COUNT;
-		if (schedule_work(&info->tqueue) == 0)
-		    MOD_DEC_USE_COUNT;
+		schedule_work(&info->tqueue);
 	}
 	if (info->xmit_cnt <= 0) {
 		info->IER &= ~UART_IER_THRI;
@@ -1520,9 +1513,7 @@
 		else if (!((info->flags & ASYNC_CALLOUT_ACTIVE) &&
 			   (info->flags & ASYNC_CALLOUT_NOHUP)))
 			set_bit(MXSER_EVENT_HANGUP, &info->event);
-		MOD_INC_USE_COUNT;
-		if (schedule_work(&info->tqueue) == 0)
-		    MOD_DEC_USE_COUNT;
+		schedule_work(&info->tqueue);
 	}
 	if (info->flags & ASYNC_CTS_FLOW) {
 		if (info->tty->hw_stopped) {
@@ -1532,9 +1523,7 @@
 				outb(info->IER, info->base + UART_IER);
 
 				set_bit(MXSER_EVENT_TXLOW, &info->event);
-				MOD_INC_USE_COUNT;
-				if (schedule_work(&info->tqueue) == 0)
-					MOD_DEC_USE_COUNT;
+				schedule_work(&info->tqueue);
 			}
 		} else {
 			if (!(status & UART_MSR_CTS)) {
diff -X dontdiff -Nru linux-2.5.59/drivers/char/pcmcia/synclink_cs.c linux-2.5.59-modfix/drivers/char/pcmcia/synclink_cs.c
--- linux-2.5.59/drivers/char/pcmcia/synclink_cs.c	Thu Jan 16 18:22:01 2003
+++ linux-2.5.59-modfix/drivers/char/pcmcia/synclink_cs.c	Fri Jan 17 14:52:42 2003
@@ -2690,7 +2690,6 @@
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_close(%s) exit, count=%d\n", __FILE__,__LINE__,
 			tty->driver.name, info->count);
-	MOD_DEC_USE_COUNT;
 }
 
 /* Wait until the transmitter is empty.
@@ -2942,8 +2941,6 @@
 		printk("%s(%d):mgslpc_open(%s), old ref count = %d\n",
 			 __FILE__,__LINE__,tty->driver.name, info->count);
 
-	MOD_INC_USE_COUNT;
-	
 	/* If port is closing, signal caller to try again */
 	if (tty_hung_up_p(filp) || info->flags & ASYNC_CLOSING){
 		if (info->flags & ASYNC_CLOSING)
@@ -2998,7 +2995,6 @@
 	
 cleanup:			
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		if(info->count)
 			info->count--;
 	}
@@ -3250,6 +3246,7 @@
 	
     memset(&serial_driver, 0, sizeof(struct tty_driver));
     serial_driver.magic = TTY_DRIVER_MAGIC;
+    serial_driver.owner = THIS_MODULE;
     serial_driver.driver_name = "synclink_cs";
     serial_driver.name = "ttySLP";
     serial_driver.major = ttymajor;
@@ -4401,7 +4398,6 @@
 		return -EBUSY;
 	}
 	info->netcount=1;
-	MOD_INC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 
 	/* claim resources and init adapter */
@@ -4424,7 +4420,6 @@
 open_fail:
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return err;
 }
@@ -4494,7 +4489,6 @@
 
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return 0;
 }
diff -X dontdiff -Nru linux-2.5.59/drivers/char/pcxx.c linux-2.5.59-modfix/drivers/char/pcxx.c
--- linux-2.5.59/drivers/char/pcxx.c	Thu Jan 16 18:22:18 2003
+++ linux-2.5.59-modfix/drivers/char/pcxx.c	Fri Jan 17 14:54:56 2003
@@ -431,8 +431,6 @@
 		return(-ENODEV);
 	}
 
-	/* flag the kernel that there is somebody using this guy */
-	MOD_INC_USE_COUNT;
 	/*
 	 * If the device is in the middle of being closed, then block
 	 * until it's done, and then try again.
@@ -576,7 +574,6 @@
 
 		if(tty_hung_up_p(filp)) {
 			/* flag that somebody is done with this module */
-			MOD_DEC_USE_COUNT;
 			restore_flags(flags);
 			return;
 		}
@@ -594,7 +591,6 @@
 		}
 		if (info->count-- > 1) {
 			restore_flags(flags);
-			MOD_DEC_USE_COUNT;
 			return;
 		}
 		if (info->count < 0) {
@@ -651,7 +647,6 @@
 		info->asyncflags &= ~(ASYNC_NORMAL_ACTIVE|
 							  ASYNC_CALLOUT_ACTIVE|ASYNC_CLOSING);
 		wake_up_interruptible(&info->close_wait);
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 	}
 }
@@ -1228,6 +1223,7 @@
 
 	memset(&pcxe_driver, 0, sizeof(struct tty_driver));
 	pcxe_driver.magic = TTY_DRIVER_MAGIC;
+	pcxe_driver.owner = THIS_MODULE;
 	pcxe_driver.name = "ttyD";
 	pcxe_driver.major = DIGI_MAJOR; 
 	pcxe_driver.minor_start = 0;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/rio/rio_linux.c linux-2.5.59-modfix/drivers/char/rio/rio_linux.c
--- linux-2.5.59/drivers/char/rio/rio_linux.c	Thu Jan 16 18:22:19 2003
+++ linux-2.5.59-modfix/drivers/char/rio/rio_linux.c	Fri Jan 17 14:57:08 2003
@@ -392,29 +392,6 @@
   udelay (usecs);
 }
 
-
-void rio_inc_mod_count (void)
-{
-#ifdef MODULE
-  func_enter ();
-  rio_dprintk (RIO_DEBUG_MOD_COUNT, "rio_inc_mod_count\n");
-  MOD_INC_USE_COUNT; 
-  func_exit ();
-#endif
-}
-
-
-void rio_dec_mod_count (void)
-{
-#ifdef MODULE
-  func_enter ();
-  rio_dprintk (RIO_DEBUG_MOD_COUNT, "rio_dec_mod_count\n");
-  MOD_DEC_USE_COUNT; 
-  func_exit ();
-#endif
-}
-
-
 static int rio_set_real_termios (void *ptr)
 {
   int rv, modem;
@@ -662,7 +639,6 @@
   
   PortP = (struct Port *)ptr;
   PortP->gs.tty = NULL;
-  rio_dec_mod_count (); 
 
   func_exit ();
 }
@@ -688,7 +664,6 @@
   }                
 
   PortP->gs.tty = NULL;
-  rio_dec_mod_count ();
   func_exit ();
 }
 
@@ -910,6 +885,7 @@
 
   memset(&rio_driver, 0, sizeof(rio_driver));
   rio_driver.magic = TTY_DRIVER_MAGIC;
+  rio_driver.owner = THIS_MODULE;
   rio_driver.driver_name = "specialix_rio";
   rio_driver.name = "ttySR";
   rio_driver.major = RIO_NORMAL_MAJOR0;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/rio/rio_linux.h linux-2.5.59-modfix/drivers/char/rio/rio_linux.h
--- linux-2.5.59/drivers/char/rio/rio_linux.h	Thu Jan 16 18:22:24 2003
+++ linux-2.5.59-modfix/drivers/char/rio/rio_linux.h	Fri Jan 17 14:58:57 2003
@@ -87,9 +87,6 @@
 #endif
 
 
-void rio_dec_mod_count (void);
-void rio_inc_mod_count (void);
-
 /* Allow us to debug "in the field" without requiring clients to
    recompile.... */
 #if 1
diff -X dontdiff -Nru linux-2.5.59/drivers/char/rio/riotty.c linux-2.5.59-modfix/drivers/char/rio/riotty.c
--- linux-2.5.59/drivers/char/rio/riotty.c	Thu Jan 16 18:22:02 2003
+++ linux-2.5.59-modfix/drivers/char/rio/riotty.c	Fri Jan 17 14:59:41 2003
@@ -141,7 +141,6 @@
 
 
 extern struct rio_info *p;
-extern void rio_inc_mod_count (void);
 
 
 int
@@ -207,8 +206,6 @@
 	tty->driver_data = PortP;
 
 	PortP->gs.tty = tty;
-	if (!PortP->gs.count)
-		rio_inc_mod_count ();
 	PortP->gs.count++;
 
 	rio_dprintk (RIO_DEBUG_TTY, "%d bytes in tx buffer\n",
@@ -217,8 +214,6 @@
 	retval = gs_init_port (&PortP->gs);
 	if (retval) {
 		PortP->gs.count--;
-		if (PortP->gs.count)
-			rio_dec_mod_count ();
 		return -ENXIO;
 	}
 	/*
diff -X dontdiff -Nru linux-2.5.59/drivers/char/riscom8.c linux-2.5.59-modfix/drivers/char/riscom8.c
--- linux-2.5.59/drivers/char/riscom8.c	Thu Jan 16 18:22:07 2003
+++ linux-2.5.59-modfix/drivers/char/riscom8.c	Fri Jan 17 15:01:08 2003
@@ -552,9 +552,7 @@
 			wake_up_interruptible(&port->open_wait);
 		else if (!((port->flags & ASYNC_CALLOUT_ACTIVE) &&
 			   (port->flags & ASYNC_CALLOUT_NOHUP))) {
-			MOD_INC_USE_COUNT;
-			if (schedule_task(&port->tqueue_hangup) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_task(&port->tqueue_hangup);
 		}
 	}
 	
@@ -674,7 +672,6 @@
 	IRQ_to_board[bp->irq] = bp;
 	bp->flags |= RC_BOARD_ACTIVE;
 	
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -692,7 +689,6 @@
 	bp->DTR = ~0;
 	rc_out(bp, RC_DTR, bp->DTR);	       /* Drop DTR on all ports */
 	
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -1676,7 +1672,6 @@
 	tty = port->tty;
 	if (tty)
 		tty_hangup(tty);	/* FIXME: module removal race still here */
-	MOD_DEC_USE_COUNT;
 }
 
 static void rc_hangup(struct tty_struct * tty)
@@ -1755,6 +1750,7 @@
 	memset(IRQ_to_board, 0, sizeof(IRQ_to_board));
 	memset(&riscom_driver, 0, sizeof(riscom_driver));
 	riscom_driver.magic = TTY_DRIVER_MAGIC;
+	riscom_driver.owner = THIS_MODULE;
 	riscom_driver.name = "ttyL";
 	riscom_driver.major = RISCOM8_NORMAL_MAJOR;
 	riscom_driver.num = RC_NBOARD * RC_NPORT;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/rocket.c linux-2.5.59-modfix/drivers/char/rocket.c
--- linux-2.5.59/drivers/char/rocket.c	Thu Jan 16 18:22:23 2003
+++ linux-2.5.59-modfix/drivers/char/rocket.c	Fri Jan 17 15:02:21 2003
@@ -874,9 +874,6 @@
 	}
 
 	if (info->count++ == 0) {
-#ifdef MODULE
-		MOD_INC_USE_COUNT;
-#endif
 		rp_num_ports_open++;
 #ifdef ROCKET_DEBUG_OPEN
 		printk("rocket mod++ = %d...", rp_num_ports_open);
@@ -1071,9 +1068,6 @@
 	tty->closing = 0;
 	wake_up_interruptible(&info->close_wait);
 	
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
 	rp_num_ports_open--;
 #ifdef ROCKET_DEBUG_OPEN
 	printk("rocket mod-- = %d...", rp_num_ports_open);
@@ -1517,9 +1511,6 @@
 		return;
 	}
 	if (info->count) {
-#ifdef MODULE
-		MOD_DEC_USE_COUNT;
-#endif
 		rp_num_ports_open--;
 	}
 	
@@ -2025,6 +2016,7 @@
 	 */
 	memset(&rocket_driver, 0, sizeof(struct tty_driver));
 	rocket_driver.magic = TTY_DRIVER_MAGIC;
+	rocket_driver.owner = THIS_MODULE;
 #ifdef CONFIG_DEVFS_FS
 	rocket_driver.name = "tts/R%d";
 #else
diff -X dontdiff -Nru linux-2.5.59/drivers/char/ser_a2232.c linux-2.5.59-modfix/drivers/char/ser_a2232.c
--- linux-2.5.59/drivers/char/ser_a2232.c	Thu Jan 16 18:21:48 2003
+++ linux-2.5.59-modfix/drivers/char/ser_a2232.c	Fri Jan 17 15:06:59 2003
@@ -272,7 +272,6 @@
 		not in "a2232_close()". See the comment in "sx.c", too.
 		If you run into problems, compile this driver into the
 		kernel instead of compiling it as a module. */
-	MOD_DEC_USE_COUNT;
 }
 
 static int  a2232_set_real_termios(void *ptr)
@@ -414,7 +413,6 @@
 	a2232_disable_tx_interrupts(ptr);
 	a2232_disable_rx_interrupts(ptr);
 	/* see the comment in a2232_shutdown_port above. */
-	/* MOD_DEC_USE_COUNT; */
 }
 
 static void a2232_hungup(void *ptr)
@@ -468,13 +466,9 @@
 		return retval;
 	}
 	port->gs.flags |= GS_ACTIVE;
-	if (port->gs.count == 1) {
-		MOD_INC_USE_COUNT;
-	}
 	retval = gs_block_til_ready(port, filp);
 
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		port->gs.count--;
 		return retval;
 	}
@@ -711,6 +705,7 @@
 
 	memset(&a2232_driver, 0, sizeof(a2232_driver));
 	a2232_driver.magic = TTY_DRIVER_MAGIC;
+	a2232_driver.owner = THIS_MODULE;
 	a2232_driver.driver_name = "commodore_a2232";
 	a2232_driver.name = "ttyY";
 	a2232_driver.major = A2232_NORMAL_MAJOR;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/serial_tx3912.c linux-2.5.59-modfix/drivers/char/serial_tx3912.c
--- linux-2.5.59/drivers/char/serial_tx3912.c	Thu Jan 16 18:22:14 2003
+++ linux-2.5.59-modfix/drivers/char/serial_tx3912.c	Fri Jan 17 15:12:43 2003
@@ -41,8 +41,6 @@
 static void rs_shutdown_port (void * ptr); 
 static int rs_set_real_termios (void *ptr);
 static int rs_chars_in_buffer (void * ptr); 
-static void rs_hungup (void *ptr);
-static void rs_close (void *ptr);
 
 /*
  * Used by generic serial driver to access hardware
@@ -56,8 +54,6 @@
 	.shutdown_port         = rs_shutdown_port,  
 	.set_real_termios      = rs_set_real_termios,  
 	.chars_in_buffer       = rs_chars_in_buffer, 
-	.close                 = rs_close, 
-	.hungup                = rs_hungup,
 }; 
 
 /*
@@ -579,9 +575,6 @@
 
 	rs_dprintk (TX3912_UART_DEBUG_OPEN, "before inc_use_count (count=%d.\n", 
 	            port->gs.count);
-	if (port->gs.count == 1) {
-		MOD_INC_USE_COUNT;
-	}
 	rs_dprintk (TX3912_UART_DEBUG_OPEN, "after inc_use_count\n");
 
 	/* Jim: Initialize port hardware here */
@@ -595,7 +588,6 @@
 	            retval, port->gs.count);
 
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		port->gs.count--;
 		return retval;
 	}
@@ -621,32 +613,6 @@
 }
 
 
-
-static void rs_close (void *ptr)
-{
-	func_enter ();
-
-	/* Anything to do here? */
-
-	MOD_DEC_USE_COUNT;
-	func_exit ();
-}
-
-
-/* I haven't the foggiest why the decrement use count has to happen
-   here. The whole linux serial drivers stuff needs to be redesigned.
-   My guess is that this is a hack to minimize the impact of a bug
-   elsewhere. Thinking about it some more. (try it sometime) Try
-   running minicom on a serial port that is driven by a modularized
-   driver. Have the modem hangup. Then remove the driver module. Then
-   exit minicom.  I expect an "oops".  -- REW */
-static void rs_hungup (void *ptr)
-{
-	func_enter ();
-	MOD_DEC_USE_COUNT;
-	func_exit ();
-}
-
 static int rs_ioctl (struct tty_struct * tty, struct file * filp, 
                      unsigned int cmd, unsigned long arg)
 {
@@ -839,6 +805,7 @@
 
 	memset(&rs_driver, 0, sizeof(rs_driver));
 	rs_driver.magic = TTY_DRIVER_MAGIC;
+	rs_driver.owner = THIS_MODULE;
 	rs_driver.driver_name = "serial";
 	rs_driver.name = "ttyS";
 	rs_driver.major = TTY_MAJOR;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/sh-sci.c linux-2.5.59-modfix/drivers/char/sh-sci.c
--- linux-2.5.59/drivers/char/sh-sci.c	Thu Jan 16 18:22:45 2003
+++ linux-2.5.59-modfix/drivers/char/sh-sci.c	Fri Jan 17 15:24:38 2003
@@ -71,8 +71,6 @@
 static int  sci_get_CD(void *ptr);
 static void sci_shutdown_port(void *ptr);
 static int sci_set_real_termios(void *ptr);
-static void sci_hungup(void *ptr);
-static void sci_close(void *ptr);
 static int sci_chars_in_buffer(void *ptr);
 static int sci_request_irq(struct sci_port *port);
 static void sci_free_irq(struct sci_port *port);
@@ -216,8 +214,6 @@
 	sci_shutdown_port,
 	sci_set_real_termios,
 	sci_chars_in_buffer,
-	sci_close,
-	sci_hungup,
 	NULL
 };
 
@@ -838,12 +834,7 @@
 	sci_setsignals(port, 1,1);
 
 	if (port->gs.count == 1) {
-		MOD_INC_USE_COUNT;
-
 		retval = sci_request_irq(port);
-		if (retval) {
-			goto failed_2;
-		}
 	}
 
 	retval = gs_block_til_ready(port, filp);
@@ -878,23 +869,11 @@
 
 failed_3:
 	sci_free_irq(port);
-failed_2:
-	MOD_DEC_USE_COUNT;
 failed_1:
 	port->gs.count--;
 	return retval;
 }
 
-static void sci_hungup(void *ptr)
-{
-	MOD_DEC_USE_COUNT;
-}
-
-static void sci_close(void *ptr)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static int sci_ioctl(struct tty_struct * tty, struct file * filp, 
                      unsigned int cmd, unsigned long arg)
 {
@@ -1019,6 +998,7 @@
 
 	memset(&sci_driver, 0, sizeof(sci_driver));
 	sci_driver.magic = TTY_DRIVER_MAGIC;
+	sci_driver.owner = THIS_MODULE;
 	sci_driver.driver_name = "sci";
 #ifdef CONFIG_DEVFS_FS
 	sci_driver.name = "ttsc/%d";
diff -X dontdiff -Nru linux-2.5.59/drivers/char/specialix.c linux-2.5.59-modfix/drivers/char/specialix.c
--- linux-2.5.59/drivers/char/specialix.c	Thu Jan 16 18:22:42 2003
+++ linux-2.5.59-modfix/drivers/char/specialix.c	Fri Jan 17 15:34:57 2003
@@ -833,9 +833,7 @@
 #ifdef SPECIALIX_DEBUG
 			printk ( "Sending HUP.\n");
 #endif
-			MOD_INC_USE_COUNT;
-			if (schedule_task(&port->tqueue_hangup) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_task(&port->tqueue_hangup);
 		} else {
 #ifdef SPECIALIX_DEBUG
 			printk ( "Don't need to send HUP.\n");
@@ -979,7 +977,6 @@
 	turn_ints_on (bp);
 	bp->flags |= SX_BOARD_ACTIVE;
 
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -999,7 +996,6 @@
 
 	turn_ints_off (bp);
 
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -2149,7 +2145,6 @@
 	tty = port->tty;
 	if (tty)
 		tty_hangup(tty);	/* FIXME: module removal race here */
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -2232,6 +2227,7 @@
 	init_bh(SPECIALIX_BH, do_specialix_bh);
 	memset(&specialix_driver, 0, sizeof(specialix_driver));
 	specialix_driver.magic = TTY_DRIVER_MAGIC;
+	specialix_driver.owner = THIS_MODULE;
 	specialix_driver.name = "ttyW";
 	specialix_driver.major = SPECIALIX_NORMAL_MAJOR;
 	specialix_driver.num = SX_NBOARD * SX_NPORT;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/stallion.c linux-2.5.59-modfix/drivers/char/stallion.c
--- linux-2.5.59/drivers/char/stallion.c	Thu Jan 16 18:22:27 2003
+++ linux-2.5.59-modfix/drivers/char/stallion.c	Fri Jan 17 15:39:58 2003
@@ -1045,8 +1045,6 @@
 	if (portp == (stlport_t *) NULL)
 		return(-ENODEV);
 
-	MOD_INC_USE_COUNT;
-
 /*
  *	On the first open of the device setup the port hardware, and
  *	initialize the per port data structure.
@@ -1208,14 +1206,12 @@
 	save_flags(flags);
 	cli();
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
 	if ((tty->count == 1) && (portp->refcount != 1))
 		portp->refcount = 1;
 	if (portp->refcount-- > 1) {
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
@@ -1268,7 +1264,6 @@
 	portp->flags &= ~(ASYNC_CALLOUT_ACTIVE | ASYNC_NORMAL_ACTIVE |
 		ASYNC_CLOSING);
 	wake_up_interruptible(&portp->close_wait);
-	MOD_DEC_USE_COUNT;
 	restore_flags(flags);
 }
 
@@ -2239,11 +2234,11 @@
 #endif
 
 	if (portp == (stlport_t *) NULL)
-		goto out;
+		return;
 
 	tty = portp->tty;
 	if (tty == (struct tty_struct *) NULL)
-		goto out;
+		return;
 
 	lock_kernel();
 	if (test_bit(ASYI_TXLOW, &portp->istate)) {
@@ -2268,8 +2263,6 @@
 		}
 	}
 	unlock_kernel();
-out:
-	MOD_DEC_USE_COUNT;
 }
 
 /*****************************************************************************/
@@ -3229,6 +3222,7 @@
  */
 	memset(&stl_serial, 0, sizeof(struct tty_driver));
 	stl_serial.magic = TTY_DRIVER_MAGIC;
+	stl_serial.owner = THIS_MODULE;
 	stl_serial.driver_name = stl_drvname;
 	stl_serial.name = stl_serialname;
 	stl_serial.major = STL_SERIALMAJOR;
@@ -4134,9 +4128,7 @@
 	if ((len == 0) || ((len < STL_TXBUFLOW) &&
 	    (test_bit(ASYI_TXLOW, &portp->istate) == 0))) {
 		set_bit(ASYI_TXLOW, &portp->istate);
-		MOD_INC_USE_COUNT;
-		if (schedule_work(&portp->tqueue) == 0)
-			MOD_DEC_USE_COUNT;
+		schedule_work(&portp->tqueue);
 	}
 
 	if (len == 0) {
@@ -4316,9 +4308,7 @@
 	misr = inb(ioaddr + EREG_DATA);
 	if (misr & MISR_DCD) {
 		set_bit(ASYI_DCDCHANGE, &portp->istate);
-		MOD_INC_USE_COUNT;
-		if (schedule_task(&portp->tqueue) == 0)
-			MOD_DEC_USE_COUNT;
+		schedule_task(&portp->tqueue);
 		portp->stats.modem++;
 	}
 
@@ -5115,9 +5105,7 @@
 	if ((len == 0) || ((len < STL_TXBUFLOW) &&
 	    (test_bit(ASYI_TXLOW, &portp->istate) == 0))) {
 		set_bit(ASYI_TXLOW, &portp->istate);
-		MOD_INC_USE_COUNT;
-		if (schedule_task(&portp->tqueue) == 0)
-			MOD_DEC_USE_COUNT;
+		schedule_task(&portp->tqueue); 
 	}
 
 	if (len == 0) {
@@ -5334,9 +5322,7 @@
 		ipr = stl_sc26198getreg(portp, IPR);
 		if (ipr & IPR_DCDCHANGE) {
 			set_bit(ASYI_DCDCHANGE, &portp->istate);
-			MOD_INC_USE_COUNT;
-			if (schedule_task(&portp->tqueue) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_task(&portp->tqueue); 
 			portp->stats.modem++;
 		}
 		break;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/sx.c linux-2.5.59-modfix/drivers/char/sx.c
--- linux-2.5.59/drivers/char/sx.c	Thu Jan 16 18:22:03 2003
+++ linux-2.5.59-modfix/drivers/char/sx.c	Fri Jan 17 15:42:35 2003
@@ -303,7 +303,6 @@
 static int  sx_get_CD (void * ptr); 
 static void sx_shutdown_port (void * ptr);
 static int  sx_set_real_termios (void  *ptr);
-static void sx_hungup (void  *ptr);
 static void sx_close (void  *ptr);
 static int sx_chars_in_buffer (void * ptr);
 static int sx_init_board (struct sx_board *board);
@@ -384,7 +383,6 @@
 	sx_set_real_termios, 
 	sx_chars_in_buffer,
 	sx_close,
-	sx_hungup,
 };
 
 
@@ -1448,8 +1446,6 @@
 
 	tty->driver_data = port;
 	port->gs.tty = tty;
-	if (!port->gs.count)
-		MOD_INC_USE_COUNT;
 	port->gs.count++;
 
 	sx_dprintk (SX_DEBUG_OPEN, "starting port\n");
@@ -1461,7 +1457,6 @@
 	sx_dprintk (SX_DEBUG_OPEN, "done gs_init\n");
 	if (retval) {
 		port->gs.count--;
-		if (port->gs.count) MOD_DEC_USE_COUNT;
 		return retval;
 	}
 
@@ -1480,7 +1475,6 @@
 	if (sx_send_command (port, HS_LOPEN, -1, HS_IDLE_OPEN) != 1) {
 		printk (KERN_ERR "sx: Card didn't respond to LOPEN command.\n");
 		port->gs.count--;
-		if (!port->gs.count) MOD_DEC_USE_COUNT;
 		return -EIO;
 	}
 
@@ -1515,40 +1509,6 @@
 }
 
 
-/* I haven't the foggiest why the decrement use count has to happen
-   here. The whole linux serial drivers stuff needs to be redesigned.
-   My guess is that this is a hack to minimize the impact of a bug
-   elsewhere. Thinking about it some more. (try it sometime) Try
-   running minicom on a serial port that is driven by a modularized
-   driver. Have the modem hangup. Then remove the driver module. Then
-   exit minicom.  I expect an "oops".  -- REW */
-static void sx_hungup (void *ptr)
-{
-  /*
-	struct sx_port *port = ptr; 
-  */
-	func_enter ();
-
-	/* Don't force the SX card to close. mgetty doesn't like it !!!!!! -- pvdl */
-	/* For some reson we added this code. Don't know why anymore ;-( -- pvdl */
-	/*
-	sx_setsignals (port, 0, 0);
-	sx_reconfigure_port(port);	
-	sx_send_command (port, HS_CLOSE, 0, 0);
-
-	if (sx_read_channel_byte (port, hi_hstat) != HS_IDLE_CLOSED) {
-		if (sx_send_command (port, HS_FORCE_CLOSED, -1, HS_IDLE_CLOSED) != 1) {
-			printk (KERN_ERR 
-			        "sx: sent the force_close command, but card didn't react\n");
-		} else
-			sx_dprintk (SX_DEBUG_CLOSE, "sent the force_close command.\n");
-	}
-	*/
-	MOD_DEC_USE_COUNT;
-	func_exit ();
-}
-
-
 static void sx_close (void *ptr)
 {
 	struct sx_port *port = ptr; 
@@ -1584,7 +1544,6 @@
 		port->gs.count = 0;
 	}
 
-	MOD_DEC_USE_COUNT;
 	func_exit ();
 }
 
@@ -2261,6 +2220,7 @@
 
 	memset(&sx_driver, 0, sizeof(sx_driver));
 	sx_driver.magic = TTY_DRIVER_MAGIC;
+	sx_driver.owner = THIS_MODULE;
 	sx_driver.driver_name = "specialix_sx";
 	sx_driver.name = "ttyX";
 	sx_driver.major = SX_NORMAL_MAJOR;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/synclink.c linux-2.5.59-modfix/drivers/char/synclink.c
--- linux-2.5.59/drivers/char/synclink.c	Thu Jan 16 18:22:01 2003
+++ linux-2.5.59-modfix/drivers/char/synclink.c	Fri Jan 17 15:46:46 2003
@@ -3323,7 +3323,6 @@
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_close(%s) exit, count=%d\n", __FILE__,__LINE__,
 			tty->driver.name, info->count);
-	MOD_DEC_USE_COUNT;
 			
 }	/* end of mgsl_close() */
 
@@ -3615,8 +3614,6 @@
 		printk("%s(%d):mgsl_open(%s), old ref count = %d\n",
 			 __FILE__,__LINE__,tty->driver.name, info->count);
 
-	MOD_INC_USE_COUNT;
-	
 	/* If port is closing, signal caller to try again */
 	if (tty_hung_up_p(filp) || info->flags & ASYNC_CLOSING){
 		if (info->flags & ASYNC_CLOSING)
@@ -3683,7 +3680,6 @@
 	
 cleanup:			
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		if(info->count)
 			info->count--;
 	}
@@ -4571,6 +4567,7 @@
 	
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.driver_name = "synclink";
 	serial_driver.name = "ttySL";
 	serial_driver.major = ttymajor;
@@ -8003,7 +8000,6 @@
 		return -EBUSY;
 	}
 	info->netcount=1;
-	MOD_INC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 
 	/* claim resources and init adapter */
@@ -8026,7 +8022,6 @@
 open_fail:
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return err;
 }
@@ -8092,7 +8087,6 @@
 
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return 0;
 }
diff -X dontdiff -Nru linux-2.5.59/drivers/char/synclinkmp.c linux-2.5.59-modfix/drivers/char/synclinkmp.c
--- linux-2.5.59/drivers/char/synclinkmp.c	Thu Jan 16 18:21:44 2003
+++ linux-2.5.59-modfix/drivers/char/synclinkmp.c	Fri Jan 17 15:47:59 2003
@@ -770,8 +770,6 @@
 		printk("%s(%d):%s open(), old ref count = %d\n",
 			 __FILE__,__LINE__,tty->driver.name, info->count);
 
-	MOD_INC_USE_COUNT;
-
 	/* If port is closing, signal caller to try again */
 	if (tty_hung_up_p(filp) || info->flags & ASYNC_CLOSING){
 		if (info->flags & ASYNC_CLOSING)
@@ -826,7 +824,6 @@
 
 cleanup:
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		if(info->count)
 			info->count--;
 	}
@@ -925,7 +922,6 @@
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s close() exit, count=%d\n", __FILE__,__LINE__,
 			tty->driver.name, info->count);
-	MOD_DEC_USE_COUNT;
 }
 
 /* Called by tty_hangup() when a hangup is signaled.
@@ -1729,7 +1725,6 @@
 		return -EBUSY;
 	}
 	info->netcount=1;
-	MOD_INC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 
 	/* claim resources and init adapter */
@@ -1752,7 +1747,6 @@
 open_fail:
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return err;
 }
@@ -1818,7 +1812,6 @@
 
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return 0;
 }
@@ -3875,6 +3868,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.driver_name = "synclinkmp";
 	serial_driver.name = "ttySLM";
 	serial_driver.major = ttymajor;
diff -X dontdiff -Nru linux-2.5.59/drivers/char/vme_scc.c linux-2.5.59-modfix/drivers/char/vme_scc.c
--- linux-2.5.59/drivers/char/vme_scc.c	Thu Jan 16 18:21:34 2003
+++ linux-2.5.59-modfix/drivers/char/vme_scc.c	Fri Jan 17 15:48:53 2003
@@ -129,6 +129,7 @@
 
 	memset(&scc_driver, 0, sizeof(scc_driver));
 	scc_driver.magic = TTY_DRIVER_MAGIC;
+	scc_driver.owner = THIS_MODULE;
 	scc_driver.driver_name = "scc";
 #ifdef CONFIG_DEVFS_FS
 	scc_driver.name = "tts/%d";
@@ -795,7 +796,6 @@
 {
 	scc_disable_tx_interrupts(ptr);
 	scc_disable_rx_interrupts(ptr);
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -803,7 +803,6 @@
 {
 	scc_disable_tx_interrupts(ptr);
 	scc_disable_rx_interrupts(ptr);
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -938,13 +937,9 @@
 		return retval;
 	}
 	port->gs.flags |= GS_ACTIVE;
-	if (port->gs.count == 1) {
-		MOD_INC_USE_COUNT;
-	}
 	retval = gs_block_til_ready(port, filp);
 
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		port->gs.count--;
 		return retval;
 	}
diff -X dontdiff -Nru linux-2.5.59/drivers/isdn/capi/capi.c linux-2.5.59-modfix/drivers/isdn/capi/capi.c
--- linux-2.5.59/drivers/isdn/capi/capi.c	Thu Jan 16 18:22:45 2003
+++ linux-2.5.59-modfix/drivers/isdn/capi/capi.c	Sat Jan 18 11:09:31 2003
@@ -200,10 +200,8 @@
 	unsigned int minor = 0;
 	unsigned long flags;
   
-  	MOD_INC_USE_COUNT;
 	mp = kmalloc(sizeof(*mp), GFP_ATOMIC);
   	if (!mp) {
-  		MOD_DEC_USE_COUNT;
   		printk(KERN_ERR "capi: can't alloc capiminor\n");
 		return 0;
 	}
@@ -249,7 +247,6 @@
 	skb_queue_purge(&mp->outqueue);
 	capiminor_del_all_ack(mp);
 	kfree(mp);
-	MOD_DEC_USE_COUNT;
 }
 
 struct capiminor *capiminor_find(unsigned int minor)
@@ -1282,6 +1279,7 @@
 	
 	memset(drv, 0, sizeof(struct tty_driver));
 	drv->magic = TTY_DRIVER_MAGIC;
+	drv->owner = THIS_MODULE;
 	drv->driver_name = "capi_nc";
 	drv->name = "capi/%d";
 	drv->major = capi_ttymajor;
@@ -1462,7 +1460,6 @@
 	char *p;
 	char *compileinfo;
 
-	MOD_INC_USE_COUNT;
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
 		strncpy(rev, p + 2, sizeof(rev));
@@ -1474,7 +1471,6 @@
 
 	if (register_chrdev(capi_major, "capi20", &capi_fops)) {
 		printk(KERN_ERR "capi20: unable to get major %d\n", capi_major);
-		MOD_DEC_USE_COUNT;
 		return -EIO;
 	}
 
@@ -1486,7 +1482,6 @@
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 	if (capinc_tty_init() < 0) {
 		unregister_chrdev(capi_major, "capi20");
-		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
@@ -1505,7 +1500,6 @@
 	printk(KERN_NOTICE "capi20: Rev %s: started up with major %d%s\n",
 				rev, capi_major, compileinfo);
 
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
diff -X dontdiff -Nru linux-2.5.59/drivers/macintosh/macserial.c linux-2.5.59-modfix/drivers/macintosh/macserial.c
--- linux-2.5.59/drivers/macintosh/macserial.c	Thu Jan 16 18:22:49 2003
+++ linux-2.5.59-modfix/drivers/macintosh/macserial.c	Sat Jan 18 11:10:52 2003
@@ -1935,7 +1935,6 @@
 	save_flags(flags); cli();
 
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
@@ -1959,7 +1958,6 @@
 		info->count = 0;
 	}
 	if (info->count) {
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
@@ -2029,7 +2027,6 @@
 	info->flags &= ~(ZILOG_NORMAL_ACTIVE|ZILOG_CALLOUT_ACTIVE|
 			 ZILOG_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -2236,17 +2233,14 @@
 	int 			retval, line;
 	unsigned long		page;
 
-	MOD_INC_USE_COUNT;
 	line = minor(tty->device) - tty->driver.minor_start;
 	if ((line < 0) || (line >= zs_channels_found)) {
-		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 	info = zs_soft + line;
 
 #ifdef CONFIG_KGDB
 	if (info->kgdb_channel) {
-		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 #endif
@@ -2616,6 +2610,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.driver_name = "macserial";
 #ifdef CONFIG_DEVFS_FS
 	serial_driver.name = "tts/%d";
diff -X dontdiff -Nru linux-2.5.59/drivers/s390/char/con3215.c linux-2.5.59-modfix/drivers/s390/char/con3215.c
--- linux-2.5.59/drivers/s390/char/con3215.c	Thu Jan 16 18:22:23 2003
+++ linux-2.5.59-modfix/drivers/s390/char/con3215.c	Sat Jan 18 11:54:11 2003
@@ -1177,6 +1177,7 @@
 
 	memset(&tty3215_driver, 0, sizeof(struct tty_driver));
 	tty3215_driver.magic = TTY_DRIVER_MAGIC;
+	tty3215_driver.owner = THIS_MODULE;
 	tty3215_driver.driver_name = "tty3215";
 	tty3215_driver.name = "ttyS";
 	tty3215_driver.name_base = 0;
diff -X dontdiff -Nru linux-2.5.59/drivers/s390/char/sclp_tty.c linux-2.5.59-modfix/drivers/s390/char/sclp_tty.c
--- linux-2.5.59/drivers/s390/char/sclp_tty.c	Thu Jan 16 18:21:39 2003
+++ linux-2.5.59-modfix/drivers/s390/char/sclp_tty.c	Sat Jan 18 11:52:25 2003
@@ -743,6 +743,7 @@
 
 	memset (&sclp_tty_driver, 0, sizeof(struct tty_driver));
 	sclp_tty_driver.magic = TTY_DRIVER_MAGIC;
+	sclp_tty_driver.owner = THIS_MODULE;
 	sclp_tty_driver.driver_name = "tty_sclp";
 	sclp_tty_driver.name = "ttyS";
 	sclp_tty_driver.name_base = 0;
diff -X dontdiff -Nru linux-2.5.59/drivers/s390/char/tuball.c linux-2.5.59-modfix/drivers/s390/char/tuball.c
--- linux-2.5.59/drivers/s390/char/tuball.c	Thu Jan 16 18:22:30 2003
+++ linux-2.5.59-modfix/drivers/s390/char/tuball.c	Sat Jan 18 11:12:12 2003
@@ -216,18 +216,6 @@
 }
 #endif /* Not a MODULE or a MODULE */
 
-void
-tub_inc_use_count(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-void
-tub_dec_use_count(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static int
 tub3270_is_ours(s390_dev_info_t *dp)
 {
diff -X dontdiff -Nru linux-2.5.59/drivers/s390/char/tubfs.c linux-2.5.59-modfix/drivers/s390/char/tubfs.c
--- linux-2.5.59/drivers/s390/char/tubfs.c	Thu Jan 16 18:22:19 2003
+++ linux-2.5.59-modfix/drivers/s390/char/tubfs.c	Sat Jan 18 11:44:04 2003
@@ -119,7 +119,6 @@
 		return -EBUSY;
 	}
 
-	tub_inc_use_count();
 	fp->private_data = ip;
 	tubp->mode = TBM_FS;
 	tubp->intv = fs3270_int;
@@ -145,7 +144,6 @@
 	fs3270_wait(tubp, &flags);
 	tubp->fsopen = 0;
 	tubp->fs_pid = 0;
-	tub_dec_use_count();
 	tubp->intv = NULL;
 	tubp->mode = 0;
 	tty3270_refresh(tubp);
@@ -166,7 +164,6 @@
 	fs3270_wait(tubp, &flags);
 	tubp->fsopen = 0;
 	tubp->fs_pid = 0;
-	tub_dec_use_count();
 	tubp->intv = NULL;
 	tubp->mode = 0;
 	/*tty3270_refresh(tubp);*/
diff -X dontdiff -Nru linux-2.5.59/drivers/s390/char/tubio.h linux-2.5.59-modfix/drivers/s390/char/tubio.h
--- linux-2.5.59/drivers/s390/char/tubio.h	Thu Jan 16 18:22:13 2003
+++ linux-2.5.59-modfix/drivers/s390/char/tubio.h	Sat Jan 18 11:57:23 2003
@@ -421,8 +421,6 @@
 	return tubp;
 }
 
-extern void tub_inc_use_count(void);
-extern void tub_dec_use_count(void);
 extern int tub3270_movedata(bcb_t *, bcb_t *, int);
 #if 0
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
diff -X dontdiff -Nru linux-2.5.59/drivers/s390/char/tubtty.c linux-2.5.59-modfix/drivers/s390/char/tubtty.c
--- linux-2.5.59/drivers/s390/char/tubtty.c	Thu Jan 16 18:22:29 2003
+++ linux-2.5.59-modfix/drivers/s390/char/tubtty.c	Sat Jan 18 11:57:48 2003
@@ -80,6 +80,7 @@
 
 	/* Initialize for tty driver */
 	td->magic = TTY_DRIVER_MAGIC;
+	td->owner = THIS_MODULE;
 	td->driver_name = "tty3270";
 	td->name = "tty3270";
 	td->major = IBM_TTY3270_MAJOR;
@@ -189,7 +190,6 @@
 		return -ENODEV;
 	}
 
-	tub_inc_use_count();
 	if ((rc = tty3270_wait(tubp, &flags)) != 0)
 		goto do_fail;
 	if (tubp->lnopen > 0) {
@@ -231,7 +231,6 @@
 	tty3270_aid_fini(tubp);
 	tty3270_rcl_fini(tubp);
 	TUBUNLOCK(tubp->irq, flags);
-	tub_dec_use_count();
 	return rc;
 }
 
@@ -253,7 +252,6 @@
 	tty3270_rcl_fini(tubp);
 	tty3270_scl_fini(tubp);
 do_return:
-	tub_dec_use_count();
 	TUBUNLOCK(tubp->irq, flags);
 }
 

--==========1831449384==========
Content-Type: application/x-gzip; name="282_patches.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="282_patches.tar.gz"; size=11551

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

--==========1831449384==========--

