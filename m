Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUHEOCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUHEOCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267707AbUHEOB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:01:28 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:46770 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S267705AbUHEN5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:57:09 -0400
Date: Thu, 5 Aug 2004 15:57:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Initial bits to help pull jiffies out of drivers
Message-ID: <20040805135725.GA8471@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> > This is really for comment, the basic idea is to add some relative
> > timer functionality. This gives us timeout objects as well as pulling
> > jiffies use into one place in the timer code. The need for the old
> > interfaces never goes away however because some code uses a previous
> > event base to construct timeouts to avoid sliding due to the latency
> > between service and re-addition.
> 
> My gripe with this is that the interface still is relative-to-HZ time.
> I'm convinced that driver(writers) are better off with an absolute time
> interface, eg add_timeout_ms(), add_timeout_us() etc.
> (which btw also give a hint about the accuracy required, so that the
> kernel can group milisecond delays together even when they got scheduled
> at different usecs, once we get timers that accurate)

This bothered me as well. I think we should try really hard to
get away from jiffies & HZ in the device drivers and hide the
conversion to jiffies in the add_timeout/mod_timeout functions
for now (until one day we can rip out jiffies alltogether).
Arnd Bergmann created a patch for the s390 device driver to
use the timeout interface. Patch is attach for whoever is
interested.

blue skies,
  Martin.

diff -urN linux-2.6.8-rc3/drivers/s390/block/dasd.c linux-2.6.8-rc3-s390/drivers/s390/block/dasd.c
--- linux-2.6.8-rc3/drivers/s390/block/dasd.c	Thu Aug  5 15:34:26 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/block/dasd.c	Thu Aug  5 15:36:57 2004
@@ -747,7 +747,6 @@
 		return -EIO;
 	}
 	cqr->startclk = get_clock();
-	cqr->starttime = jiffies;
 	cqr->retries--;
 	rc = ccw_device_start(device->cdev, cqr->cpaddr, (long) cqr,
 			      cqr->lpm, 0);
@@ -808,17 +807,17 @@
 {
 	if (expires == 0) {
 		if (timer_pending(&device->timer))
-			del_timer(&device->timer);
+			del_timeout(&device->timer);
 		return;
 	}
 	if (timer_pending(&device->timer)) {
-		if (mod_timer(&device->timer, jiffies + expires))
+		if (mod_timeout(&device->timer, expires))
 			return;
 	}
 	device->timer.function = dasd_timeout_device;
 	device->timer.data = (unsigned long) device;
-	device->timer.expires = jiffies + expires;
-	add_timer(&device->timer);
+	device->timer.expires = expires;
+	add_timeout(&device->timer);
 }
 
 /*
@@ -828,7 +827,7 @@
 dasd_clear_timer(struct dasd_device *device)
 {
 	if (timer_pending(&device->timer))
-		del_timer(&device->timer);
+		del_timeout(&device->timer);
 }
 
 static void
@@ -1198,10 +1197,11 @@
 		return;
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
 	if (cqr->status == DASD_CQR_IN_IO && cqr->expires != 0) {
-		if (time_after_eq(jiffies, cqr->expires + cqr->starttime)) {
+		if (get_clock() <= (jiffies_to_clock(cqr->expires)
+						 + cqr->startclk)) {
 			if (device->discipline->term_IO(cqr) != 0)
 				/* Hmpf, try again in 1/10 sec */
-				dasd_set_timer(device, 10);
+				dasd_set_timer(device, (10 * HZ) / 1000);
 		}
 	}
 }
@@ -1478,7 +1478,6 @@
 		/* termination successful */
 		cqr->status = DASD_CQR_QUEUED;
 		cqr->startclk = cqr->stopclk = 0;
-		cqr->starttime = 0;
 	}
 	return rc;
 }
