Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbSIXRdx>; Tue, 24 Sep 2002 13:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSIXRaL>; Tue, 24 Sep 2002 13:30:11 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:55196 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261732AbSIXRWq> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 21_chpid.
Date: Tue, 24 Sep 2002 19:23:41 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241923.41057.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check if defined chpids are available. Some code simplification.

diff -urN linux-2.5.38/drivers/s390/cio/chsc.c linux-2.5.38-s390/drivers/s390/cio/chsc.c
--- linux-2.5.38/drivers/s390/cio/chsc.c	Sun Sep 22 06:24:58 2002
+++ linux-2.5.38-s390/drivers/s390/cio/chsc.c	Tue Sep 24 17:43:50 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.9 $
+ *   $Revision: 1.12 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -52,6 +52,49 @@
 	return test_bit (ioinfo[irq]->schib.pmcw.chpid[chp], &chpids_logical);
 }
 
+static inline void
+chsc_clear_chpid(int irq, int chp)
+{
+	clear_bit(ioinfo[irq]->schib.pmcw.chpid[chp], &chpids);
+}
+
+void
+chsc_validate_chpids(int irq)
+{
+	int mask, chp;
+
+	if (ioinfo[irq]->opm) {
+		for (chp=0;chp<=7;chp++) {
+			mask = 0x80 >> chp;
+			if (ioinfo[irq]->opm & mask) {
+				if (!chsc_chpid_logical(irq,chp))
+					/* disable using this path */
+					ioinfo[irq]->opm &= ~mask;
+			} else {
+				/* This chpid is not
+				 * available to us */
+				chsc_clear_chpid(irq,chp);
+			}
+		}
+		
+	}
+	
+}
+
+void
+switch_off_chpids(int irq, __u8 mask)
+{
+	int i;
+	pmcw_t *pmcw = &ioinfo[irq]->schib.pmcw;
+
+	for (i=0;i<8;i++)
+		if ((0x80>>i) & mask
+		    & pmcw->pim
+		    & pmcw->pam
+		    & pmcw->pom)
+			clear_bit(pmcw->chpid[i], &chpids);
+}
+
 /* FIXME: this is _always_ called for every subchannel. shouldn't we
  * 	  process more than one at a time?*/
 static int
@@ -213,11 +256,9 @@
 {
 	int irq;
 	int j;
-	int mask;
 	char dbf_txt[15];
 	int ccode;
 	int was_oper;
-	int chp = 0;
 	int mask2;
 
 	sprintf(dbf_txt, "chpr%x", chpid);
@@ -266,21 +307,7 @@
 				ioinfo[irq]->schib.pmcw.pam &
 				ioinfo[irq]->schib.pmcw.pom;
 
-			if (ioinfo[irq]->opm) {
-				for (chp=0;chp<=7;chp++) {
-					mask2 = 0x80 >> chp;
-					if (ioinfo[irq]->opm & mask2) {
-						if (!test_bit
-						    (ioinfo[irq]->
-						     schib.pmcw.chpid[chp], 
-						     &chpids_logical)) {
-							/* disable using this path */
-							ioinfo[irq]->opm 
-								&= ~mask2;
-						}
-					}
-				}
-			}
+			chsc_validate_chpids(irq);
 
 			if (!ioinfo[irq]->opm) {
 				/*
@@ -307,20 +334,7 @@
 						nopfunc(irq, DEVSTAT_DEVICE_GONE);
 				}
 
-			} else if (ioinfo[irq]->ui.flags.ready) {
-				/* 
-				 * Re-do path verification for the chpid in question
-				 * FIXME: is this neccessary?
-				 */
-				mask = 0x80 >> j;
-
-				if (!s390_DevicePathVerification(irq,mask)) {
-					CHSC_DEBUG (KERN_DEBUG, CRW, 2,
-						"DevicePathVerification "
-						"successful for Subchannel %x, "
-						"chpid %x\n", irq, chpid);
-				}
-			}
+			} 
 
 			s390irq_spin_unlock(irq);
 			break;
