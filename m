Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292335AbSBBSBL>; Sat, 2 Feb 2002 13:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292339AbSBBSBB>; Sat, 2 Feb 2002 13:01:01 -0500
Received: from gear.torque.net ([204.138.244.1]:7443 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S292334AbSBBSAm>;
	Sat, 2 Feb 2002 13:00:42 -0500
Message-ID: <3C5C1CCA.3E738E91@torque.net>
Date: Sat, 02 Feb 2002 12:07:22 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Dave Jones <davej@suse.de>
Subject: [PATCH] lk 2.5.3 advansys scsi driver
Content-Type: multipart/mixed;
 boundary="------------C871C05E1420470F70C89CBE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C871C05E1420470F70C89CBE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The advansys driver is getting better but will not compile
on a SMP machine due to a missing "&" on line 5874:
   spin_lock_irqsave(boardp->lock, flags);

The attachment fixes this and cleans up doco and compile
errors when ADVANSYS_DEBUG is defined.
The driver works fine on my UP and SMP boxes with lk 2.5.3
with this patch.

Doug Gilbert
--------------C871C05E1420470F70C89CBE
Content-Type: text/plain; charset=us-ascii;
 name="advan253.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="advan253.diff"

--- linux/drivers/scsi/advansys.c	Wed Jan 30 19:19:24 2002
+++ linux/drivers/scsi/advansys.cmin5	Sun Jan 20 11:42:44 2002
@@ -1,4 +1,4 @@
-#define ASC_VERSION "3.3GG"    /* AdvanSys Driver Version */
+#define ASC_VERSION "3.3GH"    /* AdvanSys Driver Version */
 
 /*
  * advansys.c - Linux Host Driver for AdvanSys SCSI Adapters
@@ -670,7 +670,7 @@
          1. Return an error from narrow boards if passed a 16 byte
             CDB. The wide board can already handle 16 byte CDBs.
 
-     3.3GG (01/02/02):
+     3.3GH (1/20/02):
 	 1. hacks for lk 2.5 series (D. Gilbert)
 
   I. Known Problems/Fix List (XXX)
@@ -3613,23 +3613,6 @@
 #define ASC_MIN(a, b) (((a) < (b)) ? (a) : (b))
 #endif /* CONFIG_PROC_FS */
 
-/*
- * XXX - Release and acquire the io_request_lock. These macros are needed
- * because the 2.4 kernel SCSI mid-level driver holds the 'io_request_lock'
- * on entry to SCSI low-level drivers.
- *
- * These definitions and all code that uses code should be removed when the
- * SCSI mid-level driver no longer holds the 'io_request_lock' on entry to
- * SCSI low-level driver detect, queuecommand, and reset entrypoints.
- *
- * The interrupt flags values doesn't matter in the macros because the
- * SCSI mid-level will save and restore the flags values before and after
- * calling advansys_detect, advansys_queuecommand, and advansys_reset where
- * these macros are used. We do want interrupts enabled after the lock is
- * released so an explicit sti() is done. The driver only needs interrupts
- * disabled when it acquires the per board lock.
- */
-
 /* Asc Library return codes */
 #define ASC_TRUE        1
 #define ASC_FALSE       0
@@ -4821,7 +4804,7 @@
             boardp->id = asc_board_count - 1;
 
             /* Initialize spinlock. */
-            boardp->lock = SPIN_LOCK_UNLOCKED; /* replaced by host_lock dpg */
+            boardp->lock = SPIN_LOCK_UNLOCKED;
 
             /*
              * Handle both narrow and wide boards.
@@ -5871,7 +5854,7 @@
 
     /* host_lock taken by mid-level prior to call but need to protect */
     /* against own ISR */
-    spin_lock_irqsave(boardp->lock, flags);
+    spin_lock_irqsave(&boardp->lock, flags);
 
     /*
      * Block new commands while handling a reset or abort request.
@@ -9414,8 +9397,8 @@
 
     printk("Scsi_Host at addr 0x%lx\n", (ulong) s);
     printk(
-" next 0x%lx, extra_bytes %u, host_busy %u, host_no %d, last_reset %d,\n",
-        (ulong) s->next, s->extra_bytes, s->host_busy, s->host_no,
+" next 0x%lx, host_busy %u, host_no %d, last_reset %d,\n",
+        (ulong) s->next, s->host_busy, s->host_no,
         (unsigned) s->last_reset);
 
 #if ASC_LINUX_KERNEL24

--------------C871C05E1420470F70C89CBE--



