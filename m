Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284937AbRLKJGc>; Tue, 11 Dec 2001 04:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284935AbRLKJGX>; Tue, 11 Dec 2001 04:06:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:21511 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284937AbRLKJGP>;
	Tue, 11 Dec 2001 04:06:15 -0500
Subject: [PATCH] Re: console close race fix resend
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: gordo@pincoya.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <3C15A79A.98EC0ADB@zip.com.au>
In-Reply-To: <20011210191630.A13679@furble>,
	<1008035512.4287.1.camel@phantasy>  <20011210191630.A13679@furble>
	<1008050718.4287.11.camel@phantasy>  <3C15A79A.98EC0ADB@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.10.08.57 (Preview Release)
Date: 11 Dec 2001 04:05:30 -0500
Message-Id: <1008061551.815.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I talked to Andrew off-list and we agree his fix is more correct. 
It should be applied.  I tested it (I have a consistent method of
reproducing the race under preempt-kernel) and it works.

I rediffed it against pre8 because I had trouble applying his, oddly. 
Ignore previous patch.  Marcelo, please apply.  Seriously, this time.

	Robert Love

--- linux-2.4.17-pre8/drivers/char/console.c	Mon Dec 10 20:48:50 2001
+++ linux/drivers/char/console.c	Tue Dec 11 02:52:44 2001
@@ -100,6 +100,7 @@
 #include <linux/tqueue.h>
 #include <linux/bootmem.h>
 #include <linux/pm.h>
+#include <linux/smp_lock.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -2348,17 +2349,25 @@
 	set_leds();
 }
 
+/*
+ * we can race here against con_close, so we grab the bkl
+ * and check the pointer before calling set_cursor
+ */
 static void con_flush_chars(struct tty_struct *tty)
 {
-	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
+	struct vt_struct *vt;
 
 	if (in_interrupt())	/* from flush_to_ldisc */
 		return;
 
 	pm_access(pm_con);
+	lock_kernel();
 	acquire_console_sem();
-	set_cursor(vt->vc_num);
+	vt = (struct vt_struct *)tty->driver_data;
+	if (vt)
+		set_cursor(vt->vc_num);
 	release_console_sem();
+	unlock_kernel();
 }
 
 /*

