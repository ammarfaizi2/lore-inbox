Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279716AbRJYF7l>; Thu, 25 Oct 2001 01:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279715AbRJYF7c>; Thu, 25 Oct 2001 01:59:32 -0400
Received: from harddata.com ([216.123.194.198]:52494 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S279713AbRJYF7V>;
	Thu, 25 Oct 2001 01:59:21 -0400
Date: Wed, 24 Oct 2001 23:59:50 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: old bug in sym53c8xx still lurks in 2.2.20pre
Message-ID: <20011024235950.A25854@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerard Roudier posted at the beginning of an April a fix to a queue
handling in that driver which seems to be forgotten.  I was looking
through 2.2.20pre and found that the bug is still there.

There are two things about the bug - it may actually hit (some got it
while running cdparanoia) and if you look closer at the original code
you will see that it is quite suspicious. :-)

Here it is again the fix as posted by Gerard re-diffed against
2.2.19something sources.  It still applies cleanly to 2.2.20pre11.


--- linux-2.2.19aa2/drivers/scsi/sym53c8xx.c.symx	Sun Mar 25 09:31:33 2001
+++ linux-2.2.19aa2/drivers/scsi/sym53c8xx.c	Fri Apr 27 10:39:16 2001
@@ -10125,14 +10125,13 @@
 				if (i >= MAX_START*2)
 					i = 0;
 			}
-			assert(k != -1);
-			if (k != 1) {
+			if (k != -1) {
 				np->squeue[k] = np->squeue[i]; /* Idle task */
 				np->squeueput = k; /* Start queue pointer */
-				cp->host_status = HS_ABORTED;
-				cp->scsi_status = S_ILLEGAL;
-				ncr_complete(np, cp);
 			}
+			cp->host_status = HS_ABORTED;
+			cp->scsi_status = S_ILLEGAL;
+			ncr_complete(np, cp);
 		}
 		break;
 	/*

Hm, I should possibly check the latest 2.4s as well.

  Michal
