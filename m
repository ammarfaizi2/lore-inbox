Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262167AbREQBoF>; Wed, 16 May 2001 21:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbREQBnp>; Wed, 16 May 2001 21:43:45 -0400
Received: from patan.Sun.COM ([192.18.98.43]:44537 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S262167AbREQBnm>;
	Wed, 16 May 2001 21:43:42 -0400
Message-ID: <3B032D91.CE51AEB5@sun.com>
Date: Wed, 16 May 2001 18:46:57 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: groudier@club-internet.fr, linux-kernel@vger.kernel.org
CC: alan@redhat.com
Subject: PATCH: sym53c8xxx.c timer handling
Content-Type: multipart/mixed;
 boundary="------------5BA0F47ED3B7D60584115756"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5BA0F47ED3B7D60584115756
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gerard, LKML

The attached patch tweaks the sym53c8xx timeout timer handling a bit.

Is it correct?

It works with interrupts off (we need a reboot notifier to iterate the
hosts list, with IRQs off) and doesn't delay() 5 seconds in worst case.

Is there any reason this patch won't work?  It seems OK to me.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------5BA0F47ED3B7D60584115756
Content-Type: text/plain; charset=us-ascii;
 name="sym53c8xx.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym53c8xx.diff"

--- /home/users/admin/C26/III/linux-2.2/drivers/scsi/sym53c8xx.c	Tue May 15 19:14:48 2001
+++ /usr/src/linux/drivers/scsi/sym53c8xx.c	Wed May 16 22:52:12 2001
@@ -2265,7 +2265,6 @@
 	**----------------------------------------------------------------
 	*/
 	struct usrcmd	user;		/* Command from user		*/
-	volatile u_char	release_stage;	/* Synchronisation stage on release  */
 
 	/*----------------------------------------------------------------
 	**	Fields that are used (primarily) for integrity check
@@ -5884,7 +5883,12 @@
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
@@ -7244,20 +7248,17 @@
 
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
@@ -8613,23 +8614,11 @@
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

--------------5BA0F47ED3B7D60584115756--