@@ -432,18 +446,7 @@
 				   ioinfo[irq]->schib.pmcw.pam &
 				   ioinfo[irq]->schib.pmcw.pom;
 
-		if (ioinfo[irq]->opm) {
-			for (chp=0;chp<=7;chp++) {
-				mask = 0x80 >> chp;
-				if ((ioinfo[irq]->opm & mask) &&
-				    !test_bit (ioinfo[irq]->schib.pmcw.chpid[chp],
-					       &chpids_logical)) {
-
-					/* disable using this path */
-					ioinfo[irq]->opm &= ~mask;
-				}
-			}
-		}
+		chsc_validate_chpids(irq);
 
 		if ((ioinfo[irq]->ui.flags.ready) && (chpid & ioinfo[irq]->opm))
 			s390_DevicePathVerification(irq, chpid);
@@ -456,8 +459,7 @@
 	char dbf_txt[15];
 	int irq = 0;
 	int ccode;
-	int chp;
-	int mask, mask2;
+	int mask2;
 	int ret;
 	int j;
 
@@ -517,18 +519,7 @@
 						   ioinfo[irq]->schib.pmcw.pam &
 						   ioinfo[irq]->schib.pmcw.pom;
 
-				if (ioinfo[irq]->opm) {
-					for (chp=0;chp<=7;chp++) {
-						mask = 0x80 >> chp;
-						if ((ioinfo[irq]->opm & mask)
-						    && (!test_bit (ioinfo[irq]->
-							     schib.pmcw.chpid[chp], 
-							     &chpids_logical))) {
-							/* disable using this path */
-							ioinfo[irq]->opm &= ~mask;
-						}
-					}
-				}
+				chsc_validate_chpids(irq);
 
 				if (ioinfo[irq]->ui.flags.ready)
 					s390_DevicePathVerification(irq, chpid);
@@ -782,11 +773,20 @@
 	}
 
 	while (chp < NR_CHPIDS && len + entry_size < count) {
-		if ((test_bit( chp, &chpids)) && test_bit(chp, &chpids_logical))
-			len += sprintf(page+len, "0x%02X online\n", chp);
-		else if (test_bit(chp, &chpids_known))
-			len += sprintf(page+len, "0x%02X logically offline\n",
-					chp);
+		if (test_bit(chp, &chpids_known)) {
+
+			if (!test_bit(chp, &chpids))
+				len += sprintf(page+len,
+					       "0x%02X n/a\n", chp);
+			
+			else if (test_bit(chp, &chpids_logical))
+				len += sprintf(page+len,
+					       "0x%02X online\n", chp);
+			else
+				len += sprintf(page+len,
+					       "0x%02X logically offline\n", 
+					       chp);
+		}
 		chp++;
 	}
 
diff -urN linux-2.5.38/drivers/s390/cio/chsc.h linux-2.5.38-s390/drivers/s390/cio/chsc.h
--- linux-2.5.38/drivers/s390/cio/chsc.h	Sun Sep 22 06:25:17 2002
+++ linux-2.5.38-s390/drivers/s390/cio/chsc.h	Tue Sep 24 17:43:50 2002
@@ -3,4 +3,6 @@
 
 extern void s390_process_css( void );
 extern int chsc_chpid_logical (int irq, int chp);
+extern void chsc_validate_chpids(int irq);
+extern void switch_off_chpids(int irq, __u8 mask);
 #endif
