Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129684AbQKCAnR>; Thu, 2 Nov 2000 19:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQKCAnH>; Thu, 2 Nov 2000 19:43:07 -0500
Received: from 209-164-222-32.iglobal.net ([209.164.222.32]:43651 "EHLO
	liu.fafner.com") by vger.kernel.org with ESMTP id <S130089AbQKCAmx>;
	Thu, 2 Nov 2000 19:42:53 -0500
From: Elizabeth Morris-Baker <eamb@liu.fafner.com>
Message-Id: <200011030024.SAA08567@liu.fafner.com>
Subject: Re: scsi init problem in 2.4.0-test10? [PATCH]
To: torben@kernel.dk (Torben Mathiasen)
Date: Thu, 2 Nov 2000 18:24:47 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001103005034.C1353@torben> from "Torben Mathiasen" at Nov 03, 2000 12:50:34 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 

	Yes, I know that is in the spec, but truly,
	some scsi devices do act this way....
	Maybe they need to read the spec :>

	I have included the START_STOP for Matthew, but
	I never see it execute with the ATLAS disks...
	A diff follows for those that want to try it..

	cheers, 

	Elizabeth

> The SCSI spec says that INQUIRY and not
> TUR + INQUIRY is the way to go, but maybe we
> should make it a compile time option for buggy
> drives.

-------------------------cut here ----------------------
*** scsi_scan.c.orig	Tue Oct 24 14:01:54 2000
--- scsi_scan.c	Thu Nov  2 18:59:30 2000
***************
*** 471,476 ****
--- 471,479 ----
  	Scsi_Request * SRpnt;
  	int bflags, type = -1;
  	extern devfs_handle_t scsi_devfs_handle;
+ 	int spintime = 0;
+ 	int retries = 0;
+ 	unsigned long spintime_value = 0;
  
  	SDpnt->host = shpnt;
  	SDpnt->id = dev;
***************
*** 499,504 ****
--- 502,574 ----
  	 * not really necessary.  Spec recommends using INQUIRY to scan for
  	 * devices (and TEST_UNIT_READY to poll for media change). - Paul G.
  	 */
+ /* Add TUR back in to sync up the disk -- 
+    mostly borrowed from 2.2 kernel  -- eamb */
+ 
+ 	do 	
+ 	{
+                 retries = 0;
+ 
+                 while (retries < 3) 
+ 		{
+                         scsi_cmd[0] = TEST_UNIT_READY;
+                         scsi_cmd[1] = (lun << 5) & 0xe0;
+                         memset((void *) &scsi_cmd[2], 0, 8);
+                         SRpnt->sr_cmd_len = 0;
+                         SRpnt->sr_sense_buffer[0] = 0;
+                         SRpnt->sr_sense_buffer[2] = 0;
+                         SRpnt->sr_data_direction = SCSI_DATA_READ;
+ 
+ 			scsi_wait_req (SRpnt, (void *) scsi_cmd,
+                   		(void *) scsi_result,
+                   		256, SCSI_TIMEOUT+4*HZ, 3);
+ 
+                         retries++;
+                         if (SRpnt->sr_result == 0
+                             || SRpnt->sr_sense_buffer[2] != UNIT_ATTENTION)
+                                 break;
+                 }
+ 
+                 if( SRpnt->sr_result != 0
+                     && ((driver_byte(SRpnt->sr_result) & DRIVER_SENSE) != 0)
+                     && SRpnt->sr_sense_buffer[2] == UNIT_ATTENTION)
+ 		{
+                         break;
+                 }
+ 
+                 /* Look for devices that are NOT_READY.
+                  * Issue command to spin up drive for these cases. */
+                 if(SRpnt->sr_sense_buffer[2] == NOT_READY) 
+ 		{
+                         unsigned long time1;
+                         if (!spintime) 
+ 			{
+                                 scsi_cmd[0] = START_STOP;
+                                 scsi_cmd[1] = (lun << 5) & 0xe0;
+                                 scsi_cmd[1] |= 1;    /* Return immediately */
+                                 memset((void *) &scsi_cmd[2], 0, 8);
+                                 scsi_cmd[4] = 1;     /* Start spin cycle */
+                                 SRpnt->sr_cmd_len = 0;
+                                 SRpnt->sr_sense_buffer[0] = 0;
+                                 SRpnt->sr_sense_buffer[2] = 0;
+ 
+                                 SRpnt->sr_data_direction = SCSI_DATA_READ;
+ 				scsi_wait_req (SRpnt, (void *) scsi_cmd,
+                   			(void *) scsi_result,
+                   			256, SCSI_TIMEOUT+4*HZ, 3);
+                         }
+                         spintime = 1;
+                         spintime_value = jiffies;
+                         time1 = HZ;
+                         /* Wait 1 second for next try */
+                         do 
+ 			{
+                                 current->state = TASK_UNINTERRUPTIBLE;
+                                 time1 = schedule_timeout(time1);
+                         } while(time1);
+                 }
+         } while (SRpnt->sr_result && spintime && (retries < 3) &&
+                  time_after(spintime_value + 100 * HZ, jiffies));
  
  	SCSI_LOG_SCAN_BUS(3, printk("scsi: performing INQUIRY\n"));
  	/*
-------------------------cut here ----------------------
> 
> 
> On Thu, Nov 02 2000, Elizabeth Morris-Baker wrote:
> > > 
> > 
> > 	You need to send the TUR first, but yes, 
> > 	START_STOP will guarantee that you are
> > 	ready to rock and roll.
> > 	The first fix I wrote did a TUR, then
> > 	3 tries at a START_STOP, till it worked.
> > 	
> > 	cheers, 
> > 
> > 	Elizabeth
> >
> 
> [deleted]
> 
> -- 
> Torben Mathiasen <tmm@kernel.dk>
> Linux ThunderLAN maintainer 
> http://tlan.kernel.dk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