diff -urN linux-2.6.8-rc3/drivers/s390/char/con3215.c linux-2.6.8-rc3-s390/drivers/s390/char/con3215.c
--- linux-2.6.8-rc3/drivers/s390/char/con3215.c	Wed Jun 16 07:19:42 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/char/con3215.c	Thu Aug  5 15:36:57 2004
@@ -300,7 +300,7 @@
 
 	spin_lock_irqsave(raw->lock, flags);
 	if (raw->flags & RAW3215_TIMER_RUNS) {
-		del_timer(&raw->timer);
+		del_timeout(&raw->timer);
 		raw->flags &= ~RAW3215_TIMER_RUNS;
 		raw3215_mk_write_req(raw);
 		raw3215_start_io(raw);
@@ -327,16 +327,16 @@
 			/* execute write requests bigger than minimum size */
 			raw3215_start_io(raw);
 			if (raw->flags & RAW3215_TIMER_RUNS) {
-				del_timer(&raw->timer);
+				del_timeout(&raw->timer);
 				raw->flags &= ~RAW3215_TIMER_RUNS;
 			}
 		} else if (!(raw->flags & RAW3215_TIMER_RUNS)) {
 			/* delay small writes */
 			init_timer(&raw->timer);
-			raw->timer.expires = RAW3215_TIMEOUT + jiffies;
+			raw->timer.expires = RAW3215_TIMEOUT;
 			raw->timer.data = (unsigned long) raw;
 			raw->timer.function = raw3215_timeout;
-			add_timer(&raw->timer);
+			add_timeout(&raw->timer);
 			raw->flags |= RAW3215_TIMER_RUNS;
 		}
 	}
diff -urN linux-2.6.8-rc3/drivers/s390/char/sclp.c linux-2.6.8-rc3-s390/drivers/s390/char/sclp.c
--- linux-2.6.8-rc3/drivers/s390/char/sclp.c	Thu Aug  5 15:34:26 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/char/sclp.c	Thu Aug  5 15:36:57 2004
@@ -132,13 +132,13 @@
 			 * Try again later.
 			 */
 			if (!timer_pending(&sclp_busy_timer) ||
-			    !mod_timer(&sclp_busy_timer,
-				       jiffies + SCLP_BUSY_POLL_INTERVAL*HZ)) {
+			    !mod_timeout(&sclp_busy_timer,
+				       SCLP_BUSY_POLL_INTERVAL*HZ)) {
 				sclp_busy_timer.function =
 					(void *) sclp_start_request;
 				sclp_busy_timer.expires =
-					jiffies + SCLP_BUSY_POLL_INTERVAL*HZ;
-				add_timer(&sclp_busy_timer);
+					SCLP_BUSY_POLL_INTERVAL*HZ;
+				add_timeout(&sclp_busy_timer);
 			}
 			break;
 		}
@@ -648,13 +648,12 @@
 		   change event, so initially, polling is the only alternative
 		   for us to ever become operational. */
 		if (!timer_pending(&retry_timer) ||
-		    !mod_timer(&retry_timer,
-			       jiffies + SCLP_INIT_POLL_INTERVAL*HZ)) {
+		    !mod_timeout(&retry_timer,
+			       SCLP_INIT_POLL_INTERVAL*HZ)) {
 			retry_timer.function = sclp_init_mask_retry;
 			retry_timer.data = 0;
-			retry_timer.expires = jiffies +
-				SCLP_INIT_POLL_INTERVAL*HZ;
-			add_timer(&retry_timer);
+			retry_timer.expires = SCLP_INIT_POLL_INTERVAL*HZ;
+			add_timeout(&retry_timer);
 		}
 	} else {
 		sclp_receive_mask = sccb->sclp_receive_mask;
diff -urN linux-2.6.8-rc3/drivers/s390/char/sclp_con.c linux-2.6.8-rc3-s390/drivers/s390/char/sclp_con.c
--- linux-2.6.8-rc3/drivers/s390/char/sclp_con.c	Wed Jun 16 07:19:23 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/char/sclp_con.c	Thu Aug  5 15:36:57 2004
@@ -150,12 +150,12 @@
 	} while (count > 0);
 	/* Setup timer to output current console buffer after 1/10 second */
 	if (sclp_conbuf != NULL && sclp_chars_in_buffer(sclp_conbuf) != 0 &&
-	    !timer_pending(&sclp_con_timer)) {
+	    !timeout_pending(&sclp_con_timer)) {
 		init_timer(&sclp_con_timer);
 		sclp_con_timer.function = sclp_console_timeout;
 		sclp_con_timer.data = 0UL;
-		sclp_con_timer.expires = jiffies + HZ/10;
-		add_timer(&sclp_con_timer);
+		sclp_con_timer.expires = HZ/10;
+		add_timeout(&sclp_con_timer);
 	}
 	spin_unlock_irqrestore(&sclp_con_lock, flags);
 }