diff -urN linux-2.5.38/drivers/s390/cio/cio.c linux-2.5.38-s390/drivers/s390/cio/cio.c
--- linux-2.5.38/drivers/s390/cio/cio.c	Tue Sep 24 17:43:50 2002
+++ linux-2.5.38-s390/drivers/s390/cio/cio.c	Tue Sep 24 17:43:50 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.25 $
+ *   $Revision: 1.26 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -342,6 +342,7 @@
 
 	if (valid_lpm) {
 		ioinfo[irq]->opm &= ~lpm;
+		switch_off_chpids(irq, lpm);
 	} else {
 		ioinfo[irq]->opm = 0;
 		
@@ -1386,7 +1387,7 @@
 	
 	ioinfo[irq]->devstat.intparm = 0;
 	
-	if (!ioinfo[irq]->ui.flags.s_pend) 
+	if (!(ioinfo[irq]->ui.flags.s_pend || ioinfo[irq]->ui.flags.repnone))
 		ioinfo[irq]->irq_desc.handler (irq, udp, NULL);
 	
 	return 1;
diff -urN linux-2.5.38/drivers/s390/cio/s390io.c linux-2.5.38-s390/drivers/s390/cio/s390io.c
--- linux-2.5.38/drivers/s390/cio/s390io.c	Tue Sep 24 17:43:15 2002
+++ linux-2.5.38-s390/drivers/s390/cio/s390io.c	Tue Sep 24 17:53:01 2002
@@ -991,9 +991,6 @@
 	int ccode2;		/* condition code for other I/O routines */
 	schib_t *p_schib;
 	int ret;
-	int      chp = 0;
-	int      mask;
-
 	char dbf_txt[15];
 
 	sprintf (dbf_txt, "valsch%x", irq);
@@ -1115,17 +1112,7 @@
 	ioinfo[irq]->opm = ioinfo[irq]->schib.pmcw.pim
 	    & ioinfo[irq]->schib.pmcw.pam & ioinfo[irq]->schib.pmcw.pom;
 
-	if (ioinfo[irq]->opm) {
-		for (chp=0;chp<=7;chp++) {
-			mask = 0x80 >> chp;
-			if (ioinfo[irq]->opm & mask) {
-				if (!chsc_chpid_logical (irq, chp)) {
-					/* disable using this path */
-					ioinfo[irq]->opm &= ~mask;
-				}
-			}
-		}
-	}
+	chsc_validate_chpids(irq);
 
 	CIO_DEBUG_IFMSG(KERN_INFO, 0,
 			"Detected device %04X "
@@ -1690,8 +1677,6 @@
 	int ccode;
 	__u8 pathmask;
 	__u8 domask;
-	int chp;
-	int mask;
 	int old_opm = 0;
 
 	int ret = 0;
@@ -1772,18 +1757,8 @@
 	ioinfo[irq]->opm = ioinfo[irq]->schib.pmcw.pim
 	    & ioinfo[irq]->schib.pmcw.pam & ioinfo[irq]->schib.pmcw.pom;
 
-	if (ioinfo[irq]->opm) {
-		for (chp=0;chp<=7;chp++) {
-			mask = 0x80 >> chp;
-			if (ioinfo[irq]->opm & mask) {
-				if (!chsc_chpid_logical (irq, chp)) {
-					/* disable using this path */
-					ioinfo[irq]->opm &= ~mask;
-				}
-			}
-		}
-	}
-	
+	chsc_validate_chpids(irq);
+
 	if ((ioinfo[irq]->opm == 0) && (old_opm)) {
 		not_oper_handler_func_t nopfunc=ioinfo[irq]->nopfunc;
 		int was_oper = ioinfo[irq]->ui.flags.ready;
@@ -1815,7 +1790,7 @@
 	}
 
 	if ( ioinfo[irq]->ui.flags.pgid_supp == 0 )
-		return( 0);	/* just exit ... */
+		return 0;	/* just exit ... */
 
 	if (usermask) {
 		dev_path = usermask;
@@ -2229,8 +2204,8 @@
 				 *  Sense Path Group ID command
 				 *  further retries wouldn't help ...
 				 */
-				if (pdevstat->ii.sense.
-				    data[0] & SNS0_CMD_REJECT) {
+				if (pdevstat->ii.sense.data[0] & 
+				    (SNS0_CMD_REJECT | SNS0_INTERVENTION_REQ)) {
 					retry = 0;
 					irq_ret = -EOPNOTSUPP;
 				} else {

