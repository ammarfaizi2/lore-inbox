Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVCHNSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVCHNSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVCHNSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:18:02 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7812 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261477AbVCHNQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:16:38 -0500
Subject: PATCH: Ressurrect the esp serial driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110287685.3116.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Mar 2005 13:14:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another first pass rescue run. Fix up for modern locking, make it build
and check over. It could still do with other fixes (sleep_on etc) but
it's a start

Alan

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.11/drivers/char/esp.c	2005-03-05 15:17:01.000000000 +0000
+++ linux-2.6.11/drivers/char/esp.c	2005-03-08 13:02:04.347993528 +0000
@@ -129,8 +129,6 @@
 #undef SERIAL_DEBUG_OPEN
 #undef SERIAL_DEBUG_FLOW
 
-#define _INLINE_ inline
-  
 #if defined(MODULE) && defined(SERIAL_DEBUG_MCOUNT)
 #define DBG_CNT(s) printk("(%s): [%x] refc=%d, serc=%d, ttyc=%d -> %s\n", \
  tty->name, (info->flags), serial_driver.refcount,info->count,tty->count,s)
@@ -211,15 +209,14 @@
 
 	if (serial_paranoia_check(info, tty->name, "rs_stop"))
 		return;
-	
-	save_flags(flags); cli();
+
+	spin_lock_irqsave(&info->lock, flags);	
 	if (info->IER & UART_IER_THRI) {
 		info->IER &= ~UART_IER_THRI;
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
-
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static void rs_start(struct tty_struct *tty)
@@ -230,13 +227,13 @@
 	if (serial_paranoia_check(info, tty->name, "rs_start"))
 		return;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);	
 	if (info->xmit_cnt && info->xmit_buf && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 /*
@@ -264,34 +261,41 @@
  * This routine is used by the interrupt handler to schedule
  * processing in the software interrupt portion of the driver.
  */
-static _INLINE_ void rs_sched_event(struct esp_struct *info,
+static inline void rs_sched_event(struct esp_struct *info,
 				  int event)
 {
 	info->event |= 1 << event;
 	schedule_work(&info->tqueue);
 }
 
-static _INLINE_ struct esp_pio_buffer *get_pio_buffer(void)
+static DEFINE_SPINLOCK(pio_lock);
+
+static inline struct esp_pio_buffer *get_pio_buffer(void)
 {
 	struct esp_pio_buffer *buf;
+	unsigned long flags;
 
+	spin_lock_irqsave(&pio_lock, flags);
 	if (free_pio_buf) {
 		buf = free_pio_buf;
 		free_pio_buf = buf->next;
 	} else {
 		buf = kmalloc(sizeof(struct esp_pio_buffer), GFP_ATOMIC);
 	}
-
+	spin_unlock_irqrestore(&pio_lock, flags);
 	return buf;
 }
 
-static _INLINE_ void release_pio_buffer(struct esp_pio_buffer *buf)
+static inline void release_pio_buffer(struct esp_pio_buffer *buf)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&pio_lock, flags);
 	buf->next = free_pio_buf;
 	free_pio_buf = buf;
+	spin_unlock_irqrestore(&pio_lock, flags);
 }
 
-static _INLINE_ void receive_chars_pio(struct esp_struct *info, int num_bytes)
+static inline void receive_chars_pio(struct esp_struct *info, int num_bytes)
 {
 	struct tty_struct *tty = info->tty;
 	int i;
@@ -311,8 +315,6 @@
 		return;
 	}
 
-	sti();
-	
 	status_mask = (info->read_status_mask >> 2) & 0x07;
 		
 	for (i = 0; i < num_bytes - 1; i += 2) {
@@ -329,8 +331,6 @@
 			(serial_in(info, UART_ESI_RWS) >> 3) & status_mask;
 	}
 
-	cli();
-
 	/* make sure everything is still ok since interrupts were enabled */
 	tty = info->tty;
 
@@ -371,7 +371,7 @@
 	release_pio_buffer(err_buf);
 }
 
-static _INLINE_ void receive_chars_dma(struct esp_struct *info, int num_bytes)
+static inline void receive_chars_dma(struct esp_struct *info, int num_bytes)
 {
 	unsigned long flags;
 	info->stat_flags &= ~ESP_STAT_RX_TIMEOUT;
@@ -390,7 +390,7 @@
         serial_out(info, UART_ESI_CMD1, ESI_START_DMA_RX);
 }
 
