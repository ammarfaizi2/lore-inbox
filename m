Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290674AbSAYXQR>; Fri, 25 Jan 2002 18:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290826AbSAYXQI>; Fri, 25 Jan 2002 18:16:08 -0500
Received: from zero.tech9.net ([209.61.188.187]:16651 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290674AbSAYXQC>;
	Fri, 25 Jan 2002 18:16:02 -0500
Subject: [PATCH] 2.5: console close race fix
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 18:21:09 -0500
Message-Id: <1012000869.3501.97.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

There is a race between con_flush_chars and con_close.  I first
discovered it with the preemptive kernel patch, but it is a general SMP
race.  The idea for the fix is originally by Andrew Morton.

This fix is in 2.4.  Please, apply.

	Robert Love

diff -urN linux-2.5.3-pre5/drivers/char/console.c linux/drivers/char/console.c
--- linux-2.5.3-pre5/drivers/char/console.c	Thu Jan 24 17:02:57 2002
+++ linux/drivers/char/console.c	Fri Jan 25 18:12:36 2002
@@ -2349,14 +2349,18 @@
 
 static void con_flush_chars(struct tty_struct *tty)
 {
-	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
+	struct vt_struct *vt;
 
 	if (in_interrupt())	/* from flush_to_ldisc */
 		return;
 
 	pm_access(pm_con);
+	
+	/* if we race with con_close(), vt may be null */
 	acquire_console_sem();
-	set_cursor(vt->vc_num);
+	vt = (struct vt_struct *)tty->driver_data;
+	if (vt)
+		set_cursor(vt->vc_num);
 	release_console_sem();
 }
 

 

