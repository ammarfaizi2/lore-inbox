Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130443AbRCCKj2>; Sat, 3 Mar 2001 05:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130444AbRCCKjT>; Sat, 3 Mar 2001 05:39:19 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:265 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130443AbRCCKjH>; Sat, 3 Mar 2001 05:39:07 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3AA0BB0E.2912AF23@yahoo.com>
Date: Sat, 03 Mar 2001 04:36:14 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.2 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvram driver and extended HDD data
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NVRAM driver tries to print the user specified (non BIOS ROM table) hard
disk geometry for type 47 (or higher) configurable hard disk entries.

Problem is that there is no standard as to how these values are encoded
into the CMOS RAM, and so each BIOS manufacturer does it as they see fit.
(read as 'does it differently').  So the output (via /proc) prints random 
garbage for anything other than AMI BIOS at the moment.

Thus IMHO, interpretation of this data belongs in user space, and not in
the kernel and so I killed the lines printing user specified hard disk
geometry parameters from the driver.  Patch is against 2.4.2.

Paul.

--- drivers/char/nvram.c~	Wed Feb 14 02:40:29 2001
+++ drivers/char/nvram.c	Wed Feb 28 23:16:33 2001
@@ -25,12 +25,18 @@
  * the kernel and is not a module. Since the functions are used by some Atari
  * drivers, this is the case on the Atari.
  *
+ * 02/2001: I've coded some user space hacks for PC that use the NVRAM driver
+ * to set/show hard disk type(s), floppy disk type(s) and display type. These
+ * can be found in bios-cmos-X.Y.tar.gz (X.Y = version #).	Paul G.
+ *
  *
  * 	1.1	Cesar Barros: SMP locking fixes
  * 		added changelog
+ *	1.2	Paul Gortmaker: remove display of type 48/49 hard disk data
+		from /proc as it is not standardized & depends on BIOS mfr.
  */
 
-#define NVRAM_VERSION		"1.1"
+#define NVRAM_VERSION		"1.2"
 
 #include <linux/module.h>
 #include <linux/config.h>
@@ -532,17 +538,6 @@
 		PRINT_PROC( "%02x\n", type == 0x0f ? nvram[12] : type );
 	else
 		PRINT_PROC( "none\n" );
-
-	PRINT_PROC( "HD type 48 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
-				nvram[18] | (nvram[19] << 8),
-				nvram[20], nvram[25],
-				nvram[21] | (nvram[22] << 8),
-				nvram[23] | (nvram[24] << 8) );
-	PRINT_PROC( "HD type 49 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
-				nvram[39] | (nvram[40] << 8),
-				nvram[41], nvram[46],
-				nvram[42] | (nvram[43] << 8),
-				nvram[44] | (nvram[45] << 8) );
 
 	PRINT_PROC( "DOS base memory: %d kB\n", nvram[7] | (nvram[8] << 8) );
 	PRINT_PROC( "Extended memory: %d kB (configured), %d kB (tested)\n",



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

