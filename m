Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262698AbSJGSRb>; Mon, 7 Oct 2002 14:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262701AbSJGSRa>; Mon, 7 Oct 2002 14:17:30 -0400
Received: from 200-171-183-235.dsl.telesp.net.br ([200.171.183.235]:22024 "EHLO
	techlinux.com.br") by vger.kernel.org with ESMTP id <S262698AbSJGSRK>;
	Mon, 7 Oct 2002 14:17:10 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40 (-ac5) - unresolved symbols and cli/sti
Date: Mon, 7 Oct 2002 15:22:48 -0300
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210071522.48109.carlos@techlinux.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -uar --exclude=*.o --exclude=.* --exclude=*~ linux-2.5.40-ac5/drivers/char/ftape/lowlevel/fdc-io.c linux-2.5/drivers/char/ftape/lowlevel/fdc-io.c
--- linux-2.5.40-ac5/drivers/char/ftape/lowlevel/fdc-io.c	Tue Oct  1 04:06:25 2002
+++ linux-2.5/drivers/char/ftape/lowlevel/fdc-io.c	Mon Oct  7 07:45:26 2002
@@ -82,6 +82,7 @@
 static int fdc_fifo_locked;	/* has fifo && lock set ? */
 static __u8 fdc_precomp;	/* default precomp. value (nsec) */
 static __u8 fdc_prec_code;	/* fdc precomp. select code */
+static spinlock_t retry_lock;
 
 static char ftape_id[] = "ftape";  /* used by request irq and free irq */
 
@@ -89,14 +90,13 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&retry_lock, flags);
 	if (count == 0) {
 		ft_expected_stray_interrupts = 0;
 	} else {
 		ft_expected_stray_interrupts += count;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 }
 
 /*  Wait during a timeout period for a given FDC status.
@@ -194,8 +194,7 @@
 	TRACE_FUN(ft_t_any);
 
 	fdc_usec_wait(FT_RQM_DELAY);	/* wait for valid RQM status */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&retry_lock, flags);
 #if LINUX_VERSION_CODE >= KERNEL_VER(2,1,30)
 	if (!in_interrupt())
 #else
@@ -223,7 +222,7 @@
 		 * "fdc_read timeout" errors, I HOPE :-)
 		 */
 		if (ft_hide_interrupt) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&retry_lock, flags);
 			TRACE(ft_t_info,
 			      "Waiting for the isr() completing fdc_seek()");
 			if (fdc_interrupt_wait(2 * FT_SECOND) < 0) {
@@ -246,12 +245,11 @@
 
 			}
 			fdc_usec_wait(FT_RQM_DELAY);	/* wait for valid RQM status */
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&retry_lock, flags);
 		}
 	fdc_status = inb(fdc.msr);
 	if ((fdc_status & FDC_DATA_READY_MASK) != FDC_DATA_IN_READY) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&retry_lock, flags);
 		TRACE_ABORT(-EBUSY, ft_t_err, "fdc not ready");
 	} 
 	fdc_mode = *cmd_data;	/* used by isr */
@@ -301,7 +299,7 @@
 		last_time = ftape_timestamp();
 	}
 #endif
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 	TRACE_EXIT result;
 }
 
@@ -317,15 +315,14 @@
 	int retry = 0;
 	TRACE_FUN(ft_t_any);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&retry_lock, flags);
 	fdc_status = inb(fdc.msr);
 	if ((fdc_status & FDC_DATA_READY_MASK) != FDC_DATA_OUT_READY) {
 		TRACE(ft_t_err, "fdc not ready");
 		result = -EBUSY;
 	} else while (count) {
 		if (!(fdc_status & FDC_BUSY)) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&retry_lock, flags);
 			TRACE_ABORT(-EIO, ft_t_err, "premature end of result phase");
 		}
 		result = fdc_read(res_data);
@@ -348,7 +345,7 @@
 			++res_data;
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 	fdc_usec_wait(FT_RQM_DELAY);	/* allow FDC to negate BSY */
 	TRACE_EXIT result;
 }
@@ -627,15 +624,13 @@
 	unsigned long flags;
 	TRACE_FUN(ft_t_any);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&retry_lock, flags);
 
 	fdc_dor_reset(1); /* keep unit selected */
 
 	fdc_mode = fdc_idle;
 
