Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTE0VmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbTE0VmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:42:01 -0400
Received: from front2.netvisao.pt ([213.228.128.57]:63628 "HELO
	front2.netvisao.pt") by vger.kernel.org with SMTP id S264196AbTE0Vlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:41:45 -0400
Date: Tue, 27 May 2003 22:55:30 +0100
From: "Paulo Andre'" <fscked@iol.pt>
To: Leopold Gouverneur <lgouv@pi.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: should-fix(?) list
Message-Id: <20030527225530.668e27d4.fscked@iol.pt>
In-Reply-To: <20030527111923.GA386@gouv>
References: <20030527111923.GA386@gouv>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__27_May_2003_22:55:30_+0100_082ef0a0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__27_May_2003_22:55:30_+0100_082ef0a0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2003 13:19:23 +0200
Leopold Gouverneur <lgouv@pi.be> wrote:

> 1) drivers/char/ftape don't compile( it uses deprecated sti,
> save_flags etc ...)
> I tried to "fix" it by applying a patch posted some time ago on this
> list. It compiled wonderfully but trashed my hard diks even more
> wonderfully :(

Does this patch solve it for you?


		Paulo


--Multipart_Tue__27_May_2003_22:55:30_+0100_082ef0a0
Content-Type: text/plain;
 name="ftape_locking_fixes.patch"
Content-Disposition: attachment;
 filename="ftape_locking_fixes.patch"
Content-Transfer-Encoding: 7bit

diff -urN -X dontdiff linux-2.5-vanilla/drivers/char/ftape/lowlevel/fdc-io.c linux/drivers/char/ftape/lowlevel/fdc-io.c
--- linux-2.5-vanilla/drivers/char/ftape/lowlevel/fdc-io.c	2003-05-25 15:30:14.000000000 +0100
+++ linux/drivers/char/ftape/lowlevel/fdc-io.c	2003-05-27 22:37:10.000000000 +0100
@@ -66,6 +66,7 @@
 
 /*      Local vars.
  */
+static spinlock_t fdc_io_lock; 
 static unsigned int fdc_calibr_count;
 static unsigned int fdc_calibr_time;
 static int fdc_status;
@@ -89,14 +90,13 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&fdc_io_lock, flags);
 	if (count == 0) {
 		ft_expected_stray_interrupts = 0;
 	} else {
 		ft_expected_stray_interrupts += count;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 }
 
 /*  Wait during a timeout period for a given FDC status.
@@ -194,8 +194,7 @@
 	TRACE_FUN(ft_t_any);
 
 	fdc_usec_wait(FT_RQM_DELAY);	/* wait for valid RQM status */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&fdc_io_lock, flags);
 	if (!in_interrupt())
 		/* Yes, I know, too much comments inside this function
 		 * ...
@@ -242,12 +241,11 @@
 
 			}
 			fdc_usec_wait(FT_RQM_DELAY);	/* wait for valid RQM status */
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&fdc_io_lock, flags);
 		}
 	fdc_status = inb(fdc.msr);
 	if ((fdc_status & FDC_DATA_READY_MASK) != FDC_DATA_IN_READY) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&fdc_io_lock, flags);
 		TRACE_ABORT(-EBUSY, ft_t_err, "fdc not ready");
 	} 
 	fdc_mode = *cmd_data;	/* used by isr */
@@ -289,7 +287,7 @@
 		last_time = ftape_timestamp();
 	}
 #endif
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 	TRACE_EXIT result;
 }
 
@@ -305,15 +303,14 @@
 	int retry = 0;
 	TRACE_FUN(ft_t_any);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&fdc_io_lock, flags);
 	fdc_status = inb(fdc.msr);
 	if ((fdc_status & FDC_DATA_READY_MASK) != FDC_DATA_OUT_READY) {
 		TRACE(ft_t_err, "fdc not ready");
 		result = -EBUSY;
 	} else while (count) {
 		if (!(fdc_status & FDC_BUSY)) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&fdc_io_lock, flags);
 			TRACE_ABORT(-EIO, ft_t_err, "premature end of result phase");
 		}
 		result = fdc_read(res_data);
@@ -336,7 +333,7 @@
 			++res_data;
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 	fdc_usec_wait(FT_RQM_DELAY);	/* allow FDC to negate BSY */
 	TRACE_EXIT result;
 }
@@ -609,8 +606,7 @@
 	unsigned long flags;
 	TRACE_FUN(ft_t_any);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&fdc_io_lock, flags);
 
 	fdc_dor_reset(1); /* keep unit selected */
 
@@ -629,7 +625,7 @@
 	 */
 	fdc_update_dsr();               /* restore data rate and precomp */
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 
         /*
          *	Wait for first polling cycle to complete
@@ -928,8 +924,7 @@
 	 */
         TRACE(ft_t_fdc_dma,
 	      "phys. addr. = %lx", virt_to_bus((void*) buff->ptr));
-	save_flags(flags);
-	cli();			/* could be called from ISR ! */
+	spin_lock_irqsave(&fdc_io_lock, flags);
 	fdc_setup_dma(DMA_MODE_WRITE, buff->ptr, FT_SECTORS_PER_SEGMENT * 4);
 	/* Issue FDC command to start reading/writing.
 	 */
@@ -937,7 +932,7 @@
 	out[4] = buff->gap3;
 	TRACE_CATCH(fdc_setup_error = fdc_command(out, sizeof(out)),
 		    restore_flags(flags); fdc_mode = fdc_idle);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 	TRACE_EXIT 0;
 }
 
