Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279705AbRJ3BES>; Mon, 29 Oct 2001 20:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279706AbRJ3BEJ>; Mon, 29 Oct 2001 20:04:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:61195 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279705AbRJ3BD7>;
	Mon, 29 Oct 2001 20:03:59 -0500
Subject: [PATCH] tty race on con_close and con_flush_chars
From: Robert Love <rml@tech9.net>
To: linus@transmeta.com, laughing@shared-source.org
Cc: linux-kernel@vger.kernel.org, tytso@thunk.org, andrewm@uow.edu.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 29 Oct 2001 20:04:27 -0500
Message-Id: <1004403868.809.147.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race in the console code between con_close and
con_flush_chars.  n_tty_receive_buf writes to the tty queue and then
writes it out via con_flush_chars.  The race arises in between the above
two operations; the console can close and thus zero tty->drive_data. 
When con_flush_chars runs, it will dereference a null pointer.

The following fix, by Andrew Morton, merely checks if the tty still
exists because continuing.  I am submitting the patch because the race
is uncovered often with a preemptive kernel.  The fix is in the preempt
tree, but it should be pushed to mainline since it should affect SMP
too.

Linus and Alan, please apply.

diff -urN linux-2.4.13-ac5/drivers/char/console.c linux/drivers/char/console.c
--- linux-2.4.13-ac5/drivers/char/console.c	Mon Oct 29 17:27:19 2001
+++ linux/drivers/char/console.c	Mon Oct 29 17:28:24 2001
@@ -2387,9 +2387,15 @@
 		return;
 
 	pm_access(pm_con);
-	acquire_console_sem();
-	set_cursor(vt->vc_num);
-	release_console_sem();
+	if (vt) {
+		/*
+		 * If we raced with con_close(), `vt' may be null.
+		 * Hence this bandaid.   - akpm
+		 */
+		acquire_console_sem();
+		set_cursor(vt->vc_num);
+		release_console_sem();
+	}
 }
 
 /*

	Robert Love

