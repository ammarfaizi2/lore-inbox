Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTI3RK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTI3RK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:10:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:11648 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261528AbTI3RKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:10:18 -0400
Date: Tue, 30 Sep 2003 12:09:44 -0500
From: linas@austin.ibm.com
To: linux-kernel@vger.kernel.org
Cc: linuxppc64-dev@lists.linuxppc.org
Subject: [2.4 PATCH:] Lengthen SCSI timeouts to deal with broken hardware
Message-ID: <20030930120944.A31772@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[PATCH: 2.4] Lengthen SCSI timeouts to deal with broken hardware

Hi, 

The following patch lengthens some scsi timeouts to deal with some
misbehaving hardware.  The device in question is an Achip ARC765-based
ide-to-scsi converter that is used to attach IDE DVD-ROMS to scsi 
chains.  This device can take a very long time (10-15 seconds) to 
get back to a normal state after a bus reset, causing the scsi layer
to timeout on commands issued after the reset.   

We measured these timeouts using a SCSI bus analyzer.  Our guess is
that the slow IDE-CDROM behind this device is helping make the response 
times exceptionally large.

The patch below is minimalistic, and not at all fancy. Its also marked
as a __powerpc64__ patch, because this device commonly ships with ppc64
machines.   Precisely speaking, though, this is not an architecture
specific problem, anyone with this Achip/Acard will see the (hardware)
bug.   I suspect this is a rare, obscure device on non-ppc64 machines.  
I've made the patch a __powerpc64__ patch so as to limit impact and 
complaints and reasons for rejecting this patch.


--linas


--- drivers/scsi/scsi_obsolete.c.orig	2003-09-29 17:47:26.000000000 -0500
+++ drivers/scsi/scsi_obsolete.c	2003-09-29 17:51:40.000000000 -0500
@@ -118,10 +118,19 @@ static void scsi_dump_status(void);
 #define ABORT_TIMEOUT SCSI_TIMEOUT
 #define RESET_TIMEOUT SCSI_TIMEOUT
 #else
+#if defined(__powerpc64__)
+/* Some Achip ARC765-based DVD-ROM's can take 15 seconds or more to reset.
+ * All commands (sense, abort) will not get a response until the reset 
+ * completes.  Lengthen timeouts to make up for this. */
+#define SENSE_TIMEOUT (20*HZ)
+#define RESET_TIMEOUT (2*HZ)
+#define ABORT_TIMEOUT (25*HZ)
+#else
 #define SENSE_TIMEOUT (5*HZ/10)
 #define RESET_TIMEOUT (5*HZ/10)
 #define ABORT_TIMEOUT (5*HZ/10)
 #endif
+#endif
 
 
 /* Do not call reset on error if we just did a reset within 15 sec. */
--- drivers/scsi/scsi_scan.c.orig	2003-09-29 17:52:11.000000000 -0500
+++ drivers/scsi/scsi_scan.c	2003-09-29 17:56:58.000000000 -0500
@@ -23,6 +23,15 @@
 #include <linux/kmod.h>
 #endif
 
+#if defined(__powerpc64__)
+/* Some Achip ARC765-based DVD-ROM's can take 15 seconds or more to reset.
+ * All commands (sense, abort) will not get a response until the reset
+ * completes.  Lengthen timeouts to make up for this. */
+#define SCSI_INQ_TIMEOUT  (SCSI_TIMEOUT+25*HZ)
+#else
+#define SCSI_INQ_TIMEOUT  (SCSI_TIMEOUT+4*HZ)
+#endif
+
 /* 
  * Flags for irregular SCSI devices that need special treatment 
  */
@@ -602,7 +611,7 @@ static int scan_scsis_single(unsigned in
 
 	scsi_wait_req (SRpnt, (void *) scsi_cmd,
 	          (void *) scsi_result,
-	          256, SCSI_TIMEOUT+4*HZ, 3);
+	          256, SCSI_INQ_TIMEOUT, 3);
 
 	SCSI_LOG_SCAN_BUS(3, printk("scsi: INQUIRY %s with code 0x%x\n",
 		SRpnt->sr_result ? "failed" : "successful", SRpnt->sr_result));