@@ -980,8 +975,7 @@
 			    ft_t_bug, "bug: illegal operation parameter");
 	}
 	TRACE(ft_t_fdc_dma, "phys. addr. = %lx",virt_to_bus((void*)buff->ptr));
-	save_flags(flags);
-	cli();			/* could be called from ISR ! */
+	spin_lock_irqsave(&fdc_io_lock, flags);
 	if (operation != FDC_VERIFY) {
 		fdc_setup_dma(dma_mode, buff->ptr,
 			      FT_SECTOR_SIZE * buff->sector_count);
@@ -999,7 +993,7 @@
 	out[8] = 0xff;		/* No limit to transfer size. */
 	TRACE(ft_t_fdc_dma, "C: 0x%02x, H: 0x%02x, R: 0x%02x, cnt: 0x%02x",
 		out[2], out[3], out[4], out[6] - out[4] + 1);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 	TRACE_CATCH(fdc_setup_error = fdc_command(out, 9),fdc_mode = fdc_idle);
 	TRACE_EXIT 0;
 }
diff -urN -X dontdiff linux-2.5-vanilla/drivers/char/ftape/lowlevel/ftape-calibr.c linux/drivers/char/ftape/lowlevel/ftape-calibr.c
--- linux-2.5-vanilla/drivers/char/ftape/lowlevel/ftape-calibr.c	2003-03-24 22:00:14.000000000 +0000
+++ linux/drivers/char/ftape/lowlevel/ftape-calibr.c	2003-05-27 21:56:14.000000000 +0100
@@ -49,6 +49,8 @@
 static unsigned long ps_per_cycle = 0;
 #endif
 
+static spinlock_t calibr_lock;
+
 /*
  * Note: On Intel PCs, the clock ticks at 100 Hz (HZ==100) which is
  * too slow for certain timeouts (and that clock doesn't even tick
@@ -75,13 +77,12 @@
 	__u16 lo;
 	__u16 hi;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&calibr_lock, flags);
 	outb_p(0x00, 0x43);	/* latch the count ASAP */
 	lo = inb_p(0x40);	/* read the latched count */
 	lo |= inb(0x40) << 8;
 	hi = jiffies;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&calibr_lock, flags);
 	return ((hi + 1) * (unsigned int) LATCH) - lo;  /* downcounter ! */
 #endif
 }
@@ -94,12 +95,11 @@
 	unsigned int count;
  	unsigned long flags;
  
- 	save_flags(flags);
- 	cli();
+	spin_lock_irqsave(&calibr_lock, flags);
  	outb_p(0x00, 0x43);	/* latch the count ASAP */
 	count = inb_p(0x40);	/* read the latched count */
 	count |= inb(0x40) << 8;
- 	restore_flags(flags);
+	spin_unlock_irqrestore(&calibr_lock, flags);
 	return (LATCH - count);	/* normal: downcounter */
 #endif
 }
@@ -150,14 +150,13 @@
 	int status;
 	TRACE_FUN(ft_t_any);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&calibr_lock, flags);
 	t0 = short_ftape_timestamp();
 	for (i = 0; i < 1000; ++i) {
 		status = inb(fdc.msr);
 	}
 	t1 = short_ftape_timestamp();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&calibr_lock, flags);
 	TRACE(ft_t_info, "inb() duration: %d nsec", ftape_timediff(t0, t1));
 	TRACE_EXIT;
 }
@@ -241,8 +240,7 @@
 
 		*calibr_count =
 		*calibr_time = count;	/* set TC to 1 */
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&calibr_lock, flags);
 		fun(0);		/* dummy, get code into cache */
 		t0 = short_ftape_timestamp();
 		fun(0);		/* overhead + one test */
@@ -252,7 +250,7 @@
 		fun(count);		/* overhead + count tests */
 		t1 = short_ftape_timestamp();
 		multiple = diff(t0, t1);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&calibr_lock, flags);
 		time = ftape_timediff(0, multiple - once);
 		tc = (1000 * time) / (count - 1);
 		TRACE(ft_t_any, "once:%3d us,%6d times:%6d us, TC:%5d ns",
diff -urN -X dontdiff linux-2.5-vanilla/drivers/char/ftape/lowlevel/ftape-format.c linux/drivers/char/ftape/lowlevel/ftape-format.c
--- linux-2.5-vanilla/drivers/char/ftape/lowlevel/ftape-format.c	2003-03-24 22:00:38.000000000 +0000
+++ linux/drivers/char/ftape/lowlevel/ftape-format.c	2003-05-27 21:57:36.000000000 +0100
@@ -44,6 +44,8 @@
 #define FT_FMT_SEGS_PER_BUF (FT_BUFF_SIZE/(4*FT_SECTORS_PER_SEGMENT))
 #endif
 
+static spinlock_t ftape_format_lock;
+
 /*
  *  first segment of the new buffer
  */
@@ -129,9 +131,9 @@
 	head->status = formatting;
 	TRACE_CATCH(ftape_seek_head_to_track(track),);
 	TRACE_CATCH(ftape_command(QIC_LOGICAL_FORWARD),);
-	save_flags(flags); cli();
+	spin_lock_irqsave(&ftape_format_lock, flags);
 	TRACE_CATCH(fdc_setup_formatting(head), restore_flags(flags));
-	restore_flags(flags);	
+	spin_unlock_irqrestore(&ftape_format_lock, flags);
 	TRACE_EXIT 0;
 }
 


--Multipart_Tue__27_May_2003_22:55:30_+0100_082ef0a0--
