Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263157AbUDUOrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbUDUOrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUDUOrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:47:12 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:47084 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S263107AbUDUOqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:46:42 -0400
Date: Wed, 21 Apr 2004 16:46:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/9): common i/o layer.
Message-ID: <20040421144626.GC2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: common i/o layer.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Common i/o layer changes:
 - Quiesce active subchannels for lpar reipl.
 - Delete timer after reception of interrupt for kill on timeout.
 - Cleanup some comments in qdio.

diffstat:
 arch/s390/kernel/setup.c      |    4 +-
 arch/s390/kernel/smp.c        |    4 +-
 drivers/s390/cio/cio.c        |   67 +++++++++++++++++++++++++++++++++++++++++-
 drivers/s390/cio/device_fsm.c |    3 +
 drivers/s390/cio/qdio.c       |   12 +++----
 5 files changed, 79 insertions(+), 11 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	Sun Apr  4 05:36:18 2004
+++ linux-2.6-s390/arch/s390/kernel/setup.c	Wed Apr 21 16:29:36 2004
@@ -254,13 +254,13 @@
 /*
  * Reboot, halt and power_off routines for non SMP.
  */
-extern void do_reipl(unsigned long devno);
+extern void reipl(unsigned long devno);
 static void do_machine_restart_nonsmp(char * __unused)
 {
 	if (MACHINE_IS_VM)
 		cpcmd ("IPL", NULL, 0);
 	else
-		do_reipl (0x10000 | S390_lowcore.ipl_device);
+		reipl (0x10000 | S390_lowcore.ipl_device);
 }
 
 static void do_machine_halt_nonsmp(void)
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Sun Apr  4 05:36:13 2004
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Wed Apr 21 16:29:36 2004
@@ -64,7 +64,7 @@
 extern char vmhalt_cmd[];
 extern char vmpoff_cmd[];
 
-extern void do_reipl(unsigned long devno);
+extern void reipl(unsigned long devno);
 
 static void smp_ext_bitcall(int, ec_bit_sig);
 static void smp_ext_bitcall_others(ec_bit_sig);
@@ -278,7 +278,7 @@
 		if (MACHINE_IS_VM)
 			cpcmd ("IPL", NULL, 0);
 		else
-			do_reipl (0x10000 | S390_lowcore.ipl_device);
+			reipl (0x10000 | S390_lowcore.ipl_device);
 	}
 	signal_processor(smp_processor_id(), sigp_stop);
 }
diff -urN linux-2.6/drivers/s390/cio/cio.c linux-2.6-s390/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	Sun Apr  4 05:38:22 2004
+++ linux-2.6-s390/drivers/s390/cio/cio.c	Wed Apr 21 16:29:36 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.117 $
+ *   $Revision: 1.121 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -783,3 +783,68 @@
 }
 
 #endif
+static inline int
+__disable_subchannel_easy(unsigned int schid, struct schib *schib)
+{
+	int retry, cc;
+
+	cc = 0;
+	for (retry=0;retry<3;retry++) {
+		schib->pmcw.ena = 0;
+		cc = msch(schid, schib);
+		if (cc)
+			return (cc==3?-ENODEV:-EBUSY);
+		stsch(schid, schib);
+		if (!schib->pmcw.ena)
+			return 0;
+	}
+	return -EBUSY; /* uhm... */
+}
+
+static inline int
+__clear_subchannel_easy(unsigned int schid)
+{
+	int retry;
+
+	if (csch(schid))
+		return -ENODEV;
+	for (retry=0;retry<20;retry++) {
+		struct tpi_info ti;
+		
+		if (tpi(&ti)) {
+			tsch(schid, (struct irb *)__LC_IRB);
+			return 0;
+		}
+		udelay(100);
+	}
+	return -EBUSY;
+}
+
+extern void do_reipl(unsigned long devno);
+/* Make sure all subchannels are quiet before we re-ipl an lpar. */
+void
+reipl(unsigned long devno)
+{
+	unsigned int schid;
+
+	local_irq_disable();
+	for (schid=0;schid<=highest_subchannel;schid++) {
+		struct schib schib;
+		if (stsch(schid, &schib))
+			goto out;
+		if (!schib.pmcw.ena)
+			continue;
+		switch(__disable_subchannel_easy(schid, &schib)) {
+		case 0:
+		case -ENODEV:
+			break;
+		default: /* -EBUSY */
+			if (__clear_subchannel_easy(schid))
+				break; /* give up... */
+			stsch(schid, &schib);
+			__disable_subchannel_easy(schid, &schib);
+		}
+	}
+out:
+	do_reipl(devno);
+}
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Wed Apr 21 16:29:36 2004
@@ -440,12 +440,14 @@
 	if (!ret) {
 		if (get_device(&sch->dev)) {
 			/* Driver doesn't want to keep device. */
+			cio_disable_subchannel(sch);
 			device_unregister(&sch->dev);
 			sch->schib.pmcw.intparm = 0;
 			cio_modify(sch);
 			put_device(&sch->dev);
 		}
 	} else {
+		cio_disable_subchannel(sch);
 		ccw_device_set_timeout(cdev, 0);
 		cdev->private->state = DEV_STATE_DISCONNECTED;
 		wake_up(&cdev->private->wait_q);
@@ -787,6 +789,7 @@
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
+	ccw_device_set_timeout(cdev, 0);
 	/* OK, i/o is dead now. Call interrupt handler. */
 	cdev->private->state = DEV_STATE_ONLINE;
 	if (cdev->handler)
diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-s390/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/cio/qdio.c	Wed Apr 21 16:29:36 2004
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.79 $"
+#define VERSION_QDIO_C "$Revision: 1.80 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -461,12 +461,12 @@
 
 	switch(slsb[f_mod_no]) {
 
-        /* the hydra has not fetched the output yet */
+        /* the adapter has not fetched the output yet */
 	case SLSB_CU_OUTPUT_PRIMED:
 		QDIO_DBF_TEXT5(0,trace,"outpprim");
 		break;
 
-	/* the hydra got it */
+	/* the adapter got it */
 	case SLSB_P_OUTPUT_EMPTY:
 		atomic_dec(&q->number_of_buffers_used);
 		f++;
@@ -919,7 +919,7 @@
 	no_used=atomic_read(&q->number_of_buffers_used);
 
 	/* 
-	 * we need that one for synchronization with Hydra, as Hydra
+	 * we need that one for synchronization with the adapter, as it
 	 * does a kind of PCI avoidance 
 	 */
 	SYNC_MEMORY;
@@ -1069,7 +1069,7 @@
 	}
 	/*
 	 * maybe we have to do work on our outbound queues... at least
-	 * we have to check Hydra outbound-int-capable thinint-capable
+	 * we have to check the outbound-int-capable thinint-capable
 	 * queues
 	 */
 	if (q->hydra_gives_outbound_pcis) {
@@ -2027,7 +2027,7 @@
 		goto exit;
 	}
 
-	/* Check for hydra thin interrupts (bit 67). */
+	/* Check for OSA/FCP thin interrupts (bit 67). */
 	hydra_thinints = ((scsc_area->general_char[2] & 0x10000000)
 		== 0x10000000);
 	sprintf(dbf_text,"hydrati%1x", hydra_thinints);
