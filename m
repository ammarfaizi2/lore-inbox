Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283433AbRLDOoa>; Tue, 4 Dec 2001 09:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283415AbRLDOnG>; Tue, 4 Dec 2001 09:43:06 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:63125 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S283652AbRLDNeJ>; Tue, 4 Dec 2001 08:34:09 -0500
Date: Tue, 4 Dec 2001 13:35:20 +0000
From: Dave Jones <davej@suse.de>
To: groudier@free.fr
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make ncr53c8xx work with bio.
Message-ID: <20011204133520.A3760@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, groudier@free.fr,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
 Patch below makes ncr53c8xx driver compile again in 2.5.1pre5.
 Seems to have survived yesterdays torture tests.

regards,
Dave.

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/scsi/ncr53c8xx.c linux-dj/drivers/scsi/ncr53c8xx.c
--- linux/drivers/scsi/ncr53c8xx.c	Sun Sep 30 20:26:07 2001
+++ linux-dj/drivers/scsi/ncr53c8xx.c	Mon Dec  3 16:44:11 2001
@@ -8625,9 +8625,9 @@
      if (DEBUG_FLAGS & DEBUG_TINY) printk ("]\n");
 
      if (done_list) {
-          NCR_LOCK_SCSI_DONE(np, flags);
+          NCR_LOCK_SCSI_DONE(done_list->host, flags);
           ncr_flush_done_cmds(done_list);
-          NCR_UNLOCK_SCSI_DONE(np, flags);
+          NCR_UNLOCK_SCSI_DONE(done_list->host, flags);
      }
 }
 
@@ -8648,9 +8648,9 @@
      NCR_UNLOCK_NCB(np, flags);
 
      if (done_list) {
-          NCR_LOCK_SCSI_DONE(np, flags);
+          NCR_LOCK_SCSI_DONE(done_list->host, flags);
           ncr_flush_done_cmds(done_list);
-          NCR_UNLOCK_SCSI_DONE(np, flags);
+          NCR_UNLOCK_SCSI_DONE(done_list->host, flags);
      }
 }
 
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/scsi/sym53c8xx_comm.h linux-dj/drivers/scsi/sym53c8xx_comm.h
--- linux/drivers/scsi/sym53c8xx_comm.h	Fri Oct 12 23:35:54 2001
+++ linux-dj/drivers/scsi/sym53c8xx_comm.h	Mon Dec  3 16:43:38 2001
@@ -438,10 +438,10 @@
 #define	NCR_LOCK_NCB(np, flags)    spin_lock_irqsave(&np->smp_lock, flags)
 #define	NCR_UNLOCK_NCB(np, flags)  spin_unlock_irqrestore(&np->smp_lock, flags)
 
-#define	NCR_LOCK_SCSI_DONE(np, flags) \
-		spin_lock_irqsave(&io_request_lock, flags)
-#define	NCR_UNLOCK_SCSI_DONE(np, flags) \
-		spin_unlock_irqrestore(&io_request_lock, flags)
+#define	NCR_LOCK_SCSI_DONE(host, flags) \
+		spin_lock_irqsave(&(host)->host_lock, flags)
+#define	NCR_UNLOCK_SCSI_DONE(host, flags) \
+		spin_unlock_irqrestore(&((host)->host_lock), flags)
 
 #else
 
@@ -452,8 +452,8 @@
 #define	NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
 #define	NCR_UNLOCK_NCB(np, flags)  do { restore_flags(flags); } while (0)
 
-#define	NCR_LOCK_SCSI_DONE(np, flags)    do {;} while (0)
-#define	NCR_UNLOCK_SCSI_DONE(np, flags)  do {;} while (0)
+#define	NCR_LOCK_SCSI_DONE(host, flags)    do {;} while (0)
+#define	NCR_UNLOCK_SCSI_DONE(host, flags)  do {;} while (0)
 
 #endif
 

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
