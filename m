Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277183AbRJNTaV>; Sun, 14 Oct 2001 15:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277275AbRJNTaL>; Sun, 14 Oct 2001 15:30:11 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:5040 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S277183AbRJNT3z>; Sun, 14 Oct 2001 15:29:55 -0400
Date: Sun, 14 Oct 2001 20:30:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Patch: minor cleanup to floppy.c (1/3)
Message-ID: <20011014203025.F32145@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

On some ARM platforms, we only have one FDC, so we define NR_DRIVE
to 4, and N_FDC to 1.  We don't define nor declare FDC2 either.
Unfortunately, this causes floppy.c to fail.

I'm going to send you this patch in three bits - the first fixes:

1. the general case of N_FDC=1 without FDC2 declared.
2. N_DRIVE != 8 breakage caused by the motor_off_timer array -
   this can be fixed trivially.

--- orig/drivers/block/floppy.c	Mon Oct  1 23:10:37 2001
+++ linux/drivers/block/floppy.c	Sat Oct 13 13:25:04 2001
@@ -397,6 +397,7 @@
 static struct floppy_drive_params drive_params[N_DRIVE];
 static struct floppy_drive_struct drive_state[N_DRIVE];
 static struct floppy_write_errors write_errors[N_DRIVE];
+static struct timer_list motor_off_timer[N_DRIVE];
 static struct floppy_raw_cmd *raw_cmd, default_raw_cmd;
 
 /*
@@ -927,17 +928,6 @@
 	set_dor(FDC(nr), mask, 0);
 }
 
-static struct timer_list motor_off_timer[N_DRIVE] = {
-	{ data: 0, function: motor_off_callback },
-	{ data: 1, function: motor_off_callback },
-	{ data: 2, function: motor_off_callback },
-	{ data: 3, function: motor_off_callback },
-	{ data: 4, function: motor_off_callback },
-	{ data: 5, function: motor_off_callback },
-	{ data: 6, function: motor_off_callback },
-	{ data: 7, function: motor_off_callback }
-};
-
 /* schedules motor off */
 static void floppy_off(unsigned int drive)
 {
@@ -4067,8 +4057,10 @@
 		DPRINT("bad drive for set_cmos\n");
 		return;
 	}
+#if N_FDC > 1
 	if (current_drive >= 4 && !FDC2)
 		FDC2 = 0x370;
+#endif
 	DP->cmos = ints[2];
 	DPRINT("setting CMOS code to %d\n", ints[2]);
 }
@@ -4088,10 +4080,10 @@
 	{ "dma", 0, &FLOPPY_DMA, 2, 0 },
 
 	{ "daring", daring, 0, 1, 0},
-
+#if N_FDC > 1
 	{ "two_fdc",  0, &FDC2, 0x370, 0 },
 	{ "one_fdc", 0, &FDC2, 0, 0 },
-
+#endif
 	{ "thinkpad", floppy_set_flags, 0, 1, FD_INVERTED_DCL },
 	{ "broken_dcl", floppy_set_flags, 0, 1, FD_BROKEN_DCL },
 	{ "messages", floppy_set_flags, 0, 1, FTD_MSG },
@@ -4275,6 +4267,8 @@
 	}
 	
 	for (drive = 0; drive < N_DRIVE; drive++) {
+		motor_off_timer[drive].data = drive;
+		motor_off_timer[drive].function = motor_off_callback;
 		if (!(allowed_drive_mask & (1 << drive)))
 			continue;
 		if (fdc_state[FDC(drive)].version == FDC_NONE)


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

