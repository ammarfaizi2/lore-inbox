Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265542AbRGCRWw>; Tue, 3 Jul 2001 13:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265478AbRGCRWm>; Tue, 3 Jul 2001 13:22:42 -0400
Received: from cpe-24-221-106-102.az.sprintbbd.net ([24.221.106.102]:39947
	"HELO farnsworth.org") by vger.kernel.org with SMTP
	id <S265534AbRGCRWj>; Tue, 3 Jul 2001 13:22:39 -0400
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 3 Jul 2001 10:22:36 -0700
To: Andre Hedrick <andre@aslab.com>, linux-kernel@vger.kernel.org
Subject: Patch for IDE hang after resetting quirk drive
Message-ID: <20010703102236.A8708@farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Promise PDC20265 ide controller with one of the "quirk" drives,
a Quantum Fireballp LM30.  That drive has a bad sector and accessing
it would result in a DMA timeout.  Unfortunately, after the IDE driver
resets the controller, the drive never responded.

The following patch appears to correct the problem.  It duplicates
the workaround for "quirky" drives found in ide-features.c

-Dale

Dale Farnsworth		dale@farnsworth.org

--- oldlinux-2.4.5/drivers/ide/ide.c	Tue Jul  3 09:35:57 2001
+++ linux-2.4.5/drivers/ide/ide.c	Tue Jul  3 09:23:58 2001
@@ -758,7 +758,10 @@
 	 */
 	OUT_BYTE(drive->ctl|6,IDE_CONTROL_REG);	/* set SRST and nIEN */
 	udelay(10);			/* more than enough time */
-	OUT_BYTE(drive->ctl|2,IDE_CONTROL_REG);	/* clear SRST, leave nIEN */
+	if (drive->quirk_list == 2)
+		OUT_BYTE(drive->ctl, IDE_CONTROL_REG); /* clear SRST and nIEN */
+	else
+		OUT_BYTE(drive->ctl|2,IDE_CONTROL_REG);	/* clear SRST only */
 	udelay(10);			/* more than enough time */
 	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
 	ide_set_handler (drive, &reset_pollfunc, HZ/20, NULL);
