Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbRCFRBl>; Tue, 6 Mar 2001 12:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRCFRBZ>; Tue, 6 Mar 2001 12:01:25 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:17191 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131021AbRCFRAT>; Tue, 6 Mar 2001 12:00:19 -0500
Date: Tue, 6 Mar 2001 17:00:11 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.3-pre2: fix lp_read
Message-ID: <20010306170011.O4835@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should make printer status readback a little less broken
than before.

2001-06-03  Tim Waugh  <twaugh@redhat.com>

	* drivers/char/lp.c (lp_read): The loop is broken.  Remove it,
	and restore 2.2.x behaviour.

--- linux/drivers/char/lp.c.readback	Tue Mar  6 16:47:08 2001
+++ linux/drivers/char/lp.c	Tue Mar  6 16:47:31 2001
@@ -344,26 +344,7 @@
 		return -EINTR;
 
 	parport_claim_or_block (lp_table[minor].dev);
-
-	for (;;) {
-		retval = parport_read (port, kbuf, count);
-
-		if (retval)
-			break;
-
-		if (file->f_flags & O_NONBLOCK)
-			break;
-
-		/* Wait for an interrupt. */
-		interruptible_sleep_on_timeout (&lp_table[minor].waitq,
-						LP_TIMEOUT_POLLED);
-
-		if (signal_pending (current)) {
-			retval = -EINTR;
-			break;
-		}
-	}
-
+	retval = parport_read (port, kbuf, count);
 	parport_release (lp_table[minor].dev);
 
 	if (retval > 0 && copy_to_user (buf, kbuf, retval))
