Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSLRAvZ>; Tue, 17 Dec 2002 19:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267082AbSLRAvZ>; Tue, 17 Dec 2002 19:51:25 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41982 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267079AbSLRAvO>; Tue, 17 Dec 2002 19:51:14 -0500
Date: Wed, 18 Dec 2002 01:59:11 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove kernel 2.0 compatibility code from i91uscsi.c
Message-ID: <20021218005910.GJ27658@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes the tons of #if's in drivers/scsi/i91uscsi.c in
2.5.52 that are only needed for using this file in kernel 2.0.

cu
Adrian


--- linux-2.5.52/drivers/scsi/i91uscsi.c.old	2002-12-18 01:43:08.000000000 +0100
+++ linux-2.5.52/drivers/scsi/i91uscsi.c	2002-12-18 01:47:35.000000000 +0100
@@ -79,15 +79,6 @@
 #define DEBUG_STATE     0
 #define INT_DISC	0
 
-
-#ifndef CVT_LINUX_VERSION
-#define	CVT_LINUX_VERSION(V,P,S)	(V * 65536 + P * 256 + S)
-#endif
-
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-
 #include <linux/jiffies.h>
 #include <linux/delay.h>
 #include <linux/blk.h>
@@ -221,11 +212,7 @@
 {				/* Pause for amount jiffies */
 	unsigned long the_time = jiffies + amount;
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	while (time_before_eq(jiffies, the_time));
-#else
-	while (jiffies < the_time);
-#endif
 }
 
 /*-- forward reference --*/
@@ -596,9 +583,7 @@
 
 	pCurHcb->HCS_NumScbs = tul_num_scb;
 	pCurHcb->HCS_Semaph = 1;
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	pCurHcb->HCS_SemaphLock = SPIN_LOCK_UNLOCKED;
-#endif
 	pCurHcb->HCS_JSStatus0 = 0;
 	pCurHcb->HCS_Scb = scbp;
 	pCurHcb->HCS_NxtPend = scbp;
@@ -613,9 +598,7 @@
 	pCurHcb->HCS_ScbEnd = pTmpScb;
 	pCurHcb->HCS_FirstAvail = scbp;
 	pCurHcb->HCS_LastAvail = pPrevScb;
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	pCurHcb->HCS_AvailLock = SPIN_LOCK_UNLOCKED;
-#endif
 	pCurHcb->HCS_FirstPend = NULL;
 	pCurHcb->HCS_LastPend = NULL;
 	pCurHcb->HCS_FirstBusy = NULL;
@@ -713,12 +696,7 @@
 {
 	SCB *pTmpScb;
 	ULONG flags;
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_lock_irqsave(&(hcsp->HCS_AvailLock), flags);
-#else
-	save_flags(flags);
-	cli();
-#endif
 	if ((pTmpScb = hcsp->HCS_FirstAvail) != NULL) {
 #if DEBUG_QUEUE
 		printk("find scb at %08lx\n", (ULONG) pTmpScb);
@@ -728,11 +706,7 @@
 		pTmpScb->SCB_NxtScb = NULL;
 		pTmpScb->SCB_Status = SCB_RENT;
 	}
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_unlock_irqrestore(&(hcsp->HCS_AvailLock), flags);
-#else
-	restore_flags(flags);
-#endif
 	return (pTmpScb);
 }
 
@@ -744,12 +718,7 @@
 #if DEBUG_QUEUE
 	printk("Release SCB %lx; ", (ULONG) scbp);
 #endif
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_lock_irqsave(&(hcsp->HCS_AvailLock), flags);
-#else
-	save_flags(flags);
-	cli();
-#endif
 	scbp->SCB_Srb = 0;
 	scbp->SCB_Status = 0;
 	scbp->SCB_NxtScb = NULL;
@@ -760,11 +729,7 @@
 		hcsp->HCS_FirstAvail = scbp;
 		hcsp->HCS_LastAvail = scbp;
 	}
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_unlock_irqrestore(&(hcsp->HCS_AvailLock), flags);
-#else
-	restore_flags(flags);
-#endif
 }
 
 /***************************************************************************/
@@ -1017,35 +982,22 @@
 	ULONG flags;
 	SCB *pTmpScb, *pPrevScb;
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	save_flags(flags);
-	cli();
-#endif
 
 	if ((pCurHcb->HCS_Semaph == 0) && (pCurHcb->HCS_ActScb == NULL)) {
 		TUL_WR(pCurHcb->HCS_Base + TUL_Mask, 0x1F);
 		/* disable Jasmin SCSI Int        */
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
                 spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 		tulip_main(pCurHcb);
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
         	spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 		pCurHcb->HCS_Semaph = 1;
 		TUL_WR(pCurHcb->HCS_Base + TUL_Mask, 0x0F);
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 		spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-		restore_flags(flags);
-#endif
 
 		return SCSI_ABORT_SNOOZE;
 	}
