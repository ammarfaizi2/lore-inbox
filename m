Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265887AbRGJHMW>; Tue, 10 Jul 2001 03:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbRGJHMM>; Tue, 10 Jul 2001 03:12:12 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:51396 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265887AbRGJHL5>;
	Tue, 10 Jul 2001 03:11:57 -0400
Message-ID: <3B4AAC7D.A86AF1F3@sun.com>
Date: Tue, 10 Jul 2001 00:19:25 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: groudier@club-internet.fr, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  sym53c8xx timer rework
Content-Type: multipart/mixed;
 boundary="------------41FFF502043547D8ABB9A7BC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------41FFF502043547D8ABB9A7BC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gerard (and all)

Attached is a small patch to re-work the timer in the sym53c8xx driver.  I
submitted this patch against 2.4.5, but don't see it in 2.4.6, so I am
re-submitting against 2.4.6.

Please let me know if there are any problems with this patch.

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------41FFF502043547D8ABB9A7BC
Content-Type: text/plain; charset=us-ascii;
 name="sym_timer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym_timer.diff"

diff -ruN dist-2.4.6/drivers/scsi/sym53c8xx.c cobalt-2.4.6/drivers/scsi/sym53c8xx.c
--- dist-2.4.6/drivers/scsi/sym53c8xx.c	Tue Jun 12 11:06:54 2001
+++ cobalt-2.4.6/drivers/scsi/sym53c8xx.c	Mon Jul  9 11:04:14 2001
@@ -2249,7 +2265,6 @@
 	**----------------------------------------------------------------
 	*/
 	struct usrcmd	user;		/* Command from user		*/
-	volatile u_char	release_stage;	/* Synchronisation stage on release  */
 
 	/*----------------------------------------------------------------
 	**	Fields that are used (primarily) for integrity check
@@ -5868,7 +5883,12 @@
 	**	start the timeout daemon
 	*/
 	np->lasttime=0;
-	ncr_timeout (np);
+#ifdef SCSI_NCR_PCIQ_BROKEN_INTR
+	np->timer.expires = ktime_get((HZ+9)/10);
+#else
+	np->timer.expires = ktime_get(SCSI_NCR_TIMER_INTERVAL);
+#endif
+	add_timer(&np->timer);
 
 	/*
 	**  use SIMPLE TAG messages by default
@@ -7227,23 +7247,19 @@
 **==========================================================
 */
 
-#ifdef MODULE
 static int ncr_detach(ncb_p np)
 {
-	int i;
+	unsigned long flags;
 
 	printk("%s: detaching ...\n", ncr_name(np));
 
 /*
-**	Stop the ncr_timeout process
-**	Set release_stage to 1 and wait that ncr_timeout() set it to 2.
+**	Stop the ncr_timeout process - lock it to ensure no timer is running
+**	on a different CPU, or anything
 */
-	np->release_stage = 1;
-	for (i = 50 ; i && np->release_stage != 2 ; i--) MDELAY (100);
-	if (np->release_stage != 2)
-		printk("%s: the timer seems to be already stopped\n",
-			ncr_name(np));
-	else np->release_stage = 2;
+	NCR_LOCK_NCB(np, flags);
+	del_timer(&np->timer);
+	NCR_UNLOCK_NCB(np, flags);
 
 /*
 **	Reset NCR chip.
@@ -7273,7 +7289,6 @@
 
 	return 1;
 }
-#endif
 
 /*==========================================================
 **
@@ -8600,23 +8615,11 @@
 {
 	u_long	thistime = ktime_get(0);
 
-	/*
-	**	If release process in progress, let's go
-	**	Set the release stage from 1 to 2 to synchronize
-	**	with the release process.
-	*/
-
-	if (np->release_stage) {
-		if (np->release_stage == 1) np->release_stage = 2;
-		return;
-	}
-
 #ifdef SCSI_NCR_PCIQ_BROKEN_INTR
-	np->timer.expires = ktime_get((HZ+9)/10);
+	mod_timer(&np->timer, ktime_get((HZ+9)/10));
 #else
-	np->timer.expires = ktime_get(SCSI_NCR_TIMER_INTERVAL);
+	mod_timer(&np->timer, ktime_get(SCSI_NCR_TIMER_INTERVAL));
 #endif
-	add_timer(&np->timer);
 
 	/*
 	**	If we are resetting the ncr, wait for settle_time before 

--------------41FFF502043547D8ABB9A7BC--