-	/*  maybe the cli()/sti() pair is not necessary, BUT:
-	 *  the following line MUST be here. Otherwise fdc_interrupt_wait()
+	/*  The following line MUST be here. Otherwise fdc_interrupt_wait()
 	 *  won't wait. Note that fdc_reset() is called from 
 	 *  ftape_dumb_stop() when the fdc is busy transferring data. In this
 	 *  case fdc_isr() MOST PROBABLY sets ft_interrupt_seen, and tries
@@ -647,7 +642,7 @@
 	 */
 	fdc_update_dsr();               /* restore data rate and precomp */
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 
         /*
          *	Wait for first polling cycle to complete
@@ -946,16 +941,15 @@
 	 */
         TRACE(ft_t_fdc_dma,
 	      "phys. addr. = %lx", virt_to_bus((void*) buff->ptr));
-	save_flags(flags);
-	cli();			/* could be called from ISR ! */
+	spin_lock_irqsave(&retry_lock, flags);
 	fdc_setup_dma(DMA_MODE_WRITE, buff->ptr, FT_SECTORS_PER_SEGMENT * 4);
 	/* Issue FDC command to start reading/writing.
 	 */
 	out[1] = ft_drive_sel;
 	out[4] = buff->gap3;
 	TRACE_CATCH(fdc_setup_error = fdc_command(out, sizeof(out)),
-		    restore_flags(flags); fdc_mode = fdc_idle);
-	restore_flags(flags);
+		    spin_unlock_irqrestore(&retry_lock, flags); fdc_mode = fdc_idle);
+	spin_unlock_irqrestore(&retry_lock, flags);
 	TRACE_EXIT 0;
 }
 
@@ -998,8 +992,9 @@
 			    ft_t_bug, "bug: illegal operation parameter");
 	}
 	TRACE(ft_t_fdc_dma, "phys. addr. = %lx",virt_to_bus((void*)buff->ptr));
-	save_flags(flags);
-	cli();			/* could be called from ISR ! */
+
+	spin_lock_irqsave(&retry_lock, flags);
+		
 	if (operation != FDC_VERIFY) {
 		fdc_setup_dma(dma_mode, buff->ptr,
 			      FT_SECTOR_SIZE * buff->sector_count);
@@ -1017,7 +1012,7 @@
 	out[8] = 0xff;		/* No limit to transfer size. */
 	TRACE(ft_t_fdc_dma, "C: 0x%02x, H: 0x%02x, R: 0x%02x, cnt: 0x%02x",
 		out[2], out[3], out[4], out[6] - out[4] + 1);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 	TRACE_CATCH(fdc_setup_error = fdc_command(out, 9),fdc_mode = fdc_idle);
 	TRACE_EXIT 0;
 }
diff -uar --exclude=*.o --exclude=.* --exclude=*~ linux-2.5.40-ac5/drivers/char/ftape/lowlevel/fdc-isr.c linux-2.5/drivers/char/ftape/lowlevel/fdc-isr.c
--- linux-2.5.40-ac5/drivers/char/ftape/lowlevel/fdc-isr.c	Tue Oct  1 04:06:27 2002
+++ linux-2.5/drivers/char/ftape/lowlevel/fdc-isr.c	Mon Oct  7 13:11:41 2002
@@ -1091,7 +1091,6 @@
 				      */
 		TRACE_EXIT;
 	}
-	sti();
 	if (inb_p(fdc.msr) & FDC_BUSY) {	/*  Entering Result Phase */
 		ft_hide_interrupt = 0;
 		handle_fdc_busy(ftape_get_buffer(ft_queue_head));
diff -uar --exclude=*.o --exclude=.* --exclude=*~ linux-2.5.40-ac5/drivers/char/ftape/lowlevel/ftape-calibr.c linux-2.5/drivers/char/ftape/lowlevel/ftape-calibr.c
--- linux-2.5.40-ac5/drivers/char/ftape/lowlevel/ftape-calibr.c	Tue Oct  1 04:06:27 2002
+++ linux-2.5/drivers/char/ftape/lowlevel/ftape-calibr.c	Mon Oct  7 12:54:23 2002
@@ -49,6 +49,8 @@
 static unsigned long ps_per_cycle = 0;
 #endif
 
+static spinlock_t retry_lock;
+
 /*
  * Note: On Intel PCs, the clock ticks at 100 Hz (HZ==100) which is
  * too slow for certain timeouts (and that clock doesn't even tick
@@ -75,13 +77,12 @@
 	__u16 lo;
 	__u16 hi;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&retry_lock, flags);
 	outb_p(0x00, 0x43);	/* latch the count ASAP */
 	lo = inb_p(0x40);	/* read the latched count */
 	lo |= inb(0x40) << 8;
 	hi = jiffies;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 	return ((hi + 1) * (unsigned int) LATCH) - lo;  /* downcounter ! */
 #endif
 }