@@ -179,8 +179,7 @@
 
 	sclp_conbuf_emit();
 	spin_lock_irqsave(&sclp_con_lock, flags);
-	if (timer_pending(&sclp_con_timer))
-		del_timer(&sclp_con_timer);
+	del_timeout(&sclp_con_timer);
 	while (sclp_con_buffer_count > 0) {
 		spin_unlock_irqrestore(&sclp_con_lock, flags);
 		sclp_sync_wait();
diff -urN linux-2.6.8-rc3/drivers/s390/char/sclp_rw.c linux-2.6.8-rc3-s390/drivers/s390/char/sclp_rw.c
--- linux-2.6.8-rc3/drivers/s390/char/sclp_rw.c	Wed Jun 16 07:19:22 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/char/sclp_rw.c	Thu Aug  5 15:36:57 2004
@@ -428,9 +428,8 @@
 		/* wait some time, then retry request */
 		buffer->retry_timer.function = sclp_buffer_retry;
 		buffer->retry_timer.data = (unsigned long) buffer;
-		buffer->retry_timer.expires = jiffies +
-						SCLP_BUFFER_RETRY_INTERVAL*HZ;
-		add_timer(&buffer->retry_timer);
+		buffer->retry_timer.expires = SCLP_BUFFER_RETRY_INTERVAL*HZ;
+		add_timeout(&buffer->retry_timer);
 		return;
 
 	default:
diff -urN linux-2.6.8-rc3/drivers/s390/char/sclp_tty.c linux-2.6.8-rc3-s390/drivers/s390/char/sclp_tty.c
--- linux-2.6.8-rc3/drivers/s390/char/sclp_tty.c	Wed Jun 16 07:18:58 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/char/sclp_tty.c	Thu Aug  5 15:36:57 2004
@@ -376,8 +376,8 @@
 			init_timer(&sclp_tty_timer);
 			sclp_tty_timer.function = sclp_tty_timeout;
 			sclp_tty_timer.data = 0UL;
-			sclp_tty_timer.expires = jiffies + HZ/10;
-			add_timer(&sclp_tty_timer);
+			sclp_tty_timer.expires = HZ/10;
+			add_timeout(&sclp_tty_timer);
 		}
 	} else {
 		if (sclp_ttybuf != NULL &&
diff -urN linux-2.6.8-rc3/drivers/s390/char/tape_std.c linux-2.6.8-rc3-s390/drivers/s390/char/tape_std.c
--- linux-2.6.8-rc3/drivers/s390/char/tape_std.c	Wed Jun 16 07:18:37 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/char/tape_std.c	Thu Aug  5 15:36:57 2004
@@ -76,12 +76,12 @@
 	init_timer(&timeout);
 	timeout.function = tape_std_assign_timeout;
 	timeout.data     = (unsigned long) request;
-	timeout.expires  = jiffies + 2 * HZ;
-	add_timer(&timeout);
+	timeout.expires  = 2 * HZ;
+	add_timeout(&timeout);
 
 	rc = tape_do_io_interruptible(device, request);
 
-	del_timer(&timeout);
+	del_timeout(&timeout);
 
 	if (rc != 0) {
 		PRINT_WARN("%s: assign failed - device might be busy\n",
diff -urN linux-2.6.8-rc3/drivers/s390/char/tty3270.c linux-2.6.8-rc3-s390/drivers/s390/char/tty3270.c
--- linux-2.6.8-rc3/drivers/s390/char/tty3270.c	Wed Jun 16 07:19:01 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/char/tty3270.c	Thu Aug  5 15:36:57 2004
@@ -126,19 +126,19 @@
 	if (expires == 0) {
 		if (timer_pending(&tp->timer)) {
 			raw3270_put_view(&tp->view);
-			del_timer(&tp->timer);
+			del_timeout(&tp->timer);
 		}
 		return;
 	}
 	if (timer_pending(&tp->timer)) {
-		if (mod_timer(&tp->timer, jiffies + expires))
+		if (mod_timeout(&tp->timer, expires))
 			return;
 	}
 	raw3270_get_view(&tp->view);
 	tp->timer.function = (void (*)(unsigned long)) tty3270_update;
 	tp->timer.data = (unsigned long) tp;
-	tp->timer.expires = jiffies + expires;
-	add_timer(&tp->timer);
+	tp->timer.expires = expires;
+	add_timeout(&tp->timer);
 }
 
 /*
diff -urN linux-2.6.8-rc3/drivers/s390/cio/device_fsm.c linux-2.6.8-rc3-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6.8-rc3/drivers/s390/cio/device_fsm.c	Thu Aug  5 15:34:27 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/cio/device_fsm.c	Thu Aug  5 15:36:57 2004
@@ -80,17 +80,17 @@
 ccw_device_set_timeout(struct ccw_device *cdev, int expires)
 {
 	if (expires == 0) {
-		del_timer(&cdev->private->timer);
+		del_timeout(&cdev->private->timer);
 		return;
 	}
 	if (timer_pending(&cdev->private->timer)) {
-		if (mod_timer(&cdev->private->timer, jiffies + expires))
+		if (mod_timeout(&cdev->private->timer, expires))
 			return;
 	}
 	cdev->private->timer.function = ccw_device_timeout;
 	cdev->private->timer.data = (unsigned long) cdev;
-	cdev->private->timer.expires = jiffies + expires;
-	add_timer(&cdev->private->timer);
+	cdev->private->timer.expires = expires;
+	add_timeout(&cdev->private->timer);
 }
 
 /*
diff -urN linux-2.6.8-rc3/drivers/s390/crypto/z90main.c linux-2.6.8-rc3-s390/drivers/s390/crypto/z90main.c
--- linux-2.6.8-rc3/drivers/s390/crypto/z90main.c	Wed Jun 16 07:18:38 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/crypto/z90main.c	Thu Aug  5 15:36:57 2004
@@ -677,7 +677,7 @@
 	init_timer(&cleanup_timer);
 	cleanup_timer.function = z90crypt_cleanup_task;
 	cleanup_timer.data = 0;
-	cleanup_timer.expires = jiffies + (CLEANUPTIME * HZ);
+	cleanup_timer.expires = CLEANUPTIME * HZ;
 	add_timer(&cleanup_timer);
 
 	/* Set up the proc file system */
@@ -696,7 +696,7 @@
 	init_timer(&config_timer);
 	config_timer.function = z90crypt_config_task;
 	config_timer.data = 0;
-	config_timer.expires = jiffies + (INITIAL_CONFIGTIME * HZ);
+	config_timer.expires = INITIAL_CONFIGTIME * HZ;
 	add_timer(&config_timer);
 
 	/* Set up the reader task */
@@ -704,7 +704,7 @@
 	init_timer(&reader_timer);
 	reader_timer.function = z90crypt_schedule_reader_task;
 	reader_timer.data = 0;
-	reader_timer.expires = jiffies + (READERTIME * HZ / 1000);
+	reader_timer.expires = READERTIME * HZ / 1000;
 	add_timer(&reader_timer);
 
 	if ((result = z90_register_ioctl32s()))
@@ -2496,7 +2496,7 @@
 {
 	if (timer_pending(&reader_timer))
 		return;
-	if (mod_timer(&reader_timer, jiffies+(READERTIME*HZ/1000)) != 0)
+	if (mod_timeout(&reader_timer, READERTIME*HZ/1000) != 0)
 		PRINTK("Timer pending while modifying reader timer\n");
 }
 
@@ -2508,8 +2508,6 @@
 	unsigned char __user *resp_addr;
 	static unsigned char buff[1024];
 
-	PDEBUG("jiffies %ld\n", jiffies);
-
 	/**
 	 * we use workavail = 2 to ensure 2 passes with nothing dequeued before
 	 * exiting the loop. If remaining == 0 after the loop, there is no work
@@ -2567,7 +2565,7 @@
 {
 	if (timer_pending(&config_timer))
 		return;
-	if (mod_timer(&config_timer, jiffies+(expiration*HZ)) != 0)
+	if (mod_timer(&config_timer, expiration*HZ) != 0)
 		PRINTK("Timer pending while modifying config timer\n");
 }
 
@@ -2576,8 +2574,6 @@
 {
 	int rc;
 
-	PDEBUG("jiffies %ld\n", jiffies);
-
 	if ((rc = refresh_z90crypt(&z90crypt.cdx)))
 		PRINTK("Error %d detected in refresh_z90crypt.\n", rc);
 	/* If return was fatal, don't bother reconfiguring */
@@ -2590,7 +2586,7 @@
 {
 	if (timer_pending(&cleanup_timer))
 		return;
-	if (mod_timer(&cleanup_timer, jiffies+(CLEANUPTIME*HZ)) != 0)
+	if (mod_timer(&cleanup_timer, CLEANUPTIME*HZ) != 0)
 		PRINTK("Timer pending while modifying cleanup timer\n");
 }
 
@@ -2679,7 +2675,6 @@
 static void
 z90crypt_cleanup_task(unsigned long ptr)
 {
-	PDEBUG("jiffies %ld\n", jiffies);
 	spin_lock_irq(&queuespinlock);
 	if (z90crypt.mask.st_count <= 0) // no devices!
 		helper_drain_queues();
diff -urN linux-2.6.8-rc3/drivers/s390/net/ctctty.c linux-2.6.8-rc3-s390/drivers/s390/net/ctctty.c
--- linux-2.6.8-rc3/drivers/s390/net/ctctty.c	Thu Aug  5 15:34:27 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/net/ctctty.c	Thu Aug  5 15:36:57 2004
@@ -475,7 +475,7 @@
 		info->mcr &= ~(UART_MCR_DTR | UART_MCR_RTS);
 	if (info->tty)
 		set_bit(TTY_IO_ERROR, &info->tty->flags);
-	mod_timer(&info->stoptimer, jiffies + (10 * HZ));
+	mod_timeout(&info->stoptimer, 10 * HZ);
 	skb_queue_purge(&info->tx_queue);
 	skb_queue_purge(&info->rx_queue);
 	info->flags &= ~CTC_ASYNC_INITIALIZED;
@@ -1000,7 +1000,7 @@
 {
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 	ulong flags;
-	ulong timeout;
+
 	DBF_TEXT(trace, 3, __FUNCTION__);
 	if (!info || ctc_tty_paranoia_check(info, tty->name, "ctc_tty_close"))
 		return;
@@ -1045,21 +1045,26 @@
 	 * line status register.
 	 */
 	if (info->flags & CTC_ASYNC_INITIALIZED) {
+		struct timer_list t;
 		tty_wait_until_sent(tty, 30*HZ); /* 30 seconds timeout */
 		/*
 		 * Before we drop DTR, make sure the UART transmitter
 		 * has completely drained; this is especially
 		 * important if there is a transmit FIFO!
 		 */
-		timeout = jiffies + HZ;
+		init_timer(&t);
+		t.expires = HZ;
+		t.function = timer_noop;
+		add_timeout(&t);
 		while (!(info->lsr & UART_LSR_TEMT)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock_irqrestore(&ctc_tty_lock, flags);
 			schedule_timeout(HZ/2);
 			spin_lock_irqsave(&ctc_tty_lock, flags);
-			if (time_after(jiffies,timeout))
+			if (!timer_pending(&t))
 				break;
 		}
+		del_timeout(&t);
 	}
 	ctc_tty_shutdown(info);
 	if (tty->driver->flush_buffer) {
diff -urN linux-2.6.8-rc3/drivers/s390/net/fsm.c linux-2.6.8-rc3-s390/drivers/s390/net/fsm.c
--- linux-2.6.8-rc3/drivers/s390/net/fsm.c	Wed Jun 16 07:19:23 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/net/fsm.c	Thu Aug  5 15:36:57 2004
@@ -164,7 +164,7 @@
 	printk(KERN_DEBUG "fsm(%s): Delete timer %p\n", this->fi->name,
 		this);
 #endif
-	del_timer(&this->tl);
+	del_timeout(&this->tl);
 }
 
 int
@@ -181,37 +181,16 @@
 	this->tl.data = (long)this;
 	this->expire_event = event;
 	this->event_arg = arg;
-	this->tl.expires = jiffies + (millisec * HZ) / 1000;
-	add_timer(&this->tl);
+	this->tl.expires = (millisec * HZ) / 1000;
+	add_timeout(&this->tl);
 	return 0;
 }
 
-/* FIXME: this function is never used, why */
-void
-fsm_modtimer(fsm_timer *this, int millisec, int event, void *arg)
-{
-
-#if FSM_TIMER_DEBUG
-	printk(KERN_DEBUG "fsm(%s): Restart timer %p %dms\n",
-		this->fi->name, this, millisec);
-#endif
-
-	del_timer(&this->tl);
-	init_timer(&this->tl);
-	this->tl.function = (void *)fsm_expire_timer;
-	this->tl.data = (long)this;
-	this->expire_event = event;
-	this->event_arg = arg;
-	this->tl.expires = jiffies + (millisec * HZ) / 1000;
-	add_timer(&this->tl);
-}
-
 EXPORT_SYMBOL(init_fsm);
 EXPORT_SYMBOL(kfree_fsm);
 EXPORT_SYMBOL(fsm_settimer);
 EXPORT_SYMBOL(fsm_deltimer);
 EXPORT_SYMBOL(fsm_addtimer);
-EXPORT_SYMBOL(fsm_modtimer);
 EXPORT_SYMBOL(fsm_getstate_str);
 
 #if FSM_DEBUG_HISTORY
diff -urN linux-2.6.8-rc3/drivers/s390/net/fsm.h linux-2.6.8-rc3-s390/drivers/s390/net/fsm.h
--- linux-2.6.8-rc3/drivers/s390/net/fsm.h	Wed Jun 16 07:19:44 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/net/fsm.h	Thu Aug  5 15:36:57 2004
@@ -252,14 +252,4 @@
  */
 extern int fsm_addtimer(fsm_timer *timer, int millisec, int event, void *arg);
 
-/**
- * Modifies a timer of an FSM.
- *
- * @param timer    The timer to modify.
- * @param millisec Duration, after which the timer should expire.
- * @param event    Event, to trigger if timer expires.
- * @param arg      Generic argument, provided to expiry function.
- */
-extern void fsm_modtimer(fsm_timer *timer, int millisec, int event, void *arg);
-
 #endif /* _FSM_H_ */
diff -urN linux-2.6.8-rc3/drivers/s390/net/lcs.c linux-2.6.8-rc3-s390/drivers/s390/net/lcs.c
--- linux-2.6.8-rc3/drivers/s390/net/lcs.c	Thu Aug  5 15:34:27 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/net/lcs.c	Thu Aug  5 15:36:57 2004
@@ -29,6 +29,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/if.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -720,10 +721,10 @@
 	init_timer(&timer);
 	timer.function = lcs_lancmd_timeout;
 	timer.data = (unsigned long) &reply;
-	timer.expires = jiffies + HZ*card->lancmd_timeout;
-	add_timer(&timer);
+	timer.expires = HZ*card->lancmd_timeout;
+	add_timeout(&timer);
 	wait_event(reply.wait_q, reply.received);
-	del_timer(&timer);
+	del_timeout(&timer);
 	LCS_DBF_TEXT_(4, trace, "rc:%d",reply.rc);
 	return reply.rc ? -EIO : 0;
 }
diff -urN linux-2.6.8-rc3/drivers/s390/net/qeth_main.c linux-2.6.8-rc3-s390/drivers/s390/net/qeth_main.c
--- linux-2.6.8-rc3/drivers/s390/net/qeth_main.c	Thu Aug  5 15:34:27 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/net/qeth_main.c	Thu Aug  5 15:36:57 2004
@@ -1771,9 +1771,9 @@
 	timer.function = qeth_cmd_timeout;
 	timer.data = (unsigned long) reply;
 	if (IS_IPA(iob->data))
-		timer.expires = jiffies + QETH_IPA_TIMEOUT;
+		timer.expires = QETH_IPA_TIMEOUT;
 	else
-		timer.expires = jiffies + QETH_TIMEOUT;
+		timer.expires = QETH_TIMEOUT;
 	init_waitqueue_head(&reply->wait_q);
 	spin_lock_irqsave(&card->lock, flags);
 	list_add_tail(&reply->list, &card->cmd_waiter_list);
@@ -1799,9 +1799,9 @@
 		wake_up(&card->wait_q);
 		return rc;
 	}
-	add_timer(&timer);
+	add_timeout(&timer);
 	wait_event(reply->wait_q, reply->received);
-	del_timer(&timer);
+	del_timeout(&timer);
 	rc = reply->rc;
 	qeth_put_reply(reply);
 	return rc;
diff -urN linux-2.6.8-rc3/drivers/s390/scsi/zfcp_erp.c linux-2.6.8-rc3-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6.8-rc3/drivers/s390/scsi/zfcp_erp.c	Thu Aug  5 15:34:27 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/scsi/zfcp_erp.c	Thu Aug  5 15:36:57 2004
@@ -1560,8 +1560,8 @@
 	init_timer(&erp_action->timer);
 	erp_action->timer.function = zfcp_erp_memwait_handler;
 	erp_action->timer.data = (unsigned long) erp_action;
-	erp_action->timer.expires = jiffies + ZFCP_ERP_MEMWAIT_TIMEOUT;
-	add_timer(&erp_action->timer);
+	erp_action->timer.expires = ZFCP_ERP_MEMWAIT_TIMEOUT;
+	add_timeout(&erp_action->timer);
 
 	return retval;
 }
@@ -3292,7 +3292,6 @@
 	init_timer(&erp_action->timer);
 	erp_action->timer.function = zfcp_erp_timeout_handler;
 	erp_action->timer.data = (unsigned long) erp_action;
-	/* jiffies will be added in zfcp_fsf_req_send */
 	erp_action->timer.expires = ZFCP_ERP_FSFREQ_TIMEOUT;
 }
 