-static _INLINE_ void receive_chars_dma_done(struct esp_struct *info,
+static inline void receive_chars_dma_done(struct esp_struct *info,
 					    int status)
 {
 	struct tty_struct *tty = info->tty;
@@ -450,7 +450,9 @@
 		dma_bytes = 0;
 }
 
-static _INLINE_ void transmit_chars_pio(struct esp_struct *info,
+/* Caller must hold info->lock */
+
+static inline void transmit_chars_pio(struct esp_struct *info,
 					int space_avail)
 {
 	int i;
@@ -478,8 +480,6 @@
 		info->xmit_tail = (info->xmit_tail + space_avail) &
 			(ESP_XMIT_SIZE - 1);
 
-		sti();
-
 		for (i = 0; i < space_avail - 1; i += 2) {
 			outw(*((unsigned short *)(pio_buf->data + i)),
 			     info->port + UART_ESI_TX);
@@ -489,8 +489,6 @@
 			serial_out(info, UART_ESI_TX,
 				   pio_buf->data[space_avail - 1]);
 
-		cli();
-
 		if (info->xmit_cnt) {
 			serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
 			serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
@@ -520,7 +518,8 @@
 	release_pio_buffer(pio_buf);
 }
 
-static _INLINE_ void transmit_chars_dma(struct esp_struct *info, int num_bytes)
+/* Caller must hold info->lock */
+static inline void transmit_chars_dma(struct esp_struct *info, int num_bytes)
 {
 	unsigned long flags;
 	
@@ -567,7 +566,7 @@
         serial_out(info, UART_ESI_CMD1, ESI_START_DMA_TX);
 }
 
-static _INLINE_ void transmit_chars_dma_done(struct esp_struct *info)
+static inline void transmit_chars_dma_done(struct esp_struct *info)
 {
 	int num_bytes;
 	unsigned long flags;
@@ -601,7 +600,7 @@
 	}
 }
 
-static _INLINE_ void check_modem_status(struct esp_struct *info)
+static inline void check_modem_status(struct esp_struct *info)
 {
 	int	status;
 	
@@ -654,10 +653,10 @@
 	err_status = 0;
 	scratch = serial_in(info, UART_ESI_SID);
 
-	cli();
+	spin_lock(&info->lock);
 	
 	if (!info->tty) {
-		sti();
+		spin_unlock(&info->lock);
 		return IRQ_NONE;
 	}
 
@@ -740,7 +739,7 @@
 #ifdef SERIAL_DEBUG_INTR
 	printk("end.\n");
 #endif
-	sti();
+	spin_unlock(&info->lock);
 	return IRQ_HANDLED;
 }
 
@@ -789,10 +788,12 @@
  * figure out the appropriate timeout for an interrupt chain, routines
  * to initialize and startup a serial port, and routines to shutdown a
  * serial port.  Useful stuff like that.
+ *
+ * Caller should hold lock
  * ---------------------------------------------------------------
  */
 
-static _INLINE_ void esp_basic_init(struct esp_struct * info)
+static inline void esp_basic_init(struct esp_struct * info)
 {
 	/* put ESPC in enhanced mode */
 	serial_out(info, UART_ESI_CMD1, ESI_SET_MODE);
@@ -859,13 +860,13 @@
 	int	retval=0;
         unsigned int num_chars;
 
-	save_flags(flags); cli();
+        spin_lock_irqsave(&info->lock, flags);
 
 	if (info->flags & ASYNC_INITIALIZED)
 		goto out;
 
 	if (!info->xmit_buf) {
-		info->xmit_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+		info->xmit_buf = (unsigned char *)get_zeroed_page(GFP_ATOMIC);
 		retval = -ENOMEM;
 		if (!info->xmit_buf)
 			goto out;
@@ -900,6 +901,8 @@
 
 	if (info->stat_flags & ESP_STAT_NEVER_DMA)
 		info->stat_flags |= ESP_STAT_USE_PIO;
+		
+	spin_unlock_irqrestore(&info->lock, flags);
 
 	/*
 	 * Allocate the IRQ
@@ -915,7 +918,7 @@
 					&info->tty->flags);
 			retval = 0;
 		}
-		goto out;
+		goto out_unlocked;
 	}
 
 	if (!(info->stat_flags & ESP_STAT_USE_PIO) && !dma_buffer) {
@@ -935,6 +938,8 @@
 	}
 
 	info->MCR = UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2;
+	
+	spin_lock_irqsave(&info->lock, flags);
 	serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 	serial_out(info, UART_ESI_CMD2, UART_MCR);
 	serial_out(info, UART_ESI_CMD2, info->MCR);
@@ -951,6 +956,7 @@
 	if (info->tty)
 		clear_bit(TTY_IO_ERROR, &info->tty->flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
+	spin_unlock_irqrestore(&info->lock, flags);
 
 	/*
 	 * Set up the tty->alt_speed kludge
@@ -970,10 +976,12 @@
 	 * set the speed of the serial port
 	 */
 	change_speed(info);
-
 	info->flags |= ASYNC_INITIALIZED;
-	retval = 0;
-out:	restore_flags(flags);
+	return 0;
+	
+out:
+	spin_unlock_irqrestore(&info->lock, flags);
+out_unlocked:
 	return retval;
 }
 
@@ -993,8 +1001,7 @@
 	       info->irq);
 #endif
 	
-	save_flags(flags); cli(); /* Disable interrupts */
-
+	spin_lock_irqsave(&info->lock, flags);
 	/*
 	 * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
 	 * here so the queue might never be waken up
@@ -1003,7 +1010,7 @@
 	wake_up_interruptible(&info->break_wait);
 
 	/* stop a DMA transfer on the port being closed */
-	   
+	/* DMA lock is higher priority always */	   
 	if (info->stat_flags & (ESP_STAT_DMA_RX | ESP_STAT_DMA_TX)) {
 		f=claim_dma_lock();
 		disable_dma(dma);
@@ -1058,7 +1065,7 @@
 		set_bit(TTY_IO_ERROR, &info->tty->flags);
 	
 	info->flags &= ~ASYNC_INITIALIZED;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 /*
@@ -1172,7 +1179,7 @@
 	if (I_IXOFF(info->tty))
 		flow1 |= 0x81;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	/* set baud */
 	serial_out(info, UART_ESI_CMD1, ESI_SET_BAUD);
 	serial_out(info, UART_ESI_CMD2, quot >> 8);
@@ -1218,8 +1225,8 @@
 	serial_out(info, UART_ESI_CMD2, info->config.flow_off);
 	serial_out(info, UART_ESI_CMD2, info->config.flow_on >> 8);
 	serial_out(info, UART_ESI_CMD2, info->config.flow_on);
-
-	restore_flags(flags);
+	
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static void rs_put_char(struct tty_struct *tty, unsigned char ch)
@@ -1233,16 +1240,13 @@
 	if (!tty || !info->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
-	if (info->xmit_cnt >= ESP_XMIT_SIZE - 1) {
-		restore_flags(flags);
-		return;
+	spin_lock_irqsave(&info->lock, flags);
+	if (info->xmit_cnt < ESP_XMIT_SIZE - 1) {
+		info->xmit_buf[info->xmit_head++] = ch;
+		info->xmit_head &= ESP_XMIT_SIZE-1;
+		info->xmit_cnt++;
 	}
-
-	info->xmit_buf[info->xmit_head++] = ch;
-	info->xmit_head &= ESP_XMIT_SIZE-1;
-	info->xmit_cnt++;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static void rs_flush_chars(struct tty_struct *tty)
@@ -1253,16 +1257,18 @@
 	if (serial_paranoia_check(info, tty->name, "rs_flush_chars"))
 		return;
 
+	spin_lock_irqsave(&info->lock, flags);
+
 	if (info->xmit_cnt <= 0 || tty->stopped || !info->xmit_buf)
-		return;
+		goto out;
 
-	save_flags(flags); cli();
 	if (!(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
-	restore_flags(flags);
+out:
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static int rs_write(struct tty_struct * tty,
@@ -1305,7 +1311,7 @@
 		ret += c;
 	}
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 
 	if (info->xmit_cnt && !tty->stopped && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
@@ -1313,7 +1319,7 @@
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 	return ret;
 }
 
@@ -1321,12 +1327,17 @@
 {
 	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
 	int	ret;
+	unsigned long flags;
 				
 	if (serial_paranoia_check(info, tty->name, "rs_write_room"))
 		return 0;
+
+	spin_lock_irqsave(&info->lock, flags);
+
 	ret = ESP_XMIT_SIZE - info->xmit_cnt - 1;
 	if (ret < 0)
 		ret = 0;
+	spin_unlock_irqrestore(&info->lock, flags);
 	return ret;
 }
 
@@ -1342,12 +1353,13 @@
 static void rs_flush_buffer(struct tty_struct *tty)
 {
 	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
+	unsigned long flags;
 				
 	if (serial_paranoia_check(info, tty->name, "rs_flush_buffer"))
 		return;
-	cli();
+	spin_lock_irqsave(&info->lock, flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
-	sti();
+	spin_unlock_irqrestore(&info->lock, flags);
 	tty_wakeup(tty);
 }
 
@@ -1362,6 +1374,7 @@
 static void rs_throttle(struct tty_struct * tty)
 {
 	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
+	unsigned long flags;
 #ifdef SERIAL_DEBUG_THROTTLE
 	char	buf[64];
 	
@@ -1371,19 +1384,20 @@
 
 	if (serial_paranoia_check(info, tty->name, "rs_throttle"))
 		return;
-	
-	cli();
+
+	spin_lock_irqsave(&info->lock, flags);	
 	info->IER &= ~UART_IER_RDI;
 	serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 	serial_out(info, UART_ESI_CMD2, info->IER);
 	serial_out(info, UART_ESI_CMD1, ESI_SET_RX_TIMEOUT);
 	serial_out(info, UART_ESI_CMD2, 0x00);
-	sti();
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static void rs_unthrottle(struct tty_struct * tty)
 {
 	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
+	unsigned long flags;
 #ifdef SERIAL_DEBUG_THROTTLE
 	char	buf[64];
 	
@@ -1394,13 +1408,13 @@
 	if (serial_paranoia_check(info, tty->name, "rs_unthrottle"))
 		return;
 	
-	cli();
+	spin_lock_irqsave(&info->lock, flags);	
 	info->IER |= UART_IER_RDI;
 	serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 	serial_out(info, UART_ESI_CMD2, info->IER);
 	serial_out(info, UART_ESI_CMD1, ESI_SET_RX_TIMEOUT);
 	serial_out(info, UART_ESI_CMD2, info->config.rx_timeout);
-	sti();
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 /*
@@ -1573,6 +1587,7 @@
 	unsigned int change_dma;
 	int retval = 0;
 	struct esp_struct *current_async;
+	unsigned long flags;
 
 	/* Perhaps a non-sysadmin user should be able to do some of these */
 	/* operations.  I haven't decided yet. */
@@ -1628,12 +1643,14 @@
 			
                         /* all ports must use the same DMA channel */
 
+			spin_lock_irqsave(&info->lock, flags);
 			current_async = ports;
 
 			while (current_async) {
 				esp_basic_init(current_async);
 				current_async = current_async->next_port;
 			}
+			spin_unlock_irqrestore(&info->lock, flags);
 		} else {
 			/* DMA mode to PIO mode only */
 			
@@ -1641,8 +1658,10 @@
 				return -EBUSY;
 
 			shutdown(info);
+			spin_lock_irqsave(&info->lock, flags);
 			info->stat_flags |= ESP_STAT_NEVER_DMA;
 			esp_basic_init(info);
+			spin_unlock_irqrestore(&info->lock, flags);
 		}
 	}
 
@@ -1654,13 +1673,14 @@
 
 		info->config.flow_off = new_config.flow_off;
 		info->config.flow_on = new_config.flow_on;
-		save_flags(flags); cli();
+		
+		spin_lock_irqsave(&info->lock, flags);
 		serial_out(info, UART_ESI_CMD1, ESI_SET_FLOW_LVL);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_off >> 8);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_off);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_on >> 8);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_on);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
 
 	if ((new_config.rx_trigger != info->config.rx_trigger) ||
@@ -1669,7 +1689,7 @@
 
 		info->config.rx_trigger = new_config.rx_trigger;
 		info->config.tx_trigger = new_config.tx_trigger;
-		save_flags(flags); cli();
+		spin_lock_irqsave(&info->lock, flags);
 		serial_out(info, UART_ESI_CMD1, ESI_SET_TRIGGER);
 		serial_out(info, UART_ESI_CMD2,
 			   new_config.rx_trigger >> 8);
@@ -1677,14 +1697,14 @@
 		serial_out(info, UART_ESI_CMD2,
 			   new_config.tx_trigger >> 8);
 		serial_out(info, UART_ESI_CMD2, new_config.tx_trigger);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
 
 	if (new_config.rx_timeout != info->config.rx_timeout) {
 		unsigned long flags;
 
 		info->config.rx_timeout = new_config.rx_timeout;
-		save_flags(flags); cli();
+		spin_lock_irqsave(&info->lock, flags);
 
 		if (info->IER & UART_IER_RDI) {
 			serial_out(info, UART_ESI_CMD1,
@@ -1693,7 +1713,7 @@
 				   new_config.rx_timeout);
 		}
 
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
 
 	if (!(info->flags & ASYNC_INITIALIZED))
@@ -1716,11 +1736,12 @@
 {
 	unsigned char status;
 	unsigned int result;
+	unsigned long flags;
 
-	cli();
+	spin_lock_irqsave(&info->lock, flags);
 	serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
 	status = serial_in(info, UART_ESI_STAT1);
-	sti();
+	spin_unlock_irqrestore(&info->lock, flags);
 	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
 	return put_user(result,value);
 }
@@ -1730,6 +1751,7 @@
 {
 	struct esp_struct * info = (struct esp_struct *)tty->driver_data;
 	unsigned char control, status;
+	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
 		return -ENODEV;
@@ -1737,10 +1759,12 @@
 		return -EIO;
 
 	control = info->MCR;
-	cli();
+
+	spin_lock_irqsave(&info->lock, flags);
 	serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
 	status = serial_in(info, UART_ESI_STAT2);
-	sti();
+	spin_unlock_irqrestore(&info->lock, flags);
+
 	return    ((control & UART_MCR_RTS) ? TIOCM_RTS : 0)
 		| ((control & UART_MCR_DTR) ? TIOCM_DTR : 0)
 		| ((status  & UART_MSR_DCD) ? TIOCM_CAR : 0)
@@ -1753,13 +1777,14 @@
 			unsigned int set, unsigned int clear)
 {
 	struct esp_struct * info = (struct esp_struct *)tty->driver_data;
+	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
 		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
 		return -EIO;
 
-	cli();
+	spin_lock_irqsave(&info->lock, flags);
 
 	if (set & TIOCM_RTS)
 		info->MCR |= UART_MCR_RTS;
@@ -1774,7 +1799,8 @@
 	serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 	serial_out(info, UART_ESI_CMD2, UART_MCR);
 	serial_out(info, UART_ESI_CMD2, info->MCR);
-	sti();
+
+	spin_unlock_irqrestore(&info->lock, flags);
 	return 0;
 }
 
@@ -1789,17 +1815,20 @@
 	if (serial_paranoia_check(info, tty->name, "esp_break"))
 		return;
 
-	save_flags(flags); cli();
 	if (break_state == -1) {
+		spin_lock_irqsave(&info->lock, flags);
 		serial_out(info, UART_ESI_CMD1, ESI_ISSUE_BREAK);
 		serial_out(info, UART_ESI_CMD2, 0x01);
+		spin_unlock_irqrestore(&info->lock, flags);
 
+		/* FIXME - new style wait needed here */
 		interruptible_sleep_on(&info->break_wait);
 	} else {
+		spin_lock_irqsave(&info->lock, flags);
 		serial_out(info, UART_ESI_CMD1, ESI_ISSUE_BREAK);
 		serial_out(info, UART_ESI_CMD2, 0x00);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
-	restore_flags(flags);
 }
 
 static int rs_ioctl(struct tty_struct *tty, struct file * file,
@@ -1809,6 +1838,7 @@
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct __user *p_cuser;	/* user space */
 	void __user *argp = (void __user *)arg;
+	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
 		return -ENODEV;
@@ -1849,17 +1879,18 @@
 		 * Caller should use TIOCGICOUNT to see which one it was
 		 */
 		 case TIOCMIWAIT:
-			cli();
+			spin_lock_irqsave(&info->lock, flags);
 			cprev = info->icount;	/* note the counters on entry */
-			sti();
+			spin_unlock_irqrestore(&info->lock, flags);
 			while (1) {
+				/* FIXME: convert to new style wakeup */
 				interruptible_sleep_on(&info->delta_msr_wait);
 				/* see if a signal did it */
 				if (signal_pending(current))
 					return -ERESTARTSYS;
-				cli();
+				spin_lock_irqsave(&info->lock, flags);
 				cnow = info->icount;	/* atomic copy */
-				sti();
+				spin_unlock_irqrestore(&info->lock, flags);
 				if (cnow.rng == cprev.rng &&
 				    cnow.dsr == cprev.dsr && 
 				    cnow.dcd == cprev.dcd &&
@@ -1886,9 +1917,9 @@
 		 *     RI where only 0->1 is counted.
 		 */
 		case TIOCGICOUNT:
-			cli();
+			spin_lock_irqsave(&info->lock, flags);
 			cnow = info->icount;
-			sti();
+			spin_unlock_irqrestore(&info->lock, flags);
 			p_cuser = argp;
 			if (put_user(cnow.cts, &p_cuser->cts) ||
 			    put_user(cnow.dsr, &p_cuser->dsr) ||
@@ -1911,53 +1942,42 @@
 static void rs_set_termios(struct tty_struct *tty, struct termios *old_termios)
 {
 	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
+	unsigned long flags;
 
 	if (   (tty->termios->c_cflag == old_termios->c_cflag)
 	    && (   RELEVANT_IFLAG(tty->termios->c_iflag) 
 		== RELEVANT_IFLAG(old_termios->c_iflag)))
-	  return;
+		return;
 
 	change_speed(info);
 
+	spin_lock_irqsave(&info->lock, flags);
+
 	/* Handle transition to B0 status */
 	if ((old_termios->c_cflag & CBAUD) &&
 		!(tty->termios->c_cflag & CBAUD)) {
 		info->MCR &= ~(UART_MCR_DTR|UART_MCR_RTS);
-		cli();
 		serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 		serial_out(info, UART_ESI_CMD2, UART_MCR);
 		serial_out(info, UART_ESI_CMD2, info->MCR);
-		sti();
 	}
 
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) &&
 		(tty->termios->c_cflag & CBAUD)) {
 		info->MCR |= (UART_MCR_DTR | UART_MCR_RTS);
-		cli();
 		serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 		serial_out(info, UART_ESI_CMD2, UART_MCR);
 		serial_out(info, UART_ESI_CMD2, info->MCR);
-		sti();
 	}
 
+	spin_unlock_irqrestore(&info->lock, flags);
+
 	/* Handle turning of CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) &&
 	    !(tty->termios->c_cflag & CRTSCTS)) {
 		rs_start(tty);
 	}
-
-#if 0
-	/*
-	 * No need to wake up processes in open wait, since they
-	 * sample the CLOCAL flag once, and don't recheck it.
-	 * XXX  It's not clear whether the current behavior is correct
-	 * or not.  Hence, this may change.....
-	 */
-	if (!(old_termios->c_cflag & CLOCAL) &&
-	    (tty->termios->c_cflag & CLOCAL))
-		wake_up_interruptible(&info->open_wait);
-#endif
 }
 
 /*
@@ -1978,7 +1998,7 @@
 	if (!info || serial_paranoia_check(info, tty->name, "rs_close"))
 		return;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	
 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
@@ -2010,6 +2030,8 @@
 		goto out;
 	}
 	info->flags |= ASYNC_CLOSING;
+	
+	spin_unlock_irqrestore(&info->lock, flags);
 	/*
 	 * Now we wait for the transmit buffer to clear; and we notify 
 	 * the line discipline to only process XON/XOFF characters.
@@ -2027,12 +2049,16 @@
 	info->IER &= ~UART_IER_RDI;
 	info->read_status_mask &= ~UART_LSR_DR;
 	if (info->flags & ASYNC_INITIALIZED) {
+	
+		spin_lock_irqsave(&info->lock, flags);
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 
 		/* disable receive timeout */
 		serial_out(info, UART_ESI_CMD1, ESI_SET_RX_TIMEOUT);
 		serial_out(info, UART_ESI_CMD2, 0x00);
+		
+		spin_unlock_irqrestore(&info->lock, flags);
 
 		/*
 		 * Before we drop DTR, make sure the UART transmitter
@@ -2057,8 +2083,10 @@
 	}
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
+	return;
+	
 out:
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
@@ -2076,12 +2104,14 @@
 	if (!char_time)
 		char_time = 1;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
 	serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
 
 	while ((serial_in(info, UART_ESI_STAT1) != 0x03) ||
 		(serial_in(info, UART_ESI_STAT2) != 0xff)) {
+
+		spin_unlock_irqrestore(&info->lock, flags);
 		msleep_interruptible(jiffies_to_msecs(char_time));
 
 		if (signal_pending(current))
@@ -2090,11 +2120,11 @@
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 
+		spin_lock_irqsave(&info->lock, flags);
 		serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
 		serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
 	}
-	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 	set_current_state(TASK_RUNNING);
 }
 
@@ -2174,15 +2204,11 @@
 	printk("block_til_ready before block: ttys%d, count = %d\n",
 	       info->line, info->count);
 #endif
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&info->lock, flags);
 	if (!tty_hung_up_p(filp)) 
 		info->count--;
-	restore_flags(flags);
 	info->blocked_open++;
 	while (1) {
-		save_flags(flags);
-		cli();
 		if ((tty->termios->c_cflag & CBAUD)) {
 			unsigned int scratch;
 
@@ -2194,7 +2220,6 @@
 			serial_out(info, UART_ESI_CMD2,
 				scratch | UART_MCR_DTR | UART_MCR_RTS);
 		}
-		restore_flags(flags);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(info->flags & ASYNC_INITIALIZED)) {
@@ -2224,13 +2249,16 @@
 		printk("block_til_ready blocking: ttys%d, count = %d\n",
 		       info->line, info->count);
 #endif
+		spin_unlock_irqrestore(&info->lock, flags);
 		schedule();
+		spin_lock_irqsave(&info->lock, flags);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;
 	info->blocked_open--;
+	spin_unlock_irqrestore(&info->lock, flags);
 #ifdef SERIAL_DEBUG_OPEN
 	printk("block_til_ready after blocking: ttys%d, count = %d\n",
 	       info->line, info->count);
@@ -2251,6 +2279,7 @@
 {
 	struct esp_struct	*info;
 	int 			retval, line;
+	unsigned long		flags;
 
 	line = tty->index;
 	if ((line < 0) || (line >= NR_PORTS))
@@ -2262,7 +2291,7 @@
 
 	while (info && (info->line != line))
 		info = info->next_port;
-
+	
 	if (!info) {
 		serial_paranoia_check(info, tty->name, "esp_open");
 		return -ENODEV;
@@ -2271,6 +2300,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("esp_open %s, count = %d\n", tty->name, info->count);
 #endif
+	spin_lock_irqsave(&info->lock, flags);
 	info->count++;
 	tty->driver_data = info;
 	info->tty = tty;
@@ -2317,7 +2347,7 @@
  * driver.
  */
  
-static _INLINE_ void show_serial_version(void)
+static inline void show_serial_version(void)
 {
  	printk(KERN_INFO "%s version %s (DMA %u)\n",
 		serial_name, serial_version, dma);
@@ -2327,7 +2357,7 @@
  * This routine is called by espserial_init() to initialize a specific serial
  * port.
  */
-static _INLINE_ int autoconfig(struct esp_struct * info)
+static inline int autoconfig(struct esp_struct * info)
 {
 	int port_detected = 0;
 	unsigned long flags;
@@ -2335,8 +2365,7 @@
 	if (!request_region(info->port, REGION_SIZE, "esp serial"))
 		return -EIO;
 
-	save_flags(flags); cli();
-	
+	spin_lock_irqsave(&info->lock, flags);	
 	/*
 	 * Check for ESP card
 	 */
@@ -2372,7 +2401,7 @@
 	if (!port_detected)
 		release_region(info->port, REGION_SIZE);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 	return (port_detected);
 }
 
@@ -2513,6 +2542,7 @@
 		init_waitqueue_head(&info->close_wait);
 		init_waitqueue_head(&info->delta_msr_wait);
 		init_waitqueue_head(&info->break_wait);
+		spin_lock_init(&info->lock);
 		ports = info;
 		printk(KERN_INFO "ttyP%d at 0x%04x (irq = %d) is an ESP ",
 			info->line, info->port, info->irq);
@@ -2563,18 +2593,14 @@
 
 static void __exit espserial_exit(void) 
 {
-	unsigned long flags;
 	int e1;
 	struct esp_struct *temp_async;
 	struct esp_pio_buffer *pio_buf;
 
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
-	save_flags(flags);
-	cli();
 	if ((e1 = tty_unregister_driver(esp_driver)))
 		printk("SERIAL: failed to unregister serial driver (%d)\n",
 		       e1);
-	restore_flags(flags);
 	put_tty_driver(esp_driver);
 
 	while (ports) {