@@ -94,12 +95,11 @@
 	unsigned int count;
  	unsigned long flags;
  
- 	save_flags(flags);
- 	cli();
+	spin_lock_irqsave(&retry_lock, flags);
  	outb_p(0x00, 0x43);	/* latch the count ASAP */
 	count = inb_p(0x40);	/* read the latched count */
 	count |= inb(0x40) << 8;
- 	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 	return (LATCH - count);	/* normal: downcounter */
 #endif
 }
@@ -150,14 +150,13 @@
 	int status;
 	TRACE_FUN(ft_t_any);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&retry_lock, flags);
 	t0 = short_ftape_timestamp();
 	for (i = 0; i < 1000; ++i) {
 		status = inb(fdc.msr);
 	}
 	t1 = short_ftape_timestamp();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&retry_lock, flags);
 	TRACE(ft_t_info, "inb() duration: %d nsec", ftape_timediff(t0, t1));
 	TRACE_EXIT;
 }
@@ -241,8 +240,7 @@
 
 		*calibr_count =
 		*calibr_time = count;	/* set TC to 1 */
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&retry_lock, flags);
 		fun(0);		/* dummy, get code into cache */
 		t0 = short_ftape_timestamp();
 		fun(0);		/* overhead + one test */
@@ -252,7 +250,7 @@
 		fun(count);		/* overhead + count tests */
 		t1 = short_ftape_timestamp();
 		multiple = diff(t0, t1);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&retry_lock, flags);
 		time = ftape_timediff(0, multiple - once);
 		tc = (1000 * time) / (count - 1);
 		TRACE(ft_t_any, "once:%3d us,%6d times:%6d us, TC:%5d ns",
diff -uar --exclude=*.o --exclude=.* --exclude=*~ linux-2.5.40-ac5/drivers/char/ftape/lowlevel/ftape-format.c linux-2.5/drivers/char/ftape/lowlevel/ftape-format.c
--- linux-2.5.40-ac5/drivers/char/ftape/lowlevel/ftape-format.c	Tue Oct  1 04:06:59 2002
+++ linux-2.5/drivers/char/ftape/lowlevel/ftape-format.c	Mon Oct  7 12:55:27 2002
@@ -44,6 +44,8 @@
 #define FT_FMT_SEGS_PER_BUF (FT_BUFF_SIZE/(4*FT_SECTORS_PER_SEGMENT))
 #endif
 
+static spinlock_t retry_lock;
+
 /*
  *  first segment of the new buffer
  */
@@ -129,9 +131,9 @@
 	head->status = formatting;
 	TRACE_CATCH(ftape_seek_head_to_track(track),);
 	TRACE_CATCH(ftape_command(QIC_LOGICAL_FORWARD),);
-	save_flags(flags); cli();
-	TRACE_CATCH(fdc_setup_formatting(head), restore_flags(flags));
-	restore_flags(flags);	
+	spin_lock_irqsave(&retry_lock, flags);
+	TRACE_CATCH(fdc_setup_formatting(head), spin_unlock_irqrestore(&retry_lock, flags));
+	spin_unlock_irqrestore(&retry_lock, flags);
 	TRACE_EXIT 0;
 }
 
diff -uar --exclude=*.o --exclude=.* --exclude=*~ linux-2.5.40-ac5/drivers/char/ftape/lowlevel/ftape-io.c linux-2.5/drivers/char/ftape/lowlevel/ftape-io.c
--- linux-2.5.40-ac5/drivers/char/ftape/lowlevel/ftape-io.c	Tue Oct  1 04:06:28 2002
+++ linux-2.5/drivers/char/ftape/lowlevel/ftape-io.c	Mon Oct  7 12:57:43 2002
@@ -60,6 +60,8 @@
 static unsigned int ftape_udelay_count;
 static unsigned int ftape_udelay_time;
 