diff -urN linux-2.6.8-rc3/drivers/s390/scsi/zfcp_fsf.c linux-2.6.8-rc3-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6.8-rc3/drivers/s390/scsi/zfcp_fsf.c	Thu Aug  5 15:34:27 2004
+++ linux-2.6.8-rc3-s390/drivers/s390/scsi/zfcp_fsf.c	Thu Aug  5 15:36:57 2004
@@ -1154,7 +1154,7 @@
 	zfcp_fsf_start_scsi_er_timer(adapter);
 	retval = zfcp_fsf_req_send(fsf_req, NULL);
 	if (retval) {
-		del_timer(&adapter->scsi_er_timer);
+		del_timeout(&adapter->scsi_er_timer);
 		ZFCP_LOG_INFO("error: Failed to send abort command request "
 			      "on adapter %s, port 0x%016Lx, unit 0x%016Lx\n",
 			      zfcp_get_busid_by_adapter(adapter),
@@ -1190,7 +1190,7 @@
 	unsigned char status_qual =
 	    new_fsf_req->qtcb->header.fsf_status_qual.word[0];
 
-	del_timer(&new_fsf_req->adapter->scsi_er_timer);
+	del_timeout(&new_fsf_req->adapter->scsi_er_timer);
 
 	if (new_fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR) {
 		/* do not set ZFCP_STATUS_FSFREQ_ABORTSUCCEEDED */
@@ -3581,7 +3581,7 @@
 	zfcp_fsf_start_scsi_er_timer(adapter);
 	retval = zfcp_fsf_req_send(fsf_req, NULL);
 	if (retval) {
-		del_timer(&adapter->scsi_er_timer);
+		del_timeout(&adapter->scsi_er_timer);
 		ZFCP_LOG_INFO("error: Could not send an FCP-command (task "
 			      "management) on adapter %s, port 0x%016Lx for "
 			      "unit LUN 0x%016Lx\n",
@@ -4278,7 +4278,7 @@
 	struct zfcp_unit *unit =
 	    fsf_req->data.send_fcp_command_task_management.unit;
 
-	del_timer(&fsf_req->adapter->scsi_er_timer);
+	del_timeout(&fsf_req->adapter->scsi_er_timer);
 	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR) {
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_TMFUNCFAILED;
 		goto skip_fsfstatus;
@@ -4877,10 +4877,8 @@
 	list_add_tail(&fsf_req->list, &adapter->fsf_req_list_head);
 	write_unlock_irqrestore(&adapter->fsf_req_list_lock, flags);
 
-	/* figure out expiration time of timeout and start timeout */
 	if (unlikely(timer)) {
-		timer->expires += jiffies;
-		add_timer(timer);
+		add_timeout(timer);
 	}
 
 	ZFCP_LOG_TRACE("request queue of adapter %s: "
diff -urN linux-2.6.8-rc3/include/asm-s390/timex.h linux-2.6.8-rc3-s390/include/asm-s390/timex.h
--- linux-2.6.8-rc3/include/asm-s390/timex.h	Wed Jun 16 07:18:52 2004
+++ linux-2.6.8-rc3-s390/include/asm-s390/timex.h	Thu Aug  5 15:36:57 2004
@@ -37,4 +37,8 @@
 	return clk;
 }
 
+#define clock_to_jiffies(clk) ((((unsigned long)(a) >> 12)) / (1000000 / HZ))
+#define jiffies_to_clock(jiffies) ((unsigned long long) \
+				(4096ull * 1000ull * 1000ull / HZ * jiffies))
+
 #endif

