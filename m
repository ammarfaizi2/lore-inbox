Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAYP3e>; Thu, 25 Jan 2001 10:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129160AbRAYP3Z>; Thu, 25 Jan 2001 10:29:25 -0500
Received: from 13dyn253.delft.casema.net ([212.64.76.253]:13072 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129143AbRAYP3N>; Thu, 25 Jan 2001 10:29:13 -0500
Message-Id: <200101251528.QAA11270@cave.bitwizard.nl>
Subject: SD: infinite loop. 
To: torvalds@transmeta.com, alan@redhat.com
Date: Thu, 25 Jan 2001 16:28:58 +0100 (MET)
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Alan,

There is a small problem in sd.c: If a disk doesn't become ready, the
loop to try and spin it up doesn't terminate. This can be fixed by
moving one statement up a few lines. Patch below

(the "start of the loop time" variable (spintime_value) is set INSIDE
the loop, which means that the timeout is 100 seconds from 'now' and
stays that way. By moving it up into the "if" above, the value is only
set on the first iteration around the loop. )


	Roger. 


--- linux-2.4.0.clean/drivers/scsi/sd.c	Fri Oct 27 08:35:48 2000
+++ linux-2.4.0.jungo/drivers/scsi/sd.c	Thu Jan 25 16:18:41 2001
@@ -798,9 +798,9 @@
 				SRpnt->sr_data_direction = SCSI_DATA_READ;
 				scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
 					    0/*512*/, SD_TIMEOUT, MAX_RETRIES);
+				spintime_value = jiffies;
 			}
 			spintime = 1;
-			spintime_value = jiffies;
 			time1 = HZ;
 			/* Wait 1 second for next try */
 			do {




-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
