Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131744AbQLQM5J>; Sun, 17 Dec 2000 07:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132107AbQLQM47>; Sun, 17 Dec 2000 07:56:59 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:54685 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131744AbQLQM4q>; Sun, 17 Dec 2000 07:56:46 -0500
Date: Sun, 17 Dec 2000 12:26:19 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0-test13-pre2: ppa 2.07
Message-ID: <20001217122619.D19671@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch fixes some timing issues with ppa.

Tim.
*/

2000-12-13  Tim Waugh  <twaugh@redhat.com>

	* drivers/scsi/ppa.c, drivers/scsi/ppa.h: Timing fixes.  New
	parameter "recon_tmo=".  This is 2.07-for-2.4.x.

--- linux-2.4.0-test12/drivers/scsi/ppa.c.ppa207	Tue Dec 12 13:03:27 2000
+++ linux-2.4.0-test12/drivers/scsi/ppa.c	Thu Dec 14 17:18:53 2000
@@ -31,6 +31,7 @@
     Scsi_Cmnd *cur_cmd;		/* Current queued command       */
     struct tq_struct ppa_tq;	/* Polling interupt stuff       */
     unsigned long jstart;	/* Jiffies at start             */
+    unsigned long recon_tmo;    /* How many usecs to wait for reconnection (6th bit) */
     unsigned int failed:1;	/* Failure flag                 */
     unsigned int p_busy:1;	/* Parport sharing busy flag    */
 } ppa_struct;
@@ -43,6 +44,7 @@
 	cur_cmd:	NULL,		\
 	ppa_tq:		{ routine: ppa_interrupt },	\
 	jstart:		0,		\
+	recon_tmo:      PPA_RECON_TMO,	\
 	failed:		0,		\
 	p_busy:		0		\
 }
@@ -248,6 +250,12 @@
 	ppa_hosts[hostno].mode = x;
 	return length;
     }
+    if ((length > 10) && (strncmp(buffer, "recon_tmo=", 10) == 0)) {
+	x = simple_strtoul(buffer + 10, NULL, 0);
+	ppa_hosts[hostno].recon_tmo = x;
+        printk("ppa: recon_tmo set to %ld\n", x);
+	return length;
+    }
     printk("ppa /proc: invalid variable\n");
     return (-EINVAL);
 }
@@ -268,6 +276,9 @@
     len += sprintf(buffer + len, "Version : %s\n", PPA_VERSION);
     len += sprintf(buffer + len, "Parport : %s\n", ppa_hosts[i].dev->port->name);
     len += sprintf(buffer + len, "Mode    : %s\n", PPA_MODE_STRING[ppa_hosts[i].mode]);
+#if PPA_DEBUG > 0
+    len += sprintf(buffer + len, "recon_tmo : %lu\n", ppa_hosts[i].recon_tmo);
+#endif
 
     /* Request for beyond end of buffer */
     if (offset > length)
@@ -556,6 +567,7 @@
     k = PPA_SELECT_TMO;
     do {
 	k--;
+	udelay(1);
     } while ((r_str(ppb) & 0x40) && (k));
     if (!k)
 	return 0;
@@ -569,6 +581,7 @@
     k = PPA_SELECT_TMO;
     do {
 	k--;
+	udelay(1);
     }
     while (!(r_str(ppb) & 0x40) && (k));
     if (!k)
@@ -652,6 +665,7 @@
      *  1     Finished data transfer
      */
     int host_no = cmd->host->unique_id;
+    unsigned short ppb = PPA_BASE(host_no);
     unsigned long start_jiffies = jiffies;
 
     unsigned char r, v;
@@ -663,7 +677,11 @@
 	    (v == WRITE_6) ||
 	    (v == WRITE_10));
 
-    r = ppa_wait(host_no); /* Need a ppa_wait() - PJC */
+    /*
+     * We only get here if the drive is ready to comunicate,
+     * hence no need for a full ppa_wait.
+     */
+    r = (r_str(ppb) & 0xf0);
 
     while (r != (unsigned char) 0xf0) {
 	/*
@@ -673,12 +691,36 @@
 	if (time_after(jiffies, start_jiffies + 1))
 	    return 0;
 
-	if (((r & 0xc0) != 0xc0) || (cmd->SCp.this_residual <= 0)) {
+	if ((cmd->SCp.this_residual <= 0)) {
 	    ppa_fail(host_no, DID_ERROR);
 	    return -1;		/* ERROR_RETURN */
 	}
