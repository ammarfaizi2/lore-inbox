Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbSL2CaF>; Sat, 28 Dec 2002 21:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbSL2CaF>; Sat, 28 Dec 2002 21:30:05 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:7618 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266353AbSL2CaC>; Sat, 28 Dec 2002 21:30:02 -0500
Date: Sat, 28 Dec 2002 21:30:49 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.53 : drivers/char/ftape/lowlevel/fdc-io.c
Message-ID: <Pine.LNX.4.44.0212282129230.1014-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch swaps a save_flags/cli/restore_flags combo with a 
spinlock. Please review.

Regards,
Frank

--- linux/drivers/char/ftape/lowlevel/fdc-io.c.old	Sat Oct 19 12:04:19 2002
+++ linux/drivers/char/ftape/lowlevel/fdc-io.c	Sat Dec 28 21:28:17 2002
@@ -39,14 +39,14 @@
 
 #include <linux/ftape.h>
 #include <linux/qic117.h>
-#include "../lowlevel/ftape-tracing.h"
-#include "../lowlevel/fdc-io.h"
-#include "../lowlevel/fdc-isr.h"
-#include "../lowlevel/ftape-io.h"
-#include "../lowlevel/ftape-rw.h"
-#include "../lowlevel/ftape-ctl.h"
-#include "../lowlevel/ftape-calibr.h"
-#include "../lowlevel/fc-10.h"
+#include "ftape-tracing.h"
+#include "fdc-io.h"
+#include "fdc-isr.h"
+#include "ftape-io.h"
+#include "ftape-rw.h"
+#include "ftape-ctl.h"
+#include "ftape-calibr.h"
+#include "fc-10.h"
 
 /*      Global vars.
  */
@@ -84,19 +84,19 @@
 static __u8 fdc_prec_code;	/* fdc precomp. select code */
 
 static char ftape_id[] = "ftape";  /* used by request irq and free irq */
+static fdc_io_lock = SPIN_LOCK_UNLOCKED;
 
 void fdc_catch_stray_interrupts(int count)
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
 #if LINUX_VERSION_CODE >= KERNEL_VER(2,1,30)
 	if (!in_interrupt())
 #else
@@ -223,7 +222,7 @@
 		 * "fdc_read timeout" errors, I HOPE :-)
 		 */
 		if (ft_hide_interrupt) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&fdc_io_lock, flags);
 			TRACE(ft_t_info,
 			      "Waiting for the isr() completing fdc_seek()");
 			if (fdc_interrupt_wait(2 * FT_SECOND) < 0) {
@@ -246,12 +245,11 @@
 
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
@@ -301,7 +299,7 @@
 		last_time = ftape_timestamp();
 	}
 #endif
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 	TRACE_EXIT result;
 }
 
@@ -317,15 +315,14 @@
 	int retry = 0;
 	TRACE_FUN(ft_t_any);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&fdc_lock, flags);
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
@@ -348,7 +345,7 @@
 			++res_data;
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 	fdc_usec_wait(FT_RQM_DELAY);	/* allow FDC to negate BSY */
 	TRACE_EXIT result;
 }
@@ -627,8 +624,7 @@
 	unsigned long flags;
 	TRACE_FUN(ft_t_any);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&fdc_io_lock, flags);
 
 	fdc_dor_reset(1); /* keep unit selected */
 
@@ -647,7 +643,7 @@
 	 */
 	fdc_update_dsr();               /* restore data rate and precomp */
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 
         /*
          *	Wait for first polling cycle to complete
@@ -946,16 +942,15 @@
 	 */
         TRACE(ft_t_fdc_dma,
 	      "phys. addr. = %lx", virt_to_bus((void*) buff->ptr));
-	save_flags(flags);
-	cli();			/* could be called from ISR ! */
+	spin_lock_irqsave(&fdc_lock, flags);
 	fdc_setup_dma(DMA_MODE_WRITE, buff->ptr, FT_SECTORS_PER_SEGMENT * 4);
 	/* Issue FDC command to start reading/writing.
 	 */
 	out[1] = ft_drive_sel;
 	out[4] = buff->gap3;
 	TRACE_CATCH(fdc_setup_error = fdc_command(out, sizeof(out)),
-		    restore_flags(flags); fdc_mode = fdc_idle);
-	restore_flags(flags);
+		    spin_unlock_irqrestore(&fdc_io_lock, flags); fdc_mode = fdc_idle);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 	TRACE_EXIT 0;
 }
 
@@ -998,8 +993,7 @@
 			    ft_t_bug, "bug: illegal operation parameter");
 	}
 	TRACE(ft_t_fdc_dma, "phys. addr. = %lx",virt_to_bus((void*)buff->ptr));
-	save_flags(flags);
-	cli();			/* could be called from ISR ! */
+	spin_lock_irqsave(&fdc_io_lock, flags);
 	if (operation != FDC_VERIFY) {
 		fdc_setup_dma(dma_mode, buff->ptr,
 			      FT_SECTOR_SIZE * buff->sector_count);
@@ -1017,7 +1011,7 @@
 	out[8] = 0xff;		/* No limit to transfer size. */
 	TRACE(ft_t_fdc_dma, "C: 0x%02x, H: 0x%02x, R: 0x%02x, cnt: 0x%02x",
 		out[2], out[3], out[4], out[6] - out[4] + 1);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fdc_io_lock, flags);
 	TRACE_CATCH(fdc_setup_error = fdc_command(out, 9),fdc_mode = fdc_idle);
 	TRACE_EXIT 0;
 }