+static spinlock_t retry_lock;
+
 void ftape_udelay(unsigned int usecs)
 {
 	volatile int count = (ftape_udelay_count * usecs +
@@ -94,8 +96,7 @@
 
 		TRACE(ft_t_any, "%d msec, %d ticks", time/1000, ticks);
 		timeout = ticks;
-		save_flags(flags);
-		sti();
+		spin_lock_irqsave(&retry_lock, flags);
 		set_current_state(TASK_INTERRUPTIBLE);
 		do {
 			/*  Mmm. Isn't current->blocked == 0xffffffff ?
@@ -109,7 +110,7 @@
 				timeout = schedule_timeout(timeout);
 			}
 		} while (timeout);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&retry_lock, flags);
 	}
 	TRACE_EXIT;
 }
diff -uar --exclude=*.o --exclude=.* --exclude=*~ linux-2.5.40-ac5/drivers/char/tpqic02.c linux-2.5/drivers/char/tpqic02.c
--- linux-2.5.40-ac5/drivers/char/tpqic02.c	Tue Oct  1 04:06:59 2002
+++ linux-2.5/drivers/char/tpqic02.c	Mon Oct  7 12:50:18 2002
@@ -1453,6 +1453,7 @@
 {
 	int stat;
 	unsigned long flags;
+	static spinlock_t lock;
 
 	tpqputs(TPQD_DEBUG, "start_dma() enter");
 	TPQDEB( {printk(TPQIC02_NAME ": doing_read==%d, doing_write==%d\n",
@@ -1557,10 +1558,9 @@
 
 	/* initiate first data block read from/write to the tape controller */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 	dma_transfer();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 
 	TPQPUTS("start_dma() end");
 	return TE_OK;
diff -uar --exclude=*.o --exclude=.* --exclude=*~ linux-2.5.40-ac5/drivers/i2c/i2c-elektor.c linux-2.5/drivers/i2c/i2c-elektor.c
--- linux-2.5.40-ac5/drivers/i2c/i2c-elektor.c	Tue Oct  1 04:06:13 2002
+++ linux-2.5/drivers/i2c/i2c-elektor.c	Mon Oct  7 13:18:56 2002
@@ -114,15 +114,17 @@
 
 static void pcf_isa_waitforpin(void) {
 
+	unsigned long flags;
+	static spinlock_t lock;
 	int timeout = 2;
 
 	if (irq > 0) {
-		cli();
+		spin_lock_irqsave(&lock, flags);
 		if (pcf_pending == 0) {
 			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
 		} else
 			pcf_pending = 0;
-		sti();
+		spin_unlock_irqrestore(&lock, flags);
 	} else {
 		udelay(100);
 	}
diff -uar --exclude=*.o --exclude=.* --exclude=*~ linux-2.5.40-ac5/kernel/ksyms.c linux-2.5/kernel/ksyms.c
--- linux-2.5.40-ac5/kernel/ksyms.c	Tue Oct  1 04:05:49 2002
+++ linux-2.5/kernel/ksyms.c	Mon Oct  7 14:53:30 2002
@@ -606,5 +606,10 @@
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
 
+#if defined(CONFIG_IP_NF_MATCH_OWNER_MODULE)
+EXPORT_SYMBOL(next_thread);
+EXPORT_SYMBOL(find_task_by_pid);
+#endif
+
 /* debug */
 EXPORT_SYMBOL(dump_stack);
diff -uar --exclude=*.o --exclude=.* --exclude=*~ linux-2.5.40-ac5/net/netsyms.c linux-2.5/net/netsyms.c
--- linux-2.5.40-ac5/net/netsyms.c	Tue Oct  1 04:06:56 2002
+++ linux-2.5/net/netsyms.c	Mon Oct  7 13:34:50 2002
@@ -585,6 +585,10 @@
 #endif
 #endif
 
+#ifdef CONFIG_X25_MODULE
+EXPORT_SYMBOL(sk_send_sigurg);
+#endif
+
 EXPORT_SYMBOL(register_gifconf);
 
 EXPORT_SYMBOL(net_call_rx_atomic);

--

http://www.techlinux.com.br/~carlos/tmp/2.5.40-3.diff

-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________


