Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbQKEWDD>; Sun, 5 Nov 2000 17:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKEWCy>; Sun, 5 Nov 2000 17:02:54 -0500
Received: from pc101-gui2.cable.ntl.com ([62.252.3.101]:42502 "EHLO
	cyberelk.elk.co.uk") by vger.kernel.org with ESMTP
	id <S129110AbQKEWCk>; Sun, 5 Nov 2000 17:02:40 -0500
Date: Sun, 5 Nov 2000 22:02:01 +0000
From: Tim Waugh <tim@cyberelk.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.2.18pre19: ppa 2.05
Message-ID: <20001105220201.A1730@cyberelk.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Here is a patch to update the ppa driver in 2.2.x to 2.05.  I'm using
it here.

Tim.
*/

--- linux/drivers/scsi/ppa.c.pjc	Sat Nov  4 16:48:07 2000
+++ linux/drivers/scsi/ppa.c	Sat Nov  4 16:53:13 2000
@@ -299,12 +299,11 @@
     unsigned char r;
 
     k = PPA_SPIN_TMO;
-    do {
-	r = r_str(ppb);
-	k--;
-	udelay(1);
+    /* Wait for bit 6 and 7 - PJC */
+    for (r = r_str (ppb); ((r & 0xc0)!=0xc0) && (k); k--) {
+	    udelay (1);
+	    r = r_str (ppb);
     }
-    while (!(r & 0x80) && (k));
 
     /*
      * return some status information.
@@ -653,11 +652,7 @@
 	    (v == WRITE_6) ||
 	    (v == WRITE_10));
 
-    /*
-     * We only get here if the drive is ready to comunicate,
-     * hence no need for a full ppa_wait.
-     */
-    r = (r_str(ppb) & 0xf0);
+    r = ppa_wait(host_no); /* Need a ppa_wait() - PJC */
 
     while (r != (unsigned char) 0xf0) {
 	/*
@@ -695,7 +690,7 @@
 	    }
 	}
 	/* Now check to see if the drive is ready to comunicate */
-	r = (r_str(ppb) & 0xf0);
+	r = ppa_wait(host_no); /* need ppa_wait() - PJC */
 	/* If not, drop back down to the scheduler and wait a timer tick */
 	if (!(r & 0x80))
 	    return 0;
--- linux/drivers/scsi/ppa.h.pjc	Sat Nov  4 16:54:11 2000
+++ linux/drivers/scsi/ppa.h	Sat Nov  4 16:56:44 2000
@@ -10,7 +10,7 @@
 #ifndef _PPA_H
 #define _PPA_H
 
-#define   PPA_VERSION   "2.03 (for Linux 2.2.x)"
+#define   PPA_VERSION   "2.05 (for Linux 2.2.x)"
 
 /* 
  * this driver has been hacked by Matteo Frigo (athena@theory.lcs.mit.edu)
@@ -51,6 +51,13 @@
  *    CONFIG_SCSI_PPA_HAVE_PEDANTIC => CONFIG_SCSI_IZIP_EPP16
  *    added CONFIG_SCSI_IZIP_SLOW_CTR option
  *                                                      [2.03]
+ *
+ * Use ppa_wait() to check for ready AND connected status bits
+ * Add ppa_wait() calls to ppa_completion()
+ *  by Peter Cherriman <pjc@ecs.soton.ac.uk> and
+ *     Tim Waugh <twaugh@redhat.com>
+ *                                                      [2.04]
+ * Fix kernel panic on scsi timeout, 2000-08-18		[2.05]
  */
 /* ------ END OF USER CONFIGURABLE PARAMETERS ----- */
 
@@ -166,6 +173,7 @@
 		eh_device_reset_handler:	NULL,			\
 		eh_bus_reset_handler:		ppa_reset,		\
 		eh_host_reset_handler:		ppa_reset,		\
+		use_new_eh_code:		1,			\
 		bios_param:			ppa_biosparam,		\
 		this_id:			-1,			\
 		sg_tablesize:			SG_ALL,			\
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
