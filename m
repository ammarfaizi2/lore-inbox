Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbTFDVXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTFDVXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:23:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:16347 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264103AbTFDVWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:22:53 -0400
Date: Wed, 4 Jun 2003 16:34:16 -0500
From: linas@austin.ibm.com
To: lnz@dandelion.com, mike@i-connect.net, eric@andante.org,
       linux-kernel@vger.kernel.org, olh@suse.de, groudier@free.fr,
       axboe@suse.de, acme@conectiva.com.br
Cc: linas@linas.org
Subject: Patches for SCSI timeout bug
Message-ID: <20030604163415.A41236@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I've got a SCSI timeout bug in kernels 2.4 and 2.5, and several 
different patches (appended) that fix it.  I'm not sure which way 
of fixing it is best.

Hardware:
IDE DVD/CDROM connected to ACHIP ARC765 based SCSI-to-IDE converter,
attached to symbios controller using sym53c8xx driver.

SYMPTOMS:
When booting, system hangs because the initial SCSI bus scan times
out when it gets to this device, causing a command abort, which
times out, and thence (in kernel 2.4) into an infinite loop of 
resets and timeouts.  In kernel 2.5, its not an infinite loop;
only two resets, but the device is never found.

ROOT CAUSE:
During boot, the sym53c8xx driver performs a SCSI bus reset.
The Achip takes about 15 seconds after a bus reset before it
is williing to reply to scsi commands.  However, in the current
code for the initial bus scan, a device is given 6 seconds
before scsi target aborts, resets, etc. come raining down.

I've got some lengthly SCSI bus traces if anyone cares to look.

MORE DETAILS:
During boot, the sym53c8xx driver for the SCSI controller
performs a SCSI bus reset. (Other drivers may or may not 
perform this reset; some are configurable).  After the
reset, it waits 2 seconds before starting a bus scan.
(Some other drivers wait 5, others 10; others maybe 
more or less). During the bus scan, generic (common
among all drivers) SCSI code gives each device 6 seconds 
to respond.  If the device doesn't respond,  the code
launches into a sequence of target aborts, bus resets, 
etc. in an attempt to recover.

If the DVD/CDROM is scanned early in the bus scan, then 
it will not have had time to finish reseting itself before
its scanned, and it won't respond fast enough, leading to the 
bad behaviour.  If the machine has lots of disks, then the
CDROM is scanned later, giving it enough time & then everything 
is fine.

FIXES:
There's several ways to fix this: 
1) By increasing the generic SCSI bus scan timeout to be 
   longer than 15 seconds (as well as the timeout for a 
   bus reset to be longer than this).

2) By incresing the sym53c8xx post-reset delay to at least
   12 seconds.

Fix 2) may not be bad: I have at least one scsi hard drive which 
takes 5 seconds to recover from a bus reset.   On the other hand,
fix 2) makes the boot process longer: it introduces a delay of 
N x 12 seconds, where N is the number of scsi channels.
(Most cards have two channels; some server-class machines with 
many cards may have a significantly longer boot).

Fix 1) does not introduce any delay at all, if the SCSI
devices respond quickly.  Fix 1) also will stop the problem
from recurring if/when this CDROM is attached to something 
other than a sym53c8xx.

I like fix 1) better, but I'm not a Linux SCSI guy, so I don't
really know & can't make this choice ....  Below are some
patches for kernel 2.4; they are almost identical for kernel 2.5.

--linas


PATCHES for 'fix 1':  (note these also fix a compile-time warning
in this code):


Index: scsi_scan.c
===================================================================
RCS file: /cvs/linuxppc64/linuxppc64_2_4/drivers/scsi/scsi_scan.c,v
retrieving revision 1.19
diff -u -r1.19 scsi_scan.c
--- scsi_scan.c 8 Jan 2003 18:47:06 -0000       1.19
+++ scsi_scan.c 29 May 2003 23:02:29 -0000
@@ -576,9 +576,10 @@
        SRpnt->sr_cmd_len = 0;
        SRpnt->sr_data_direction = SCSI_DATA_READ;
  
+       /* Some AChip ARC765 devices take 15 seconds recover from bus reset */
        scsi_wait_req (SRpnt, (void *) scsi_cmd,
                  (void *) scsi_result,
-                 256, SCSI_TIMEOUT+4*HZ, 3);
+                 256, SCSI_TIMEOUT+15*HZ, 3);
  
        SCSI_LOG_SCAN_BUS(3, printk("scsi: INQUIRY %s with code 0x%x\n",
                SRpnt->sr_result ? "failed" : "successful", SRpnt->sr_result));



Index: scsi_obsolete.c
===================================================================
RCS file: /cvs/linuxppc64/linuxppc64_2_4/drivers/scsi/scsi_obsolete.c,v
retrieving revision 1.4
diff -u -r1.4 scsi_obsolete.c
--- scsi_obsolete.c     22 Apr 2002 15:33:14 -0000      1.4
+++ scsi_obsolete.c     29 May 2003 23:02:29 -0000
@@ -106,21 +106,15 @@
 static void scsi_dump_status(void);
 #endif
  
-
-#ifdef DEBUG
-#define SCSI_TIMEOUT (5*HZ)
-#else
-#define SCSI_TIMEOUT (2*HZ)
-#endif
-
+/* same timeouts as scsi_error.c */
 #ifdef DEBUG
 #define SENSE_TIMEOUT SCSI_TIMEOUT
 #define ABORT_TIMEOUT SCSI_TIMEOUT
 #define RESET_TIMEOUT SCSI_TIMEOUT
 #else
-#define SENSE_TIMEOUT (5*HZ/10)
-#define RESET_TIMEOUT (5*HZ/10)
-#define ABORT_TIMEOUT (5*HZ/10)
+#define SENSE_TIMEOUT (10*HZ)
+#define RESET_TIMEOUT (2*HZ)
+#define ABORT_TIMEOUT (15*HZ)
 #endif
  
  


PATCH for 'fix 2'

Index: sym53c8xx_defs.h
===================================================================
RCS file: /cvs/linuxppc64/linuxppc64_2_4/drivers/scsi/sym53c8xx_defs.h,v
retrieving revision 1.8
diff -u -r1.8 sym53c8xx_defs.h
--- sym53c8xx_defs.h    22 Apr 2002 15:33:14 -0000      1.8
+++ sym53c8xx_defs.h    4 Jun 2003 21:24:49 -0000
@@ -269,7 +269,7 @@
 /*
  * Settle time after reset at boot-up
  */
-#define SCSI_NCR_SETUP_SETTLE_TIME     (2)
+#define SCSI_NCR_SETUP_SETTLE_TIME     (15)
  
 /*
 **     Bridge quirks work-around option defaulted to 1.

