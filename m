Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbRAaPcb>; Wed, 31 Jan 2001 10:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAaPcX>; Wed, 31 Jan 2001 10:32:23 -0500
Received: from smtp6.mail.yahoo.com ([128.11.69.103]:42502 "HELO
	smtp6.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129757AbRAaPcS>; Wed, 31 Jan 2001 10:32:18 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A782E16.39B5F09C@yahoo.com>
Date: Wed, 31 Jan 2001 10:24:06 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
CC: ag784@freenet.buffalo.edu
Subject: [PATCH] sbpcd ignoring module options
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The old SB Pro CD-ROM driver currently ignores any and all options
passed to it while used as a module (rendering it useless as it only
autoprobes 1 address...)  The driver could probably use a cleanup,
as it has sbpcd_setup called for both modular and in kernel (rather
than just in kernel only) and it maintains a lot of state in global
variables making it hard to maintain. However it is a legacy driver
and probably not worth the effort, besides it is 2.4.x now, etc etc.

Anyway this minimal patch fixes that, and also lets you specify
max_drives as the 3rd setup int (vs. being compiled in) to get
rid of those phantom detections on the really crap interface cards.

Paul.

--- drivers/cdrom/sbpcd.c~	Mon Nov 20 04:16:39 2000
+++ drivers/cdrom/sbpcd.c	Wed Jan 31 10:19:48 2001
@@ -322,6 +322,9 @@
  *		CD_AUDIO_COMPLETED state so workman (and other playes) can repeat play.
  *		Andrew J. Kroll <ag784@freenet.buffalo.edu> Wed Jul 26 04:24:10 EDT 2000
  *
+ *  4.64 Fix module parameters - were being completely ignored.
+ *	 Can also specify max_drives as 3rd setup int to get rid of
+ *	 "ghost" drives on crap hardware (aren't they all?)   Paul Gortmaker
  *
  *  TODO
  *     implement "read all subchannel data" (96 bytes per frame)
@@ -473,7 +476,7 @@
 #else
 static int sbpcd[] = {CDROM_PORT, SBPRO}; /* probe with user's setup only */
 #endif
-MODULE_PARM(sbpcd, "2i");
+MODULE_PARM(sbpcd, "3i");
 
 #define NUM_PROBE  (sizeof(sbpcd) / sizeof(int))
 
@@ -561,7 +564,6 @@
 
 static int sbpcd_ioaddr = CDROM_PORT;	/* default I/O base address */
 static int sbpro_type = SBPRO;
-static unsigned char setup_done;
 static unsigned char f_16bit;
 static unsigned char do_16bit;
 static int CDo_command, CDo_reset;
@@ -578,15 +580,19 @@
 static unsigned char msgnum;
 static char msgbuf[80];
 
-static const char *str_sb = "SoundBlaster";
+static int max_drives = MAX_DRIVES;
+#ifndef MODULE
+static unsigned char setup_done;
 static const char *str_sb_l = "soundblaster";
-static const char *str_lm = "LaserMate";
-static const char *str_sp = "SPEA";
 static const char *str_sp_l = "spea";
-static const char *str_ss = "SoundScape";
 static const char *str_ss_l = "soundscape";
-static const char *str_t16 = "Teac16bit";
 static const char *str_t16_l = "teac16bit";
+static const char *str_ss = "SoundScape";
+#endif
+static const char *str_sb = "SoundBlaster";
+static const char *str_lm = "LaserMate";
+static const char *str_sp = "SPEA";
+static const char *str_t16 = "Teac16bit";
 static const char *type;
 
 #if !(SBPCD_ISSUE-1)
@@ -3739,7 +3745,7 @@
 	
 	msg(DBG_INI,"check_drives entered.\n");
 	ndrives=0;
-	for (j=0;j<MAX_DRIVES;j++)
+	for (j=0;j<max_drives;j++)
 	{
 		D_S[ndrives].drv_id=j;
 		if (sbpro_type==1) D_S[ndrives].drv_sel=(j&0x01)<<1|(j&0x02)>>1;
@@ -5540,6 +5546,7 @@
 int sbpcd_setup(char *s)
 #endif
 {
+#ifndef MODULE
 	int p[4];
 	(void)get_options(s, ARRAY_SIZE(p), p);
 	setup_done++;
@@ -5555,6 +5562,12 @@
 	else if (!strcmp(s,str_t16)) sbpro_type=3;
 	else if (!strcmp(s,str_t16_l)) sbpro_type=3;
 	if (p[0]>0) sbpcd_ioaddr=p[1];
+	if (p[0]>2) max_drives=p[3];
+#else
+	sbpcd_ioaddr = sbpcd[0];
+	sbpro_type = sbpcd[1];
+	max_drives = sbpcd[2];
+#endif
 	
 	CDo_command=sbpcd_ioaddr;
 	CDi_info=sbpcd_ioaddr;



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