-	/* determine if we should use burst I/O */ fast = (bulk && (cmd->SCp.this_residual >= PPA_BURST_SIZE))
-	    ? PPA_BURST_SIZE : 1;
+
+	/* On some hardware we have SCSI disconnected (6th bit low)
+	 * for about 100usecs. It is too expensive to wait a 
+	 * tick on every loop so we busy wait for no more than
+	 * 500usecs to give the drive a chance first. We do not 
+	 * change things for "normal" hardware since generally 
+	 * the 6th bit is always high.
+	 * This makes the CPU load higher on some hardware 
+	 * but otherwise we can not get more then 50K/secs 
+	 * on this problem hardware.
+	 */
+	if ((r & 0xc0) != 0xc0) {
+	   /* Wait for reconnection should be no more than 
+	    * jiffy/2 = 5ms = 5000 loops
+	    */
+	   unsigned long k = ppa_hosts[host_no].recon_tmo; 
+	   for (; k && ((r = (r_str(ppb) & 0xf0)) & 0xc0) != 0xc0; k--)
+	     udelay(1);
+
+	   if(!k) 
+	     return 0;
+	}	   
+
+	/* determine if we should use burst I/O */ 
+	fast = (bulk && (cmd->SCp.this_residual >= PPA_BURST_SIZE)) 
+	     ? PPA_BURST_SIZE : 1;
 
 	if (r == (unsigned char) 0xc0)
 	    status = ppa_out(host_no, cmd->SCp.ptr, fast);
@@ -701,7 +743,7 @@
 	    }
 	}
 	/* Now check to see if the drive is ready to comunicate */
-	r = ppa_wait(host_no); /* need ppa_wait() - PJC */
+	r = (r_str(ppb) & 0xf0);
 	/* If not, drop back down to the scheduler and wait a timer tick */
 	if (!(r & 0x80))
 	    return 0;
--- linux-2.4.0-test12/drivers/scsi/ppa.h.ppa207	Tue Dec 12 13:03:27 2000
+++ linux-2.4.0-test12/drivers/scsi/ppa.h	Thu Dec 14 17:19:16 2000
@@ -10,7 +10,7 @@
 #ifndef _PPA_H
 #define _PPA_H
 
-#define   PPA_VERSION   "2.06 (for Linux 2.2.x)"
+#define   PPA_VERSION   "2.07 (for Linux 2.4.x)"
 
 /* 
  * this driver has been hacked by Matteo Frigo (athena@theory.lcs.mit.edu)
@@ -56,11 +56,20 @@
  * Add ppa_wait() calls to ppa_completion()
  *  by Peter Cherriman <pjc@ecs.soton.ac.uk> and
  *     Tim Waugh <twaugh@redhat.com>
- *                                                      [2.04]
+ *							[2.04]
+ *
  * Fix kernel panic on scsi timeout, 2000-08-18		[2.05]
  *
  * Avoid io_request_lock problems.
  * John Cavan <johncavan@home.com>			[2.06]
+ *
+ * Busy wait for connected status bit in ppa_completion()
+ *  in order to cope with some hardware that has this bit low
+ *  for short periods of time.
+ * Add udelay() to ppa_select()
+ *  by Peter Cherriman <pjc@ecs.soton.ac.uk> and
+ *     Oleg Makarenko <omakarenko@cyberplat.ru>         
+ *                                                      [2.07]
  */
 /* ------ END OF USER CONFIGURABLE PARAMETERS ----- */
 
@@ -116,6 +125,7 @@
 #define PPA_BURST_SIZE	512	/* data burst size */
 #define PPA_SELECT_TMO  5000	/* how long to wait for target ? */
 #define PPA_SPIN_TMO    50000	/* ppa_wait loop limiter */
+#define PPA_RECON_TMO   500	/* scsi reconnection loop limiter */
 #define PPA_DEBUG	0	/* debuging option */
 #define IN_EPP_MODE(x) (x == PPA_EPP_8 || x == PPA_EPP_16 || x == PPA_EPP_32)
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
