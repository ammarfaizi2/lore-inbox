Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289497AbSAJPU2>; Thu, 10 Jan 2002 10:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289496AbSAJPUT>; Thu, 10 Jan 2002 10:20:19 -0500
Received: from [151.17.201.167] ([151.17.201.167]:36622 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S289494AbSAJPUI>;
	Thu, 10 Jan 2002 10:20:08 -0500
Message-ID: <3C3DB049.B86E0CD9@teamfab.it>
Date: Thu, 10 Jan 2002 16:16:25 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Paul Gortmaker <p_gortmaker@yahoo.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dledford@redhat.com
Subject: [PATCH 2.2.x] Remove TEST_UNIT_READY from scsi.c (Was 2.2.x SCSI dat 
 problem)
Content-Type: multipart/mixed;
 boundary="------------906814F59AD0B1FDF42F1E24"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------906814F59AD0B1FDF42F1E24
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi!

I've FINALLY find out why 2.2.x kernel always fail on first time access
to my scsi DAT 20/40 [1][2] .

 2.2.x: sense key Illegal Request, then halt with I/O error
 2.4.x: sense key Unit Attention,  but works

After too many hours spent reading linux scsi code I've decided to apply
a "brute force" method to discover why 2.4.x works and why 2.2.x not.
I've dicotomically test too many kernels from 2.3.51 to 2.4.17
to catch the breakpoint, and boom it's on patch-2.4.0-test2, before
that release we have the same error as 2.2.x .
Reading the scsi changes of patch-2.4.0-test2 [3] I've also find
that the "TEST_UNIT_READ removal" from scsi_scan.c cure the problem!

I've made a patch [4] against 2.2.20 that can be applied without
major problems also to 2.2.19,2.2.21pre2.

Comments, bug reports, suggestions welcome,
luca

[1] http://marc.theaimsgroup.com/?l=linux-scsi&m=100876196731096&w=2
[2] http://marc.theaimsgroup.com/?l=linux-scsi&m=100902910327577&w=2
[3] http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0688.html
[4] see attach
--------------906814F59AD0B1FDF42F1E24
Content-Type: text/plain; charset=us-ascii;
 name="remove_TUR.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove_TUR.diff"

--- linux/drivers/scsi_orig/scsi.c	Tue Jan  8 10:50:48 2002
+++ linux/drivers/scsi/scsi.c	Thu Jan 10 15:16:31 2002
@@ -34,6 +34,10 @@
  *  Jiffies wrap fixes (host->resetting), 3 Dec 1998 Andrea Arcangeli
  *
  *  out_of_space + add-single-device work, D. Gilbert (dpg) 990612
+ *
+ *  Remove TEST_UNIT_READY, backported from patch-2.4.0-test2
+ *  Wed Jan 9 18:34:51 CET 2002 Luca Montecchiani <luca.montecchiani@teamfab.it>
+ *
  */
 
 #include <linux/config.h>
@@ -697,46 +701,21 @@
   SDpnt->was_reset = 0;
   SDpnt->expecting_cc_ua = 0;
 
-  scsi_cmd[0] = TEST_UNIT_READY;
-  scsi_cmd[1] = lun << 5;
-  scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[4] = scsi_cmd[5] = 0;
-
   SCpnt->host = SDpnt->host;
   SCpnt->device = SDpnt;
   SCpnt->target = SDpnt->id;
   SCpnt->lun = SDpnt->lun;
   SCpnt->channel = SDpnt->channel;
-  {
-    struct semaphore sem = MUTEX_LOCKED;
-    SCpnt->request.sem = &sem;
-    SCpnt->request.rq_status = RQ_SCSI_BUSY;
-    spin_lock_irq(&io_request_lock);
-    scsi_do_cmd (SCpnt, (void *) scsi_cmd,
-                 (void *) scsi_result,
-                 256, scan_scsis_done, SCSI_TIMEOUT + 4 * HZ, 5);
-    spin_unlock_irq(&io_request_lock);
-    down (&sem);
-    SCpnt->request.sem = NULL;
-  }
 
-  SCSI_LOG_SCAN_BUS(3,  printk ("scsi: scan_scsis_single id %d lun %d. Return code 0x%08x\n",
-          dev, lun, SCpnt->result));
-  SCSI_LOG_SCAN_BUS(3,print_driverbyte(SCpnt->result));
-  SCSI_LOG_SCAN_BUS(3,print_hostbyte(SCpnt->result));
-  SCSI_LOG_SCAN_BUS(3,printk("\n"));
-
-  if (SCpnt->result) {
-    if (((driver_byte (SCpnt->result) & DRIVER_SENSE) ||
-         (status_byte (SCpnt->result) & CHECK_CONDITION)) &&
-        ((SCpnt->sense_buffer[0] & 0x70) >> 4) == 7) {
-      if (((SCpnt->sense_buffer[2] & 0xf) != NOT_READY) &&
-          ((SCpnt->sense_buffer[2] & 0xf) != UNIT_ATTENTION) &&
-          ((SCpnt->sense_buffer[2] & 0xf) != ILLEGAL_REQUEST || lun > 0))
-        return 1;
-    }
-    else
-      return 0;
-  }
+  /*
+   * We used to do a TEST_UNIT_READY before the INQUIRY but that was 
+   * not really necessary.  Spec recommends using INQUIRY to scan for
+   * devices (and TEST_UNIT_READY to poll for media change). - Paul G.
+   * 
+   * Wed Jan 9 18:34:51 CET 2002 Luca Montecchiani <luca.montecchiani@teamfab.it>
+   * backported to 2.2.20 from patch-2.4.0-test2
+   * to fix "the first use error" on 20/40gbyte Seagate dat
+   */
 
   SCSI_LOG_SCAN_BUS(3,printk ("scsi: performing INQUIRY\n"));
   /*
@@ -756,7 +735,7 @@
     spin_lock_irq(&io_request_lock);
     scsi_do_cmd (SCpnt, (void *) scsi_cmd,
                  (void *) scsi_result,
-                 256, scan_scsis_done, SCSI_TIMEOUT, 3);
+                 256, scan_scsis_done, SCSI_TIMEOUT+4*HZ, 3);
     spin_unlock_irq(&io_request_lock);
     down (&sem);
     SCpnt->request.sem = NULL;



--------------906814F59AD0B1FDF42F1E24--

