Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSJDRhQ>; Fri, 4 Oct 2002 13:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSJDRhQ>; Fri, 4 Oct 2002 13:37:16 -0400
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:18586 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262806AbSJDRhI> convert rfc822-to-8bit; Fri, 4 Oct 2002 13:37:08 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (21/27): sync i/o bug.
Date: Fri, 4 Oct 2002 16:33:21 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041633.21523.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bogus sanity check from {en,dis}able_sync_isc() and really disable all
interrupt sub classes except isc 7 in wait_cons_dev.

diff -urN linux-2.5.40/drivers/s390/cio/cio.c linux-2.5.40-s390/drivers/s390/cio/cio.c
--- linux-2.5.40/drivers/s390/cio/cio.c	Fri Oct  4 16:16:22 2002
+++ linux-2.5.40-s390/drivers/s390/cio/cio.c	Fri Oct  4 16:16:28 2002
@@ -1715,7 +1715,7 @@
 		 */
 		__ctl_store (cr6, 6, 6);
 		save_cr6 = cr6;
-		cr6 &= 0x01FFFFFF;
+		cr6 = 0x01000000;
 		__ctl_load (cr6, 6, 6);
 
 		do {
@@ -1855,47 +1855,39 @@
 
 	/* This one spins until it can get the sync_isc lock for irq# irq */
 
-	if ((irq <= highest_subchannel) && 
-	    (ioinfo[irq] != INVALID_STORAGE_AREA) &&
-	    (!ioinfo[irq]->st)) {
-		if (atomic_read (&sync_isc) != irq)
-			atomic_compare_and_swap_spin (-1, irq, &sync_isc);
-
-		sync_isc_cnt++;
-
-		if (sync_isc_cnt > 255) {	/* fixme : magic number */
-			panic ("Too many recursive calls to enable_sync_isc");
-
-		}
-		/*
-		 * we only run the STSCH/MSCH path for the first enablement
-		 */
-		else if (sync_isc_cnt == 1) {
-			ioinfo[irq]->ui.flags.syncio = 1;
-
-			ccode = stsch (irq, &(ioinfo[irq]->schib));
-
-			if (!ccode) {
-				ioinfo[irq]->schib.pmcw.isc = 5;
-				rc = s390_set_isc5(irq, 0);
-
-			} else {
-				rc = -ENODEV;	/* device is not-operational */
-
-			}
-		}
-
-		if (rc) {	/* can only happen if stsch/msch fails */
-			sync_isc_cnt = 0;
-			atomic_set (&sync_isc, -1);
+	if (atomic_read (&sync_isc) != irq)
+		atomic_compare_and_swap_spin (-1, irq, &sync_isc);
+	
+	sync_isc_cnt++;
+	
+	if (sync_isc_cnt > 255) {	/* fixme : magic number */
+		panic ("Too many recursive calls to enable_sync_isc");
+		
+	}
+	/*
+	 * we only run the STSCH/MSCH path for the first enablement
+	 */
+	else if (sync_isc_cnt == 1) {
+		ioinfo[irq]->ui.flags.syncio = 1;
+		
+		ccode = stsch (irq, &(ioinfo[irq]->schib));
+		
+		if (!ccode) {
+			ioinfo[irq]->schib.pmcw.isc = 5;
+			rc = s390_set_isc5(irq, 0);
+			
+		} else {
+			rc = -ENODEV;	/* device is not-operational */
+			
 		}
-	} else {
-
-		rc = -EINVAL;
-
+	}
+	
+	if (rc) {	/* can only happen if stsch/msch fails */
+		sync_isc_cnt = 0;
+		atomic_set (&sync_isc, -1);
 	}
 
-	return (rc);
+	return rc;
 }
 
 
@@ -1910,44 +1902,36 @@
 	sprintf (dbf_txt, "disisc%x", irq);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
-	if ((irq <= highest_subchannel) && 
-	    (ioinfo[irq] != INVALID_STORAGE_AREA) && 
-	    (!ioinfo[irq]->st)) {
-		/*
-		 * We disable if we're the top user only, as we may
-		 *  run recursively ... 
-		 * We must not decrease the count immediately; during
-		 *  msch() processing we may face another pending
-		 *  status we have to process recursively (sync).
-		 */
-
-		if (sync_isc_cnt == 1) {
-			ccode = stsch (irq, &(ioinfo[irq]->schib));
-
-			if (!ccode) {
-
-				ioinfo[irq]->schib.pmcw.isc = 3;
-				rc = s390_set_isc5(irq, 1);
-			} else {
-				rc = -ENODEV;
-			}
-				
-			ioinfo[irq]->ui.flags.syncio = 0;
-
-			sync_isc_cnt = 0;
-			atomic_set (&sync_isc, -1);
-
+	/*
+	 * We disable if we're the top user only, as we may
+	 *  run recursively ... 
+	 * We must not decrease the count immediately; during
+	 *  msch() processing we may face another pending
+	 *  status we have to process recursively (sync).
+	 */
+	
+	if (sync_isc_cnt == 1) {
+		ccode = stsch (irq, &(ioinfo[irq]->schib));
+		
+		if (!ccode) {
+			
+			ioinfo[irq]->schib.pmcw.isc = 3;
+			rc = s390_set_isc5(irq, 1);
 		} else {
-			sync_isc_cnt--;
-
+			rc = -ENODEV;
 		}
+		
+		ioinfo[irq]->ui.flags.syncio = 0;
+		
+		sync_isc_cnt = 0;
+		atomic_set (&sync_isc, -1);
+		
 	} else {
-
-		rc = -EINVAL;
-
+		sync_isc_cnt--;
+		
 	}
 
-	return (rc);
+	return rc;
 }
 
 EXPORT_SYMBOL (halt_IO);

