Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271297AbRHZKoS>; Sun, 26 Aug 2001 06:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271303AbRHZKoH>; Sun, 26 Aug 2001 06:44:07 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:25098 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S271297AbRHZKnz>;
	Sun, 26 Aug 2001 06:43:55 -0400
Message-ID: <3B88D202.429B1F59@yahoo.com>
Date: Sun, 26 Aug 2001 06:40:02 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.7 i586)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Marcelo E. Magallon" <marcelo.magallon@bigfoot.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Oops when loading floppy.o
In-Reply-To: <E15ais1-00081T-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> I can reproduce it to order. The floppy driver has done this since before
> 2.4.0 in this specific case I think. It actual stops installs working on
> the problem box I have
> 
> > >>EIP; c0117602 <__run_task_queue+12/60>   <=====
> > Trace; c011a2f6 <immediate_bh+16/20>
> > Trace; c011756a <bh_action+1a/50>
> 
> Thats the important bit I think, its not killing off all the stuff it set up
> when it exits. Its not an XFS triggered bug, so the trace is useful

It does a reset and as part of that it registers an empty task which may not
be completed before the module disappears.  Also noticed an extra del_timer
and that it should return ENODEV (not EIO) when a controller is not present.

Sensible fix would be to not queue these empty tasks at all, but minimal fix
(2.4.x) is to just make sure they are off the queue before module vanishes.

Please test as the code in floppy.c is showing 10+yrs of moss growth and 
is not 100% clear to follow :)

Paul.

--- drivers/block/floppy.c~	Sun Aug 12 06:06:25 2001
+++ drivers/block/floppy.c	Sun Aug 26 06:24:12 2001
@@ -124,6 +124,11 @@
  * - s/suser/capable/
  */
 
+/*
+ * 2001/08/26 -- Paul Gortmaker - fix insmod oops on machines with no
+ * floppy controller (lingering task on list after module is gone... boom.)
+ */
+
 #define FLOPPY_SANITY_CHECK
 #undef  FLOPPY_SILENT_DCL_CLEAR
 
@@ -4144,7 +4149,7 @@
 	return 0;
 }
 
-static int have_no_fdc= -EIO;
+static int have_no_fdc= -ENODEV;
 
 
 int __init floppy_init(void)
@@ -4200,7 +4205,6 @@
 		del_timer(&fd_timeout);
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 		devfs_unregister_blkdev(MAJOR_NR,"fd");
-		del_timer(&fd_timeout);
 		return -EBUSY;
 	}
 
@@ -4259,9 +4263,7 @@
 	if (have_no_fdc) 
 	{
 		DPRINT("no floppy controllers found\n");
-		floppy_tq.routine = (void *)(void *) empty;
-		mark_bh(IMMEDIATE_BH);
-		schedule();
+		run_task_queue(&tq_immediate);
 		if (usage_count)
 			floppy_release_irq_and_dma();
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));



