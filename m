Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBNKNw>; Wed, 14 Feb 2001 05:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129106AbRBNKNm>; Wed, 14 Feb 2001 05:13:42 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:24082 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129104AbRBNKNb>; Wed, 14 Feb 2001 05:13:31 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A8A56EF.2DA6AB1D@yahoo.com>
Date: Wed, 14 Feb 2001 04:59:11 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: alan@lxorguk.ukuu.org.uk, ag784@freenet.buffalo.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sbpcd oops on merged requests
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two fixes here - 1st is to make the new max_drives its own separate
module parameter since the driver uses the existing sbpcd module
parameter internally for more than just module parameters <sigh>.

2nd is more important - if you read more than 4 blocks from the 
device, you will get a random crash - meaning you could mount a
cd and do "ls" and think it worked if that is all you did. Anything
more gets a rolling oops, EIP pointing off into outer space etc.

Tracked this down to the addition of the generic merge request
handling added to ll_rw_block in 2.3.41 (apparently nobody has
used this driver since then!!!) - it appears these conflict with
the molestation of the request list that sbpcd does from within.

Rather than attack sbpcd with a chainsaw, I went for the minimal
patch approach and simply disabled request merging.  Lets face it,
performance is not an issue if you are using a 2x speed CD with
seek times you measure with a wall calendar.

Patch is against 2.4.2-pre3.

Paul.


--- drivers/cdrom/sbpcd.c~	Wed Feb 14 04:02:04 2001
+++ drivers/cdrom/sbpcd.c	Wed Feb 14 04:09:55 2001
@@ -323,7 +323,7 @@
  *		Andrew J. Kroll <ag784@freenet.buffalo.edu> Wed Jul 26 04:24:10 EDT 2000
  *
  *  4.64 Fix module parameters - were being completely ignored.
- *	 Can also specify max_drives as 3rd setup int to get rid of
+ *	 Can also specify max_drives=N as a setup int to get rid of
  *	 "ghost" drives on crap hardware (aren't they all?)   Paul Gortmaker
  *
  *  TODO
@@ -339,6 +339,15 @@
  *
  */
 
+/*
+ * Trying to merge requests breaks this driver horribly (as in it goes
+ * boom and apparently has done so since 2.3.41).  As it is a legacy 
+ * driver for a horribly slow double speed CD on a hideous interface 
+ * designed for polled operation, I won't loose any sleep in simply 
+ * disallowing merging.				Paul G.  02/2001
+ */
+#define DONT_MERGE_REQUESTS
+
 #ifndef SBPCD_ISSUE
 #define SBPCD_ISSUE 1
 #endif SBPCD_ISSUE
@@ -476,7 +485,8 @@
 #else
 static int sbpcd[] = {CDROM_PORT, SBPRO}; /* probe with user's setup only */
 #endif
-MODULE_PARM(sbpcd, "3i");
+MODULE_PARM(sbpcd, "2i");
+MODULE_PARM(max_drives, "i");
 
 #define NUM_PROBE  (sizeof(sbpcd) / sizeof(int))
 
@@ -5566,7 +5576,6 @@
 #else
 	sbpcd_ioaddr = sbpcd[0];
 	sbpro_type = sbpcd[1];
-	max_drives = sbpcd[2];
 #endif
 	
 	CDo_command=sbpcd_ioaddr;
@@ -5661,6 +5670,21 @@
 	msg(DBG_SEQ,"found SoundScape interface at %04X.\n", sbpcd_ioaddr);
 	return (0);
 }
+
+#ifdef DONT_MERGE_REQUESTS
+static int dont_merge_requests_fn(request_queue_t *q, struct request *req,
+                                struct request *next, int max_segments)
+{
+	return 0;
+}
+
+static int dont_bh_merge_fn(request_queue_t *q, struct request *req,
+                            struct buffer_head *bh, int max_segments)
+{
+	return 0;
+}
+#endif
+
 /*==========================================================================*/
 /*
  *  Test for presence of drive and initialize it.
@@ -5828,6 +5852,11 @@
 #endif MODULE
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+#ifdef DONT_MERGE_REQUESTS
+	(BLK_DEFAULT_QUEUE(MAJOR_NR))->back_merge_fn = dont_bh_merge_fn;
+	(BLK_DEFAULT_QUEUE(MAJOR_NR))->front_merge_fn = dont_bh_merge_fn;
+	(BLK_DEFAULT_QUEUE(MAJOR_NR))->merge_requests_fn = dont_merge_requests_fn;
+#endif
 	blk_queue_headactive(BLK_DEFAULT_QUEUE(MAJOR_NR), 0);
 	read_ahead[MAJOR_NR] = buffers * (CD_FRAMESIZE / 512);
 	





_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

