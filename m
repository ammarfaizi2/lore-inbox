Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTIGNSo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbTIGNSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:18:43 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:26077 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263241AbTIGNSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:18:33 -0400
Message-ID: <3F5B3021.9090107@colorfullife.com>
Date: Sun, 07 Sep 2003 15:18:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Cherry <cherry@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] mwave locking (was: IA32 - 1 New warnings)
Content-Type: multipart/mixed;
 boundary="------------050405000701030709020907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050405000701030709020907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

John wrote:

>drivers/char/mwave/mwavedd.c:331:2: warning: #warning "Sleeping on spinlock"
>  
>
Interesting locking strategy:
A spinlock is placed on the stack and then 
spin_lock_irqsave(&local_lock, flags).

Attached is a patch that removes that. Untested due to lack of hardware. 
Anyone around such hardware (IBM Thinkpad?)
--
    Manfred

--------------050405000701030709020907
Content-Type: text/plain;
 name="patch-mwave"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-mwave"

--- 2.6/drivers/char/mwave/mwavedd.c	2003-09-07 12:29:10.000000000 +0200
+++ build-2.6/drivers/char/mwave/mwavedd.c	2003-09-07 15:04:00.000000000 +0200
@@ -293,8 +293,6 @@
 	
 		case IOCTL_MW_GET_IPC: {
 			unsigned int ipcnum = (unsigned int) ioarg;
-			spinlock_t ipc_lock = SPIN_LOCK_UNLOCKED;
-			unsigned long flags;
 	
 			PRINTK_3(TRACE_MWAVE,
 				"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC"
@@ -310,32 +308,29 @@
 			}
 	
 			if (pDrvData->IPCs[ipcnum].bIsEnabled == TRUE) {
+				DECLARE_WAITQUEUE(wait, current);
+
 				PRINTK_2(TRACE_MWAVE,
 					"mwavedd::mwave_ioctl, thread for"
 					" ipc %x going to sleep\n",
 					ipcnum);
-	
-				spin_lock_irqsave(&ipc_lock, flags);
+				add_wait_queue(&pDrvData->IPCs[ipcnum].ipc_wait_queue, &wait);
+				pDrvData->IPCs[ipcnum].bIsHere = TRUE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				/* check whether an event was signalled by */
 				/* the interrupt handler while we were gone */
 				if (pDrvData->IPCs[ipcnum].usIntCount == 1) {	/* first int has occurred (race condition) */
 					pDrvData->IPCs[ipcnum].usIntCount = 2;	/* first int has been handled */
-					spin_unlock_irqrestore(&ipc_lock, flags);
 					PRINTK_2(TRACE_MWAVE,
 						"mwavedd::mwave_ioctl"
 						" IOCTL_MW_GET_IPC ipcnum %x"
 						" handling first int\n",
 						ipcnum);
 				} else {	/* either 1st int has not yet occurred, or we have already handled the first int */
-					pDrvData->IPCs[ipcnum].bIsHere = TRUE;
-#warning "Sleeping on spinlock"
-					interruptible_sleep_on(&pDrvData->IPCs[ipcnum].ipc_wait_queue);
-					pDrvData->IPCs[ipcnum].bIsHere = FALSE;
+					schedule();
 					if (pDrvData->IPCs[ipcnum].usIntCount == 1) {
-						pDrvData->IPCs[ipcnum].
-						usIntCount = 2;
+						pDrvData->IPCs[ipcnum].usIntCount = 2;
 					}
-					spin_unlock_irqrestore(&ipc_lock, flags);
 					PRINTK_2(TRACE_MWAVE,
 						"mwavedd::mwave_ioctl"
 						" IOCTL_MW_GET_IPC ipcnum %x"
@@ -343,6 +338,9 @@
 						" application\n",
 						ipcnum);
 				}
+				pDrvData->IPCs[ipcnum].bIsHere = FALSE;
+				remove_wait_queue(&pDrvData->IPCs[ipcnum].ipc_wait_queue, &wait);
+				set_current_state(TASK_RUNNING);
 				PRINTK_2(TRACE_MWAVE,
 					"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC,"
 					" returning thread for ipc %x"

--------------050405000701030709020907--

