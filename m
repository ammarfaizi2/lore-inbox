Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWAFLJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWAFLJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWAFLJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:09:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22739 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932404AbWAFLJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:09:23 -0500
Date: Fri, 6 Jan 2006 12:09:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] suspend: update documentation
Message-ID: <20060106110922.GC9219@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updates documentation for suspend-to-disk and RAM. In particular
modular disk drivers trap is documented.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -27,13 +27,11 @@ echo shutdown > /sys/power/disk; echo di
 
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
-
-Encrypted suspend image:
-------------------------
-If you want to store your suspend image encrypted with a temporary
-key to prevent data gathering after resume you must compile
-crypto and the aes algorithm into the kernel - modules won't work
-as they cannot be loaded at resume time.
+. If you have SATA disks, you'll need recent kernels with SATA suspend
+support. For suspend and resume to work, make sure your disk drivers
+are built into kernel -- not modules. [There's way to make
+suspend/resume with modular disk drivers, see FAQ, but you should
+better not do that.]
 
 
 Article about goals and implementation of Software Suspend for Linux
@@ -328,4 +326,10 @@ init=/bin/bash, then swapon and starting
 usually does the trick. Then it is good idea to try with latest
 vanilla kernel.
 
+Q: How can distributions ship a swsusp-supporting kernel with modular
+disk drivers (especially SATA)?
 
+A: Well, it can be done, load the drivers, then do echo into
+/sys/power/disk/resume file from initrd. Be sure not to mount
+anything, not even read-only mount, or you are going to lose your
+data.
diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -104,6 +104,7 @@ HP NX7000			??? (*)
 HP Pavilion ZD7000		vbetool post needed, need open-source nv driver for X
 HP Omnibook XE3	athlon version	none (1)
 HP Omnibook XE3GC		none (1), video is S3 Savage/IX-MV
+HP Omnibook 5150		none (1), (S1 also works OK)
 IBM TP T20, model 2647-44G	none (1), video is S3 Inc. 86C270-294 Savage/IX-MV, vesafb gets "interesting" but X work.
 IBM TP A31 / Type 2652-M5G      s3_mode (3) [works ok with BIOS 1.04 2002-08-23, but not at all with BIOS 1.11 2004-11-05 :-(]
 IBM TP R32 / Type 2658-MMG      none (1)
@@ -122,16 +123,21 @@ IBM TP X30			s3_bios (2)
 IBM TP X31 / Type 2672-XXH      none (1), use radeontool (http://fdd.com/software/radeon/) to turn off backlight.
 IBM TP X32			none (1), but backlight is on and video is trashed after long suspend
 IBM Thinkpad X40 Type 2371-7JG  s3_bios,s3_mode (4)
+IBM TP 600e			none(1), but a switch to console and back to X is needed
 Medion MD4220			??? (*)
 Samsung P35			vbetool needed (6)
-Sharp PC-AR10 (ATI rage)	none (1)
+Sharp PC-AR10 (ATI rage)	none (1), backlight does not switch off
 Sony Vaio PCG-C1VRX/K		s3_bios (2)
 Sony Vaio PCG-F403		??? (*)
 Sony Vaio PCG-N505SN		??? (*)
+Sony Vaio PCG-GRT995MP		none (1), works with 'nv' X driver
 Sony Vaio vgn-s260		X or boot-radeon can init it (5)
+Sony Vaio vgn-S580BH		vga=normal, but suspend from X. Console will be blank unless you return to X. 
+Sony Vaio vgn-FS115B		s3_bios (2),s3_mode (4)
 Toshiba Libretto L5		none (1)
-Toshiba Satellite 4030CDT	s3_mode (3)
-Toshiba Satellite 4080XCDT      s3_mode (3)
+Toshiba Portege 3020CT		s3_mode (3)
+Toshiba Satellite 4030CDT	s3_mode (3) (S1 also works OK)
+Toshiba Satellite 4080XCDT      s3_mode (3) (S1 also works OK)
 Toshiba Satellite 4090XCDT      ??? (*)
 Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
 Toshiba M30                     (2) xor X with nvidia driver using internal AGP
diff --git a/kernel/power/process.c b/kernel/power/process.c
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -83,7 +83,7 @@ int freeze_processes(void)
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			printk(KERN_ERR " stopping tasks timed out (%d tasks remaining)\n", todo );
 			break;
 		}
 	} while(todo);
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -967,7 +967,7 @@ int swsusp_check(void)
 	if (!error)
 		pr_debug("swsusp: resume file found\n");
 	else
-		pr_debug("swsusp: Error %d check for resume file\n", error);
+		pr_debug("swsusp: Error %d checking for resume file\n", error);
 	return error;
 }
 

-- 
Boycott Kodak -- for their patent abuse against Java.
