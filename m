Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWBMUNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWBMUNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWBMUNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:13:55 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:63148
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964851AbWBMUNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:13:54 -0500
Subject: [PATCH] tty reference count fix
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "jesper.juhl@gmail.com" <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 14:13:30 -0600
Message-Id: <1139861610.3573.24.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix hole where tty structure can be released when reference
count is non zero. Existing code can sleep without tty_sem
protection between deciding to release the tty structure
(setting local variables tty_closing and otty_closing)
and setting TTY_CLOSING to prevent further opens.
An open can occur during this interval causing release_dev()
to free the tty structure while it is still referenced.

This should fix bugzilla.kernel.org
[Bug 6041] New: Unable to handle kernel paging request

In Bug 6041, tty_open() oopes on accessing the tty structure
it has successfully claimed. Bug was on SMP machine
with the same tty being opened and closed by
multiple processes, and DEBUG_PAGEALLOC enabled.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesper Juhl <jesper.juhl@gmail.com>

--- linux/drivers/char/tty_io.c	2006-02-10 15:54:00.000000000 -0600
+++ b/drivers/char/tty_io.c	2006-02-13 13:14:33.000000000 -0600
@@ -1841,7 +1841,6 @@ static void release_dev(struct file * fi
 		tty_closing = tty->count <= 1;
 		o_tty_closing = o_tty &&
 			(o_tty->count <= (pty_master ? 1 : 0));
-		up(&tty_sem);
 		do_sleep = 0;
 
 		if (tty_closing) {
@@ -1869,6 +1868,7 @@ static void release_dev(struct file * fi
 
 		printk(KERN_WARNING "release_dev: %s: read/write wait queue "
 				    "active!\n", tty_name(tty, buf));
+		up(&tty_sem);
 		schedule();
 	}	
 
@@ -1877,8 +1877,6 @@ static void release_dev(struct file * fi
 	 * both sides, and we've completed the last operation that could 
 	 * block, so it's safe to proceed with closing.
 	 */
-	 
-	down(&tty_sem);
 	if (pty_master) {
 		if (--o_tty->count < 0) {
 			printk(KERN_WARNING "release_dev: bad pty slave count "
@@ -1892,7 +1890,6 @@ static void release_dev(struct file * fi
 		       tty->count, tty_name(tty, buf));
 		tty->count = 0;
 	}
-	up(&tty_sem);
 	
 	/*
 	 * We've decremented tty->count, so we need to remove this file
@@ -1937,6 +1934,8 @@ static void release_dev(struct file * fi
 		read_unlock(&tasklist_lock);
 	}
 
+	up(&tty_sem);
+
 	/* check whether both sides are closing ... */
 	if (!tty_closing || (o_tty && !o_tty_closing))
 		return;