@@ -1054,11 +1006,7 @@
 		/* 07/27/98 */
 		if (pTmpScb->SCB_Srb == (unsigned char *) srbp) {
 			if (pTmpScb == pCurHcb->HCS_ActScb) {
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 				spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-				restore_flags(flags);
-#endif
 				return SCSI_ABORT_BUSY;
 			} else if (pTmpScb == pCurHcb->HCS_FirstPend) {
 				if ((pCurHcb->HCS_FirstPend = pTmpScb->SCB_NxtScb) == NULL)
@@ -1072,11 +1020,7 @@
 			pTmpScb->SCB_Flags |= SCF_DONE;
 			if (pTmpScb->SCB_Flags & SCF_POST)
 				(*pTmpScb->SCB_Post) ((BYTE *) pCurHcb, (BYTE *) pTmpScb);
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 			spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-			restore_flags(flags);
-#endif
 			return SCSI_ABORT_SUCCESS;
 		}
 		pPrevScb = pTmpScb;
@@ -1089,18 +1033,10 @@
 		if (pTmpScb->SCB_Srb == (unsigned char *) srbp) {
 
 			if (pTmpScb == pCurHcb->HCS_ActScb) {
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 				spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-				restore_flags(flags);
-#endif
 				return SCSI_ABORT_BUSY;
 			} else if (pTmpScb->SCB_TagMsg == 0) {
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 				spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-				restore_flags(flags);
-#endif
 				return SCSI_ABORT_BUSY;
 			} else {
 				pCurHcb->HCS_ActTags[pTmpScb->SCB_Target]--;
@@ -1119,22 +1055,14 @@
 				pTmpScb->SCB_Flags |= SCF_DONE;
 				if (pTmpScb->SCB_Flags & SCF_POST)
 					(*pTmpScb->SCB_Post) ((BYTE *) pCurHcb, (BYTE *) pTmpScb);
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 				spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-				restore_flags(flags);
-#endif
 				return SCSI_ABORT_SUCCESS;
 			}
 		}
 		pPrevScb = pTmpScb;
 		pTmpScb = pTmpScb->SCB_NxtScb;
 	}
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	restore_flags(flags);
-#endif
 	return (SCSI_ABORT_NOT_RUNNING);
 }
 
@@ -1163,12 +1091,7 @@
 {
 	ULONG flags;
 	SCB *pScb;
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	save_flags(flags);
-	cli();
-#endif
 
 	if (ResetFlags & SCSI_RESET_ASYNCHRONOUS) {
 
@@ -1176,24 +1099,16 @@
 			TUL_WR(pCurHcb->HCS_Base + TUL_Mask, 0x1F);
 			/* disable Jasmin SCSI Int        */
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
         		spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 			tulip_main(pCurHcb);
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
         		spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 			pCurHcb->HCS_Semaph = 1;
 			TUL_WR(pCurHcb->HCS_Base + TUL_Mask, 0x0F);
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 			spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-			restore_flags(flags);
-#endif
 
 			return SCSI_RESET_SNOOZE;
 		}
@@ -1206,20 +1121,12 @@
 		if (pScb == NULL) {
 			printk("Unable to Reset - No SCB Found\n");
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 			spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-			restore_flags(flags);
-#endif
 			return SCSI_RESET_NOT_RUNNING;
 		}
 	}
 	if ((pScb = tul_alloc_scb(pCurHcb)) == NULL) {
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 		spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-		restore_flags(flags);
-#endif
 		return SCSI_RESET_NOT_RUNNING;
 	}
 	pScb->SCB_Opcode = BusDevRst;
@@ -1238,24 +1145,16 @@
 		/* disable Jasmin SCSI Int        */
 		pCurHcb->HCS_Semaph = 0;
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
         	spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 		tulip_main(pCurHcb);
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
                 spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 		pCurHcb->HCS_Semaph = 1;
 		TUL_WR(pCurHcb->HCS_Base + TUL_Mask, 0x0F);
 	}
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	restore_flags(flags);
-#endif
 	return SCSI_RESET_PENDING;
 }
 
@@ -1263,50 +1162,28 @@
 {
 	ULONG flags;
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	save_flags(flags);
-	cli();
-#endif
 	TUL_WR(pCurHcb->HCS_Base + TUL_Mask, 0x1F);
 	pCurHcb->HCS_Semaph = 0;
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	restore_flags(flags);
-#endif
 
 	tul_stop_bm(pCurHcb);
 
 	tul_reset_scsi(pCurHcb, 2);	/* 7/29/98 */
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	save_flags(flags);
-	cli();
-#endif
 	tul_post_scsi_rst(pCurHcb);
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
         spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 	tulip_main(pCurHcb);
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
         spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 	pCurHcb->HCS_Semaph = 1;
 	TUL_WR(pCurHcb->HCS_Base + TUL_Mask, 0x0F);
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	restore_flags(flags);
-#endif
 	return (SCSI_RESET_SUCCESS | SCSI_RESET_HOST_RESET);
 }
 
@@ -1320,12 +1197,7 @@
 	pCurScb->SCB_SGIdx = 0;
 	pCurScb->SCB_SGMax = pCurScb->SCB_SGLen;
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	save_flags(flags);
-	cli();
-#endif
 
 	tul_append_pend_scb(pCurHcb, pCurScb);	/* Append this SCB to Pending queue */
 
@@ -1335,24 +1207,16 @@
 		/* disable Jasmin SCSI Int        */
 		pCurHcb->HCS_Semaph = 0;
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
         	spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 		tulip_main(pCurHcb);
 
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
         	spin_lock_irqsave(&(pCurHcb->HCS_SemaphLock), flags);
-#endif
 
 		pCurHcb->HCS_Semaph = 1;
 		TUL_WR(pCurHcb->HCS_Base + TUL_Mask, 0x0F);
 	}
-#if LINUX_VERSION_CODE >= CVT_LINUX_VERSION(2,1,95)
 	spin_unlock_irqrestore(&(pCurHcb->HCS_SemaphLock), flags);
-#else
-	restore_flags(flags);
-#endif
 	return;
 }
 
